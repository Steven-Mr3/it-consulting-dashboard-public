class ReportsController < ApplicationController
  def index
    # Date range filter
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : 30.days.ago.to_date
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today

    # Filter tickets by date range
    @tickets = Ticket.where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)

    # Filter by client
    @tickets = @tickets.where(client_id: params[:client_id]) if params[:client_id].present?

    # Metrics
    @total_tickets = @tickets.count
    @resolved_tickets = @tickets.where(status: [:resolved, :closed]).count
    @open_tickets = @tickets.open.count
    @average_resolution_time = calculate_avg_resolution_time(@tickets)

    # SLA Compliance
    resolved_with_sla = @tickets.where(status: [:resolved, :closed]).where.not(resolved_at: nil)
    within_sla = resolved_with_sla.select { |t| t.within_sla? }.count
    @sla_compliance = resolved_with_sla.count > 0 ? (within_sla.to_f / resolved_with_sla.count * 100).round(1) : 100.0

    # Charts data
    @tickets_by_status = @tickets.group(:status).count
    @tickets_by_priority = @tickets.group(:priority).count
    @tickets_by_category = @tickets.group(:category).count
    @tickets_over_time = @tickets.group_by { |t| t.created_at.to_date }.transform_values(&:count).sort.to_h

    # For filter dropdown
    @clients = Client.all
  end

  def export_pdf
    # This would require WickedPDF configuration
    # Placeholder for PDF export functionality
    redirect_to reports_path, alert: 'PDF export coming soon!'
  end

  private

  def calculate_avg_resolution_time(tickets)
    resolved = tickets.where(status: [:resolved, :closed]).where.not(resolved_at: nil)
    return 0 if resolved.count.zero?

    total_time = resolved.map { |t| t.response_time_minutes }.compact.sum
    (total_time.to_f / resolved.count / 60).round(1) # Return in hours
  end
end

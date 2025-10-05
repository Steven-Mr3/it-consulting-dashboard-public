class DashboardController < ApplicationController
  def index
    # KPIs
    @total_tickets = Ticket.count
    @open_tickets = Ticket.open.count
    @closed_tickets = Ticket.where(status: [:resolved, :closed]).count
    @urgent_tickets = Ticket.urgent.open.count

    # SLA Compliance
    resolved_tickets = Ticket.where(status: [:resolved, :closed]).where.not(resolved_at: nil)
    within_sla_count = resolved_tickets.select { |t| t.within_sla? }.count
    @sla_compliance = resolved_tickets.count > 0 ? (within_sla_count.to_f / resolved_tickets.count * 100).round(1) : 100.0

    # MTTR (Mean Time To Resolution) in hours
    mttr_minutes = resolved_tickets.map { |t| t.response_time_minutes }.compact.sum
    @mttr = resolved_tickets.count > 0 ? (mttr_minutes.to_f / resolved_tickets.count / 60).round(1) : 0

    # Uptime (simulated as percentage of non-critical tickets)
    critical_count = Ticket.where(priority: :critical, status: [:new, :in_progress]).count
    @uptime = @total_tickets > 0 ? (((@total_tickets - critical_count).to_f / @total_tickets) * 100).round(1) : 100.0

    # Chart data - Last 30 days
    @tickets_by_day = Ticket.where('created_at >= ?', 30.days.ago)
                            .group_by { |t| t.created_at.to_date }
                            .transform_values(&:count)
                            .sort.to_h

    @tickets_by_status = Ticket.group(:status).count
    @tickets_by_priority = Ticket.group(:priority).count
    @tickets_by_category = Ticket.group(:category).count

    # Recent activity
    @recent_tickets = Ticket.order(created_at: :desc).limit(10)
    @active_alerts = Alert.active.order(created_at: :desc).limit(5)

    # Trending data for last 30 days
    @resolution_trend = resolved_tickets.where('resolved_at >= ?', 30.days.ago)
                                       .group_by { |t| t.resolved_at.to_date }
                                       .transform_values(&:count)
                                       .sort.to_h
  end
end

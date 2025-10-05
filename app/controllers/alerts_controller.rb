class AlertsController < ApplicationController
  include Pagy::Backend
  before_action :set_alert, only: [:resolve]

  def index
    @alerts = Alert.includes(:ticket).all

    # Filter by severity
    @alerts = @alerts.by_severity(params[:severity]) if params[:severity].present?

    # Filter by resolved status
    if params[:resolved] == 'true'
      @alerts = @alerts.where(resolved: true)
    elsif params[:resolved] == 'false'
      @alerts = @alerts.active
    end

    @alerts = @alerts.order(created_at: :desc)

    @pagy, @alerts = pagy(@alerts, limit: 20)
  end

  def resolve
    if @alert.resolve!
      redirect_to alerts_path, notice: 'Alert was successfully resolved.'
    else
      redirect_to alerts_path, alert: 'Failed to resolve alert.'
    end
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end
end

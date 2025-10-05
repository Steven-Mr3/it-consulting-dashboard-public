module ApplicationHelper
  include Pagy::Frontend

  def sidebar_counters
    return {} unless user_signed_in?

    {
      tickets: Ticket.where(status: [ "open", "in_progress" ]).count,
      alerts: Alert.where(resolved: false).count,
      clients: Client.count
    }
  end
end

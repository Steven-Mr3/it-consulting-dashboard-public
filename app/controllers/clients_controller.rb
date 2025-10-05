class ClientsController < ApplicationController
  include Pagy::Backend
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @clients = pagy(Client.all.order(:name), limit: 20)
  end

  def show
    @tickets = @client.tickets.order(created_at: :desc).limit(10)
    @total_tickets = @client.tickets.count
    @open_tickets = @client.tickets.open.count
    @sla_compliance = @client.sla_compliance_rate
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully deleted.'
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :contact_email, :contact_phone, :sla_response_time, :contract_start, :contract_end)
  end
end

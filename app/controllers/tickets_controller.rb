class TicketsController < ApplicationController
  include Pagy::Backend
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.includes(:client, :assigned_to, :created_by).all

    # Filters
    @tickets = @tickets.where(status: params[:status]) if params[:status].present?
    @tickets = @tickets.where(priority: params[:priority]) if params[:priority].present?
    @tickets = @tickets.where(client_id: params[:client_id]) if params[:client_id].present?
    @tickets = @tickets.where(assigned_to_id: params[:assigned_to_id]) if params[:assigned_to_id].present?

    # Search
    if params[:query].present?
      @tickets = @tickets.where("title LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    # Sort
    @tickets = @tickets.order(created_at: :desc)

    # Pagination
    @pagy, @tickets = pagy(@tickets, limit: 15)

    # For filter dropdowns
    @clients = Client.all
    @consultants = User.consultants
  end

  def show
    @comments = @ticket.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @ticket = Ticket.new
    @clients = Client.all
    @consultants = User.consultants
  end

  def edit
    @clients = Client.all
    @consultants = User.consultants
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.created_by = current_user

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      @clients = Client.all
      @consultants = User.consultants
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      @clients = Client.all
      @consultants = User.consultants
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully deleted.'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :priority, :category, :client_id, :assigned_to_id)
  end
end

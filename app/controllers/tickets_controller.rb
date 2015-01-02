class TicketsController < ApplicationController

  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def show

  end

  def edit

  end

  def update
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: 'Ticket has been updated.'
    else
      flash[:alert] = 'Ticket has not been updated.'
      render 'edit'
    end
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    if @ticket.save
      redirect_to [@project, @ticket], notice: 'Ticket has been created.'
    else
      flash[:alert] = 'Ticket has not been created.'
      render 'new'
    end
  end

  private

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end

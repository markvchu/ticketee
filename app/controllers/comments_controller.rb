class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :set_ticket
  before_action :set_project

  def create

    sanitize_parameters!
    @comment = CommentWithNotifications.create(@ticket.comments,
                                               current_user,
                                               comment_params)
    
    if @comment.save
      flash[:notice] = 'Comment has been created.'
      redirect_to [@project, @ticket]
    else
      @states = State.all
      @comment = @comment.comment
      flash[:alert] = 'Comment has not been created.'
      render template: 'tickets/show'
    end
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_project
    @project = @ticket.project
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id, :tag_names)
  end

  def sanitize_parameters!
    if cannot?(:'change states', @ticket.project)
      params[:comment].delete(:state_id)
    end
    if cannot?(:tag, @ticket.project)
      params[:comment].delete(:tag_names)
    end
  end
end

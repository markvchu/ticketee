class ProjectsController < ApplicationController

  before_action :authorize_admin!, except: [:index, :show]
  before_action :require_signin!, only: [:show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def update

    if @project.update(project_params)
      redirect_to @project, notice: 'Project has been updated.'
    else
      flash[:alert] = 'Project has not been updated.'
      render 'edit'
    end

  end

  def destroy
    @project.destroy

    redirect_to projects_path, notice: 'Project has been destroyed.'
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      # flash[:notice] = 'Project has been created.'
      redirect_to @project, notice: 'Project has been created.'
    else
      flash[:alert] = 'Project has not been created.'
      render 'new'
    end

  end

  def show
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = if current_user.admin?
                 Project.find(params[:id])
               else
                 Project.viewable_by(current_user).find(params[:id])
               end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The project you were looking' +
        ' for could not be found.'
    redirect_to projects_path
  end

end

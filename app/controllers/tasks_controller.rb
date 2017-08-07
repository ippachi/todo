class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_user

  def index
    @tasks = @user.tasks.paginate(page: params[:page], per_page: 10)
  end

  def new
    @task = @user.tasks.build
  end 

  def update
    @task = tasks_params.each do |id, task_param|
      @task = Task.find(id)
      @task.update_attributes(task_param)
      @task
    end
    flash[:success] = "Update your task"
    redirect_to user_tasks_path
  end

  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Upload your task!"
      redirect_to user_tasks_path
    else
      render 'new'
    end
  end

  def destroy
    @task = @user.tasks.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:content, :dead_limit, :done)
    end

    def tasks_params
      params.permit(tasks: [:done])[:tasks]
    end

    def set_user
      @user = current_user
    end
end

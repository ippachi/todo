class TasksController < ApplicationController
  before_action :authenticate_user!, only:[:index, :new, :create, :destroy]
  before_action :correct_user, only:[:new, :create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
  end 

  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Upload your task!"
      redirect_to user_tasks_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:content, :dead_limit, :done)
    end
end

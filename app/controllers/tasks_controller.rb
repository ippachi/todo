class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_user

  def index
    @unfinished_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.done = 0").order("dead_limit")
    @finished_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.done = 1").order("dead_limit")
    @work_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 1").order("tasks.done, dead_limit")
    @study_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 2").order("tasks.done, dead_limit")
    @life_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 3").order("tasks.done, dead_limit")
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
    params[:task][:category] = params[:task][:category].to_i
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

  def search
    @unfinished_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.done = 0 and content like ?", "%"+params[:search]+"%").order("dead_limit")
    @finished_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.done = 1 and content like ?", "%"+params[:search]+"%").order("dead_limit")
    @work_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 1 and content like ?", "%"+params[:search]+"%").order("dead_limit")
    @study_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 2 and content like ?", "%"+params[:search]+"%").order("dead_limit")
    @life_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 3 and content like ?", "%"+params[:search]+"%").order("dead_limit")
    render "index"
  end

  private
    def task_params
      params.require(:task).permit(:content, :dead_limit, :done, :category)
    end

    def tasks_params
      params.permit(tasks: [:done])[:tasks]
    end

    def set_user
      @user = current_user
    end
end

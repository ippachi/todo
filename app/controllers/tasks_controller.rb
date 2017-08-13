class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_task, only:[:edit, :update, :destroy]
  before_action :set_tasks, only:[:index, :search]

  def index
  end

  def new
    @task = @user.tasks.build
  end 

  def edit
  end

  def update
    params[:task][:category] = params[:task][:category].to_i
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Update your task!"
      redirect_to tasks_url
    else
      render 'new'
    end
  end

  def create
    params[:task][:category] = params[:task][:category].to_i
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Upload your task!"
      redirect_to tasks_url
    else
      render 'new'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url
  end

  def update_state
    @task = tasks_params.each do |id, task_param|
      @task = Task.find(id)
      @task.update_attributes(task_param)
      @task
    end
    flash[:success] = "Update your task"
    redirect_to tasks_url
  end

  def search
    @unfinished_tasks = @unfinished_tasks.where("content like ?", "%"+params[:search]+"%")
    @finished_tasks = @finished_tasks.where("content like ?", "%"+params[:search]+"%")
    @work_tasks = @work_tasks.where("content like ?", "%"+params[:search]+"%")
    @study_tasks = @study_tasks.where("content like ?", "%"+params[:search]+"%")
    @life_tasks = @life_tasks.where("content like ?", "%"+params[:search]+"%")
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

    def set_task
      @task = @user.tasks.find_by(id: params[:id])
      if @task.nil?
        flash[:error] = "You don't have this task id"
        redirect_to tasks_url
      end
    end
    
    def set_tasks
      @unfinished_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.done = 0").order("dead_limit")
      @finished_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.done = 1").order("dead_limit")
      @work_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 1").order("tasks.done, dead_limit")
      @study_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 2").order("tasks.done, dead_limit")
      @life_tasks = @user.tasks.paginate(page: params[:page], per_page: 10).where("tasks.category = 3").order("tasks.done, dead_limit")
    end
end

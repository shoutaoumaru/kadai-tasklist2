class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
 
  def show
  end
  
  def new 
   @task = Task.new
  end
  
  def create
    @task = current_user.tasks.new(task_params) # 変更箇所
    
    if @task.save
      flash[:success] = "タスクが投稿されました"
      redirect_to tasks_url # 変更箇所
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash[:danger] = "タスクが投稿されません"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクが編集されました"
      redirect_to @task
    else
      flash[:danger] = "タスクが編集されませんでした"
      render :new
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクが削除されました"
    redirect_to root_url
  end
  
  private
  
  def set_task
     @task = current_user.tasks.find(params[:id])  #Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
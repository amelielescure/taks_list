class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :postpone]

  def index
    @tags = Tag.all
    if params[:tags].present?
      @tasks = Task.filter_by_tag(params[:tags])
    else
      @tasks = Task.postpone_date_current
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Tâche bien crée.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Tâche bien modifiée.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
  end

  def postpone
    @task.update(task_params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :postpone_date, :task_tags)
    end
end

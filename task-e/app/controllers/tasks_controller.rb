class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  #  :correct_task_owner, only: [:create, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html {redirect_to @task.user, notice: 'Task was successfully created.'}
      else
        format.html {render :new}
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to @task.user, notice: 'Task was successfully updated.'}
      else
        format.html {render :edit}
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html {redirect_to current_user, notice: 'Task was successfully deleted.'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:task_name, :due_date, :weight, :progress, :priority, :required_time, :user_id, :tag, :algorithm)
    end

    def correct_task_owner
      @user = @task.user
      redirect_to(root_url) unless @user == current_user
    end
end

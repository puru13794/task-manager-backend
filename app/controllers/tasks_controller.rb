class TasksController < ApplicationController
	before_action :authenticate_user!
	rescue_from ActionController::ParameterMissing, with: :render_missing_params_error

	def index
		# byebug
		@tasks = current_user.tasks
		render json: {code: 200, data: @tasks}, status: :ok
	end


	def create
		@task = current_user.tasks.new(task_params)
		if task_params[:status] == 'todo' && too_many_todo_tasks?
		    render json: { code: 402, error: 'Complete existing "TO DO" tasks to create new tasks' }, status: :unprocessable_entity
		    return
		elsif @task.save
			render json: {code: 200, data: @task}, status: :ok
		else
			render json: {code: 402, error: @task.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		byebug
		@task = current_user.tasks.find(params[:id])
		return render json: {code: 422, errors: ["No task exists with id: #{params[:id]} for this user"]}, status: :unprocessable_entity unless @task 
		if @task.update(task_params)
			render json: { code: 200, data: @task }, status: :ok
  		else
    		render json: { code: 422, errors: @task.errors.full_messages }, status: :unprocessable_entity
  		end
	end


	def destroy
		@task = current_user.tasks.find(params[:id])
		return render json: {code: 422, errors: ["No task exists with id: #{params[:id]} for this user to destroy"]}, status: :unprocessable_entity unless @task 
		if @task.destroy
		  render json: { code: 200, message: 'Task deleted successfully' }, status: :ok
		else
		  render json: { code: 500, error: 'Unable to delete task' }, status: :internal_server_error
		end
	end


	private

	def task_params
      params.require(:task).permit(:title, :description, :status)
    end

    def too_many_todo_tasks?
	  total_tasks_count = current_user.tasks.count
	  todo_tasks_count = current_user.tasks.where(status: Task.statuses[:todo]).count

	  return false if total_tasks_count.zero?
	  return false if (todo_tasks_count.to_f / total_tasks_count) < 0.5

	  true
	end

	def render_missing_params_error(exception)
    	render json: { code: 400, error: "Bad Request", exception: exception.message }, status: :bad_request
	end
end
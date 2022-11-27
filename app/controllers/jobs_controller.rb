class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]
  before_action :set_todos, only: %i[ edit update new]
  before_action :set_jobs, only: %i[ index]
  # GET /jobs or /jobs.json
  def index
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to job_url(@job), notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def set_todos
      @todos= Todo.where('status =?', 0)
    end   

    def set_jobs
      @q = Job.ransack(params[:q].try(:merge, m: params[:combinator]))
      @jobs = @q.result.all.paginate(:page => params[:page], :per_page => 10).order(todo_id: :asc)
    end      

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:name, :status,:todo_id)
    end
end

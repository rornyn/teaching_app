class CoursesController < ApplicationController
  before_action :admin_not_allowed
  before_action :check_role, except: [:index, :show, :join_course]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :join_program]


  # GET /courses
  # GET /courses.json
  def index
    if current_user.teacher?
      @courses = current_user.courses
    else
      @courses = Course.approved.includes(:interested_courses).all
    end
  end

  def join_course
    @courses = get_filter_data(params[:filter])
    content = render_to_string(partial: 'table_data.html.erb') if request.format.json?
    respond_to do |format|
     format.html
     format.json { render json: {data: content}}
   end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = current_user.courses.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
       params.require(:course).permit(:title, :content, :start_dt, :end_dt, :student_length)
    end

    def check_role
      if current_user.student?
        flash[:error] = "You don't have access to perform this action."
        redirect_to root_path and return
      end
    end

    def admin_not_allowed
      if current_user.admin?
        redirect_to admin_courses_path and return
      end
    end

    def get_filter_data(filter)
      courses = Course.joins(:interested_courses).where("interested_courses.student_id = ? and interested_courses.status = #{InterestedCourse.statuses["approved"]} ", current_user.id)
      case filter
      when Course::Filter[:upcoming]
        courses.where("date(start_dt) > ? ", Time.now.to_date)
      when Course::Filter[:past]
        courses.where("date(end_dt) < ?", Time.now.to_date)
      when Course::Filter[:current]
        courses.where("date(start_dt) <= ? and date(end_dt) >= ? ", Time.now.to_date, Time.now.to_date)
      else
        courses
      end
    end
end

class Admin::CoursesController < ApplicationController
  before_action :set_course, except: [:index]

  def index
    @courses = Course.all
  end

  def approved
    @course.approved!
    flash[:notice] = "Course approved"
    redirect_to admin_courses_path
  end

  def show
    render "courses/show"
  end

  private

  def set_course
    @course = Course.find params[:id]
  end
end

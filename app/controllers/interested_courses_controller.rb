class InterestedCoursesController < ApplicationController
  before_action :set_course

  def index
    @interested_courses = @course.interested_courses
  end

  def create
    if current_user.current_month_courses.count < 3
      current_user.interested_courses.create({course_id: @course.id})
      flash[:notice] = "Request sent"
    else
      flash[:error] = "You can not join more than 3 course per month"
    end
    redirect_to courses_path
  end

  def update
    if current_user.teacher?
      interested_course = @course.interested_courses.where(id: params[:id])
      interested_course.approved!
      flash[:notice] = "Request approved"
    else
      flash[:error] = "Unauthorize access"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_course
    @course = Course.find params[:course_id]
  end
end

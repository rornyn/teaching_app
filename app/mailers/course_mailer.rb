class CourseMailer < ApplicationMailer

  def join_request_approved
    @course = Course.find params[:course_id]
    mail(to: params[:user_email], subject: "Request Approved!")
  end
end

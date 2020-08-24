module CoursesHelper

  def get_request_status(course)
    interested_course = course.interested_courses.where(student_id: current_user.id).first
    InterestedCourse::Status[interested_course.status.to_sym]
  end
end

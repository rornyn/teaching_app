json.extract! course, :id, :title, :content, :start_dt, :end_dt, :status, :teacher_id, :student_length, :created_at, :updated_at
json.url course_url(course, format: :json)

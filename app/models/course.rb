class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  validates_presence_of :title, :content, :start_dt, :end_dt, :student_length
end

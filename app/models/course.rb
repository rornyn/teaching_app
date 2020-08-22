class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  validates_presence_of :title, :content, :start_dt, :end_dt, :student_length

  Status = {pending: "Pending", approved: "Approved"}

  enum status: Status.keys

  after_initialize :set_default_status,  if: :new_record?

  def set_default_status
    self.status = Course.statuses[:pending]
  end
end

class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :interested_courses, dependent: :destroy
  has_many :interested_students, through: :interested_courses, source: :student
  has_many :comments,  dependent: :destroy

  validates_presence_of :title, :content, :start_dt, :end_dt, :student_length

  Status = {pending: "Pending", approved: "Approved"}
  Filter = {upcoming: "Upcoming course", past: "Ended Course", current: "Currently Running Course"}

  enum status: Status.keys

  after_initialize :set_default_status,  if: :new_record?

  delegate :name, to: :teacher, prefix: :teacher, allow_nil: true

  def set_default_status
    self.status = Course.statuses[:pending]
  end

  def join_by_student?(student_id)
    self.interested_students.ids.include?(student_id)
  end
end

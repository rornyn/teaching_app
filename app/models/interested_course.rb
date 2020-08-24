class InterestedCourse < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'

  Status = {pending: "Pending", approved: "Approved"}

  enum status: Status.keys

  after_initialize :set_default_status,  if: :new_record?

  validates_uniqueness_of :course_id, :scope => [ :student_id ]

  delegate :name, to: :student, prefix: :student, allow_nil: true

  private

  def set_default_status
    self.status = InterestedCourse.statuses[:pending]
  end
end

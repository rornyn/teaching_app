class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  CustomRole = {teacher: "Teacher", student: "Student"}
  AllRole = {admin: "Admin"}.merge(CustomRole)
  enum role: AllRole.keys

  #Association
  has_many :comments, dependent: :destroy
  ##Student
  has_many :interested_courses, foreign_key: 'student_id',  dependent: :destroy
  ##Teacher
  has_many :courses, foreign_key: 'teacher_id',  dependent: :destroy

  validates_presence_of :role

  def name
    self.first_name.to_s+ ' ' + self.last_name.to_s
  end

  def current_month_courses
    self.interested_courses.approved.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
  end

end

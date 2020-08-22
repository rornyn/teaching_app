class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  CustomRole = {teacher: "Teacher", student: "Student"}
  AllRole = {admin: "Admin"}.merge(CustomRole)
  enum role: AllRole.keys

  #Association
  ##Student
  has_many :interested_courses, foreign_key: 'student_id',  dependent: :destroy
  ##Teacher
  has_many :courses, foreign_key: 'teacher_id',  dependent: :destroy

  validates_presence_of :role

end

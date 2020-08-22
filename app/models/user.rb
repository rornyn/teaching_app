class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  CustomRole = {teacher: "Teacher", student: "Student"}
  AllRole = {admin: "Admin"}.merge(CustomRole)

  enum role: AllRole.keys

  validates_presence_of :role

end

class CreateInterestedCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :interested_courses do |t|
      t.integer :student_id
      t.references :course, foreign_key: true
      t.integer :status

      t.timestamps
    end
    add_foreign_key :interested_courses, :users, column: :student_id
  end
end

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :content
      t.datetime :start_dt
      t.datetime :end_dt
      t.integer :status,  default: 0
      t.integer :teacher_id, index: true
      t.integer :student_length

      t.timestamps
    end
    add_foreign_key :courses, :users, column: :teacher_id
  end
end

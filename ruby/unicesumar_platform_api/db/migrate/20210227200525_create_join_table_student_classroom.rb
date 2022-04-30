class CreateJoinTableStudentClassroom < ActiveRecord::Migration[6.1]
  def change
    create_join_table :students, :classrooms do |t|
      t.index [:student_id, :classroom_id]
      t.index [:classroom_id, :student_id]
    end
  end
end

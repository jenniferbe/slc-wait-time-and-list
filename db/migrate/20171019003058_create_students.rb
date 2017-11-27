class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :sid
      t.string :email
      t.boolean :transfer_student
      t.boolean :concurrency_student
      t.timestamps null: false
    end
  end
end

class AddDomesticToStudents < ActiveRecord::Migration
  def change
    add_column :students, :domestic_student, :boolean
  end
end

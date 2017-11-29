class AddConcurrentInstitutionToStudents < ActiveRecord::Migration
  def change
    add_column :students, :concurrent_institution, :string
  end
end

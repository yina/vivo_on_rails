class CreateFacultyMembers < ActiveRecord::Migration
  def change
    create_table :faculty_members do |t|
      t.text  :first_name
      t.text  :middle_name
      t.text  :last_name
      t.text  :name_prefix
      t.text  :name_suffix
      t.text  :fax
      t.text  :primary_email
      t.timestamps
    end
  end
end

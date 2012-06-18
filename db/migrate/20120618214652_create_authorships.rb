class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :faculty_member_id
      t.integer :academic_article_id
      t.timestamps
    end
  end
end

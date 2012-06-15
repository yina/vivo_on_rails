class CreatePeriodicals < ActiveRecord::Migration
  def change
    create_table :periodicals do |t|
      t.text :label

      t.timestamps
    end
  end
end

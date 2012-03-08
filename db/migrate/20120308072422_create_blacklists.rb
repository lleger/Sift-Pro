class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.string :word
      t.integer :university_id
      t.integer :user_id

      t.timestamps
    end
  end
end

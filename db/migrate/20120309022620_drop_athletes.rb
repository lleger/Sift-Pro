class DropAthletes < ActiveRecord::Migration
  def up
    drop_table :athletes
  end

  def down
    create_table "athletes" do |t|
      t.string   "name"
      t.string   "email"
      t.integer  "sport_id"
      t.integer  "university_id"
      t.string   "token"
      t.string   "secret"
      t.datetime "remember_created_at"
      
      t.timestamps
    end
  end
end

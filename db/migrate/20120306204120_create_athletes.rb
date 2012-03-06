class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :name
      t.string :email
      t.integer :sport_id
      t.integer :university_id
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end

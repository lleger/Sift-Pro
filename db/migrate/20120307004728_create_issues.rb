class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.text :tweet
      t.text :blacklisted_words
      t.integer :univeresity_id
      t.integer :athlete_id
      t.text :response
      t.boolean :approved

      t.timestamps
    end
  end
end

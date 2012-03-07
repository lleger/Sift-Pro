class SpellCheckIssue < ActiveRecord::Migration
  def up
    rename_column :issues, :univeresity_id, :university_id
  end

  def down
    rename_column :issues, :university_id, :univeresity_id
  end
end
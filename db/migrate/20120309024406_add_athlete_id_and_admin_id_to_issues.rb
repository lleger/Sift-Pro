class AddAthleteIdAndAdminIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :admin_id, :integer

  end
end

class AddAdminAndUniversityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false

    add_column :users, :university_id, :integer

  end
end

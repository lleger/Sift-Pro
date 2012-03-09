class AddAthleteFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string

    add_column :users, :sport_id, :integer

    add_column :users, :token, :string

    add_column :users, :secret, :string

  end
end

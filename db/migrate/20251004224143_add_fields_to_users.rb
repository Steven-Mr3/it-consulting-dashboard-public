class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :integer
    add_column :users, :client_id, :integer
    add_column :users, :avatar_url, :string
  end
end

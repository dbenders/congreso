class AddUsernameToPerson < ActiveRecord::Migration
  def change
    add_column :people, :username, :string
  end
end

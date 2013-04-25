class AddPartyIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :party_id, :integer
  end
end

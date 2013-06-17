class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :person_id
      t.integer :bill_id
      t.string :vote

      t.timestamps
    end
  end
end

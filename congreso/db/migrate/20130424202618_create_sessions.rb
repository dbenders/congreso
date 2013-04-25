class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.date :date
      t.string :chamber
      t.string :name
      t.text :transcript
      t.string :video_url

      t.timestamps
    end
  end
end

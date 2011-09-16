class CreateGunplamodeltypes < ActiveRecord::Migration
  def self.up
    create_table :gunplamodeltypes do |t|
      t.integer :codiceready
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :gunplamodeltypes
  end
end

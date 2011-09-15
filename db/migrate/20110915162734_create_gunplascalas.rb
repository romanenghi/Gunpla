class CreateGunplascalas < ActiveRecord::Migration
  def self.up
    create_table :gunplascalas do |t|
      t.integer :codiceready
      t.string :name
    end
  end

  def self.down
    drop_table :gunplascalas
  end
end

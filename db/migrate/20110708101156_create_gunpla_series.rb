class CreateGunplaSeries < ActiveRecord::Migration
  def self.up
    create_table :gunpla_series do |t|
      t.integer :gunpla_id
      t.integer :serie_id
      t.boolean :primary
      t.timestamps
    end
  end

  def self.down
    drop_table :gunpla_series
  end
end

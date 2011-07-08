class CreateData1999s < ActiveRecord::Migration
  def self.up
    create_table :data1999s do |t|
      t.integer :gunpla_id

      t.timestamps
    end
  end

  def self.down
    drop_table :data1999s
  end
end

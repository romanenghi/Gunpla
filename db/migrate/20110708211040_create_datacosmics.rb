class CreateDatacosmics < ActiveRecord::Migration
  def self.up
    create_table :datacosmics do |t|
      t.integer :gunpla_id

      t.timestamps
    end
  end

  def self.down
    drop_table :datacosmics
  end
end

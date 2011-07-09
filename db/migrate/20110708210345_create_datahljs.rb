class CreateDatahljs < ActiveRecord::Migration
  def self.up
    create_table :datahljs do |t|
      t.integer :gunpla_id
      t.string :code
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :datahljs
  end
end

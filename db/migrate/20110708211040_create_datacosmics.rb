class CreateDatacosmics < ActiveRecord::Migration
  def self.up
    create_table :datacosmics do |t|
      t.integer :gunpla_id
      t.string :code
      t.string :description
      t.string :jancode
      t.string :wholesaleprice
      t.string :publicprice
      t.timestamps
    end
  end

  def self.down
    drop_table :datacosmics
  end
end

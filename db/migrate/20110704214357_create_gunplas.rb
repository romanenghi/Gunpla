class CreateGunplas < ActiveRecord::Migration
  def self.up
    create_table :gunplas do |t|
    t.integer :gunplascalas_id
	  t.string :code
	  t.string :description
	  t.text :longdescription
	  t.string :publicprice
	  t.string :jancode
	  t.boolean :export
      t.timestamps
    end
  end

  def self.down
    drop_table :gunplas
  end
end

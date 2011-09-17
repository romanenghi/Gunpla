class CreateDatahljs < ActiveRecord::Migration
  def self.up
    create_table :datahljs do |t|
      t.integer :gunpla_id
      t.string :code
      t.string :description
      t.string :jancode
      t.string :image
      t.text :longdescription
      t.string :productseriestitle
      t.string :producttype
      t.timestamps
    end
  end

  def self.down
    drop_table :datahljs
  end
end

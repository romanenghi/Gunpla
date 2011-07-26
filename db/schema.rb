# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110709180919) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data1999s", :force => true do |t|
    t.integer  "gunpla_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datacosmics", :force => true do |t|
    t.integer  "gunpla_id"
    t.string   "code"
    t.string   "description"
    t.string   "jancode"
    t.string   "wholesaleprice"
    t.string   "publicprice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datahljs", :force => true do |t|
    t.integer  "gunpla_id"
    t.string   "code"
    t.string   "description"
    t.string   "jancode"
    t.string   "image"
    t.text     "longdescription"
    t.string   "productseriestitle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gunpla_categories", :force => true do |t|
    t.integer  "gunpla_id"
    t.integer  "category_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gunpla_series", :force => true do |t|
    t.integer  "gunpla_id"
    t.integer  "serie_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gunplas", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "publicprice"
    t.string   "jancode"
    t.boolean  "export"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "gunpla_id"
    t.integer  "imagetype_id"
    t.boolean  "defaultimage"
    t.string   "localpath"
    t.string   "remotepath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

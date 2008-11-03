# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081103095345) do

  create_table "addresses", :force => true do |t|
    t.string  "name"
    t.string  "city"
    t.string  "street"
    t.integer "zipcode",          :precision => 4, :scale => 0
    t.integer "addressable_id"
    t.string  "addressable_type"
  end

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "category_attributes", :force => true do |t|
    t.string  "name"
    t.string  "format"
    t.integer "category_id"
  end

  create_table "labels", :force => true do |t|
    t.string "name"
  end

  create_table "labels_products", :id => false, :force => true do |t|
    t.integer "label_id"
    t.integer "product_id"
  end

  create_table "order_states", :force => true do |t|
    t.string "name"
  end

  create_table "order_types", :force => true do |t|
    t.string "name"
  end

  create_table "orders", :force => true do |t|
    t.datetime "created_at"
    t.integer  "order_type_id"
    t.integer  "order_state_id"
    t.integer  "customer_id"
  end

  create_table "product_attributes", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "category_attribute_id"
    t.string  "value"
  end

  create_table "product_pictures", :force => true do |t|
    t.string  "text"
    t.string  "image_url"
    t.integer "product_id"
  end

  create_table "products", :force => true do |t|
    t.string  "name"
    t.integer "price",       :limit => 8, :precision => 8, :scale => 0
    t.integer "category_id"
  end

end

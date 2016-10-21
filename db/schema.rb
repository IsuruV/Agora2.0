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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161021174249) do

  create_table "apartments", force: :cascade do |t|
    t.string "links"
    t.string "locations"
    t.string "pictures"
    t.string "price_range"
    t.string "bed_rooms"
    t.string "transportation"
    t.string "sqft"
    t.string "description"
    t.string "pet_policy"
    t.string "parking"
    t.string "amementies"
  end

end

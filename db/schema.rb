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

ActiveRecord::Schema.define(version: 20180714101602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "ads", force: :cascade do |t|
    t.text     "widget"
    t.string   "google_id"
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "variety"
    t.text     "innerHTML"
  end

  create_table "answers", force: :cascade do |t|
    t.text     "text"
    t.integer  "question_id"
    t.boolean  "is_correct",   default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "redirect_url"
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.text     "short"
    t.integer  "category_id"
    t.string   "slug"
    t.string   "cover_image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "website_id"
    t.index ["category_id"], name: "index_articles_on_category_id", using: :btree
    t.index ["website_id"], name: "index_articles_on_website_id", using: :btree
  end

  create_table "assets", force: :cascade do |t|
    t.string   "storage_uid"
    t.string   "storage_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "storage_width"
    t.integer  "storage_height"
    t.float    "storage_aspect_ratio"
    t.integer  "storage_depth"
    t.string   "storage_format"
    t.string   "storage_mime_type"
    t.string   "storage_size"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories_websites", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "website_id"
  end

  create_table "configs", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.integer  "website_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["website_id"], name: "index_configs_on_website_id", using: :btree
  end

  create_table "formsite_ads", force: :cascade do |t|
    t.integer  "formsite_id"
    t.integer  "ad_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["ad_id"], name: "index_formsite_ads_on_ad_id", using: :btree
    t.index ["formsite_id"], name: "index_formsite_ads_on_formsite_id", using: :btree
  end

  create_table "formsite_questions", force: :cascade do |t|
    t.integer  "formsite_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "formsite_users", force: :cascade do |t|
    t.integer  "formsite_id"
    t.integer  "user_id"
    t.boolean  "is_verified"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "is_useragent_valid"
    t.boolean  "is_impressionwise_test_success"
  end

  create_table "formsites", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "droplet_id"
    t.string   "droplet_ip"
    t.string   "zone_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "repo_url"
    t.string   "ad_client"
    t.string   "ad_sidebar_id"
    t.string   "ad_top_id"
    t.string   "ad_middle_id"
    t.string   "ad_bottom_id"
    t.string   "first_redirect_url"
    t.string   "final_redirect_url"
    t.string   "favicon_image"
    t.string   "logo_image"
    t.boolean  "is_thankyou"
    t.string   "background"
    t.text     "left_side_content"
    t.text     "first_question_code_snippet"
    t.text     "head_code_snippet"
    t.boolean  "is_checkboxes"
    t.text     "right_side_content"
  end

  create_table "product_cards", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.integer  "rate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "website_id"
    t.index ["website_id"], name: "index_product_cards_on_website_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "website_ads", force: :cascade do |t|
    t.integer  "website_id"
    t.integer  "ad_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_website_ads_on_ad_id", using: :btree
    t.index ["website_id"], name: "index_website_ads_on_website_id", using: :btree
  end

  create_table "websites", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "droplet_id"
    t.string   "droplet_ip"
    t.string   "zone_id"
    t.string   "repo_url"
    t.string   "ad_client"
    t.string   "favicon_image"
    t.string   "logo_image"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "websites"
  add_foreign_key "configs", "websites"
  add_foreign_key "formsite_ads", "ads"
  add_foreign_key "formsite_ads", "formsites"
  add_foreign_key "product_cards", "websites"
  add_foreign_key "website_ads", "ads"
  add_foreign_key "website_ads", "websites"
end

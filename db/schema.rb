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

ActiveRecord::Schema.define(version: 20181207093528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

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

  create_table "adopia_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adopia_lists", force: :cascade do |t|
    t.integer  "adopia_account_id", null: false
    t.integer  "list_id",           null: false
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["adopia_account_id"], name: "index_adopia_lists_on_adopia_account_id", using: :btree
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
    t.boolean  "is_correct",             default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "redirect_url"
    t.integer  "formsite_user_id"
    t.datetime "deleted_at"
    t.integer  "next_question_position"
    t.boolean  "last_question",          default: false
    t.index ["deleted_at"], name: "index_answers_on_deleted_at", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "api_clients", force: :cascade do |t|
    t.string   "token"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_users", force: :cascade do |t|
    t.integer  "api_client_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_verified"
    t.boolean  "is_useragent_valid"
    t.boolean  "is_impressionwise_test_success"
    t.boolean  "is_duplicate"
    t.string   "s1"
    t.string   "s2"
    t.string   "s3"
    t.string   "s4"
    t.string   "s5"
    t.string   "website"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "ip"
    t.datetime "captured"
    t.string   "lead_id"
    t.string   "zip"
    t.string   "state"
    t.string   "phone1"
    t.string   "job"
    t.index ["api_client_id"], name: "index_api_users_on_api_client_id", using: :btree
    t.index ["email"], name: "index_api_users_on_email", using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.text     "short"
    t.integer  "category_id"
    t.string   "slug"
    t.string   "cover_image"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "website_id"
    t.integer  "formsite_id"
    t.datetime "deleted_at"
    t.integer  "leadgen_rev_site_id"
    t.index ["category_id"], name: "index_articles_on_category_id", using: :btree
    t.index ["deleted_at"], name: "index_articles_on_deleted_at", using: :btree
    t.index ["leadgen_rev_site_id"], name: "index_articles_on_leadgen_rev_site_id", using: :btree
    t.index ["website_id"], name: "index_articles_on_website_id", using: :btree
  end

  create_table "articles_leadgen_rev_sites", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "leadgen_rev_site_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["article_id"], name: "index_articles_leadgen_rev_sites_on_article_id", using: :btree
    t.index ["leadgen_rev_site_id"], name: "index_articles_leadgen_rev_sites_on_leadgen_rev_site_id", using: :btree
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

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.jsonb    "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index", using: :btree
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "aweber_accounts", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "access_token"
    t.string   "secret_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "oauth_token"
    t.string   "name"
  end

  create_table "aweber_lists", force: :cascade do |t|
    t.integer  "aweber_account_id"
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "collect_statistics", default: false, null: false
  end

  create_table "aweber_rules", force: :cascade do |t|
    t.integer  "list_from_id"
    t.integer  "list_to_id"
    t.string   "time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories_formsites", force: :cascade do |t|
    t.integer "formsite_id"
    t.integer "category_id"
  end

  create_table "categories_leadgen_rev_sites", force: :cascade do |t|
    t.integer "leadgen_rev_site_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_leadgen_rev_sites_on_category_id", using: :btree
    t.index ["leadgen_rev_site_id"], name: "index_categories_leadgen_rev_sites_on_leadgen_rev_site_id", using: :btree
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

  create_table "elite_accounts", force: :cascade do |t|
    t.string   "sender"
    t.string   "api_key",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elite_groups", force: :cascade do |t|
    t.integer  "elite_account_id", null: false
    t.string   "name"
    t.string   "group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["elite_account_id"], name: "index_elite_groups_on_elite_account_id", using: :btree
  end

  create_table "email_marketer_campaigns", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "list_ids",    default: [], null: false, array: true
    t.string   "subject"
    t.string   "origin"
    t.string   "source_url"
    t.jsonb    "stats",       default: {}, null: false
    t.datetime "sent_at"
    t.integer  "account_id"
  end

  create_table "email_marketer_mappings", force: :cascade do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "destination_type"
    t.integer  "destination_id"
    t.date     "start_date"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "last_transfer_at"
    t.string   "tag"
    t.integer  "delay_in_hours",   default: 0
    t.string   "domain"
    t.index ["destination_type", "destination_id"], name: "index_email_marketer_mappings_on_source", using: :btree
    t.index ["source_type", "source_id"], name: "index_email_marketer_mappings_on_destination", using: :btree
  end

  create_table "esp_accounts", force: :cascade do |t|
    t.string   "type",                     null: false
    t.string   "name"
    t.text     "api_key"
    t.text     "access_token"
    t.text     "secret_token"
    t.text     "oauth_token"
    t.integer  "account_id"
    t.string   "account_code"
    t.string   "username"
    t.string   "password"
    t.integer  "daily_limit",  default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "esp_lists", force: :cascade do |t|
    t.integer  "account_id",  null: false
    t.string   "type",        null: false
    t.bigint   "list_id"
    t.string   "slug"
    t.string   "address"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "campaign_id"
  end

  create_table "esp_rules", force: :cascade do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.integer  "delay_in_hours", default: 0, null: false
    t.string   "domain"
    t.string   "affiliate"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["source_type", "source_id"], name: "index_esp_rules_on_source_type_and_source_id", using: :btree
  end

  create_table "esp_rules_lists", force: :cascade do |t|
    t.integer "esp_rule_id",                   null: false
    t.string  "list_type"
    t.integer "list_id"
    t.boolean "is_over_limit", default: false
    t.index ["esp_rule_id"], name: "index_esp_rules_lists_on_esp_rule_id", using: :btree
    t.index ["list_type", "list_id"], name: "index_esp_rules_lists_on_list_type_and_list_id", using: :btree
  end

  create_table "esp_sending_limits", force: :cascade do |t|
    t.string   "provider",                null: false
    t.integer  "daily_limit", default: 0
    t.hstore   "isp_limits"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["isp_limits"], name: "index_esp_sending_limits_on_isp_limits", using: :gin
  end

  create_table "exported_leads", force: :cascade do |t|
    t.string   "list_type"
    t.integer  "list_id"
    t.string   "linkable_type"
    t.integer  "linkable_id"
    t.datetime "created_at"
    t.integer  "esp_rule_id"
    t.index ["esp_rule_id"], name: "index_exported_leads_on_esp_rule_id", using: :btree
    t.index ["linkable_type", "linkable_id"], name: "index_email_marketer_list_users_to_linkable", using: :btree
    t.index ["list_type", "list_id"], name: "index_exported_leads_on_list_type_and_list_id", using: :btree
  end

  create_table "formsite_ads", force: :cascade do |t|
    t.integer  "formsite_id"
    t.integer  "ad_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["ad_id"], name: "index_formsite_ads_on_ad_id", using: :btree
    t.index ["formsite_id"], name: "index_formsite_ads_on_formsite_id", using: :btree
  end

  create_table "formsite_aweber_lists", force: :cascade do |t|
    t.integer  "aweber_list_id"
    t.integer  "formsite_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "delay_in_hours", default: 0, null: false
  end

  create_table "formsite_questions", force: :cascade do |t|
    t.integer  "formsite_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "position"
  end

  create_table "formsite_user_answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "formsite_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "formsite_user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "formsite_users", force: :cascade do |t|
    t.integer  "formsite_id"
    t.integer  "user_id"
    t.boolean  "is_verified"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_useragent_valid"
    t.boolean  "is_impressionwise_test_success"
    t.boolean  "is_duplicate"
    t.string   "s4"
    t.string   "s5"
    t.string   "s1"
    t.string   "s2"
    t.string   "s3"
    t.string   "ndm_token"
    t.string   "affiliate"
    t.datetime "birthday"
    t.string   "zip"
    t.string   "phone"
    t.string   "ip"
    t.string   "job_key"
    t.datetime "deleted_at"
    t.boolean  "is_email_duplicate",             default: false
    t.string   "external_link"
    t.string   "company"
    t.string   "abstract"
    t.string   "title"
    t.string   "data_key"
    t.string   "site_type",                      default: "leadgen"
    t.integer  "website_id"
    t.string   "url"
    t.index ["deleted_at"], name: "index_formsite_users_on_deleted_at", using: :btree
    t.index ["website_id"], name: "index_formsite_users_on_website_id", using: :btree
  end

  create_table "formsites", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "droplet_id"
    t.string   "droplet_ip"
    t.string   "zone_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
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
    t.string   "s1_description"
    t.string   "s2_description"
    t.string   "s3_description"
    t.string   "s4_description"
    t.string   "s5_description"
    t.string   "form_box_title_text"
    t.string   "affiliate_description"
    t.boolean  "is_phone_number",             default: false
    t.datetime "deleted_at"
    t.string   "fraud_user_redirect_url"
    t.index ["deleted_at"], name: "index_formsites_on_deleted_at", using: :btree
  end

  create_table "leadgen_rev_site_ads", force: :cascade do |t|
    t.integer  "leadgen_rev_site_id"
    t.integer  "ad_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["ad_id"], name: "index_leadgen_rev_site_ads_on_ad_id", using: :btree
    t.index ["leadgen_rev_site_id"], name: "index_leadgen_rev_site_ads_on_leadgen_rev_site_id", using: :btree
  end

  create_table "leadgen_rev_site_user_answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "leadgen_rev_site_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "leadgen_rev_site_user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["answer_id"], name: "index_leadgen_rev_site_user_answers_on_answer_id", using: :btree
    t.index ["leadgen_rev_site_id"], name: "index_leadgen_rev_site_user_answers_on_leadgen_rev_site_id", using: :btree
    t.index ["leadgen_rev_site_user_id"], name: "index_leadgen_rev_site_user_answers_on_leadgen_rev_site_user_id", using: :btree
    t.index ["question_id"], name: "index_leadgen_rev_site_user_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_leadgen_rev_site_user_answers_on_user_id", using: :btree
  end

  create_table "leadgen_rev_site_users", force: :cascade do |t|
    t.integer  "leadgen_rev_site_id"
    t.integer  "user_id"
    t.boolean  "is_verified"
    t.boolean  "is_useragent_valid"
    t.boolean  "is_impressionwise_test_success"
    t.boolean  "is_duplicate"
    t.string   "s4"
    t.string   "s5"
    t.string   "s1"
    t.string   "s2"
    t.string   "s3"
    t.string   "ndm_token"
    t.string   "affiliate"
    t.datetime "birthday"
    t.string   "zip"
    t.string   "phone"
    t.string   "ip"
    t.string   "job_key"
    t.datetime "deleted_at"
    t.boolean  "is_email_duplicate",             default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["leadgen_rev_site_id"], name: "index_leadgen_rev_site_users_on_leadgen_rev_site_id", using: :btree
    t.index ["user_id"], name: "index_leadgen_rev_site_users_on_user_id", using: :btree
  end

  create_table "leadgen_rev_sites", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "droplet_id"
    t.string   "droplet_ip"
    t.string   "zone_id"
    t.string   "repo_url"
    t.string   "favicon_image"
    t.string   "logo_image"
    t.string   "shortname"
    t.string   "text_file"
    t.datetime "deleted_at"
    t.string   "ad_client"
    t.string   "ad_sidebar_id"
    t.string   "ad_top_id"
    t.string   "ad_middle_id"
    t.string   "ad_bottom_id"
    t.string   "first_redirect_url"
    t.string   "final_redirect_url"
    t.boolean  "is_thankyou"
    t.string   "background"
    t.text     "left_side_content"
    t.text     "first_question_code_snippet"
    t.text     "head_code_snippet"
    t.boolean  "is_checkboxes"
    t.string   "right_side_content"
    t.string   "s1_description"
    t.string   "s2_description"
    t.string   "s3_description"
    t.string   "s4_description"
    t.string   "s5_description"
    t.string   "form_box_title_text"
    t.string   "affiliate_description"
    t.boolean  "is_phone_number"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "show_popup",                  default: false
    t.string   "popup_iframe_urls",           default: [],                 array: true
    t.integer  "popup_delay"
    t.string   "leadgen_entry"
    t.index ["deleted_at"], name: "index_leadgen_rev_sites_on_deleted_at", using: :btree
  end

  create_table "leads", force: :cascade do |t|
    t.string   "type"
    t.string   "email"
    t.string   "full_name"
    t.jsonb    "details",        default: {}, null: false
    t.datetime "converted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "source_id"
    t.integer  "destination_id"
    t.integer  "user_id"
    t.string   "status"
    t.string   "affiliate"
    t.datetime "event_at"
    t.integer  "campaign_id"
    t.index ["user_id"], name: "index_leads_on_user_id", using: :btree
  end

  create_table "mailgun_accounts", force: :cascade do |t|
    t.string   "api_key",    null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailgun_lists", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "mailgun_account_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["mailgun_account_id"], name: "index_mailgun_lists_on_mailgun_account_id", using: :btree
  end

  create_table "mailgun_templates", force: :cascade do |t|
    t.string   "author"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailgun_templates_schedules", force: :cascade do |t|
    t.integer  "mailgun_template_id", null: false
    t.integer  "mailgun_list_id",     null: false
    t.datetime "sending_time",        null: false
    t.string   "scheduled_job_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["mailgun_list_id"], name: "index_mailgun_templates_schedules_on_mailgun_list_id", using: :btree
    t.index ["mailgun_template_id"], name: "index_mailgun_templates_schedules_on_mailgun_template_id", using: :btree
  end

  create_table "maropost_accounts", force: :cascade do |t|
    t.integer  "account_id", null: false
    t.text     "auth_token", null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maropost_lists", force: :cascade do |t|
    t.integer  "maropost_account_id", null: false
    t.integer  "list_id",             null: false
    t.string   "name",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["maropost_account_id"], name: "index_maropost_lists_on_maropost_account_id", using: :btree
  end

  create_table "netatlantic_accounts", force: :cascade do |t|
    t.string   "sender"
    t.string   "sender_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "account_name"
  end

  create_table "netatlantic_lists", force: :cascade do |t|
    t.integer  "list_id"
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "netatlantic_account_id"
  end

  create_table "onepoint_accounts", force: :cascade do |t|
    t.string   "username",   null: false
    t.string   "api_key",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "onepoint_lists", force: :cascade do |t|
    t.integer  "onepoint_account_id", null: false
    t.integer  "list_id",             null: false
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["onepoint_account_id"], name: "index_onepoint_lists_on_onepoint_account_id", using: :btree
  end

  create_table "ongage_accounts", force: :cascade do |t|
    t.string   "username",     null: false
    t.string   "password",     null: false
    t.string   "account_code", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ongage_lists", force: :cascade do |t|
    t.integer  "list_id",           null: false
    t.integer  "ongage_account_id", null: false
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["ongage_account_id"], name: "index_ongage_lists_on_ongage_account_id", using: :btree
  end

  create_table "pending_leads", force: :cascade do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "email"
    t.string   "full_name"
    t.string   "destination_name"
    t.datetime "created_at"
    t.datetime "sent_at"
    t.integer  "user_id"
    t.string   "destination_type"
    t.text     "referrer"
    t.boolean  "sent_to_adopia",      default: false
    t.boolean  "sent_to_netatlantic", default: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_pending_leads_on_deleted_at", using: :btree
    t.index ["destination_type"], name: "index_pending_leads_on_destination_type", using: :btree
    t.index ["referrer"], name: "index_pending_leads_on_referrer", using: :btree
    t.index ["sent_to_adopia"], name: "index_pending_leads_on_sent_to_adopia", using: :btree
    t.index ["sent_to_netatlantic"], name: "index_pending_leads_on_sent_to_netatlantic", using: :btree
    t.index ["source_type", "source_id"], name: "index_pending_leads_on_source_type_and_source_id", using: :btree
  end

  create_table "product_cards", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "website_id"
    t.string   "url"
    t.float    "rate"
    t.integer  "leadgen_rev_site_id"
    t.index ["leadgen_rev_site_id"], name: "index_product_cards_on_leadgen_rev_site_id", using: :btree
    t.index ["website_id"], name: "index_product_cards_on_website_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "formsite_id"
    t.integer  "position"
    t.string   "flow",                default: "horizontal"
    t.datetime "deleted_at"
    t.boolean  "is_last",             default: false,        null: false
    t.integer  "leadgen_rev_site_id"
    t.integer  "website_id"
    t.index ["deleted_at"], name: "index_questions_on_deleted_at", using: :btree
    t.index ["formsite_id"], name: "index_questions_on_formsite_id", using: :btree
    t.index ["leadgen_rev_site_id"], name: "index_questions_on_leadgen_rev_site_id", using: :btree
    t.index ["website_id"], name: "index_questions_on_website_id", using: :btree
  end

  create_table "sparkpost_accounts", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "username"
    t.string   "api_key",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sparkpost_lists", force: :cascade do |t|
    t.integer  "sparkpost_account_id", null: false
    t.string   "list_id",              null: false
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["sparkpost_account_id"], name: "index_sparkpost_lists_on_sparkpost_account_id", using: :btree
  end

  create_table "suppression_email_marketer_lists", force: :cascade do |t|
    t.integer "suppression_list_id", null: false
    t.string  "removable_type",      null: false
    t.integer "removable_id",        null: false
    t.index ["removable_type", "removable_id"], name: "index_suppression_lists_on_removable", using: :btree
    t.index ["suppression_list_id"], name: "index_suppression_lists_on_esp_lists_suppression_list_id", using: :btree
  end

  create_table "suppression_lists", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "file_name"
    t.boolean  "autoremove_from_esp", default: false, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "added_to_aweber", default: false
    t.datetime "deleted_at"
    t.datetime "unsubscribed_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  end

  create_table "website_ads", force: :cascade do |t|
    t.integer  "website_id"
    t.integer  "ad_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_website_ads_on_ad_id", using: :btree
    t.index ["website_id"], name: "index_website_ads_on_website_id", using: :btree
  end

  create_table "website_user_answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "formsite_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "formsite_user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "websites", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "droplet_id"
    t.string   "droplet_ip"
    t.string   "zone_id"
    t.string   "repo_url"
    t.string   "ad_client"
    t.string   "favicon_image"
    t.string   "logo_image"
    t.string   "shortname"
    t.string   "text_file"
    t.datetime "deleted_at"
    t.boolean  "show_popup",        default: false
    t.string   "popup_iframe_urls", default: [],                 array: true
    t.integer  "popup_delay"
    t.index ["deleted_at"], name: "index_websites_on_deleted_at", using: :btree
  end

  add_foreign_key "adopia_lists", "adopia_accounts"
  add_foreign_key "answers", "questions"
  add_foreign_key "api_users", "api_clients"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "websites"
  add_foreign_key "categories_leadgen_rev_sites", "categories"
  add_foreign_key "categories_leadgen_rev_sites", "leadgen_rev_sites"
  add_foreign_key "configs", "websites"
  add_foreign_key "elite_groups", "elite_accounts"
  add_foreign_key "esp_rules_lists", "esp_rules"
  add_foreign_key "exported_leads", "esp_rules"
  add_foreign_key "formsite_ads", "ads"
  add_foreign_key "formsite_ads", "formsites"
  add_foreign_key "leadgen_rev_site_ads", "ads"
  add_foreign_key "leadgen_rev_site_ads", "leadgen_rev_sites"
  add_foreign_key "leadgen_rev_site_user_answers", "answers"
  add_foreign_key "leadgen_rev_site_user_answers", "leadgen_rev_site_users"
  add_foreign_key "leadgen_rev_site_user_answers", "leadgen_rev_sites"
  add_foreign_key "leadgen_rev_site_user_answers", "questions"
  add_foreign_key "leadgen_rev_site_user_answers", "users"
  add_foreign_key "leadgen_rev_site_users", "leadgen_rev_sites"
  add_foreign_key "leadgen_rev_site_users", "users"
  add_foreign_key "leads", "users"
  add_foreign_key "mailgun_lists", "mailgun_accounts"
  add_foreign_key "mailgun_templates_schedules", "esp_lists", column: "mailgun_list_id"
  add_foreign_key "mailgun_templates_schedules", "mailgun_templates"
  add_foreign_key "maropost_lists", "maropost_accounts"
  add_foreign_key "onepoint_lists", "onepoint_accounts"
  add_foreign_key "ongage_lists", "ongage_accounts"
  add_foreign_key "product_cards", "leadgen_rev_sites"
  add_foreign_key "product_cards", "websites"
  add_foreign_key "questions", "formsites"
  add_foreign_key "questions", "leadgen_rev_sites"
  add_foreign_key "questions", "websites"
  add_foreign_key "sparkpost_lists", "sparkpost_accounts"
  add_foreign_key "suppression_email_marketer_lists", "suppression_lists"
  add_foreign_key "website_ads", "ads"
  add_foreign_key "website_ads", "websites"
end

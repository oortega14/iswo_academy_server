# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_09_135124) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "admin_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_academies_on_admin_id"
    t.index ["category_id"], name: "index_academies_on_category_id"
  end

  create_table "academy_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "academy_configurations", force: :cascade do |t|
    t.string "domain", null: false
    t.jsonb "colors", default: {}
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_phone"
    t.bigint "academy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_academy_configurations_on_academy_id"
    t.index ["domain"], name: "index_academy_configurations_on_domain", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_detail_id", null: false
    t.string "address"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_detail_id"], name: "index_addresses_on_user_detail_id"
  end

  create_table "course_purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.decimal "amount_paid", precision: 10, scale: 2, null: false
    t.decimal "platform_fee", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_purchases_on_course_id"
    t.index ["user_id"], name: "index_course_purchases_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "academy_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_courses_on_academy_id"
    t.index ["creator_id"], name: "index_courses_on_creator_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "professor_invitations", force: :cascade do |t|
    t.string "email", null: false
    t.string "token", null: false
    t.bigint "academy_id", null: false
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_professor_invitations_on_academy_id"
    t.index ["token"], name: "index_professor_invitations_on_token", unique: true
  end

  create_table "social_networks", force: :cascade do |t|
    t.bigint "user_detail_id", null: false
    t.string "platform", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_detail_id"], name: "index_social_networks_on_user_detail_id"
  end

  create_table "student_enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "academy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_student_enrollments_on_academy_id"
    t.index ["user_id"], name: "index_student_enrollments_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "academy_id", null: false
    t.decimal "amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_subscriptions_on_academy_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "user_academies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "academy_id"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_user_academies_on_academy_id"
    t.index ["user_id"], name: "index_user_academies_on_user_id", unique: true
  end

  create_table "user_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.string "phone"
    t.string "dni"
    t.integer "gender"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
    t.index ["username"], name: "index_user_details_on_username", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.boolean "is_active", default: true
    t.boolean "is_super_admin", default: false
    t.boolean "is_profile_completed", default: false
    t.integer "wizard_step", default: 1
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "academies", "academy_categories", column: "category_id"
  add_foreign_key "academies", "users", column: "admin_id"
  add_foreign_key "academy_configurations", "academies"
  add_foreign_key "addresses", "user_details"
  add_foreign_key "course_purchases", "courses"
  add_foreign_key "course_purchases", "users"
  add_foreign_key "courses", "academies"
  add_foreign_key "courses", "users", column: "creator_id"
  add_foreign_key "professor_invitations", "academies"
  add_foreign_key "social_networks", "user_details"
  add_foreign_key "student_enrollments", "academies"
  add_foreign_key "student_enrollments", "users"
  add_foreign_key "subscriptions", "academies"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "user_academies", "academies"
  add_foreign_key "user_academies", "users"
  add_foreign_key "user_details", "users"
end

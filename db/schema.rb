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

ActiveRecord::Schema[7.2].define(version: 2025_03_12_235850) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "slogan"
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
    t.string "color_palette", null: false
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_phone"
    t.bigint "academy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_academy_configurations_on_academy_id"
    t.index ["domain"], name: "index_academy_configurations_on_domain", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
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

  create_table "assessments", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "course_id", null: false
    t.bigint "course_section_id"
    t.string "type"
    t.string "name"
    t.integer "time_limit"
    t.integer "retry_after", null: false
    t.integer "approve_with", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assessments_on_course_id"
    t.index ["course_section_id"], name: "index_assessments_on_course_section_id"
    t.index ["teacher_id"], name: "index_assessments_on_teacher_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "attachable_type", null: false
    t.bigint "attachable_id", null: false
    t.string "type", null: false
    t.string "url"
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable"
  end

  create_table "badge_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges_users", id: false, force: :cascade do |t|
    t.bigint "badge_id", null: false
    t.bigint "user_id", null: false
    t.index ["badge_id", "user_id"], name: "index_badges_users_on_badge_id_and_user_id"
    t.index ["user_id", "badge_id"], name: "index_badges_users_on_user_id_and_badge_id"
  end

  create_table "certificate_configurations", force: :cascade do |t|
    t.string "course_name"
    t.string "course_time"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_certificate_configurations_on_course_id"
  end

  create_table "certificates", force: :cascade do |t|
    t.string "student_name"
    t.string "course_title"
    t.float "duration"
    t.date "end_date"
    t.uuid "code"
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_certificates_on_course_id"
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.text "body", null: false
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "correct_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_correct_answers_on_question_id"
  end

  create_table "course_details", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "description"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_details_on_course_id"
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

  create_table "course_sections", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_sections_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "status", default: 0
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "academy_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_courses_on_academy_id"
    t.index ["creator_id"], name: "index_courses_on_creator_id"
  end

  create_table "courses_learning_routes", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "learning_route_id", null: false
    t.index ["course_id", "learning_route_id"], name: "idx_on_course_id_learning_route_id_d32053c5e3"
    t.index ["learning_route_id", "course_id"], name: "idx_on_learning_route_id_course_id_a17175d1d9"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.integer "status", default: 0
    t.integer "progress", default: 0
    t.datetime "purchased_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id", "course_id"], name: "index_enrollments_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "learning_routes", force: :cascade do |t|
    t.bigint "academy_id", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_learning_routes_on_academy_id"
  end

  create_table "lesson_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.string "status", default: "pending"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "progress_seconds", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_progresses_on_lesson_id"
    t.index ["user_id", "lesson_id"], name: "index_lesson_progresses_on_user_id_and_lesson_id", unique: true
    t.index ["user_id"], name: "index_lesson_progresses_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "position"
    t.boolean "visible", default: false
    t.bigint "course_section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_section_id"], name: "index_lessons_on_course_section_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.string "message", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
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

  create_table "question_options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "content", null: false
    t.boolean "correct", default: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "assessment_id", null: false
    t.text "content", null: false
    t.integer "question_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_questions_on_assessment_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_refresh_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "description"
    t.integer "stars", default: 0
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_reviews_on_course_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "social_networks", force: :cascade do |t|
    t.bigint "user_detail_id", null: false
    t.string "platform", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_detail_id"], name: "index_social_networks_on_user_detail_id"
  end

  create_table "student_assessments", force: :cascade do |t|
    t.bigint "assessment_id", null: false
    t.bigint "student_id", null: false
    t.integer "score", default: 0
    t.integer "status", default: 0
    t.string "type"
    t.datetime "started_at"
    t.datetime "last_attempt_at"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_student_assessments_on_assessment_id"
    t.index ["student_id"], name: "index_student_assessments_on_student_id"
  end

  create_table "student_enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "academy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_student_enrollments_on_academy_id"
    t.index ["user_id"], name: "index_student_enrollments_on_user_id"
  end

  create_table "student_responses", force: :cascade do |t|
    t.bigint "student_assessment_id", null: false
    t.bigint "question_id", null: false
    t.bigint "question_option_id"
    t.text "answer_text"
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_student_responses_on_question_id"
    t.index ["question_option_id"], name: "index_student_responses_on_question_option_id"
    t.index ["student_assessment_id"], name: "index_student_responses_on_student_assessment_id"
  end

  create_table "student_task_comments", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "student_task_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_task_id"], name: "index_student_task_comments_on_student_task_id"
    t.index ["user_id"], name: "index_student_task_comments_on_user_id"
  end

  create_table "student_tasks", force: :cascade do |t|
    t.integer "status"
    t.float "grade"
    t.datetime "due_date"
    t.bigint "teacher_task_id", null: false
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_tasks_on_course_id"
    t.index ["student_id"], name: "index_student_tasks_on_student_id"
    t.index ["teacher_task_id"], name: "index_student_tasks_on_teacher_task_id"
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

  create_table "teacher_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "due_date"
    t.integer "status", default: 0
    t.datetime "deleted_at"
    t.bigint "course_id", null: false
    t.bigint "course_section_id"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_teacher_tasks_on_course_id"
    t.index ["course_section_id"], name: "index_teacher_tasks_on_course_section_id"
    t.index ["teacher_id"], name: "index_teacher_tasks_on_teacher_id"
  end

  create_table "user_academies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "academy_id"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_user_academies_on_academy_id"
    t.index ["user_id"], name: "index_user_academies_on_user_id"
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
    t.integer "wizard_step", default: 0
    t.integer "active_academy_id"
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
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "user_details"
  add_foreign_key "assessments", "course_sections"
  add_foreign_key "assessments", "courses"
  add_foreign_key "assessments", "users", column: "teacher_id"
  add_foreign_key "certificate_configurations", "courses"
  add_foreign_key "certificates", "courses"
  add_foreign_key "certificates", "users"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "users"
  add_foreign_key "correct_answers", "questions"
  add_foreign_key "course_details", "courses"
  add_foreign_key "course_purchases", "courses"
  add_foreign_key "course_purchases", "users"
  add_foreign_key "course_sections", "courses"
  add_foreign_key "courses", "academies"
  add_foreign_key "courses", "users", column: "creator_id"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "learning_routes", "academies"
  add_foreign_key "lesson_progresses", "lessons"
  add_foreign_key "lesson_progresses", "users"
  add_foreign_key "lessons", "course_sections"
  add_foreign_key "professor_invitations", "academies"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "assessments"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "reviews", "courses"
  add_foreign_key "reviews", "users"
  add_foreign_key "social_networks", "user_details"
  add_foreign_key "student_assessments", "assessments"
  add_foreign_key "student_assessments", "users", column: "student_id"
  add_foreign_key "student_enrollments", "academies"
  add_foreign_key "student_enrollments", "users"
  add_foreign_key "student_responses", "question_options"
  add_foreign_key "student_responses", "questions"
  add_foreign_key "student_responses", "student_assessments"
  add_foreign_key "student_task_comments", "student_tasks"
  add_foreign_key "student_task_comments", "users"
  add_foreign_key "student_tasks", "courses"
  add_foreign_key "student_tasks", "teacher_tasks"
  add_foreign_key "student_tasks", "users", column: "student_id"
  add_foreign_key "subscriptions", "academies"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "teacher_tasks", "course_sections"
  add_foreign_key "teacher_tasks", "courses"
  add_foreign_key "teacher_tasks", "users", column: "teacher_id"
  add_foreign_key "user_academies", "academies"
  add_foreign_key "user_academies", "users"
  add_foreign_key "user_details", "users"
end

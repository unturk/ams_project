# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131130151053) do

  create_table "renters", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "ap_num"
    t.string   "ocak"
    t.string   "subat"
    t.string   "mart"
    t.string   "nisan"
    t.string   "mayis"
    t.string   "haziran"
    t.string   "temmuz"
    t.string   "agustos"
    t.string   "eylul"
    t.string   "ekim"
    t.string   "kasim"
    t.string   "aralik"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renters", ["ap_num"], name: "index_renters_on_ap_num", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "verified",        default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end

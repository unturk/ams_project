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

ActiveRecord::Schema.define(version: 20131213112722) do

  create_table "aidats", force: true do |t|
    t.integer  "daire"
    t.integer  "year"
    t.string   "month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "renters", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "ap_num"
    t.string   "meslek"
    t.string   "medeni_durum"
    t.integer  "birey_sayisi"
    t.integer  "cocuk_sayisi"
    t.string   "memleket"
    t.string   "ev_sahibi"
    t.string   "ev_sahibi_telefon"
    t.string   "kira_miktari"
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

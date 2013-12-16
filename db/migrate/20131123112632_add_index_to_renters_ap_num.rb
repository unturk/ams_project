#Adding index  apart number to renters table
class AddIndexToRentersApNum < ActiveRecord::Migration
  def change
    add_index :renters, :ap_num, unique: true
  end
end

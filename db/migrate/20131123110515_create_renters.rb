#Creating renters table
class CreateRenters < ActiveRecord::Migration
  def change
    create_table :renters do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :ap_num
      t.string :meslek
      t.string :medeni_durum
      t.integer :birey_sayisi
      t.integer :cocuk_sayisi
      t.string :memleket
      t.string :ev_sahibi
      t.string :ev_sahibi_telefon
      t.string :kira_miktari


      t.timestamps
    end
  end
end

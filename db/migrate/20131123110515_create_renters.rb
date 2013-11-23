class CreateRenters < ActiveRecord::Migration
  def change
    create_table :renters do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :ap_num
      t.string :ocak
      t.string :subat
      t.string :mart
      t.string :nisan
      t.string :mayis
      t.string :haziran
      t.string :temmuz
      t.string :agustos
      t.string :eylul
      t.string :ekim
      t.string :kasim
      t.string :aralik

      t.timestamps
    end
  end
end

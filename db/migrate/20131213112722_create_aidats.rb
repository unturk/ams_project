class CreateAidats < ActiveRecord::Migration
  def change
    create_table :aidats do |t|
      t.integer :daire
      t.integer :year
      t.string :month

      t.timestamps
    end
  end
end

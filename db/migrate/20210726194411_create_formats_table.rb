class CreateFormatsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :formats |t|
    t.string :dvd
    t.string :vhs
    t.string :bluray
    t.integer :quantity
  end
end

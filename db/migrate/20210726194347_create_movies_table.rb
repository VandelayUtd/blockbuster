class CreateMoviesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
    t.string :title
    t.string :director
    t.integer :year
    end
  end
end

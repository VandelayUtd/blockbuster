class CreateMoviesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
    t.string :title
    t.string :director
    t.integer :year
    t.string :format
    t.integer :user_id
    end
  end
end

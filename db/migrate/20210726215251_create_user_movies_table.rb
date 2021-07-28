class CreateUserMoviesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_movies do |t|
      t.integer :movie_id
      t.integer :user_id
    end
  end
end

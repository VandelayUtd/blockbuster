class CreateMemberMoviesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :member_movies do |t|
      t.integer :movie_id
      t.integer :member_id
    end
  end
end

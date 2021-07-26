class CreateMovieFormatsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_formats do |t|
      t.integer :movie_id
      t.integer :format_id
    end
  end
end

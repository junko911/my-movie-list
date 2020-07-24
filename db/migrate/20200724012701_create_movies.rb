class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :director_id
      t.integer :studio_id
      t.integer :rating
    end
  end
end

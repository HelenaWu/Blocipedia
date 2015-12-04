class AddSlugIndexToWikis < ActiveRecord::Migration
  def change
    add_index :wikis, :slug, unique: true
  end
end

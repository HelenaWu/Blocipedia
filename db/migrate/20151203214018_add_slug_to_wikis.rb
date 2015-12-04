class AddSlugToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :slug, :string, unique: true
  end
end

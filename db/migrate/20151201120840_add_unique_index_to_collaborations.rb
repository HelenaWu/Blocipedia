class AddUniqueIndexToCollaborations < ActiveRecord::Migration
  def change
    # remove_index :collaborations, :user_id
    # remove_index :collaborations, :wiki_id
    add_index :collaborations, [:user_id,:wiki_id], unique: true
  end
end

class AddUniqueIndexToPostsAndCommentsI < ActiveRecord::Migration[8.0]
  def change
    add_index :posts, :id, unique: true unless index_exists?(:posts, :id, unique: true)
    add_index :comments, :id, unique: true unless index_exists?(:comments, :id, unique: true)
  end
end

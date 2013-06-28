class AddPictureColumnToUser < ActiveRecord::Migration
  def self.up
    remove_column :posts, :picture
    add_attachment :posts, :picture
  end

  def self.down
    add_column :posts, :picture
    remove_attachment :posts, :picture
  end
end

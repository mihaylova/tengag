class Post < ActiveRecord::Base
  attr_accessible :hot, :link, :picture, :title, :user, :picture_file_name
  
  belongs_to :user

  has_attached_file :picture, 
    :styles => { :medium => "300x300>", :thumb => "100x100>", large: "600x600" }
 
  validates_attachment :picture, :presence => true
  validates_attachment_size :picture, :less_than=>1.megabyte
  validates :title, :presence => true

  scope :hot, where(hot: true)
  scope :trending, where(hot: false)
end

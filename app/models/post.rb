class Post < ActiveRecord::Base
  attr_accessible :hot, :link, :picture, :title, :user

  belongs_to :user
end

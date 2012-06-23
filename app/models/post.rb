class Post < ActiveRecord::Base
  attr_accessible :body, :title, :user_id
  
  #Validate User ID When Creating Post
  validates_numericality_of :user_id
  belongs_to :user
end

class Post < ActiveRecord::Base
  attr_accessible :content
  validates :user_id, presence: true
  default_scope order: 'posts.created_at DESC'
  has_many :comments
  belongs_to :user
end

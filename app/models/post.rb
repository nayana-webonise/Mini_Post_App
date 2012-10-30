class Post < ActiveRecord::Base
  attr_accessible :content
  validates :user_id, presence: true
  validates :content, :presence => { :message => "Content can't be blank" }
  default_scope order: 'posts.created_at DESC'
  has_many :comments, dependent: :destroy
  belongs_to :user
end

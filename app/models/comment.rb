class Comment < ActiveRecord::Base
  attr_accessible :body
  default_scope order: 'comments.created_at DESC'
  belongs_to :post
end

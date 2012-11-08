class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id

  belongs_to :user
  validates :uid, :provider, :presence => true
  attr_accessor :raw

  def image
    self.raw["user_info"]["image"]
  rescue
  end
  def email
    self.raw["user_info"]["email"]
  rescue
  end
  def name
    self.raw["user_info"]["name"]
  rescue
  end

end





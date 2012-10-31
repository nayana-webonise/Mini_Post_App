class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id
  #belongs_to :user
  #
  #
  #
  #def apply_omniauth(auth)
  #  # In previous omniauth, 'user_info' was used in place of 'raw_info'
  #  self.email = auth['extra']['raw_info']['email']
  #  # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
  #  authentications.build(:provider => auth['provider'], :uid => auth['uid'], :user_id => auth['user_id'], :token => auth['credentials']['token'])
  #end

  belongs_to :user
  validates :uid, :provider, :presence => true
  attr_accessor :raw

  def email
    self.raw["user_info"]["email"]
  rescue
  end


end

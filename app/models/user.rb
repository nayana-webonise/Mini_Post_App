
require 'digest'
class User < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  self.per_page = 10
  attr_accessible :email, :name, :password, :password_confirmation, :image
  has_secure_password

  before_save { |user| user.email = email.downcase }

  #validates_presence_of :name
  #
  #validates :email,:presence => true
  #
  #validates :password, :presence => true
  #validates :password_confirmation,:presence => true

  has_many :posts, dependent: :destroy
  has_many :authentications, :dependent => :delete_all
  has_many :following, :through => :relationships, :source => "followed_id"
  has_many :relationships, :foreign_key => "follower_id",
           :dependent => :destroy

  has_many :following, :through => :relationships, :source => :followed


  has_many :reverse_relationships, :foreign_key => "followed_id",
           :class_name => "Relationship",
           :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower


  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  def feed
  Post.from_users_followed_by(self)
  end


  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.image =  auth['extra']['raw_info']['image']
    self.email = auth['extra']['raw_info']['email']
    self.name =  auth['extra']['raw_info']['name']

    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end


  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil


  end

end

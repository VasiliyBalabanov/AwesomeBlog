class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  #attr_accessor :password
  #before_save :encrypt_password
  after_save :welcome_mail
  
  validates :password, :presence => true, :length => {:minimum => 3}
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}, :length => {:minimum => 6}
  
#  def self.authenticate(email, password)
#    user = find_by_email(email)
#    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
#      user
#    else
#      nil
#    end
#  end
  
#  def encrypt_password
#    if password.present?
#      self.password_salt = BCrypt::Engine.generate_salt
#      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
#    end
#  end
  
  private
  
  def welcome_mail
    UserMailer.welcome(self).deliver
  end
end

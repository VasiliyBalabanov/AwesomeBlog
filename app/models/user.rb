class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  has_many :posts
  has_many :comments
  
  attr_accessor :password
  before_save :encrypt_password
  after_save :welcome_mail
  
  validates :password, :confirmation => true, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  private
  
  def welcome_mail
    UserMailer.welcome(self).deliver
  end
end

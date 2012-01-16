class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  after_save :welcome_mail
  
  validates :password, :presence => true, :length => {:minimum => 3}
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}, :length => {:minimum => 6}
  
  private
  
  def welcome_mail
    UserMailer.welcome(self).deliver
  end
end

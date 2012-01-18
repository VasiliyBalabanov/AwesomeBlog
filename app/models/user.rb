class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  before_create { generate_token(:auth_token) }
  before_update { generate_token(:auth_token) }
  after_create :welcome_mail
  before_save :admin
  
  validates :password, :presence => true, :length => {:minimum => 3}, :on => :create
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}, :length => {:minimum => 6}
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
     self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  private
  
  def admin
    if self.id == 1
      self.is_admin = true
    end
  end
  
  def welcome_mail
    UserMailer.welcome(self).deliver
  end
end

class Post < ActiveRecord::Base
  validates :user_id, :presence => true
  has_many :comments, :dependent => :destroy
  belongs_to :user
  scope :recent, order("created_at desc")
end

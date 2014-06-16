class User < ActiveRecord::Base
  has_secure_password
  has_many :projects

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true, email: true

  def fullname
    "#{firstname} #{lastname}"
  end
end
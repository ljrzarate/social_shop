class User < ActiveRecord::Base
  acts_as_voter
  acts_as_follower
  acts_as_followable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments
  has_many :events

  #validates_presence_of :name
end

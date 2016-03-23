class User < ActiveRecord::Base
  acts_as_voter
  acts_as_follower
  acts_as_followable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :authentications, dependent: :destroy

  #validates_presence_of :name
end

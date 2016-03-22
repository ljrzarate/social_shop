class Post < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create], owner: Proc.new{ |controller, model| controller.current_user }
  acts_as_votable
  acts_as_commentable

  belongs_to :user
  mount_uploader :attachment, AvatarUploader
end

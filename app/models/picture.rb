class Picture < ActiveRecord::Base
  belongs_to :picturable, polymorphic: true
  mount_uploader :image, AvatarUploader

  validates :image, presence: true
end

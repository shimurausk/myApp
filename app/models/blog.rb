class Blog < ActiveRecord::Base
	#has_many :comments,dependent: :destroy
	mount_uploader :avatar, AvatarUploader
	# don't forget those if you use :attr_accessible (delete method and form caching method are provided by Carrierwave and used by RailsAdmin)
  #attr_accessible :avatar, :avatar_cache, :remove_avatar
  #attr_accessible :title, :text, :avatar, :tag_list


	validates :title, presence: true,
					  length: { minimum: 6 }
end

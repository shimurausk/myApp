class Staff < ActiveRecord::Base
	has_many :works
	validates :name,presence: true
	validates :email,presence: true
	validates :address,presence: true
	validates :age,presence: true
	validates :hourlywage, presence: true

	mount_uploader :icon, AvatarUploader
end

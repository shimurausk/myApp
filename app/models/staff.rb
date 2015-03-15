class Staff < ActiveRecord::Base
	belongs_to :user
	has_many :works
	has_many :reservations, dependent: :destroy
	validates :name,presence: true
	validates :email,presence: true
	validates :address,presence: true
	validates :age,presence: true
	validates :hourlywage, presence: true

	mount_uploader :icon, AvatarUploader
end

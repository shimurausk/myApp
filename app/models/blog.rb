class Blog < ActiveRecord::Base
	has_many :comments,dependent: :destroy
	mount_uploader :avatar, AvatarUploader
	validates :title, presence: true,
				  length: { minimum: 6 }
  validates :category, presence: true
  has_many :taggings
  has_many :tags,through: :taggings

  def self.tagged_with(name)
  	Tag.find_by_name!(name).blogs
  end

  def self.tag_counts
    #binding.pry
  	Tag.select("tags.*,count(taggings.tag_id) as count").
  	joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
  	tags.map(&:name).join(", ")
  end

  def tag_list=(names)
  	self.tags = names.split(",").map do |n|
  		Tag.where(name: n.strip).first_or_create!
  	end	
  end

end

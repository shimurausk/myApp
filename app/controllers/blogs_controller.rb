class BlogsController < ApplicationController

	include ApplicationHelper
	before_action :get_category
	before_action :get_tags
	before_action :related_post

	def get_category
		binding.pry
		@blogs_hava_category = Blog.where(status:true)
		@blogs_category = []
		@blogs_hava_category.each do |c|
			@blogs_category.push(c.category)
		end 
		@blogs_category = @blogs_category.uniq()
	end

	def get_tags
		@blogs = Blog.all
		@blogs_tags = []

		@blogs.each do |blog|
			if blog.status == 'public'
				if(blog.tags.any?)
					blog.tags.each do |hadTag|
						#if blog.include?
						@blogs_tags.push(hadTag.name)
					end
				end

			end
		end
		@blogs_tags = @blogs_tags.uniq()
	end

	def category
		@categorys = Blog.where(category: params[:category])
	end

	def tag
		@tag = Tag.find_by_name(params[:tag]).blogs
	end

	def related_post
		@blog = Blog.all
	end

	def new
		@blog = Blog.new
		all_category
		all_tag
	end

	def create
		@blog = Blog.new(blogs_params)
		if @blog.save
			redirect_to @blog
		else
			all_category
			all_tag
			render 'new'
		end	
	end

	def show
		@blogs = Blog.new
		@blog = Blog.find(params[:id])
	end

	def index
		@blogs = Blog.all.order("id DESC")
		@tags = Tag.all
	end

	def edit
		@blog = Blog.find(params[:id])
		all_category
		all_tag
	end

	def update
		@blog = Blog.find(params[:id])

		if @blog.update(blogs_params)
			redirect_to @blog
		else
			all_category
			all_tag
			render "edit"
		end
	end

	def destroy
		@blog = Blog.find(params[:id])
		@blog.destroy if @blog.present?
		redirect_to blogs_path
	end

	private
		def blogs_params
			params.require(:blog).permit(:title,:text,:avatar,:category,:tag_list,:status)		
		end	

end

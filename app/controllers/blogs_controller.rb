class BlogsController < ApplicationController

	before_action :get_category
	before_action :get_tags
	before_action :related_post

	def get_category
		#@blogs_hava_category = Blog.where("category not?",nil)
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

		@blogs.each do |t|
			#raw d.tags.map(&:name).map { |t| link_to t, tag_path(d)}.join(', ')
			if(t.tags.any?)
				t.tags.each do |hadTag|
					@blogs_tags.push(hadTag.name)
				end
			end
			#t.tags.any? ? @blogs_tags.push(t.tags.map(&:name)) : ''
		end
		
		
		@blogs_tags = @blogs_tags.uniq()
	end

	def related_post
		@Recently =  Blog.where(created_at: Date.today<<6...Date.today)
	end

	def index
		@blogs = Blog.all.order("id DESC")
	end

	def show
		@blog = Blog.find(params[:id])
	end

	def category
		@categorys = Blog.where(category: params[:category])
	end

	def tag
		@tag = Tag.find_by_name(params[:tag]).blogs
	end

	# def create
	# 	@blog = Blog.new(blogs_params)

	# 	if @blog.save
	# 		redirect_to @blog
	# 	else
	# 		render 'new'
	# 	end	
	# end

	# def new
	# 	@blog = Blog.new
	# end

	# def edit
	# 	@blog = Blog.find(params[:id])
	# end

	# def update
	# 	@blog = Blog.find(params[:id])

	# 	if @blog.update(blogs_params)
	# 		redirect_to @blog
	# 	else
	# 		render "edit"
	# 	end
	# end

	# def destroy
	# 	@blog = Blog.find(params[:id])

	# 	@blog.destroy
	# 	redirect_to blogs_path
	# end

	private
		def blogs_params
			params.require(:blog).permit(:title,:text,:avatar,:tag_list)		
		end	

end

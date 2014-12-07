class BlogsController < ApplicationController

	before_action :get_category
	before_action :get_tags

	def get_category
		#@blogs_hava_category = Blog.where("category not?",nil)
		#binding.pry
		@blogs_hava_category = Blog.where(status:true)
		#binding.pry
		@blogs_category = []
		@blogs_hava_category.each do |c|
			@blogs_category.push(c.category)
		end 
		#binding.pry
		@blogs_category = @blogs_category.uniq()
	end

	def get_tags
		@blogs = Blog.all
		@blogs_tags = []

		@blogs.each do |t|
			#binding.pry
			#raw d.tags.map(&:name).map { |t| link_to t, tag_path(d)}.join(', ')
			if(t.tags.any?)
				t.tags.each do |hadTag|
					#binding.pry
					@blogs_tags.push(hadTag.name)
				end
			end
			#t.tags.any? ? @blogs_tags.push(t.tags.map(&:name)) : ''
		end
		
		#binding.pry
		@blogs_tags = @blogs_tags.uniq()
	end

	def related_post
		@blog = Blog.all
		
	end

	def index
		@blogs = Blog.all.order("id DESC")
		#binding.pry
	end

	def show
		@blog = Blog.find(params[:id])
		#binding.pry
	end

	def category
		@categorys = Blog.where(category: params[:category])
	end

	def tag
		@tag = Tag.find_by_name(params[:tag]).blogs
		#binding.pry
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

	def update
		@blog = Blog.find(params[:id])

		if @blog.update(blogs_params)
			redirect_to @blog
		else
			render "edit"
		end
	end

	def destroy
		@blog = Blog.find(params[:id])

		@blog.destroy
		redirect_to blogs_path
	end

	private
		def blogs_params
			params.require(:blog).permit(:title,:text,:avatar,:tag_list)		
		end	

end

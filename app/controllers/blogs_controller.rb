class BlogsController < ApplicationController

	before_action :get_category

	def get_category
		@blogs_hava_category = Blog.where("category not?",nil)

		@blogs_category = []
		@blogs_hava_category.each do |c|
			@blogs_category.push(c.category)
		end 
		#binding.pry
		@blogs_category = @blogs_category.uniq()
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

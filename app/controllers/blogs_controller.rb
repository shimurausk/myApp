class BlogsController < ApplicationController

	def index
		@blogs = Blog.all.order("id DESC")
		#binding.pry
		@blogs_hava_category = Blog.where("category not?",nil)
	end

	def show
		@blog = Blog.find(params[:id])
		#binding.pry
		@blogs_hava_category = Blog.where("category not?",nil)
	end

	def category
		#urlのパラメータに属するカラムを取得
		@categorys = Blog.where(category: params[:category])

		#binding.pry
		@blogs_hava_category = Blog.where("category not?",nil)
		#@blogs_hava_category.each do |c|
			#binding.pry
			#@blogs_category = c.category
		#end
		
		#@categorys = @blogs_hava_category.where(category: params[:category])
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
			params.require(:blog).permit(:title,:text,:avatar)		
		end	

end

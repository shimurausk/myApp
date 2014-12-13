class DashboardsController < ApplicationController
	def index
		@blogs = Blog.all.order("id DESC")
		#binding.pry
	end

	def show
		@blog = Blog.find(params[:id])
		#binding.pry
	end

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])

		if @blog.update(blogs_params)
			redirect_to @blog
		else
			render "edit"
		end
	end

	def create
		@blog = Blog.new(blogs_params)

		if @blog.save
			redirect_to @blog
		else
			render 'new'
		end	
	end

	def new
		@blog = Blog.new
	end

	def edit
		@blog = Blog.find(params[:id])
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

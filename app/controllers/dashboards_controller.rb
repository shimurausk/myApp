class DashboardsController < ApplicationController
	def index
		@work = Work.all
		@new_work = Work.new
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

	def confirm
		#入力チェック
  	@data = Work.new(dashboard_params)
  		
  	if @data.valid?
  		render :action => 'confirm'
  	else

  		@new_reservation = @data
  		render :action => 'new'
  	end
	end

	 private
		def blogs_params
			params.require(:blog).permit(:title,:text,:avatar,:tag_list)		
		end	
end

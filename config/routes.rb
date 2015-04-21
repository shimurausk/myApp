Rails.application.routes.draw do
  get 'pages/index'

  
  devise_for :users, :controllers => {
      :sessions => 'users/sessions',
      :passwords => 'users/passwords',
      :registrations => 'users/registrations'
    }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'



  # get 'blogs/dashboards', to:'dashboards#index' ,as: :dashboards
  # get 'blogs/dashboards/:id/edit', to:'dashboards#edit', as: :edit_dashboards
  # put 'blogs/dashboards/:id/', to:'dashboards#update', as: :update_dashboards
  # patch 'blogs/dashboards/:id/', to:'dashboards#update'
  # delete 'blogs/dashboards/:id/', to:'dashboards#destroy', as: :delete_dashboards

  # get 'blogs/dashboards', to:'dashboards#index' ,as: :dashboards
  # match 'blogs/dashboards/edit', :via => :get
  # match 'blogs/dashboards/update', :via => 'put'
  # match 'blogs/dashboards/delete',:via => 'delete'

  resources :blogs do
    resources :comments
    # member do 
    # end
  end

  #get 'blogs/:category' => 'blogs#index', as: :category
  #get 'blogs' , to:'blogs#index'
  #get 'blogs/:id' , to:'blogs#show', as: :blog
  get 'blogs/category/:category' , to:'blogs#category', as: :category
  get 'blogs/tag/:tag' , to:'blogs#tag', as: :tag

resources :staffs do
  resources :works
end

#match 'reservations/entry' ,:via => :post,as: :reservations_entry
#match 'reservations/search_result' ,:via => :post
match 'reservations/confirm' ,:via => :post
# match 'reservations/thanks' ,:via => :post
# post 'reservations/list/:day' ,to: 'reservations#list', as: :day
# get 'reservations/list/:day' ,to: 'reservations#list', as: :days
post 'reservations/list/' ,to: 'reservations#list'
get 'reservations/list/:day' ,to: 'reservations#list', as: :day
resources :reservations

#get 'dashboards/blog' ,to: 'dashboards_blog#blog'
get 'dashboards/blogs', to:'dashboards_blog#index' ,as: :dashboards_blog
get 'dashboards/blogs/:id/edit', to:'dashboards_blog#edit', as: :edit_dashboards_blog
put 'dashboards/blogs/:id/', to:'dashboards_blog#update', as: :update_dashboards_blog
patch 'dashboards/blogs/:id/', to:'dashboards_blog#update'
delete 'dashboards/blogs/:id/', to:'dashboards_blog#destroy', as: :delete_dashboards_blog

get 'dashboards/workday/:workday' ,to: 'dashboards#workday', as: :workday
match 'dashboards/confirm' ,:via => :post
resources :dashboards

get 'contacts' => 'contacts#index'
match 'contacts/confirm' ,:via => :post
match 'contacts/create' ,:via => :post

# Blog.all.each do |cat|
#   get "#{cat.category}" => 'blogs#view', :id => cat.id
# end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'pages#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

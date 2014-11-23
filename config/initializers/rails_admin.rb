RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)
 
  ## == Cancan ==
   config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  #rails_admin 
  #config.included_models = ['ActsAsTaggableOn::Tag'] 
  # config.model Blog do
  # list do
  #   #field :title
  #   field :tag_list
  # end

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # config.model 'Blog' do
  #   edit do
  #     field :tag_list, :ActsAsTaggableOn
  #   end
  # end
end

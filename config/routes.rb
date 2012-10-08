WetongjiWeb::Application.routes.draw do
  resources :versions

  post "information/approve"
  resources :information

  post "sensitives/batch_save"
  resources :sensitives

  get "organizer_registers/form_received"
  resources :organizer_registers

  post "exams/import"
  get "exams/upload"
  resources :exams

  mount Ckeditor::Engine => '/ckeditor'

  post "sele_courses/import"
  get "sele_courses/upload"
  resources :sele_courses

  post "courses/import"
  get "courses/upload"
  resources :courses

  resources :upload_files

  post "news/approve"
  resources :news

  resources :events

  resources :organizers

  devise_for :admins
  get "admins/select_role"
  get "admins/form_received"
  get "admins/register"
  resources :admins

  post "activities/approve"
  resources :activities

  resources :channels

  get "home/index"
  match "dashboard" => "home#index", :as => :admin_root

  resources :time_tables

  resources :teachers

  get "users/confirmation"
  get "users/welcome"
  get "users/reset_password_from_mail"
  post "users/reset_password"
  get "users/reset_password_success"
  get "users/reconfirm"
  get "users/send_reset_password_mail"
  get "users/reconfirm_all"
  post "users/batch_save"
  resources :users

  post "students/import"
  get "students/upload"
  resources :students



  get 'api/test'
  get 'api/call'
  post 'api/call'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

Waito::Application.routes.draw do
  resources :pins, only: :destroy
  resources :flags, only: :destroy
  resources :comments, only: :destroy
  get 'comments/:comment_id/reply_form', to: 'comments#new', as: 'load_reply_form'
  post 'comments/:comment_id/reply', to: 'comments#create', as: 'comment_reply'
  put 'comments/:comment_id/vote', to: 'reputations#update', as: 'comment_vote'
  put 'posts/:post_id/vote', to: 'reputations#update', as: 'post_vote'
  get 'tag_add', to: 'tag_search#show', as: 'tag_add'
  get 'tag_search', to: 'tag_search#index', as: 'tag_search'
  resources :tags
  resources :posts do
    resources :pins, only: :create
    resources :flags, only: :create
    resources :comments, only: [:create, :index]
  end

  resources :faqs, only: [:index, :create, :update]
  resources :suggestions
  resources :support_tickets, only: [:index, :create, :new, :update]
  get 'support', to: 'support_tickets#new'
  get 'forgot_password', to: 'password_resets#new', as: 'forgot_password'
  resources :password_resets, only: [:new, :create, :edit, :update]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions, only: [:new, :create, :destroy]
  get 'username_check' => 'username_check#index'
  get 'signup' => "users#new"
  resources :users do
    put 'update_avatar', on: :member
  end

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

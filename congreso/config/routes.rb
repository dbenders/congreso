Congreso::Application.routes.draw do

  namespace :admin do
    resources :chambers
    resources :parties
    resources :sessions do
      resources :text_bookmarks do
        get 'rebuild', :on => :collection
        get 'retag', :on => :collection
        get 'up'
        get 'down'
        get 'transcript'      
        get 'merge_up'
      end
      resources :bookmarks do
        get 'match', :on => :collection
        get 'toggle_matchtyp'
      end   
    end    
    resources :you_tube_videos    
    resources :provinces do
      get 'merge', :on => :collection
    end
  end

  resources :people, :path => 'legisladores' do
    get 'card'
  end

  root :to => 'chambers#index'

  #match 'legisladores' => 'people#index', :as => :pretty_people
  match '~:id' => 'people#show', :as => :person
  match '~:id/card' => 'people#card', :as => :person_card
  match ':id' => 'chambers#show', :as => :chamber
  match ':chamber_name/:period/:meeting' => 'sessions#show', :as => :session
  match ':chamber_name/:period/:meeting/tbk/:text_bookmark_id' => 'text_bookmarks#transcript', :as => :session_text_bookmark_transcript



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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

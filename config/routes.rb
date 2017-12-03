Rails.application.routes.draw do
  devise_for :tutors, controllers: {
      sessions: 'tutor/sessions'
  }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :students, only: [:index, :new, :create]
  get 'history_entries' => 'history_entries#show', as: :history_entries
  get 'history_entries/:id' => 'history_entries#get_report', as: :history_report
  
  resources :student_requests, only: [:index, :destroy]
  resources :tutors, only: [:index]
  patch 'tutors/:id/activate_session' => 'tutors#activate_session', as: :tutor_activate_session
  patch 'tutors/:id/finish_session' => 'tutors#finish_session', as: :tutor_finish_session
  patch 'tutors/check_in' => 'tutors#check_in', as: :tutor_check_in
  patch 'tutors/check_out' => 'tutors#check_out', as: :tutor_check_out

  root 'students#new'
  # get 'students/:id/sign_in' => 'students#sign_in', as: :sign_in_student
  get 'student_requests/:id/wait_time' => 'student_requests#wait_time', as: :wait_time_student_request
  get 'student_requests/:id/confirm' => 'student_requests#confirm', as: :confirm_student_request
  # get 'student_requests/:id/remove' => 'student_requests#remove', as: :remove_student_request

  #security routes
  post 'app_login' => 'app_security#authenticate', as: :app_authenticate
  get 'app_login' => 'app_security#show', as: :app_firewall
  post 'app_logout' => 'app_security#logout', as: :app_logout

  # get 'tutor_login' => 'tutor_security#show', as: :tutor_firewall
  # post 'tutor_login' => 'tutor_security#authenticate', as: :tutor_authenticate
  # post 'tutor_logout' => 'tutor_security#logout', as: :tutor_logout

  #the following routes exist to allow for redirects to *#create methods since redirec_to only
  #issues redirects to controller actions that have the GET http verb.
  # get 'student_requests/:id/create' => 'student_requests#create', as: :create_student_request
  #
  # patch 'student_requests/:id/activate_session' => 'student_requests#activate_session', as: :activate_session
  # patch 'student_requests/:id/finish_session' => 'student_requests#finish_session', as: :finish_session

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

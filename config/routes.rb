Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :students do
    resources :drop_in_histories
    resources :weekly_appointments
    resources :scheduled_appointments
  end


  resources :student_queues


  root 'students#new'
  get 'students/:id/sign_in' => 'students#sign_in', as: :sign_in_student
  get 'student_queues/:id/wait_time' => 'student_queues#wait_time', as: :wait_time_student_queue
  get 'student_queues/:id/confirm' => 'student_queues#confirm', as: :confirm_student_queue
  get 'student_queues/:id/remove' => 'student_queues#remove', as: :remove_student_queue

  #security routes
  get 'app_login' => 'app_security#show', as: :app_firewall_path
  get 'tutor_login' => 'tutor_security#show', as: :tutor_firewall_path

  #the following routes exist to allow for redirects to *#create methods since redirec_to only
  #issues redirects to controller actions that have the GET http verb.
  get 'student_queues/:id/create' => 'student_queues#create', as: :create_student_queue
  get '/students/:student_id/scheduled_appointments/create' => 'scheduled_appointments#create',
      as: :create_student_scheduled_appointment
  get '/students/:student_id/weekly_appointments/create' => 'weekly_appointment#create',
      as: :create_student_weekly_appointment


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

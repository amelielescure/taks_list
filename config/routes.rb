TasksList::Application.routes.draw do
  root "tasks#index"
  resources :tasks do
    member do
      post 'postpone'
    end
  end
end

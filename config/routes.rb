Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "courses#index"

  namespace :admin do
    root to: "courses#index"
    resources :courses, only: [:index, :show] do
      put :approved, on: :member
    end
  end

  resources :courses do
    resources :interested_courses, only: [:create, :update, :index]
    resources :comments
  end


end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      post 'login' => "authentication#login"

      resources :posts do
        resources :comments
      end
    end
  end

end

Siftpro::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => "logout" }, :path => ""

  resources :universities, only: [:new, :create]
  
  get "/signup" => "universities#new"
  get "/features"  => "static#features"
  get "/pricing"  => "static#pricing"
  
  authenticated :user do
    resources :issues, only: [:index, :show]
    resources :sports, except: :show
    resources :universities, except: [:new, :create, :index, :show]
    resources :athletes, except: :show do
      member do
        get "authorize"
        get "callback"
        get "tweet"
        post "post"
      end
    end  
    resources :blacklists, except: :show
    resources :users, only: [:index, :destroy]
    root to: "dashboard#index"
  end
  
  root to: "static#home"
end

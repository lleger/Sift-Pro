Siftpro::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => "logout" }, :path => ""

  resources :universities, only: [:new, :create]
  
  get "/signup" => "universities#new"
  get "/features"  => "static#features"
  get "/pricing"  => "static#pricing"

  root to: "static#home"

  authenticate :user do
    resources :issues, only: [:index, :show]
    resources :sports
    resources :universities, except: [:new, :create]
    resources :athletes do
      member do
        get "authorize"
        get "callback"
        get "tweet"
        post "post"
      end
    end    
    root to: "issues#index"
  end
end

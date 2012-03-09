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
    resources :blacklists, except: :show
    resources :users
    scope "twitter" do
      get "authorize" => "twitter#authorize"
      get "callback" => "twitter#callback"
      post "post" => "twitter#post"
    end
    root to: "dashboard#index"
  end
  
  root to: "static#home"
end

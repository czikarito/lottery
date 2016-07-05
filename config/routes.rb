Rails.application.routes.draw do
  resources :bids
  devise_for :users
  resources :items do
    collection do
      match 'search' => 'items#search', via: [:get, :post], as: :search
    end

  end

  root 'items#index'

  resources :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  #post 'bind/index'
end

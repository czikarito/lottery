Rails.application.routes.draw do
  resources :bids
  devise_for :users
  resources :items do
    collection do
      match 'search' => 'items#search', via: [:get, :post], as: :search
    end
    member do
      post 'draw'
    end
  end

  root 'items#index'

  resources :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # devise_scope :user do
  #
  # end
  get 'main/index'
  get 'auctions/index'
end

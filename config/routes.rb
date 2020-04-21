Rails.application.routes.draw do
  get 'provinces/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  constraints ->(request) { request.format == :json } do
    scope "/categories" do
      get "", to: "categories#index"
      get "/:id/products", to: "products#by_category_id"
      get "/:id/products/onSale", to: "products#on_sale" # use query string?
      get "/:id/products/new", to: "products#new"
      get "/:id/products/recUpdated", to: "products#recently_updated"
    end

    scope "/products" do
      get "/:id", to: "products#show"
    end

    get "/search", to: "products#search"
  end

  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/logged_in", to: "sessions#is_logged_in?"
  resources :users, only: %i[create show]

  get "/provinces", to: "provinces#index"
end

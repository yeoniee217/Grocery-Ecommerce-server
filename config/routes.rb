Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  constraints ->(request) { request.format == :json } do
    scope "/categories" do
      get "/all_categories", to: "categories#all_categories"
    end

    scope "/products" do
      get "/by_category_id/:id", to: "products#by_category_id"
    end
  end
end

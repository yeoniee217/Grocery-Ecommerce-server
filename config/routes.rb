Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope "/categories" do
    get "/all_categories", to: "categories#all_categories"
  end
end

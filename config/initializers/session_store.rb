if Rails.env === "production"
  Rails.application.config.session_store :cookie_store, key: "_grocery-ecommerce", domain: "your-frontend-domain"
else
  Rails.application.config.session_store :cookie_store, key: "_grocery-ecommerce"
end

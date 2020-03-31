class ApplicationController < ActionController::Base
  # Disable the web-based CSRF protection.
  protect_from_forgery with: :null_session
end

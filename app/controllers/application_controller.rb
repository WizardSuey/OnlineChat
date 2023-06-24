class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] 
    end

    def require_user_logged_in!
        redirect_to sign_up_path if current_user.nil?
    end
end

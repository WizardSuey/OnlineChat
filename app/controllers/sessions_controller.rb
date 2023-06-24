class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email])

        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path
        else
            flash[:alert]
            render :new
        end
    end

    def destroy
        ActionCable.server.remote_connections.where(current_user: current_user).disconnect
        current_user.update(status: User.statuses[:offline])
        session[:user_id] = nil
        redirect_to root_path
    end
end

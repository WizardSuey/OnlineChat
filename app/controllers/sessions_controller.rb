class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email])

        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Вы успешно вошли!"
        else
            flash[:alert] = "Неверная почта или пароль!"
            render :new
        end
    end

    
    
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Вы успешно вышли!"
    end
end

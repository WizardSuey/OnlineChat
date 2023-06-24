class UsersController < ApplicationController
    before_action :require_user_logged_in!

    def show 
        @user = User.find(params[:id])
        @users = User.all_except(current_user)

        @room = Room.new
        @rooms = Room.public_rooms
        @room_name = get_name(@user, current_user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(changed_at: :asc)
        render 'rooms/index'
    end

    def edit
    end

    def update
        if current_user.update(user_params)
            redirect_to root_path
        else
            render :edit
        end
    end

    private 
    def get_name(user1, user2)
        user = [user1, user2].sort
        "private_#{user[0].id}_#{user[1].id}"
    end

    def user_params
        params.require(:user).permit(:avatar, :password_digest)
    end
end

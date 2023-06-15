class UsersController < ApplicationController
    before_action :require_user_logged_in!

    def show 
        @user = User.find(params[:id])
        @users = User.all_except(Current.user)

        @room = Room.new
        @rooms = Room.public_rooms
        @room_name = get_name(@user, Current.user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, Current.user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(changed_at: :asc)
        render 'rooms/index'
    end

    private 
    def get_name(user1, user2)
        user = [user1, user2].sort
        "private_#{user[0].id}_#{user[1].id}"
    end
end

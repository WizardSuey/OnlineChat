class RoomsController < ApplicationController
    before_action :require_user_logged_in!
    before_action :set_status
  
    def index
      @room = Room.new
      @rooms = Room.public_rooms
  
      @users = User.where.not(id: current_user.id)
      render 'index'
    end
  
    def show
      @single_room = Room.find(params[:id])
  
      @room = Room.new
      @rooms = Room.public_rooms
  
      @message = Message.new
      @messages = @single_room.messages.order(created_at: :asc)
  
      @users = User.where.not(id: current_user.id)
      render 'index'
    end
  
    def create
      @room = Room.create(name: params['room']['name'])
    end

    private

    def set_status
      current_user.update!(status: User.statuses[:online]) if current_user
    end
end
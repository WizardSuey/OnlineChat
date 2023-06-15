class RoomsController < ApplicationController
    before_action :require_user_logged_in!
  
    def index
      @room = Room.new
      @rooms = Room.public_rooms
  
      @users = User.where.not(id: Current.user.id)
      render 'index'
    end
  
    def show
      @single_room = Room.find(params[:id])
  
      @room = Room.new
      @rooms = Room.public_rooms
  
      @message = Message.new
      @messages = @single_room.messages.order(created_at: :asc)
  
      @users = User.where.not(id: Current.user.id)
      render 'index'
    end
  
    def create
      @room = Room.create(name: params['room']['name'])
    end
  end
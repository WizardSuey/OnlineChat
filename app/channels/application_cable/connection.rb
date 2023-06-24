module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_current_user
    end

    private

    def find_current_user
      user_id = cookies.signed[:user_id]
      User.find_by(id: user_id)
    end
  end
end
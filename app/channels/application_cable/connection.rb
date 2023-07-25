module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      puts request
      self.current_user = find_verified_user request.params[:token]
    end

    def find_verified_user token
      decoded_auth_token = JsonWebToken.decode(token) if token
      user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      if user
        return user
      else
        return reject_unauthorized_connection
      end
    end
  end
end

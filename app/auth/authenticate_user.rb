class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  #this is where parameters are taken when the command is called
  def initialize(email, password)
    @email = email
    @password = password
  end

  #this is where the result gets returned
  def call
    user
  end

  private

  def user
    user = User.find_by_email(email)

    if user
      if user.authenticate(password)
        return user
      else
        errors.add :user_authentication, 'Wrong Password'
      end
    else
      @newUser = User.create(email: email, password: password)
      if @newUser.save
        return @newUser
      else
        errors.add :bad, 'Fail to register'
      end
    end
    nil

    # return user if user && user.authenticate(password)

    # errors.add :user_authentication, 'Invalid credentials'
    # nil
  end
end

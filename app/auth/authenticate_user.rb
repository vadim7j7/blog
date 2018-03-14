module Auth
  class AuthenticateUser
    prepend SimpleCommand
    attr_accessor :email, :password

    # This is where parameters are taken when the command is called
    def initialize(email, password)
      @email    = email
      @password = password
    end

    # This is where the result gets returned
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end

    private

    def user
      user = User.find_by_email(email)
      return user if user&.authenticate(password)

      errors.add(:user_authentication, I18n.t('auth.errors.invalid_credentials'))

      nil
    end
  end
end

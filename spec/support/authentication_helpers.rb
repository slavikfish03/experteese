module AuthenticationHelpers
  def sign_in_as(user, password: "222222")
    post login_path, params: {
      session: {
        email: user.email,
        password: password
      }
    }
  end
end

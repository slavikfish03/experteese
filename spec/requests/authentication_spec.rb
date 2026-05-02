require "rails_helper"

RSpec.describe "Authentication" do
  it "registers a new user" do
    expect do
      post users_path, params: {
        user: {
          name: "RSpec User",
          email: "rspec@example.com",
          password: "222222",
          password_confirmation: "222222"
        }
      }
    end.to change(User, :count).by(1)

    expect(response).to redirect_to(user_path(User.find_by!(email: "rspec@example.com"), locale: :en))
  end

  it "signs in and signs out" do
    sign_in_as users(:one)
    expect(response).to redirect_to(work_url(locale: :en))

    delete logout_path
    expect(response).to redirect_to(root_url(locale: :en))
  end
end

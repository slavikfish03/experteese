require "rails_helper"

RSpec.describe User do
  subject(:user) do
    described_class.new(
      name: "Valid User",
      email: "valid@example.com",
      password: "222222",
      password_confirmation: "222222"
    )
  end

  it "is valid with name, email, and matching password" do
    expect(user).to be_valid
  end

  it "normalizes email before saving" do
    user.email = "MixedCase@Example.COM"
    user.save!

    expect(user.email).to eq("mixedcase@example.com")
  end

  it "rejects invalid email" do
    user.email = "invalid-email"

    expect(user).not_to be_valid
  end

  it "rejects duplicate email case-insensitively" do
    user.email = users(:one).email.upcase

    expect(user).not_to be_valid
  end

  it "requires a password with at least six characters" do
    user.password = "12345"
    user.password_confirmation = "12345"

    expect(user).not_to be_valid
  end
end

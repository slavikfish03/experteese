require "rails_helper"

RSpec.describe Theme do
  it "has many images" do
    expect(themes(:one).images).to include(images(:one))
  end

  it "requires a unique name" do
    theme = described_class.new(name: themes(:one).name)

    expect(theme).not_to be_valid
  end

  it "finds a theme id by name" do
    expect(described_class.find_theme_id(themes(:one).name)).to eq(themes(:one).id)
  end
end

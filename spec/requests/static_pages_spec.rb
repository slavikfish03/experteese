require "rails_helper"

RSpec.describe "Static pages" do
  it "renders public pages" do
    get root_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Experteese")

    get help_path
    expect(response).to have_http_status(:ok)

    get about_path
    expect(response).to have_http_status(:ok)

    get contacts_path
    expect(response).to have_http_status(:ok)
  end

  it "switches locale through request params" do
    get root_path, params: { locale: :ru }

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Рабочая среда")
  end
end

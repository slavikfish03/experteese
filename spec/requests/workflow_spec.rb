require "rails_helper"

RSpec.describe "Expert workflow" do
  it "renders the work area" do
    get work_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Image rating")
  end

  it "localizes seed theme names on the work page" do
    theme = Theme.create!(
      name: "Which Renoir work best characterizes his artistic style?"
    )
    Image.create!(
      name: "Renoir Test Image",
      file: "renoir_bouquet.jpg",
      theme: theme,
      ave_value: 0
    )

    get work_path(locale: :ru, theme_id: theme.id)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Какое произведение Ренуара")
    expect(response.body).not_to include("Which Renoir work")
  end

  it "blocks anonymous rating submission" do
    expect do
      post values_path, params: { image_id: images(:two).id, value: 85 }
    end.not_to change(Value, :count)

    expect(response).to redirect_to(login_url(locale: :en))
  end

  it "allows signed-in users to submit a rating" do
    sign_in_as users(:one)

    expect do
      post values_path, params: { image_id: images(:two).id, value: 85 }
    end.to change(Value, :count).by(1)

    expect(response).to redirect_to(work_url(locale: :en, theme_id: images(:two).theme_id))
  end

  it "localizes duplicate rating alerts" do
    post login_path(locale: :ru), params: {
      session: {
        email: users(:one).email,
        password: "222222"
      }
    }

    expect do
      post values_path(locale: :ru), params: { image_id: images(:one).id, value: 90 }
    end.not_to change(Value, :count)

    follow_redirect!

    expect(response.body).to include("Вы уже оценили это изображение.")
  end

  it "returns image navigation json" do
    get api_next_image_path, params: { theme_id: themes(:one).id, index: 0 }

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to include("status" => "success")
  end

  it "shows personal rating statistics" do
    images(:one).update!(ave_value: 50)
    sign_in_as users(:one)

    get user_path(users(:one))

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Rating history")
    expect(response.body).to include("Ratings within 25% of image average")
  end
end

Theme.find_or_create_by!(name: "-----")

themes = {
  renoir: Theme.find_or_create_by!(
    name: "Which Renoir work best characterizes his artistic style?"
  ),
  picasso: Theme.find_or_create_by!(
    name: "Which Picasso work best characterizes his artistic style?"
  ),
  matisse: Theme.find_or_create_by!(
    name: "Which Matisse work best characterizes his artistic style?"
  )
}

[
  [ "P.-A. Renoir, Ball at the Moulin de la Galette", "renoir_moulin.jpg", themes[:renoir] ],
  [ "P.-A. Renoir, Bouquet", "renoir_bouquet.jpg", themes[:renoir] ],
  [ "P.-A. Renoir, Boating Party", "renoir_boating_party.jpg", themes[:renoir] ],
  [ "P.-A. Renoir, Garden Scene", "renoir_garden.jpg", themes[:renoir] ],
  [ "P. Picasso, Factory", "picasso_factory.jpg", themes[:picasso] ],
  [ "P. Picasso, Guitar", "picasso_guitar.jpg", themes[:picasso] ],
  [ "P. Picasso, Blue Study", "picasso_blue_study.jpg", themes[:picasso] ],
  [ "P. Picasso, Studio Figure", "picasso_studio_figure.jpg", themes[:picasso] ],
  [ "H. Matisse, Dancer", "matisse_dancer.jpg", themes[:matisse] ],
  [ "H. Matisse, Red Room", "matisse_red_room.jpg", themes[:matisse] ],
  [ "H. Matisse, Open Window", "matisse_open_window.jpg", themes[:matisse] ],
  [ "H. Matisse, Paper Cutout", "matisse_paper_cutout.jpg", themes[:matisse] ]
].each do |name, file, theme|
  image = Image.find_or_initialize_by(file: file)
  image.update!(name: name, theme: theme, ave_value: image.ave_value || 0)
end

user = User.find_or_initialize_by(email: "example@railstutorial.org")
user.name = "Example User"
user.password = "222222"
user.password_confirmation = "222222"
user.save!

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

password = 'qwert123'

Category.create!([
  {:name => 'Sci-Fi & Fantasy'},
  {:name => 'Romance'},
  {:name => 'History'},
  {:name => 'Computer & Technology'},
  {:name => 'Science & Math'},
  {:name => 'Literature & Fiction'}
])

sf_fantasy = Category.find_by(:name => 'Sci-Fi & Fantasy')
history = Category.find_by(:name => 'History')
comp_tech = Category.find_by(:name => 'Computer & Technology')
math = Category.find_by(:name => 'Science & Math')

User.create!([
  {:email => 'mcbride@example.com', :password => password},
  {:email => 'william@example.com', :password => password},
  {:email => 'brian@example.com', :password => password},
  {:email => 'admin@admin.com', :password => 'Admin123', :admin => true}
])

mcbride = User.first
william = User.second
brian = User.third


mcbride.books.create!(
  :title => 'Harry Potter and the Goblet of Fire',
  :description => "Next level fanny pack roof party, 8-bit man braid hammock selvage hella. Mixtape hella try-hard, occupy shoreditch everyday carry banh mi you probably haven't heard of them meditation pickled. Poutine semiotics bitters tumblr put a bird on it, helvetica scenester chambray freegan synth tilde disrupt. Banjo skateboard tousled raw denim man bun meh. Meh fap microdosing, knausgaard biodiesel put a bird on it franzen seitan intelligentsia selfies beard etsy. Crucifix plaid 8-bit microdosing venmo selfies sriracha, keytar meggings celiac. Kale chips YOLO man braid fixie roof party.",
  :author => "J.K. Rowling",
  :category_id => sf_fantasy.id,
  :book_img => File.open("./app/assets/images/covers/hp_goblet_of_fire.jpg", 'r')
)

mcbride.books.create!(
  :title => 'Harry Potter and the Chamber of Secrets',
  :description => "Jean shorts kogi 90's, DIY yr affogato trust fund fanny pack hoodie fashion axe you probably haven't heard of them bicycle rights banjo skateboard. Quinoa cornhole pop-up, leggings cardigan twee craft beer DIY vinyl organic knausgaard. Sartorial keffiyeh messenger bag, williamsburg kombucha raw denim polaroid authentic. Godard pop-up etsy, microdosing kogi fixie bespoke raw denim. Shabby chic distillery ramps jean shorts pabst freegan. Disrupt franzen poutine microdosing. Sustainable messenger bag banh mi letterpress pickled chillwave, schlitz man bun tilde.",
  :author => "J.K. Rowling",
  :category_id => sf_fantasy.id,
  :book_img => File.open('./app/assets/images/covers/hp_chamber_secrets.jpeg', 'r')
)

william.books.create!(
  :title => 'Secret Lives of the First Ladies',
  :description => "Sint echo park cred, qui lumbersexual vegan tilde lo-fi id. Helvetica twee chia, swag kitsch pour-over sint aliqua. Tilde jean shorts laborum, trust fund magna aesthetic polaroid tofu bespoke hashtag. Waistcoat franzen narwhal, dolore tilde nostrud et ex lumbersexual authentic knausgaard accusamus gochujang chia church-key. Lumbersexual distillery shabby chic sint williamsburg dreamcatcher flexitarian. Chambray wolf kickstarter pork belly wayfarers. Lomo kogi vegan laborum church-key tattooed.",
  :author => "Cormac O'Brien, Monika Suteski",
  :category_id => history.id,
  :book_img => File.open("./app/assets/images/covers/secret_lives.jpeg", 'r')
)

william.books.create!(
  :title => 'Automate the Boring Stuff with Python: Practical Programming for Total Beginners',
  :description => "Paleo drinking vinegar fanny pack PBR&B, butcher tacos aesthetic dreamcatcher cred tumblr godard before they sold out pour-over. Artisan crucifix humblebrag chia, drinking vinegar craft beer hashtag kickstarter PBR&B green juice kitsch. Beard street art occupy post-ironic. Tote bag viral master cleanse chambray. +1 letterpress bicycle rights, blog irony tote bag fingerstache pug photo booth kitsch 3 wolf moon health goth. Etsy typewriter hashtag banh mi fixie green juice church-key thundercats gochujang YOLO four dollar toast, irony cold-pressed pug celiac. Master cleanse retro tilde, austin food truck selvage keytar.",
  :author => "Al Sweigart",
  :category_id => comp_tech.id,
  :book_img => File.open('./app/assets/images/covers/automate_python.jpg', 'r')
)

brian.books.create!(
  :title => 'Elementary Statistics',
  :description => "Mixtape do excepteur, pork belly vinyl godard photo booth hoodie tote bag distillery gentrify quinoa consectetur paleo. Waistcoat tofu actually offal microdosing. Mumblecore placeat neutra asymmetrical nesciunt. Biodiesel cornhole man bun, knausgaard neutra tumblr delectus food truck health goth vero freegan leggings cray. Sunt YOLO microdosing whatever, ethical selfies echo park pour-over 90's. Hammock keytar sint cronut you probably haven't heard of them. Meditation culpa exercitation mustache, truffaut hashtag occupy schlitz tacos consectetur direct YOLO photo booth.",
  :author => 'Mario F. Triola',
  :category_id => math.id,
  :book_img => File.open('./app/assets/images/covers/elementary_stats.jpg', 'r')
)

Book.first.reviews.create!(
  :rating => 5,
  :comment => "Best book I have ever read.",
  :user_id => mcbride.id
)

Book.first.reviews.create!(
  :rating => 3,
  :comment => "Not my style!",
  :user_id => william.id
)

Book.last.reviews.create!(
  :rating => 5,
  :comment => 'Must-read book',
  :user_id => brian.id
)

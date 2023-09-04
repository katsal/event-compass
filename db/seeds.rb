require 'nokogiri'
require 'open-uri'
require 'faker'
require 'json'

run_start_time = Time.now

puts "Starting seed process at #{run_start_time}"

Message.destroy_all
List.destroy_all
User.destroy_all
Event.destroy_all
Category.destroy_all
puts "Destroyed Users and Lists and Events!"

barry_acc = User.new(
  email: "Barry@eventcompass.com",
  password: "password1",
  name: "Barry",
  location: "location One",
  introduction: "We are the admins",
  admin: true
)

# # photo_url = "https://avatars.githubusercontent.com/u/138180537?v=4"
# # file = URI.open(photo_url)
# # barry_acc.user_img.attach(io: file, filename: 'user.jpeg', content_type: "image/jpeg")
barry_acc.save!

karthika_acc = User.new(
  email: "karthika@eventcompass.com",
  password: "password2",
  name: "Karthika",
  location: "location Two",
  introduction: "We are the admins",
  admin: true
)

# # photo_url = "https://avatars.githubusercontent.com/u/129238177?v=4"
# # file = URI.open(photo_url)
# # karthika_acc.user_img.attach(io: file, filename: 'user.jpeg', content_type: "image/jpeg")
karthika_acc.save!

caitlyn_acc = User.new(
  email: "Caitlyn@eventcompass.com",
  password: "password3",
  name: "Caitlyn",
  location: "location Three",
  introduction: "We are the admins",
  admin: true
)


# # photo_url = "https://avatars.githubusercontent.com/u/138352657?v=4"
# # file = URI.open(photo_url)
# # caitlyn_acc.user_img.attach(io: file, filename: 'user.jpeg', content_type: "image/jpeg")
caitlyn_acc.save!

kostas_acc = User.new(
  email: "Kostas@eventcompass.com",
  password: "password4",
  name: "Kostas",
  location: "location Four",
  introduction: "We are the admins",
  admin: true
)

# # photo_url = "https://avatars.githubusercontent.com/u/133198548?v=4"
# # file = URI.open(photo_url)
# # kostas_acc.user_img.attach(io: file, filename: 'user.jpeg', content_type: "image/jpeg")
kostas_acc.save!

intros = [
  "Greetings, fellow wanderers! Exploring the world is my passion.",
  "Hello there! Embracing the beauty of cultures and landscapes fuels my journey.",
  "Hey, adventurers! On a quest to uncover hidden treasures across the globe.",
  "Salutations, fellow explorers! Join me in chasing sunsets and stories.",
  "Hey, curious souls! I'm here to immerse in new experiences and share tales.",
  "Greetings from a travel enthusiast! Every destination has a story to tell.",
  "Hello, fellow wayfarers! Finding joy in connecting with people and places.",
  "Heya, seekers of adventure! Curiosity drives me to roam, learn, and evolve.",
  "Hello, fellow adventurers! Capturing moments and memories as I roam.",
  "Greetings, fellow explorers! Each journey is a canvas for unforgettable experiences.",
  "Hey there, wanderers! Savoring the diversity of cultures and embracing the unknown.",
  "Greetings, fellow nomads! Sharing my tales and discoveries along the way.",
  "Hello, fellow travelers! Navigating the world with an open heart and an open mind.",
  "Hey, curious travelers! Seeking connection and inspiration through my journeys.",
  "Hello, fellow seekers! Finding magic in the unexplored corners of the world.",
  "Greetings, fellow wayfarers! Nurturing my love for exploration and human connection.",
  "Hello, kindred spirits! Embarking on a lifelong adventure of growth and discovery.",
  "Hey, fellow adventurers! Charting my course through diverse landscapes and cultures.",
  "Hello, fellow souls! Weaving stories of my journeys to inspire and connect.",
  "Greetings, fellow explorers of life! Celebrating the tapestry of our global village.",
  "Greetings, fellow adventurers! Ready to uncover the world's mysteries?",
  "Hello, curious minds! Exploring far and wide, one journey at a time.",
  "Hey there, fellow seekers! Discovering new horizons is my ultimate thrill.",
  "Salutations, explorers of life! Every destination is an opportunity to grow.",
  "Hey, fellow wayfarers! Let's create stories that span continents and cultures.",
  "Greetings, kindred wanderers! Embracing the unknown with open arms.",
  "Hello, fellow travelers! Captivated by the allure of diverse landscapes.",
  "Hey, fellow explorers! Join me in the pursuit of awe and inspiration.",
  "Greetings, fellow wanderlusters! Unveiling the world's beauty through my lens.",
  "Hello, fellow nomads! Journeying to find my place in the global mosaic.",
  "Hey there, fellow adventurers! Navigating life with a heart full of wanderlust.",
  "Greetings, fellow souls! Sharing my path of discovery with the world.",
  "Hello, kindred spirits! Embracing serendipity and forging connections.",
  "Hey, fellow wayfarers! Curating experiences that shape my identity.",
  "Greetings, fellow travelers! Celebrating the rich tapestry of humanity.",
  "Hello, fellow seekers! Chasing dreams and collecting stories along the way.",
  "Hey, adventurers at heart! Crafting memories across borders and boundaries.",
  "Greetings, curious explorers! Every journey is a lesson in perspective.",
  "Hello, fellow dreamers! Weaving the threads of culture into my narrative.",
  "Hey there, fellow wanderers! Writing a story that transcends borders.",
  "Salutations, kindred adventurers! My compass leads me to the essence of places.",
  "Greetings, fellow wanderers! Let's traverse the globe, one adventure at a time.",
  "Hello, curious souls! Embarking on a journey to discover the world's tapestry.",
  "Hey there, fellow explorers! Unveiling the beauty and depth of different cultures.",
  "Salutations, kindred spirits! Seeking stories and memories in every corner.",
  "Hey, fellow adventurers! Connecting with diverse landscapes and people.",
  "Greetings, fellow travelers! Fueled by wanderlust and a heart full of dreams.",
  "Hello, fellow wanderlusters! On a mission to fill my life with experiences.",
  "Hey there, explorers at heart! Navigating the world with wonder and curiosity.",
  "Salutations, fellow seekers! Enriching my life through global perspectives.",
  "Greetings, kindred wayfarers! Carving a path through the unknown and unexpected.",
  "Hello, fellow nomads! Infusing every journey with a spirit of discovery.",
  "Hey, fellow travelers of life! Embracing the challenges and beauty of the road.",
  "Salutations, curious minds! Mapping my journey through stories and memories.",
  "Greetings, fellow adventurers! Celebrating diversity and connection through travel.",
  "Hello, fellow explorers! Capturing moments that become the chapters of my story.",
  "Hey there, fellow souls! Embracing the unfamiliar to nurture personal growth.",
  "Salutations, kindred wanderers! My travels are a canvas for inspiration and growth.",
  "Greetings, fellow seekers! Each journey a step toward self-discovery and wonder.",
  "Hello, fellow dreamers! Curating experiences that shape my sense of belonging.",
  "Hey, fellow adventurers! Finding purpose in the pursuit of new horizons."
]

100.times do
  email = Faker::Internet.unique.email
  name = Faker::Name.unique.name
  introduction = intros.sample
  location = Faker::Address.city
  password = "123123"

  user = User.new(email: email, introduction: introduction, location: location, name: name, password: password, password_confirmation: password)

  if user.save
    # Generate a random number of users to favorite

    # # num_favorites = rand(10..User.count - 1) # Ensure at least 1 favorite
    # num_favorites = 0 if User.count == 0 || num_favorites.nil? || num_favorites >= User.all.count
    # # Randomly select other users to favorite for this user
    # users_to_favorite = User.where.not(id: user.id).sample(num_favorites)
    # users_to_favorite.each do |favorited_user|
    #   user.favorite(favorited_user)
    # end
  else
    puts "Failed to create user: #{user.email} - Errors: #{user.errors.full_messages.join(', ')}"
  end
end

users = User.all

puts "Users created"
end_time = Time.now
elapsed_time = end_time - run_start_time

puts "Time elapsed: #{elapsed_time} seconds"



users.each do |user|
  num_favorites = [rand(15..25), rand(25..45), rand(46..200)].sample
  users_to_favorite = (users - [user]).sample(num_favorites)

  user.favorites.destroy_all # Clear existing favorites
  users_to_favorite.each do |favorited_user|
    user.favorite(favorited_user)
  end
end



puts "Followers assigned"
end_time = Time.now
elapsed_time = end_time - run_start_time

puts "Time elapsed: #{elapsed_time} seconds"


list_names = [
  "Festivals",
  "Cultural Overload",
  "Drunken Fun",
  "Studying",
  "Ocean Fun",
  "Coastal Getaway",
  "City Exploration",
  "Cultural City Tour",
  "Historic City Route",
  "Urban Discovery",
  "Lakeside Serene",
  "City Escape",
  "Hidden Gems",
  "Scenic Views",
  "City Lights",
  "Spiritual Retreat",
  "Cosmopolitan Trip",
  "Sunset Adventure",
  "Mystic Excursion",
  "Cityscape Retreat",
  "City Break",
  "Otaku Awesomeness",
  "朝ドラ Scene Visits",
  "Shrine/Temple Trips",
  "Anime Scene Reinactment"
]


100.times do
  user_id = users.sample.id
  name = list_names.sample
  location = Faker::Address.city
  start_date = Date.today + rand(1..10)
  end_date = start_date + rand(1..10)

  list = List.new(user_id: user_id, name: name, location: location, start_date: start_date, end_date: end_date)

  if list.save
  else
    puts "Failed to create list: #{list.name} - Errors: #{list.errors.full_messages.join(', ')}"
end
end

puts "Lists created"
end_time = Time.now
elapsed_time = end_time - run_start_time

puts "Time elapsed: #{elapsed_time} seconds"


event = ""
no_category = Category.create!(name: "No category")
url_array = ['https://tokyocheapo.com/events/',
  'https://tokyocheapo.com/events/page/2/',
  'https://tokyocheapo.com/events/page/3/'
]

url_array.each do |url|
  html = URI.open(url).read
  doc = Nokogiri::HTML(html)

  doc.search(".card--event").each do |element|
    name = element.search(".card__title").text.strip

    location_element = element.search(".location")
    location_text = location_element.empty? ? "Tokyo" : location_element.text.strip + ", Tokyo"
    separated_location = location_text.scan(/[A-Z][a-z]+/).join(" ")
    encoded_location_text = URI.encode_www_form_component(location_text)

    description = element.search(".card__excerpt").text.strip
    date = element.search(".card--event__date-box").text.strip.gsub(/\s+/, "")
    card_url = element.search(".card__image").attr("href").value
    attributes = element.search(".card--event__attribute")
    categories = element.search("a[href^='/event-category/']").map { |anchor| anchor.text }


    card_html = URI.open(card_url).read
    card_doc = Nokogiri::HTML(card_html)

    img_url = card_doc.search(".hero-img").attr("src").value
    description = card_doc.search(".entry-content__text").text.strip

    category = false
    price = false
    time = false

    attributes.each do |attribute|
      value = attribute.text.strip
      if value.include?("¥") || value.downcase == "free"
        price = value
      elsif value.include?(":")
        time = value
      else
        category = value
      end
    end

    category_instance = nil

    categories.each do |cat|
      category_instance = Category.find_by(name: cat)
      unless category_instance.present?
        category_instance = Category.create!(name: cat)
      end
    end

    # if category
    #   category_instance = Category.find_by(name: category)
    #     unless category_instance
    #       category_instance = Category.create!(name: category)
    #     end
    # else
    #   category_instance = no_category
    # end

    start_time = ""
    end_time = ""

    if time
      time_array = time.split(' ')
      start_time = time_array[0]
      end_time = time_array[2]
    end

    arrayDates = date.split('~')
    if arrayDates.count == 1
      dateInfo = date.match(/(\w{3})(\d+|\w+)/)
      if dateInfo[2].to_i != 0
        parsed_start_date = DateTime.parse("#{dateInfo[2]} #{dateInfo[1]} #{start_time}")

        parsed_end_date = DateTime.parse("#{dateInfo[2]} #{dateInfo[1]} #{end_time}")
      else
        parsed_start_date = DateTime.parse("01 #{dateInfo[1]} #{start_time}")

        parsed_end_date = DateTime.parse("01 #{dateInfo[1]} #{end_time}")
      end

    elsif arrayDates[0].downcase.match(/(mid)|(late)|(early)/)

      parsed_start_date = DateTime.parse("01 #{arrayDates[1].downcase.gsub(/(mid)|(late)|(early)/, "")} #{start_time}")

      parsed_end_date = DateTime.parse("28 #{arrayDates[1].downcase.gsub(/(mid)|(late)|(early)/, "")} #{end_time}")

    else
      start_date_info = arrayDates[0].match(/(\w{3})(\d+)/)
      parsed_start_date = DateTime.parse("#{start_date_info[2]} #{start_date_info[1]} #{start_time}")

      end_date_info = arrayDates[1].match(/(\w{3})(\d+)/)
      parsed_end_date = DateTime.parse("#{end_date_info[2]} #{end_date_info[1]} #{end_time}")
    end


    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{encoded_location_text}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    data = URI.open(url).read
    response = JSON.parse(data)
    if response['features'] && response['features'][0] && response['features'][0]['geometry'] && response['features'][0]['geometry']['coordinates']
      coordinates = response['features'][0]['center']
    else
      coordinates = [139.6503, 35.6762]
    end

    longitude = coordinates[0]
    latitude = coordinates[1]

    event = Event.new(
      name: name,
      location: separated_location,
      longitude: longitude,
      latitude: latitude,
      description: description,
      price: price,
      start_date: parsed_start_date,
      end_date: parsed_end_date,
      img_url: img_url
    )

    event.url = "https://www.bbc.com/"
    # event.url = card_doc.search(".entry-content__text").text.strip
    event.category = category_instance || no_category
    if event.save!
      puts "Event #{Event.all.count} saved successfully"
    else
      puts "Attributes of the failed record: #{user.attributes}"
    end
  end
end

puts "Events created"
end_time = Time.now
elapsed_time = end_time - run_start_time

puts "Time elapsed: #{elapsed_time} seconds"


event_ids = Event.all.map(&:id)
list_ids = List.all.map(&:id)

puts "Cleaning up event_list"
EventList.destroy_all

events = Event.all
lists = List.all

events_1 = events.each_slice(events.size/1.25).to_a[0]
events_2 = events.each_slice(events.size/10).to_a[8]
events_3 = events.each_slice(events.size/10).to_a[9]


100.times do
  x = rand(1..10)
  case x
  when 1..8
    event_id = events_1.sample.id
  when 9
    event_id = events_2.sample.id
  when 10
    event_id = events_3.sample.id
  end

  list_id = lists.sample.id

  event_list = EventList.new(event_id: event_id, list_id: list_id)
  if event_list.save
  else
    puts "Event list not created :("
  end
end

puts "Event Lists created"
end_time = Time.now
elapsed_time = end_time - run_start_time

puts "Time elapsed: #{elapsed_time} seconds"

comments =[
  "🤷‍♀️ The event was okay, I suppose. Some aspects were decent, but nothing stood out as particularly impressive. It might be worth another visit in the future.",
  "🤷‍♂️ The experience had its moments. Certain elements were alright, and others were just average. It didn't exceed expectations, but it wasn't a complete disappointment either.",
  "🤷‍♀️ The event had both positives and negatives. The overall vibe was alright, and some parts were moderately enjoyable. It left me with mixed feelings.",
  "🤷‍♂️ The attraction provided a mix of experiences. Some parts were decently executed, while others were lacking. It was an average time, all things considered.",
  "🤷‍♀️ The activity was neither here nor there. It had its highlights, but there were also moments that left me wanting more. A neutral experience overall.",
  "🤷‍♂️ The event was passable. It had its ups and downs, and nothing truly wowed me. It was a middle-of-the-road experience that didn't leave a strong impression.",
  "🤷‍♀️ The outing had its moments of interest. Some aspects were worth noting, but others left me underwhelmed. It was a mixed bag of experiences.",
  "🤷‍♂️ The event had its share of pros and cons. Some aspects were engaging, while others were lackluster. I left feeling moderately satisfied.",
  "🤷‍♀️ The experience was average overall. There were certain enjoyable parts, but they were balanced by aspects that fell short. It left me with a sense of indifference.",
  "🤷‍♂️ The event was decent, but not remarkable. It offered a range of experiences, some of which were alright, and others were forgettable. A neutral encounter.",
  "⭐️ The event had both positive and negative aspects. Some parts were enjoyable, while others left me wanting more. A mixed experience overall.",
  "⭐️ The experience didn't fully meet my expectations. Certain elements were decent, but others fell short. It left me somewhat unsatisfied.",
  "⭐️ The event was okay, but it could have been better. Some aspects were underwhelming, and it left me feeling somewhat indifferent.",
  "⭐️ The attraction had its moments, but it lacked consistency. Some parts were engaging, while others were forgettable. A mixed bag overall.",
  "⭐️ The activity had its ups and downs. There were enjoyable aspects, but they were balanced by elements that left me underwhelmed.",
  "⭐️ The event showed promise, but it didn't fully deliver. Some elements were engaging, while others left me feeling unimpressed.",
  "⭐️ The outing had its highlights, but it was marred by certain aspects. It left me with mixed feelings about the overall experience.",
  "⭐️ The event was a bit hit and miss. Some parts were worth noting, but others left me wishing for more. A neutral experience overall.",
  "⭐️ The experience was somewhat lackluster. It had its moments, but it failed to leave a lasting impression. A middle-of-the-road encounter.",
  "⭐️ The event was somewhat enjoyable, but not exceptional. Some aspects held my interest, while others left me wanting something more.",
  "⭐️ The event had potential, but it didn't fully live up to it. Certain elements were decent, but the overall impact was moderate.",
  "⭐️ The experience had its positives, but it wasn't without its drawbacks. It left me with a mix of both appreciation and disappointment.",
  "⭐️ The event was a bit of a mixed bag. Some parts were enjoyable, but others left me wishing for a more consistently positive experience.",
  "⭐️ The outing had its moments of interest, but it didn't leave a strong impression overall. It left me feeling somewhat undecided.",
  "⭐️ The event had its strengths, but it wasn't without its weaknesses. It offered a combination of both satisfying and lackluster elements.",
  "🌟 Had its highlights and positive moments. Some aspects were enjoyable, leaving me with a generally positive impression.",
  "🎉 Offered positives that stood out. Certain elements were engaging, and it left me with an overall positive feeling.",
  "🎭 Managed to capture my interest and provide a generally positive experience. Not flawless, but it had its enjoyable moments.",
  "🏰 Provided some good takeaways. It offered engaging elements and left me with an optimistic outlook.",
  "🎸 Showed promise in certain areas. While not perfect, it left me with a sense of positivity about the overall experience.",
  "🍣 Had its highlights that made it enjoyable. Not exceptional, but it had elements to appreciate.",
  "🎨 Offered moments of interest that I appreciated. Managed to provide a generally positive and engaging time.",
  "🚀 Had its enjoyable moments that made it worthwhile. Not without its downsides, but the overall experience was positive.",
  "🍫 Had its share of positives. Noteworthy elements provided a generally positive and enjoyable experience.",
  "⚡️ Had enjoyable aspects. While not flawless, it managed to deliver a generally positive and satisfying experience.",
  "💫 Provided enjoyable moments. While not without minor downsides, it left me with a positive impression overall.",
  "✨ Managed to provide a positive experience with aspects to highlight. Not every part was perfect, but it had its strengths.",
  "🌻 Had bright spots that stood out. Managed to offer a positive experience with moments of engagement.",
  "🌈 Delivered enjoyable moments that made it worthwhile. A generally positive overall experience that I could appreciate.",
  "🌸 Had positives that were worth noting. Provided a positive experience with elements that stood out.",
  "Loved it! ⭐️",
  "Huge letdown. 👎",
  "Not worth it. 😒",
  "Impressed! 👍",
  "Expected more. 😕",
  "Average. 😐",
  "Awe-inspiring! ✨",
  "Regretful. 😞",
  "Decent time. 😊",
  "Avoid! ❌",
  "So-so. 😶",
  "Thrilling! 🎉",
  "Disappointing. 😔",
  "Mixed bag. 🤷‍♂️",
  "Exceeded expectations! 🌟",
  "Waste of time. ⌛",
  "Okay overall. 🤔",
  "Unforgettable! 🌈",
  "Frustrating. 😣",
  "Fair enough. 👌",
  "Underwhelmed. 🙁",
  "Could be better. 🤨",
  "Mediocre. 😑",
  "Must-see! 👏",
  "Displeasing. 😖",
  "Not too bad. 😅",
  "Outstanding! 🎇",
  "Bitterly disappointed. 😟",
  "Middle ground. 🤷‍♀️",
  "Pleasant surprise! 😃",
  "Fail. 🚫",
]

events_1 = events.each_slice(events.size/1.25).to_a[0]
events_2 = events.each_slice(events.size/10).to_a[8]
events_3 = events.each_slice(events.size/10).to_a[9]


100.times do
  x = rand(1..10)
  case x
  when 1..8
    event_id = events_1.sample.id
  when 9
    event_id = events_2.sample.id
  when 10
    event_id = events_3.sample.id
  end

  comment = comments.sample
  user_id = users.sample.id

  new_comment = Comment.new(event_id: event_id, user_id: user_id, comment: comment)
  new_comment.save
end

comment = Comment.all.sample.id

puts "Comments created"
end_time = Time.now
elapsed_time = end_time - run_start_time

puts "Time elapsed: #{elapsed_time} seconds"


comments = Comment.all

comments_1 = comments.each_slice(comments.size/1.25).to_a[0]
comments_2 = comments.each_slice(comments.size/10).to_a[8]
comments_3 = comments.each_slice(comments.size/10).to_a[9]


200.times do

  x = rand(1..10)
  case x
  when 1..8
    comment = comments_1.sample
  when 9
    comment = comments_2.sample
  when 10
    comment = comments_3.sample
  end

  comment.liked_by users.sample

end


puts "Upvotes created"
puts "Created #{Event.count} events!"
puts "Created #{EventList.count} event lists!"
puts "Created #{List.count} lists!"
puts "Created #{Category.count} categories!"
puts "Created #{Comment.count} comments!"

end_time = Time.now
elapsed_time = end_time - run_start_time
puts "Time elapsed: #{elapsed_time} seconds"

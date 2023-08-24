require 'nokogiri'
require 'open-uri'
require 'faker'
require 'json'

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

20.times do
  email = Faker::Internet.unique.email
  name = Faker::Name.name
  introduction = Faker::Quotes::Shakespeare.as_you_like_it_quote
  location = Faker::Address.city
  password = "123123"

  user = User.new(email: email, introduction: introduction, location: location, name: name, password: password, password_confirmation: password)

  if user.save!
    puts "Created user: #{user.email}"
  else
    puts "Failed to create user: #{user.email} - Errors: #{user.errors.full_messages.join(', ')}"
  end
end

users = User.all

20.times do
  user_id = users.sample.id
  name = Faker::JapaneseMedia::StudioGhibli.character
  location = Faker::Address.city
  start_date = Date.today + rand(1..10)
  end_date = start_date + rand(1..10)

  list = List.new(user_id: user_id, name: name, location: location, start_date: start_date, end_date: end_date)

  if list.save!
    puts "Created list: #{list.name}"
  else
    puts "Failed to create list: #{list.name} - Errors: #{list.errors.full_messages.join(', ')}"
  end
end

event = ""
no_category = Category.create!(name: "No category")
url_array = ['https://tokyocheapo.com/events/', 'https://tokyocheapo.com/events/page/2/', 'https://tokyocheapo.com/events/page/3/']

url_array.each do |url|
  html = URI.open(url).read
  doc = Nokogiri::HTML(html)

  doc.search(".card--event").each do |element|
    name = element.search(".card__title").text.strip

    location_element = element.search(".location")
    location_text = location_element.empty? ? "Tokyo" : location_element.text.strip
    encoded_location_text = URI.encode_www_form_component(location_text)

    description = element.search(".card__excerpt").text.strip
    date = element.search(".card--event__date-box").text.strip.gsub(/\s+/, "")
    card_url = element.search(".card__image").attr("href").value
    attributes = element.search(".card--event__attribute")

    card_html = URI.open(card_url).read
    card_doc = Nokogiri::HTML(card_html)

    img_url = card_doc.search(".hero-img").attr("src").value

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

    if category
      category_instance = Category.find_by(name: category)
        unless category_instance
          category_instance = Category.create!(name: category)
        end
    else
      category_instance = no_category
    end

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
      location: encoded_location_text,
      longitude: longitude,
      latitude: latitude,
      description: description,
      price: price,
      start_date: parsed_start_date,
      end_date: parsed_end_date
    )

    event = Event.new(name: name, location: encoded_location_text, longitude: longitude, latitude: latitude, description: description, price: price, start_date: parsed_start_date, end_date: parsed_end_date, img_url: img_url)
    event.url = "https://www.bbc.com/"
    event.category = Category.new
    event.save!
  end
end


event_ids = Event.all.map(&:id)
list_ids = List.all.map(&:id)

100.times do
    event_id = event_ids.sample
    list_id = list_ids.sample
    event_list = EventList.new
    event_list.list_id = list_id
    event_list.event_id = event_id
    event_list.save

end

puts "Created #{Event.count} events!"
puts "Created #{EventList.count} event lists!"
puts "Created #{Category.count} categories!"

###Event list

puts "Cleaning up event_list"
EventList.destroy_all
events = Event.all
lists = List.all

20.times do
  event_id = events.sample.id
  list_id = lists.sample.id

  event_list = EventList.new(event_id: event_id, list_id: list_id)

  if event_list.save!
    puts "Created event_list"
  else
    puts "Failed to create event_list Errors: #{event_list.errors.full_messages.join(', ')}"
  end
end

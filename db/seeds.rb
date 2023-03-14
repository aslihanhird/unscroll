require "open-uri"

Post.delete_all
Profile.delete_all
List.delete_all
User.delete_all

p "Database cleared"
p "................................"

# Create a user
user = User.new(
  username: "demo",
  email: "demo@lewagon.com",
  password: "123456"
)

if user.valid?
  user.save
  puts "User #{user.username} saved succesfully."
else
  puts "User #{user.username} failed to save."
  puts "Errors: #{user.errors.messages}"
end

# Create 2 lists
list1 = List.new(
  user: user,
  name: "Writing"
)

if list1.valid?
  list1.save
  puts "List #{list1.name} saved succesfully."
else
  puts "List #{list1.name} failed to save."
  puts "Errors: #{list1.errors.messages}"
end

list2 = List.new(
  user: user,
  name: "Food"
)

if list2.valid?
  list2.save
  puts "List #{list2.name} saved succesfully."
else
  puts "List #{list2.name} failed to save."
  puts "Errors: #{list2.errors.messages}"
end

# Creating 5 profiles
profile_data = [
  {
    username: "BurgerRater",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpn5-3rIz4yS0icubE8vMeTIao-C7YN6dipQ&usqp=CAU",
    profile_type: "instagram"
  },

  {
    username: "ChefRamsay",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://pbs.twimg.com/profile_images/1448696882746695683/Jp2_LEBL_400x400.jpg",
    profile_type: "instagram"
  },

  {
    username: "StephenKing",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "https://images.gr-assets.com/authors/1362814142p8/3389.jpg",
    profile_type: "instagram"
  },

  {
    username: "PatrickRothfuss",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "https://assets.wired.com/photos/w_660/wp-content/uploads/2014/10/rothfuss-inline.jpg",
    profile_type: "twitter"
  },

  {
    username: "neilhimself",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "https://literature.britishcouncil.org/assets/Uploads/writers/_resampled/FillWyI2ODAiLCI2ODAiXQ/Neil-Gaiman-c-Kimberley-Butler-web.jpg",
    profile_type: "twitter"
  },

]

profile_data.each do |profile|
  new_profile = Profile.new(
    username: profile[:username],
    list: profile[:list],
    profile_pic: profile[:profile_picture_url],
    profile_type: profile[:profile_type]
  )

  if new_profile.valid?
    new_profile.save
    puts "New profile #{new_profile.username} saved succesfully."
    new_profile.photo.attach(io: URI.open(new_profile.profile_pic), filename: "seed-content.png", content_type: "image/png")
    puts new_profile.photo.attached? ? "Image attached" : "Image Failed to attach"
  else
    puts "Profile #{new_profile.username} failed to save."
    puts "Errors: #{new_profile.errors.messages}"
  end
end

# Creating insta posts per profile
posts_data = [
  {
    caption: "A delicious burger 😍! A perfect burger!

    Possibly the best burger I've ever tasted! 🤤

    7/10",
    media_url: "https://media-cdn.tripadvisor.com/media/photo-s/1a/e7/61/92/20200209-130439-largejpg.jpg",
    profile: Profile.find_by(username: "BurgerRater"),
    source: "instagram"
  },
  {
    caption: "This burger literally saved my marraige.  Didn't taste too good though.  3/10",
    media_url: "https://www.umami.site/wp-content/uploads/2018/10/blended-mushroom-beef-burger-recipe.jpg",
    profile: Profile.find_by(username: "BurgerRater"),
    source: "instagram"
  },
  {
    caption: "A perfect pot roast.  Look at that.",
    media_url: "https://therecipecritic.com/wp-content/uploads/2020/09/potroast-500x500.jpg",
    profile: Profile.find_by(username: "ChefRamsay"),
    source: "instagram"
  },
  {
    caption: "The perfect sushi rolls from gracademy!! Filled with all the good stuff - salmon, avocado and a hearty helping of soy sauce!",
    media_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-837452_11-fbff219.jpg",
    profile: Profile.find_by(username: "ChefRamsay"),
    source: "instagram"
  },
  {
    caption: "CITY OF DREAMS, by Don Winslow: It's a crime classic. Winslow's best book, by far. You won't put it down. I think it's published next month.",
    media_url: "https://i.harperapps.com/covers/9780062851239/y648.jpg",
    profile: Profile.find_by(username: "StephenKing"),
    source: "instagram"
  },
  {
    caption: "THE CURATOR, by Owen King: On sale today. The unabridged audio is read by Marin Ireland. It's a bravura performance.",
    media_url: "https://is1-ssl.mzstatic.com/image/thumb/Publication112/v4/d6/ca/a3/d6caa3ea-9da8-13b3-cac6-bf6d99b5deae/9781982196820.jpg/1200x630wz.png",
    profile: Profile.find_by(username: "StephenKing"),
    source: "instagram"
  },
  {
    caption: "What a fabulous list to be on! it's an honour to be nominated. https://twitter.com/deloftheendless/status/1633396274559844353",
    media_url: "none",
    profile: Profile.find_by(username: "neilhimself"),
    source: "twitter"
  },

  {
    caption: "Whenever you start to question your own artistic choices, just remember: Picasso drew a butt.",
    media_url: "https://i.pinimg.com/originals/64/c5/ea/64c5ea82d82f916a9b6b2984961236a7.jpg",
    profile: Profile.find_by(username: "PatrickRothfuss"),
    source: "twitter"
  },

  {
    caption: "Was surprised (flattered) to be mentioned here. Then dug up the thread it mentioned because I didn't remember posting  anything inspirational.

    Sharing to show that simply being open about your struggle can sometimes be enough to help another person:

    https://twitter.com/PatrickRothfuss/status/1525268593457479681",
    media_url: "none",
    profile: Profile.find_by(username: "PatrickRothfuss"),
    source: "twitter"
  }

]

posts_data.each do |post|
  new_post = Post.new(
    caption: post[:caption],
    media_url: post[:media_url],
    timestamp: rand(1600000000..1678447387),
    source: post[:source],
    profile: post[:profile]
  )

  if new_post.valid?
    new_post.save
    puts "New post (#{new_post.id}) saved."
    unless new_post.media_url == 'none'
      new_post.photo.attach(io: URI.open(new_post.media_url), filename: "seed-post-image.png", content_type: "image/png")
      puts new_post.photo.attached? ? "Image attached" : "Image Failed to attach"
    end
  else
    puts "Post failed to save for #{post.profile}."
    puts "Errors: #{new_post.errors.messages}"
  end
end

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
  password: "123456",
  admin: true
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
  name: "Music"
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
  name: "Writing"
)

if list2.valid?
  list2.save
  puts "List #{list2.name} saved succesfully."
else
  puts "List #{list2.name} failed to save."
  puts "Errors: #{list2.errors.messages}"
end

# Creating Music profiles
profile_data = [
  {
    username: "DOMiAndJDBECK",
    list: List.find_by(name: "Music"),
    profile_picture_url: "../assets/images/seeds/DomiJDBeck.png",
    profile_type: "twitter"
  },

  {
    username: "loumana_",
    list: List.find_by(name: "Music"),
    profile_picture_url: "../assets/images/seeds/loumana.png",
    profile_type: "instagram"
  },

  {
    username: "icesealedeyes",
    list: List.find_by(name: "Music"),
    profile_picture_url: "../assets/images/seeds/ISE.png",
    profile_type: "instagram"
  },

  {
    username: "taminoamir",
    list: List.find_by(name: "Music"),
    profile_picture_url: "../assets/images/seeds/tamino.png",
    profile_type: "instagram"
  },

  {
    username: "UncleSego",
    list: List.find_by(name: "Music"),
    profile_picture_url: "../assets/images/seeds/masego.png",
    profile_type: "twitter"
  },

  {
    username: "StephenKing",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "../assets/images/seeds/king.png",
    profile_type: "instagram"
  },

  {
    username: "PatrickRothfuss",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "../assets/images/seeds/pat.png",
    profile_type: "twitter"
  },

  {
    username: "neilhimself",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "../assets/images/seeds/neilhimself.png",
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
    new_profile.photo.attach(io: File.open(new_profile.profile_pic), filename: "seed-content.png", content_type: "image/png")
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
    source: "instagram",
    media_type: 'photo'
  },
  {
    caption: "This burger literally saved my marraige.  Didn't taste too good though.  3/10",
    media_url: "https://www.umami.site/wp-content/uploads/2018/10/blended-mushroom-beef-burger-recipe.jpg",
    profile: Profile.find_by(username: "BurgerRater"),
    source: "instagram",
    media_type: 'photo'
  },
  {
    caption: "A perfect pot roast.  Look at that.",
    media_url: "https://therecipecritic.com/wp-content/uploads/2020/09/potroast-500x500.jpg",
    profile: Profile.find_by(username: "ChefRamsay"),
    source: "instagram",
    media_type: 'photo'
  },
  {
    caption: "The perfect sushi rolls from gracademy!! Filled with all the good stuff - salmon, avocado and a hearty helping of soy sauce!",
    media_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-837452_11-fbff219.jpg",
    profile: Profile.find_by(username: "ChefRamsay"),
    source: "instagram",
    media_type: 'photo'
  },
  {
    caption: "CITY OF DREAMS, by Don Winslow: It's a crime classic. Winslow's best book, by far. You won't put it down. I think it's published next month.",
    media_url: "https://i.harperapps.com/covers/9780062851239/y648.jpg",
    profile: Profile.find_by(username: "StephenKing"),
    source: "instagram",
    media_type: 'photo'
  },
  {
    caption: "THE CURATOR, by Owen King: On sale today. The unabridged audio is read by Marin Ireland. It's a bravura performance.",
    media_url: "https://is1-ssl.mzstatic.com/image/thumb/Publication112/v4/d6/ca/a3/d6caa3ea-9da8-13b3-cac6-bf6d99b5deae/9781982196820.jpg/1200x630wz.png",
    profile: Profile.find_by(username: "StephenKing"),
    source: "instagram",
    media_type: 'photo'
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
    source: "twitter",
    media_type: 'photo'
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
    profile: post[:profile],
    media_type: post[:media_type]
  )

  if new_post.valid?
    new_post.save
    puts "New post (#{new_post.id}) saved."
    unless new_post.media_url == 'none'
      new_post.photos.attach(io: URI.open(new_post.media_url), filename: "seed-post-image.png", content_type: "image/png")
      puts new_post.photos.attached? ? "Image attached" : "Image Failed to attach"
    end
  else
    puts "Post failed to save for #{post.profile}."
    puts "Errors: #{new_post.errors.messages}"
  end
end

# Creating carousels list

list3 = List.new(
  user: user,
  name: "Carousels test"
)

if list3.valid?
  list3.save
  puts "List #{list3.name} saved succesfully."
else
  puts "List #{list3.name} failed to save."
  puts "Errors: #{list3.errors.messages}"
end

# Creating carousel profiles

carousel_profile_data = [
  {
    username: "neilhimself",
    list: List.find_by(name: "Carousels test"),
    profile_picture_url: "https://literature.britishcouncil.org/assets/Uploads/writers/_resampled/FillWyI2ODAiLCI2ODAiXQ/Neil-Gaiman-c-Kimberley-Butler-web.jpg",
    profile_type: "instagram"
  },

  {
    username: "aksak.ak",
    list: List.find_by(name: "Carousels test"),
    profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/107264821_581730679204297_2938797758067589536_n.jpg?stp=dst-jpg_s320x320&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=101&_nc_ohc=Dnt5PeCFrLEAX8vSCak&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBzZzGDhZb0G73_dLBHU7tAcgq1YTO7SftDx-jL5UZk4w&oe=6415708B&_nc_sid=8fd12b",
    profile_type: "instagram"
  },
]

carousel_profile_data.each do |profile|
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
    puts new_profile.photo.attached? ? "Profile Pic attached" : "Profile Pic Failed to attach"
  else
    puts "Profile #{new_profile.username} failed to save."
    puts "Errors: #{new_profile.errors.messages}"
  end
end

# Carousel 1

carousel_data_1 = {
  caption: "Night sky. The stars were out the night before last, so I improvised a tripod from a tissue box, and took a few pictures. I love this one of the sky and the shadows of the trees.",
  profile: Profile.find_by(username: "neilhimself"),
  source: "instagram",
  media_type: 'carousel',
  media_keys: ['photo', 'video']
}

carousel_1 = Post.new(
  caption: carousel_data_1[:caption],
  timestamp: rand(1600000000..1678447387),
  source: carousel_data_1[:source],
  profile: carousel_data_1[:profile],
  media_type: carousel_data_1[:media_type],
  media_keys: carousel_data_1[:media_keys]
)

if carousel_1.valid?
  carousel_1.save
  puts "New post (#{carousel_1.id}) saved."
  carousel_1.photos.attach(io: URI.open('https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/325854201_545110114228565_4686087712766057585_n.webp?stp=dst-jpg_e35&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=105&_nc_ohc=rbMCUFXiI5QAX-w54oL&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MzAxODg1NDk1MzM4MTU0MTExMg%3D%3D.2-ccb7-5&oh=00_AfCvIo4r2izZfjemskm-DlOECZT7HIaqv2bhLN2u1ZwAEA&oe=641612E6&_nc_sid=30a2ef'), filename: "seed-post-photo.png", content_type: "image/png")
  carousel_1.videos.attach(io: URI.open('https://scontent-bru2-1.cdninstagram.com/v/t50.2886-16/326455002_1528689777597378_143681180239615834_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjQ4MC5jYXJvdXNlbF9pdGVtLmJhc2VsaW5lIiwicWVfZ3JvdXBzIjoiW1wiaWdfd2ViX2RlbGl2ZXJ5X3Z0c19vdGZcIl0ifQ&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=106&_nc_ohc=7CNPJSEpsEAAX8ubRTu&edm=ALQROFkBAAAA&vs=1479892792537873_744399830&_nc_vs=HBkcFQAYJEdOcE9kUlBDV3lyVFZXNEZBRnBYRjYxRmRmNEJia1lMQUFBRhUAAsgBACgAGAAbAYgHdXNlX29pbAEwFQAAJp6p3JnesuQ%2FFQIoAkMzLBc%2F9MzMzMzMzRgSZGFzaF9iYXNlbGluZV8yX3YxEQB17gcA&ccb=7-5&oh=00_AfC4DQ5_FdKjr4pSeljat8MwxXtmykdIBlngXeonr-Ezdg&oe=6411CA68&_nc_sid=30a2ef'), filename: "seed-post-video.png", content_type: "video/mp4")
  puts carousel_1.photos.attached? ? "Photo attached" : "Photo Failed to attach"
  puts carousel_1.videos.attached? ? "Video attached" : "Video Failed to attach"

else
  puts "Post failed to save for #{carousel_1.profile}."
  puts "Errors: #{carousel_1.errors.messages}"
end

# Carsouel 2

carousel_data_2 = {
  caption: "Silken is OUT 💙

  Super hyped to finally (finally) share this track with u all, I know some of you have been waiting for it 👀

  🎚Produced, mixed and mastered by the legendary @lucas6mon

  🥂 to the first of many bangers",
  profile: Profile.find_by(username: "aksak.ak"),
  source: "instagram",
  media_type: 'carousel',
  media_keys: ['video', 'photo', 'photo']
}

carousel_2 = Post.new(
  caption: carousel_data_2[:caption],
  timestamp: rand(1600000000..1678447387),
  source: carousel_data_2[:source],
  profile: carousel_data_2[:profile],
  media_type: carousel_data_2[:media_type],
  media_keys: carousel_data_2[:media_keys]
)

if carousel_2.valid?
  carousel_2.save
  puts "New post (#{carousel_2.id}) saved."
  carousel_2.videos.attach(io: URI.open('https://scontent-bru2-1.cdninstagram.com/v/t50.2886-16/315450558_626917079226911_3234041562241735884_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjQ4Mi5jYXJvdXNlbF9pdGVtLmJhc2VsaW5lIiwicWVfZ3JvdXBzIjoiW1wiaWdfd2ViX2RlbGl2ZXJ5X3Z0c19vdGZcIl0ifQ&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=111&_nc_ohc=qqN2BVeigAgAX9J18If&edm=ALQROFkBAAAA&vs=661440272344554_453028934&_nc_vs=HBksFQAYJEdMNWt6UklmbXNfQkxUb0NBTXljUklxcW5fRXNia1lMQUFBRhUAAsgBABUAGCRHUGh6eXhMZW95ZGlQR1FDQU1oeGdRR1Atd1VNYmtZTEFBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMBUAACaIjYjL7vjOPxUCKAJDMywXQDDVP3ztkWgYEmRhc2hfYmFzZWxpbmVfMl92MREAde4HAA%3D%3D&ccb=7-5&oh=00_AfDfbiM2RATgt8SKP8Tlp2Kt1f2-Hpxx5a0RiIglc8O9JQ&oe=6412066E&_nc_sid=30a2ef'), filename: "seed-post-video.png", content_type: "image/png")
  carousel_2.photos.attach(io: URI.open('https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/315066320_173788325273180_5523960232077781542_n.jpg?stp=dst-jpg_e35_s1080x1080&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=108&_nc_ohc=5dezoTp3qSkAX-i4jgb&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=Mjk2OTE1NzgwODYwNzU4MTkxOA%3D%3D.2-ccb7-5&oh=00_AfDb5iggH4LMu4DNEKpumcON7pJT3Xj1tcv662b_wxnVnw&oe=64153E16&_nc_sid=30a2ef'), filename: "seed-post-video.png", content_type: "video/mp4")
  carousel_2.photos.attach(io: URI.open('https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/314821835_192839169973395_372215399562011978_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=103&_nc_ohc=tRHOOPHzoqYAX_h1fwW&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=Mjk2OTE1NzgwODIzMDEwOTM2OA%3D%3D.2-ccb7-5&oh=00_AfAqFatAv0SIq2Vrqx--CJwQi9Dw-vy6eAewjxdLmkRwlw&oe=6414DFA8&_nc_sid=30a2ef'), filename: "seed-post-video.png", content_type: "video/mp4")
  puts carousel_2.photos.attached? ? "Photo attached" : "Photo Failed to attach"
  puts carousel_2.videos.attached? ? "Video attached" : "Video Failed to attach"

else
  puts "Post failed to save for #{carousel_2.profile}."
  puts "Errors: #{carousel_2.errors.messages}"
end

puts 'Done :) (special request from damian)'

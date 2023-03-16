require "open-uri"

Post.delete_all
Profile.delete_all
List.delete_all
User.delete_all

p "Database cleared"
p "................................"

# Create a user
user = User.new(
  username: "Aslihan",
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
    profile_picture_url: "app/assets/images/seeds/profiles/DomiJDBeck.png",
    profile_type: "twitter"
  },

  {
    username: "aksak.ak",
    list: List.find_by(name: "Music"),
    profile_picture_url: "app/assets/images/seeds/profiles/aksak.jpeg",
    profile_type: "instagram"
  },

  {
    username: "loumana_",
    list: List.find_by(name: "Music"),
    profile_picture_url: "app/assets/images/seeds/profiles/loumana.png",
    profile_type: "instagram"
  },

  {
    username: "icesealedeyes",
    list: List.find_by(name: "Music"),
    profile_picture_url: "app/assets/images/seeds/profiles/ISE.png",
    profile_type: "instagram"
  },

  {
    username: "taminoamir",
    list: List.find_by(name: "Music"),
    profile_picture_url: "app/assets/images/seeds/profiles/tamino.png",
    profile_type: "instagram"
  },

  {
    username: "UncleSego",
    list: List.find_by(name: "Music"),
    profile_picture_url: "app/assets/images/seeds/profiles/masego.png",
    profile_type: "twitter"
  },

  {
    username: "coltleduo",
    list: List.find_by(name: "Music"),
    profile_picture_url: "app/assets/images/seeds/profiles/colt.png",
    profile_type: "instagram"
  },

  {
    username: "StephenKing",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "app/assets/images/seeds/profiles/king.png",
    profile_type: "instagram"
  },

  {
    username: "PatrickRothfuss",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "app/assets/images/seeds/profiles/pat.png",
    profile_type: "twitter"
  },

  {
    username: "neilhimself",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "app/assets/images/seeds/profiles/neilhimself.png",
    profile_type: "twitter"
  },

  {
    username: "lemonysnicket",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "app/assets/images/seeds/profiles/snicket.png",
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

# Creating insta & twitter posts per profile
posts_data = [
  {
    caption: "SEE U THEREv@Elbjazz

    TiX -> https://DOMiAndJDBECK.lnk.to/tour",
    media_url: "app/assets/images/seeds/posts/domijd.png",
    profile: Profile.find_by(username: "DOMiAndJDBECK"),
    source: "twitter",
    media_type: 'photo'
  },

  {
    caption: "Torments - Out Tomorrow ⛓ Ytb premiere 6Pm ⛓Link in bio.
    -
    Pic @greg_evrard
    -
    #metalrelease #newmetalsong #newcoreband #belgiummetal #bruxellesmusic #belgianartist #photographer #photographie #localscene #torments #icesealedeyes",
    media_url: "app/assets/images/seeds/posts/ise_post.jpeg",
    profile: Profile.find_by(username: "icesealedeyes"),
    source: "instagram",
    media_type: 'photo'
  },

  {
    caption: "🎷🎷🎷",
    media_url: "app/assets/images/seeds/posts/sego.jpeg",
    profile: Profile.find_by(username: "UncleSego"),
    source: "twitter",
    media_type: 'photo'
  },

  {
    caption: "Toutes ces foutues planètes s’alignent 🙃🙂🙃 Reprise de Vie de Chien de @primerolodc 🫀",
    media_url: "app/assets/images/seeds/posts/colt.mp4",
    profile: Profile.find_by(username: "coltleduo"),
    source: "instagram",
    media_type: 'video'
  },

  {
    caption: "RT @RandomSandman: Random Sandman #8746.
    #Sandman #NeilGaiman #Morpheus #Dream #Endless",
    media_url: "app/assets/images/seeds/posts/neilRT.jpeg",
    profile: Profile.find_by(username: "neilhimself"),
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
  },

  {
    caption: "A fair enough comparison, I warrant. My only hope is  the industrious children of The Mysterious Benedict Society need never face even half the dangers the Baudelaires confronted. I suspect the Benedict Society will have their own unfortunate adventures. Well wishes to all!",
    media_url: "none",
    profile: Profile.find_by(username: "lemonysnicket"),
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
      if new_post.media_type == 'photo'
        new_post.photos.attach(io: File.open(new_post.media_url), filename: "seed-post-image.png", content_type: "image/png")
        puts new_post.photos.attached? ? "Image attached" : "Image Failed to attach"
      elsif new_post.media_type == 'video'
        new_post.videos.attach(io: File.open(new_post.media_url), filename: "seed-post-video.mp4", content_type: "video/mp4")
        puts new_post.videos.attached? ? "Video attached" : "Video Failed to attach"
      end
    end
  else
    puts "Post failed to save for #{post.profile}."
    puts "Errors: #{new_post.errors.messages}"
  end
end

# Creating carousel posts

carousel_data_1 = {
  caption: "Never ending cycle ♻️♻️♻️♻️♻️",
  profile: Profile.find_by(username: "loumana_"),
  source: "instagram",
  media_type: 'carousel',
  media_keys: ['photo', 'photo', 'video', 'photo']
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
  carousel_1.photos.attach(io: File.open('app/assets/images/seeds/carousel1/loumana1.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")
  puts "Carousel photo 1 attached"
  carousel_1.photos.attach(io: File.open('app/assets/images/seeds/carousel1/loumana2.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")
  puts "Carousel photo 2 attached"
  carousel_1.videos.attach(io: File.open('app/assets/images/seeds/carousel1/loumana3.mp4'), filename: "seed-post-video.png", content_type: "video/mp4")
  puts "Carousel video 3 attached"
  carousel_1.photos.attach(io: File.open('app/assets/images/seeds/carousel1/loumana4.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")
  puts "Carousel photo 3 attached"
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
  carousel_2.videos.attach(io: File.open('app/assets/images/seeds/carousel2/aksak.mp4'), filename: "seed-post-video.png", content_type: "video/mp4")
  carousel_2.photos.attach(io: File.open('app/assets/images/seeds/carousel2/aksak2.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")
  carousel_2.photos.attach(io: File.open('app/assets/images/seeds/carousel2/aksak3.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")
  puts carousel_2.photos.attached? ? "Photo attached" : "Photo Failed to attach"
  puts carousel_2.videos.attached? ? "Video attached" : "Video Failed to attach"

else
  puts "Post failed to save for #{carousel_2.profile}."
  puts "Errors: #{carousel_2.errors.messages}"
end

carousel_data_3 = {
  caption: "tour&🦦things",
  profile: Profile.find_by(username: "taminoamir"),
  source: "instagram",
  media_type: 'carousel',
  # media_keys: ['video', 'photo', 'video', 'photo', 'photo', 'photo', 'photo', 'video', 'photo', 'photo']
  media_keys: ['video', 'photo', 'photo', 'photo', 'photo', 'photo', 'photo', 'photo']
}

carousel_3 = Post.new(
  caption: carousel_data_3[:caption],
  timestamp: rand(1600000000..1678447387),
  source: carousel_data_3[:source],
  profile: carousel_data_3[:profile],
  media_type: carousel_data_3[:media_type],
  media_keys: carousel_data_3[:media_keys]
)

if carousel_3.valid?
  carousel_3.save
  puts "New post (#{carousel_3.id}) saved."

  carousel_3.videos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino1.mp4'), filename: "seed-post-video.png", content_type: "video/mp4")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino2.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino4.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino5.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino6.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino7.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino9.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  carousel_3.photos.attach(io: File.open('app/assets/images/seeds/carousel3/tamino10.jpeg'), filename: "seed-post-photo.png", content_type: "image/png")

  puts carousel_3.photos.attached? ? "Photo attached" : "Photo Failed to attach"
  puts carousel_3.videos.attached? ? "Video attached" : "Video Failed to attach"

else
  puts "Post failed to save for #{carousel_3.profile}."
  puts "Errors: #{carousel_3.errors.messages}"
end

puts 'Done :) (special request from damian)'

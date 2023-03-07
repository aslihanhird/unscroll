InstaProfile.delete_all
List.delete_all
User.delete_all
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
  name: "Food"
)

if list2.valid?
  list2.save
  puts "List #{list2.name} saved succesfully."
else
  puts "List #{list2.name} failed to save."
  puts "Errors: #{list2.errors.messages}"
end

# Creating 5 Insta profiles

insta_profile_data = [
  {
    username: "opmijntalloor",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/279328880_389563856376445_1852077437183279362_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=101&_nc_ohc=1IeoxgpT8BQAX8Y7EVN&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAFg8YD6oSvM9YY4IT6_7Dj66kSeGKiL3TOQZWu06BLVA&oe=640B50DF&_nc_sid=1527a3"
  },

  {
    username: "eenlepeltjelekkers",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/244458906_1167601647098320_3765168347587320534_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=104&_nc_ohc=SDhbOzxb5IsAX_2q8iH&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfDd36V2GK2OYgycFIE7b3VeyD_d4adlbGOlicXZOPiCDA&oe=640BECCE&_nc_sid=1527a3"
  },

  {
    username: "delhaizebelgium",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/135813760_696904997860119_1464246863208096522_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=103&_nc_ohc=ctapx6C9iUMAX8Vt0Uw&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfCiTo5PTGpLQduZgZeXszAEfoVrq2TF80wGFBEvC9PxYQ&oe=640C7C56&_nc_sid=1527a3"
  },

  {
    username: "metallica",
    list: List.find_by(name: "Music"),
    profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/317012131_687203769414479_1592679017416652389_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=vWF4QMGXNqwAX_T1GWy&edm=AGW0Xe4BAAAA&ccb=7-5&oh=00_AfC7RDL_AxyJ_PZnpn7aPWDJcwhGkO3tjJjoxNUkr-r61A&oe=640B7FED&_nc_sid=acd11b"
  },

  {
    username: "evanescenceofficial",
    list: List.find_by(name: "Music"),
    profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/298974319_475988790594872_934832594272575287_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=108&_nc_ohc=UZyPU-kUrdEAX-jreIr&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfD88zP9OvMOb91Vtp1pE_46pSNGFZBksTHSX2oMiPJC2Q&oe=640C3E42&_nc_sid=1527a3"
  }

]

insta_profile_data.each do |profile|
  new_profile = InstaProfile.new(
    username: profile[:username],
    list: profile[:list],
    profile_picture_url: profile[:profile_picture_url]
  )

  if new_profile.valid?
    new_profile.save
    puts "New profile #{new_profile.username} saved succesfully."
  else
    puts "Profile #{new_profile.username} failed to save."
    puts "Errors: #{new_profile.errors.messages}"
  end
end

InstaPost.delete_all
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

# Testing profile data fetch




# list2 = List.new(
#   user: user,
#   name: "Food"
# )

# if list2.valid?
#   list2.save
#   puts "List #{list2.name} saved succesfully."
# else
#   puts "List #{list2.name} failed to save."
#   puts "Errors: #{list2.errors.messages}"
# end

# # Creating 5 Insta profiles
# insta_profile_data = [
#   {
#     username: "opmijntalloor",
#     list: List.find_by(name: "Food"),
#     profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/279328880_389563856376445_1852077437183279362_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=101&_nc_ohc=1IeoxgpT8BQAX8Y7EVN&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAFg8YD6oSvM9YY4IT6_7Dj66kSeGKiL3TOQZWu06BLVA&oe=640B50DF&_nc_sid=1527a3"
#   },

#   {
#     username: "eenlepeltjelekkers",
#     list: List.find_by(name: "Food"),
#     profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/244458906_1167601647098320_3765168347587320534_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=104&_nc_ohc=SDhbOzxb5IsAX_2q8iH&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfDd36V2GK2OYgycFIE7b3VeyD_d4adlbGOlicXZOPiCDA&oe=640BECCE&_nc_sid=1527a3"
#   },

#   {
#     username: "delhaizebelgium",
#     list: List.find_by(name: "Food"),
#     profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/135813760_696904997860119_1464246863208096522_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=103&_nc_ohc=ctapx6C9iUMAX8Vt0Uw&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfCiTo5PTGpLQduZgZeXszAEfoVrq2TF80wGFBEvC9PxYQ&oe=640C7C56&_nc_sid=1527a3"
#   },

#   {
#     username: "metallica",
#     list: List.find_by(name: "Music"),
#     profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/317012131_687203769414479_1592679017416652389_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=vWF4QMGXNqwAX_T1GWy&edm=AGW0Xe4BAAAA&ccb=7-5&oh=00_AfC7RDL_AxyJ_PZnpn7aPWDJcwhGkO3tjJjoxNUkr-r61A&oe=640B7FED&_nc_sid=acd11b"
#   },

#   {
#     username: "evanescenceofficial",
#     list: List.find_by(name: "Music"),
#     profile_picture_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-19/298974319_475988790594872_934832594272575287_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=108&_nc_ohc=UZyPU-kUrdEAX-jreIr&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfD88zP9OvMOb91Vtp1pE_46pSNGFZBksTHSX2oMiPJC2Q&oe=640C3E42&_nc_sid=1527a3"
#   }

# ]

# insta_profile_data.each do |profile|
#   new_profile = InstaProfile.new(
#     username: profile[:username],
#     list: profile[:list],
#     profile_picture_url: profile[:profile_picture_url]
#   )

#   if new_profile.valid?
#     new_profile.save
#     puts "New profile #{new_profile.username} saved succesfully."
#   else
#     puts "Profile #{new_profile.username} failed to save."
#     puts "Errors: #{new_profile.errors.messages}"
#   end
# end

# # Creating 2 insta posts per profile
# insta_posts_data = [
#   {
#     caption: "Heerlijke pastataart 😍! Perfect om mee uit te pakken bij een dinertje met vrienden. 👀

#     Het is natuurlijk ook gemakkelijk dat je deze taart op voorhand kan maken en gewoon daarna nog 10 minuten opnieuw op te warmen in de oven.

#     Zo spendeer je meer tijd met je gezelschap en minder tijd in de keuken!

#     Wie gaat deze eens klaarmaken? 🤤🙋",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t39.30808-6/330390395_1346075615961621_442302036782805855_n.png?stp=dst-jpg_e35_p1080x1080_sh0.08&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=109&_nc_ohc=BZuvsUyuQUoAX_eVIWG&edm=ACWDqb8AAAAA&ccb=7-5&ig_cache_key=MzA1MjMwMzk3ODg1NTcyNjA2MA%3D%3D.2-ccb7-5&oh=00_AfBLtd3uD_NYkTy9Phkxy5LhG6k_DMQ6iIxERthnqcUo1Q&oe=640C8217&_nc_sid=1527a3",
#     timestamp: "08/03/2023, 06:15",
#     insta_profile: InstaProfile.find_by(username: "opmijntalloor")
#   },
#   {
#     caption: "Het grote geheim van een creamy Italiaanse pasta? 't Is alleszins niet room! De Italiaanse keuken is zo mooi in zijn eenvoud.

#     Wij maken onze pasta creamy dankzij water. Ge hoort het goed: water. 💧",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t39.30808-6/329154632_504001941916884_3368038772875862424_n.png?stp=c0.0.1364.1706a_dst-png_e15&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=100&_nc_ohc=TjOhMNQOFHYAX8qoUMt&edm=ACWDqb8AAAAA&ccb=7-5&ig_cache_key=MzA0MjE2MjYxNDIwNTQyNDc4OQ%3D%3D.2-ccb7-5&oh=00_AfAeTdcyjBe0jOANpyNKDf0mbudH-H4oN_nhVur8vks9AA&oe=640BC126&_nc_sid=1527a3",
#     timestamp: "20/02/2023, 07:12",
#     insta_profile: InstaProfile.find_by(username: "opmijntalloor")
#   },
#   {
#     caption: "🍗 Pittige kip met sesam en soja

#     Efkes alle smaakpapillen wakkerschudden 🤩. Hartig, pikant en een vleugje zoet: perfect om drukke werkdagen wat op te fleuren!

#     👩‍🍳 Recept hieronder en met extra tips & tricks op de blog 👉 link in bio

#     💬 Wat hebben jullie vandaag op tafel gezet?

#     ✔️ Ingrediënten
#     1 bos lente-ui, in ringen, 6 kippendijfilets, in reepjes
#     arachideolie
#     250 g peultjes
#     1 eetlepel sojasaus
#     zeezout
#     2 eetlepels sesamzaad

#     Voor de saus
#     3 el oestersaus
#     3 el sesamolie
#     1 el sojasaus
#     1 el honing
#     1 el sambal
#     1 el water
#     4 teentjes look
#     zwarte peper

#     ✔️ Bereidingswijze
#     1. Meng alle ingrediënten voor de saus.
#     2. Verhit een scheutje arachideolie in de wok op hoog vuur.
#     3. Doe er de peultjes in en laat goed aanbakken tot hier en daar geblakerd.
#     4. Schep om en giet er de sojasaus bij.
#     5. Laat nog enkele minuten bakken tot de sojasaus ingekookt is, voeg eventueel nog wat extra zout toe en schep de peultjes uit de wok.
#     6. Voeg een nieuw scheutje olie toe en bak de kip goudbruin en gaar.
#     7. Voeg er de witte en lichtgroene delen van de lente-ui en de saus aan toe.
#     8. Laat een drietal minuten inkoken tot iets ingedikt.
#     9. Verdeel de peultjes en kip over 4 borden.
#     10. Garneer met sesamzaad en de overgebleven lente-ui.
#     11. Serveer met gekookte rijst en crispy chili oil.

#     🥰 Smakelijk!",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/333640655_191592910228999_3490827911669990015_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=107&_nc_ohc=Rlf8dHFjBusAX9DLu9i&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA0OTAxNTcxNjMwOTYyNzgyNQ%3D%3D.2-ccb7-5&oh=00_AfD_Rek5mGMloncOF-fIqz8CzF3anTYXjcFI7_4vAfiL5w&oe=640AFBA8&_nc_sid=1527a3",
#     timestamp: "02/03/2023, 10:23",
#     insta_profile: InstaProfile.find_by(username: "eenlepeltjelekkers")
#   },
#   {
#     caption: "Time’s running out to pre-order your Cliff Burton Ultimates! Action Figure from our friends at @super7.

#     Available in the Met Store & the Probity UK Shop until March 10, 2023, at 10 AM PST!

#     Get Yours ➡ metallica.lnk.to/Super7Cliff or the #linkinbio👆",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/334525259_188068587273447_4263342960315135064_n.jpg?stp=dst-jpg_e15&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=ZvXgT3-PGr0AX_Kkbj0&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA1MjcyMTk2MTc4NTE3NjU2OA%3D%3D.2-ccb7-5&oh=00_AfCv2vDhpu_i6fC_y_c4mDvrv4iV8sAfHolL428UX62XNg&oe=640B6A0A&_nc_sid=1527a3",
#     timestamp: "06/03/2023, 11:25",
#     insta_profile: InstaProfile.find_by(username: "metallica")
#   },
#   {
#     caption: "RIP Brother Gary. Thank you for bringing me so much joy with your guitar playing and songwriting in one of my all time favorite bands, Lynyrd Skynyrd.

#     — James",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/334323541_750282763398552_3638425719194467413_n.jpg?stp=dst-jpg_e35_s640x640_sh0.08&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=WBTQYOaBcSQAX8sqO9s&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA1MjIyNTU5MDQ2NzU3MDc5MA%3D%3D.2-ccb7-5&oh=00_AfBaemNumzQFT8jdhpaQf0p3Cid0-qrm0SpeUpDh5zrA3w&oe=640C5167&_nc_sid=1527a3",
#     timestamp: "05/03/2023, 12:10",
#     insta_profile: InstaProfile.find_by(username: "metallica")
#   },
#   {
#     caption: "Extreme makeover - the food edition

#     Misschien geen extreme make-over zoals op tv 🤓, maar toch ook een groot verschil in de voor en na ▶️ swipe

#     📸 Food fotografie… Ik heb het gaandeweg moeten leren. In de begindagen van mijn blog besteedde ik er weinig aandacht aan. Het ging vooral over iets publiceren 👩‍💻, en liefst zo veel mogelijk.",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/330994131_231724552562099_1800453542510069098_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=111&_nc_ohc=qA7lNMuKeSIAX_YP4jr&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzAzODA2ODM1MzkyNzY3NDg0Mg%3D%3D.2-ccb7-5&oh=00_AfCMMvupLCKiCDm7jB0NNHewZx2Ct8twVU9EAR9i59n9ug&oe=640C08E4&_nc_sid=1527a3",
#     timestamp: "16/02/2023, 18:25",
#     insta_profile: InstaProfile.find_by(username: "eenlepeltjelekkers")
#   },
#   {
#     caption: "Envie d’une explosion de saveurs végétariennes ? Essayez cette recette de frittata aux champignons, petits pois et ricotta. 🍄 Lien de la recette en bio.

#     Zin in een vegetarisch smaakbommetje? Probeer eens deze frittata met champignons, erwtjes en ricotta. 🍄 Link naar het recept in bio.",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/333644154_737023098028279_8312333205156490049_n.jpg?stp=dst-jpg_e35_p640x640_sh0.08&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=107&_nc_ohc=LH5S-uOp_8EAX8g4Kbc&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA1MjM1OTQwMzA0Mjg0NzI2NQ%3D%3D.2-ccb7-5&oh=00_AfBIcl4wKXfzDoJ3hm-X9L5KXZC6iuwAhjFTGJzDRzZ2jQ&oe=640B4AEC&_nc_sid=1527a3",
#     timestamp: "06/03/2023, 03:12",
#     insta_profile: InstaProfile.find_by(username: "delhaizebelgium")
#   },
#   {
#     caption: "Joyeuse fête des grands-mères ! Quoi de mieux que de célébrer cette journée spéciale avec la recette classique de rosbif ? Profitez de cette journée en famille autour de ce plat traditionnel ! Lien de la recette en bio.

#     ​Geniet van Grootmoederdag! Wat is er beter om deze speciale dag te vieren dan rosbief op grootmoeder’s wijze? Probeer dit lekkere klassieke recept met heel de familie! Link naar het recept in bio.",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/334410091_1246312582960825_1170986753397653249_n.jpg?stp=dst-jpg_e15&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=101&_nc_ohc=h1meNjT6IE4AX8PH89f&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA1MDk0MDM2MzMwNTM0NTEyNQ%3D%3D.2-ccb7-5&oh=00_AfBS9yTstYQKBcpO79j5DlCBAW2uPqmgBGuI9eifUX2O1Q&oe=640C1C96&_nc_sid=1527a3",
#     timestamp: "04/03/2023, 08:12",
#     insta_profile: InstaProfile.find_by(username: "delhaizebelgium")
#   },
#   {
#     caption: "Thank you AUSTIN! Had a blast with you last night at @moodycenteratx 🔥

#     📸 @dhallphoto",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/333613030_935678120792831_5453115563550685924_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=111&_nc_ohc=lKLAJYKQFO4AX-cgzIM&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA0OTA1ODA2NjY5MjEyNDc1Mw%3D%3D.2-ccb7-5&oh=00_AfDxdL8Ro2Wyg4dEBTarbK40jjk3IVnerOdkM7S-MfY4BQ&oe=640C2210&_nc_sid=1527a3",
#     timestamp: "02/03/2023, 18:12",
#     insta_profile: InstaProfile.find_by(username: "evanescenceofficial")
#   },
#   {
#     caption: "🚨NEW MERCH ALERT 🚨

#     Head to our online store to check out some brand new merch items from the 2023 tour!

#     *LINK IN BIO*",
#     media_url: "https://scontent-bru2-1.cdninstagram.com/v/t51.2885-15/334200422_1319471928621274_5589257953928886138_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-bru2-1.cdninstagram.com&_nc_cat=110&_nc_ohc=aIAZzdQV7uIAX_TAy4h&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzA0ODQzMzg5Nzk5NTY3MjEzMg%3D%3D.2-ccb7-5&oh=00_AfCexTpvRO0TkkEkgF3ToSpbqJjfx3tQ41A45rX7EVb_kw&oe=640B4633&_nc_sid=1527a3",
#     timestamp: "01/03/2023, 12:15",
#     insta_profile: InstaProfile.find_by(username: "evanescenceofficial")
#   }
# ]

# insta_posts_data.each do |post|
#   new_post = InstaPost.new(
#     caption: post[:caption],
#     media_url: post[:media_url],
#     timestamp: post[:timestamp],
#     insta_profile: post[:insta_profile]
#   )

#   if new_post.valid?
#     new_post.save
#     puts "New post (#{new_post.id}) saved."
#   else
#     puts "Post failed to save for #{post.insta_profile}."
#     puts "Errors: #{new_post.errors.messages}"
#   end
# end

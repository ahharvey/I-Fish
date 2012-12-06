Desa.destroy_all
Desa.create(name: "test1 desa")

Fish.destroy_all
Fish.create(family: "Squatinidae", genus: "Squatina", species: "australis", local_name: "Australian Angelshark", english_name: "Australian Angelshark", code: "111")
Fish.create(family: "Muraenidae", genus: "Gymnothorax", species: "eurostus", local_name: "Abbott's Moray", english_name: "Abbott's Moray", code: "112")
Fish.create(family: "Ceratodontidae", genus: "Neoceratodus", species: "forsteri", local_name: "Australian Lungfish", english_name: "Australian Lungfish", code: "113")
Fish.create(family: "Centropomidae", genus: "Lates", species: "calcarifer", local_name: "Barramundi", english_name: "Barramundi", code: "114")
Fish.create(family: "Serranidae", genus: "Chromileptes", species: "altivelis", local_name: "Barramundi Cod", english_name: "Barramundi Cod", code: "115")

role_public = Role.create(name: "public")
role_staff = Role.create(name: "staff")
role_supervisor = Role.create(name: "supervisor")
role_admin = Role.create(name: "administrator")

admin1 = Admin.create(email: "admin@fish.com", name: "Admin Adminson", password: "admin1", password_confirmation: "admin1")

user_public = User.create(email: "public@fish.com", name: "Public McPublic", password: "public1", password_confirmation: "public1")
user_public.roles.push role_public

user_staff = User.create(email: "staff@fish.com", name: "staff1", password: "staff1", password_confirmation: "staff1")
user_staff.roles.push role_staff

user_supervisor = User.create(email: "supervisor@fish.com", name: "supervisor1", password: "supervisor1", password_confirmation: "supervisor1")
user_supervisor.roles.push role_supervisor
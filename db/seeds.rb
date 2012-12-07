# Desas
desa1 = Desa.create(name: "Jakarta", lat: -6.21154, lng: 106.84517)
desa2 = Desa.create(name: "Bandung", lat: -6.91474, lng: 107.60981)

# Fish
Fish.create(family: "Squatinidae", genus: "Squatina", species: "australis", local_name: "Australian Angelshark", english_name: "Australian Angelshark", code: "111")
Fish.create(family: "Muraenidae", genus: "Gymnothorax", species: "eurostus", local_name: "Abbott's Moray", english_name: "Abbott's Moray", code: "112")
Fish.create(family: "Ceratodontidae", genus: "Neoceratodus", species: "forsteri", local_name: "Australian Lungfish", english_name: "Australian Lungfish", code: "113")
Fish.create(family: "Centropomidae", genus: "Lates", species: "calcarifer", local_name: "Barramundi", english_name: "Barramundi", code: "114")
Fish.create(family: "Serranidae", genus: "Chromileptes", species: "altivelis", local_name: "Barramundi Cod", english_name: "Barramundi Cod", code: "115")

# Offices
office1 = Office.create(name: "Test office 1")

# Roles
role_public = Role.create(name: "public")
role_staff = Role.create(name: "staff")
role_supervisor = Role.create(name: "supervisor")
role_admin = Role.create(name: "administrator")

# Administrators
admin1 = office1.admins.create(email: "admin@fish.com",
  name: "Admin Adminson",
  password: "admin1",
  password_confirmation: "admin1")

# Users
user_public1 = desa1.users.create(email: "public@fish.com",
  name: "Public McPublic 1",
  password: "public1",
  password_confirmation: "public1")
user_public2 = desa1.users.create(email: "public@fish.com",
  name: "Public McPublic 2",
  password: "public2",
  password_confirmation: "public2")


user_staff1 = User.create(email: "staff1@fish.com",
	name: "staff1",
	password: "staff1",
	password_confirmation: "staff1",
	desa_id: desa1.id)
user_staff1.roles.push role_staff
user_staff2 = User.create(email: "staff2@fish.com",
	name: "staff2",
	password: "staff2",
	password_confirmation: "staff2",
	desa_id: desa2.id)
user_staff2.roles.push role_staff

user_supervisor1 = User.create(email: "supervisor1@fish.com",
	name: "supervisor1",
	password: "supervisor1",
	password_confirmation: "supervisor1",
	desa_id: desa2.id)
user_supervisor1.roles.push role_supervisor
user_supervisor2 = User.create(email: "supervisor2@fish.com",
	name: "supervisor2",
	password: "supervisor2",
	password_confirmation: "supervisor2",
	desa_id: desa2.id)
user_supervisor2.roles.push role_supervisor

# Surveys
survey1 = user_staff1.surveys.create!(:date => DateTime.now.to_s,
	start_time: DateTime.now - 50,
	start_time: DateTime.now + 50,
	desa_id: desa1.id,
	observer: "Test observer1",
	measure: "Test measure1",
	scribe: "Test scribe1",
	fishery: "Test fishery1")
survey2 = user_staff2.surveys.create!(:date => DateTime.now.to_s,
	start_time: DateTime.now - 50,
	start_time: DateTime.now + 50,
	desa_id: desa2.id,
	observer: "Test observer2",
	measure: "Test measure2",
	scribe: "Test scribe2",
	fishery: "Test fishery2")
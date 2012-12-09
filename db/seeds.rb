# Desas
desa1 = Desa.create(name: "Jakarta", lat: -6.21154, lng: 106.84517)
desa2 = Desa.create(name: "Bandung", lat: -6.91474, lng: 107.60981)

# Fish
fish1 = Fish.create(order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Auxis rochei", english_name: "Bullet tuna", indonesia_name: "Lisong", code: "BLT")
fish2 = Fish.create(order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Auxis thazard", english_name: "Firgate tuna", indonesia_name: "Tongkol krai", code: "FRI")
fish3 = Fish.create(order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Euthynnus affinis", fishbase_name: "Kawakawa", english_name: "Kawa kawa/Eastern little tuna", indonesia_name: "Tongkol komo", code: "KAW")
fish4 = Fish.create(scientific_name: "Katsuwanus pelamis", english_name: "Skipjack tuna", indonesia_name: "Cakalang")

# Fisheries
fishery1 = Fishery.create(name: "Fishery ABC", code: "ABC")
fishery2 = Fishery.create(name: "Fishery DEF", code: "DEF")
fishery3 = Fishery.create(name: "Fishery GHI", code: "GHI")
fishery4 = Fishery.create(name: "Fishery JKL", code: "JKL")

# Gears
gear1 = Gear.create(alpha_code: "PS1-K", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin pelagis kecil dengan satu kapal", num_code: "01.1.1.1", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "One boat operated purse seines")
gear2 = Gear.create(alpha_code: "PS1-B", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin pelagis besar dengan satu kapal", num_code: "01.1.1.2", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "One boat operated purse seines")
gear3 = Gear.create(alpha_code: "PS2-K", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin group pelagis kecil", num_code: "01.1.2.1", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "Two boat operated purse seines")
gear4 = Gear.create(alpha_code: "PS2-B", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin group pelagis besar", num_code: "01.1.2.2", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "Two boat operated purse seines")
gear5 = Gear.create(alpha_code: "LA", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "LA", num_code: "01.2.0", sub_cat_eng: "Without purse lines/lampara", sub_cat_ind: "Jaring lingkar tanpa tali kerut")

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
survey1 = user_staff1.surveys.create!(start_time: DateTime.now - 50,
	end_time: DateTime.now + 50,
	desa_id: desa1.id,
	fishery_id: fishery1.id,
	fleet_observer: "Test observer1",
	catch_measure: "Test measure1",
	catch_scribe: "Test scribe1",
	date_published: DateTime.now - 4.months)
survey1 = user_staff1.surveys.create!(start_time: DateTime.now - 50,
	end_time: DateTime.now + 50,
	desa_id: desa1.id,
	fishery_id: fishery1.id,
	fleet_observer: "Test observer1",
	catch_measure: "Test measure1",
	catch_scribe: "Test scribe1",
	date_published: DateTime.now - 5.months)
survey2 = user_staff2.surveys.create!(start_time: DateTime.now - 50,
	end_time: DateTime.now + 50,
	desa_id: desa2.id,
	fishery_id: fishery2.id,
	fleet_observer: "Test observer2",
	catch_measure: "Test measure2",
	catch_scribe: "Test scribe2",
	date_published: DateTime.now - 2.months)

# Landings
landing1 = Landing.create(gear_id: gear1.id,
	survey_id: survey1.id,
	quantity: 100,
	weight: 500,
	time_out: DateTime.new(2012, 6, 1),
	time_in: DateTime.new(2012, 6, 8))
landing2 = Landing.create(gear_id: gear1.id,
	survey_id: survey1.id,
	quantity: 200,
	weight: 800,
	time_out: DateTime.new(2012, 6, 9),
	time_in: DateTime.new(2012, 6, 20))
landing3 = Landing.create(gear_id: gear1.id,
	survey_id: survey1.id,
	quantity: 200,
	weight: 800,
	time_out: DateTime.new(2012, 6, 9),
	time_in: DateTime.new(2012, 6, 20))

# catches
catch1 = Catch.create(fish_id: fish1.id,
	landing_id: landing1.id,
	length: 50,
	weight: 500)
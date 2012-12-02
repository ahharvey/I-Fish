Desa.destroy_all
Desa.create(name: "desa1", code: 'desa1')

Fish.destroy_all
Fish.create(order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Auxis rochei", english_name: "Bullet tuna", indonesia_name: "Lisong", code: "BLT")
Fish.create(order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Auxis thazard", english_name: "Firgate tuna", indonesia_name: "Tongkol krai", code: "FRI")
Fish.create(order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Euthynnus affinis", fishbase_name: "Kawakawa", english_name: "Kawa kawa/Eastern little tuna", indonesia_name: "Tongkol komo", code: "KAW")
Fish.create(scientific_name: "Katsuwanus pelamis", english_name: "Skipjack tuna", indonesia_name: "Cakalang")

Gear.destroy_all
Gear.create(alpha_code: "PS1-K", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin pelagis kecil dengan satu kapal", num_code: "01.1.1.1", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "One boat operated purse seines")
Gear.create(alpha_code: "PS1-B", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin pelagis besar dengan satu kapal", num_code: "01.1.1.2", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "One boat operated purse seines")
Gear.create(alpha_code: "PS2-K", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin group pelagis kecil", num_code: "01.1.2.1", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "Two boat operated purse seines")
Gear.create(alpha_code: "PS2-B", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "PS", name: "Pukat cincin group pelagis besar", num_code: "01.1.2.2", sub_cat_eng: "With purse lines/Purse seine", sub_cat_ind: "Jaring lingkar bertali kerut", type_ind: "Pukat cincin dengan satu kapal", type_eng: "Two boat operated purse seines")
Gear.create(alpha_code: "LA", cat_eng: "Surrounding nets", cat_ind: "Jaring lingkar", fao_code: "LA", num_code: "01.2.0", sub_cat_eng: "Without purse lines/lampara", sub_cat_ind: "Jaring lingkar tanpa tali kerut")
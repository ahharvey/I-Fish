
Admin.delete_all
Catch.delete_all
Desa.delete_all
District.delete_all
Engine.delete_all
ExcelFile.delete_all
Fish.delete_all
Fishery.delete_all
Gear.delete_all
Graticule.delete_all
Landing.delete_all
Logbook.delete_all
LoggedDay.delete_all
Office.delete_all
Province.delete_all
Role.delete_all
Survey.delete_all
User.delete_all
VesselType.delete_all


fishery = Fishery.create([
  { name: "Lombok Strait small pelagic", code: "LOM-PS" },
  { name: "Lombok Strait large pelagic", code: "LOM-PL" }
]) 

engine = Engine.create([
  { name: "Outboard", code: "OB" },
  { name: "Longtail", code: "LT" },
  { name: "Inboard", code: "IB" }
]) 

gear = Gear.create([
	{ cat_ind: "Jaring lingkar", cat_eng: "Surrounding nets", sub_cat_ind: "Jaring lingkar bertali kerut", sub_cat_eng: "With purse lines/Purse seine", type_ind: "Pukat cincin dengan satu kapal", type_eng: "One boat operated purse seines", name: "Pukat cincin pelagis kecil dengan satu kapal", alpha_code: "PS1-K", num_code: "01.1.1.1", fao_code: "PS" },
	{ cat_ind: "Jaring lingkar", cat_eng: "Surrounding nets", sub_cat_ind: "Jaring lingkar bertali kerut", sub_cat_eng: "With purse lines/Purse seine", type_ind: "Pukat cincin dengan satu kapal", type_eng: "One boat operated purse seines", name: "Pukat cincin pelagis besar dengan satu kapal", alpha_code: "PS1-B", num_code: "01.1.1.2", fao_code: "PS" },
	{ cat_ind: "Jaring lingkar", cat_eng: "Surrounding nets", sub_cat_ind: "Jaring lingkar bertali kerut", sub_cat_eng: "With purse lines/Purse seine", type_ind: "Pukat cincin dengan dua kapal", type_eng: "Two boat operated purse seines", name: "Pukat cincin grup pelagis kecil", alpha_code: "PS2-K", num_code: "01.1.2.1", fao_code: "PS" },
	{ cat_ind: "Jaring lingkar", cat_eng: "Surrounding nets", sub_cat_ind: "Jaring lingkar bertali kerut", sub_cat_eng: "With purse lines/Purse seine", type_ind: "Pukat cincin dengan dua kapal", type_eng: "Two boat operated purse seines", name: "Pukat cincin grup pelagis besar", alpha_code: "PS2-B", num_code: "01.1.2.2", fao_code: "PS" },
	{ cat_ind: "Jaring lingkar", cat_eng: "Surrounding nets", sub_cat_ind: "Jaring lingkar tanpa tali kerut", sub_cat_eng: "Without purse lines/Lampara", type_ind: "", type_eng: "", name: "", alpha_code: "LA", num_code: "01.2.0", fao_code: "LA" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik pantai", sub_cat_eng: "Beach seines", type_ind: "", type_eng: "", name: "", alpha_code: "SB", num_code: "02.1.0", fao_code: "SB" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik berkapal", sub_cat_eng: "Boat or vessel seines", type_ind: "Dogol", type_eng: "", name: "Danish seines", alpha_code: "SDN", num_code: "02.2.1", fao_code: "SV" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik berkapal", sub_cat_eng: "Boat or vessel seines", type_ind: "", type_eng: "", name: "Scottish seines", alpha_code: "SSC", num_code: "02.2.2", fao_code: "SV" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik berkapal", sub_cat_eng: "Boat or vessel seines", type_ind: "", type_eng: "", name: "Pair seines", alpha_code: "SPR", num_code: "02.2.3", fao_code: "SV" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik berkapal", sub_cat_eng: "Boat or vessel seines", type_ind: "", type_eng: "", name: "Payang", alpha_code: "SV-PYG", num_code: "02.2.0.1", fao_code: "SV" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik berkapal", sub_cat_eng: "Boat or vessel seines", type_ind: "", type_eng: "", name: "Cantrang", alpha_code: "SV-CTG", num_code: "02.2.0.2", fao_code: "SV" },
	{ cat_ind: "Pukat Tarik", cat_eng: "Seine nets", sub_cat_ind: "Pukat tarik berkapal", sub_cat_eng: "Boat or vessel seines", type_ind: "", type_eng: "", name: "Lampara dasar", alpha_code: "SV-LDS", num_code: "02.2.0.3", fao_code: "SV" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela dasar", sub_cat_eng: "Bottom trawls", type_ind: "Pukat hela dasar berpalang", type_eng: "Beam trawl", name: "", alpha_code: "TBB", num_code: "03.1.1", fao_code: "TBB" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela dasar", sub_cat_eng: "Bottom trawls", type_ind: "Pukat hela dasar berpapan", type_eng: "Otter trawls", name: "", alpha_code: "OTB", num_code: "03.1.2", fao_code: "OTB" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela dasar", sub_cat_eng: "Bottom trawls", type_ind: "Pukat hela dasar dua kapal", type_eng: "Pair trawls", name: "", alpha_code: "PTB", num_code: "03.1.3", fao_code: "PTB" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela dasar", sub_cat_eng: "Bottom trawls", type_ind: "Nephrops trawl", type_eng: "Nephrops trawl", name: "", alpha_code: "TBN", num_code: "03.1.4", fao_code: "TBB" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela dasar", sub_cat_eng: "Bottom trawls", type_ind: "Pukat hela dasar udang", type_eng: "Shrimp trawls", name: "Pukat udang", alpha_code: "TBS-PU", num_code: "03.1.5.1", fao_code: "TBB" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela pertengahan", sub_cat_eng: "Midwater trawls", type_ind: "Pukat hela pertengahan berpapan", type_eng: "Otter trawls", name: "Pukat ikan", alpha_code: "OTM-PI", num_code: "03.2.1.1", fao_code: "OTM" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela pertengahan", sub_cat_eng: "Midwater trawls", type_ind: "Pukat hela pertengahan dua kapal", type_eng: "Pair trawls", name: "", alpha_code: "PTM", num_code: "03.2.2", fao_code: "PTM" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela pertengahan", sub_cat_eng: "Midwater trawls", type_ind: "Pukat hela pertengahan udang", type_eng: "Shrimp trawls", name: "", alpha_code: "TMS", num_code: "03.2.3", fao_code: "TM" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat hela kembar berpapan", sub_cat_eng: "Otter twin trawls", type_ind: "", type_eng: "", name: "", alpha_code: "OTT", num_code: "03.3.0", fao_code: "OTT" },
	{ cat_ind: "Pukat hela", cat_eng: "Trawls", sub_cat_ind: "Pukat dorong", sub_cat_eng: "", type_ind: "", type_eng: "", name: "", alpha_code: "TX-PD", num_code: "03.9.0.1", fao_code: "TX" },
	{ cat_ind: "Penggaruk", cat_eng: "Dredges", sub_cat_ind: "Penggaruk berkapal", sub_cat_eng: "Boat dredges", type_ind: "", type_eng: "", name: "", alpha_code: "DRB", num_code: "04.1.0", fao_code: "DRB" },
	{ cat_ind: "Penggaruk", cat_eng: "Dredges", sub_cat_ind: "Penggaruk tanpa kapal", sub_cat_eng: "Hand dredges", type_ind: "", type_eng: "", name: "", alpha_code: "DRH", num_code: "04.2.0", fao_code: "DRH" },
	{ cat_ind: "Jaring angkat", cat_eng: "Lift nets", sub_cat_ind: "Anco", sub_cat_eng: "Portable lift nets", type_ind: "", type_eng: "", name: "", alpha_code: "LNP", num_code: "05.1.0", fao_code: "LNP" },
	{ cat_ind: "Jaring angkat", cat_eng: "Lift nets", sub_cat_ind: "Jaring angkat berperahu", sub_cat_eng: "Boat-operated lift nets", type_ind: "Bagan berperahu", type_eng: "", name: "", alpha_code: "LNP-BP", num_code: "05.2.0.1", fao_code: "LNP" },
	{ cat_ind: "Jaring angkat", cat_eng: "Lift nets", sub_cat_ind: "Jaring angkat berperahu", sub_cat_eng: "Boat-operated lift nets", type_ind: "Bouke ami", type_eng: "", name: "", alpha_code: "LNB-BA", num_code: "05.2.0.2", fao_code: "LNB" },
	{ cat_ind: "Jaring angkat", cat_eng: "Lift nets", sub_cat_ind: "Jaring angkat berperahu", sub_cat_eng: "Boat-operated lift nets", type_ind: "Bagan tancap", type_eng: "Shore-operated stationary lift nets", name: "", alpha_code: "LNS", num_code: "05.3.0", fao_code: "LNS" },
	{ cat_ind: "Yang dijatuhkan atau ditebarkan", cat_eng: "Falling gear", sub_cat_ind: "Jala jatuh berkapal", sub_cat_eng: "Cast nets", type_ind: "", type_eng: "", name: "", alpha_code: "FCN", num_code: "06.1.0", fao_code: "FCN" },
	{ cat_ind: "Yang dijatuhkan atau ditebarkan", cat_eng: "Falling gear", sub_cat_ind: "Jala tebar", sub_cat_eng: "Falling gear not specified", type_ind: "", type_eng: "", name: "", alpha_code: "FG", num_code: "06.9.0", fao_code: "FG" },
	{ cat_ind: "Jaring Insang", cat_eng: "Gillnets and entangling nets", sub_cat_ind: "Jaring insang tetap", sub_cat_eng: "Set gillnets (anchored)", type_ind: "", type_eng: "", name: "Jaring Liong bun", alpha_code: "GNS-LB", num_code: "07.1.0.1", fao_code: "GNS" },
	{ cat_ind: "Jaring Insang", cat_eng: "Gillnets and entangling nets", sub_cat_ind: "Jaring insang hanyut", sub_cat_eng: "Drifnets", type_ind: "", type_eng: "", name: "Jaring gillnet oseanik", alpha_code: "GND-OC", num_code: "07.2.0.1", fao_code: "GND" },
	{ cat_ind: "Jaring Insang", cat_eng: "Gillnets and entangling nets", sub_cat_ind: "Jaring insang lingkar", sub_cat_eng: "Encircling gillnets", type_ind: "", type_eng: "", name: "", alpha_code: "GNC", num_code: "07.3.0", fao_code: "GNC" },
	{ cat_ind: "Jaring Insang", cat_eng: "Gillnets and entangling nets", sub_cat_ind: "Jaring insang berpancang", sub_cat_eng: "Fixed gillnets (on stakes)", type_ind: "", type_eng: "", name: "", alpha_code: "GNI", num_code: "07.4.0", fao_code: "GNF" },
	{ cat_ind: "Jaring Insang", cat_eng: "Gillnets and entangling nets", sub_cat_ind: "Jaring insang berlapis", sub_cat_eng: "Trammel nets", type_ind: "", type_eng: "", name: "Jaring klitik", alpha_code: "GTR-JK", num_code: "07.5.0.1", fao_code: "GTR" },
	{ cat_ind: "Jaring Insang", cat_eng: "Gillnets and entangling nets", sub_cat_ind: "", sub_cat_eng: "Combined gillnets-trammel nets", type_ind: "", type_eng: "", name: "", alpha_code: "GTN", num_code: "07.6.0", fao_code: "GTN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "Stationary uncovered pound nets", type_ind: "", type_eng: "", name: "Set net", alpha_code: "FPN", num_code: "08.1.0", fao_code: "FPN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "Bubu", sub_cat_eng: "Pots", type_ind: "", type_eng: "", name: "", alpha_code: "FPO", num_code: "08.2.0", fao_code: "FPO" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "Bubu bersayap", sub_cat_eng: "Fyke nets", type_ind: "", type_eng: "", name: "", alpha_code: "FYK", num_code: "08.3.0", fao_code: "FYK" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "Stow nets", type_ind: "Pukat labuh", type_eng: "Long bag set net", name: "", alpha_code: "FSN-PL", num_code: "08.4.0.1", fao_code: "FSN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "", type_ind: "Togo", type_eng: "", name: "", alpha_code: "FSN-TG", num_code: "08.4.0.2", fao_code: "FSN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "", type_ind: "Ambai", type_eng: "", name: "", alpha_code: "FSN-AB", num_code: "08.4.0.3", fao_code: "FSN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "", type_ind: "Jermal", type_eng: "", name: "", alpha_code: "FSN-JM", num_code: "08.4.0.4", fao_code: "FSN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "", type_ind: "Pengerih", type_eng: "", name: "", alpha_code: "FSN-PG", num_code: "08.4.0.5", fao_code: "FSN" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "", sub_cat_eng: "Barriers, fences, weirs", type_ind: "", type_eng: "", name: "Sero", alpha_code: "FWR-SR", num_code: "08.5.0.1", fao_code: "FWR" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "Perangkap Ikan Peloncat", sub_cat_eng: "Aerial traps", type_ind: "", type_eng: "", name: "", alpha_code: "FWR", num_code: "08.6.0", fao_code: "FWR" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "Muro ami", sub_cat_eng: "", type_ind: "", type_eng: "", name: "", alpha_code: "FIX-MA", num_code: "08.9.0.1", fao_code: "FIX" },
	{ cat_ind: "Perangkap", cat_eng: "Traps", sub_cat_ind: "Seser", sub_cat_eng: "", type_ind: "", type_eng: "", name: "", alpha_code: "FIX-SS", num_code: "08.9.0.2", fao_code: "FIX" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "", sub_cat_eng: "Handlines and pole-lines/hand operated", type_ind: "Pancing ulur", type_eng: "", name: "", alpha_code: "LHP-PU", num_code: "09.1.0.1", fao_code: "LHP" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "", sub_cat_eng: "Handlines and pole-lines/hand operated", type_ind: "Pancing berjoran", type_eng: "", name: "", alpha_code: "LHP-PJ", num_code: "09.1.0.2", fao_code: "LHP" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "", sub_cat_eng: "Handlines and pole-lines/hand operated", type_ind: "Huhate", type_eng: "", name: "", alpha_code: "LHP-PH", num_code: "09.1.0.3", fao_code: "LHP" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "", sub_cat_eng: "Handlines and pole-lines/hand operated", type_ind: "", type_eng: "Squid angling", name: "", alpha_code: "LHP-SA", num_code: "09.1.0.4", fao_code: "LHP" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "", sub_cat_eng: "Handlines and pole-lines/mechanized", type_ind: "", type_eng: "Squid jiggling", name: "", alpha_code: "LHM-PC", num_code: "09.2.0.1", fao_code: "LHM" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "", sub_cat_eng: "Handlines and pole-lines/mechanized", type_ind: "Huhate mekanis", type_eng: "", name: "", alpha_code: "LHM-HM", num_code: "09.2.0.2", fao_code: "LHM" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "Rawai dasar", sub_cat_eng: "Set long lines", type_ind: "", type_eng: "", name: "", alpha_code: "LLS", num_code: "09.3.0", fao_code: "LLS" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "Rawai hanyut", sub_cat_eng: "Drifting long lines", type_ind: "Rawai tuna", type_eng: "", name: "", alpha_code: "LLD-RT", num_code: "09.4.0.1", fao_code: "LLD" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "Rawai hanyut", sub_cat_eng: "Drifting long lines", type_ind: "Rawai cucut", type_eng: "", name: "", alpha_code: "LLD-RC", num_code: "09.4.0.2", fao_code: "LLD" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "Tonda", sub_cat_eng: "Trolling lines", type_ind: "", type_eng: "", name: "", alpha_code: "LTL", num_code: "09.6.0", fao_code: "LTL" },
	{ cat_ind: "Pancing", cat_eng: "Hooks and Lines", sub_cat_ind: "Pancing layang-layang", sub_cat_eng: "", type_ind: "", type_eng: "", name: "", alpha_code: "LX-LY", num_code: "09.9.0.1", fao_code: "LX" },
	{ cat_ind: "Penjepit dan Melukai", cat_eng: "Grappling and Wounding", sub_cat_ind: "Tombak", sub_cat_eng: "Harpoons", type_ind: "Ladung", type_eng: "", name: "", alpha_code: "HAR-LD", num_code: "10.0.0.1", fao_code: "HAR" },
	{ cat_ind: "Penjepit dan Melukai", cat_eng: "Grappling and Wounding", sub_cat_ind: "Tombak", sub_cat_eng: "Harpoons", type_ind: "Panah", type_eng: "", name: "", alpha_code: "HAR-PN", num_code: "10.0.0.2", fao_code: "HAR" }
])

fish = Fish.create([
	{ order: "", family: "", scientific_name: "Netuma thalassina", fishbase_name: "Giant catfish", english_name: "Giant catfish", indonesia_name: "Manyung", code: "" },
	{ order: "BELONIFORMES", family: "Belonidae", scientific_name: "Belonidae", fishbase_name: "", english_name: "Needle fish", indonesia_name: "Cendro", code: "BEN" },
	{ order: "BELONIFORMES", family: "Belonidae", scientific_name: "Tylosurus spp", fishbase_name: "", english_name: "Needle fish", indonesia_name: "Cendro", code: "NED" },
	{ order: "PLEURONECTIFORMES", family: "Psettodidae", scientific_name: "Psettodidae", fishbase_name: "", english_name: "Indian halibut/Queensland halibut", indonesia_name: "Ikan sebelah", code: "HPX" },
	{ order: "PERCOIDEI", family: "Caesionidae", scientific_name: "Caesio cuning", fishbase_name: "Redbelly yellowtail fusilier", english_name: "Redbelly yellowtail fusilier", indonesia_name: "Ekor kuning/Pisang-pisang", code: "CJU" },
	{ order: "PERCOIDEI", family: "Caesionidae", scientific_name: "Caesio caerulaurea", fishbase_name: "Blue and gold fusilier", english_name: "Blue and gold fusilier", indonesia_name: "Lolosi biru", code: "CJC" },
	{ order: "", family: "", scientific_name: "Selaroides spp", fishbase_name: "", english_name: "Trevallies", indonesia_name: "Selar", code: "" },
	{ order: "PERCOIDEI", family: "Carangidae", scientific_name: "Caranx spp", fishbase_name: "", english_name: "Jack trevallies", indonesia_name: "Kuwe", code: "TRE" },
	{ order: "PERCOIDEI", family: "Carangidae", scientific_name: "Decapterus spp", fishbase_name: "", english_name: "Scad", indonesia_name: "Layang", code: "SDX" },
	{ order: "", family: "", scientific_name: "Elagatis bipinnulatus", fishbase_name: "", english_name: "Rainbow runner", indonesia_name: "Sunglir", code: "" },
	{ order: "PERCOIDEI", family: "Carangidae", scientific_name: "Megalaspis cordyla", fishbase_name: "Torpedo scad", english_name: "Torpedo Scad", indonesia_name: "Tetengkek", code: "HAS" },
	{ order: "", family: "", scientific_name: "Formio niger", fishbase_name: "", english_name: "Black pomfret", indonesia_name: "Bawal hitam", code: "" },
	{ order: "STROMATEOIDEI, ANABANTOIDEI", family: "Stromateidae", scientific_name: "Pampus argenteus", fishbase_name: "Silver pomfret", english_name: "Silver pomfret", indonesia_name: "Bawal putih", code: "SIP" },
	{ order: "", family: "", scientific_name: "Chorinemus spp", fishbase_name: "", english_name: "Queen fish", indonesia_name: "Daun bambu/Talang-talang", code: "" },
	{ order: "PERCOIDEI", family: "Carangidae", scientific_name: "Selar boops", fishbase_name: "Oxeye scad", english_name: "Oxeye scad", indonesia_name: "Bentong", code: "LRO" },
	{ order: "PERCOIDEI", family: "Carangidae", scientific_name: "Selar crumenophthalmus", fishbase_name: "Bigeye scad", english_name: "Bigeye scad", indonesia_name: "Bentong", code: "BIS" },
	{ order: "PERCOIDEI", family: "Centropomidae", scientific_name: "Lates calcarifer", fishbase_name: "Barramundi", english_name: "Barramundi/Giant sea perch", indonesia_name: "Kakap putih", code: "GIP" },
	{ order: "CLUPEIFORMES", family: "Chirocentridae", scientific_name: "Chirocentrus dorab", fishbase_name: "Dorab wolf-herring", english_name: "Dorab wolf herring", indonesia_name: "Golok-golok", code: "DOB" },
	{ order: "", family: "", scientific_name: "Anodonstoma chacunda", fishbase_name: "", english_name: "Chacunda gizard shad", indonesia_name: "Selanget", code: "" },
	{ order: "CLUPEIFORMES", family: "Clupeidae", scientific_name: "Amblygaster sirm", fishbase_name: "Spotted sardinella", english_name: "Spotted sardinella", indonesia_name: "Siro", code: "AGS" },
	{ order: "CLUPEIFORMES", family: "Clupeidae", scientific_name: "Dussumieria acuta", fishbase_name: "Rainbow sardine", english_name: "Rainbow sardine", indonesia_name: "Japuh", code: "RAS" },
	{ order: "CLUPEIFORMES", family: "Clupeidae", scientific_name: "Sardinella fimbriata", fishbase_name: "", english_name: "Fringescale sardinella", indonesia_name: "Tembang", code: "FRS" },
	{ order: "CLUPEIFORMES", family: "Clupeidae", scientific_name: "Sardinella gibbosa", fishbase_name: "Goldstripe sardinella", english_name: "Goldstripe sardinella", indonesia_name: "Tembang", code: "SAG" },
	{ order: "CLUPEIFORMES", family: "Clupeidae", scientific_name: "Sardinella lemuru", fishbase_name: "Bali sardinella", english_name: "Bali sardinella", indonesia_name: "Lemuru", code: "SAM" },
	{ order: "CLUPEIFORMES", family: "Clupeidae", scientific_name: "Tenualosa ilisha", fishbase_name: "", english_name: "Hilsa shad", indonesia_name: "Terubuk", code: "HIL" },
	{ order: "PERCOIDEI", family: "Coryphaenidae", scientific_name: "Coryphaena hippurus", fishbase_name: "Common dolphinfish", english_name: "Common dolphin fish", indonesia_name: "Lemadang", code: "DOL" },
	{ order: "AULOPIFORMES", family: "Synodontidae", scientific_name: "Saurida tumbil", fishbase_name: "Greater lizardfish", english_name: "Greater lizardfish", indonesia_name: "Beloso/Buntut kebo", code: "LIG" },
	{ order: "PLEURONECTIFORMES", family: "Cynoglossidae", scientific_name: "Cynoglossus spp", fishbase_name: "", english_name: "Tongue soles", indonesia_name: "Ikan lidah", code: "YOX" },
	{ order: "", family: "", scientific_name: "Pleuronectus spp", fishbase_name: "", english_name: "Tongue soles", indonesia_name: "Ikan lidah", code: "" },
	{ order: "CLUPEIFORMES", family: "Engraulidae", scientific_name: "Stolephorus spp", fishbase_name: "", english_name: "Anchovies", indonesia_name: "Teri", code: "STO" },
	{ order: "BELONIFORMES", family: "Exocoetidae", scientific_name: "Cypselurus spp", fishbase_name: "", english_name: "Flying fish", indonesia_name: "Ikan terbang", code: "YPX" },
	{ order: "", family: "", scientific_name: "Hemirhampus spp", fishbase_name: "", english_name: "Garfish and Halfbeaks", indonesia_name: "Julung-julung", code: "" },
	{ order: "PERCOIDEI", family: "Haemulidae", scientific_name: "Pomadasys maculatus", fishbase_name: "Saddle grunt", english_name: "Saddle grunt/Spotted javelinfish", indonesia_name: "Gerot-gerot", code: "PKL" },
	{ order: "PERCOIDEI", family: "Haemulidae", scientific_name: "Plectorhinchus spp", fishbase_name: "", english_name: "Sweetlips", indonesia_name: "Ikan gaji", code: "PBX" },
	{ order: "AULOPIFORMES", family: "Synodontidae", scientific_name: "Harpadon nehereus", fishbase_name: "Bombay-duck", english_name: "Bombay duck", indonesia_name: "Ikan nomei/Lomei", code: "BUC" },
	{ order: "SCOMBROIDEI", family: "Istiophoridae", scientific_name: "Istiophorus platypterus", fishbase_name: "Indo-Pacific sailfish", english_name: "Indo-pacific sailfish", indonesia_name: "Ikan layaran", code: "SFA" },
	{ order: "SCOMBROIDEI", family: "Istiophoridae", scientific_name: "Makaira indica", fishbase_name: "", english_name: "Black marlin", indonesia_name: "Setuhuk hitam", code: "BLM" },
	{ order: "", family: "", scientific_name: "Makaira mazarra", fishbase_name: "", english_name: "Indo-pacific blue marlin", indonesia_name: "Setuhuk biru", code: "" },
	{ order: "SCOMBROIDEI", family: "Istiophoridae", scientific_name: "Tetrapturus audax", fishbase_name: "", english_name: "Striped marlin", indonesia_name: "Setuhuk loreng", code: "MLS" },
	{ order: "SCOMBROIDEI", family: "Xiphiidae", scientific_name: "Xiphias gladius", fishbase_name: "Swordfish", english_name: "Swordfish", indonesia_name: "Ikan pedang", code: "SWO" },
	{ order: "PERCOIDEI", family: "Labridae", scientific_name: "Cheilinus undulatus", fishbase_name: "Humphead wrasse", english_name: "Napoleon wrasse/Humphead wrasse", indonesia_name: "Ikan napoleon", code: "HVM" },
	{ order: "PERCOIDEI", family: "Lactariidae", scientific_name: "Lactarius lactarius", fishbase_name: "False trevally", english_name: "Fals trevally", indonesia_name: "Kapas-kapas", code: "TRF" },
	{ order: "PERCOIDEI", family: "Leiognathidae", scientific_name: "Leiognathus spp", fishbase_name: "", english_name: "Slipmouths/Pony fishes", indonesia_name: "Peperek", code: "POY" },
	{ order: "PERCOIDEI", family: "Lethrinidae", scientific_name: "Lethrinus spp", fishbase_name: "", english_name: "Emperors", indonesia_name: " Lencam", code: "LZX" },
	{ order: "PERCOIDEI", family: "Lutjanidae", scientific_name: "Lutjanus spp", fishbase_name: "", english_name: "Red snappers", indonesia_name: " Kakap merah/Bambangan", code: "SNA" },
	{ order: "PERCOIDEI", family: "Lutjanidae", scientific_name: "Pristipomoides multidens", fishbase_name: "Goldbanded jobfish", english_name: "Goldenbanded jobfish", indonesia_name: "Pinjalo", code: "LRI" },
	{ order: "PERCOIDEI", family: "Lutjanidae", scientific_name: "Pristipomoides typus", fishbase_name: "Sharptooth jobfish", english_name: "Sharptooth jobfish", indonesia_name: "Pinjalo", code: "LRU" },
	{ order: "MUGILIFORMES", family: "Mugilidae", scientific_name: "Mugil cephalus", fishbase_name: "Flathead grey mullet", english_name: "Mangrove mullets", indonesia_name: "Belanak", code: "MUF" },
	{ order: "MUGILIFORMES", family: "Mugilidae", scientific_name: "Valamugil seheli", fishbase_name: "", english_name: "Blue-spot mullet/Blue-tail mullet", indonesia_name: "Belanak", code: "VMH" },
	{ order: "PERCOIDEI", family: "Mullidae", scientific_name: "Parupeneus indicus", fishbase_name: "Indian goatfish", english_name: "Indian goatfish", indonesia_name: "Biji nangka karang", code: "RFQ" },
	{ order: "PERCOIDEI", family: "Mullidae", scientific_name: "Upeneus sulphureus", fishbase_name: "Sulphur goatfish", english_name: "Sulphur goatfish", indonesia_name: "Kuniran", code: "UPS" },
	{ order: "PERCOIDEI", family: "Mullidae", scientific_name: "Upeneus vittatus", fishbase_name: "Yellowstriped goatfish", english_name: "Yellow-strip goatfish", indonesia_name: "Biji nangka karang", code: "UPI" },
	{ order: "", family: "", scientific_name: "Nemimterus hexodon", fishbase_name: "", english_name: "Ornate treafin bream", indonesia_name: "Kurisi", code: "" },
	{ order: "PERCOIDEI", family: "Polynemidae", scientific_name: "Eleutheronema tetradactylum", fishbase_name: "Fourfinger threadfin", english_name: "Four finger treadfin", indonesia_name: "Kurau", code: "FOT" },
	{ order: "PERCOIDEI", family: "Polynemidae", scientific_name: "Polynemus spp", fishbase_name: "", english_name: "Treadfin", indonesia_name: " Kuro/Senangin", code: "QTX" },
	{ order: "PERCOIDEI", family: "Priacanthidae", scientific_name: "Priacanthus tayenus", fishbase_name: "Purple-spotted bigeye", english_name: "Purple-spotted/Big eye", indonesia_name: "Swangi/Mata besar", code: "PQY" },
	{ order: "", family: "", scientific_name: "Priacanthus marcracanthus", fishbase_name: "", english_name: "Red big eye", indonesia_name: "Serinding tembakau", code: "" },
	{ order: "PERCOIDEI", family: "Sciaenidae", scientific_name: "Nibea albiflora", fishbase_name: "", english_name: "Croacker", indonesia_name: "Gulamah/Tigawaja", code: "YED" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Auxis rochei", fishbase_name: "", english_name: "Bullet tuna", indonesia_name: "Lisong", code: "BLT" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Auxis thazard", fishbase_name: "", english_name: "Firgate tuna", indonesia_name: "Tongkol krai", code: "FRI" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Euthynnus affinis", fishbase_name: "Kawakawa", english_name: "Kawa kawa/Eastern little tuna", indonesia_name: "Tongkol komo", code: "KAW" },
	{ order: "", family: "", scientific_name: "Katsuwanus pelamis", fishbase_name: "", english_name: "Skipjack tuna", indonesia_name: "Cakalang", code: "" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Rastrelliger brachysoma", fishbase_name: "Short mackerel", english_name: "Short-body mackerel", indonesia_name: "Kembung", code: "RAB" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Rastrelliger kanagurta", fishbase_name: "Indian mackerel", english_name: "Indian mackerel", indonesia_name: "Banyar", code: "RAG" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Sarda orientalis", fishbase_name: "Striped bonito", english_name: "Striped bonito", indonesia_name: "Kenyar", code: "BIP" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Scomber australasicus", fishbase_name: "Blue mackerel", english_name: "Spotted chub mackerel", indonesia_name: "Slengseng", code: "MAA" },
	{ order: "", family: "", scientific_name: "Scomberomorus cammerson", fishbase_name: "", english_name: "Narrow-barred spanish mackerel", indonesia_name: "Tenggiri", code: "" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Scomberomorus guttatus", fishbase_name: "Indo-Pacific king mackerel", english_name: "Indo-pacific king mackerel", indonesia_name: "Tenggiri papan", code: "GUT" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Thunnus alalunga", fishbase_name: "Albacore", english_name: "Albacore", indonesia_name: "Albakora", code: "ALB" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Thunnus albacares", fishbase_name: "Yellowfin tuna", english_name: "Yellowfin tuna", indonesia_name: "Madidihang", code: "YFT" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Thunnus maccoyii", fishbase_name: "Southern bluefin tuna", english_name: "Southern bluefin tuna", indonesia_name: "Tuna sirip biru selatan", code: "SBF" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Thunnus obesus", fishbase_name: "Bigeye tuna", english_name: "Bigeye tuna", indonesia_name: "Tuna mata besar", code: "BET" },
	{ order: "SCOMBROIDEI", family: "Scombridae", scientific_name: "Thunnus tonggol", fishbase_name: "Longtail tuna", english_name: "Longtail tuna", indonesia_name: "Tongkol abu-abu", code: "LOT" },
	{ order: "", family: "", scientific_name: "Cephalophodis boenack", fishbase_name: "", english_name: "Blue lined seabass", indonesia_name: "Kerapu karang", code: "" },
	{ order: "PERCOIDEI", family: "Serranidae", scientific_name: "Cromileptes altivelis", fishbase_name: "Humpback grouper", english_name: "Humpback hind", indonesia_name: "Kerapu bebek", code: "MPV" },
	{ order: "PERCOIDEI", family: "Serranidae", scientific_name: "Epinephelus merra", fishbase_name: "Honeycomb grouper", english_name: "Honeycomb grouper", indonesia_name: "Kerapu balong", code: "EER" },
	{ order: "PERCOIDEI", family: "Serranidae", scientific_name: "Epinephelus tauvina", fishbase_name: "Greasy grouper", english_name: "Greasy rockcod/Estuary rockcod", indonesia_name: "Kerapu lumpur", code: "EPT" },
	{ order: "PERCOIDEI", family: "Serranidae", scientific_name: "Plectropomus leopardus", fishbase_name: "Leopard coralgrouper", english_name: "Leopard coralgrouper", indonesia_name: "Kerapu sunu", code: "EMO" },
	{ order: "ACANTHUROIDEI", family: "Siganidae", scientific_name: "Siganus canaliculatus", fishbase_name: "White-spotted spinefoot", english_name: "White-spotted spinefoot", indonesia_name: "Beronang lingkis", code: "SCN" },
	{ order: "ACANTHUROIDEI", family: "Siganidae", scientific_name: "Siganus guttatus", fishbase_name: "Goldlined spinefoot", english_name: "Orange-spotted spinefoot", indonesia_name: "Ikan beronang", code: "SGU" },
	{ order: "ACANTHUROIDEI", family: "Siganidae", scientific_name: "Siganus virgatus", fishbase_name: "Barhead spinefoot", english_name: "Barhed spinefoot", indonesia_name: "Beronang kuning", code: "IUG" },
	{ order: "", family: "", scientific_name: "Silago sihama", fishbase_name: "", english_name: "Sivler silago", indonesia_name: "Rejung", code: "" },
	{ order: "OTHER PERCIFORMES", family: "Sphyraenidae", scientific_name: "Sphyraena barracuda", fishbase_name: "Great barracuda", english_name: "Great barracuda", indonesia_name: "Alu-alu/Manggilala/Pucul", code: "GBA" },
	{ order: "OTHER PERCIFORMES", family: "Sphyraenidae", scientific_name: "Sphyraena jello", fishbase_name: "Pickhandle barracuda", english_name: "Pickhandel barracuda", indonesia_name: "Senuk", code: "BAC" },
	{ order: "PERCOIDEI", family: "Terapontidae", scientific_name: "Terapon jarbua", fishbase_name: "Jarbua terapon", english_name: "Jarbua terapon", indonesia_name: "Kerong-kerong", code: "TJB" },
	{ order: "PERCOIDEI", family: "Terapontidae", scientific_name: "Terapon theraps", fishbase_name: "Largescaled terapon", english_name: "Largescale terapon", indonesia_name: "Kerong-kerong", code: "TEH" },
	{ order: "SCOMBROIDEI", family: "Trichiuridae", scientific_name: "Trichiurus spp", fishbase_name: "", english_name: "Hairtails", indonesia_name: "Layur", code: "TCW" },
	{ order: "LAMNIFORMES", family: "Alopiidae", scientific_name: "Alopias spp", fishbase_name: "", english_name: "Thresher sharks", indonesia_name: "Cucut tikus, Cucut moneyt", code: "THR" },
	{ order: "CARCHARHINIFORMES", family: "Carcharhinidae", scientific_name: "Carcharhinus spp", fishbase_name: "", english_name: "Requiem sharks (ground sharks, blue sharks, sharpnose sharks)", indonesia_name: "Cucut lanyam", code: "CWZ" },
	{ order: "LAMNIFORMES", family: "Lamnidae", scientific_name: "Isurus spp", fishbase_name: "", english_name: "Mackerel sharks, Makos, White sharks, Porbeagles", indonesia_name: "Mako", code: "MAK" },
	{ order: "", family: "", scientific_name: "Pristis spp", fishbase_name: "", english_name: "Sawfishes", indonesia_name: "Ikan gergaji", code: "" },
	{ order: "", family: "", scientific_name: "Eusphyra blochi", fishbase_name: "", english_name: "Wingehead", indonesia_name: "Cucut martil", code: "" },
	{ order: "", family: "", scientific_name: "Sphyma spp", fishbase_name: "", english_name: "Hammerhead sharks", indonesia_name: "Capingan", code: "" },
	{ order: "SQUALIFORMES", family: "Squalidae", scientific_name: "Squalus spp", fishbase_name: "", english_name: "Dogfish sharks", indonesia_name: "Cucut botol", code: "DGZ" },
	{ order: "RAJIFORMES", family: "Dasyatidae", scientific_name: "Dasyatis spp", fishbase_name: "", english_name: "Stingrays", indonesia_name: "Pari kembang", code: "STI" },
	{ order: "RAJIFORMES", family: "Dasyatidae", scientific_name: "Dasyatis spp", fishbase_name: "", english_name: "Stingrays", indonesia_name: "Pari macan", code: "STI" },
	{ order: "RAJIFORMES", family: "Mobulidae", scientific_name: "Mobula spp", fishbase_name: "", english_name: "Devilrays", indonesia_name: "Pari kelelawar", code: "RMV" },
	{ order: "RAJIFORMES", family: "Mobulidae", scientific_name: "Mobula spp", fishbase_name: "", english_name: "Mantarays", indonesia_name: "Pari kelelawar", code: "RMV" },
	{ order: "", family: "", scientific_name: "Myliobatus spp", fishbase_name: "", english_name: "Eaglerays", indonesia_name: "Pari burung", code: "" },
	{ order: "RAJIFORMES", family: "Myliobatidae", scientific_name: "Aetobatus spp", fishbase_name: "", english_name: "Eaglerays", indonesia_name: "Pari burung", code: "AQX" },
	{ order: "RAJIFORMES", family: "Myliobatidae", scientific_name: "Aetomylaeus spp", fishbase_name: "", english_name: "Eaglerays", indonesia_name: "Pari burung", code: "RJX" },
	{ order: "RAJIFORMES", family: "Rhinobatidae", scientific_name: "Rhina ancylostoma", fishbase_name: "Bowmouth guitarfish", english_name: "Guitarfishes", indonesia_name: "Pari hidung sekop", code: "RRY" },
	{ order: "RAJIFORMES", family: "Rhinobatidae", scientific_name: "Rhina ancylostoma", fishbase_name: "Bowmouth guitarfish", english_name: "Shovelnose rays", indonesia_name: "Pari hidung sekop", code: "RRY" },
	{ order: "RAJIFORMES", family: "Rhinobatidae", scientific_name: "Rhynchobatus djiddensis", fishbase_name: "Giant guitarfish", english_name: "Whitespotted wedgefishes", indonesia_name: "Pari kekeh", code: "RCD" },
	{ order: "", family: "", scientific_name: "-", fishbase_name: "", english_name: "All fishes other than those listed above", indonesia_name: "Ikan-ikan yang lain", code: "" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Metapenaeus ensis", fishbase_name: "", english_name: "Endeavour prawn/shrimp, Bluetail endeavour prawn/shrimp, Red greasiback", indonesia_name: "Udang dogol", code: "MPE" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Metapenaeus monoceros", fishbase_name: "", english_name: "Endeavour prawn/shrimp, Bluetail endeavour prawn/shrimp, Red greasiback", indonesia_name: "Udang dogol", code: "MPN" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Penaeus merguiensis", fishbase_name: "", english_name: "Banana prawn/White shrimp", indonesia_name: "Udang putih/Jerbung", code: "PBA" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Penaeus indicus", fishbase_name: "", english_name: "Banana prawn/Indian", indonesia_name: "Udang putih/Jerbung", code: "PNI" },
	{ order: "", family: "", scientific_name: "Parapenaeopsis sculptitis", fishbase_name: "", english_name: "Tiger cat shrimp/Rainbow shrimp", indonesia_name: "Udang krosok", code: "" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Penaeus latisulcatus", fishbase_name: "", english_name: "King/Blue legged prawn", indonesia_name: "Udang ratu/raja", code: "WKP" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Penaeus monodon", fishbase_name: "", english_name: "Jumbo tiger prawn/shrimp, Giant tiger prawn/shrimp, Blue tiger prawn", indonesia_name: "Udang windu", code: "GIT" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Penaeus semisulcatus", fishbase_name: "", english_name: "Jumbo tiger prawn/Brown tiger prawn", indonesia_name: "Udang windu", code: "TIP" },
	{ order: "NATANTIA", family: "Penaeidae", scientific_name: "Penaeus esculentus", fishbase_name: "", english_name: "Tiger prawn/Brown tiger prawn", indonesia_name: "Udang windu", code: "PRB" },
	{ order: "REPTANTIA", family: "Palinuridae", scientific_name: "Panulirus versicolor", fishbase_name: "", english_name: "Spiny lobster", indonesia_name: "Udang barong/Udang karang", code: "NUV" },
	{ order: "", family: "", scientific_name: "-", fishbase_name: "", english_name: "Other shrimps", indonesia_name: "Udang lainnya", code: "" },
	{ order: "BRACHYURA", family: "Portunidae", scientific_name: "Scylla serrata", fishbase_name: "", english_name: "Mangrove mud crab", indonesia_name: "Kepiting", code: "MUD" },
	{ order: "BRACHYURA", family: "Portunidae", scientific_name: "Portunus pelagicus", fishbase_name: "", english_name: "Swimming crab", indonesia_name: "Rajungan", code: "SCD" },
	{ order: "", family: "", scientific_name: "Cheolina mydas", fishbase_name: "", english_name: "Marine turtles", indonesia_name: "Penyu", code: "" },
	{ order: "", family: "", scientific_name: "-", fishbase_name: "", english_name: "All crustaceans other than those listed above", indonesia_name: "Binatang berkulit keras lainnya", code: "" },
	{ order: "BIVALVIA", family: "Arcidae", scientific_name: "Anadara granosa", fishbase_name: "", english_name: "Blood cockles", indonesia_name: "Kerang darah", code: "BLC" },
	{ order: "BIVALVIA", family: "Mytilidae", scientific_name: "Perna viridis", fishbase_name: "", english_name: "Green mussels", indonesia_name: "Kerang hijau", code: "MSV" },
	{ order: "CEPHALOPODA", family: "Loliginidae", scientific_name: "Loligo spp", fishbase_name: "", english_name: "Common squids", indonesia_name: "Cumi-cumi", code: "SQC" },
	{ order: "CEPHALOPODA", family: "Octopodidae", scientific_name: "Octopus spp", fishbase_name: "", english_name: "Octupuses", indonesia_name: "Gurita", code: "OCZ" },
	{ order: "BIVALVIA", family: "Ostreidae", scientific_name: "Crassostrea gigas", fishbase_name: "", english_name: "Pacific oyster", indonesia_name: "Tiram", code: "OYG" },
	{ order: "", family: "", scientific_name: "Amusium spp", fishbase_name: "", english_name: "Scallops", indonesia_name: "Simping", code: "" },
	{ order: "BIVALVIA", family: "Pteriidae", scientific_name: "Pinctada margaritifera", fishbase_name: "", english_name: "Black-lip pearl oyster", indonesia_name: "Kerang mutiara/Tapis-tapis", code: "PNM" },
	{ order: "CEPHALOPODA", family: "Sepiidae", scientific_name: "Sepia spp", fishbase_name: "", english_name: "Cuttle fish", indonesia_name: "Sotong", code: "IAX" },
	{ order: "", family: "", scientific_name: "Trochus (Teptus) nilotic", fishbase_name: "", english_name: "Top shell", indonesia_name: "Lola/Susu bundar", code: "" },
	{ order: "BIVALVIA", family: "Veneridae", scientific_name: "Meretrix spp", fishbase_name: "", english_name: "Clams", indonesia_name: "Remis", code: "HCX" },
	{ order: "", family: "", scientific_name: "-", fishbase_name: "", english_name: "All molluscs other than those listed above", indonesia_name: "Binatang lunak lainnya", code: "" },
	{ order: "", family: "", scientific_name: "Stichopus spp", fishbase_name: "", english_name: "Sea cucumber", indonesia_name: "Teripang", code: "" },
	{ order: "", family: "", scientific_name: "Aulleta spp", fishbase_name: "", english_name: "Sponge", indonesia_name: "Bunga karang", code: "" },
	{ order: "SCYPHOZOA", family: "Rhizostomidae", scientific_name: "Rhopilema spp", fishbase_name: "", english_name: "Jelly fish", indonesia_name: "Ubur-ubur", code: "JEL" },
	{ order: "", family: "", scientific_name: "-", fishbase_name: "", english_name: "All aquaitc animals other than those listed above", indonesia_name: "Binatang air lainnya", code: "" },
	{ order: "", family: "", scientific_name: "Euchema spp", fishbase_name: "", english_name: "Sea weeds", indonesia_name: "Rumput laut", code: "" },
	{ order: "", family: "", scientific_name: "Gracillia spp", fishbase_name: "", english_name: "Sea weeds", indonesia_name: "Rumput laut", code: "" },
	{ order: "", family: "", scientific_name: "Aetomylaeus spp", fishbase_name: "", english_name: "Sea weeds", indonesia_name: "Rumput laut", code: "RJX" }
])

# Provinces
prov11	= Province.create( name: "Nanggroe Aceh Darussalam", code: "11")
prov12	= Province.create( name: "Sumatera Utara", code: "12")
prov13	= Province.create( name: "Sumatera Barat", code: "13")
prov14	= Province.create( name: "Riau", code: "14")
prov15	= Province.create( name: "Jambi", code: "15")
prov16	= Province.create( name: "Sumatera Selatan", code: "16")
prov17	= Province.create( name: "Bengkulu", code: "17")
prov18	= Province.create( name: "Lampung", code: "18")
prov19	= Province.create( name: "Kep. Bangka Belitung", code: "19")
prov21	= Province.create( name: "Kep. Riau", code: "21")
prov31	= Province.create( name: "DKI Jakarta", code: "31")
prov32	= Province.create( name: "Jawa Barat", code: "32")
prov33	= Province.create( name: "Jawa Tengah", code: "33")
prov34	= Province.create( name: "DI Yogyakarta", code: "34")
prov35	= Province.create( name: "Jawa Timur", code: "35")
prov36	= Province.create( name: "Banten", code: "36")
prov51	= Province.create( name: "Bali", code: "51")
prov52	= Province.create( name: "Nusa Tenggara Barat", code: "52")
prov53	= Province.create( name: "Nusa Tenggara Timur", code: "53")
prov61	= Province.create( name: "Kalimantan Barat", code: "61")
prov62	= Province.create( name: "Kalimantan Tengah", code: "62")
prov63	= Province.create( name: "Kalimantan Selatan", code: "63")
prov64	= Province.create( name: "Kalimantan Timur", code: "64")
prov71	= Province.create( name: "Sulawesi Utara", code: "71")
prov72	= Province.create( name: "Sulawesi Tengah", code: "72")
prov73	= Province.create( name: "Sulawesi Selatan", code: "73")
prov74	= Province.create( name: "Sulawesi Tenggara", code: "74")
prov75	= Province.create( name: "Gorontalo", code: "75")
prov76	= Province.create( name: "Sulawesi Barat", code: "76")
prov81	= Province.create( name: "Maluku", code: "81")
prov82	= Province.create( name: "Maluku Utara", code: "82")
prov91	= Province.create( name: "Papua Barat", code: "91")
prov94	= Province.create( name: "Papua", code: "94")

# Districts
dist1101	= District.create( name: "Simeulue", code: "1101", province_id: prov11.id)
dist1102	= District.create( name: "Aceh Singkil", code: "1102", province_id: prov11.id)
dist1103	= District.create( name: "Aceh Selatan", code: "1103", province_id: prov11.id)
dist1104	= District.create( name: "Aceh Tenggara", code: "1104", province_id: prov11.id)
dist1105	= District.create( name: "Aceh Timur", code: "1105", province_id: prov11.id)
dist1106	= District.create( name: "Aceh Tengah", code: "1106", province_id: prov11.id)
dist1107	= District.create( name: "Aceh Barat", code: "1107", province_id: prov11.id)
dist1108	= District.create( name: "Aceh Besar", code: "1108", province_id: prov11.id)
dist1109	= District.create( name: "Pidie", code: "1109", province_id: prov11.id)
dist1110	= District.create( name: "Bireuen", code: "1110", province_id: prov11.id)
dist1111	= District.create( name: "Aceh Utara", code: "1111", province_id: prov11.id)
dist1112	= District.create( name: "Aceh Barat Daya", code: "1112", province_id: prov11.id)
dist1113	= District.create( name: "Gayo Lues", code: "1113", province_id: prov11.id)
dist1114	= District.create( name: "Aceh Tamiang", code: "1114", province_id: prov11.id)
dist1115	= District.create( name: "Nagan Raya", code: "1115", province_id: prov11.id)
dist1116	= District.create( name: "Aceh Jaya", code: "1116", province_id: prov11.id)
dist1117	= District.create( name: "Bener Meriah", code: "1117", province_id: prov11.id)
dist1118	= District.create( name: "Pidie Jaya", code: "1118", province_id: prov11.id)
dist1171	= District.create( name: "Kota Banda Aceh", code: "1171", province_id: prov11.id)
dist1172	= District.create( name: "Kota Sabang", code: "1172", province_id: prov11.id)
dist1173	= District.create( name: "Kota Langsa", code: "1173", province_id: prov11.id)
dist1174	= District.create( name: "Kota Lhokseumawe", code: "1174", province_id: prov11.id)
dist1175	= District.create( name: "Kota Subulussalam", code: "1175", province_id: prov11.id)
dist1201	= District.create( name: "N i a s", code: "1201", province_id: prov12.id)
dist1202	= District.create( name: "Mandailing Natal", code: "1202", province_id: prov12.id)
dist1203	= District.create( name: "Tapanuli Selatan", code: "1203", province_id: prov12.id)
dist1204	= District.create( name: "Tapanuli Tengah", code: "1204", province_id: prov12.id)
dist1205	= District.create( name: "Tapanuli Utara", code: "1205", province_id: prov12.id)
dist1206	= District.create( name: "Toba Samosir", code: "1206", province_id: prov12.id)
dist1207	= District.create( name: "Labuhan Batu", code: "1207", province_id: prov12.id)
dist1208	= District.create( name: "Asahan", code: "1208", province_id: prov12.id)
dist1209	= District.create( name: "Simalungun", code: "1209", province_id: prov12.id)
dist1210	= District.create( name: "Dairi", code: "1210", province_id: prov12.id)
dist1211	= District.create( name: "K a r o", code: "1211", province_id: prov12.id)
dist1212	= District.create( name: "Deli Serdang", code: "1212", province_id: prov12.id)
dist1213	= District.create( name: "Langkat", code: "1213", province_id: prov12.id)
dist1214	= District.create( name: "Nias Selatan", code: "1214", province_id: prov12.id)
dist1215	= District.create( name: "Humbang Hasundutan", code: "1215", province_id: prov12.id)
dist1216	= District.create( name: "Pakpak Bharat", code: "1216", province_id: prov12.id)
dist1217	= District.create( name: "Samosir", code: "1217", province_id: prov12.id)
dist1218	= District.create( name: "Serdang Bedagai", code: "1218", province_id: prov12.id)
dist1219	= District.create( name: "Batu Bara", code: "1219", province_id: prov12.id)
dist1220	= District.create( name: "Padang Lawas Utara", code: "1220", province_id: prov12.id)
dist1221	= District.create( name: "Padang Lawas", code: "1221", province_id: prov12.id)
dist1271	= District.create( name: "Kota Sibolga", code: "1271", province_id: prov12.id)
dist1272	= District.create( name: "Kota Tanjung Balai", code: "1272", province_id: prov12.id)
dist1273	= District.create( name: "Kota Pematang Siantar", code: "1273", province_id: prov12.id)
dist1274	= District.create( name: "Kota Tebing Tinggi", code: "1274", province_id: prov12.id)
dist1275	= District.create( name: "Kota Medan", code: "1275", province_id: prov12.id)
dist1276	= District.create( name: "Kota Binjai", code: "1276", province_id: prov12.id)
dist1277	= District.create( name: "Kota Padang Sidempuan", code: "1277", province_id: prov12.id)
dist1301	= District.create( name: "Kep	 Mentawa", code: "1301", province_id: prov13.id)
dist1302	= District.create( name: "Pesisir Selatan", code: "1302", province_id: prov13.id)
dist1303	= District.create( name: "Solok", code: "1303", province_id: prov13.id)
dist1304	= District.create( name: "Sawahlunto/Sijunjung", code: "1304", province_id: prov13.id)
dist1305	= District.create( name: "Tanah Datar", code: "1305", province_id: prov13.id)
dist1306	= District.create( name: "Padang Pariaman", code: "1306", province_id: prov13.id)
dist1307	= District.create( name: "A g a m", code: "1307", province_id: prov13.id)
dist1308	= District.create( name: "Lima Puluh Koto", code: "1308", province_id: prov13.id)
dist1309	= District.create( name: "Pasaman", code: "1309", province_id: prov13.id)
dist1310	= District.create( name: "Solok Selatan", code: "1310", province_id: prov13.id)
dist1311	= District.create( name: "Dharmasraya", code: "1311", province_id: prov13.id)
dist1312	= District.create( name: "Pasaman Barat", code: "1312", province_id: prov13.id)
dist1371	= District.create( name: "Kota Padang", code: "1371", province_id: prov13.id)
dist1372	= District.create( name: "Kota Solok", code: "1372", province_id: prov13.id)
dist1373	= District.create( name: "Kota Sawahlunto", code: "1373", province_id: prov13.id)
dist1374	= District.create( name: "Kota Padang Panjang", code: "1374", province_id: prov13.id)
dist1375	= District.create( name: "Kota Bukit Tinggi", code: "1375", province_id: prov13.id)
dist1376	= District.create( name: "Kota Payakumbuh", code: "1376", province_id: prov13.id)
dist1377	= District.create( name: "Kota Pariaman", code: "1377", province_id: prov13.id)
dist1401	= District.create( name: "Kuantan Senggigi", code: "1401", province_id: prov14.id)
dist1402	= District.create( name: "Indragiri Hulu", code: "1402", province_id: prov14.id)
dist1403	= District.create( name: "Indragiri Hilir", code: "1403", province_id: prov14.id)
dist1404	= District.create( name: "Pelalawan", code: "1404", province_id: prov14.id)
dist1405	= District.create( name: "S i a k", code: "1405", province_id: prov14.id)
dist1406	= District.create( name: "Kampar", code: "1406", province_id: prov14.id)
dist1407	= District.create( name: "Rokan Hulu", code: "1407", province_id: prov14.id)
dist1408	= District.create( name: "Bengkalis", code: "1408", province_id: prov14.id)
dist1409	= District.create( name: "Rokan Hilir", code: "1409", province_id: prov14.id)
dist1471	= District.create( name: "Kota Pekan Baru", code: "1471", province_id: prov14.id)
dist1473	= District.create( name: "Kota Dumai", code: "1473", province_id: prov14.id)
dist1501	= District.create( name: "Kerinci", code: "1501", province_id: prov15.id)
dist1502	= District.create( name: "Merangin", code: "1502", province_id: prov15.id)
dist1503	= District.create( name: "Sarolangun", code: "1503", province_id: prov15.id)
dist1504	= District.create( name: "Batang Hari", code: "1504", province_id: prov15.id)
dist1505	= District.create( name: "Muaro Jambi", code: "1505", province_id: prov15.id)
dist1506	= District.create( name: "Tjg Jabung Timur", code: "1506", province_id: prov15.id)
dist1507	= District.create( name: "Tjg Jabung Barat", code: "1507", province_id: prov15.id)
dist1508	= District.create( name: "T e b o", code: "1508", province_id: prov15.id)
dist1509	= District.create( name: "Bungo", code: "1509", province_id: prov15.id)
dist1571	= District.create( name: "Kota Jambi", code: "1571", province_id: prov15.id)
dist1601	= District.create( name: "Ogan Komering Ulu", code: "1601", province_id: prov16.id)
dist1602	= District.create( name: "Ogan Komering Ilir", code: "1602", province_id: prov16.id)
dist1603	= District.create( name: "Muara Enim", code: "1603", province_id: prov16.id)
dist1604	= District.create( name: "Lahat", code: "1604", province_id: prov16.id)
dist1605	= District.create( name: "Musi Rawas", code: "1605", province_id: prov16.id)
dist1606	= District.create( name: "Musi Banyuasin", code: "1606", province_id: prov16.id)
dist1607	= District.create( name: "Banyuasin", code: "1607", province_id: prov16.id)
dist1608	= District.create( name: "OKU Selatan", code: "1608", province_id: prov16.id)
dist1609	= District.create( name: "OKU Timur", code: "1609", province_id: prov16.id)
dist1610	= District.create( name: "Ogan Ilir", code: "1610", province_id: prov16.id)
dist1611	= District.create( name: "Empat Lawang", code: "1611", province_id: prov16.id)
dist1671	= District.create( name: "Kota Palembang", code: "1671", province_id: prov16.id)
dist1672	= District.create( name: "Kota Prabumulih", code: "1672", province_id: prov16.id)
dist1673	= District.create( name: "Kota Pagar Alam", code: "1673", province_id: prov16.id)
dist1674	= District.create( name: "Kota Lubuk Linggau", code: "1674", province_id: prov16.id)
dist1701	= District.create( name: "Bengkulu Selatan", code: "1701", province_id: prov17.id)
dist1702	= District.create( name: "Rejang Lebong", code: "1702", province_id: prov17.id)
dist1703	= District.create( name: "Bengkulu Utara", code: "1703", province_id: prov17.id)
dist1704	= District.create( name: "K a u r", code: "1704", province_id: prov17.id)
dist1705	= District.create( name: "Seluma", code: "1705", province_id: prov17.id)
dist1706	= District.create( name: "Muko Muko", code: "1706", province_id: prov17.id)
dist1707	= District.create( name: "Lebong", code: "1707", province_id: prov17.id)
dist1708	= District.create( name: "Kepahiang", code: "1708", province_id: prov17.id)
dist1771	= District.create( name: "Kota Bengkulu", code: "1771", province_id: prov17.id)
dist1801	= District.create( name: "Lampung Barat", code: "1801", province_id: prov18.id)
dist1802	= District.create( name: "Tanggamus", code: "1802", province_id: prov18.id)
dist1803	= District.create( name: "Lampung Selatan", code: "1803", province_id: prov18.id)
dist1804	= District.create( name: "Lampung Timur", code: "1804", province_id: prov18.id)
dist1805	= District.create( name: "Lampung Tengah", code: "1805", province_id: prov18.id)
dist1806	= District.create( name: "Lampung Utara", code: "1806", province_id: prov18.id)
dist1807	= District.create( name: "Way Kanan", code: "1807", province_id: prov18.id)
dist1808	= District.create( name: "Tulang Bawang", code: "1808", province_id: prov18.id)
dist1809	= District.create( name: "Pesawaran", code: "1809", province_id: prov18.id)
dist1871	= District.create( name: "Kota Bandar Lampung", code: "1871", province_id: prov18.id)
dist1872	= District.create( name: "Kota Metro", code: "1872", province_id: prov18.id)
dist1901	= District.create( name: "Bangka", code: "1901", province_id: prov19.id)
dist1902	= District.create( name: "Belitung", code: "1902", province_id: prov19.id)
dist1903	= District.create( name: "Bangka Barat", code: "1903", province_id: prov19.id)
dist1904	= District.create( name: "Bangka Tengah", code: "1904", province_id: prov19.id)
dist1905	= District.create( name: "Bangka Selatan", code: "1905", province_id: prov19.id)
dist1906	= District.create( name: "Belitung Timur", code: "1906", province_id: prov19.id)
dist1971	= District.create( name: "Kota Pangkal Pinang", code: "1971", province_id: prov19.id)
dist2101	= District.create( name: "Karimun", code: "2101", province_id: prov21.id)
dist2102	= District.create( name: "Bintan", code: "2102", province_id: prov21.id)
dist2103	= District.create( name: "Natuna", code: "2103", province_id: prov21.id)
dist2104	= District.create( name: "Lingga", code: "2104", province_id: prov21.id)
dist2171	= District.create( name: "Kota Batam", code: "2171", province_id: prov21.id)
dist2172	= District.create( name: "Kota Tanjung Pinang", code: "2172", province_id: prov21.id)
dist3101	= District.create( name: "Kepulauan Seribu", code: "3101", province_id: prov31.id)
dist3171	= District.create( name: "Kota Jakarta Selatan", code: "3171", province_id: prov31.id)
dist3172	= District.create( name: "Kota Jakarta Timur", code: "3172", province_id: prov31.id)
dist3173	= District.create( name: "Kota Jakarta Pusat", code: "3173", province_id: prov31.id)
dist3174	= District.create( name: "Kota Jakarta Barat", code: "3174", province_id: prov31.id)
dist3175	= District.create( name: "Kota Jakarta Utara", code: "3175", province_id: prov31.id)
dist3201	= District.create( name: "Bogor", code: "3201", province_id: prov32.id)
dist3202	= District.create( name: "Sukabumi", code: "3202", province_id: prov32.id)
dist3203	= District.create( name: "Cianjur", code: "3203", province_id: prov32.id)
dist3204	= District.create( name: "Bandung", code: "3204", province_id: prov32.id)
dist3205	= District.create( name: "Garut", code: "3205", province_id: prov32.id)
dist3206	= District.create( name: "Tasikmalaya", code: "3206", province_id: prov32.id)
dist3207	= District.create( name: "Ciamis", code: "3207", province_id: prov32.id)
dist3208	= District.create( name: "Kuningan", code: "3208", province_id: prov32.id)
dist3209	= District.create( name: "Cirebon", code: "3209", province_id: prov32.id)
dist3210	= District.create( name: "Majalengka", code: "3210", province_id: prov32.id)
dist3211	= District.create( name: "Sumedang", code: "3211", province_id: prov32.id)
dist3212	= District.create( name: "Indramayu", code: "3212", province_id: prov32.id)
dist3213	= District.create( name: "Subang", code: "3213", province_id: prov32.id)
dist3214	= District.create( name: "Purwakarta", code: "3214", province_id: prov32.id)
dist3215	= District.create( name: "Karawang", code: "3215", province_id: prov32.id)
dist3216	= District.create( name: "Bekasi", code: "3216", province_id: prov32.id)
dist3217	= District.create( name: "Bandung Barat", code: "3217", province_id: prov32.id)
dist3271	= District.create( name: "Kota Bogor", code: "3271", province_id: prov32.id)
dist3272	= District.create( name: "Kota Sukabumi", code: "3272", province_id: prov32.id)
dist3273	= District.create( name: "Kota Bandung", code: "3273", province_id: prov32.id)
dist3274	= District.create( name: "Kota Cirebon", code: "3274", province_id: prov32.id)
dist3275	= District.create( name: "Kota Bekasi", code: "3275", province_id: prov32.id)
dist3276	= District.create( name: "Kota Depok", code: "3276", province_id: prov32.id)
dist3277	= District.create( name: "Kota Cimahi", code: "3277", province_id: prov32.id)
dist3278	= District.create( name: "Kota Tasikmalaya", code: "3278", province_id: prov32.id)
dist3279	= District.create( name: "Kota Banjar", code: "3279", province_id: prov32.id)
dist3301	= District.create( name: "Cilacap", code: "3301", province_id: prov33.id)
dist3302	= District.create( name: "Banyumas", code: "3302", province_id: prov33.id)
dist3303	= District.create( name: "Purbalingga", code: "3303", province_id: prov33.id)
dist3304	= District.create( name: "Banjarnegara", code: "3304", province_id: prov33.id)
dist3305	= District.create( name: "Kebumen", code: "3305", province_id: prov33.id)
dist3306	= District.create( name: "Purworejo", code: "3306", province_id: prov33.id)
dist3307	= District.create( name: "Wonosobo", code: "3307", province_id: prov33.id)
dist3308	= District.create( name: "Magelang", code: "3308", province_id: prov33.id)
dist3309	= District.create( name: "Boyolali", code: "3309", province_id: prov33.id)
dist3310	= District.create( name: "Klaten", code: "3310", province_id: prov33.id)
dist3311	= District.create( name: "Sukoharjo", code: "3311", province_id: prov33.id)
dist3312	= District.create( name: "Wonogiri", code: "3312", province_id: prov33.id)
dist3313	= District.create( name: "Karanganyar", code: "3313", province_id: prov33.id)
dist3314	= District.create( name: "Sragen", code: "3314", province_id: prov33.id)
dist3315	= District.create( name: "Grobogan", code: "3315", province_id: prov33.id)
dist3316	= District.create( name: "Blora", code: "3316", province_id: prov33.id)
dist3317	= District.create( name: "Rembang", code: "3317", province_id: prov33.id)
dist3318	= District.create( name: "P a t i", code: "3318", province_id: prov33.id)
dist3319	= District.create( name: "Kudus", code: "3319", province_id: prov33.id)
dist3320	= District.create( name: "Jepara", code: "3320", province_id: prov33.id)
dist3321	= District.create( name: "Demak", code: "3321", province_id: prov33.id)
dist3322	= District.create( name: "Semarang", code: "3322", province_id: prov33.id)
dist3323	= District.create( name: "Temanggung", code: "3323", province_id: prov33.id)
dist3324	= District.create( name: "Kendal", code: "3324", province_id: prov33.id)
dist3325	= District.create( name: "Batang", code: "3325", province_id: prov33.id)
dist3326	= District.create( name: "Pekalongan", code: "3326", province_id: prov33.id)
dist3327	= District.create( name: "Pemalang", code: "3327", province_id: prov33.id)
dist3328	= District.create( name: "Tegal", code: "3328", province_id: prov33.id)
dist3329	= District.create( name: "Brebes", code: "3329", province_id: prov33.id)
dist3371	= District.create( name: "Kota Magelang", code: "3371", province_id: prov33.id)
dist3372	= District.create( name: "Kota Surakarta", code: "3372", province_id: prov33.id)
dist3373	= District.create( name: "Kota Salatiga", code: "3373", province_id: prov33.id)
dist3374	= District.create( name: "Kota Semarang", code: "3374", province_id: prov33.id)
dist3375	= District.create( name: "Kota Pekalongan", code: "3375", province_id: prov33.id)
dist3376	= District.create( name: "Kota Tegal", code: "3376", province_id: prov33.id)
dist3401	= District.create( name: "Kulon Progo", code: "3401", province_id: prov34.id)
dist3402	= District.create( name: "Bantul", code: "3402", province_id: prov34.id)
dist3403	= District.create( name: "Gunung Kidul", code: "3403", province_id: prov34.id)
dist3404	= District.create( name: "Sleman", code: "3404", province_id: prov34.id)
dist3471	= District.create( name: "Kota Yogyakarta", code: "3471", province_id: prov34.id)
dist3501	= District.create( name: "Pacitan", code: "3501", province_id: prov35.id)
dist3502	= District.create( name: "Ponorogo", code: "3502", province_id: prov35.id)
dist3503	= District.create( name: "Trenggalek", code: "3503", province_id: prov35.id)
dist3504	= District.create( name: "Tulungagung", code: "3504", province_id: prov35.id)
dist3505	= District.create( name: "Blitar", code: "3505", province_id: prov35.id)
dist3506	= District.create( name: "Kediri", code: "3506", province_id: prov35.id)
dist3507	= District.create( name: "Malang", code: "3507", province_id: prov35.id)
dist3508	= District.create( name: "Lumajang", code: "3508", province_id: prov35.id)
dist3509	= District.create( name: "Jember", code: "3509", province_id: prov35.id)
dist3510	= District.create( name: "Banyuwangi", code: "3510", province_id: prov35.id)
dist3511	= District.create( name: "Bondowoso", code: "3511", province_id: prov35.id)
dist3512	= District.create( name: "Situbondo", code: "3512", province_id: prov35.id)
dist3513	= District.create( name: "Probolinggo", code: "3513", province_id: prov35.id)
dist3514	= District.create( name: "Pasuruan", code: "3514", province_id: prov35.id)
dist3515	= District.create( name: "Sidoarjo", code: "3515", province_id: prov35.id)
dist3516	= District.create( name: "Mojokerto", code: "3516", province_id: prov35.id)
dist3517	= District.create( name: "Jombang", code: "3517", province_id: prov35.id)
dist3518	= District.create( name: "Nganjuk", code: "3518", province_id: prov35.id)
dist3519	= District.create( name: "Madiun", code: "3519", province_id: prov35.id)
dist3520	= District.create( name: "Magetan", code: "3520", province_id: prov35.id)
dist3521	= District.create( name: "Ngawi", code: "3521", province_id: prov35.id)
dist3522	= District.create( name: "Bojonegoro", code: "3522", province_id: prov35.id)
dist3523	= District.create( name: "Tuban", code: "3523", province_id: prov35.id)
dist3524	= District.create( name: "Lamongan", code: "3524", province_id: prov35.id)
dist3525	= District.create( name: "Gresik", code: "3525", province_id: prov35.id)
dist3526	= District.create( name: "Bangkalan", code: "3526", province_id: prov35.id)
dist3527	= District.create( name: "Sampang", code: "3527", province_id: prov35.id)
dist3528	= District.create( name: "Pamekasan", code: "3528", province_id: prov35.id)
dist3529	= District.create( name: "Sumenep", code: "3529", province_id: prov35.id)
dist3571	= District.create( name: "Kota Kediri", code: "3571", province_id: prov35.id)
dist3572	= District.create( name: "Kota Blitar", code: "3572", province_id: prov35.id)
dist3573	= District.create( name: "Kota Malang", code: "3573", province_id: prov35.id)
dist3574	= District.create( name: "Kota Probolinggo", code: "3574", province_id: prov35.id)
dist3575	= District.create( name: "Kota Pasuruan", code: "3575", province_id: prov35.id)
dist3576	= District.create( name: "Kota Mojokerto", code: "3576", province_id: prov35.id)
dist3577	= District.create( name: "Kota Madiun", code: "3577", province_id: prov35.id)
dist3578	= District.create( name: "Kota Surabaya", code: "3578", province_id: prov35.id)
dist3579	= District.create( name: "Kota Batu", code: "3579", province_id: prov35.id)
dist3601	= District.create( name: "Pandeglang", code: "3601", province_id: prov36.id)
dist3602	= District.create( name: "Lebak", code: "3602", province_id: prov36.id)
dist3603	= District.create( name: "Tangerang", code: "3603", province_id: prov36.id)
dist3604	= District.create( name: "Serang", code: "3604", province_id: prov36.id)
dist3671	= District.create( name: "Tangerang", code: "3671", province_id: prov36.id)
dist3672	= District.create( name: "Cilegon", code: "3672", province_id: prov36.id)
dist3673	= District.create( name: "Serang", code: "3673", province_id: prov36.id)
dist5101	= District.create( name: "Jembrana", code: "5101", province_id: prov51.id)
dist5102	= District.create( name: "Tabanan", code: "5102", province_id: prov51.id)
dist5103	= District.create( name: "Badung", code: "5103", province_id: prov51.id)
dist5104	= District.create( name: "Gianyar", code: "5104", province_id: prov51.id)
dist5105	= District.create( name: "Klungkung", code: "5105", province_id: prov51.id)
dist5106	= District.create( name: "Bangli", code: "5106", province_id: prov51.id)
dist5107	= District.create( name: "Karang Asem", code: "5107", province_id: prov51.id)
dist5108	= District.create( name: "Buleleng", code: "5108", province_id: prov51.id)
dist5171	= District.create( name: "Kota Denpasar", code: "5171", province_id: prov51.id)
dist5201	= District.create( name: "Lombok Barat", code: "5201", province_id: prov52.id)
dist5202	= District.create( name: "Lombok Tengah", code: "5202", province_id: prov52.id)
dist5203	= District.create( name: "Lombok Timur", code: "5203", province_id: prov52.id)
dist5204	= District.create( name: "Sumbawa", code: "5204", province_id: prov52.id)
dist5205	= District.create( name: "Dompu", code: "5205", province_id: prov52.id)
dist5206	= District.create( name: "B i m a", code: "5206", province_id: prov52.id)
dist5207	= District.create( name: "Sumbawa Barat", code: "5207", province_id: prov52.id)
dist5271	= District.create( name: "Kota Mataram", code: "5271", province_id: prov52.id)
dist5272	= District.create( name: "Kota Bima", code: "5272", province_id: prov52.id)
dist5301	= District.create( name: "Sumba Barat", code: "5301", province_id: prov53.id)
dist5302	= District.create( name: "Sumba Timur", code: "5302", province_id: prov53.id)
dist5303	= District.create( name: "Kupang", code: "5303", province_id: prov53.id)
dist5304	= District.create( name: "Timor Tengah Selatan", code: "5304", province_id: prov53.id)
dist5305	= District.create( name: "Timor Tengah Utara", code: "5305", province_id: prov53.id)
dist5306	= District.create( name: "B e l u", code: "5306", province_id: prov53.id)
dist5307	= District.create( name: "A l o r", code: "5307", province_id: prov53.id)
dist5308	= District.create( name: "Lembata", code: "5308", province_id: prov53.id)
dist5309	= District.create( name: "Flores Timur", code: "5309", province_id: prov53.id)
dist5310	= District.create( name: "Sikka", code: "5310", province_id: prov53.id)
dist5311	= District.create( name: "E n d e", code: "5311", province_id: prov53.id)
dist5312	= District.create( name: "Ngada", code: "5312", province_id: prov53.id)
dist5313	= District.create( name: "Manggarai", code: "5313", province_id: prov53.id)
dist5314	= District.create( name: "Rote Ndao", code: "5314", province_id: prov53.id)
dist5315	= District.create( name: "Manggarai Barat", code: "5315", province_id: prov53.id)
dist5316	= District.create( name: "Sumba Barat Daya", code: "5316", province_id: prov53.id)
dist5317	= District.create( name: "Sumba Tengah", code: "5317", province_id: prov53.id)
dist5318	= District.create( name: "Nagekeo", code: "5318", province_id: prov53.id)
dist5319	= District.create( name: "Manggarai Timur", code: "5319", province_id: prov53.id)
dist5371	= District.create( name: "Kota Kupang", code: "5371", province_id: prov53.id)
dist6101	= District.create( name: "Sambas", code: "6101", province_id: prov61.id)
dist6102	= District.create( name: "Bengkayang", code: "6102", province_id: prov61.id)
dist6103	= District.create( name: "Landak", code: "6103", province_id: prov61.id)
dist6104	= District.create( name: "Pontianak", code: "6104", province_id: prov61.id)
dist6105	= District.create( name: "Sanggau", code: "6105", province_id: prov61.id)
dist6106	= District.create( name: "Ketapang", code: "6106", province_id: prov61.id)
dist6107	= District.create( name: "Sintang", code: "6107", province_id: prov61.id)
dist6108	= District.create( name: "Kapuas Hulu", code: "6108", province_id: prov61.id)
dist6109	= District.create( name: "Sekadau", code: "6109", province_id: prov61.id)
dist6110	= District.create( name: "Melawi", code: "6110", province_id: prov61.id)
dist6111	= District.create( name: "Kayong Utara", code: "6111", province_id: prov61.id)
dist6112	= District.create( name: "Kubu Raya", code: "6112", province_id: prov61.id)
dist6171	= District.create( name: "Kota Pontianak", code: "6171", province_id: prov61.id)
dist6172	= District.create( name: "Kota Singkawang", code: "6172", province_id: prov61.id)
dist6201	= District.create( name: "Kotawaringin Barat", code: "6201", province_id: prov62.id)
dist6202	= District.create( name: "Kotawaringin Timur", code: "6202", province_id: prov62.id)
dist6203	= District.create( name: "Kapuas", code: "6203", province_id: prov62.id)
dist6204	= District.create( name: "Barito Selatan", code: "6204", province_id: prov62.id)
dist6205	= District.create( name: "Barito Utara", code: "6205", province_id: prov62.id)
dist6206	= District.create( name: "Sukamara", code: "6206", province_id: prov62.id)
dist6207	= District.create( name: "Lamandau", code: "6207", province_id: prov62.id)
dist6208	= District.create( name: "Seruyan", code: "6208", province_id: prov62.id)
dist6209	= District.create( name: "Katingan", code: "6209", province_id: prov62.id)
dist6210	= District.create( name: "Pulang Pisau", code: "6210", province_id: prov62.id)
dist6211	= District.create( name: "Gunung Mas", code: "6211", province_id: prov62.id)
dist6212	= District.create( name: "Barito Timur", code: "6212", province_id: prov62.id)
dist6213	= District.create( name: "Murung Raya", code: "6213", province_id: prov62.id)
dist6271	= District.create( name: "Kota Palangka Raya", code: "6271", province_id: prov62.id)
dist6301	= District.create( name: "Tanah Laut", code: "6301", province_id: prov63.id)
dist6302	= District.create( name: "Kota Baru", code: "6302", province_id: prov63.id)
dist6303	= District.create( name: "Banjar", code: "6303", province_id: prov63.id)
dist6304	= District.create( name: "Barito Kuala", code: "6304", province_id: prov63.id)
dist6305	= District.create( name: "Tapin", code: "6305", province_id: prov63.id)
dist6306	= District.create( name: "Hulu Sungai Selatan", code: "6306", province_id: prov63.id)
dist6307	= District.create( name: "Hulu Sungai Tengah", code: "6307", province_id: prov63.id)
dist6308	= District.create( name: "Hulu Sungai Utara", code: "6308", province_id: prov63.id)
dist6309	= District.create( name: "Tabalong", code: "6309", province_id: prov63.id)
dist6310	= District.create( name: "Tanah Bumbu", code: "6310", province_id: prov63.id)
dist6311	= District.create( name: "Balangan", code: "6311", province_id: prov63.id)
dist6371	= District.create( name: "Kota Banjarmasin", code: "6371", province_id: prov63.id)
dist6372	= District.create( name: "Kota Banjar Baru", code: "6372", province_id: prov63.id)
dist6401	= District.create( name: "Pasir", code: "6401", province_id: prov64.id)
dist6402	= District.create( name: "Kutai Barat", code: "6402", province_id: prov64.id)
dist6403	= District.create( name: "Kutai", code: "6403", province_id: prov64.id)
dist6404	= District.create( name: "Kutai Timur", code: "6404", province_id: prov64.id)
dist6405	= District.create( name: "Berau", code: "6405", province_id: prov64.id)
dist6406	= District.create( name: "Malinau", code: "6406", province_id: prov64.id)
dist6407	= District.create( name: "Bulungan", code: "6407", province_id: prov64.id)
dist6408	= District.create( name: "Nunukan", code: "6408", province_id: prov64.id)
dist6409	= District.create( name: "Penajam Paser Utr", code: "6409", province_id: prov64.id)
dist6410	= District.create( name: "Tana Tidung", code: "6410", province_id: prov64.id)
dist6471	= District.create( name: "Kota Balikpapan", code: "6471", province_id: prov64.id)
dist6472	= District.create( name: "Kota Samarinda", code: "6472", province_id: prov64.id)
dist6473	= District.create( name: "Kota Tarakan", code: "6473", province_id: prov64.id)
dist6474	= District.create( name: "Kota Bontang", code: "6474", province_id: prov64.id)
dist7101	= District.create( name: "Bolaang Mongondow", code: "7101", province_id: prov71.id)
dist7102	= District.create( name: "Minahasa", code: "7102", province_id: prov71.id)
dist7103	= District.create( name: "Kep	 Sangihe Talau", code: "7103", province_id: prov71.id)
dist7104	= District.create( name: "Kep	 Talau", code: "7104", province_id: prov71.id)
dist7105	= District.create( name: "Minahasa Selatan", code: "7105", province_id: prov71.id)
dist7106	= District.create( name: "Minahasa Utara", code: "7106", province_id: prov71.id)
dist7107	= District.create( name: "Bolaang Mongondow Utara", code: "7107", province_id: prov71.id)
dist7108	= District.create( name: "Kep	 Sitar", code: "7108", province_id: prov71.id)
dist7109	= District.create( name: "Minahasa Tenggara", code: "7109", province_id: prov71.id)
dist7171	= District.create( name: "Kota Manado", code: "7171", province_id: prov71.id)
dist7172	= District.create( name: "Kota Bitung", code: "7172", province_id: prov71.id)
dist7173	= District.create( name: "Kota Tomohon", code: "7173", province_id: prov71.id)
dist7174	= District.create( name: "Kota Kotamobagu", code: "7174", province_id: prov71.id)
dist7201	= District.create( name: "Banggai Kepulauan", code: "7201", province_id: prov72.id)
dist7202	= District.create( name: "Banggai", code: "7202", province_id: prov72.id)
dist7203	= District.create( name: "Morowali", code: "7203", province_id: prov72.id)
dist7204	= District.create( name: "P o s o", code: "7204", province_id: prov72.id)
dist7205	= District.create( name: "Donggala", code: "7205", province_id: prov72.id)
dist7206	= District.create( name: "Toli Toli", code: "7206", province_id: prov72.id)
dist7207	= District.create( name: "B u o l", code: "7207", province_id: prov72.id)
dist7208	= District.create( name: "Parigi Moutong", code: "7208", province_id: prov72.id)
dist7209	= District.create( name: "Tojo Una-Una", code: "7209", province_id: prov72.id)
dist7271	= District.create( name: "Kota Palu", code: "7271", province_id: prov72.id)
dist7301	= District.create( name: "Selayar", code: "7301", province_id: prov73.id)
dist7302	= District.create( name: "Bulukumba", code: "7302", province_id: prov73.id)
dist7303	= District.create( name: "Bantaeng", code: "7303", province_id: prov73.id)
dist7304	= District.create( name: "Jeneponto", code: "7304", province_id: prov73.id)
dist7305	= District.create( name: "Takalar", code: "7305", province_id: prov73.id)
dist7306	= District.create( name: "G o w a", code: "7306", province_id: prov73.id)
dist7307	= District.create( name: "Sinjai", code: "7307", province_id: prov73.id)
dist7308	= District.create( name: "Maros", code: "7308", province_id: prov73.id)
dist7309	= District.create( name: "Pangkajene Kep", code: "7309", province_id: prov73.id)
dist7310	= District.create( name: "Barru", code: "7310", province_id: prov73.id)
dist7311	= District.create( name: "B o n e", code: "7311", province_id: prov73.id)
dist7312	= District.create( name: "Soppeng", code: "7312", province_id: prov73.id)
dist7313	= District.create( name: "W a j o", code: "7313", province_id: prov73.id)
dist7314	= District.create( name: "Sidenreng Rappang", code: "7314", province_id: prov73.id)
dist7315	= District.create( name: "Pinrang", code: "7315", province_id: prov73.id)
dist7316	= District.create( name: "Enrekang", code: "7316", province_id: prov73.id)
dist7317	= District.create( name: "L u w u", code: "7317", province_id: prov73.id)
dist7318	= District.create( name: "Tana Toraja", code: "7318", province_id: prov73.id)
dist7322	= District.create( name: "Luwu Utara", code: "7322", province_id: prov73.id)
dist7325	= District.create( name: "Luwu Timur", code: "7325", province_id: prov73.id)
dist7371	= District.create( name: "Kota Makassar", code: "7371", province_id: prov73.id)
dist7372	= District.create( name: "Kota Pare Pare", code: "7372", province_id: prov73.id)
dist7373	= District.create( name: "Kota Palopo", code: "7373", province_id: prov73.id)
dist7401	= District.create( name: "Buton", code: "7401", province_id: prov74.id)
dist7402	= District.create( name: "M u n a", code: "7402", province_id: prov74.id)
dist7403	= District.create( name: "Kendari", code: "7403", province_id: prov74.id)
dist7404	= District.create( name: "Kolaka", code: "7404", province_id: prov74.id)
dist7405	= District.create( name: "Konawe Selatan", code: "7405", province_id: prov74.id)
dist7406	= District.create( name: "Bombana", code: "7406", province_id: prov74.id)
dist7407	= District.create( name: "Wakatobi", code: "7407", province_id: prov74.id)
dist7408	= District.create( name: "Kolaka Utara", code: "7408", province_id: prov74.id)
dist7409	= District.create( name: "Buton Utara", code: "7409", province_id: prov74.id)
dist7410	= District.create( name: "Konawe Utara", code: "7410", province_id: prov74.id)
dist7471	= District.create( name: "Kota Kendari", code: "7471", province_id: prov74.id)
dist7472	= District.create( name: "Kota Baubau", code: "7472", province_id: prov74.id)
dist7501	= District.create( name: "Boalemo", code: "7501", province_id: prov75.id)
dist7502	= District.create( name: "Gorontalo", code: "7502", province_id: prov75.id)
dist7503	= District.create( name: "Pohuwato", code: "7503", province_id: prov75.id)
dist7504	= District.create( name: "Bone Bolango", code: "7504", province_id: prov75.id)
dist7505	= District.create( name: "Gorontalo Utara", code: "7505", province_id: prov75.id)
dist7571	= District.create( name: "Kota Gorontalo", code: "7571", province_id: prov75.id)
dist7601	= District.create( name: "Majene", code: "7601", province_id: prov76.id)
dist7602	= District.create( name: "Polewali Mamasa", code: "7602", province_id: prov76.id)
dist7603	= District.create( name: "Mamasa", code: "7603", province_id: prov76.id)
dist7604	= District.create( name: "Mamuju", code: "7604", province_id: prov76.id)
dist7605	= District.create( name: "Mamuju Utara", code: "7605", province_id: prov76.id)
dist8101	= District.create( name: "Maluku Tenggara Barat", code: "8101", province_id: prov81.id)
dist8102	= District.create( name: "Maluku Tenggara", code: "8102", province_id: prov81.id)
dist8103	= District.create( name: "Maluku Tengah", code: "8103", province_id: prov81.id)
dist8104	= District.create( name: "B u r u", code: "8104", province_id: prov81.id)
dist8105	= District.create( name: "Kepulauan Aru", code: "8105", province_id: prov81.id)
dist8106	= District.create( name: "Seram Bagian Barat", code: "8106", province_id: prov81.id)
dist8107	= District.create( name: "Seram Bagian Timur", code: "8107", province_id: prov81.id)
dist8171	= District.create( name: "Kota Ambon", code: "8171", province_id: prov81.id)
dist8172	= District.create( name: "Tual", code: "8172", province_id: prov81.id)
dist8201	= District.create( name: "Halmahera Barat", code: "8201", province_id: prov82.id)
dist8202	= District.create( name: "Halmahera Tengah", code: "8202", province_id: prov82.id)
dist8203	= District.create( name: "Kepulauan Sula", code: "8203", province_id: prov82.id)
dist8204	= District.create( name: "Halmahera Selatan", code: "8204", province_id: prov82.id)
dist8205	= District.create( name: "Halmahera Utara", code: "8205", province_id: prov82.id)
dist8206	= District.create( name: "Halmahera Timur", code: "8206", province_id: prov82.id)
dist8271	= District.create( name: "Kota Ternate", code: "8271", province_id: prov82.id)
dist8272	= District.create( name: "Kota Tidore Kepulauan", code: "8272", province_id: prov82.id)
dist9101	= District.create( name: "Fakfak", code: "9101", province_id: prov91.id)
dist9102	= District.create( name: "Kaimana", code: "9102", province_id: prov91.id)
dist9103	= District.create( name: "Teluk Wondama", code: "9103", province_id: prov91.id)
dist9104	= District.create( name: "Teluk Bintuni", code: "9104", province_id: prov91.id)
dist9105	= District.create( name: "Manokwari", code: "9105", province_id: prov91.id)
dist9106	= District.create( name: "Sorong Selatan", code: "9106", province_id: prov91.id)
dist9107	= District.create( name: "Sorong", code: "9107", province_id: prov91.id)
dist9108	= District.create( name: "Raja Ampat", code: "9108", province_id: prov91.id)
dist9171	= District.create( name: "Kota Sorong", code: "9171", province_id: prov91.id)
dist9401	= District.create( name: "Merauke", code: "9401", province_id: prov94.id)
dist9402	= District.create( name: "Jayawijaya", code: "9402", province_id: prov94.id)
dist9403	= District.create( name: "Jayapura", code: "9403", province_id: prov94.id)
dist9404	= District.create( name: "Nabire", code: "9404", province_id: prov94.id)
dist9408	= District.create( name: "Yapen Waropen", code: "9408", province_id: prov94.id)
dist9409	= District.create( name: "Biak Numfor", code: "9409", province_id: prov94.id)
dist9410	= District.create( name: "Paniai", code: "9410", province_id: prov94.id)
dist9411	= District.create( name: "Puncak Jaya", code: "9411", province_id: prov94.id)
dist9412	= District.create( name: "Mimika", code: "9412", province_id: prov94.id)
dist9413	= District.create( name: "Boven Digoel", code: "9413", province_id: prov94.id)
dist9414	= District.create( name: "Mappi", code: "9414", province_id: prov94.id)
dist9415	= District.create( name: "Asmat", code: "9415", province_id: prov94.id)
dist9416	= District.create( name: "Yahukimo", code: "9416", province_id: prov94.id)
dist9417	= District.create( name: "Peg	 Bintan", code: "9417", province_id: prov94.id)
dist9418	= District.create( name: "Tolikara", code: "9418", province_id: prov94.id)
dist9419	= District.create( name: "Sarmi", code: "9419", province_id: prov94.id)
dist9420	= District.create( name: "Keerom", code: "9420", province_id: prov94.id)
dist9426	= District.create( name: "Waropen", code: "9426", province_id: prov94.id)
dist9427	= District.create( name: "Supiori", code: "9427", province_id: prov94.id)
dist9428	= District.create( name: "Mamberamo Raya", code: "9428", province_id: prov94.id)
dist9429	= District.create( name: "Nduga", code: "9429", province_id: prov94.id)
dist9430	= District.create( name: "Lanny Jaya", code: "9430", province_id: prov94.id)
dist9431	= District.create( name: "Mamberamo Tengah", code: "9431", province_id: prov94.id)
dist9432	= District.create( name: "Yalimo", code: "9432", province_id: prov94.id)
dist9433	= District.create( name: "Puncak", code: "9433", province_id: prov94.id)
dist9434	= District.create( name: "Dogiyai", code: "9434", province_id: prov94.id)
dist9471	= District.create( name: "Kota Jayapura", code: "9471", province_id: prov94.id)


# Desas
desa = Desa.create([
  { name: "Ampenan", code: "001", lat: -8.583333, lng: 116.116667, district_id: dist5271.id},
  { name: "Banka Banka", code: "002", lat: -8.747771, lng: 115.864595, district_id: dist5201.id },
  { name: "Seraya", code: "003", lat: -8.349155, lng: 115.682927, district_id: dist5107.id },
  { name: "Kasamba", code: "004", lat: -8.569655, lng: 115.433475, district_id: dist5105.id }
]) 

# Offices
office1 = Office.create(name: "DKP Karangasem", district_id: dist5107.id)
office2 = Office.create(name: "DKP Klungkung", district_id: dist5105.id)
office3 = Office.create(name: "DKP Mataram", district_id: dist5271.id)
office4 = Office.create(name: "DKP Lombok Barat", district_id: dist5201.id)

# Graticules
graticule1 = Graticule.create({:code => "ASDF"})

# Roles
role_public = Role.create(name: "public")
role_staff = Role.create(name: "staff")
role_supervisor = Role.create(name: "supervisor")
role_admin = Role.create(name: "administrator")
role_enumerator = Role.create(name: "enumerator")

# Users
desa1 = Desa.first
user1 = desa1.users.create(name: "user1", email: "user1@fish.com", password: "password1", password_confirmation: "password1")

# Administrators
admin1 = office1.admins.create(email: "admin@fish.com",
  name: "Admin Adminson",
  office_id: office1.id,
  password: "admin1",
  password_confirmation: "admin1",
  approved: true)
admin1.roles.push role_admin
admin1.roles.push role_staff

admin_staff1 = Admin.create(email: "staff1@fish.com",
	name: "staff1",
	password: "staff1",
	password_confirmation: "staff1",
	approved: true,
	office_id: office1.id)
admin_staff1.roles.push role_admin
admin_staff1.roles.push role_staff

admin_staff2 = Admin.create(email: "staff2@fish.com",
	name: "staff2",
	password: "staff2",
	password_confirmation: "staff2",
	approved: true,
	office_id: office2.id)
admin_staff2.roles.push role_admin
admin_staff2.roles.push role_staff

admin_staff2 = Admin.create(email: "rm.sylvester@gmail.com",
	name: "rmsylvester",
	password: "Password1",
	password_confirmation: "Password1",
	approved: true,
	office_id: office2.id)
admin_staff2.roles.push role_admin
admin_staff2.roles.push role_staff

admin_supervisor1 = Admin.create(email: "supervisor1@fish.com",
	name: "supervisor1",
	password: "supervisor1",
	password_confirmation: "supervisor1",
	approved: true,
	office_id: office1.id)
admin_supervisor1.roles.push role_admin
admin_supervisor1.roles.push role_supervisor

admin_supervisor2 = Admin.create(email: "supervisor2@fish.com",
	name: "supervisor2",
	password: "supervisor2",
	password_confirmation: "supervisor2",
	approved: true,
	office_id: office2.id)
admin_supervisor2.roles.push role_admin
admin_supervisor2.roles.push role_supervisor


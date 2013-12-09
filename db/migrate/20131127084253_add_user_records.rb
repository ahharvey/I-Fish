class AddUserRecords < ActiveRecord::Migration
  def up
    remove_index :users, :email
    add_index :users, :email

    User.create( name: "I Wayan Sugiasa", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.3 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Komang Budi Artawan", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Sukra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Komang Ladra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.3 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Matan", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.3 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Mandra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Salin", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Manis", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.7 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Direng", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.3 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Made Pujut", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Patra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Landra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Lau", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Kadek Muliasa", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.15  , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Made Rangen", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Komang Kartika", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nengah Salin", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Wicara", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Sueca", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Arnata", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Radin", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Nara", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 4.5 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Kartika", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Matal", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Made Sariana", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Tumpek", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.5 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Kutang", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Parta", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Sulatra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Salin", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Rasibawa", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Putra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.1 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Komang Kartika", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.35  , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Kariasa", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.3 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Pastika", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.1 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Ngara", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.3 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Sadra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Komang Juli", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.9 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Darta", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.7 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Redita", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.9 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Rames", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.1 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Salin", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Su", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.1 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nengah Pasek", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.9 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Glung", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I made Nail", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6.2 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Wayan Ase", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  5.8 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Made Putra", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 6.1 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Ketut Purna", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length:  6 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )
    User.create( name: "I Nyoman Sadru", notes: "Banjar Tukad Tiis – Seraya", vessel_type_id: VesselType.find_by_code("OC".downcase).id, length: 5.9 , engine_id: Engine.find_by_code("OB").id, power: 15, desa_id: Desa.find_by_name("Seraya").id )

    User.create( name: "Wayan Jata", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Sudra", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Dasna", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nyoman Maja", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Astawan", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Sudiarta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sukerta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sinah", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Kardi", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Suriata", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nyoman Rugeg", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Subrata", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Sutama", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Ribig", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sumantara", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sudiarta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sujana", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Surasta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Ketut Subrata", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Kamar", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Ketut Sudirta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Lilir", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Komang Subrata", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Kadek Sukanta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Gusti Made Candra", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Dewa Gede Mataram", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Dewa Gede Raka", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Dewa Nyoman Suyasa", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sudiasta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Tirta Yadnya", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Dewa Putu Mandra", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Gusti Made Jelantik", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Ketut Sregig", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Tedun", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nyoman Sutama", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "Dewa Nyoman Oka", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Gusti Made Purna", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Dana", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Komang Sudarma", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nyoman Renis", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Rusta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Suardana", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nyoman Arimbawa", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Sambayasa", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Sukra", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Sudiarta", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Nengah Dira", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Komang Anawa", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Wayan Ribeg", desa_id: Desa.find_by_name("Kasamba").id )
    User.create( name: "I Dewa Ketut Oka Swati", desa_id: Desa.find_by_name("Kasamba").id )

    User.create(name:"Bahrim", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Rusmiadi", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Jamiludin", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Munadi", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Supriadi", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sumantri", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sopiandi", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Rusnan", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Gapur", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Agusdin", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Tajudin", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Suyitno", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Mustar", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Muh nazarudin", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Ahmad", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Alamudin", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Salam", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Jumadi", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sukri", notes: "Lingkungan Pondok prasi", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Awaludin", notes: "", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Jum'ati", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Bahri", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Kamil", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sapri", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sap", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Nasriadi", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Mahesan", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Nurpah", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Muhasim", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Maeli", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sahban", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Maewan", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Nursim", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Japri", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sapriadi", notes: "Lingkungan Bugis", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Suparmin", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sabri", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Nur Amin", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Arfik", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Dian Permana", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sudirman", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Ridwan", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Imam Safii", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sahwan", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Bahar", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Aziz", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Agus", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sofiandi", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Sahri", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )
    User.create(name:"Alimin", notes: "Lingkungan Bintaro", desa_id: Desa.find_by_name("Ampenan").id )

    User.create( name: "Pak Bahar", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jumaidi", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Karni", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Akim", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Tohri", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Badrun", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Lukman", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Junaidi", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Moh", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Anam", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Saparutin", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Mahsun", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Murtawan", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Haji Mahdar", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Deni", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Hamdani", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak sahri", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jaenuddin", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Andi", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Arifin", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Delimah", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Nurdin", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Man", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Haji Darmawan", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Kasdi", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Arsiah", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak  Jallaludin", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak sabri", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Muhnan", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Derah", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Made", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Komang", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jero Bawa", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Sukur", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jamuhur", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jun", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Samali", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Apri", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Min", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Sahrim", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jamil", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Cemin", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Maming", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Usup", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Darto", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Jaenal", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Talib", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Daang", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Lalu Awan", desa_id: Desa.find_by_name("Banka Banka").id )
    User.create( name: "Pak Harsal", desa_id: Desa.find_by_name("Banka Banka").id )
  end

  def down
    remove_index :users, :email
    add_index :users, :email, :unique => true
  end
end
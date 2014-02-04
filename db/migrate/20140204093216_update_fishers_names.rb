class UpdateFishersNames < ActiveRecord::Migration
  def up

    User.where(name: "Wayan Jata", desa_id: 12).each do |u|
      u.name= "I Wayan Jata"
      u.save
    end
    User.where(name: "I Nengah Ribig", desa_id: 12).each do |u|
      u.name= "I Ketut Repen"
      u.save
    end
    User.where(name: "I Wayan Sumantara", desa_id: 12).each do |u|
      u.name= "I Wayan Anggaradita"
      u.save
    end
    User.where(name: "I Nengah Lilir", desa_id: 12).each do |u|
      u.name= "I Wayan Karinu"
      u.save
    end
    User.where(name: "I Komang Sudarma", desa_id: 12).each do |u|
      u.name= "I Nyoman Sudarma"
      u.save
    end
    User.where(name: "I Komang Anawa", desa_id: 12).each do |u|
      u.name= "I Komang Arnawa"
      u.save
    end
    User.where(name: "I Komang Budi Artawan", desa_id: 11).each do |u|
      u.name= " I Komang Budiartawan"
      u.save
    end
    User.where(name: "I Komang Ladra", desa_id: 11).each do |u|
      u.name= " I Komang Ladra Sentosa"
      u.save
    end
    User.where(name: "I Wayan Matan", desa_id: 11).each do |u|
      u.name= " I Wayan Matal"
      u.save
    end
    User.where(name: "I Wayan Mandra", desa_id: 11).each do |u|
      u.name= " I Nyoman Mandra"
      u.save
    end
    User.where(name: "I Wayan Salin", desa_id: 11).each do |u|
      u.name= " I Wayan Salin A"
      u.save
    end
    User.where(name: "I Ketut Direng", desa_id: 11).each do |u|
      u.name= " I Ketut Ranes"
      u.save
    end
    User.where(name: "I Ketut Patra", desa_id: 11).each do |u|
      u.name= " I Gede Patra"
      u.save
    end
    User.where(name: "I Nengah Salin", desa_id: 11).each do |u|
      u.name= " I Nyoman Salin"
      u.save
    end
    User.where(name: "I Nyoman Wicara", desa_id: 11).each do |u|
      u.name= " I Nengah Suastika"
      u.save
    end
    User.where(name: "I Nyoman Sueca", desa_id: 11).each do |u|
      u.name= " I Nyoman Sweca"
      u.save
    end
    User.where(name: "I Komang Kartika", desa_id: 11).each do |u|
      u.name= " I Nyoman "
      u.save
    end
    User.where(name: "I Wayan Salin", desa_id: 11).each do |u|
      u.name= " I Wayan Salin B"
      u.save
    end
    User.where(name: "I Wayan Glung", desa_id: 11).each do |u|
      u.name= " I Wayan Galung"
      u.save
    end
    User.where(name: "I Made Putra", desa_id: 11).each do |u|
      u.name= " I Nyoman Rada"
      u.save
    end
    User.where(name: "I Ketut Purna", desa_id: 11).each do |u|
      u.name= " I Nyoman Wirna"
      u.save
    end

  end

  def down
  end
end





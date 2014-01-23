class AddDesaRecords < ActiveRecord::Migration
  
  def up

    desas = [
      { name: "Tanah Ampo", lat: -8.507896, lng: 115.514092, district_id: 265, code: "005" },
      { name: "Anantelo", lat: -8.549471, lng: 115.484877, district_id: 263, code: "006" },
      { name: "Ahmad", lat: -8.355120, lng: 115.689796, district_id: 265, code: "007" },
      { name: "Gemelut", lat: -8.427944, lng: 115.690434, district_id: 265, code: "008" },
      { name: "Bunutun", lat: -8.350185, lng: 115.682709, district_id: 265, code: "009" },
      { name: "Pessinggahan", lat: -8.554387, lng: 115.464921, district_id: 263, code: "010" },
      { name: "Padang Bai", lat: -8.531215, lng: 115.509337, district_id: 265, code: "011" },
      { name: "Pantai Jasi", lat: -8.479385, lng: 115.621815, district_id: 265, code: "012" },
      { name: "Candidasa", lat: -8.509756, lng: 115.567673, district_id: 265, code: "013" },
      { name: "Banjar Pengalon", lat: -8.549471, lng: 115.484877, district_id: 265, code: "014" },
      { name: "Sekotong Barat" , lat: -8.742207, lng: 116.002309, district_id: 268, code: "015" }
    ]

    desas.each do |d|
      Desa.where(d).first_or_create()
    end

  end

  def down

    desas = [
      { name: "Tanah Ampo", lat: -8.507896, lng: 115.514092, district_id: 265 },
      { name: "Anantelo", lat: -8.549471, lng: 115.484877, district_id: 263 },
      { name: "Ahmad", lat: -8.355120, lng: 115.689796, district_id: 265 },
      { name: "Gemelut", lat: -8.427944, lng: 115.690434, district_id: 265 },
      { name: "Bunutun", lat: -8.350185, lng: 115.682709, district_id: 265 },
      { name: "Pessinggahan", lat: -8.554387, lng: 115.464921, district_id: 263 },
      { name: "Padang Bai", lat: -8.531215, lng: 115.509337, district_id: 265 },
      { name: "Pantai Jasi", lat: -8.479385, lng: 115.621815, district_id: 265 },
      { name: "Candidasa", lat: -8.509756, lng: 115.567673, district_id: 265 },
      { name: "Banjar Pengalon", lat: -8.549471, lng: 115.484877, district_id: 265 },
      { name: "Sekotong Barat" , lat: -8.742207, lng: 116.002309, district_id: 268}
    ]

    desas.each do |d|
      Desa.where(d).first.destroy
    end

  end
end

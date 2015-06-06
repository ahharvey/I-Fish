namespace :add_data do
  desc "populating data..........."
  task :desas => :environment do

    lob = District.find_by_name( 'Lombok Barat' )
    ampenan = District.find_by_name( 'Kota Mataram')

    desas = [
      {name: 'Pandanan', lat: -1 * (8+((46+(28.64/60))/60)), lng: 115+((58+(18.25/60))/60), district_id: lob.id},
      {name: 'Batu Kijuk', lat: -1 * (8+((44+(36.91/60))/60)) , lng: 116+((1+(15.34/60))/60), district_id: lob.id},
      {name: 'Lendang jahe', lat: -1 * (8+((43+(8.71/60))/60)), lng: 116+((3+(31.04/60))/60), district_id: lob.id},
      {name: 'Buncit', lat: -1 * (8+((42+(35.89/60))/60)) , lng: 116+((3+(39.13/60))/60), district_id: lob.id},
      {name: 'Jerajang',  lat: -1 * (8+((38+(52.71/60))/60)) , lng: 116+((4+(11.10/60))/60), district_id: ampenan.id},
      {name: 'Kuranji',  lat: -1 * (8+((37+(16.56/60))/60)) , lng: 116+((4+(28.06/60))/60), district_id: ampenan.id},
      {name: 'Kebun Belik', lat: -1 * (8+((36+(51.33/60))/60)) , lng: 116+((4+(28.03/60))/60), district_id: ampenan.id},
      {name: 'Tanjung Karang', lat: -1 * (8+((36+(8.32/60))/60)) , lng: 116+((4+(25.06/60))/60), district_id: ampenan.id},
    ]

    desas.each do |desa|
      d = Desa.find_by_name_and_district_id( desa[:name], desa[:district_id])
      unless d.present? 
        Desa.create(desa)
      end
    end
  end

  task :create_grids => :environment do 
    xs = 14..49
    ys = "a".."z"

    ys.each do |y|
      xs.each do |x|
        Grid.create(xaxis: x, yaxis: y)
      end
    end

  end
end

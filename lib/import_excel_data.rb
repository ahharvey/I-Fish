require 'iconv'

class ImportExcelData
  def self.working_based_sheet(xl_file, excel_data)
    # xl_file = ExcelFile.find(id)

    if xl_file.file.file.extension.eql?("xls")
      xls = Excel.new(xl_file.file.path)
    else
      xls = Excelx.new(xl_file.file.path)
    end
    mysheets = xls.sheets

    # parses and imports survey details from Survey tab
    if xls.sheets.include?('Survey')
      xls.default_sheet = 'Survey'
      fishery = xls.cell(1,"B").downcase  rescue ''
      code_desa = xls.cell(2,"B").downcase  rescue ''
      date = Date.today #xls.cell(3,"B").to_date
      start_time = DateTime.now#Time.at(xls.cell(4,"B"))
      end_time = DateTime.now #Time.parse(xls.cell(5,"B"))
      fleet_observer = xls.cell(6,"B").to_s
      catch_scribe = xls.cell(7,"B").to_s
      catch_measure = xls.cell(8,"B").to_s
      unless fishery.blank?
        desa_id = Desa.where("LOWER(code) = ?", code_desa).first.id rescue 0
        fishery_id = Fishery.where("LOWER(code) = ?", fishery).first.id rescue 0

        survey = Survey.new(
          fishery_id: fishery_id, 
          desa_id: desa_id, 
          date_published: date, 
          start_time: start_time, #DateTime.new(date.year,date.month,date.day,start_time.hour,start_time.min)
          end_time: end_time, #DateTime.new(date.year,date.month,date.day,end_time.hour,end_time.min)
          fleet_observer: fleet_observer, 
          catch_scribe: catch_scribe, 
          catch_measure: catch_measure,
          admin_id: xl_file.admin.id
        )
        excel_data.add_model(survey, {:sheet => "Survey", :model_type => "Survey"})
      end

      # parses and imports survey landing data from Form A tab
      if xls.sheets.include?('Form A - Fleet')#
        xls.default_sheet = 'Form A - Fleet'
        for d in 2..xls.last_row
          reg = xls.cell(d,"B").to_s
          name = xls.cell(d,"C")
          type = xls.cell(d,"D")
          engine = xls.cell(d,"E").downcase rescue ''
          power = xls.cell(d,"F").to_i
          length = xls.cell(d,"G").to_i
          graticule = xls.cell(d,"H").downcase rescue ''
          dep_time = Time.now+xls.cell(d,"I") rescue Time.now
          arr_time = Time.now+xls.cell(d,"J") rescue Time.now
          sail = xls.cell(d,"K").to_s
          fuel = xls.cell(d,"L").to_i
          crew = xls.cell(d,"M").to_i
          gear = xls.cell(d,"N").downcase rescue ''
          fish = xls.cell(d,"O").downcase rescue ''
          weight = xls.cell(d,"P").to_i
          qty = xls.cell(d,"Q").to_i
          value = xls.cell(d,"R").to_i
          unless reg.blank?
            gear_id = Gear.where("LOWER(alpha_code) = ?", gear).first.id rescue 0
            engine_id = Engine.where("LOWER(code) = ?", engine).first.id rescue 0
            graticule_id = Graticule.where("LOWER(code) = ?", graticule).first.id rescue 0
            fish_id = Fish.where("LOWER(code) = ?", fish).first.id rescue 0
            landing = survey.landings.new(  
              power: power, 
              graticule_id: graticule_id.to_i, 
              type: type, 
              vessel_ref: reg, 
              vessel_name: name, 
              boat_size: length,
              engine_id: engine_id.to_i, 
              sail: sail, 
              fuel: fuel, 
              crew: crew, 
              weight: weight, 
              quantity: qty, 
              value: value, 
              time_in: arr_time, 
              time_out: dep_time, 
              gear_id: gear_id.to_i,
              fish_id: fish_id.to_i,
              survey_id: survey.id
            )
            # Set the importing flag so that validation on survey doesn't fail
            landing.importing!
            excel_data.add_model(landing, {:sheet => "Form A - Fleet", :model_type => "Landing", :row => d})
          end
        end
        # parses and imports survey catch data from Form B tab
        if xls.sheets.include?('Form B - Catch')
          xls.default_sheet = 'Form B - Catch'
          for i in 2..xls.last_row
            species = xls.cell(i,"B").downcase  rescue ''
            length = xls.cell(i,"C").to_i
            weight = xls.cell(i,"D").to_i
            unless species.blank?
              fish_id = Fish.where("LOWER(code) = ?", species).first.id rescue 0
              catch = Catch.new(
                fish_id: fish_id.to_i,
                length: length,
                weight: weight,
                landing_id: landing.id
              )
              excel_data.add_model(catch, {:sheet => "Form B - Catch", :model_type => "Catch", :row => i})
            end
          end
        end
      end
    end

    # parses and imports logbook data from logbook tab
    if xls.sheets.include?('Logbook')
      xls.default_sheet = 'Logbook'

      user_id = xls.cell(1,"C").to_i
      fishery = xls.cell(1,"G").to_s
      month = xls.cell(1,"K").to_i
      year = xls.cell(1,"O").to_i
      fishery_id = Fishery.where("LOWER(code) = ?", fishery).first.id rescue 0
      logbook = Logbook.new(
        user_id: user_id,
        admin_id: xl_file.admin.id,
        fishery_id: fishery_id.to_i,
        date: Date.new(year,month,1)
        )
      excel_data.add_model(logbook, {:sheet => "Logbook", :model_type => "Logbook"})

      for j in 4..xls.last_row
        day = xls.cell(j,"A").to_i
        start_time = xls.cell(j,"B")
        end_time = xls.cell(j,"C")
        gear_time = xls.cell(j,"D").to_i
        graticule_id = xls.cell(j,"E").downcase  rescue ''
        crew = xls.cell(j,"F").to_i
        fuel = xls.cell(j,"G").to_i
        sail = xls.cell(j,"H").downcase rescue ''
        net = xls.cell(j,"I").downcase rescue ''
        line = xls.cell(j,"J").downcase rescue ''
        fish_id = xls.cell(j,"K").downcase  rescue ''
        quantity = xls.cell(j,"L").to_i
        weight = xls.cell(j,"M").to_i
        value = xls.cell(j,"N").to_i
        condition = xls.cell(j,"O").to_i
        moon = xls.cell(j,"P").to_i
        date = DateTime.new(year, month, day)

        unless day.blank?
          unless start_time.blank?
            fish_id = Fish.where("LOWER(code) = ?", fish_id).first.id rescue 0
            graticule_id = Graticule.where("LOWER(code) = ?", graticule_id).first.id rescue 0
            #user_id = User.where("LOWER(code) = ?", user).first.id rescue 0
            logged_day = LoggedDay.new(
              start_time: date+start_time,
              end_time: date+end_time,
              gear_time: gear_time,
              crew: crew,
              fuel: fuel,
              sail: sail.to_bool,
              net: net.to_bool,
              line: line.to_bool,
              fish_id: fish_id.to_i,
              quantity: quantity,
              weight: weight,
              value: value,
              condition: condition,
              moon: moon,
              logbook_id: logbook.id,
              graticule_id: graticule_id.to_i
              )
            excel_data.add_model(logged_day, {:sheet => "Logbook", :model_type => "LoggedDay", :row => j})
          end
        end
      end
    end

  end
end
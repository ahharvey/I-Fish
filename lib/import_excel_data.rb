#require 'iconv'
require 'roo'
#require 'zip'

class ImportExcelData
  def self.working_based_sheet(xl_file, excel_data)
    #xl_file = ExcelFile.find(id)

    if xl_file.file.file.extension.eql?("xls")
      xls = Roo::Excel.new(xl_file.file.path)
    elsif xl_file.file.file.extension.eql?("xlsx")
      xls = Roo::Excelx.new(xl_file.file.path)
    else
      xls = ''
    end
    mysheets = xls.sheets

    # parses and imports survey details from Survey tab
    if xls.sheets.include?('Survey')
      xls.default_sheet = 'Survey'
      if xls.cell(1,"B") == 'LOM-PS'
        ImportExcelData.parse_small_pelagic_survey(xl_file, excel_data, xls)
      elsif xls.cell(1,"B") == 'SHARK'
        ImportExcelData.parse_shark_survey(xl_file, excel_data, xls)
      else
        survey = Survey.new( fishery_id: xls.cell(1,"B") )
        excel_data.add_model(survey, {:sheet => "Survey", :model_type => "Survey"})
      end
    end

    # parses and imports logbook data from logbook tab
    if xls.sheets.include?('Logbook')
      xls.default_sheet = 'Logbook'
      if xls.cell(1,"G") == 'LOM-PS'
        ImportExcelData.parse_small_pelagic_logbook(xl_file, excel_data, xls)
      elsif xls.cell(1,"G") == 'SHARK'
        ImportExcelData.parse_shark_logbook(xl_file, excel_data, xls)
      else
        logbook = Logbook.new( fishery_id: xls.cell(1,"G") )
        excel_data.add_model(logbook, {:sheet => "Logbook", :model_type => "Logbook"})
      end
    end

  end

  def self.parse_small_pelagic_survey(xl_file, excel_data, xls)
    xls.default_sheet = 'Survey'
=begin debug code
    puts xls.cell(3,"B")
    Rails.logger.info xls.cell(3,"B")#
    puts xls.cell(4,"B")
    Rails.logger.info xls.cell(4,"B")#
    puts xls.cell(5,"B")
    Rails.logger.info xls.cell(5,"B")
=end
    fishery = xls.cell(1,"B").downcase  rescue ''
    code_desa = xls.cell(2,"B").downcase  rescue ''
    date = xls.cell(3,"B").to_date
    start_time = date.to_datetime + xls.cell(4,"B").to_i.seconds
    end_time = date.to_datetime+xls.cell(5,"B").to_i.seconds
    vessel_count = xls.cell(6,"B")
    vessel_enumerator = xls.cell(7,"B")
    catch_scribe = xls.cell(8,"B")
    catch_measurer = xls.cell(9,"B")

    unless fishery.blank?
      desa_id = Desa.where("LOWER(name) = ?", code_desa.downcase).first.id rescue ''
      fishery_id = Fishery.where("LOWER(code) = ?", fishery.downcase).first.id rescue ''

      vessel_enumerator_id = ImportExcelData.lookup_admin( vessel_enumerator )
      catch_scribe_id = ImportExcelData.lookup_admin( catch_scribe )
      catch_measurer_id = ImportExcelData.lookup_admin( catch_measurer )
      
=begin debug code
      

#        vessel_enumerator_id = Admin.find_by_email(vessel_enumerator).id rescue vessel_enumerator
#        catch_scribe_id = Admin.find_by_email(catch_scribe).id rescue catch_scribe
#        catch_measurer_id = Admin.find_by_email(catch_measurer).id rescue catch_measurer

      Rails.logger.info vessel_enumerator_id
      Rails.logger.info catch_scribe_id
      Rails.logger.info catch_measurer_id
=end
      survey = Survey.new(
        fishery_id: fishery_id.to_i, 
        desa_id: desa_id, 
        date_published: date.to_s, 
        start_time: start_time, #DateTime.new(date.year,date.month,date.day,start_time.hour,start_time.min)
        end_time: end_time, #DateTime.new(date.year,date.month,date.day,end_time.hour,end_time.min)
        landing_enumerator_id: vessel_enumerator_id, 
        catch_scribe_id: catch_scribe_id, 
        catch_measurer_id: catch_measurer_id,
        admin_id: xl_file.admin.id,
        vessel_count: vessel_count
      )
      excel_data.add_model(survey, {:sheet => "Survey", :model_type => "Survey"})
      
    end

    # parses and imports survey landing data from Form A tab
      if xls.sheets.include?('Form A - Fleet')#
        xls.default_sheet = 'Form A - Fleet'
        for d in 2..xls.last_row
          unless xls.cell(d,"H").blank?
            row = xls.cell(d,"A").to_i
            reg = xls.cell(d,"B").to_s
            name = xls.cell(d,"C")
            vessel_type = xls.cell(d,"D").to_s.downcase rescue ''
            engine = xls.cell(d,"E").downcase rescue ''
            power = xls.cell(d,"F").to_i
            length = xls.cell(d,"G").to_i
            graticule = xls.cell(d,"H").to_s rescue ''
            dep_date = xls.cell(d,"I").blank? ? date : xls.cell(d,"I").to_date
            dep_time = dep_date.to_datetime + xls.cell(d,"J").to_i.seconds
            arr_time = date.to_datetime + xls.cell(d,"K").to_i.seconds
            aborted= xls.cell(d,"L").to_s
            sail = xls.cell(d,"M").to_i
            fuel = xls.cell(d,"N").to_i
            crew = xls.cell(d,"O").to_i
            gear = xls.cell(d,"P").downcase rescue ''
            ice = xls.cell(d,"Q").to_i
            conditions = xls.cell(d,"R").to_i
            fish = xls.cell(d,"S").downcase rescue ''
            weight = xls.cell(d,"T").to_i
            qty = xls.cell(d,"U").to_i
            value = xls.cell(d,"V").to_i

            if sail == "Y"
              sail_bool = true
            elsif sail == "N"
              sail_bool = false
            else
              sail_bool = ""
            end
=begin debug code
#            if aborted == "Y"
#              abort_bool = true
#            elsif aborted == "N"
#              abort_bool = false
#            else
#              abort_bool = ""
#            end

            Rails.logger.info aborted
            Rails.logger.info aborted
=end          
            gear_id = Gear.where("LOWER(alpha_code) = ?", gear).first.id rescue ''
            engine_id = Engine.where("LOWER(code) = ?", engine).first.id rescue ''
            graticule_id = Graticule.find_by_code(graticule).id rescue ''
            fish_id = Fish.where("LOWER(code) = ?", fish).first.id rescue ''
            vessel_type_id = VesselType.find_by_code(vessel_type).id rescue ''
            landing = Landing.new(  
              row: row,
              power: power, 
              graticule_id: graticule_id, 
              vessel_type_id: vessel_type_id, 
              vessel_ref: reg, 
              vessel_name: name, 
              boat_size: length,
              engine_id: engine_id, 
              sail: sail_bool, 
              fuel: fuel, 
              crew: crew, 
              weight: weight, 
              quantity: qty, 
              value: value, 
              time_in: arr_time, 
              time_out: dep_time, 
              gear_id: gear_id,
              fish_id: fish_id,
              aborted: aborted,
              ice: ice,
              conditions: conditions
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
            row = xls.cell(i,"B").to_i
            species = xls.cell(i,"C").downcase  rescue ''
            length = xls.cell(i,"D").to_i
            sampling_factor = xls.cell(i,"E").to_s
            measurement = 'fl'
            unless species.blank?
              fish_id = Fish.where("LOWER(code) = ?", species).first.id rescue 0
              #landing_id = Landing.where(survey_id: survey.id, row: row).first.id
              catch_tab = Catch.new(
                fish_id: fish_id,
                length: length,
                sfactor: sampling_factor,
                measurement: measurement,
                row: row
              )
              #Rails.logger.info catch.to_yaml
              #puts catch.to_yaml
              catch_tab.importing!
              excel_data.add_model(catch_tab, {:sheet => "Form B - Catch", :model_type => "Catch", :row => i})
            end
          end
        end
      end

  end

  def self.parse_small_pelagic_logbook(xl_file, excel_data, xls)
    xls.default_sheet = 'Logbook'

    user = xls.cell(1,"C")
    fishery = xls.cell(1,"G").downcase
    month = xls.cell(1,"K").to_i
    year = xls.cell(1,"O").to_i

    if user.is_a? String
      if user_record = User.find_by_email(user)
        user_id = user_record.id
      elsif user_record = User.find_by_name(user)
        user_id = user_record.id
      else
        user_id = ''
      end
    elsif user.is_a? Integer
      user_id = User.find( user ).id
    else
      user_id = ''
    end
    #user_id = User.find_by_name( user.to_s ).id rescue user
    #fishery_id = Fishery.find_by_code(fishery).id rescue 'fishery'
    fishery_id = Fishery.where("LOWER(code) = ?", fishery.downcase).first.id rescue 'fishery'
    logbook = Logbook.new(
      user_id: user_id.to_i,
      admin_id: xl_file.admin.id,
      fishery_id: fishery_id.to_i,
      date: Date.new(year,month,1)
      )
=begin debug code
    Rails.logger.info user
    Rails.logger.info fishery
    Rails.logger.info month
    Rails.logger.info year
    Rails.logger.info user_id
    Rails.logger.info fishery_id
    Rails.logger.info xls.cell(1,"G").to_s
=end
    excel_data.add_model(logbook, {:sheet => "Logbook", :model_type => "Logbook"})

    for j in 4..xls.last_row
      unless xls.cell(j,"B").blank?
        day = xls.cell(j,"A").to_i
        date = DateTime.new(year, month, day)
        start_time = date + xls.cell(j,"B").to_i.seconds
        end_time = date + xls.cell(j,"C").to_i.seconds
        gear_time = xls.cell(j,"D").to_i
        aborted = xls.cell(j,"E").to_s
        graticule = xls.cell(j,"F").to_s rescue ''
        crew = xls.cell(j,"G").to_i
        fuel = xls.cell(j,"H").to_i
        sail = xls.cell(j,"I").downcase rescue ''
        net = xls.cell(j,"J").downcase rescue ''
        line = xls.cell(j,"K").downcase rescue ''
        ice = xls.cell(j,"L").to_i
        fish_id = xls.cell(j,"M").downcase  rescue ''
        quantity = xls.cell(j,"N").to_i
        weight = xls.cell(j,"O").to_i
        value = xls.cell(j,"P").to_i
        condition = xls.cell(j,"Q").to_i
        
                
        if aborted == "Y"
          abort_bool = true
        elsif aborted == "N"
          abort_bool = false
        else
          abort_bool = ""
        end

        fish_id = Fish.where("LOWER(code) = ?", fish_id).first.id rescue 0
        graticule_id = Graticule.find_by_code(graticule).id rescue ''
        Rails.logger.info graticule_id
        #user_id = User.where("LOWER(code) = ?", user).first.id rescue 0
        logged_day = LoggedDay.new(
          start_time: start_time,
          end_time: end_time,
          gear_time: gear_time,
          crew: crew,
          fuel: fuel,
          sail: sail.to_bool,
          net: net.to_bool,
          line: line.to_bool,
          fish_id: fish_id,
          quantity: quantity,
          weight: weight,
          value: value,
          condition: condition,
          logbook_id: logbook.id,
          graticule_id: graticule_id,
          ice: ice,
          aborted: abort_bool
          )
        excel_data.add_model(logged_day, {:sheet => "Logbook", :model_type => "LoggedDay", :row => j})

      end
    end
    
  end

  def self.parse_shark_survey(xl_file, excel_data, xls)
    xls.default_sheet = 'Survey'
=begin debug code
    puts xls.cell(3,"B")
    Rails.logger.info xls.cell(3,"B")#
    puts xls.cell(4,"B")
    Rails.logger.info xls.cell(4,"B")#
    puts xls.cell(5,"B")
    Rails.logger.info xls.cell(5,"B")
=end
    fishery = xls.cell(1,"B").downcase  rescue ''
    code_desa = xls.cell(2,"B").downcase  rescue ''
    date = xls.cell(3,"B").to_date
    start_time = date.to_datetime + xls.cell(4,"B").to_i.seconds
    end_time = date.to_datetime+xls.cell(5,"B").to_i.seconds
    vessel_count = xls.cell(6,"B")
    vessel_enumerator = xls.cell(7,"B")
    catch_scribe = xls.cell(8,"B")
    catch_measurer = xls.cell(9,"B")

    unless fishery.blank?
      desa_id = Desa.where("LOWER(name) = ?", code_desa.downcase).first.id rescue ''
      fishery_id = Fishery.where("LOWER(code) = ?", fishery.downcase).first.id rescue ''

      vessel_enumerator_id = ImportExcelData.lookup_admin( vessel_enumerator )
      catch_scribe_id = ImportExcelData.lookup_admin( catch_scribe )
      catch_measurer_id = ImportExcelData.lookup_admin( catch_measurer )
      
=begin debug code
      

#        vessel_enumerator_id = Admin.find_by_email(vessel_enumerator).id rescue vessel_enumerator
#        catch_scribe_id = Admin.find_by_email(catch_scribe).id rescue catch_scribe
#        catch_measurer_id = Admin.find_by_email(catch_measurer).id rescue catch_measurer

      Rails.logger.info vessel_enumerator_id
      Rails.logger.info catch_scribe_id
      Rails.logger.info catch_measurer_id
=end
      survey = Survey.new(
        fishery_id: fishery_id.to_i, 
        desa_id: desa_id, 
        date_published: date.to_s, 
        start_time: start_time, #DateTime.new(date.year,date.month,date.day,start_time.hour,start_time.min)
        end_time: end_time, #DateTime.new(date.year,date.month,date.day,end_time.hour,end_time.min)
        landing_enumerator_id: vessel_enumerator_id, 
        catch_scribe_id: catch_scribe_id, 
        catch_measurer_id: catch_measurer_id,
        admin_id: xl_file.admin.id,
        vessel_count: vessel_count
      )
      excel_data.add_model(survey, {:sheet => "Survey", :model_type => "Survey"})
      
    end

    # parses and imports survey landing data from Form A tab
      if xls.sheets.include?('Form A - Fleet')#
        xls.default_sheet = 'Form A - Fleet'
        for d in 2..xls.last_row
          unless xls.cell(d,"H").blank?
            row = xls.cell(d,"A").to_i
            reg = xls.cell(d,"B").to_s
            name = xls.cell(d,"C")
            length = xls.cell(d,"D").to_i
            engine = xls.cell(d,"E").downcase rescue ''
            power = xls.cell(d,"F").to_i
            graticule = xls.cell(d,"G").to_s rescue ''
            dep_date = xls.cell(d,"H").blank? ? date : xls.cell(d,"H").to_date
            dep_time = dep_date.to_datetime + xls.cell(d,"I").to_i.seconds
            arr_time = date.to_datetime + xls.cell(d,"J").to_i.seconds  
            aborted = xls.cell(j,"K").to_s 
            gear = xls.cell(d,"L").downcase rescue ''
            fuel = xls.cell(d,"M").to_i
            crew = xls.cell(d,"N").to_i
            ice = xls.cell(d,"O").to_i
            conditions = xls.cell(d,"P").to_i
            fish = xls.cell(d,"Q").downcase rescue ''
            qty = xls.cell(d,"R").to_i
            value = xls.cell(d,"S").to_i

#            if sail == "Y"
#              sail_bool = true
#            elsif sail == "N"
#              sail_bool = false
#            else
#              sail_bool = ""
#            end
=begin debug code
#            if aborted == "Y"
#              abort_bool = true
#            elsif aborted == "N"
#              abort_bool = false
#            else
#              abort_bool = ""
#            end

            Rails.logger.info aborted
            Rails.logger.info aborted
=end          
            gear_id = Gear.where("LOWER(alpha_code) = ?", gear).first.id rescue ''
            engine_id = Engine.where("LOWER(code) = ?", engine).first.id rescue ''
            graticule_id = Graticule.find_by_code(graticule).id rescue ''
            fish_id = Fish.where("LOWER(code) = ?", fish).first.id rescue ''
#            vessel_type_id = VesselType.find_by_code(vessel_type).id rescue ''
            landing = Landing.new(  
              row: row,
              power: power, 
              graticule_id: graticule_id, 
              vessel_ref: reg, 
              vessel_name: name, 
              boat_size: length,
              engine_id: engine_id,  
              fuel: fuel, 
              crew: crew,  
              quantity: qty, 
              value: value, 
              time_in: arr_time, 
              time_out: dep_time, 
              gear_id: gear_id,
              fish_id: fish_id,
              aborted: aborted,
              ice: ice,
              conditions: conditions
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
            row = xls.cell(i,"B").to_i
            species = xls.cell(i,"C").downcase  rescue ''
            length = xls.cell(i,"D").to_i
            measurement = xls.cell(i,"E").to_s
            sampling_factor = 'c'
            unless species.blank?
              fish_id = Fish.where("LOWER(code) = ?", species).first.id rescue 0
              #landing_id = Landing.where(survey_id: survey.id, row: row).first.id
              catch_tab = Catch.new(
                fish_id: fish_id,
                length: length,
                measurement: measurement.downcase,
                sfactor: sampling_factor,
                row: row
                )
              #Rails.logger.info catch.to_yaml
              #puts catch.to_yaml
              catch_tab.importing!
              excel_data.add_model(catch_tab, {:sheet => "Form B - Catch", :model_type => "Catch", :row => i})
            end
          end
        end
      end

  end

  def self.parse_shark_logbook(xl_file, excel_data, xls)
    xls.default_sheet = 'Logbook'

    user = xls.cell(1,"C")
    fishery = xls.cell(1,"G").downcase
    month = xls.cell(1,"K").to_i
    year = xls.cell(1,"O").to_i

    if user.is_a? String
      if user_record = User.find_by_email(user)
        user_id = user_record.id
      elsif user_record = User.find_by_name(user)
        user_id = user_record.id
      else
        user_id = ''
      end
    elsif user.is_a? Integer
      user_id = User.find( user ).id
    else
      user_id = ''
    end
    #user_id = User.find_by_name( user.to_s ).id rescue user
    #fishery_id = Fishery.find_by_code(fishery).id rescue 'fishery'
    fishery_id = Fishery.where("LOWER(code) = ?", fishery.downcase).first.id rescue 'fishery'
    logbook = Logbook.new(
      user_id: user_id.to_i,
      admin_id: xl_file.admin.id,
      fishery_id: fishery_id.to_i,
      date: Date.new(year,month,1)
      )
=begin debug code
    Rails.logger.info user
    Rails.logger.info fishery
    Rails.logger.info month
    Rails.logger.info year
    Rails.logger.info user_id
    Rails.logger.info fishery_id
    Rails.logger.info xls.cell(1,"G").to_s
=end
    excel_data.add_model(logbook, {:sheet => "Logbook", :model_type => "Logbook"})

    for j in 4..xls.last_row
      unless xls.cell(j,"B").blank?
        day = xls.cell(j,"A").to_i
        date = DateTime.new(year, month, day)
        start_time = date + xls.cell(j,"B").to_i.seconds
        end_time = date + xls.cell(j,"C").to_i.seconds
        gear_time = xls.cell(j,"D").to_i
        aborted = xls.cell(j,"E").to_s
        graticule = xls.cell(j,"F").to_s rescue ''
        crew = xls.cell(j,"G").to_i
        fuel = xls.cell(j,"H").to_i
        ice = xls.cell(j,"I").to_i
        fish_id = xls.cell(j,"J").downcase  rescue ''
        quantity = xls.cell(j,"K").to_i
        # weight = xls.cell(j,"O").to_i
        value = xls.cell(j,"L").to_i
        condition = xls.cell(j,"M").to_i
        notes = xls.cell(j,"N").to_s
                
        if aborted == "Y"
          abort_bool = true
        elsif aborted == "N"
          abort_bool = false
        else
          abort_bool = ""
        end

        fish_id = Fish.where("LOWER(code) = ?", fish_id).first.id rescue 0
        graticule_id = Graticule.find_by_code(graticule).id rescue ''
        Rails.logger.info graticule_id
        #user_id = User.where("LOWER(code) = ?", user).first.id rescue 0
        logged_day = LoggedDay.new(
          start_time: start_time,
          end_time: end_time,
          gear_time: gear_time,
          crew: crew,
          fuel: fuel,
          fish_id: fish_id,
          quantity: quantity,
          value: value,
          condition: condition,
          logbook_id: logbook.id,
          graticule_id: graticule_id,
          ice: ice,
          aborted: abort_bool,
          notes: notes
          )
        excel_data.add_model(logged_day, {:sheet => "Logbook", :model_type => "LoggedDay", :row => j})

      end
    end
    
  end

  def self.lookup_admin( object )
    if object.is_a? String
      if admin = Admin.find_by_email(object)
        admin.id
      elsif admin = Admin.find_by_name(object)
        admin.id
      else
        nil
      end
    elsif object.is_a? Integer
      if admin = Admin.find( object ).id
        admin.id
      else
        nil
      end
    else
      nil
    end
  end
end











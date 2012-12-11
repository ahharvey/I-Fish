require 'iconv'

class ImportExcelData
  def self.working_based_sheet(id, user_id)
    xl_file = ExcelFile.find(id)

    if xl_file.file.file.extension.eql?("xls")
      xls = Excel.new(xl_file.file.path)
    else
      xls = Excelx.new(xl_file.file.path)
    end
    mysheets = xls.sheets

    # form A
    
    if xls.sheets.include?('Form A - Fleet')
      xls.default_sheet = 'Form A - Fleet'
    
    
      for d in 2..xls.last_row
        reg = xls.cell(d,"B").to_s
        name = xls.cell(d,"C")
        type = xls.cell(d,"D")
        engine = xls.cell(d,"E").to_s
        power = xls.cell(d,"F").to_s
        fishing_area = xls.cell(d,"G").to_s
        dep_time = Time.now+xls.cell(d,"H") rescue Time.now
        arr_time = Time.now+xls.cell(d,"I") rescue Time.now
        sail = xls.cell(d,"J")
        fuel = xls.cell(d,"K").to_s
        crew = xls.cell(d,"L").to_s
        gear = xls.cell(d,"M").downcase rescue ''
        weight = xls.cell(d,"N").to_i
        qty = xls.cell(d,"O").to_i
        value = xls.cell(d,"P").to_i

        unless reg.blank?
          gear_id = Gear.where("LOWER(alpha_code) = ?", gear).first.id rescue 0
          landing = Landing.new(power: power, fishing_area: fishing_area, type: type, vessel_ref: reg, vessel_name: name, engine: engine, sail: sail, fuel: fuel, crew: crew, weight: weight, quantity: qty, value: value, time_in: arr_time, time_out: dep_time, gear_id: gear_id.to_i)
          landing.save
        end
      end
    end
    
    # form B
    if xls.sheets.include?('Form B - Catch')
      xls.default_sheet = 'Form B - Catch'
    
    
      for i in 2..xls.last_row
        species = xls.cell(i,"B").downcase  rescue ''
        length = xls.cell(i,"C")
        weight = xls.cell(i,"D")
        unless species.blank?
          fish_id = Fish.where("LOWER(code) = ?", species).first.id rescue 0
        
          catch = Catch.new(fish_id: fish_id.to_i, length: length, weight: weight)
          catch.save
        end
      end
    end
    
    # Survey
    if xls.sheets.include?('Survey')
      xls.default_sheet = 'Survey'
    
      fishery = xls.cell(1,"B").downcase  rescue ''
      kabupaten = xls.cell(2,"B")
      code_desa = xls.cell(3,"B").downcase  rescue ''
      date = xls.cell(4,"B").to_time
      start_time = date+xls.cell(5,"B")
      end_time = date+xls.cell(6,"B")
      fleet_observer = xls.cell(7,"B")
      catch_scribe = xls.cell(8,"B")
      catch_measure = xls.cell(9,"B")
        
      unless fishery.blank?
        desa_id = Desa.where("LOWER(code) = ?", code_desa).first.id rescue 0
        fishery_id = Fishery.where("LOWER(code) = ?", fishery).first.id rescue 0

        survey = Survey.new(fishery_id: fishery_id.to_i, desa_id: desa_id.to_i, date_published: date, start_time: start_time, end_time: end_time, fleet_observer: fleet_observer, catch_scribe: catch_scribe, catch_measure: catch_measure, user_id: user_id.to_i)
        survey.save
      end
    end
    
  end
end
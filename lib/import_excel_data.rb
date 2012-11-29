require 'iconv'

class ImportExcelData
  def self.working_based_sheet(id, user_id)
    xl_file = ExcelFile.find(id)
    
    if xl_file.file.file.extension.eql?("xls")
      xls = Excel.new(xl_file.file.path)
    else
      xls = Excelx.new(xl_file.file.path)
    end
    sheets = xls.sheets

    # form A
    
    if xls.sheets.include?('Form A - Fleet')
      xls.default_sheet = 'Form A - Fleet'
    
    
      for i in 2..xls.last_row
        reg = xls.cell(i,"B")
        name = xls.cell(i,"C")
        type = xls.cell(i,"D")
        engine = xls.cell(i,"E")
        power = xls.cell(i,"F")
        fishing_area = xls.cell(i,"G")
        dep_time = xls.cell(i,"H")
        arr_time = xls.cell(i,"I")
        sail = xls.cell(i,"J")
        fuel = xls.cell(i,"K")
        crew = xls.cell(i,"L")
        gear = xls.cell(i,"M").downcase rescue ''
        weight = xls.cell(i,"N")
        qty = xls.cell(i,"O")
        value = xls.cell(i,"P")
      
        unless reg.blank?
          gear_id = Gear.where("LOWER(code) = ?", gear).first.id rescue nil
      
          Landing.create(power: power, fishing_area: fishing_area, type: type, vessel_ref: reg, vessel_name: name, engine: engine, sail: sail,
            fuel: fuel, crew: crew, weight: weight, quantity: qty, value: value, time_in: arr_time,
            time_out: dep_time, gear_id: gear_id)
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
          fish_id = Fish.where("LOWER(code) = ?", species).first.id rescue nil
        
          Catch.create(fish_id: fish_id, length: length, weight: weight)
        end
      end
    end
    
    # Survey
    if xls.sheets.include?('Survey')
      xls.default_sheet = 'Survey'
    
      fishery = xls.cell(1,"B").downcase  rescue ''
      kabupaten = xls.cell(2,"B")
      code_desa = xls.cell(3,"B").downcase  rescue ''
      date = xls.cell(4,"B")
      start_time = xls.cell(5,"B")
      end_time = xls.cell(6,"B")
      fleet_observer = xls.cell(7,"B")
      catch_scribe = xls.cell(8,"B")
      catch_measure = xls.cell(9,"B")
        
      unless fishery.blank?
        desa_id = Desa.where("LOWER(code) = ?", code_desa).first.id rescue nil
        fishery_id = Fishery.where("LOWER(code) = ?", fishery).first.id rescue nil

        Survey.create(fishery_id: fishery_id, desa_id: desa_id, date_published: date, 
          start_time: start_time, end_time: end_time, fleet_observer: fleet_observer,
          catch_scribe: catch_scribe, catch_measure: catch_measure, user_id: user_id)
      end
    end
    
  end
end
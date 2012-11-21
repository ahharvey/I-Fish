class ImportExcelData
  def self.working_based_sheet(id)
    xl_file = ExcelFile.find(id)
    xls = Excelx.new(xl_file.file.path)
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
        gear = xls.cell(i,"M")
        weight = xls.cell(i,"N")
        qty = xls.cell(i,"O")
        value = xls.cell(i,"P")
      
        unless reg.blank?
          gear_id = Gear.where("name = ?", gear).first.id rescue nil
      
          Landing.create(vessel_ref: reg, vessel_name: name, engine: engine, sail: sail,
            fuel: fuel, crew: crew, weight: weight, quantity: qty, value: value, time_in: arr_time,
            time_out: dep_time, gear_id: gear_id)
        end
      end
    end
    
    # form B
    if xls.sheets.include?('Form B - Catch')
      xls.default_sheet = 'Form B - Catch'
    
    
      for i in 2..xls.last_row
        species = xls.cell(i,"B")
        length = xls.cell(i,"C")
        weight = xls.cell(i,"D")
        unless species.blank?
          fish_id = Fish.where("species = ?", species).first.id rescue nil
        
          Catch.create(fish_id: fish_id, length: length, weight: weight)
        end
      end
    end
    
    # Survey
    if xls.sheets.include?('Survey')
      xls.default_sheet = 'Survey'
    
      fishery = xls.cell(1,"B")
      kabupaten = xls.cell(2,"B")
      desa = xls.cell(3,"B")
      date = xls.cell(4,"B")
      start_time = xls.cell(5,"B")
      end_time = xls.cell(6,"B")
      fleet_observer = xls.cell(7,"B")
      catch_scribe = xls.cell(8,"B")
      catch_measure = xls.cell(9,"B")
        
      unless fishery.blank?
        desa_id = Desa.where("name = ?", desa).first.id rescue nil
        
        Survey.create(fishery: fishery, desa_id: desa_id, date: date, 
          start_time: start_time, end_time: end_time, observer: fleet_observer,
        scribe: catch_scribe, measure: catch_measure)
      end
    end
    
  end
end
class ImportExcelData
  def self.working_based_sheet(id)
    xl_file = ExcelFile.find(id)
    xls = Excelx.new(xl_file.file.url)
    sheets = xls.sheets

    # form A
    unless xls.sheets['Form A - Fleet'].blank?
      xls.default_sheet = xls.sheets['Form A - Fleet']
    
    
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
            time_out: dep_time, gear: gear_id)
        end
      end
    end
    
    # form B
    unless xls.sheets['Form B - Catch'].blank?
      xls.default_sheet = xls.sheets['Form B - Catch']
    
    
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
    
  end
end
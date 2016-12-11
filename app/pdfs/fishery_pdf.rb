class FisheryPdf < BasePdf

  def initialize(fishery, view)
    super

    @fishery = fishery




    #canvas do

      build_header
      build_companies
      build_vessels

      start_new_page

      build_production
      build_operations
    #end
  end

  def build_header
    grid([0,0], [0,5]).bounding_box do
      title @fishery.name
      subtitle "Monthly Report #{(Date.today-1.month).year}-#{(Date.today-1.month).month}"
    end
    grid([0,5], [0,5]).bounding_box do
      build_logo width: bounds.width * 0.5, height: bounds.height * 0.5, left: bounds.width * 0.5
      fill_color "188BA0"
      text_box "AP2HI", size: 8, align: :center, color: "188BA0", at: [bounds.width * 0.5, bounds.height*0.5]
    end
  end
  def build_companies
    grid([1,0], [1,5]).bounding_box do
      h1 "COMPANIES"
    end
    grid([2,0], [3,5]).bounding_box do
      p "#{@fishery.member_companies.size} companies operate in #{@fishery.name}."
      bounding_box([0, bounds.top-20], width: bounds.width , height: bounds.height-20) do
        top = 0
        lft = 0
        @fishery.member_companies.each_with_index do |company, i|
          if company.avatar?
            image company.avatar.file.file, fit: [40, 40], at: [40*i,bounds.top]#[40*(i-lft),bounds.top-top]
          end
          top = top + 40 if ( i.to_f/4 == 0 )
          lft = lft + 4  if ( i.to_f/4 == 0 )
          #text company.name, size: 10, align: :left, color: "188BA0"
        end
      end
    end
    grid([2,4], [3,5]).bounding_box do
      rows = [["Type", "Number"]]
      if @fishery.member_companies.any?

        rows << ['Harvest', @fishery.member_companies.harvest.size]
        rows << ['Processing', @fishery.member_companies.processing.size]
        rows << ['Unknown', @fishery.member_companies.unknown_type.size]

      else
        rows << ['None','-']
      end
      build_table rows, bounds.width
    end
  end
  def build_vessels
    grid([4,0], [4,5]).bounding_box do
      h1 "VESSELS"
    end
    grid([5,0], [6,1]).bounding_box do
      a = "#{@view.pluralize(@fishery.vessels.size, 'vessel')} operate the #{@fishery.name} fishery. "
      b = "#{@view.pluralize(@fishery.vessels.ap2hi.size, 'vessel')} are AP2HI members and participate in a Fishery Improvement Project. "
      c = "AP2HI collaborates with partners, including the Ministry of Marine Affairs and Fisheries, to ensure high sustainability and compliance standards."
      p a + b + c
    end
    grid([5,3], [6,5]).bounding_box do

      rows = [["Status", "<10 GT", "10-30 GT", ">30 GT"]]
      if @fishery.vessels.any?

        rows << [
          'Certified',
          @fishery.vessels.certified.sm.size.to_i,
          @fishery.vessels.certified.md.size.to_i,
          @fishery.vessels.certified.lg.size.to_i
        ]
        rows << [
          'In Assessment',
          @fishery.vessels.in_assessment.sm.size.to_i,
          @fishery.vessels.in_assessment.md.size.to_i,
          @fishery.vessels.in_assessment.lg.size.to_i
        ]
        rows << [
          'Other Elligible Fishers',
          @fishery.vessels.other_elligibles.sm.size.to_i,
          @fishery.vessels.other_elligibles.md.size.to_i,
          @fishery.vessels.other_elligibles.lg.size.to_i
        ]

      else
        rows << ['-','-','-','-']
      end
      build_table rows, bounds.width, [ bounds.width * 0.4, bounds.width * 0.2, bounds.width * 0.2, bounds.width * 0.2]
    end
    grid([7,2], [7,2]).bounding_box do
      calc = (100 * @fishery.vessels.with_valid_docs.size)/@fishery.vessels.ap2hi.size  rescue 0
      data = { "COC" => calc }
      title = "Vessels with code of conduct"
      svg svgpie data, size: bounds.width, donut: true, single: true, background: true, title: title
    end
    grid([7,1], [7,1]).bounding_box do
      calc = (100*@fishery.vessels.with_valid_docs.size)/@fishery.vessels.ap2hi.size  rescue 0
      calc = 75
      data = { "DOCS" => calc }
      title = "Vessels with valid licences"
      svg svgpie data, size: bounds.width, donut: true, single: true, background: true, title: title
    end
    grid([7,3], [7,3]).bounding_box do
      calc = (100*@fishery.vessels.audited_this_year.size)/@fishery.vessels.ap2hi.size rescue 0
      calc = 25
      data = { "Inspected" => calc }
      title = "Vessels inspected within 12 months"
      svg svgpie data, size: bounds.width, donut: true, single: true, background: true, title: title
    end
    grid([7,4], [7,4]).bounding_box do
      calc = (100*@fishery.vessels.audited_this_year.size)/@fishery.vessels.ap2hi.size rescue 0
      calc = 50
      data = { "VMS" => calc }
      title = "Vessels with VMS"
      svg svgpie data, size: bounds.width, donut: true, single: true, background: true, title: title
    end
  end

  def build_production
    grid([0,0], [0,5]).bounding_box do
      h1 "PRODUCTION"
    end
    grid([1,0], [1,2]).bounding_box do
      p "#{@fishery.unloadings.last_month.size} fishing trips took place this month, with a total production of #{@fishery.unloading_catches.last_month.sum(:quantity)}mt."
    end

    grid([2,0], [2,0]).bounding_box do
      data = @fishery.unloading_catches.current.to_catch_composition_chart
      title = "Catch composition (#{Date.today.year})"
      svg svgpie data, size: bounds.height, title: title, legend: true, donut: true, mid_val: false
    end
    grid([3,0], [3,0]).bounding_box do
      data = @fishery.unloading_catches.to_catch_composition_chart
      title = "Av. catch composition (#{@fishery.unloadings.default.last.try(:time_out).try(:year)} - #{Date.today.year})"
      svg svgpie data, size: bounds.height, title: title, legend: true, donut: true, mid_val: false
    end

    grid([2,2], [2,3]).bounding_box do
      data = @fishery.unloading_catches.current.to_monthly_production_chart
      title = "Volume (#{Date.today.year})"
      svg svgchart data, width: bounds.width, height: bounds.height, labels: %w{ J F M A M J J A S O N D }, y_title: 'kg', title: title, legend: true
    end
    grid([3,2], [3,3]).bounding_box do
      data = @fishery.unloading_catches.to_monthly_production_chart
      title = "Av. volume (#{@fishery.unloadings.default.last.try(:time_out).try(:year)} - #{Date.today.year})"
      svg svgchart data, width: bounds.width, height: bounds.height, labels: %w{ J F M A M J J A S O N D }, y_title: 'kg', title: title, legend: true
    end

    grid([1,5], [1,5]).bounding_box do
      calc = (100*@fishery.unloadings.with_vms.size)/@fishery.unloadings.size rescue 0
      data = { "VMS" => calc }
      title = "Trips with VMS"
      svg svgpie data, size: bounds.height, donut: true, single: true, background: true, title: title
    end
    grid([2,5], [2,5]).bounding_box do
      calc = (100*@fishery.unloadings.with_observers.size)/@fishery.unloadings.size rescue 0
      data = { "Observers" => calc }
      title = "Trips with Observers"
      svg svgpie data, size: bounds.height, donut: true, single: true, background: true, title: title
    end
    grid([3,5], [3,5]).bounding_box do
      calc = (100*@fishery.unloadings.with_port_sampling.size)/@fishery.unloadings.size rescue 0
      data = { "Sampling" => calc }
      title = "Trips with Port Sampling"
      svg svgpie data, size: bounds.height, donut: true, single: true, background: true, title: title
    end


  end

  def build_operations
    grid([4,0], [4,5]).bounding_box do
      h1 "OPERATIONS"
    end
    grid([5,0], [6,2]).bounding_box do
      p "As a core part of its sustainability initiatives, AP2HI is committed to monitoring and supporting efficiency improvements within the fishery."
    end
    grid([6,0], [6,0]).bounding_box do
      #bounding_box([0, bounds.top], width: bounds.width * 0.3, height: bounds.height) do
        data = @fishery.to_bait_ratio(current: true)
        data = data.sum(&:last)/data.size.to_f
        data = { "Bait" => data.round(0) }
        title = "Bait:Tuna ratio (#{Date.today.year})"
        svg svgpie data, size: bounds.height, title: title, legend: false, donut: true, single: true, mid_val: true, background: true
      #
    end
    grid([7,0], [7,0]).bounding_box do
      #bounding_box([bounds.width * 0.3, bounds.top], width: bounds.width * 0.7, height: bounds.height) do
      data = @fishery.to_bait_ratio
      data = data.sum(&:last)/data.size.to_f
      data = { "Bait" => data.round(0) }
      title = "Av. bait:tuna ratio (#{@fishery.unloadings.default.last.try(:time_out).try(:year)} - #{Date.today.year})"
      svg svgpie data, size: bounds.height, title: title, legend: false, donut: true, mid_val: true, background: true, single: true
      #end
    end
    grid([6,4], [7,5]).bounding_box do
      #bounding_box([0, bounds.top], width: bounds.width * 0.3, height: bounds.height) do

        data = @fishery.unloadings.to_monthly_fuel_utilization
        title = "Catch composition (#{Date.today.year})"
        svg svgscatter data,
          width: bounds.width,
          height: bounds.height,
          title: 'Fuel Efficiency',
          y_title: "Catch (kg)",
          x_title: "Fuel (L)"
      #end
    end
  end









  def build_pie
    svg = '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100px" x="0px" y="0px" height="100px" viewBox="0 0 32 32" background="#000000" border-radius="50%">'
    svg += '<circle r="16" cx="16" cy="16" stroke-width="32" stroke="#cccccc" fill="#134886" stroke-dasharray="38 100"/>'
    svg += '</svg>'
  end




end

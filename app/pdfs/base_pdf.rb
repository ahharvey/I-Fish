
class BasePdf < Prawn::Document


  def initialize(object, view)
    #super(top_margin: 70)
    super()
    define_grid( columns: 6, rows: 9, column_gutter: 10, row_gutter: 0)
    @view = view
    font "Helvetica", color: "188BA0"
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end

  def svgscatter data, *args
    ::Svg::ScatterChart.new(data,*args).render
  end

  def svgpie data, *args
    ::Svg::PieChart.new(data,*args).render
#    opts = args.extract_options!
#    size = opts[:size] || 100
#    legend = opts[:legend] || false
#    title = opts[:title] || false
#    donut = opts[:donut] || false
#    single = opts[:single] || false
#    background = opts[:background] || false#
#

#    x   = 100
#    y   = 0
#    tot = 0
#    data.each_value { |v| tot += v } unless single# calculates the sum of all segments and assigns to `tot`
#    tot = 100 if single#

#    # color scheme
#    col = %w{ #188BA0 #136F7F #26DEFF #0A3740 #22C7E5 #CCF7FF #DAEEF2 #E3E9EA #8899AA #D7DCDD #99EFFF #BBDDDD #ADD2D8 #AACCDD #79DFF2 #557777 #228899 #188BA0 #3F757F #008EA8 #117788 #3D4A4C #005566 #2B2B2B #101111 #001122}#

#    # title
#    if title#

#      tit = "<text text-anchor='middle' x='0' y='120' font-family='Helvetica' font-size='12' font-weight='bold'>#{title}</text>"#

#    end#

#    leg = ""
#    svg = "<svg width='#{size}px' height='#{size}px' viewBox='-100 -100 #{legend ? 300 : 200} #{title ? 250 : 200}'>"
#    svg += "<circle r='100' cx='0' cy='0' fill='#dddddd' ></circle>" if background
#    svg += "<g transform='rotate(#{single ? 90 : -90})'>"#

#    #leg = "<svg width='#{size}px' height='#{size}px' viewBox='-100 -100 200 200'>"
#    data.each_with_index do |d, i|
#      seg   = d[1]
#      px    = x
#      py    = y
#      pre   = 0
#      data.first(i).to_h.each_value { |v| pre += v }
#      rad   = 2 * Math::PI * ( ( seg + pre ) / tot.to_f )
#      x     = ( Math::cos(rad) * 100 )
#      y     = ( Math::sin(rad) * 100 )#

#      if ( seg / tot.to_f ) >= 0.5
#        svg += "<path d='M0,0 L#{px},#{py} A100,100 0 1,1 #{x},#{y} Z' fill='#{col[i]}' fill-opacity='1' />"
#      else
#        svg += "<path d='M0,0 L#{px},#{py} A100,100 0 0,1 #{x},#{y} Z' fill='#{col[i]}' fill-opacity='1' />"
#      end#

#      leg += "<g transform='translate(110, #{-100 + (i * 18 ) + 20 } )'>" #place each legend on the right and bump each one down 15 pixels
#      leg += "<rect width='15px' height='15px' fill='#{col[i]}' />"
#      leg += "<text x='17' y='11' font-size='8' font-family='Helvetica' >#{d[0]}</text>"
#      leg += "</g>"#

#      Rails.logger.info 'HHHHHHHHHHHHHHH' if d[0] == 'LIG'
#      Rails.logger.info "<path d='M0,0 L#{px},#{py} A100,100 0 #{x <= 0.to_f ? 1 : 0},#{y <= 0.to_f ? 1 : 0} #{x},#{y} Z' fill='#{col[i]}' fill-opacity='1' />"  if d[0] == 'LIG'
#      if d[0] == 'Inspected'
#        Rails.logger.info 'XXXXXXXXXXXXXXXXXX'
#        Rails.logger.info "<path d='M0,0 L#{px},#{py} A100,100 0 #{x <= 0.to_f ? 1 : 0},#{y <= 0.to_f ? 1 : 0} #{x},#{y} Z' fill='#{col[i]}' fill-opacity='1' />"
#      end
#    end#

#    svg += '</g>'
#    svg += "<circle r='55' cx='0' cy='0' fill='#ffffff' ></circle>" if donut
#    svg += "<text text-anchor='middle' x='0' y='12' font-family='Helvetica' font-size='22' font-weight='bold'>#{data.first[1]}%</text>" if donut
#    svg += leg if legend
#    svg += tit if title
#    svg += "</svg>"#

#    Rails.logger.info svg#

#    svg
  end

  def title content
    text content, size: 16, align: :left, color: "188BA0"
  end

  def subtitle content
    text content, size: 12, align: :left, color: "188BA0"
  end

  def h1 content
    move_down 10
    stroke do
      stroke_color "188BA0"
      #dash(5, space: 2, phase: 0)
      line_width 1
      stroke_horizontal_rule
      move_down 2
      horizontal_line(0, 540)
      move_down 30
    end
    text content, size: 14, align: :center, color: "188BA0"
    move_down 20
  end

  def p content
    text content, size: 11, align: :justify, color: "444444"
    move_down 3
  end

  def build_logo *args
    opts    = args.extract_options!
    width   = opts[:width]  || 100
    height  = opts[:height] || 100
    left    = opts[:left]   || 0
    top     = opts[:top]    || 0
    path    =  "#{Rails.root}/app/assets/images/ap2hi.jpg"
    image path, fit: [width, height] , position: left, vposition: top
  end

  def filling
    stroke do
      fill_color '134886'
      fill_rectangle [cursor-bounds.height,cursor], bounds.width, bounds.height
      fill_color '000000'
    end
  end

  def build_table content, width, column_widths=nil
    cols = column_widths || [width * 0.7, width * 0.3]
    table(content, cell_style: { size: 7, padding: 5, height: 20 }, column_widths: cols ) do
      cells.borders = []
      row(0).borders = [:bottom]
      rows(0..4).border_width = 0.2
      row(0).font_style = :bold
      row(0).valign = :bottom
      row(0).size = 7
      column(1..5).align = :right
      columns(0..0).borders = [:right]
      row(0).columns(0..0).borders = [:bottom, :right]
      row(1..4).columns(0..0).borders = [:right]
    end
  end

  def svgchart data, *args
    ::Svg::BarChart.new(data,*args).render
  end

end

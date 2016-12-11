module Svg

  class BarChart

    def initialize data, *args
      opts = args.extract_options!
      @data       = data

      @keys = @data[0][:data].keys
      @h = Hash[@keys.map {|x| [x, 0]}]

      @labels = opts[:labels] || @h.keys
      @width = opts[:width] || 100
      @height = opts[:height] || 50

      @y_title = opts[:y_title] || false
      @x_title = opts[:x_title] || false
      @title   = opts[:title] || false
      @legend   = opts[:legend] || false

      # we iterate through the data hash to calaculate the
      # max value for each month
      @data.each_with_index do |d, i|
        d[:data].each_with_index do |p,ii|
          month = p[0]
          oldvalue = @h.select{|k| k == month }.first[1]
          value = p[1]
          @h[month] = oldvalue+value
        end
      end


      @colors = %w{ #188BA0 #136F7F #26DEFF #0A3740 #22C7E5 #CCF7FF #DAEEF2 #E3E9EA #8899AA #D7DCDD #99EFFF #BBDDDD #ADD2D8 #AACCDD #79DFF2 #557777 #228899 #188BA0 #3F757F #008EA8 #117788 #3D4A4C #005566 #2B2B2B #101111 #001122}
      @cols = @labels.count
      @cats = @data.count
      @max = @h.values.max.round(-2)
      @lft   = 0
      @rgt   = 200
      @top   = 0
      @btm   = 100
      @ticks = 9
      @colwidthouter = ((@rgt-@lft)/@cols.to_f)
      @colwidthinner = @colwidthouter*0.9
      @tickheight = (@btm-@top)/@max.to_f

      render
    end

    def render

      svg =   "<svg x='0px' y='0px' height='#{@height}px' width='#{@width}px' viewBox='-20 -30 250 150' >"

      svg += columns
      svg += axes
      svg += y_title  if @y_title
      svg += x_title  if @y_title
      svg += title    if @title
      svg += legend   if @legend

      #svg += x_labels
      #svg += y_labels



  #    svg +=  "
  #      <g id='month1' stroke='#000000' stroke-width='0.5' stroke-miterlimit='10' >
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*0)}' y='#{btm - (tickheight * 1)}' fill='#808080' height='#{tickheight * 1}'/>
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*0)}' y='#{btm - (tickheight * 3) - (tickheight*1)}' fill='#DFDFDF' height='#{tickheight * 3}'/>
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*0)}' y='#{btm - (tickheight * 5) - (tickheight*1) - (tickheight*3)}' fill='#000000' height='#{tickheight * 5}'/>
  #      </g>"#

  #    svg +=  "
  #      <g id='month2' stroke='#000000' stroke-width='0.5' stroke-miterlimit='10' >
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*1)}' y='#{btm}' fill='#808080' height='#{tickheight * 8}'/>
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*1)}' y='#{btm + (tickheight*8)}' fill='#DFDFDF' height='#{tickheight * 1}'/>
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*1)}' y='#{btm + (tickheight*8) + (tickheight*1)}' fill='#000000' height='#{tickheight * 1}'/>
  #      </g>"
  #    svg +=  "
  #      <g id='month2' stroke='#000000' stroke-width='0.5' stroke-miterlimit='10' >
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*2)}' y='#{btm}' fill='#808080' height='#{tickheight * 1}'/>
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*2)}' y='#{btm + (tickheight*1)}' fill='#DFDFDF' height='#{tickheight * 8}'/>
  #        <rect width='#{colwidthinner}' x='#{lft + (colwidthouter*0.05) + (colwidthouter*2)}' y='#{btm + (tickheight*1) + (tickheight*1)}' fill='#000000' height='#{tickheight * 8}'/>
  #      </g>"







      svg +=  "</svg>"

      svg
    end
  private

    def columns
      keys = @data[0][:data].keys
      h = Hash[keys.map {|x| [x, 0]}]

      # we translate left by 0.5 col width to center the columns
      svg = "<g class='data' data-setname='Production' transform='translate(#{@colwidthinner * -0.5})' >"
      @data.each_with_index do |d, i|

        unless d[:data].values.sum == 0
          d[:data].each_with_index do |p,ii|
            month = p[0]
            oldheight = h.select{|k| k == month }.first[1]
            height = @tickheight * p[1]
            h[month] = oldheight+height
            svg +=  "<rect x='#{0 + (@colwidthouter*ii) + (@colwidthouter*0.5)}' y='#{100 - height - oldheight}' width='#{@colwidthinner}' fill='#{@colors[i]}' height='#{height}'/>"
          end
        end
      end
      svg += '</g>'
    end

    def axes
      x_axis + y_axis + x_ticks + y_ticks
    end

    def x_axis
      "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='0' y1='100' x2='200' y2='100'/>"
    end

    def y_axis
      "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='0' y1='0' x2='0' y2='100'/>"
    end

    def legend
      legend_swatches + legend_text
    end

    def legend_swatches
      svg =  "<g id='legend_swatches' stroke-width='0' >"
        @data.each_with_index do |d, i|
          unless d[:data].values.sum == 0
            svg +=  "<rect width='10' height='10' x='205' y='#{0 + ((100/@cats.to_f)*i)}' fill='#{@colors[i]}' />"
          end
        end
      svg +=  "</g>"
    end

    def legend_text
      svg =  "<g id='legend_text' font-family='Helvetica' font-size='8'>"
        @data.each_with_index do |d, i|
          unless d[:data].values.sum == 0
            svg +=  "<text x='220' y='#{8 + ((100/@cats.to_f)*i)}'>#{d[:name]}</text>"
          end
        end
      svg +=  "</g>"
    end

    def x_ticks
      x_labels =  "<g font-size='8'>"
        @labels.each_with_index do |label, i|
          x_labels +=  "<text x='#{0 + (@colwidthouter*i) + (@colwidthouter*0.5)}' y='110' text-anchor='middle' >#{label}</text>"
        end
      x_labels +=  "</g>"
    end

    def y_ticks
      "
        <g class='y-ticks'>
          <line fill='none' stroke='#000000' stroke-miterlimit='10' x1='-5' x2='0' y1='100' y2='100'/>
          <line fill='none' stroke='#000000' stroke-miterlimit='10' x1='-5' x2='0' y1='50' y2='50'/>
          <line fill='none' stroke='#000000' stroke-miterlimit='10' x1='-5' x2='0' y1='0' y2='0'/>
        </g>
        <g class='y-tick-labels'>
          <text text-anchor='end' font-size='8' x='-10' y='100'>0</text>
          <text text-anchor='end' font-size='8' x='-10' y='50'>#{(@max/2).round(-2)}</text>
          <text text-anchor='end' font-size='8' x='-10' y='0'>#{@max.round(-2)}</text>
        </g>
      "
    end

    def y_title
      "
        <g transform='translate(-30,50) rotate(-90)'>
          <text text-anchor='middle' font-size='10'>#{@y_title}</text>
        </g>
      "
    end
    def x_title
      "
        <g>
          <text text-anchor='middle' font-size='10' x='100' y='130'>#{@x_title}</text>
        </g>
      "
    end

    def title
      "
        <g>
          <text text-anchor='middle' font-size='10' font-weight='bold' x='100' y='-20'>#{@title}</text>
        </g>
      "
    end

  end
end

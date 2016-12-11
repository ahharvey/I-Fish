
module Svg

  class PieChart

    def initialize data, *args
      opts        = args.extract_options!
      @data       = data
      @cats       = data.count
      @size       = opts[:size] || 100
      @legend     = opts[:legend] || false
      @title      = opts[:title] || false
      @donut      = opts[:donut] || false
      @mid_val      = opts[:mid_val] || false
      @single     = opts[:single] || false
      @background = opts[:background] || false
      @title_height = 0 unless @title
      @title_height = 20 if @title
      @lg_width     = 0 unless @legend
      @lg_width     = 20 if @legend
      @x          = 100
      @y          = 0
      @tot        = 0
      @data.each_value { |v| @tot += v } unless @single# calculates the sum of all segments and assigns to `tot`
      @tot        = 100     if @single

      # color scheme
      @col        = %w{ #188BA0 #136F7F #26DEFF #0A3740 #22C7E5 #CCF7FF #DAEEF2 #E3E9EA #8899AA #D7DCDD #99EFFF #BBDDDD #ADD2D8 #AACCDD #79DFF2 #557777 #228899 #188BA0 #3F757F #008EA8 #117788 #3D4A4C #005566 #2B2B2B #101111 #001122}

      render
    end

    def render

      svg = "<svg width='#{@size}' height='#{@size}' viewBox='-100 -120 230 220}'>"

      svg += chart

      svg += title if @title
      svg += legend if @legend
      svg += "</svg>"#

    end
  private
    def title
      "<text text-anchor='middle' x='0' y='-110' font-family='Helvetica' font-size='12' font-weight='bold'>#{@title}</text>"
    end
    def legend
      legend_swatches + legend_text
    end

    def legend_swatches
      svg =  "<g id='legend_swatches' stroke-width='0'>"
        @data.each_with_index do |d, i|
          unless (d[1]/@tot.to_f) == 0
            svg +=  "<rect width='10' height='10' x='105' y='#{-100 + ((200/@cats.to_f)*i)}' fill='#{@col[i]}' />"
          end
        end
      svg +=  "</g>"
    end
    def legend_text
      svg =  "<g id='legend_text' font-family='Helvetica' font-size='8'>"
      @data.each_with_index do |d, i|
        unless (d[1]/@tot.to_f) == 0
          svg += "<text x='120' y='#{-100 + 8 + ((200/@cats.to_f)*i)}' font-size='8' font-family='Helvetica' >#{d[0]}</text>"
        end
      end
      svg +=  "</g>"
    end
    def chart
      svg = ''
      svg += background if @background
      svg += "<g transform='rotate(#{@single ? 90 : -90})'>"

      svg += segments

      svg += '</g>'
      svg += donut if @donut
    end
    def background
      "<circle r='100' cx='0' cy='0' fill='#dddddd' ></circle>"
    end
    def donut
      svg = "<circle r='55' cx='0' cy='0' fill='#ffffff' ></circle>"
      svg += "<text text-anchor='middle' x='0' y='12' font-family='Helvetica' font-size='22' font-weight='bold'>#{@data.first[1]}%</text>" if @mid_val
      svg
    end

    def segments
      x = @x
      y = @y
      svg = ''
      @data.each_with_index do |d, i|
        seg   = d[1]
        px    = x
        py    = y
        pre   = 0
        @data.first(i).to_h.each_value { |v| pre += v }
        rad   = 2 * Math::PI * ( ( seg + pre ) / @tot.to_f )
        x     = ( Math::cos(rad) * 100 )
        y     = ( Math::sin(rad) * 100 )

        if ( seg / @tot.to_f ) >= 0.5
          svg += "<path d='M0,0 L#{px},#{py} A100,100 0 1,1 #{x},#{y} Z' fill='#{@col[i]}' fill-opacity='1' />"
        else
          svg += "<path d='M0,0 L#{px},#{py} A100,100 0 0,1 #{x},#{y} Z' fill='#{@col[i]}' fill-opacity='1' />"
        end
      end
      svg
    end
  end
end

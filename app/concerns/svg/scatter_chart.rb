module Svg

  class ScatterChart

    def initialize data, *args
      opts        = args.extract_options!
      @data = data
      @headers = @data.shift
      @max_fuel = @data.map(&:first).max.round(-3)
      @max_catch = @data.map(&:last).max.round(-3)
      @width = opts[:width] || 100
      @height = opts[:height] || 100
      @title = opts[:title] || false
      @x_title = opts[:x_title] || false
      @y_title = opts[:y_title] || false
      @colors = %w{ #188BA0 #136F7F #26DEFF #0A3740 #22C7E5 #CCF7FF #DAEEF2 #E3E9EA #8899AA #D7DCDD #99EFFF #BBDDDD #ADD2D8 #AACCDD #79DFF2 #557777 #228899 #188BA0 #3F757F #008EA8 #117788 #3D4A4C #005566 #2B2B2B #101111 #001122}

      @lft   = 0
      @rgt   = @width
      @top   = 0
      @btm   = @height

      render
    end

    def render
      svg = "<svg width='#{@width}px' height='#{@height}px' viewBox='0 0 200 200'>"
      svg += chart
      svg += "</svg>"
    end

    def chart
      svg = "<svg x='30' viewBox='-40 -30 280 280}'>"
      svg += axes
      svg += "<g class='data' data-setname='Fuel Efficiency' >"
      @data.each do |d|
        svg += "<circle cx='#{(200/@max_fuel.to_f)*d[0]}' cy='#{200-((200/@max_catch.to_f)*d[1])}' data-value='7.2' r='4' fill='#{@colors[1]}' />"
      end
      svg += "</g>"
      svg += y_ticks
      svg += y_title  if @y_title
      svg += x_ticks
      svg += x_title  if @x_title
      svg += title    if @title
      svg += "</svg>"
    end

    def axes
      lft = 0
      rgt = 200
      top = 0
      btm = 200
      svg =  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{lft}' y1='#{btm}' x2='#{rgt}' y2='#{btm}'/>"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{lft}' y1='#{btm}' x2='#{lft}' y2='#{top}'/>"
    end

    def y_ticks
      lft = 0
      rgt = 200
      top = 0
      btm = 200
      svg = "<g >"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{lft-8}' y1='#{btm}' x2='#{lft}' y2='#{btm}'/>"
      svg +=  "<text text-anchor='end' alignment-baseline='central' font-size='8' transform='matrix(0.7952 0 0 1 #{lft-10} #{btm})'>0</text>"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{lft-8}' y1='#{btm/2}}' x2='#{lft}' y2='#{btm/2}}'/>"
      svg +=  "<text text-anchor='end' alignment-baseline='central' font-size='8' transform='matrix(0.7952 0 0 1 #{lft-10} #{btm/2})'>#{@max_catch/2}</text>"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{lft-8}' y1='#{top}' x2='#{lft}' y2='#{top}'/>"
      svg +=  "<text text-anchor='end' alignment-baseline='central' font-size='8' transform='matrix(0.7952 0 0 1 #{lft-10} #{top})'>#{@max_catch}</text>"
      svg += "</g>"
    end

    def x_ticks
      lft = 0
      rgt = 200
      top = 0
      btm = 200
      svg = "<g>"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{lft}' y1='#{btm}' x2='#{lft}' y2='#{btm+8}'/>"
      svg +=  "<text text-anchor='middle' font-size='8' transform='matrix(0.7952 0 0 1 #{lft} #{btm+18})'>0</text>"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{rgt/2}' y1='#{btm}}' x2='#{rgt/2}' y2='#{btm+8}}'/>"
      svg +=  "<text text-anchor='middle' font-size='8' transform='matrix(0.7952 0 0 1 #{rgt/2} #{btm+18})'>#{@max_fuel/2}</text>"
      svg +=  "<line fill='none' stroke='#000000' stroke-miterlimit='10' x1='#{rgt}' y1='#{btm}' x2='#{rgt}' y2='#{btm+10}'/>"
      svg +=  "<text text-anchor='middle' font-size='8' transform='matrix(0.7952 0 0 1 #{rgt} #{btm+18})'>#{@max_fuel}</text>"
      svg += "</g>"
    end

    def x_title
      svg  = "<g>"
      svg += "<text text-anchor='middle' font-size='10' x='100' y='230'>#{@x_title}</text>"
      svg += "</g>"
    end

    def y_title
      svg  = "<g transform='translate(-30,100) rotate(-90)'>"
      svg += "<text text-anchor='middle' font-size='10'>#{@y_title}</text>"
      svg += "</g>"
    end

    def title
      svg  = "<g>"
      svg += "<text text-anchor='middle' font-size='10' font-weight='bold' x='100' y='-20'>#{@title}</text>"
      svg += "</g>"
    end

  end
end

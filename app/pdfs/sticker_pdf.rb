class StickerPdf < Prawn::Document
	require 'prawn/qrcode'

  def initialize(vessels)
    super(page_layout: :landscape)

    @vessels = vessels

    define_grid columns: 2, rows: 3, gutter: 10
    font "Helvetica", color: "188BA0"

    
    

    build_sticker

    build_crop_marks(10,35,5,0.5)

  end

  private

  def build_sticker
    @col=0
    @row=0
    @vessels.each do |vessel|

      grid(@row,@col).bounding_box do

        bounding_box([0, bounds.top], width: bounds.width * 0.25, height: bounds.height * 0.5) do

          build_logo( bounds.width, bounds.height )

        end
        bounding_box([bounds.width * 0.25, bounds.top], width: bounds.width * 0.75, height: bounds.height * 0.5) do

          build_ap2hi_header
        end

        stroke_color 'cccccc'
        stroke_horizontal_line 50, bounds.width - 50
        
        bounding_box([0, bounds.height * 0.5], width: bounds.width * 0.75, height: bounds.height * 0.4) do

          build_vessel_info(vessel)
        end
        bounding_box([bounds.width * 0.75, bounds.height * 0.5], width: bounds.width * 0.25, height: bounds.height * 0.4) do
          url = UrlHelpers.vessel_url(vessel)
          build_qr_code(url, bounds.width, bounds.height)
        end

        bounding_box([0, bounds.height * 0.1], width: bounds.width, height: bounds.height * 0.1) do

          build_url
        end

        if @row == 2 && @col == 1
          start_new_page
          define_grid columns: 2, rows: 3, gutter: 10
          @col = 0
          
          @row = 0
        else 
          if @col == 1
            @row += 1
            @col = 0
          else
            @col += 1
          end
        end
#       build_logo
#       bounding_box([100, 0], width: 200, height: 100) do
#         
#       end
#       move_down 5
#       
#       move_down 5

#       move_down 10
#       text "www.ap2hi.org", size: 10, align: :center, color: '333333'
#       render_qr_code( RQRCode::QRCode.new("http://mantawatch.com", :size => 5) )
      end

    end
  end

  def build_logo(width, height)
    logopath =  "#{Rails.root}/app/assets/images/ap2hi.jpg"
    image logopath, fit: [width, height], position: 0, vposition: 0
  end

  def build_ap2hi_header
    move_down 10
    text "AP2HI", size: 22, align: :center, color: "188BA0"
    move_down 3
    text "Asosiasi Perikanan Pole & Line dan Handline Indonesia", size: 14, color: "188BA0", align: :center
    move_down 3
    text "Indonesian Pole & Line and Handline Fisheries Association", size: 8, color: "188BA0", align: :center
  end

  def build_vessel_info(vessel)
    
    

    bounding_box([0, bounds.top], width: bounds.width * 0.35, height: bounds.height) do
      move_down 10
      text "NAMA KAPAL: ", size: 6, align: :right, styles: [:bold]
      move_down 10
      text "NOMOR REGISTRASI: ", size: 6, align: :right, styles: [:bold]
    end

    bounding_box([bounds.width * 0.35, bounds.top], width: bounds.width * 0.65, height: bounds.height) do
      move_down 10
      text vessel.name, indent_paragraphs: 10
      move_down 5
      text vessel.ap2hi_ref, indent_paragraphs: 10
    end
    
  end

  def build_qr_code(url, width, height)
    encoded_string  = RQRCode::QRCode.new(url)
    render_qr_code(encoded_string, pos: [0,height], extent: height, dot: 1.5, stroke: false)
  end

  def build_url
    text "www.ap2hi.org", size: 10, align: :center, color: "188BA0"
  end

  def build_crop_marks(spacing, margin, gutter, lineweight)
    #crop mark line thickness
    line_width(lineweight)

    repeat :all do
  
      #spacing = 2.125
      #margin = 9
    
      #Draw crop marks
      canvas do
        # topleft corner
        stroke_line [bounds.left + spacing, bounds.top - margin], 
                    [bounds.left + margin - spacing, bounds.top - margin]
        stroke_line [bounds.left + margin, bounds.top - spacing], 
                    [bounds.left + margin, bounds.top - margin + spacing]
        # topright corner
        stroke_line [bounds.right - spacing, bounds.top - margin], 
                    [bounds.right - margin + spacing, bounds.top - margin]
        stroke_line [bounds.right - margin, bounds.top - spacing], 
                    [bounds.right - margin, bounds.top - margin + spacing]
   
        # bottomleft corner
        stroke_line [bounds.left + spacing, bounds.bottom + margin], 
                    [bounds.left + margin - spacing, bounds.bottom + margin]
        stroke_line [bounds.left + margin, bounds.bottom + spacing], 
                    [bounds.left + margin, bounds.bottom + margin - spacing]
   
        # bottomright corner
        stroke_line [bounds.right - spacing, bounds.bottom + margin], 
                    [bounds.right - margin + spacing, bounds.bottom + margin]
        stroke_line [bounds.right - margin, bounds.bottom + spacing], 
                    [bounds.right - margin, bounds.bottom + margin - spacing]

        # upper margin
        stroke_line [bounds.left + (bounds.width / 2) - gutter, bounds.top - spacing], 
                    [bounds.left + (bounds.width / 2) - gutter, bounds.top - margin + spacing]
        stroke_line [bounds.left + (bounds.width / 2) + gutter, bounds.top - spacing], 
                    [bounds.left + (bounds.width / 2) + gutter, bounds.top - margin + spacing]

        # lower margin
        stroke_line [bounds.left + (bounds.width / 2) - gutter, bounds.bottom + spacing], 
                    [bounds.left + (bounds.width / 2) - gutter, bounds.bottom + margin - spacing]
        stroke_line [bounds.left + (bounds.width / 2) + gutter, bounds.bottom + spacing], 
                    [bounds.left + (bounds.width / 2) + gutter, bounds.bottom + margin - spacing]

        # left margin
        stroke_line [bounds.left + spacing, (( bounds.height + margin) / 3 ) - gutter], 
                    [bounds.left + margin - spacing, (( bounds.height + margin) / 3 ) - gutter]
        stroke_line [bounds.left + spacing, (( bounds.height + margin) / 3 ) + gutter], 
                    [bounds.left + margin - spacing, (( bounds.height + margin) / 3 ) + gutter]

        stroke_line [bounds.left + spacing, bounds.top - (( bounds.height + margin ) / 3 ) - gutter ], 
                    [bounds.left + margin - spacing, bounds.top -  (( bounds.height + margin ) / 3 ) - gutter ]
        stroke_line [bounds.left + spacing, bounds.top - (( bounds.height + margin ) / 3 ) + gutter ], 
                    [bounds.left + margin - spacing, bounds.top -  (( bounds.height + margin ) / 3 ) + gutter ]

        # right margin
        stroke_line [bounds.right - spacing, (( bounds.height + margin) / 3 ) - gutter], 
                    [bounds.right - margin + spacing, (( bounds.height + margin) / 3 ) - gutter]
        stroke_line [bounds.right - spacing, (( bounds.height + margin) / 3 ) + gutter], 
                    [bounds.right - margin + spacing, (( bounds.height + margin) / 3 ) + gutter]

        stroke_line [bounds.right - spacing, bounds.top - (( bounds.height + margin ) / 3 ) - gutter ], 
                    [bounds.right - margin + spacing, bounds.top -  (( bounds.height + margin ) / 3 ) - gutter ]
        stroke_line [bounds.right - spacing, bounds.top - (( bounds.height + margin ) / 3 ) + gutter ], 
                    [bounds.right - margin + spacing, bounds.top -  (( bounds.height + margin ) / 3 ) + gutter ]

      end
    end
  end



  
end
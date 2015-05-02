prawn_document(:page_layout => :landscape) do |pdf|

  qrcode_content = @vessel.ap2hi_ref
  
  render_qr_code(qrcode_content)


end
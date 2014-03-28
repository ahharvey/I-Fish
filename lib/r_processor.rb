require 'rinruby'

class RProcessor

  def self.village_cpue
    for desa in Desa.all
      R.image_path = Rails.root.join("public", "plots", "cpue_desa_#{desa.id}.png").to_s
#    R.eval <<EOF
      R.eval("vesselsSunk <- c(4, 5, 1)")
      R.eval("png(filename=image_path)")
      R.eval("barplot(vesselsSunk)")
      R.eval("dev.off()")


      

      for l in Landing.all
        a << "#{l.time_in.year}-#{l.time_in.month}-#{l.time_in.day}"
      end

      b=Landing.pluck(:cpue)
      c=["na"]
      b.map! { |x| x == nil ? c : x }.flatten!

      R.assign "date", a
      R.assign "cpue", b

      R.eval("plot(#{a},#{b})")
#    EOF
  end
end
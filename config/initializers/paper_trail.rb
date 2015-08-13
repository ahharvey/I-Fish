# config/initializers/paper_trail.rb
PaperTrail::Rails::Engine.eager_load!
module PaperTrail
class Version < ActiveRecord::Base
  def whodunnit
    return nil 							if self[:whodunnit].blank? 
    return self[:whodunnit] if self[:whodunnit].is_a? Integer
    return self[:whodunnit] if self[:whodunnit] == 'Guest'

    target_klass, target_id = self[:whodunnit].split(':')
    eval(target_klass).find(target_id)
  end

end
end
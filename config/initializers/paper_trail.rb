# config/initializers/paper_trail.rb
PaperTrail::Rails::Engine.eager_load!

PaperTrail.config.track_associations = false


module PaperTrail
  class Version < ActiveRecord::Base
    def whodunnit
      return nil                    if self[:whodunnit].blank?
      return self[:whodunnit].to_i  if Integer( self[:whodunnit] ).is_a? Integer rescue false
      return self[:whodunnit]       if self[:whodunnit] == 'Guest'

      target_klass, target_id = self[:whodunnit].split(':')
      eval(target_klass).find(target_id)
    end

  end
end

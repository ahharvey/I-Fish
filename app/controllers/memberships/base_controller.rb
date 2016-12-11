module Memberships
  class BaseController < ApplicationController
    def current_ability
      @current_ability ||= AbilityMemberships.new(current_admin)
    end
    before_action :user_for_paper_trail
    before_action :set_paper_trail_whodunnit
    def user_for_paper_trail
      #admin_signed_in? ? current_admin.id : 'Guest'  # or whatever

      "#{@currently_signed_in.class.to_s}:#{@currently_signed_in.id}" rescue 'Guest'
    end
  end
end

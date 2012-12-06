class AdminAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= Admin.new # guest user (not logged in)
    if user.admin?
      # Administrators can view and edit anything.
      can :manage, :all
    end

  end
end

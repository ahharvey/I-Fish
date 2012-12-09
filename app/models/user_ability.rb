class UserAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.supervisor?
      # Supervisors can view and edit data owned by staff who share the same office.
      can :manage, Survey, :desa_id => user.desa.id
      can :read, User, :desa_id => user.desa.id
      can :read, Fishery
    end

    if user.staff?
      # Staff can view and edit data they own, and profiles of users who share the same district
      can :manage, Survey, :user_id => user.id
      can :read, User, :desa_id => user.desa.id
    end

    if user.public?
      # Users can view summarised data
      # can :read, Survey
    end
  end
end

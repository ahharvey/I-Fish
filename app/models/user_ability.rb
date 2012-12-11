class UserAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.supervisor?
      # Supervisors can view and edit data owned by staff who share the same office.
      can :manage, Survey, :desa_id => user.desa.id # Can manage own data
      can :read, User, :office_id => user.office.id # To view summarised user data
      can :read, Fishery # To view summarised fishery data
    end

    if user.staff?
      # Staff can view and edit data they own, and profiles of users who share the same district
      can :manage, Survey, :user_id => user.id #Can manage own data
      can :read, User, :desa_id => user.desa.id # To view summarised user data
    end

    if user.public?
      # Users can view summarised data only.
      # The summarised data views will not authorise the resources, noly check to see if the user is public
    end
  end
end
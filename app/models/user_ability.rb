class UserAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.supervisor?
      can :manage, Survey, :user_id => user.id
      # Supervisors can view and edit data owned by staff who share the same office.
      # can :read, :all
    end

    if user.staff?
      can :manage, Survey, :user_id => user.id
      # Staff can view and edit data they own, and profiles of users who share the same district
      # can :read, :all
    end

    if user.public?
      can :read, Survey, :user_id => user.id
      # Staff can view and edit data they own, and profiles of users who share the same district
      # can :read, :all
    end
  end
end

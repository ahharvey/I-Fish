class UserAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.public?
      # Users can view users and fisheries and edit their own profile data.
      can :read, User
      can :manage, User, :id => user.id
      can :read, Fishery
    end
  end
end
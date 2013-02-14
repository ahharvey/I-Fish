class UserAbility
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    @user.roles.each { |role| send(role) }

    if @user.roles.size == 0
      can :read, :all #for guest without roles
    end
  end


end
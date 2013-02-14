class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    @admin = admin || Admin.new # for guest
    @admin.roles.each { |role| send(role.name) }

    if @admin.roles.size == 0
      can :read, :all #for guest without roles
    end
  end

  def public
    
    # Users can view users and fisheries and edit their own profile data.
    can :read, User
    can :manage, Admin, :id => @admin.id
    can :read, Fishery
  end

  def enumerator
    # Staff can view and edit data they own, and profiles of users who share the same district
    can :manage, Logbook, :admin_id => @admin.id #Can manage own data
    can :manage, Survey, :admin_id => @admin.id #Can manage own data
    can :read, Fishery # To view summarised fishery data
    can :read, User
    can :manage, Admin, :id => @admin.id
  end

  def staff
    # Staff can view and edit data they own, and profiles of users who share the same district
    can :manage, Survey, :admin_id => @admin.id #Can manage own data
    can :read, Fishery # To view summarised fishery data
    can :read, User
    can :read, Admin, :id => @admin.id
  end

  def supervisor
    #Supervissors inherit abilities of enuemerators
    enumerator 
    
    #AND

    # Supervisors can view and edit data owned by staff who share the same office.
    can :read, User
    can :manage, User do |user|
      user.desa.district_id == @admin.office.district_id
    end

    can :read, Admin, Admin.includes(:roles).where(:roles => {:name => "staff"}, :office_id => @admin.office_id) do |a|
    end

    can :manage, Survey, Survey.includes(:desa).where(:desas => {:district_id => @admin.office.district_id}) do |survey|
    end

    can :read, Fishery # To view summarised fishery data
  end

  def leader
    
  end

  def administrator
    leader
    can :manage, :all
  end
end

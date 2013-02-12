class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    # Define abilities for the passed in user here. For example:

    admin ||= Admin.new # guest user (not logged in)
    if admin.admin?
      # Administrators can view and edit anything.
      can :manage, :all
    end

    if admin.supervisor?
      # Supervisors can view and edit data owned by staff who share the same office.
      can :read, User
      can :manage, User do |user|
      	user.desa.district_id == admin.office.district_id
      end

      can :read, Admin, Admin.includes(:roles).where(:roles => {:name => "staff"}, :office_id => admin.office_id) do |a|
      end

      can :manage, Survey, Survey.includes(:desa).where(:desas => {:district_id => admin.office.district_id}) do |survey|
      end

      can :read, Fishery # To view summarised fishery data
    end

    if admin.staff?
      # Staff can view and edit data they own, and profiles of users who share the same district
      can :manage, Survey, :admin_id => admin.id #Can manage own data
      can :read, Fishery # To view summarised fishery data
      can :read, User
      can :read, Admin, :id => admin.id
    end

    if admin.enumerator?
      # Staff can view and edit data they own, and profiles of users who share the same district
      can :manage, Logbook, :admin_id => admin.id #Can manage own data
      can :manage, Survey, :admin_id => admin.id #Can manage own data
      can :read, Fishery # To view summarised fishery data
      can :read, User
      can :manage, Admin, :id => admin.id
    end

  end
end

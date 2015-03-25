class Ability
  include CanCan::Ability

  def initialize(user_or_admin)
    
    user_or_admin ||= User.new

    abilities_for_all

    if user_or_admin.class == User
      abilities_for_all_users(user_or_admin)
      user_or_admin.roles.each do |role| 
        send(role.name, user_or_admin)
      end
    elsif user_or_admin.class == Admin
      abilities_for_all_admins(user_or_admin)
      user_or_admin.roles.each do |role| 
        send(role.name, user_or_admin)
      end
    end
    
  end

  def abilities_for_all # Abilities for guests and all users
    can :read, [Fishery, Fish, Gear, Desa, District, Province, Engine, Logbook] # Guests can read public models, including viewing reports
    can :index, :home # home page
    can :reports, :home # report select page
    #can :multipart_import, :home # email import route
  end

  def abilities_for_all_users(user)
    # Users can view all users, and can manage their own profile.
    can :read, User
    can :manage, User, id: user.id
    #can :welcome, User, id: user.id
  end

  def abilities_for_all_admins(admin)
    # Admins can view all users and admins, and can manage their own profile.
    can :read, User
    can :read, Admin
    can :manage, Admin, id: admin.id
    can :read, ExcelFile #can read excel files
  end

  def public(admin)
    can :read, User
    can :manage, Admin, :id => admin.id
    can :read, Fishery
  end

  def enumerator(admin)
    # Staff can view and edit data they own, and profiles of users who share the same district
    can :manage, Logbook, :admin_id => admin.id #Can manage own data
    can :manage, Survey, :admin_id => admin.id #Can manage own data
    can :read, Fishery # To view summarised fishery data
    can :read, Company, id: admin.managed_companies.map(&:id)
    can :read, Vessel, id: admin.managed_vessels.map(&:id)
    can :create, Unloading, id: admin.managed_unloadings.map(&:id)
    can :create, BaitLoading, id: admin.managed_bait_loadings.map(&:id)
    can :upload_data, :home # Can submit data
    can :process_upload_data, :home # Can submit data
    can :manage, ExcelFile, :admin_id => admin.id #Can manage own excel files
  end

  def staff(admin)
    # Staff can view and edit data they own, and profiles of users who share the same district
    can :manage, Survey, :admin_id => admin.id #Can manage own data
    can :manage, Fishery, id: admin.member_fisheries.map(&:id)
    cannot :destroy, Fishery


    can :create, Unloading
    can :manage, Unloading, id: admin.managed_unloadings.map(&:id)
    cannot :destroy, Unloading

    can :create, BaitLoading
    can :manage, BaitLoading, id: admin.managed_bait_loadings.map(&:id)
    cannot :destroy, BaitLoading

    can :create, Vessel
    can :manage, Vessel, id: admin.managed_vessels.map(&:id)
    cannot :destroy, Vessel

    can :create, Company
    can :manage, Company, id: admin.managed_companies.map(&:id)
    cannot :destroy, Company
 
    #can :read, Fishery # To view summarised fishery data
    can :read, User
    can :read, Admin, :id => admin.id
  end

  def supervisor(admin)
    #Supervissors inherit abilities of enuemerators
     
    #AND#
    # Supervisors can view the dashboard

    can :manage, 'supervisor/dashboard'
    can :index, 'supervisor/dashboard'
    
    #AND#
    # Supervisors can view and edit data owned by staff who share the same office.
   
    can :manage, User, desa: { district_id: admin.office.district_id}

    can :read, Admin, Admin.includes(:roles).where(:roles => {:name => "staff"}, :office_id => admin.office_id) do |a|
    end
    can :manage, Survey
    can :manage, Logbook
    can :manage, Landing
    can :manage, Catch
    can :manage, LoggedDay
    can :read, Fishery # To view summarised fishery data
  end

  def leader(admin)
    
  end

  def administrator(admin)
    can :manage, :all
  end
end
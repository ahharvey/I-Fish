class Ability
  include CanCan::Ability

  def initialize(user_or_admin)

    user_or_admin ||= User.new

    abilities_for_all

    unless user_or_admin.new_record?

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

  end

  def abilities_for_all # Abilities for guests and all users
    can [:index, :show], [Fishery, Fish, Gear, Company, Engine, Vessel, Port, Wpp] # Guests can read public models, including viewing reports
    can [:show,:index], :home # home page
    can [
      :current_catch_composition,
      :average_catch_composition,
      :current_monthly_production,
      :average_monthly_production,
      :current_fuel_utilization
      ], Company
    #can :reports, :home # report select page
    #can :multipart_import, :home # email import route
  end

  def abilities_for_all_users(user)
    # Users can view all users, and can manage their own profile.
    can :read, User
    can :manage, User, id: user.id

    cannot :manage, Unloading
    can :create, Unloading
    can :update, Unloading, vessel_id: user.managed_vessels.map(&:id)
    cannot :destroy, Unloading

    cannot :manage, BaitLoading
    #can :create, BaitLoading
    #can :manage, BaitLoading, vessel_id: user.managed_vessels.map(&:id)
    cannot :destroy, BaitLoading

    cannot :manage, UnloadingCatch
    can :create, UnloadingCatch
    #can :manage, BaitLoading, vessel_id: user.managed_vessels.map(&:id)
    cannot :destroy, UnloadingCatch


    can [:update,:report], Company, id: user.companies.map(&:id)
    can :read, SizeClass
    can :create, SizeClass
    cannot :destroy, SizeClass
    #can :welcome, User, id: user.id
  end

  def abilities_for_all_admins(admin)
    # Admins can view all users and admins, and can manage their own profile.
    can :read, [Fishery, Fish, Gear, Company, Engine, Vessel, Office]

    can :index, [
      Charts::ProductionsController,
      Charts::CpuesController,
      Charts::FuelUtilizationsController,
      Charts::CatchCompositionsController,
      Charts::BaitEfficienciesController
    ]
    can [:edit,:update], Vessel
    can :read, User
    can :read, Admin
    can :manage, Admin, id: admin.id
    can :read, ExcelFile #can read excel files
    can :manage, Bait
    cannot :destroy, Bait
    can :manage, SizeClass
    cannot :destroy, SizeClass
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

    can :create, Unloading
    can :manage, Unloading, id: admin.managed_unloadings.map(&:id)
    can :create, BaitLoading, vessel_id: admin.managed_vessels.map(&:id)

    can :create, UnloadingCatch
    can :manage, UnloadingCatch, id: admin.managed_unloading_catches.map(&:id)
    cannot :destroy, UnloadingCatch

    can :create, BaitLoading
    can :manage, BaitLoading, id: admin.managed_bait_loadings.map(&:id)
    cannot :destroy, BaitLoading

    can :create, Audit
    can :create, PendingVessel

    can :upload_data, :home # Can submit data
    can :process_upload_data, :home # Can submit data

    can :manage, ExcelFile, :admin_id => admin.id #Can manage own excel files
  end

  def staff(admin)
    # Staff can view and edit data they own, and profiles of users who share the same district
    can :manage, Survey, :admin_id => admin.id #Can manage own data
    can :manage, Fishery, id: admin.member_fisheries.map(&:id)
    cannot :destroy, Fishery

    can :create, CarrierLoading
    can :manage, CarrierLoading, id: admin.managed_carrier_loadings.map(&:id)
    cannot :destroy, CarrierLoading

    can :create, Port
    cannot :destroy, Port

    can :create, Wpp
    cannot :destroy, Wpp

    can :create, Unloading
    can :manage, Unloading, id: admin.managed_unloadings.map(&:id)
    cannot :destroy, Unloading

    can :create, UnloadingCatch
    can :manage, UnloadingCatch, id: admin.managed_unloading_catches.map(&:id)
    cannot :destroy, UnloadingCatch

    can :create, BaitLoading
    can :manage, BaitLoading, id: admin.managed_bait_loadings.map(&:id)
    cannot :destroy, BaitLoading

    can :create, Vessel
    can :manage, Vessel, id: admin.managed_vessels.map(&:id)
    cannot :destroy, Vessel

    can :create, VesselImport

    can :create, Company
    can :manage, Company, id: admin.managed_companies.map(&:id)
    can :report, Company, id: admin.managed_companies.map(&:id)
    cannot :destroy, Company

    can :manage, Office, id: admin.office_id

    cannot :destroy, Company

    can :create, Audit
    can :manage, Audit, admin_id: admin
    cannot :destroy, Audit

    can :manage, PendingVessel
    cannot :destroy, PendingVessel

    can :manage, Document

    #can :read, Fishery # To view summarised fishery data
    can :read, User
    can :read, Admin, :id => admin.id

    can :manage, 'staff/dashboard'
    can :index, 'staff/dashboard'
    can :import, :home
    can :manage, Importer

    can [:create, :destroy], :memberships_vessels

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

  def developer(admin)
  end
end

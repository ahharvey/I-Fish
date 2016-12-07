class AbilityReview
  include CanCan::Ability
  def initialize(user_or_admin)

    user_or_admin ||= User.new

    default_roles

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

  def default_roles
  end

  def abilities_for_all_users(user)
  end

  def abilities_for_all_admins(admin)
    can [:update], Unloading
    can [:update], BaitLoading
  end

  def public(admin)
  end

  def enumerator(admin)
  end

  def staff(admin)
  end

  def supervisor(admin)
  end

  def leader(admin)
  end

  def administrator(admin)
  end

  def developer(admin)
  end
end

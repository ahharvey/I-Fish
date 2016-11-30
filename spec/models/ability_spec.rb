require 'rails_helper'
require "cancan/matchers"
# ...
RSpec.describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is a Public" do
      let(:user) { create :user }

      it { is_expected.to not_have_abilities([:index, :show, :new, :create, :edit, :update, :destroy], Document) }

      it { is_expected.to have_abilities([:index, :show], Fishery) }
      it { is_expected.to not_have_abilities([:new, :create, :edit, :update, :destroy], Fishery) }

      it { is_expected.to have_abilities([:new, :create], Unloading.new ) }
      it { is_expected.to have_abilities([:edit, :update], Unloading ) }
      it { is_expected.to not_have_abilities([:index, :show, :destroy], Unloading ) }

      it { is_expected.to have_abilities([:new, :create], BaitLoading.new) }
      it { is_expected.to not_have_abilities([:index, :show, :edit, :update, :destroy], BaitLoading.new) }
    end


  end
end

RSpec.describe "Admin" do
  describe "abilities" do
    subject(:ability){ Ability.new(admin) }
    let(:admin){ nil }

    context "when is a Staff" do
      let(:admin) { create :admin }
      before :each do
        admin.roles.push Role.where(name: 'enumerator').first_or_create
      end
      it { is_expected.to have_abilities([:index, :show, :edit, :update], Vessel) }
      it { is_expected.to not_have_abilities([:new, :create, :destroy], Vessel) }

      it { is_expected.to have_abilities([:new, :create], Audit ) }
      it { is_expected.to not_have_abilities([:index, :show, :edit, :update], Audit ) }
    end
    context "when is a Staff" do
      let(:admin) { create :admin }
      before :each do
        admin.roles.push Role.where(name: 'staff').first_or_create
      end

      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update, :destroy], Document) }

      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update], BaitLoading) }
      it { is_expected.to not_have_abilities([:destroy], BaitLoading) }

      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update], UnloadingCatch) }
      it { is_expected.to not_have_abilities([:destroy], UnloadingCatch) }
    end

    context "when is an Administrator" do
      let(:admin) { create :admin }
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
      end

      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update, :destroy], Fishery) }

      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update, :destroy], Unloading) }

      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update, :destroy], Document) }
      it { is_expected.to have_abilities([:index, :show, :new, :create, :edit, :update, :destroy], BaitLoading) }
    end
  end
end

require 'rails_helper'

RSpec.describe "unloadings/show", type: :view, broken: true do

  before(:each) do
    @unloading = assign(:unloading, unloading )
    #@prerep = assign(:prerep, Prerep.new )
    #@prereps = assign(:prereps, [prerep1,prerep2,prerep3])
  #  view.stub(:current_user) { admin }
    #view.any_instance.stub(:current_admin).and_return(admin)
    #controller.stub(:current_user).and_return(admin)
    allow(view).to receive(:current_user).and_return(admin)
  end

  let(:admin)    { create :admin }
  let(:unloading) { create :unloading }
  let(:prerep1) { create :prerep, logbook: logbook }
  let(:prerep2) { create :prerep, logbook: logbook }
  let(:prerep3) { create :prerep, logbook: logbook }


  context 'with superadmin' do
    before :each do
      allow_any_instance_of(Admin).to receive(:admin?).and_return( true )
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      #controller.stub(:current_ability) { @ability }
      allow(controller).to receive(:current_ability).and_return( @ability )
    end
    it 'displays approve and reject btns' do
      @ability.can :update, @unloading
      render
      assert_select "form[action=?][method=?]", review_unloading_path(@unloading), "post" do
        assert_select "input##{@unloading.id}_unloading_review_state_pending[name=?][value=?][type=?]", "unloading[review_state]", "pending", "radio"
        assert_select "input##{@unloading.id}_unloading_review_state_approved[name=?][value=?][type=?]", "unloading[review_state]", "approved", "radio"
        assert_select "input##{@unloading.id}_unloading_review_state_rejected[name=?][value=?][type=?]", "unloading[review_state]", "rejected", "radio"
      end
    end
  end
  context 'with user' do
    it 'displays the panels' do
      expect(view).to   have_selector("div.panel-heading", text: 'Company')
      expect(view).to   have_selector("div.panel-heading", text: 'Operations')
      expect(view).to   have_selector("div.panel-heading", text: 'Inputs')
      expect(view).to   have_selector("div.panel-heading", text: 'ETP')
    end

    it 'displays the catches table' do
      render
      within "table#catch_table.table" do
        expect(rendered).to have_selector "tr.catch-row", count: 3
      end
    end

    it 'displays the change log' do
      render
      within "table#change_log_table.table" do
        expect(rendered).to have_selector "tr.change-log-row", count: 3
      end
    end
  end
end

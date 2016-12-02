require 'rails_helper'

RSpec.describe Charts::FuelUtilizationsController, type: :controller do


  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:company)   { create :company }
  let(:vessel)    { create :vessel, company: company }
  let!(:unloading1){ create :unloading, time_out: Date.today-1.day, time_in: Date.today, vessel: vessel, fuel: 20 }
  let!(:unloading2){ create :unloading, time_out: Date.today-2.years-1.day, time_in: Date.today-2.years, vessel: vessel, fuel: 30 }
  let!(:unloading_catch1) { create :unloading_catch, quantity: 10, unloading: unloading1 }
  let!(:unloading_catch2) { create :unloading_catch, quantity: 100, unloading: unloading2 }


  describe "GET #index" do
    context 'when admin is logged in with period current' do
      before :each do
        sign_in admin
        get :index, company_id: company.id, period: 'current'
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :json }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template }
      it { expect( JSON.parse(response.body) ).to match_array(
          [
            ["Fuel","Catch"],
            [20,10]
          ]
        )
      }
    end
    context 'when admin is logged in with period all' do
      before :each do
        sign_in admin
        get :index, company_id: company.id, period: 'all'
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :json }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template }
      it { expect( JSON.parse(response.body) ).to match_array(
          [
            ["Fuel","Catch"],
            [30,100],
            [20,10]
          ]
        )
      }
    end
    context 'when admin is logged in with no period' do
      before :each do
        sign_in admin
        get :index, company_id: company.id
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :json }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template }
      it { expect( JSON.parse(response.body) ).to match_array(
          [
            ["Fuel","Catch"],
            [30,100],
            [20,10]
          ]
        )
      }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :index, company_id: company.id
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :index, company_id: company.id
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #show" do
  end

  describe "GET #new" do
  end

  describe "GET #edit" do
  end

  describe "POST #create" do
  end

  describe "PUT #update" do
  end

  describe "DELETE #destroy"  do
  end


end

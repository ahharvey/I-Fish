require 'rails_helper'

RSpec.describe Charts::BaitEfficienciesController, type: :controller do


  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:company)   { create :company }
  let(:vessel)    { create :vessel, company: company }
  let!(:unloading1){ create :unloading, time_out: Date.new(Date.today.year, 1, 1), time_in: Date.new(Date.today.year,1,2), vessel: vessel }
  let!(:unloading2){ create :unloading, time_out: Date.new(2014, 2, 1), time_in: Date.new(2014, 2, 2), vessel: vessel }
  let!(:unloading_catch1) { create :unloading_catch, quantity: 100, unloading: unloading1, fish: fish1 }
  let!(:unloading_catch2) { create :unloading_catch, quantity: 100, unloading: unloading2, fish: fish2 }
  let(:fish1)     { create :fish }
  let(:fish2)     { create :fish }
  let!(:bait_loading1) { create :bait_loading, vessel: vessel, quantity: 10, date: Date.new(Date.today.year, 1, 1) }
  let!(:bait_loading2) { create :bait_loading, vessel: vessel, quantity: 10, date: Date.new(2014, 2, 1) }


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
      it { expect( JSON.parse(response.body) ).to eq(
          {
            "Jan" => 10,
            "Feb" => 0,
            "Mar" => 0,
            "Apr" => 0,
            "May" => 0,
            "Jun" => 0,
            "Jul" => 0,
            "Aug" => 0,
            "Sep" => 0,
            "Oct" => 0,
            "Nov" => 0,
            "Dec" => 0
          }
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
      it { expect( JSON.parse(response.body) ).to eq(
          {
            "Jan" => 10,
            "Feb" => 10,
            "Mar" => 0,
            "Apr" => 0,
            "May" => 0,
            "Jun" => 0,
            "Jul" => 0,
            "Aug" => 0,
            "Sep" => 0,
            "Oct" => 0,
            "Nov" => 0,
            "Dec" => 0
          }
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
      it { expect( JSON.parse(response.body) ).to eq(
          {
            "Jan" => 10,
            "Feb" => 10,
            "Mar" => 0,
            "Apr" => 0,
            "May" => 0,
            "Jun" => 0,
            "Jul" => 0,
            "Aug" => 0,
            "Sep" => 0,
            "Oct" => 0,
            "Nov" => 0,
            "Dec" => 0
          }
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

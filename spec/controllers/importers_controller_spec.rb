require 'rails_helper'

RSpec.describe ImportersController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      file:  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'test_sheet.xlsx')),
      label: 'vessels'
    }
  }



  let(:invalid_attributes) {
    {
      file: nil,
      label: nil
    }
  }


  let(:admin)        { create :admin }
  let(:user)        { create :user }


  let(:vessel)       { create :vessel }
  let(:company)      { create :company }


  describe "GET #index" do
    # not routable
  end

  describe "GET #show" do
    # not routable
  end

  describe "GET #new" do
    context 'when admin is logged in and with valid params' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :new, label: 'vessels', company_id: company.id
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:importer)).to be_a_new(Importer) }
      it { expect(assigns(:importer).label).to eq 'vessels' }
      it { expect(assigns(:object)).to eq(company) }
      it { expect(assigns(:label)).to eq('vessels') }
    end
    context 'when admin is logged in and with invalid parent' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :new, label: 'vessels', company_id: 99
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:importer)).to be_a_new(Importer) }
      it { expect(assigns(:importer).label).to eq 'vessels' }
      it { expect(assigns(:object)).to be nil }
      it { expect(assigns(:label)).to eq('vessels') }
    end
    context 'when admin is logged in and with invalid label' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :new, label: 'invalidLabel', company_id: company.id
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:importer)).to be nil }
      it { expect(assigns(:object)).to eq(company) }
      it { expect(assigns(:label)).to be nil }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new, label: 'vessels', company_id: company.id
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :new, label: 'vessels', company_id: company.id
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #edit" do
    # not routable
  end

  describe "POST #create" do
    # we will only test with admin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      sign_in admin
    end
    context "with valid params nested by company" do
      before :each do
        post :create, { importer: valid_attributes, company_id: company.id }
      end
      it {
        expect {
          post :create, { importer: valid_attributes, company_id: company.id }
        }.to change(Importer, :count).by(1)
      }
      it 'does some stuff', :broken do
        ActiveJob::Base.queue_adapter = :test

        expect {
          post :create, { importer: valid_attributes, company_id: company.id }
        }.to have_enqueued_job(UnloadingImporterJob) #.with("users-backup.txt", "products-backup.txt")
      end

      it { expect(assigns(:importer)).to be_a(Importer) }
      it { expect(assigns(:importer)).to be_persisted }
      it { expect(assigns(:importer).parent).to eq company }
      it { expect(assigns(:importer).imported_by).to eq admin }
      it { expect(assigns(:object)).to be_a(Company) }
      it { is_expected.to redirect_to company_path(company) }
      it { expect( flash[:notice] ).to have_content "Records were succesfully imported and are being processed" }
    end
    context "with valid params nested by vessel" do
      before :each do
        post :create, { importer: valid_attributes, vessel_id: vessel.id }
      end
      it { expect(assigns(:importer)).to be_a(Importer) }
      it { expect(assigns(:importer)).to be_persisted }
      it { expect(assigns(:importer).parent).to eq vessel }
      it { expect(assigns(:importer).imported_by).to eq admin }
      it { expect(assigns(:object)).to be_a(Vessel) }
      it { is_expected.to redirect_to vessel_path(vessel) }
      it { expect( flash[:notice] ).to have_content "Records were succesfully imported and are being processed" }
    end
    context "with invalid params" do
      before :each do
        post :create, { importer: invalid_attributes, company_id: company.id}
      end
      it { expect( assigns(:importer) ).to be_a_new(Importer) }
      it { is_expected.to render_template :new }
    end
  end

  describe "PUT #update" do
    # not routable
  end

  describe "DELETE #destroy"  do
    # not routable
  end


end

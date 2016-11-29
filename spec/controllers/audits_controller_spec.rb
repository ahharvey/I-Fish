require 'rails_helper'

RSpec.describe AuditsController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      admin_id: admin.id,
      auditable_id: vessel1.id,
      auditable_type: vessel1.class.name,
      status: 'rejected'
    }
  }

  let(:invalid_attributes) {
    {
      status: nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:vessel1)   { create :vessel }
  let(:vessel2)   { create :vessel }

  let(:audit1)    { create :audit, auditable: vessel1 }
  let(:audit2)    { create :audit }
  let(:audit3)    { create :audit }


  describe "GET #index" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :index, { vessel_id: vessel1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:audits) ).to match_array( [audit1] ) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :index, { vessel_id: vessel1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :index, { vessel_id: vessel1.id }
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #show" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :show, { id: audit1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:audit) ).to eq( audit1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: audit1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: audit1.id }
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #new" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :new, { vessel_id: vessel1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:audit)).to be_a_new(Audit) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new, { vessel_id: vessel1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create audits." }
    end
    context 'when user is logged out' do
      before :each do
        get :new, { vessel_id: vessel1.id }
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #edit" do
  end

  describe "POST #create" do
    # we will only test with admin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
    end
    context "with valid params and approved" do
      before :each do
        post :create, { audit: valid_attributes.merge(status: 'approved'), vessel_id: vessel1.id}
      end
      it {
        expect {
          post :create, { audit: attributes_for(:audit), vessel_id: vessel2.id }
        }.to change(Audit, :count).by(1)
      }
      it { expect(assigns(:audit)).to be_a(Audit) }
      it { expect(assigns(:audit)).to be_persisted }
      it { is_expected.to redirect_to vessel_path(vessel1) }
      it { expect( flash[:notice] ).to have_content "SUCCESS! Audit was successfully created." }
    end
    context "with valid params and rejected" do
      before :each do
        post :create, { audit: valid_attributes, vessel_id: vessel1.id}
      end
      it {
        expect {
          post :create, { audit: attributes_for(:audit).merge(status: 'rejected'), vessel_id: vessel2.id }
        }.to change(Audit, :count).by(1)
      }
      it { expect(assigns(:audit)).to be_a(Audit) }
      it { expect(assigns(:audit)).to be_persisted }
      it { is_expected.to redirect_to edit_vessel_path(vessel1) }
      it { expect( flash[:notice] ).to have_content "SUCCESS! Audit was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, { audit: invalid_attributes, vessel_id: vessel1.id }
      end
      it { expect( assigns(:audit) ).to be_a_new(Audit) }
      it { is_expected.to render_template :new }
    end
  end

  describe "PUT #update" do
    # we will only test with admin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
    end
    context "with valid params" do
      let(:new_attributes) {
        { status: 'approved' }
      }
      before :each do
        put :update, {:id => audit1.to_param, :audit => new_attributes}
      end
      it { expect( assigns(:audit) ).to eq(audit1) }
      it { is_expected.to redirect_to audit1.auditable }
      it { expect( assigns(:audit).status ).to eq "approved" }
      it { expect( flash[:notice] ).to have_content "Audit was successfully updated." }
      it {
        is_expected.to permit(
          :status,
          :comment
        ).
          for(:update, params: { id: audit1.to_param, audit: valid_attributes } ).
          on(:audit)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => audit1.to_param, :audit => invalid_attributes}
      end
      it { expect( assigns(:audit) ).to eq(audit1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:audit) { create :audit }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      #require 'pry'; binding.pry
      delete :destroy, {:id => audit1.to_param}
    end
    it { expect {
        delete :destroy, {:id => audit.to_param}
      }.to change(Audit, :count).by(-1) }
    it { is_expected.to redirect_to(audit1.auditable) }
    it { expect( flash[:notice] ).to have_content "Audit was successfully destroyed." }
  end


end

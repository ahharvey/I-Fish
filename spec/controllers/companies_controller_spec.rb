require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name:   'Company A'
    }
  }

  let(:invalid_attributes) {
    {
      name:   nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:company1)  { create :company }
  let(:company2)  { create :company }
  let(:company3)  { create :company }


  describe "GET #index" do
    context 'when user is logged in' do
      before :each do
        sign_in user

        get :index

      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:companies) ).to match_array( [company1, company2, company3] ) }
    end
    context 'when user is logged out' do
      before :each do
        get :index
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:companies) ).to match_array( [company1, company2, company3] ) }
    end
    context 'when params[:format] == csv' do
      before :each do
        get :index, { format: :csv }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :csv }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template :index }
      it { expect( assigns(:companies) ).to match_array( [company1, company2, company3] ) }
    end
  end

  describe "GET #show" do
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: company1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:company) ).to eq( company1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: company1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:company) ).to eq( company1 ) }
      it { is_expected.to_not set_flash }
    end
  end

  describe "GET #new" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :new
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:company)).to be_a_new(Company) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :new
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create companies." }
    end
    context 'when user is logged out' do
      before :each do
        get :new
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #edit" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :edit, { id: company1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:company)).to eq(company1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :edit, { id: company1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this company." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: company1.id }
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "POST #create" do
    # we will only test with admin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
    end
    context "with valid params" do
      before :each do
        post :create, {:company => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:company => attributes_for(:company) }
        }.to change(Company, :count).by(1)
      end
      it { expect(assigns(:company)).to be_a(Company) }
      it { expect(assigns(:company)).to be_persisted }
      it { is_expected.to redirect_to company_path(Company.last) }
      it { expect( flash[:notice] ).to have_content "Company was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:company => invalid_attributes}
      end
      it { expect( assigns(:company) ).to be_a_new(Company) }
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
        { name: 'New Name' }
      }
      before :each do
        put :update, {:id => company1.to_param, :company => new_attributes}
      end
      it { expect( assigns(:company) ).to eq(company1) }
      it { is_expected.to redirect_to company1 }
      it { expect( assigns(:company).name ).to eq 'New Name' }
      it { expect( flash[:notice] ).to have_content "Your edits were successfully submitted and are pending review." }
      it {
        is_expected.to permit(
          :name,
          :shark_policy,
          :iuu_list,
          :code_of_conduct,
          :member,
          :avatar,
          :crop_x,
          :crop_y,
          :crop_w,
          :crop_h,
          :fishery_id,
          :code,
          :harvest,
          :processing).
          for(:update, params: { id: company1.to_param, company: valid_attributes } ).
          on(:company)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => company1.to_param, :company => invalid_attributes}
      end
      it { expect( assigns(:company) ).to eq(company1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:company) { create :company }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      #require 'pry'; binding.pry
      delete :destroy, {:id => company1.to_param}
    end
    it { expect {
        delete :destroy, {:id => company.to_param}
      }.to change(Company, :count).by(-1) }
    it { is_expected.to redirect_to(companies_path) }
    it { expect( flash[:notice] ).to have_content "Company was successfully destroyed." }
  end


end

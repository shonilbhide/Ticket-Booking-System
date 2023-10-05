require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:valid_admin_attributes) { FactoryBot.attributes_for(:admin) }
  let(:invalid_admin_attributes) { FactoryBot.attributes_for(:admin, email: nil) }

  describe "GET #show" do
    before do
      @admin = FactoryBot.create(:admin)
      session[:admin_id] = @admin.id
    end

    it "returns a success response" do
      get :show, params: { id: @admin.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    before do
      @admin = FactoryBot.create(:admin)
      session[:admin_id] = @admin.id
    end

    it 'returns a success response' do
      admin = FactoryBot.create(:admin)
      get :edit, params: { id: admin.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before do
      @admin = FactoryBot.create(:admin)
      session[:admin_id] = @admin.id
    end

    context 'with valid attributes' do
      it 'creates a new admin' do
        expect {
          post :create, params: { admin: valid_admin_attributes }
        }.to change(Admin, :count).by(1)
      end

      it 'redirects to the created admin' do
        post :create, params: { admin: valid_admin_attributes }
        expect(response).to redirect_to(admin_path(Admin.last))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new admin' do
        expect {
          post :create, params: { admin: invalid_admin_attributes }
        }.not_to change(Admin, :count)
      end

      it 'renders the new template' do
        post :create, params: { admin: invalid_admin_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    let(:admin) { FactoryBot.create(:admin) }
    let(:new_attributes) { FactoryBot.attributes_for(:admin, name: "New Name") }
    before do
      session[:admin_id] = admin.id
    end

    context 'with valid attributes' do
      it 'updates the admin' do
        put :update, params: { id: admin.id, admin: new_attributes }
        admin.reload
        expect(admin.name).to eq("New Name")
      end

      it 'redirects to the admin' do
        put :update, params: { id: admin.id, admin: new_attributes }
        expect(response).to redirect_to(admin_path(admin))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the admin' do
        put :update, params: { id: admin.id, admin: invalid_admin_attributes }
        expect(admin.name).not_to eq(nil)
      end

      it 'renders the edit template' do
        put :update, params: { id: admin.id, admin: invalid_admin_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:admin) { FactoryBot.create(:admin) }

    before do
      session[:admin_id] = admin.id
    end

    it 'destroys the admin' do
      expect {
        delete :destroy, params: { id: admin.id }
      }.to change(Admin, :count).by(-1)
    end

    it 'redirects to the admins list' do
      delete :destroy, params: { id: admin.id }
      expect(response).to redirect_to(root_url)
    end
  end
end

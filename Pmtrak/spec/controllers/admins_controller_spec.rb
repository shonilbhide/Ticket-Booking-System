require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:valid_admin_attributes) { FactoryBot.attributes_for(:admin) }
  let(:invalid_admin_attributes) { FactoryBot.attributes_for(:admin, email: nil) }



  describe 'GET #show' do
    it 'returns a success response' do
        admin = FactoryBot.create(:admin)
        get :show, params: { id: admin.id }
        expect(response).to be_successful # Change this line if the action should return a different status code.
      end
    end

#   describe 'GET #new' do
#     it 'returns a success response' do
#     @current_user = FactoryBot.build(:admin)
#       get :new
#       expect(response).to be_successful
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid attributes' do
#       it 'creates a new admin' do
#         @current_user = FactoryBot.build(:admin)
#         expect {
#           post :create, params: { admin: valid_admin_attributes }
#         }.to change(Admin, :count).by(1)
#       end

#       it 'redirects to the created admin' do
#         @current_user = FactoryBot.build(:admin)
#         post :create, params: { admin: valid_admin_attributes }
#         expect(response).to redirect_to(admin_path(Admin.last))
#       end
#     end

#     context 'with invalid attributes' do
#       it 'does not create a new admin' do
#         @current_user = FactoryBot.build(:admin)
#         expect {
#           post :create, params: { admin: invalid_admin_attributes }
#         }.not_to change(Admin, :count)
#       end

#       it 'renders the new template' do
#         @current_user = FactoryBot.build(:admin)
#         post :create, params: { admin: invalid_admin_attributes }
#         expect(response).to render_template('new')
#       end
#     end
#   end

#   describe 'GET #edit' do
#     it 'returns a success response' do
#         @current_user = FactoryBot.build(:admin)
#       admin = FactoryBot.create(:admin)
#       get :edit, params: { id: admin.id }
#       expect(response).to be_successful
#     end
#   end

  # Add more test cases for 'update', 'destroy', and custom actions like 'show_trains', 'show_passengers', etc.
end
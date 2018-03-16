require 'rails_helper'

RSpec.describe Version1::AuthController, type: :api do
  describe 'login' do
    before :each do
      @user = create(:user, email: 'user@example.com')
    end

    it 'sends invalid credentials' do
      post('/version1/auth/login', email: 'email@email.com', password: 'asdgahsdgajhdgahd')

      expect(json).to have_key(:error)
    end

    it 'sends valid credentials' do
      post('/version1/auth/login', email: @user.email, password: '123456789')

      token = JsonWebToken.encode(user_id: @user.id)
      expect(json[:access_token]).to eq(token)
    end

    it 'sends valid token' do
      token = JsonWebToken.encode(user_id: @user.id)

      header('Authorization', token)
      get('/version1/auth')

      expect(json[:profile][:email]).to eq(@user.email)
      expect(json[:profile]).to match_response_schema('profile')
    end

    it 'sends invalid token' do
      header('Authorization', 'token')
      response = get('/version1/auth')

      expect(response.status).to eq(401)
    end
  end

  describe 'registration' do
    it 'was success' do
      post('/version1/auth/registration', email: 'user1@user.net', password: '123456789')

      expect(json[:message]).to eq(I18n.t('auth.success.registration'))
    end

    it 'was not success without password' do
      response = post('/version1/auth/registration', email: 'user1@user.net', password: '')

      expect(response.status).to eq(400)
    end
  end
end

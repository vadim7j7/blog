require 'rails_helper'

RSpec.describe Version1::PostsController, type: :api do
  before :each do
    @user = create(:user, profile: create(:profile))
  end

  def token
    JsonWebToken.encode(user_id: @user.id)
  end

  it 'has profile fields' do
    header('Authorization', token)
    response = get('/version1/profile')

    expect(response.status).to eq(200)
    expect(json[:profile]).to match_response_schema('profile')
  end

  it 'was updated successfully' do
    header('Authorization', token)
    response = put('/version1/profile', first_name: 'John', last_name: 'Die')

    expect(response.status).to eq(200)
    expect(json[:profile]).to match_response_schema('profile')
    expect(json[:profile][:firstName]).to eq('John')
    expect(json[:profile][:lastName]).to eq('Die')
  end

  it 'was not updated because the token is invalid' do
    header('Authorization', 'Invalid token')
    response = put('/version1/profile', first_name: 'John', last_name: 'Die')

    expect(response.status).to eq(401)
  end
end

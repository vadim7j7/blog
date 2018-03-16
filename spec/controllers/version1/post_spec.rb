require 'rails_helper'

RSpec.describe Version1::PostsController, type: :api do
  before :each do
    @user = create(:user)
  end

  def token
    JsonWebToken.encode(user_id: @user.id)
  end

  describe 'create' do
    it 'was success' do
      header('Authorization', token)
      response = post('/version1/posts', title: 'A Title', body: 'Some Text!!!!!!')

      expect(response.status).to eq(200)
      expect(json[:post]).to match_response_schema('post')
    end

    it 'was not success, it does not have title' do
      header('Authorization', token)
      response = post('/version1/posts', body: 'Some Text!!!!!!')

      expect(response.status).to eq(400)
    end
  end

  describe 'update' do
    it 'was updated successfully' do
      post = create(:post, user: @user)

      header('Authorization', token)
      response = put("/version1/posts/#{post.id}", title: 'New Title')

      expect(response.status).to eq(200)
      expect(json[:post]).to match_response_schema('post')
      expect(json[:post][:slug]).to eq(StringUtils.str_to_slug(json[:post][:title]))
    end

    it 'was not updated because the user does not have access' do
      post = create(:post, user: create(:user))

      header('Authorization', token)
      response = put("/version1/posts/#{post.id}", title: 'New Title')

      expect(response.status).to eq(403)
    end
  end

  describe 'destroy' do
    it 'was removed successfully' do
      post = create(:post, user: @user)

      header('Authorization', token)
      response = delete("/version1/posts/#{post.id}")

      expect(response.status).to eq(204)
    end

    it 'was not removed successfully because the user does not have access' do
      post = create(:post, user: create(:user))

      header('Authorization', token)
      response = delete("/version1/posts/#{post.id}")

      expect(response.status).to eq(403)
    end
  end

  it '#list' do
    create(:post, user: @user)
    create(:post, user: @user)

    response = get('/version1/posts')

    expect(response.status).to eq(200)
  end

  it '#show' do
    post = create(:post, user: @user)

    response = get("/version1/posts/#{post.id}")

    expect(response.status).to eq(200)
    expect(json[:post]).to match_response_schema('post')
  end
end

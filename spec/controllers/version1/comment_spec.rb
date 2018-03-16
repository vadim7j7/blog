require 'rails_helper'

RSpec.describe Version1::CommentsController, type: :api do
  before :each do
    @user  = create(:user)
    @user2 = create(:user)
    @post  = create(:post, user: @user2)
  end

  def token
    JsonWebToken.encode(user_id: @user.id)
  end

  def token2
    JsonWebToken.encode(user_id: @user2.id)
  end

  describe 'create' do
    it 'was success' do
      header('Authorization', token)
      response = post('/version1/comments', message: 'Hello', post_id: @post.id)

      expect(response.status).to eq(200)
      expect(json[:comment]).to match_response_schema('comment')
    end

    it 'was not success, it does not have message' do
      header('Authorization', token)
      response = post('/version1/comments', post_id: @post.id)
      expect(response.status).to eq(422)
    end

    it 'was not success, it does not have post Id' do
      header('Authorization', token)
      response = post('/version1/comments', message: 'Hello')
      expect(response.status).to eq(404)
    end

    context 'children comment' do
      it 'with success' do
        comment = create(:comment, user: @user2, post: @post)

        header('Authorization', token)
        response = post('/version1/comments', message: 'Hello', post_id: @post.id, parent_id: comment.id)

        expect(response.status).to eq(200)
        expect(json[:comment]).to match_response_schema('comment')
      end

      it 'without success, because parent Id is invalid' do
        header('Authorization', token)
        response = post('/version1/comments', message: 'Hello', post_id: @post.id, parent_id: 999)

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'update' do
    before :each do
      @comment = create(:comment, user: @user, post: @post)
    end

    it 'was success' do
      header('Authorization', token)

      message = 'Hello!!!'
      response = put("/version1/comments/#{@comment.id}", message: message)

      expect(response.status).to eq(200)
      expect(json[:comment]).to match_response_schema('comment')
      expect(json[:comment][:message]).to eq(message)
    end

    it 'was not updated because comment Id is not invalid' do
      header('Authorization', token)
      response = put('/version1/comments/89988', message: 'Hey!!!')
      expect(response.status).to eq(404)
    end

    it 'was not updated because the user does not have access' do
      header('Authorization', token2)
      response = put("/version1/comments/#{@comment.id}", message: 'Hey!!!')
      expect(response.status).to eq(403)
    end
  end

  describe 'destroy' do
    before :each do
      @comment = create(:comment, user: @user, post: @post)
    end

    it 'was success' do
      header('Authorization', token)
      response = delete("/version1/comments/#{@comment.id}")
      expect(response.status).to eq(204)
    end

    it 'was not destroy because comment Id is not invalid' do
      header('Authorization', token)
      response = delete('/version1/comments/89988')
      expect(response.status).to eq(404)
    end

    it 'was not destroy because the user does not have access' do
      header('Authorization', token2)
      response = delete("/version1/comments/#{@comment.id}")
      expect(response.status).to eq(403)
    end
  end
end

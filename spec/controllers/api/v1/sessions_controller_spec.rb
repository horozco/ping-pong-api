# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  it { expect(v1_sessions_path).to eq('/v1/sessions') }
  it {
    expect(post: v1_sessions_url).to route_to(controller: 'api/v1/sessions',
                                              action:     'create',
                                              format:     :json)
  }
  it {
    expect(delete: v1_sessions_url).to route_to(controller: 'api/v1/sessions',
                                               action:     'destroy',
                                               format:     :json)
  }

  describe 'POST #create' do
    before(:each) do
      @player = FactoryGirl.create :player
    end

    context 'when the credentials are correct' do
      before(:each) do
        request_parameters = {
          session: {
            email:    @player.email,
            password: @player.password
          }
        }
        post :create, params: request_parameters
        @player.reload
      end

      it { expect(json['id']).to eql @player.id }
      it { expect(json['auth_token']).to eql @player.auth_token }
      it { expect(json['name']).to eql @player.name }

      it { expect(response).to have_http_status(200) }
    end

    context 'when the credentials are incorrect' do
      before(:each) do
        request_parameters = {
          session: {
            email:    @player.email,
            password: 'invalidpassword'
          }
        }
        post :create, params: request_parameters
        @player.reload
      end

      it { expect(errors).not_to be_nil }
      it { expect(errors['title']).to match('Wrong credentials') }
      it { expect(errors['detail']).to match('Wrong email or password') }

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'DELETE #destroy' do
    let(:player) { FactoryGirl.create :player }
    before(:each) do
      sign_in player
      request.headers['Authorization'] = player.auth_token
      delete :destroy, params: { id: player.auth_token }
    end

    it { should respond_with 200 }
  end
end

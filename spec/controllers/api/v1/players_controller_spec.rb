# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PlayersController, type: :controller do
  it { expect(v1_players_path).to eq('/v1/players') }
  it { expect(v1_player_path(1)).to eq('/v1/players/1') }
  it {
    expect(post: v1_players_url).to route_to(controller: 'api/v1/players',
                                             action:     'create',
                                             format:     :json)
  }
  it {
    expect(put: v1_player_url(1)).to route_to(controller: 'api/v1/players',
                                              action:     'update',
                                              id: '1',
                                              format:     :json)
  }
  it {
    expect(get: v1_player_url(1)).to route_to(controller: 'api/v1/players',
                                              action:     'show',
                                              id: '1',
                                              format:     :json)
  }

  describe 'authentication is required to' do
    [
      { method: 'put',     action: 'update',   params: { format: :json, params: { id: 0 } } },
      { method: 'get',     action: 'index',    params: { format: :json } },
      { method: 'get',     action: 'show',     params: { format: :json, params: { id: 0 } } }
    ].each do |request|
      context "#{request[:method].upcase} ##{request[:action]}" do
        before do
          send(request[:method].to_sym, request[:action].to_sym, request[:params])
        end

        it { should                       respond_with(401) }
        it { expect(response).to          have_http_status(401) }
        it { expect(errors).not_to        be_nil }
        it { expect(errors['title']).to   match('Not authorized') }
        it { expect(errors['detail']).to  match('Not authorized') }
      end
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        player: {
          name: FactoryGirl.attributes_for(:player)[:name],
          email: FactoryGirl.attributes_for(:player)[:email],
          password: FactoryGirl.attributes_for(:player)[:password],
          password_confirmation: FactoryGirl.attributes_for(:player)[:password_confirmation]
        }
      }
    end

    context 'with valid attributes' do
      before(:each) do
        post :create, format: :json, params: params
      end

      it { should respond_with 200 }
      it { expect(response).to have_http_status(200) }
      it { expect(json['id']).to be_present }
      it { expect(json['auth_token']).to be_present }
      it { expect(json['name']).to eq(params[:player][:name]) }
    end

    %w[name email password].each do |field_name|
      context "without #{field_name}" do
        before(:each) do
          params[:player][field_name.to_sym] = ''
          post :create, format: :json, params: params
        end

        it { should respond_with 422 }
        it { expect(response).to have_http_status(422) }
        it { expect(JSON.parse(errors['detail'])[field_name]).not_to be_nil }
        it { expect(JSON.parse(errors['detail'])[field_name].first).to match('can\'t be blank') }
      end
    end
  end

  describe 'PUT #update' do
    let(:player) { FactoryGirl.create(:player) }
    let(:params) do
      {
        id: player.id,
        player: {
          name: 'New name'
        }
      }
    end

    before { request.headers['Authorization'] = player.auth_token }

    context 'with valid attributes' do
      before(:each) do
        put :update, format: :json, params: params
      end

      it { should respond_with 200 }
      it { expect(response).to have_http_status(200) }
      it { expect(json['id']).to be_present }
      it { expect(json['auth_token']).to be_present }
      it { expect(json['name']).to match('New name') }
    end

    %w[name email password].each do |field_name|
      context "without #{field_name}" do
        before(:each) do
          params[:player][field_name.to_sym] = ''
          put :update, format: :json, params: params
        end

        it { should respond_with 422 }
        it { expect(response).to have_http_status(422) }
        it { expect(JSON.parse(errors['detail'])[field_name]).not_to be_nil }
        it { expect(JSON.parse(errors['detail'])[field_name].first).to match('can\'t be blank') }
      end
    end
  end

  describe 'GET #show' do
    let(:player) { FactoryGirl.create(:player) }
    let(:params) do
      {
        id: player.id
      }
    end

    before { request.headers['Authorization'] = player.auth_token }

    context 'with valid attributes' do
      before(:each) do
        get :show, format: :json, params: params
      end

      it { should respond_with 200 }
      it { expect(response).to have_http_status(200) }
      it { expect(json['id']).to be_present }
      it { expect(json['auth_token']).to be_present }
      it { expect(json['name']).to be_present }
      it { expect(json['email']).to be_present }
    end
  end

  describe 'GET #index' do
    let(:players) { FactoryGirl.create_list(:player, 4) }
    let(:params) do
      {}
    end

    before { request.headers['Authorization'] = players.first.auth_token }

    context 'with valid attributes' do
      before(:each) do
        get :index, format: :json, params: params
      end

      it { should respond_with 200 }
      it { expect(response).to have_http_status(200) }
      it { expect(json.count).to eq(players.count) }
    end
  end
end

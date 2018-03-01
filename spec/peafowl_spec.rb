require 'spec_helper'

describe "Peafowl" do
  def build_peafowl(&block)
    peafowl = Class.new.send(:include, Peafowl)
    peafowl.define_singleton_method(:name) { 'ServiceObject' }
    peafowl.class_eval(&block) if block
    peafowl
  end

  let(:peafowl_1) do
    build_peafowl do
      attribute :username, String
      attribute :password, String

      validates :username, presence: true
      validates :password, presence: true

      def call
        sample_username = 'misugi'.freeze
        sample_password = 'captain_tsubasa'.freeze

        add_error!('Username or Password is not valid!') unless username == sample_username || password == sample_password

        context[:current_user] = { username: sample_username }
      end
    end
  end

  let(:peafowl_2) do
    build_peafowl do
      before do
        context[:before] = true
      end

      def call
      end

      after do
        context[:after] = true
      end
    end
  end

  context 'peafowl_1' do
    it 'validation for username' do
      expect(peafowl_1.call(password: 'captain_tsubasa').failure?).to be true
    end

    it 'validation for password' do
      expect(peafowl_1.call(username: 'misugi').failure?).to be true
    end

    it 'result contain current_user' do
      username = 'misugi'
      password = 'captain_tsubasa'
      result = peafowl_1.call(username: username, password: password)

      expect(result.current_user).not_to be_empty
      expect(result.current_user[:username]).to eq(username)
    end
  end

  context 'peafowl_2' do
    it 'before callback' do
      expect(peafowl_2.call.before).to be true
    end

    it 'after callback' do
      expect(peafowl_2.call.after).to be true
    end
  end
end

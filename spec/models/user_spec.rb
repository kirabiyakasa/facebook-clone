require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do

    it 'ensures name presence' do
      user = User.new(email: 'email@example.com', password: "abc123").save
      expect(user).to eql(false)
    end

    it 'ensures email presence' do
      user = User.new(name: 'name', password: "abc123").save
      expect(user).to eql(false)
    end

    it 'ensures password presence' do
      user = User.new(name: 'name', email: 'email@example.com').save
      expect(user).to eql(false)
    end

    it 'ensures name uniqueness' do
      user1 = User.new(name: 'name', email: 'email@example.com',
                       password: "abc123").save
      user2 = User.new(name: 'name', email: 'email2@example.com',
                       password: "abc123").save
      expect(user2).to eql(false)
    end

    it 'ensures email uniqueness' do
      user1 = User.new(name: 'name', email: 'email@example.com',
                       password: "abc123").save
      user2 = User.new(name: 'name2', email: 'email@example.com',
                       password: "abc123").save
      expect(user2).to eql(false)
    end

    it 'should save successfully' do
      user = User.new(name: 'name', email: 'email@example.com',
                      password: "abc123").save
      expect(user).to eql(true)
    end
  end

  context 'scope tests' do
    let (:params) { {password: "abc123"} }
    before(:each) do
      5.times do |i|
        name = "name#{i}"
        email = "email#{i}@example.com"
        User.new(params.merge(name: name, email: email)).save
      end
    end

    it '' do
    end

  end
end

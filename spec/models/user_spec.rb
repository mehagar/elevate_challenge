require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates required fields' do
    u = User.new(email: nil, username: nil, fullname: nil, password: nil)

    expect(u).to_not be_valid
  end

  it 'authenticates with valid password' do
    u = User.create(email: 'test@email.com', username: 'test_user', fullname: 'test_name', password: 'test_password')
    u.save!
    u = User.find(u.id)

    expect(u.authenticate('invalid_pass')).to eq(false)
    authenticated_user = u.authenticate('test_password')
    expect(authenticated_user.email).to eq('test@email.com')
  end
end

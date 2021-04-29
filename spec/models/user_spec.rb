require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates required fields' do
    u = User.new(email: nil, username: nil, fullname: nil, password: nil)

    expect(u).to_not be_valid
  end
end

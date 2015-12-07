require 'rails_helper'


describe User do
  it "default tier to free" do
    user = create(:user)
    expect(user.tier).to eq("free")
  end

end


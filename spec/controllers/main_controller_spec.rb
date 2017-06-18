require 'rails_helper'
describe "logout" do
  it "logout" do
    set_rack_session(:user_id => 1 )
    visit "/drive"
    find("a[href=/logout]").click
    expect(current_path).to eql "/"
  end
end
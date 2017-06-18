require 'rails_helper'
describe "the signin process", type: :feature do
  it "signs me in" do
    visit "/"
    within("form") do
      fill_in 'user[login]', with: 'test'
      fill_in 'user[password]', with: 'password'
    end
    click_button 'Zaloguj'
    expect(current_path).to eql("/drive")
  end

  it "doesn't sign me in" do
    visit "/"
    within("form") do
      fill_in 'user[login]', with: 'login'
      fill_in 'user[password]', with: 'password'
    end
    click_button 'Zaloguj'
    expect(current_path).to eql("/")
  end

end
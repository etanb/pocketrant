require 'spec_helper'
require 'pry'
# include Rails.application.routes.url_helpers

describe "Login system" do

  let(:new_user) { FactoryGirl.build(:user) }
  let(:existing_user) { FactoryGirl.create(:user) }


  it "allows users to sign up" do 
    visit root_path
    signup(new_user)
    expect(page).to have_content new_user.email
  end

  it "allows users to sign in" do
    visit root_path 
    signin(existing_user)
    expect(page).to have_content existing_user.email
  end
  
  it "allows users to sign out" do
    visit root_path
    signout(existing_user)
    expect(page).to have_content "sign in"
  end


  def signup(user)
    click_link "Sign up"
    within("#new_user") do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
    end
    click_button "Sign up"
  end

  def signin(user)
    click_link "sign in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
    click_button "Sign in"
  end

  def signout(user)
    signin(user)
    click_link "Sign out"
  end

end
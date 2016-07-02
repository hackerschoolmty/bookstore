module LoginMacro

  def feature_sign_in user
    visit root_path
    click_link "Sign in"
    fill_in "user_email", with: user.email
    fill_in "user_password", with:"password"
    click_button "Guardar"
    sleep(1)
  end
end
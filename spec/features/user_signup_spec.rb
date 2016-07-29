feature 'create user account' do
  scenario 'I can sign up as a new user' do
    sign_up
    expect{ click_button 'signup' }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, example')
    expect(User.first.email).to eq('example@gmail.com')
  end

  scenario 'no new user is created with mismatching passwords' do
    sign_up(password_confirmation: "1234")
    expect { click_button 'signup' }.not_to change(User, :count)
    expect(current_path).to eq('/newuser')
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario 'I can not sign up without entering an email' do
    sign_up(email: "")
    expect { click_button 'signup' }.not_to change(User, :count)
    expect(current_path).to eq('/newuser')
    expect(page).to have_content("Email must not be blank")
  end

  scenario 'I can not sign up using an invalid email format' do
    sign_up(email: "example@gmail")
    expect { click_button 'signup' }.not_to change(User, :count)
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'I can not sign up using a duplicate email address' do
     sign_up
     click_button 'signup'
     sign_up
     expect { click_button 'signup' }.not_to change(User, :count)
     expect(page).to have_content("Email is already taken")
  end
end

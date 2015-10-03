module RegistrationHelper
  def fill_in_name
    fill_in 'First name', with: 'Johnny'
    fill_in 'Last name', with: 'Jones'
    fill_in 'Phone number', with: '6178945641'
    page.find('#registration_dob').set("06/19/1992")
    select 'Male', from: 'Gender'
  end

  def fill_in_address
    fill_in 'Zip code', with: '02460'
    fill_in 'Address', with: '1 Congress St'
    fill_in 'City', with: 'Boston'
    select 'Massachusetts', from: 'State'
  end
end

require 'calabash-android/calabash_steps'

Given(/^I wait until the ad is finished$/) do
  sleep(30)
end

When(/^I search for "([^"]*)"$/) do |arg|
  @app.main_screen.search(arg)
end

Then(/^I should see some recipes$/) do
  sleep(5)
  @app.main_screen.results.await
end

And(/^I go back to previous screen$/) do
  press_back_button
  sleep 1
end
def increment_show_index
  defined?(@show_index) ? @show_index += 1 : @show_index = 1
end

def open_show_from_menu(text)
  @app.home_screen.menu.open
  sleep 1
  @app.home_screen.menu.open_show(text)

  @app.home_screen.sleep(3) # wait to close navigation drawer, etc.
  text
end

Given(/^I am on the Home screen$/) do
  @app.home_screen.await
end

Given(/^I collect all available shows$/) do
  @app.home_screen.menu.open
  @shows = @app.home_screen.menu.collect_all_shows
  @app.home_screen.menu.close
end

When(/^I open the first show$/) do
  @show_index = 0
  @app.home_screen.open_show_from_menu(@shows[0])
end

When(/^I open the first show from the menu$/) do
  @show_title = open_show_from_menu(0)
end

When(/^I open the next show$/) do
  increment_show_index
  @app.home_screen.open_show_from_menu(@shows[@show_index])
end

And(/^I open the next show from the menu$/) do
  increment_show_index

  @show_title = open_show_from_menu(@show_index)
end
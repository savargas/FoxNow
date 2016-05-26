Then(/^I should see the Show screen$/) do
  @app.show_screen.await
  fail("#{@app.show_screen.show_title} but expected: #{@shows[@show_index]}") unless @app.show_screen.show_title == @shows[@show_index]
end


$LOAD_PATH.unshift *Dir.glob(File.expand_path('features'))
require 'testmunk/calabash/android/screens/screen'

class HomeScreen < Testmunk::Android::Screen

  class Menu < Testmunk::Android::View

    def initialize(driver)
      super driver, {marked: 'navigation_drawer_list'}
    end

    def open
      view({marked: 'Open navigation drawer'}).touch
      await
    end

    def close
      perform_action('swipe', 'right')
      sleep 2
    end

    def open_show(text)
      find_show("* {text LIKE '#{text}'}")
      view("* id:'text1' {text LIKE '#{text}'}").touch
    end

    def find_show(m_query)
      query_result = query(m_query)
      current_screen_state = query('*')
      prev_screen_state = []
      while (query_result.empty? and (current_screen_state != prev_screen_state))
        prev_screen_state = current_screen_state
        step 'I scroll down'
        current_screen_state = query('*')
        query_result = query(m_query)
      end
      query(m_query)
    end

    def collect_all_shows
      current_screen_state = query('*')
      prev_screen_state = []
      @list = []
      while (current_screen_state != prev_screen_state)
        prev_screen_state = current_screen_state
        @list = @list + get_current_shows
        scroll_down
        current_screen_state = query('*')
      end
      5.times{scroll_up}
      @list.uniq!
      @list.map{|el| el.gsub("'","*")}
    end

    def get_current_shows
      query("* id:'text1'").map{|el| el["text"]}
    end
  end

  class Show < Testmunk::Android::View
    def initialize(driver, i)
      super driver, i == 0 ? "* marked:'home_panel_item_layout' index:0" : "* marked:'home_panel_item_layout'"
      @index = i
    end

    def title
      descendant({marked: 'show_name'}).parameters['text']
    end

    def image
      descendant({marked: 'key_art_image'})
    end

    def scroll_to
      scroll_to_row("* marked:'recycler'", @index == 0 ? 0 : @index + 1)
    end

    def touch
      image.touch
    end
  end


  def traits
    view({marked: 'recycler'})
  end

  def open_show(i)
    await

    show(i).scroll_to
    title = show(i).title
    show(i).touch

    title
  end

  def show(i)
    Show.new(@driver, i)
  end

  def menu
    Menu.new(@driver)
  end

end

class ShowScreen < Testmunk::Android::Screen
  view :title_image, {marked: 'show_title_image'}

  def traits
    title_image
  end

  def await
    super

    sleep 2
  end

  def show_title
    title_image.parameters['contentDescription'].gsub("'","*")
  end
end
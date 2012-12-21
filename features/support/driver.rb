require 'wedding_jukebox/core'

World(WeddingJukebox::TestDataBuilder)

module WeddingJukebox
  module Players
    def catalogue
      @catalogue ||= FakeCatalogue.new #WeddingJukebox.catalogue
    end

    def jukebox
      @jukebox ||= Jukebox.new(catalogue, ui)
    end

    def ui
      @ui ||= WebUIDriver.new(self)
    end

    class WebUIDriver < SimpleDelegator
      def search(term)
        visit '/'
        fill_in "Search for your favourite song", with: term
        click_button "Go"
      end
    end
  end
end
World(WeddingJukebox::Players)

require 'capybara/cucumber'

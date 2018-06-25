require './config/environment'

def reload!
  load_all './lib'
end

#https://medium.com/@rudyyazdi/rake-gem-explained-ebee7e6e6f72 read this to understand rake
task :console do
  Pry.start
end


task :scrape_rooms do
  #instantiate scraper and find new rooms
  chicago_scraper = RoomScraper.new('https://chicago.craigslist.org/search/roo')
  chicago_scraper.call #.call is another way to say "run" or "execute"
  nyc_scraper = RoomScraper.new('https://newyork.craigslist.org/search/roo')
  nyc_scraper.call
  # after this method call, I should be able to say Room.all and have rooms there
end

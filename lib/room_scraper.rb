class RoomScraper

  def initialize(index_url)
    @index_url = index_url # need this if i want to use index_url elsewhere
    @doc = Nokogiri::HTML(open(index_url))
  end



  def call
    rows.each do |row_data|
      Room.create_from_hash(scrape_row(row_data)) #=> should put room in my database
      #binding.pry
    end
  end

  private
    def rows
      @rows ||= @doc.search("div.content ul.rows p.result-info")
    end

    def scrape_row(row)
      # scrape an individual row
      {
        :date_created => row.search("datetime"),
        :title => row.search("a.hdrlnk").text,
        :url => "#{@index_url}#{row.search("a.hdrlnk").attribute("href").text}",
        :price => row.search("span.result-price").text,
      }
      #binding.pry
    end

end

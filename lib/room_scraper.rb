class RoomScraper

  @@row = []

  def initialize(index_url)
    @index_url = index_url
    @doc = Nokogiri::HTML(open(index_url))
  end



  def call
    rows.each do |row_doc|
      data = scrape_row(row_doc)
      binding.pry
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
        :title => row.search("a.hdrlink").text,
        :url => "#{@index_url}#{row.search("a.hdrlink").attribute("href")}",
        :price => row.search("span.result-price").text,
      }
    end

end

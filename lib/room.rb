class Room
  attr_accessor :id, :title, :date_created, :price, :url

  def self.create_from_hash(hash)
    new_from_hash(hash).save
  end

  def self.new_from_hash(hash)
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]
    #binding.pry
    room
  end

  def self.by_price(order = "ASC")
    sql = <<-SQL
      SELECT * FROM rooms ORDER BY #{order}
      SQL

      rows = DB[:connection].execute(sql)
      self.new_from_rows(rows)
  end

  #Room.by_price("ASC") #=> lowest price room first
  #Room.by_price("DESC") #=> highest price room first
  def self.new_from_db(row)
    self.new.tap do |room|
      room.id = row[0]
      room.title = row[1]
      room.date_created = row[2]
      room.price = row[3]
      room.url = row[4]
    end
  end

  def save
    insert
  end

  def self.all #creates objects for each room and instances for each its attributes
    sql = <<-SQL
      SELECT * FROM rooms;
    SQL

    rows = DB[:connection].execute(sql)
    # go from a row [1, "title", date, price, url] to an instance #<Room>
    self.new_from_rows(rows)
  end


  def insert
    puts "YOU ARE ABOUT TO SAVE #{self}"
    sql = <<-SQL
      INSERT INTO rooms (title, date_created, price, url) VALUES (?, ?, ?, ?)
    SQL

    DB[:connection].execute(sql, self.title, self.date_created, self.price, self.url)
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS rooms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date_created DATETIME,
        price TEXT,
        url TEXT
      )
    SQL

    DB[:connection].execute(sql)
  end

end

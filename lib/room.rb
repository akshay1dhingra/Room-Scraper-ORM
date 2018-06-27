class Room
  attr_accessor :title, :date_created, :price, :url

  def self.create_from_hash(hash)
    new_from_hash(hash).save
  end

  def self.new_from_hash(hash)
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]
    binding.pry
    room
  end

  def save
    puts "YOU ARE ABOUT TO SAVE #{self}"
  end

end

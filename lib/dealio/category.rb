class Dealio::Category  
  attr_accessor :name, :url, :items
  @@all = []
  def initialize(name, url)
    @name = name
    @url =  "https://www.bradsdeals.com" + url 
    @items = []
    @@all << self #saving or remembering the object 
  end
  
  def self.all 
    @@all 
  end
end
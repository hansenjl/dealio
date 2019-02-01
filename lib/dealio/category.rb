class Dealio::Category
  attr_accessor :name, :url, :type
  attr_reader :deals  #has_many relationship
  @@all = []
  def initialize(name, url, type)
    @name = name
    @url =  "https://www.bradsdeals.com" + url
    @deals = []
    @type = type
    @@all << self #saving or remembering the object
  end

  def self.all
    @@all
  end
  
  def self.homegoods
    @@all.select{|item| item.type == "home"}
  end
  
  def self.electronics
    @@all.select{|item| item.type == "electronics"}
  end
  
  def self.shoes
    @@all.select{|item| item.type == "shoes"}
  end



  def add_deal(deal)
    self.deals << deal
    deal.category = self
  end
end
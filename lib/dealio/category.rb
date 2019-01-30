class Dealio::Category
  attr_accessor :name, :url
  attr_reader :deals  #has_many relationship
  @@all = []
  def initialize(name, url)
    @name = name
    @url =  "https://www.bradsdeals.com" + url
    @deals = []
    @@all << self #saving or remembering the object
  end

  def self.all
    @@all
  end


  def add_deal(deal)
    self.deals << deal
    deal.category = self
  end
end
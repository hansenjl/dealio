class Dealio::Category
  attr_accessor :name, :url, :type 
  attr_reader :deals  #has_many relationship
  @@all = []
  def initialize(name, url, type)
    @name = name
    @url =  "https://www.bradsdeals.com" + url
    @type = type
    @deals = []
    @@all << self #saving or remembering the object
  end

  def self.all
    @@all
  end
  
  def self.type(type)
    @@all.select{|category| category.type == type}
  end



  def add_deal(deal)
    self.deals << deal
    deal.category = self
  end
end
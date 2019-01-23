class Dealio::Scraper   
  
  def self.scrape_categories(url)
    #open the url and scrape all the categories 
    webpage = Nokogiri::HTML(open(url))
    section = webpage.css("div.category-drawer")
    array_of_links = section.css("li a.icon.arrow-right.end-of-line")

    array_of_links.map do |link|
     Dealio::Category.new(link.text, link.attributes["href"].value) 
    end 
    #return value will now be an array of objects 
  end
  
  def self.scrape_items(category)
    webpage = Nokogiri::HTML(open(category.url))
    items = webpage.css("div.col.information h3 a.go-link")
    items.each do |item_link|
      category.items << item_link.text 
    end
  end
  
end
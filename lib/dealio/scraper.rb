class Dealio::Scraper

  def self.scrape_categories(type)
    #open the url and scrape all the categories
    url = "https://www.bradsdeals.com/categories/#{type}"
    webpage = Nokogiri::HTML(open(url))
    section = webpage.css("div.category-drawer")
    array_of_links = section.css("li a.icon.arrow-right.end-of-line")

    array_of_links.map do |link|
     Dealio::Category.new(link.text, link.attributes["href"].value, type)
    end
    #return value will now be an array of objects
  end

  def self.scrape_items(category)
    webpage = Nokogiri::HTML(open(category.url))
    items = webpage.css("div.row div.col.information")
    items.each do |card|
      #creating an instance
      deal = Dealio::Deal.new

      name_and_price = card.css("a.go-link").text.split("$")

      #Assigning object attributes
      deal.description = card.css("p").text
      deal.product = name_and_price[0]
      deal.price = name_and_price[1]

      #Associated Objects
      category.add_deal(deal)

    end
  end

end
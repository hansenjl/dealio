class Dealio::CLI
  attr_accessor :theme
  
  def start   #instance method
    puts "Welcome to Dealio!"
    menu
  end

  def menu
    puts "What category do you want deals on today?"
    puts "Electronics, home goods, or shoes?"
    puts "Type either 'electronics', 'home', or 'shoes'"
    input = gets.strip.downcase
    case input
      when "electronics"
        puts "\n Fetching the electronics deals..."
        @theme = "electronics"
        scrape_categories if Dealio::Category.electronics.length == 0 
        list_categories
        choose_category
      when "home"
        puts "\n Fetching the home deals..."
        @theme = "home"
        scrape_categories if Dealio::Category.home.length == 0 
        list_categories
        choose_category
      when "shoes"
        puts "\n Fetching the shoe deals..."
        @theme = "shoes"
        scrape_categories  if Dealio::Category.shoes.length == 0      
        list_categories
        choose_category
      when "exit"
         puts "Goodbye"
      else
        puts "Sorry! I didn't understand that input"
        menu  #recursion
    end
  end

  def list_categories
    Dealio::Category.all.select{|item| item.type == @theme}.each.with_index(1) do |category, index|
      puts "#{index}. #{category.name}"
    end
  end

  def choose_category
    puts "\nChoose a category by selecting a number:"
    input = gets.strip.to_i
    max_value = Dealio::Category.all.select{|item| item.type == @theme}.length
    if input.between?(1,max_value)
      category = Dealio::Category.all.select{|item| item.type == @theme}[input-1]
      display_category_items(category)
    else
      puts "\nPlease put in a valid input"
      list_categories
      choose_category
    end
  end

  def display_category_items(category)
    Dealio::Scraper.scrape_items(category)
    puts "Here are the deals for #{category.name}:\n"
    category.deals.each.with_index(1) do |deal, index|   #represents an array of deal objects
      #print out info about each deal
      puts "\n#{index}. #{deal.product}"
      puts "Price: #{deal.price}"
      puts deal.description
    end
    second_menu
  end

  # def scrape_electronics
  #     url = "https://www.bradsdeals.com/categories/electronics"
  #     categories =  Dealio::Scraper.scrape_categories(url)
  # end
  # def scrape_home
  #     url = "https://www.bradsdeals.com/categories/home"
  #     categories =  Dealio::Scraper.scrape_categories(url)
  # end
  # def scrape_shoes
  #     url = "https://www.bradsdeals.com/categories/shoes"
  #     categories =  Dealio::Scraper.scrape_categories(url)
  # end
  
  def scrape_categories
    url = "https://www.bradsdeals.com/categories/" + @theme 
    categories =  Dealio::Scraper.scrape_categories(url, @theme)
  end

  def second_menu
    puts "Would you like to look at another category? Type 'C'"
    puts "Would you like to go to the start? Type 'S'"
    puts "Would you like to exit? Type 'E'"
    input = gets.strip.upcase
    case input 
    when "C", "CATEGORY"
      list_categories
      choose_category
    when "S", "START"
      menu
    when "E", "EXIT", "QUIT"
      puts "Goodbye!"
    else
      puts "Sorry I couldn't understand that command"
      second_menu
    end
  end
end
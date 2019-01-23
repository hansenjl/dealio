class Dealio::CLI   
  
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
        puts "in electronics"
        scrape_electronics
        list_categories
        choose_category
      when "home"
         puts "in home"
      when "shoes"
         puts "in shoes"
      when "exit"
         puts "Goodbye"
      else
        puts "Sorry! I didn't understand that input"
        menu  #recursion 
    end
  end
  
  def list_categories
    Dealio::Category.all.each.with_index(1) do |category, index|
      puts "#{index}. #{category.name}"
    end
  end
  
  def choose_category
    puts "\nChoose a category by selecting a number:"
    input = gets.strip.to_i 
    max_value = Dealio::Category.all.length 
    if input.between?(1,max_value)
      category = Dealio::Category.all[input-1]
      display_category_items(category)
    else
      puts "\nPlease put in a valid input"
      list_categories
      choose_category
    end
  end
  
  def display_category_items(category)
    Dealio::Scraper.scrape_items(category)
    category.items 
  end
  
  def scrape_electronics
      url = "https://www.bradsdeals.com/categories/electronics"
      categories =  Dealio::Scraper.scrape_categories(url)
  end
end
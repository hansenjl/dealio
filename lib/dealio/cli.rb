class Dealio::CLI
  attr_reader :counter, :type

  def start   #instance method
    puts "Welcome to Dealio!".colorize(:yellow)
    @counter = 0 
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
        @type = "electronics"
        if  @counter == 0  #not already scraped
          scrape_categories
          @counter = 1 
        end
        list_categories
        choose_category
      when "home"
         puts "in home"
         @type = "home"
         if !Dealio::Category.all.find{|category| category.type == "home"}
          scrape_categories
        end
         list_categories
         choose_category
      when "shoes"
         puts "in shoes"
         @type = "shoes"
         if Dealio::Category.type(@type) == []
           scrape_categories
         end
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
    Dealio::Category.type(@type).each.with_index(1) do |category, index|
      puts "#{index}. #{category.name}"
    end
  end

  def choose_category
    puts "\nChoose a category by selecting a number:"
    input = gets.strip.to_i
    max_value = Dealio::Category.type(@type).length
    if input.between?(1,max_value)
      category = Dealio::Category.type(@type)[input-1]
      display_category_items(category)
    else
      puts "\nPlease put in a valid input"
      list_categories
      choose_category
    end
  end

  def display_category_items(category)
    if category.description == [] 
      Dealio::Scraper.scrape_items(category)
    end
    puts "Here are the deals for #{category.name}:\n"
    category.deals.each.with_index(1) do |deal, index|   #represents an array of deal objects
      #print out info about each deal
      puts "\n#{index}. #{deal.product}"
      puts "Price: #{deal.price}"
      puts deal.description
    end
    second_menu
  end

  def scrape_categories
      categories =  Dealio::Scraper.scrape_categories(@type)
  end

  def second_menu
    puts "Would you like to look at another category? Type 'C'"
    puts "Would you like to go to the start? Type 'S'"
    puts "Would you like to exit? Type 'E'"
    input = gets.strip.upcase
    if input == "C"
      list_categories
      choose_category
    elsif input == "S"
      menu
    elsif input == "E"
      puts "Goodbye!"
    else
      puts "Sorry I couldn't understand that command"
      second_menu
    end
  end
end
class Dealio::CLI   
  
  def start   #instance method
    puts "Welcome to Dealio!"
    puts "What category do you want deals on today?"
    puts "Electronics, home goods, or shoes?"
    puts "Type either 'electronics', 'home', or 'shoes'"
    input = gets.strip.downcase
    case input 
      when "electronics"
        puts "in electronics"
        #Scrape the Electronics page 
        url = "https://www.bradsdeals.com/categories/electronics"
        Dealio::Scraper.scrape_categories(url)
      when "home"
         puts "in home"
      when "shoes"
         puts "in shoes"
      when "exit"
         puts "Goodbye"
      else
        puts "invalid"
        #they didn't put in a correct input
    end
  
    
    
    
    
    
    
  end
end
require_relative 'scrape'
require 'mechanize'

class Processing

    # initializing the website to Scrape class.
    def initialize
        site = "https://news.osu.edu"
        @website = Scrape.new(site)
    end
    
    def start
        loop do
            puts "Please enter a topic to search for any related OSU News to the topic:"
            topic = gets.chomp
            puts "searching..."
            @website.fill_form(topic) # fill the search bar in OSU News website
            list_articles = @website.get_articles_names # get the article names that shows up after searching
            puts "You are now in the page #{@website.page.uri}\n"
            
            # statement for output whether there is a result or not
            if list_articles.count != 0
                puts "Here are the available articles on #{topic}:"
                
                list_articles.each_with_index do |article_title, index| # print out the articles with numbers
                    puts "#{index+1}. #{article_title}"
                end

                puts "Choose a number for an article you want to read:"
                number = gets.chomp.to_i

                # find the article associated with the number
                article_title = list_articles[number-1] 

                # go to url for that article and get text
                article_text = @website.get_article_text(article_title)
                
                # display article text
                puts article_text
                words_number = @website.count_words(article_text) # count the number of words in text

                puts "Number of words in the article: #{words_number}\n"

                loop do 
                    puts "Enter keys words you would like to find in the article:"
                    key_word = gets.chomp

                    #search for key words
                    key_word_exist = @website.search_for_word_in_article(article_title,key_word)
                    puts key_word_exist
                    puts "Would you like to enter another key word or enter N to quit"
                    new_key_word = gets.chomp
                    if (new_key_word.downcase == "n")
                        break
                    end
                end
            else
                puts "No article found!\n"
            end

            puts "Would you like to find a new topic? Press any key to continue and N to quit."
            ans = gets.chomp
            if(ans.downcase == "n")
                break
            end
        end
    end
end



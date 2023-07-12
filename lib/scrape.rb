require 'mechanize'


class Scrape
    attr_accessor :page
    
    def initialize(website)
        mech = Mechanize.new
        @page = mech.get(website)
    end
    
    def fill_form(topic) # find the first form in OSU News website
        input = @page.forms[0]
        input['q'] = topic
        search = input.submit # submit button
        @page = search # @page will now go to the searched page
    end

    def get_article_text(article_title)
        link = @page.link_with(text: article_title)
        news_page = link.click
        news_text = news_page.css('div.pp-overflow-hidden p, div.pp-overflow-hidden li').text.strip # since p is only taking the paragraphs, there might be some text in ordered list
        return news_text
    end

    def count_words(article_text)
        delimiters = [',', ' ', ';',':','.','(',')','“']
        wordArray = article_text.split(Regexp.union(delimiters))
        return wordArray.count
    end

    def get_articles_names
        articles_names = @page.css('td div a:not(.searchresult_readmore)').map(&:text) # put the article names in a map
        articles_names.delete("caldwell.151@osu.edu") # I couldn't find where this email come from so I just hard delete it.
        articles_names
    end

    def search_for_word_in_article(article,word)
        text = get_article_text(article)
        return 'Exist' if text.include?(word)
        return 'Not Exist'
    end
end

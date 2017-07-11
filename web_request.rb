require "pry-byebug"
require 'nokogiri'
require 'open-uri'

class WebRequest

  def import_data(word_to_search)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{word_to_search}"
    file = open(url, "Accept-Language" => "en")
    doc = Nokogiri::HTML(file)

    food_name = doc.search('.m_titre_resultat > a')

    food_name
  end

  def x(number_of_food, word_to_search)
    base_url = "http://www.letscookfrench.com"
    food = import_data(word_to_search)
    recipe = food[number_of_food - 1]

    individual_page = base_url + recipe.attribute('href')

    file = open(individual_page, "Accept-Language" => "en")
    doc = Nokogiri::HTML(file)

    individual_method = doc.search('.m_content_recette_todo').text.strip.gsub(/\r/, '').gsub(/\n/, '').split("  ")[-1]
    food_time = doc.search('span.preptime').text.strip
    food_dificult = doc.search('.m_content_recette_breadcrumb').text.delete("-").split("\r")[2].strip

    [recipe.text, individual_method, food_time, food_dificult]
  end
end


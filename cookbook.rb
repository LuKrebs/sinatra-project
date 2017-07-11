require 'csv'
require_relative 'recipe'

class Cookbook
  attr_accessor :recipe_list, :recipe, :description, :time, :difficult

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_change
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index - 1)
    save_change
  end

  def mark_as_done(recipe_done)
    recipe = @recipes[recipe_done]
    recipe.name = recipe.name.gsub('[ ]', '[X]')
    recipe.name = recipe.name.gsub('[X]', '[X]')
    save_change
  end

  private

  def save_change
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |item|
        csv << [item.name, item.description, item.time, item.difficult]
      end
    end
  end
end

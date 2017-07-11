require 'yaml/store'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'web_request'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @title = "Welcome to the Cookbook!"
  erb :index
end

get '/new' do
  erb :new
end

get '/create' do
  @recipe = Recipe.new(params["name"], params["description"], params["time"], params["difficult"])
  csv_path = 'recipes.csv'
  @cookbook = Cookbook.new(csv_path)
  @cookbook.add_recipe(@recipe)
  redirect '/'
end

get '/delete' do
  csv_path = 'recipes.csv'
  @cookbook = Cookbook.new(csv_path)
  @recipes = @cookbook.all
  if params['delete_number'] != nil
    @cookbook.remove_recipe(params['delete_number'].to_i)
  end
  params["delete_number"] = 150
  erb :delete

end

get '/list' do
  csv_path = 'recipes.csv'
  @cookbook = Cookbook.new(csv_path)
  @recipes = @cookbook.all
  erb :list
end

get '/import' do

  @web_request = WebRequest.new()
  @food_name = params['import_word']
  @request2 = @web_request.import_data(@food_name)

  @food_number = params['import_number'].to_i
  if @food_number > 0 && @food_name != nil
    @right_food = @web_request.x(@food_number - 1, @food_name)
    @new_recipe = Recipe.new(@right_food[0], @right_food[1], @right_food[2], @right_food[3])
    csv_path = 'recipes.csv'
    @cookbook = Cookbook.new(csv_path)
    @cookbook.add_recipe(@new_recipe)
  end

  params['import_number'] = 0
  erb :import
end



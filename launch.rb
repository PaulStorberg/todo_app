require "csv"

require_relative 'controllers/application_controller.rb'
require_relative 'models/application_model.rb'
# require_relative 'views/application.rb'

object_array = ['list', 'task', 'user']

object_array.each do |controller|
  require_relative "controllers/#{controller}s_controller.rb"
end

object_array.each do |model|
  require_relative "models/#{model}.rb"
end

object_array.each do |view|
  require_relative "views/#{view}s.rb"
end

# puts "Please enter your username."
# username = gets.chomp
# puts "Please enter your password."
# password = gets.chomp.downcase

# @user = User.find(0)
# @user.update(username: "Testy")

# @user = User.create(username: "username", password: "password")

# @user = User.find(4)
# @user.destroy

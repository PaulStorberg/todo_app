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

# ==============================================================================
# puts "Hello! Please sign in(1), sign up(2) or exit(3)"
#
# answer = gets.chomp.downcase.to_i
#
# while true
#   if answer == 1
#     UsersController.new_session
#     break
#   elsif answer == 2
#     UsersController.sign_up
#     break
#   elsif answer == 3
#     break
#   else
#     puts "Please type an integer."
#     answer = gets.chomp.downcase.to_i
#   end
# end

# ==============================================================================
User.find_by(username: 'Paul', password: 'password')

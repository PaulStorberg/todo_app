class UsersView
  def self.show(user)
    puts "#{user.username}s Tasks!"
  end

  def self.sign_up
    puts "Users sign up".upcase
    puts ""
    puts "Please enter a username."
    username = gets.chomp
    puts ""
    puts "Please enter a password."
    password = gets.chomp.downcase

    UsersController.create(username, password)
  end

  def self.sign_in
    puts "Users sign in".upcase
    puts ""
    puts "Please enter your username."
    username = gets.chomp
    puts ""
    puts "Please enter your password."
    password = gets.chomp.downcase

    UsersController.create_session(username, password)
  end

  def tasks_index
    puts "Users tasks index"
  end
end

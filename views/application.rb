options = [
  "Create Task",
  "Edit Task",
  "Delete Task",
  "Exit Program"
]

while true
  puts "What would you like to do?"
  options.each_with_index do |option, index|
    puts "  #{index + 1}. #{option}"
  end

  answer = gets.chomp.to_i

  case answer
  when 1 # Create Task
    puts "Option under construction Create"
  when 2 # Edit Task
    puts "Option under construction Edit"
  when 3 # Delete Task
    puts "Option under construction Delete"
  when 4 # Exit Program
    number = rand(1..2)
    if number.even?
      puts "See you later alligator!"
    else
      puts "After a while crocodile!"
    end

    break
  else # Invalid Entry
    puts "Type the right numbers bitch ass"
  end
end

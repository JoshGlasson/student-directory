@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      @students = input_students
    when "2"
      show_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

# user input for students
def input_students
  puts "Please enter the names and cohorts of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    cohort = gets.chomp
    # add the student hash to the array
    @students << {name: name, cohort: cohort}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} student"
    end
    # get another name and cohort from the user
    name = gets.chomp
  end
  @students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print_students_list
  @students.each_with_index do |student, index|
#    if student[:name][0,1] == "J"  # ---> code for printing out names beginning with certain letter
#    if student[:name].length < 5   # ---> code for printing out names under certain length
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
#    end # ---> end for first letter of names
#    end # ---> end for certain length of names
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

interactive_menu

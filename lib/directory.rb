
class StudentDirectory
attr_reader :students

def initialize
  @students = []
end

def interactive_menu
  loop do
    puts print_menu
    process_menu_selection(STDIN.gets.chomp)
  end
end

def print_menu
  return "1. Input the students\n2. Show the students\n3. Save the list to csv file\n4. Load the list from csv file\n9. Exit"
end

def show_students
  print_header
  print_students_list
  puts print_footer
end

def process_menu_selection(selection)
  case selection
    when "1"
      puts "You've selected option 1. Input Students"
      puts "Please enter the names and cohorts of the students"
      puts "To finish, just hit return twice"
      students = input_students
    when "2"
      puts "You've selected option 2. Show the Students"
      show_students
    when "3"
      puts "You've selected option 3. Save Students to csv file"
      puts "Enter filename.csv"
      save_students(STDIN.gets.chomp)
    when "4"
      puts "You've selected option 4. Load Students from csv file"
      puts "Enter filename.csv"
      load_students(STDIN.gets.chomp)
    when "9"
      puts "You've selected option 9. Exit, Goodbye!"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students(filename)
  return if filename.nil?
  if File.exists?(filename)
    puts "#{filename} already exists, do you want to 1. Overwrite it or 2. Add to it?"
    puts "Enter 1 or 2"
    input = STDIN.gets.chomp
    if input == "1"
      file = File.open(filename, "w")
      # iterate over the array of students
      students.each do |student|
        student_data = [student[:name], student[:cohort]]
        csv_line = student_data.join(",")
        file.puts csv_line
      end
      file.close
      puts "#{filename} saved."
    elsif input == "2"
      # open the file for writing
      file = File.open(filename, "a")
      # iterate over the array of students
        students.each do |student|
          student_data = [student[:name], student[:cohort]]
          @csv_line = student_data.join(",")
        file.puts @csv_line
      end
      file.close
      puts "#{filename} saved."
    else
      return
    end
  else
    file = File.open(filename, "w")
    # iterate over the array of students
    students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    file.close
    puts "#{filename} saved."
  end
end


def load_students(filename)
  return if filename.nil? # get out of the method if it isn't given
    if File.exists?(filename) # if it exists
      @students = []
      file = File.open(filename, "r")
      file.readlines.each do |line|
        name, cohort = line.chomp.split(',')
        students_into_hash(name, cohort)
      end
      puts "Loaded #{students.count} from #{filename}"
    else
      puts "Sorry, #{filename} doesn't exist."
      return
    end
  file.close
end

def try_load_students(filename)
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def students_into_hash(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

# user input for students
def input_students
  name = STDIN.gets.chomp
  while !name.empty? do
    cohort = STDIN.gets.chomp
    students_into_hash(name, cohort)
    puts student_counter
    name = STDIN.gets.chomp
  end
  students
end

def student_counter
  if students.count == 1
    return "Now we have #{students.count} student"
  else
    return "Now we have #{students.count} students"
  end
end

def print_header
  puts "The students of Makers Academy"
  puts "-------------------------------------------"
end

def print_students_list
  students.each_with_index do |student, index|
#    if student[:name][0,1] == "J"  # ---> code for printing out names beginning with certain letter
#    if student[:name].length < 5   # ---> code for printing out names under certain length
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
#    end # ---> end for first letter of names
#    end # ---> end for certain length of names
end

def print_footer
  if students.count == 1
    puts "Overall, we have #{students.count} great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
  return "-------------------------------------------"
end
end

sd = StudentDirectory.new
sd.interactive_menu

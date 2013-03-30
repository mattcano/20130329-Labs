
class Menu

  attr_accessor :task_count, :task_arr

  def initialize
    @task_count = 0
    @task_arr = []
    greeting
  end

  CONTROLS_STR = ["N:  Create a new task", 
              "M:  Mark a task as complete", 
              "P:  Print out all tasks", 
              "I:  Print incomplete tasks", 
              "C:  Print complete tasks",
              "E:  Export to file",
              "X:  Exit"]

  CONTROLS = ["N", "M", "P", "I", "C", "E", "X"]

  def greeting
    puts "\nWelcome to SuperList!\n\n"
  end

  def prompt
    puts "\nWhat would you like to do?"
    print_controls
    c = gets.chomp.upcase
    validate_control(c)
    case c
    when "N"
      new_task
    when "M"
      mark_complete
      print_all
    when "P"
      print_all
    when "I"
      print_incomplete
    when "C"
      print_complete
    when "E"
      export_to_file
    when "X"
      return false
    end
    return true
  end

  def new_task
    t = Task.new
    puts "\nWhat is your new task?"
    t.message = gets.chomp
    @task_arr << t
  end

  def mark_complete
    puts "Which task # would you like to mark complete?"
    num = gets.chomp.to_i
    raise Invalid_Task_Entry unless num > 0 && num <= @task_arr.size
    @task_arr[num-1].complete = true
  end

  def print_all
    count = 1
    puts "\nYour SuperList:"
    @task_arr.each do |t|
      puts count.to_s + ". " + marker(t.complete)+ " " + t.message
      count += 1
    end
  end

  def print_incomplete
    temp_arr = @task_arr.select{ |t| t.complete == false}
    puts "\nYour Incomplete tasks:"
    temp_arr.each do |t|
      puts marker(t.complete)+ " " + t.message
    end
  end

  def print_complete
    temp_arr = @task_arr.select{ |t| t.complete == true}
    puts "\nYour Incomplete tasks:"
    temp_arr.each do |t|
      puts marker(t.complete)+ " " + t.message
    end
  end

  def export_to_file
    puts "\nWhat do you want to name your export file?"
    str = gets.chomp
    f = File.new("#{str}.txt", "w+")
    count = 1
    f.puts "Your SuperList:"
    @task_arr.each do |t|
      f.puts count.to_s + ". " + marker(t.complete)+ " " + t.message
      count += 1
    end
    f.close
  end

   def print_controls
    CONTROLS_STR.each{|i| puts i}
  end

  #takes in a boolean
  def marker(bool)
    if bool
      return "X"
    else
      return "O"
    end
  end

  def validate_control(input)
    raise Invalid_Control_Entry unless CONTROLS.include?(input.upcase)
  end

end


class Task

  attr_accessor :complete, :message

  def initialize 
    @complete = false
    @message = ""
  end

end

class Todo_Exception < Exception
  def message
    "GENERAL TODO EXCEPTION"
  end
end

class Invalid_Control_Entry < Todo_Exception
  def message 
    "\nNOT A VALID CONTROL."
  end
end

class Invalid_Task_Entry < Todo_Exception
  def message 
    "\nNOT A VALID TASK."
  end
end

m = Menu.new

continue = true

while continue
  begin
    continue = m.prompt
  rescue Todo_Exception => ex
    puts ex.message
    retry
  end
end

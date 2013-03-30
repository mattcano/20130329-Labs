class City

  attr_accessor :name, :population

  def initialize
    @name = ""
    @population = 0
  end
end

counter = 1
city_array = []

puts "Welcome to City Sim!!"
puts "--------------------"

5.times do 

  print "Please enter the name of city \##{counter}:         "
  new_name = gets.chomp

  print "Please enter the population of city \##{counter}:   "
  new_population = gets.chomp
  puts "--------------------"
  counter += 1

  c = City.new
  c.name = new_name
  c.population = new_population

  city_array << c

end

city_array.each{|c| puts c.name + ": " + c.population.to_s}
city_array.sort!{ |x,y| y.population <=> x.population}
puts "Your most populous city is #{city_array[0].name}"

########################### Concepts #############################
=begin

- Ruby doesn't care about whitespace (spaces and blank lines)
- Blocks can be defined with either the keywords do and end or with curly braces ({}).

1.times do
  puts "I'm a code block!"
end

1.times { puts "As am I!" }

Along with false, nil is one of two non-true values in Ruby (Every other object is regarded as "truthy," meaning that if you were to type if 2 or if "bacon", the code in that if statement would be run.)

Remember: there's always more than one way to do something in Ruby.


=end
########################### Strings #############################
print "What's your first name?" # (print it)
puts "shun" # (print it and a newline)

"Eric".reverse #=> "cirE"
"love".length #=> 4
"eric".upcase #=> "ERIC" 
"ERIC".downcase #=> "eric"

=begin						=> muti-line comment
I'm a comment!
I don't need any # symbols.
=end

x = gets #=> (intput aaa) => "aaa\n"
x = x.chomp #=> "aaa"

first_name = "Kevin"		#=> (print with variable)
puts "Your name is #{first_name}!"

#[.capitalize capitalize first letter and make the rest lowercase]
"AAA".capitalize #=> "Aaa"
"aaa".capitalize #=> "Aaa"
answer.capitalize! #=> (next time when using variable answer => answer.capitalize)(also can use .upcase! ...)
user_input = gets.chomp.downcase! #=> (this doesn't work!!!)

x = "3"
x.to_i  # int 3

"hello".each_char {|c| print c, ' ' }

a = "hello "
a << "world"   #=> "hello world"
a.concat(33)   #=> "hello world!"

a = "hello there"
a[1]                   #=> "e"
a[2, 3]                #=> "llo"
a[2..3]                #=> "ll"
a[-3, 2]               #=> "er"
a[7..-2]               #=> "her"
a[-4..-2]              #=> "her"
a[-2..-4]              #=> ""
a[11, 0]               #=> ""
a[11]                  #=> nil
a[12, 0]               #=> nil
a[12..-1]              #=> nil

"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  #=> "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"

"hello".index('e')             #=> 1
"hello".index('lo')            #=> 3
"hello".index('a')             #=> nil
"hello".index(?e)              #=> 1
"hello".index(/[aeiou]/, -3)   #=> 4

"abcd".insert(0, 'X')    #=> "Xabcd"
"abcd".insert(3, 'X')    #=> "abcXd"
"abcd".insert(4, 'X')    #=> "abcdX"
"abcd".insert(-3, 'X')   #=> "abXcd"
"abcd".insert(-1, 'X')   #=> "abcdX"

########################### Conditions #############################
if x < y  # Assumes x and y are defined
  puts "x is less than y!"
elsif x > y
  puts "x is greater than y!"
else
  puts "x equals y!"
end
-1
unless hungry
  puts "I'm writing Ruby programs!"
else
  puts "Time to eat!"
end

problem = false
print "Good to go!" unless problem

if string_to_check.include? "substring" #=> (As a general rule, Ruby methods that end with ? evaluate to the boolean values true or false)
	string_to_change.gsub!(/s/, "th")	#=> (change every 's' to "th")
end

counter = 1
while counter < 11
  puts counter
  counter = counter + 1
end

i = 0
until i == 6	# i == 6
  i += 1
end
puts i

for num in 1...10	#=> print 1-9
  puts num
end

for num in 1..10	#=> print 1-10
  puts num
end

loop { print "Hello, world!" } # infinitely print 

i = 0
loop do
  i += 1
  print "#{i}"
  break if i > 5
end

for i in 1..5		# won't print even number
  next if i % 2 == 0
  print i
end

numbers = [1, 2, 3, 4, 5]	# new array
# one way to loop
numbers.each { |item| puts item }	# item is the variable representing each elements in array
# another way to loop
numbers.each do |item|
  puts item
end

3.times {print "hahaha\n"}	# print hahaha 3 times

text = ["aaa,bbb,ccc"]
text.split(",")			# ["aaa", "bbb", "ccc"]

case language
when "JS"
  puts "Websites!"
when "Python"
  puts "Science!"
when "Ruby"
  puts "Web apps!"
else
  puts "I don't know!"
end

case language     # same as above
  when "JS" then puts "Websites!"
  when "Python" then puts "Science!"
  when "Ruby" then puts "Web apps!"
  else puts "I don't know!"
end

########################### Hash #############################
hash = {
  key1 => value1,
  key2 => value2,
  key3 => value3
}

pets = Hash.new
pets["guotai"] = "cat"
puts pets["guotai"]		# print "cat"

restaurant_menu = {
  "noodles" => 4,
  "soup" => 3,
  "salad" => 2
}
restaurant_menu.each do |item, price|	# print item and prices pairs
  puts "#{item}: #{price}"
end

# If you have a hash with a default value, and you try to access a non-existent key, you get that default value.
h = Hash.new("nothing here")
puts h # {}
puts h["kitty"] # print "nothing here"

colors = {"blue" => 3, "green" => 1, "red" => 2}	# sort a hash
colors = colors.sort_by do |color, count|
  count
end

colors = colors.sort_by { # same as above 
 |color, count|
  count
}

colors.each do |name, number|
  puts name + " " + count.to_s
end

########################### Functions #############################
def puts_1_to_10
  (1..10).each { |i| puts i }
end

def square(n)
  puts n ** 2
  return n * 2
end

def what_up(greeting, *bros)	#  splat arguments
  bros.each { |bro| puts "#{greeting}, #{bro}!" }
end
what_up("What up", "Justin", "Ben", "Kevin Sorbo")

def capitalize(string) 
  puts "#{string[0].upcase}#{string[1..-1]}"
end

# The combined comparison operator looks like this: <=>. It returns 0 if the first operand (item to be compared) equals the second, 1 if first operand is greater than the second, and -1 if the first operand is less than the second.
book_1 = "A Wrinkle in Time"
book_2 = "A Brief History of Time"
book_1 <=> book_2

books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]
books.sort! {
 |first, second|
 second <=> first
}

def alphabetize(arr, rev=false) # default value of rev = "false"
end

########################### Hashes and Symbols #############################
# The .object_id method gets the ID of an object—it's how Ruby knows whether two objects are the exact same object.
puts "string".object_id
puts "string".object_id

# Symbols make good hash keys for a few reasons:
# - They're immutable, meaning they can't be changed once they're created;
# - Only one copy of any symbol exists at a given time, so they save memory;
# - Symbol-as-keys are faster than strings-as-keys because of the above two reasons.

symbol_hash = {
  :one => 1,
}

:sasquatch.to_s # ==> "sasquatch"
"sasquatch".to_sym # ==> :sasquatch
"hello".intern # ==> :hello

# .push method allows you to add an element to the end of an array!
numbers = [1, 2, 3, 4, 5, 6]
evens = []
numbers.each do |number|
  if number % 2 == 0
    evens.push(number)
  end
end
print evens # prints '[2, 4, 6]'

grades = { alice: 100,
  bob: 92,
  chris: 95,
  dave: 97
}
grades.select {|name, grade| grade < 97} # ==> {:bob=>92, :chris=>95}
grades.select { |k, v| k == :alice } # ==> {:alice=>100}

my_hash = { one: 1, two: 2, three: 3 }
my_hash.each_key { |k| print k } # ==> one two three
my_hash.each_value { |v| print v } # ==> 1 2 3

if movies[title.to_sym] == nil  # add to hash
  movies[title.to_sym] = rating.to_i
else
  puts "already exists"
end

if movies[title.to_sym].nil?  # delete from a hash
    puts "Movie not found!"
else
    movies.delete(title.to_sym)
    puts "#{title} has been removed."
end

########################### Refactor #############################
ruby_is_eloquent = true
ruby_is_ugly = false

puts "Ruby is eloquent!" if ruby_is_eloquent
puts "Ruby's not ugly!" unless ruby_is_ugly

puts 3 < 4 ? "3 is less than 4!" : "3 is not less than 4."

# if we only want to assign a variable if it hasn't already been assigned? For this, we can use the conditional assignment operator: ||=
favorite_book = nil
favorite_book ||= "Cat's Cradle"  # favorite_book = "Cat's Cradle"
favorite_book ||= "Why's (Poignant) Guide to Ruby"  # doesn't do anything
favorite_book = "Why's (Poignant) Guide to Ruby"

def multiple_of_three(n)
  return n % 3 == 0 ? "True" : "False"
end

def multiple_of_three(n)
   n % 3 == 0 ? "True" : "False"  # same as above!
end

95.upto(100) { |num| print num, " " } # Prints 95 96 97 98 99 100
100.downto(95) { |num| print num, " "} # prints 100 99 98 97 96 95
"A".upto("E") {|x| print x, " "} # A B C D E

# .respond_to? takes a symbol and returns true if an object can receive that method and false otherwise.
[1, 2, 3].respond_to?(:push)  # true
[1, 2, 3].respond_to?(:to_sym)  # false

[1, 2, 3] << 4 # ==> [1, 2, 3, 4]
"Yukihiro " << "Matsumoto" # ==> "Yukihiro Matsumoto"

drink = "espresso"
age = 26
"I love " + drink   # ==> I love espresso
"I love " << drink  # ==> I love espresso
"I am " + age.to_s + " years old." # ==> "I am 26 years old."
"I am " << age.to_s << " years old." # ==> "I am 26 years old."
"I love #{drink}." # ==> I love espresso.
"I am #{age} years old." # ==> I am 26 years old.

return "n must be an integer." unless n.is_a? Integer

########################### Blocks, Procs, and Lambdas #############################
[1, 2, 3].each { |num| puts num }

my_nums = [1, 2, 3]
my_nums.collect { |num| num ** 2 } # ==> [1, 4, 9]
my_nums # ==> [1, 2, 3]
my_nums.collect! { |num| num ** 2 } # ==> [1, 4, 9]
my_nums # ==> [1, 4, 9]
# The .collect! and .map! methods do the exact same thing

def yield_name(name)
  puts "In the method! Let's yield."
  yield("Kim")
  puts "In between the yields!"
  yield(name)
  puts "Block complete! Back in the method."
end
yield_name("Eric") { |n| puts "My name is #{n}." }

#=============>
# In the method! Let's yield.
# My name is Kim.
# In between the yields!
# My name is Eric.
# Block complete! Back in the method.

# The & is used to convert the cube proc into a block
cube = Proc.new { |x| x ** 3 }
[1, 2, 3].collect!(&cube)	# ==> [1, 8, 27]
[1, 2, 3].collect! { |x| x ** 3 }	# same as above!

# Why bother saving our blocks as procs? There are two main advantages:
# - Procs are full-fledged objects, so they have all the powers and abilities of objects. (Blocks do not.)
# - Unlike blocks, procs can be called over and over without rewriting them. This prevents you from having to retype the contents of your block every time you need to execute a particular bit of code.

# Unlike blocks, we can call procs directly by using Ruby's .call method
test = Proc.new { # does something }
test.call 	# does that something!

strings = ["1", "2", "3"]
nums = strings.map(&:to_i)	# ==> [1, 2, 3]

lambda { puts "Hello!" }	# These two are the same
Proc.new { puts "Hello!" }

strings = ["leonardo", "donatello", "raphael", "michaelangelo"]
symbolize = lambda { |x| x.to_sym } 
symbols = strings.collect(&symbolize)	# [:leonardo, :donatello, :raphael, :michaelangelo]

def lambda_demo(a_lambda)
  puts "I'm the method!"
  a_lambda.call
end
lambda_demo(lambda { puts "I'm the lambda!" })
# =========>
# I'm the method! 
# I'm the lambda!

def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }# this will return
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_proc
def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!" # this will return
end
puts batman_ironman_lambda
# See how the proc says Batman will win? This is because it returns immediately, without going back to the batman_ironman_proc method.
# Our lambda, however, goes back into the method after being called, so the method returns the last code it evaluates: "Iron Man will win!"

:hello.is_a? Symbol # ==> true

# A block is just a bit of code between do..end or {}. It's not an object on its own, but it can be passed to methods like .each or .select.
# A proc is a saved block we can use over and over.
# A lambda is just like a proc, only it cares about the number of arguments it gets and it returns to its calling method rather than returning immediately.

odds_n_ends = [:weezard, 42, "Trady Blix", 3, true, 19, 12.345] # an array can contain different types
is_int = lambda { |x| x.is_a? Integer}
ints = odds_n_ends.select(&is_int)	# select all integers

########################### Object-Oriented Programming  #############################
# (Almost) everything in Ruby is an object! 
# we use @ before a variable to signify that it's an instance variable.
class Language
  def initialize(name, creator)
    @name = name
    @creator = creator
  end
  def description
    puts "I'm #{@name} and I was created by #{@creator}!"
  end
end
ruby = Language.new("Ruby", "Yukihiro Matsumoto")
ruby.description

# We can create class variables by starting a variable name with two @ symbols. Class variables are attached to entire classes, not just instances of classes
class Person
  @@people_count = 0
  def initialize(name)
    @name = name
    @@people_count += 1
  end
  def self.number_of_instances
    @@people_count
  end
end
matz = Person.new("Yukihiro")
dhh = Person.new("David")
puts "Number of Person instances: #{Person.number_of_instances}"	# 2

# Global variables can be declared in two ways. The first is you just define the variable outside of any method or class. If you want to make a variable global from inside a method or class, just start it with a $
class MyClass
  $my_variable = "Hello!"
end
puts $my_variable

class Creature
  def initialize(name)
    @name = name
  end
  
  def fight
    puts "Punch to the chops!"
  end
end
class Dragon < Creature
   def fight 
      puts "Instead of breathing fire..."
      super
   end
end

class Monkey
end
class Monkey; end # same as above

# A class method belongs to the class itself, and for that reason it's prefixed with the class name
class Machine
  def Machine.hello
    puts "Hello from the machine!"
  end
end

class Person
  attr_reader :name
  attr_writer :name
end
### same as ###
def name
  @name
end

def name=(value)
  @name = value
end

attr_reader :job
attr_writer :job
### same as ###
attr_accessor :job

# You can think of modules as being very much like classes, only modules can't create instances and can't have subclasses. They're just used to store things!
module Circle

  PI = 3.141592653589793
  def Circle.area(radius)
    PI * radius**2
  end

  def Circle.circumference(radius)
    2 * PI * radius
  end
end

puts Math::PI
# See that double colon we just used? That's called the scope resolution operator, which is a fancy way of saying it tells Ruby where you're looking for a specific bit of code. (namespacing)

# Some modules, like Math, are already present in the interpreter. Others need to be explicitly brought in, however, and we can do this using require
require 'date'
puts Date.today

# Any class that includes a certain module can use those module's methods!
class Angle
  include Math
  attr_accessor :radians
  
  def initialize(radians)
    @radians = radians
  end
  
  def cosine
    cos(@radians)
  end
end

acute = Angle.new(1)
acute.cosine

module Action
  def jump
    @distance = rand(4) + 2
    puts "I jumped forward #{@distance} feet!"
  end
end
class Rabbit
  include Action
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
peter = Rabbit.new("Peter")
peter.jump

########################### Final Project  #############################
module Menu

    def menu
      " Welcome to the TodoLister Program!
      This menu will help you use the Task List System
      1) Add
      2) Show
      3) Update
      4) Delete
      5) Write to File
      6) Read from File
      7) Toggle Status
      Q) Quit "
    end

    def show
      menu
    end

  end

  module Promptable

    def prompt(message = "Just the facts, ma'am.", symbol = ':> ')
      print message
      print symbol
      gets.chomp
    end

  end

  class List
    attr_reader :all_tasks

    def initialize
      @all_tasks = []
    end

    def add(task)
      all_tasks << task
    end

    def delete(task_number)
      all_tasks.delete_at(task_number - 1)
    end

    def update(task_number, task)
      all_tasks[task_number - 1] = task
    end

    def show
      all_tasks.map.with_index { |l, i| "(#{i.next}): #{l}" }
    end

    def write_to_file(filename)
      machinified = @all_tasks.map(&:to_machine).join("\n")
      IO.write(filename, machinified)
    end

    def read_from_file(filename)
      IO.readlines(filename).each do |line|
        status, *description = line.split(':')
        status = status.downcase.include?('x')
        add(Task.new(description.join(':').strip, status))
      end
    end

    def toggle(task_number)
      all_tasks[task_number - 1].toggle_status
    end
      
end

  class Task
    attr_reader :description
    attr_accessor :completed_status

    def initialize(description, completed_status = false)
      @description = description
      @completed_status = completed_status
    end

    def to_s
      "#{represent_status} : #{description}"
    end

    def completed?
      completed_status
    end

    def toggle_status
      @completed_status = !completed?
    end

    def to_machine
      "#{represent_status}:#{description}"
    end

    private

    def represent_status
      completed? ? '[X]' : '[ ]'
    end

  end


  if __FILE__ == $PROGRAM_NAME
    include Promptable
    include Menu
    my_list = List.new
    puts 'Please choose from the following list'
    until ['q'].include?(user_input = prompt(show).downcase)
      case user_input
        when '1'
          my_list.add(Task.new(prompt('What is the task you 
          would like to accomplish?')))
        when '2'
          puts my_list.show
        when '3'
          my_list.update(prompt('Which task to update?').to_i, 
          Task.new(prompt('Task Description?')))
        when '4'
          puts my_list.show
          my_list.delete(prompt('Which task to delete?').to_i)
        when '5'
          my_list.write_to_file(prompt 'What is the filename to 
          write to?')
        when '6'
          begin
            my_list.read_from_file(prompt('What is the filename to 
            read from?'))
          rescue Errno::ENOENT
            puts 'File name not found, please verify your file name 
            and path.'
          end
        when '7'
          puts my_list.show
          my_list.toggle(prompt('Which would you like to toggle the 
          status for?').to_i)
        else
          puts 'Try again, I did not understand.'
        end
        prompt('Press enter to continue', '')
      end
    puts 'Outro - Thanks for using the menu system!'
  end

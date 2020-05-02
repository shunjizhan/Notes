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

"Eric".reverse  # => "cirE"
"love".length   # => 4
"eric".upcase   # => "ERIC" 
"ERIC".downcase # => "eric"

=begin						=> muti-line comment
I'm a comment!
I don't need any # symbols.
=end

x = gets # => (intput aaa) => "aaa\n"
x = x.chomp # => "aaa"

first_name = "Kevin"		# => (print with variable)
puts "Your name is #{first_name}!"

#[.capitalize capitalize first letter and make the rest lowercase]
"AAA".capitalize   # => "Aaa"
"aaa".capitalize   # => "Aaa"
answer.capitalize! # => in place modification
user_input = gets.chomp.downcase! # => (thisesn't work!!!)

x = "3"
x.to_i  # int 3

"hello".each_char {|c| print c, ' ' }

a = "hello "
a << "world"   # => "hello world"
a.concat(33)   # => "hello world!"

a = "hello there"
a[1]       # => "e"
a[2, 3]    # => "llo"
a[2..3]    # => "ll"
a[-3, 2]   # => "er"
a[7..-2]   # => "her"
a[-4..-2]  # => "her"
a[-2..-4]  # => ""
a[11, 0]   # => ""
a[11]      # => nil
a[12, 0]   # => nil
a[12..-1]  # => nil

"hello".gsub(/[aeiou]/, '*')                  # => "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')             # => "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}      # => "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  # => "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    # => "h3ll*"

"hello".index('e')             # => 1
"hello".index('lo')            # => 3
"hello".index('a')             # => nil
"hello".index(?e)              # => 1
"hello".index(/[aeiou]/, -3)   # => 4

"abcd".insert(0, 'X')    # => "Xabcd"
"abcd".insert(3, 'X')    # => "abcXd"
"abcd".insert(4, 'X')    # => "abcdX"
"abcd".insert(-3, 'X')   # => "abXcd"
"abcd".insert(-1, 'X')   # => "abcdX"

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

# As a general rule, Ruby methods that end with ? evaluate to the boolean values true or false
if string_to_check.include? "substring"
	string_to_change.gsub!(/s/, "th")	# change every 's' to "th"
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

for num in 1...10	# => print 1-9
  puts num
end

for num in 1..10	# => print 1-10
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

3.times { print "hahaha\n" }	# print hahaha 3 times

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
_hash = {
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

# same as above 
colors = colors.sort_by { 
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

:sasquatch.to_s # => "sasquatch"
"sasquatch".to_sym # => :sasquatch
"hello".intern # => :hello

# .push method allows you to add an element to the end of an array!
numbers = [1, 2, 3, 4, 5, 6]
evens = []
numbers.each do |number|
  if number % 2 == 0
    evens.push(number)
  end
end
print evens # prints '[2, 4, 6]'

grades = { 
  alice: 100,
  bob: 92,
  chris: 95,
  dave: 97
}
grades.select { |name, grade| grade < 97 } # => { :bob=>92, :chris=>95 }
grades.select { |k, v| k == :alice } # => { :alice=>100 }

my_hash = { one: 1, two: 2, three: 3 }
my_hash.each_key { |k| print k } # => one two three
my_hash.each_value { |v| print v } # => 1 2 3

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

[1, 2, 3] << 4 # => [1, 2, 3, 4]
"Yukihiro " << "Matsumoto" # => "Yukihiro Matsumoto"

drink = "espresso"
age = 26
"I love " + drink   # => I love espresso
"I love " << drink  # => I love espresso
"I am " + age.to_s + " years old." # => "I am 26 years old."
"I am " << age.to_s << " years old." # => "I am 26 years old."
"I love #{drink}." # => I love espresso.
"I am #{age} years old." # => I am 26 years old.

return "n must be an integer." unless n.is_a? Integer

########################### Blocks, Procs, and Lambdas #############################
[1, 2, 3].each { |num| puts num }

my_nums = [1, 2, 3]
my_nums.collect { |num| num ** 2 } # => [1, 4, 9]
my_nums # => [1, 2, 3]
my_nums.collect! { |num| num ** 2 } # => [1, 4, 9]
my_nums # => [1, 4, 9]
# The .collect! and .map! methods do the exact same thing

def yield_name(name)
  puts "In the method! Let's yield."
  yield("Kim")
  puts "In between the yields!"
  yield(name)
  puts "Block complete! Back in the method."
end
yield_name("Eric") { |n| puts "My name is #{n}." }

=begin
=> In the method! Let's yield.
=> My name is Kim.
=> In between the yields!
=> My name is Eric.
=> Block complete! Back in the method.
=end

# The & is used to convert the cube proc into a block
cube = Proc.new { |x| x ** 3 }
[1, 2, 3].collect!(&cube)	# => [1, 8, 27]
[1, 2, 3].collect! { |x| x ** 3 }	# same as above!

# Why bother saving our blocks as procs? There are two main advantages:
# - Procs are full-fledged objects, so they have all the powers and abilities of objects. (Blocks do not.)
# - Unlike blocks, procs can be called over and over without rewriting them. This prevents you from having to retype the contents of your block every time you need to execute a particular bit of code.

# Unlike blocks, we can call procs directly by using Ruby's .call method
test = Proc.new { # does something }
test.call 	# does that something!

strings = ["1", "2", "3"]
nums = strings.map(&:to_i)	# => [1, 2, 3]

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
# =>
# I'm the method! 
# I'm the lambda!

def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" } # this will return
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
# Proc returns immediately, without going back to the batman_ironman_proc method.
# Our lambda, however, goes back into the method after being called, so the method returns the last code it evaluates: "Iron Man will win!"

:hello.is_a? Symbol # => true

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

# We can create class variables by starting a variable name with two @ symbols. Class variables are attached to entire classes, not just instances of classes, like a static method
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
puts "Number of Person instances: #{Person.number_of_instances}"	# => 2

# Global variables can be declared in two ways. The first is you just define the variable outside of any method or class. If you want to make a variable global from inside a method or class, just start it with a $
class MyClass
  $my_variable = "Hello!"
end
puts $my_variable

# inheritance
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

def name(value)
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


########################### Debug #############################
some_instance.pry   # this will lead to a termianl
method(:some_method).owner
method(:some_method).source_location


#----------------------------------------------------------------#
#----------------------------- More -----------------------------#
#----------------------------------------------------------------#
# ---------- Line Ending ---------- #
# Ruby interprets semicolons and newline characters as the ending of a statement. However, if Ruby encounters operators, such as +, −, or backslash at the end of a line, they indicate the continuation of a statement.

# ---------- Here Document ---------- #
# "Here Document" refers to build strings from multiple lines. Following a << you can specify a string or an identifier to terminate the string literal, and all lines following the current line up to the terminator are the value of the string. If the terminator is quoted, the type of quotes determines the type of the line-oriented string literal.
print <<EOF
   This is the first way of creating
   here document ie. multiple line string.
EOF

print <<"EOF";                # same as above
   This is the second way of creating
   here document ie. multiple line string.
EOF

print <<`EOC`                 # execute commands
  echo hi there
  echo lo there
EOC

print <<"foo", <<"bar"  # you can stack them
  I said foo.
foo
  I said bar.
bar
=begin
  ==>
  This is the first way of creating
  her document ie. multiple line string.
  This is the second way of creating
  her document ie. multiple line string.
  hi there
  lo there
  I said foo.
  I said bar.
=end

# ---------- BEGIN and END ---------- #
# print something as the beginning and end of the program
puts "This is main Ruby Program"
END {
   puts "Terminating Ruby Program"
}
BEGIN {
   puts "Initializing Ruby Program"
}

# ---------- variables ---------- #
=begin
There are 6 types of varaibles in Ruby:
- Local Variables: Local variables are the variables that are defined in a method. Local variables are not available outside the method. You will see more details about method in subsequent chapter. Local variables begin with a lowercase letter or _.

- Instance Variables: Instance variables are available across methods for any particular instance or object. That means that instance variables change from object to object. Instance variables are preceded by the at sign (@) followed by the variable name.

- Class Variables: Class variables are available across different objects. A class variable belongs to the class and is a characteristic of a class. They are preceded by the sign @@ and are followed by the variable name.

- Global Variables: Class variables are not available across classes. If you want to have a single variable, which is available across classes, you need to define a global variable. The global variables are always preceded by the dollar sign ($).

- Constants: Constants begin with an uppercase letter. Constants defined within a class or module can be accessed from within that class or module, and those defined outside a class or module can be accessed globally. Constants may not be defined within methods. Referencing an uninitialized constant produces an error.
=end

# Interger Numbers (class of Fixnum or Bignum)
123                  # Fixnum decimal
1_234                # Fixnum decimal with underline. Underline is automatically is ignored
-500                 # Negative Fixnum
0377                 # octal
0xff                 # hexadecimal
0b1011               # binary
?a                   # character code for 'a'
?\n                  # code for a newline (0x0a)
12345678901234567890 # Bignum

# Floating Numbers (class Float)
123.4                # floating point value
1.0e6                # scientific notation
4E20                 # dot not required
4e+20                # sign before exponential

# String Literals (class String)
puts "Multiplication Value : #{24*60*60}";  # inject expression in string

# Ranges
# 3 ways to create a range
range = 1..5   # (include end value)
range = 1...5  # (exclude end value)
range = Range.new


# ---------- operators ---------- #
# <=> is Combined comparison operator. Returns 0 if first operand equals second, 1 if first operand is greater than the second and -1 if first operand is less than the second. 

# .eql?() return true if the receiver and argument have both the same type and equal values. 
1 == 1.0      # => true
1.eql?(1.0)   # => false

# .equal?() return true if the receiver and argument have the same object id. 

# Parallel Assignment: multiple variables can be assigned together
a, b = b, a

# Bitwise Operators
& AND
| OR
^ XOR
~ Binary Ones Complement (flip bits)
<< Left Shift
>> Right Shift

# Logical Operators
and
or
&&
||
!
not

# Ternary Operator
# condition_true? x : y

# defined?() returns a description string of the expression, or nil if the expression isn't defined.
foo = 42
defined? foo    # => "local-variable"
defined? $_     # => "global-variable"
defined? bar    # => nil (undefined)

defined? puts        # => "method"
defined? puts(bar)   # => nil (bar is not defined here)
defined? unpack      # => nil (not defined here)

defined? super     # => "super" (if it can be called)
defined? super     # => nil (if it cannot be)

defined? yield    # => "yield" (if there is a block passed)
defined? yield    # => nil (if there is no block)

# Dot "." and Double Colon "::" Operators
=begin
You call a module method by preceding its name with the module's name and a period.
You reference a constant using the module name and two colons.

The :: is a unary operator that allows: constants, instance methods and class methods defined within a class or module, to be accessed from anywhere outside the class or module.

Remember in Ruby, classes and methods may be considered constants too.

You need to just prefix the :: Const_name with an expression that returns the appropriate class or module object.

If no prefix expression is used, the main Object class is used by default.
=end

# example 1
MR_COUNT = 0         # constant defined on main Object class
module Foo
   MR_COUNT = 0
   ::MR_COUNT = 1    # set global count to 1
   MR_COUNT = 2      # set local count to 2
end
puts MR_COUNT        # => 1
puts Foo::MR_COUNT   # => 2

# example 2
CONST = ' out'
class Inside_one
   CONST = proc {' in proc'}
   def where_is_my_CONST
      ::CONST + ' inside one'
   end
end
class Inside_two
   CONST = ' inside two'
   def where_is_my_CONST
      CONST
   end
end
puts Inside_one.new.where_is_my_CONST             # => out inside one
puts Inside_two.new.where_is_my_CONST             # => inside two
puts CONST                                        # => out
puts Object::CONST                                # => out
puts Inside_one::CONST                            # => #<Proc:0x00007ff85e817f28@(irb):3>
puts Inside_two::CONST                            # => inside two
puts Inside_one::CONST.call                       # => in proc


# ---------- Conditions ---------- #
# if statement without else
$debug = 1
print "debug\n" if $debug

# case statement
$age =  5
case $age
  when 0 .. 2
     puts "baby"
  when 3 .. 6
     puts "little child"
  when 7 .. 12
     puts "child"
  when 13 .. 18
     puts "youth"
  else
     puts "adult"
end

# ---------- Loops ---------- #
### while statement
$i = 0
$num = 5
while $i < $num  do
   puts("Inside the loop i = #$i" )
   $i +=1
end

# If a while modifier follows a begin statement with no rescue or ensure clauses, 
# code is executed once before conditional is evaluated
begin 
  # code
end while conditional


### until statement
until conditional [do]
  # code
end

# If an until modifier follows a begin statement with no rescue or ensure clauses
# code is executed once before conditional is evaluated.
begin
   # code
end until conditional


### for statement
for var1 [, var2 ...] in expression [do]
  # code
end

for i in 0..5
   puts "Value of local variable is #{i}"
end

# A for...in loop is almost exactly equivalent to the following, except that a for loop doesn't create a new scope for local variables. A for loop's expression is separated from code by the reserved word do, a newline, or a semicolon.
(expression).each do |variable[, variable...]| 
  # code 
end

(0..5).each do |i|
   puts "Value of local variable is #{i}"
end


### break statement
# Terminates the most internal loop. Terminates a method with an associated block if called within the block (with the method returning nil).


### next statement
# Jumps to the next iteration of the most internal loop. Terminates execution of a block if called within a block (with yield or call returning nil).


### redo statement
# Restarts this iteration of the most internal loop, without checking loop condition. Restarts yield or call if called within a block.


### retry statement
# If retry appears in rescue clause of begin expression, restart from the beginning of the begin body.
begin
  do_something # exception raised
rescue
  # handles error
  retry  # restart from beginning
end

# If retry appears in the iterator, the block, or the body of the for expression, restarts the invocation of the iterator call. Arguments to the iterator is re-evaluated.
# *** this one doesn't seem to work though
for i in 0..5
  retry if i > 2
  puts "Value of local variable is #{i}"
end



### 杂
# literal template
$global_variable = 10
puts "Global variable in Class2 is #$global_variable"



# ---------- Methods ---------- #
### define methods
def method_name 
   expr..
end

def method_name (var1, var2)
   expr..
end

### call methods
method_name         # without params
method_name 25, 30  # with params

### variable number of parameters
def sample (*test)
   puts "The number of parameters is #{test.length}"
   for i in 0...test.length
      puts "The parameters are #{test[i]}"
   end
end



# ---------- Blocks ---------- #
block_name {
   statement1
   statement2
   ..........
}

### invoke a block
# we can invoke a block from method using yield, which will look for the block with the same name as current function
def test
   puts "You are in the method"
   yield
   puts "You are again back to the method"
   yield
end
test { puts "You are in the block" }
=begin
  ==>
  You are in the method
  You are in the block
  You are again back to the method
  You are in the block
=end


### invoke a block with parameters
def test
   yield 5
   puts "You are in the method test"
   yield 100
end
test {|i| puts "You are in the block #{i}"}
=begin
  ==>
  You are in the block 5
  You are in the method test
  You are in the block 100
=end


## block and method
def test(&block)
   block.call
end
test { puts "Hello World!"}   # => Hello World!



# ---------- Modules ---------- #
module Math
   PI = 3.141592654
   def Math.sin(x)
    # ..
   end

end

### require a module
$LOAD_PATH << '.'   # If you do not want to use $LOAD_PATH then you can use require_relative to include files from a relative directory.
require 'math.rb'   # .rb is optional
y = Math.sin(Math::PI / 4)


### embed a module in a class
class Bitcoin
include POW
   def use_module
      puts POW::block_time
   end
end



# ---------- Strings ---------- #
### Expression Substitution
x, y = 12, 36
puts "The value of x is #{ x }."
puts "The sum of x and y is #{ x + y }."


### General Delimited Strings
%{Ruby is fun.}    # => "Ruby is fun."
%Q{ Ruby is fun. } # => " Ruby is fun. "
%q[Ruby is fun.]  # equivalent to a single-quoted string
%x!ls!            # equivalent to back tick command output `ls`


### Character Encoding
# The default character set for Ruby is ASCII, whose characters may be represented by single bytes. 
# If you use UTF-8, or another modern character set, characters may be represented in one to four bytes.
# change encoding:
$KCODE = 'u'


### String Built-in Methods
# ......



# ---------- Arrays ---------- #
# Ruby arrays can hold objects such as String, Integer, Fixnum, Hash, Symbol, even other Array objects. 
# Ruby arrays are not as rigid as arrays in other languages. 
# Ruby arrays grow automatically while adding elements to them.



# ---------- Hashes ---------- #
# A Hash is a collection of key-value pairs like this: "employee" = > "salary". It is similar to an Array, except that indexing is done via arbitrary keys of any object type, not an integer index.
months = Hash.new               # create a Hash
months = Hash.new( "month" )    # create a Hash with default value
H = Hash["a" => 100, "b" => 200]

# You can use any Ruby object as a key or value, even an array, so the following example is a valid one −
[1,"jan"] => "January"


### hash public api
# ......



# ---------- Date and Time ---------- #
# The Time class represents dates and times in Ruby
time1 = Time.new
time2 = Time.now    # does the same thing as above

puts "Current Time : " + time1.inspect  # => Current Time : Mon Jun 02 12:02:39 -0700 2008
puts "Current Time : " + time2.inspect  # => Current Time : Mon Jun 02 12:02:39 -0700 2008


### format date
Time.local(2008, 7, 8)          # => # July 8, 2008
Time.local(2008, 7, 8, 9, 10)   # => July 8, 2008, 09:10am, local time
Time.utc(2008, 7, 8, 9, 10)     # => July 8, 2008, 09:10 UTC
Time.gm(2008, 7, 8, 9, 10, 11)  # => July 8, 2008, 09:10:11 GMT (same as UTC)


### component of a Time
time = Time.new

puts time.year    # => Year of the date 
puts time.month   # => Month of the date (1 to 12)
puts time.day     # => Day of the date (1 to 31 )
puts time.wday    # => 0: Day of week: 0 is Sunday
puts time.yday    # => 365: Day of year
puts time.hour    # => 23: 24-hour clock
puts time.min     # => 59
puts time.sec     # => 59
puts time.usec    # => 999999: microseconds
puts time.zone    # => "UTC": timezone name

# format data using components
time = Time.new
values = time.to_a
p values  
# => [26, 10, 12, 2, 6, 2008, 1, 154, false, "MST"]
# represents [sec, min, hour, day, month, year, wday, yday, isdst, zone]
puts Time.utc(*values)  # => Mon Jun 02 12:15:36 UTC 2008


### time arithmetic
now = Time.now         # Current time
past = now - 10        # 10 seconds ago.  [Time - number => Time]
future = now + 10      # 10 seconds later [Time + number => Time]
diff = future - past   # => 10            [Time - Time => number of seconds]
puts diff              # => 20 



# ---------- Range ---------- #
(1..5)      # => 1, 2, 3, 4, 5
(1...5)     # => 1, 2, 3, 4
('a'..'d')  # => 'a', 'b', 'c', 'd'

# The sequence 1..100 is held as a Range object containing references to two Fixnum objects. We can convert a range to a list using the to_a method. 
range1 = (1..10).to_a         # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
range2 = ('bar'..'bat').to_a  # => ["bar", "bas", "bat"]


### Range built in methods
digits = 0..9

puts digits.include?(5)  # => true
puts digits.min          # 0
puts digits.max          # 9
puts digits.reject {|i| i < 5 }   # 5, 6, 7, 8, 9

digits.each do |digit|
   puts "In Loop #{digit}"
end


### ranges as conditions
# don't really understand... 
# prints sets of lines from the standard input, where the first line in each set contains the word start and the last line the word ends −
while gets
   print if /start/../end/
end

# range used in case statement
score = 70
result = case score
   when 0..40 then "Fail"
   when 41..60 then "Pass"
   when 61..70 then "Pass with Merit"
   when 71..100 then "Pass with Distinction"
   else "Invalid Score"
end
puts result

# range as intervals
# test if some value falls within the interval represented by the range. This is done using ===, the case equality operator.
if ((1..10) === 5)
   puts "5 lies in (1..10)"
end

if (('a'..'j') === 'c')
   puts "c lies in ('a'..'j')"
end

if (('a'..'j') === 'z')
   puts "z lies in ('a'..'j')"
end
=begin
  ==>
  5 lies in (1..10)
  c lies in ('a'..'j')  
=end



# ---------- Iterator ---------- #
# Iterators are nothing but methods supported by collections. Objects that store a group of data members are called collections. In Ruby, arrays and hashes can be termed collections. Iterators return all the elements of a collection, one after the other.
collection.each do |variable|
  # code
end

ary = [1, 2, 3, 4, 5]
ary.each do |i|
   puts i
end

### collect iterator
# The collect iterator returns all the elements of a collection.
a = [1, 2, 3, 4, 5]
b = Array.new
b = a.collect
puts b    # => 1 2 3 4 5
# Note: The collect method is not the right way to do copying between arrays. There is another method called a clone, which should be used to copy one array into another array.

# You normally use the collect method when you want to do something with each of the values to get the new array.
a = [1,2,3,4,5]
b = a.collect{|x| 10 * x}
puts b     # => 10 20 30 40 50



# ---------- IO ---------- #
# The class IO provides all the basic methods, such as read, write, gets, puts, readline, getc, and printf.

# The gets statement can be used to take any input from the user from standard screen called STDIN.
puts "Enter a value :"
val = gets
puts val

# putc statement can be used to output one character at a time.
str = "Hello Ruby!"
putc str    # => H

# print is similar to puts, but doesn't print new line
print "Hello World"
print "Good Morning"  
# => Hello WorldGood Morning

### file operations
file = File.new("filename", "mode")
   # ... process the file
file.close

# File.open method can be associated with a block, whereas you cannot do the same using the File.new method.
File.open("filename", "mode") do |aFile|
   # ... process the file
end

# readline
arr = IO.readlines("input.txt")
puts arr[0]
puts arr[1]

# The difference between the method foreach and the method readlines is that the method foreach is associated with a block
IO.foreach("input.txt"){ |block| puts block }

# rename and delete
File.rename( "test1.txt", "test2.txt" )
File.delete("test2.txt")

# chmod
file = File.new( "test.txt", "w" )
file.chmod( 0755 )

# test whether a file exists before opening it
File.open("file.rb") if File::exists?( "file.rb" )

# 杂
File.file?( "text.txt" )    
File::directory?( "/usr/local/bin" ) 
File.readable?( "test.txt" )   
File.writable?( "test.txt" )  
File.executable?( "test.txt" )
File.zero?( "test.txt" )  # if it is zero size

File.size?( "text.txt" )     # => 1002
File::ftype( "test.txt" )    # => file (filetype: oneof[file, directory, characterSpecial, blockSpecial, fifo, link, socket, or unknown])

# find when a file was created, modified, or last accessed
File::ctime( "test.txt" ) # => Fri May 09 10:06:37 -0700 2008
File::mtime( "text.txt" ) # => Fri May 09 10:44:44 -0700 2008
File::atime( "text.txt" ) # => Fri May 09 10:45:01 -0700 2008

### Dir class
Dir.chdir("/usr/bin")   # change directory
puts Dir.pwd            # return current dir

# get a list of the files and directories within a specific directory using Dir.entries −
puts Dir.entries("/usr/bin").join(' ')
# similar to above
Dir.foreach("/usr/bin") do |entry|
   puts entry
end
# similar to above
Dir["/usr/bin/*"]

Dir.mkdir("mynewdir")
Dir.mkdir( "mynewdir", 755 )
Dir.delete("testdir")

























$ rails new MySite	#  created a new Rails app named MySite
$ bundle install	# The bundle install command installed all the software packages needed by the new Rails app. These software packages are called gems and they are listed in the file Gemfile.
$ rails server	# started the Rails development server so that we could preview the app in the browser by visiting http://localhost:8000. This development server is called WEBrick

=begin
request/response cycle:
	- A user opens his browser, types in a URL, and presses Enter.
	- When a user presses Enter, the browser makes a request for that URL.
	- The request hits the Rails router (config/routes.rb). The router maps the URL to the correct controller and action to handle the request.
	- The action receives the request and passes it on to the view.
	- The view renders the page as HTML.
	- The controller sends the HTML back to the browser. The page loads and the user sees it.
=end

$ rails generate controller Pages 	# generated a new controller named Pages. This created a file app/controllers/pages_controller.rb
## app/controllers/pages_controller.rb 
class PagesController < ApplicationController
  def home
  end
end
## config/route.rb
Rails.application.routes.draw do
  get 'welcome' => 'pages#home'	# when a user visits http://localhost:8000/welcome, the route will tell Rails to send this request to the Pages controller's home action.
  root 'pages#home'				# http://localhost:8000 also request to the Pages controller's home action.
end
## app/views/pages/home.html.erb (this page will be rendered)
<div class="main">
  <div class="container">
    <h1>Hello my name is shun</h1>
    <p>I make Rails apps.</p>
  </div>
</div>

$ rails s -p 8080 -b 0.0.0.0 	# start a server listening on 8080

# app/views/layouts/application.html.erb is the layout file 

########## Database ##########
=begin
request/response cycle (with database):
	- A user opens his browser, types in a URL, and presses Enter. When a user presses Enter, the browser makes a request for that URL.
	- The request hits the Rails router (config/routes.rb).
	- The router maps the URL to the correct controller and action to handle the request.
	- The action receives the request, and asks the model to fetch data from the database.
	- The model returns a list of data to the controller action.
	- The controller action passes the data on to the view.
	- The view renders the page as HTML.
	- The controller sends the HTML back to the browser. The page loads and the user sees it.
=end

$ rails generate model Message  
=begin
this command created a new model named Message. In doing so, Rails created two files:
	- a model file in app/models/message.rb. The model represents a table in the database.
	- a migration file in db/migrate/. Migrations are a way to update the database. The name of the migration file starts with the timestamp of when it was created.
=end

## db/migrate/20170122224339_create_messages.rb
class CreateMessages < ActiveRecord::Migration
  def change	# The change method tells Rails what change to make to the database. 
    create_table :messages do |t|		# create a new table in the database for storing messages.
	  t.text :content			# create a text column called content in the messages tables.
      t.timestamps	# creates two more columns in the messages table called created_at and updated_at. These columns are automatically set when a message is created and updated.
    end
  end
end
$ rake db:migrate	# updates the database with the new messages data model.
$ rake db:seed		# seeds the database with sample data from db/seeds.rb.
## app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def index
    @messages = Message.all # retrieves all messages from the database and stores them in variable @messages
  end

  def new
	  @message = Message.new #  creates a new Message object @message and passes it on to the view in app/views/messages/new.html.erb.
  end
	
  def create 
  	@message = Message.new(message_params) 
  	if @message.save 
    	redirect_to '/messages' 
  	else 
    	render 'new' 
  	end 
  end
	
  private 
	def message_params 	# create action uses the message_params method to safely collect data from the form and update the database.
	    params.require(:message).permit(:content) 
	end

end
## app/views/messages/index.html.erb
<div class="container">
	<% @messages.each do |message| %> 
		<div class="message"> 
  			<p class="content"><%= message.content %></p> 
  			<p class="time"><%= message.created_at %></p> 
		</div> 
	<% end %>
	# a link goes here, see below
</div>
# we can use link_to to generate links,the first parameter is the link textthe second parameter is the URL
#　<%= link_to 'New Message', "messages/new" %>

=begin
The file index.html.erb is a web template. Web templates are HTML files that contain variables and control flow statements. 
Rather than write the same HTML over and over again for each message, we can use web templates to loop through and display data from the database.
The default web templating language in Rails is embedded Ruby, or ERB.
=end

## app/views/messages/new.html.erb
=begin
<div class="create">
  <div class="container">
   	<%= form_for(@message) do |f| %>  # In the view, form_for creates a form with the fields of the @message object.
  		<div class="field"> 
    		<%= f.label :message %><br> 	# POST request to the URL /messages ==> router maps to the create action.
    		<%= f.text_area :content %> 
  		</div> 
  		<div class="actions"> 
    		<%= f.submit "Create" %> 
  		</div> 
	<% end %>
  </div>
</div>
=end

## config/route
Rails.application.routes.draw do
	get '/messages' => 'messages#index'
	get '/messages/new' => 'messages#new'
	post 'messages' => 'messages#create'
end

########## Association ##########
$ rails generate model Tag
$ rails generate model Destination
# The has_many / belongs_to pair is frequently used to define one-to-many relationships
## app/models/tag.rb
class Tag < ActiveRecord::Base
  has_many :destinations	# denotes that a single Tag can have multiple Destinations.
end
## app/models/destination.rb
class Destination < ActiveRecord::Base
  belongs_to :tag 		# denotes that each Destination belongs to a single Tag.
end

## many-to-many relationiships
## app/models/movie.rb
class Movie < ActiveRecord::Base
	has_many :parts 
	has_many :actors, through: :parts
end
## app/models/actor.rb
class Actor < ActiveRecord::Base
	has_many :parts 
	has_many :movies, through: :parts
end
## app/models/part.rb
class Part < ActiveRecord::Base
	belongs_to :movie 
	belongs_to :actor
end

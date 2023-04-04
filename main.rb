class Pawn
	attr_accessor :x_coordinate, :y_coordinate, :facing, :color, :moved
  def initialize(x_coordinate, y_coordinate, facing, color)
  	if(x_coordinate.to_i >= 7 || x_coordinate.to_i < 0 || y_coordinate.to_i >= 7 || y_coordinate.to_i < 0)
  		puts "Cannot place the pawn here. Try again."
  	else
	    @x_coordinate = x_coordinate.to_i
	    @y_coordinate = y_coordinate.to_i
	    @facing = facing
	    @color = color
	    @moved = false
	  end
    self
  end

  def move(count)
  	case @facing
  		when 'north'
  			if @y_coordinate + count > 7
  				puts "Cannot move any higher."
  			else
  				@y_coordinate += count
  			end
  		when 'south'
  			if @y_coordinate - count < 0
  				puts "Cannot move any lower."
  			else
  				@y_coordinate -= count
  			end
  		when 'east'
  			if @x_coordinate + count > 8
  				puts "Cannot move any further."
  			else
  				@x_coordinate += count
  			end
  		when 'west'
  			if @x_coordinate - count < 0
  				puts "Cannot move any further."
  			else
  				@x_coordinate -= count
  			end
		end
	end

	def rotate(direction)
		directions = ["north", "east", "south", "west"]
		puts "Currently facing: "+@facing
		current_direction = directions.index(@facing)
		@facing = directions[current_direction+direction]
	  puts "Now facing: "+@facing
	end
end

placed = false
finished = false
accepted_commands = ["left", "right", "report", "exit"]
pawn=''
puts "Starting Pawn Simulator..."

while !finished
	puts "\nPlease enter a valid command: "
	command = gets
	command.downcase!
	command.strip!

	if !placed && !command.include?('place')
		puts "Place the pawn first..."
	elsif command.include?('place')
		puts "Placing the pawn..."
		command.gsub! 'place ', ''
		data = command.split(",")
		pawn = Pawn.new(data[0].strip!, data[1].strip!, data[2].strip!, data[3].strip!)
		placed = true
	elsif command.include?('move')
		move_limit = 2
		if pawn.moved
			move_limit = 1
		end
		data = command.split(" ")
		if !data[1]
			puts "Please include the number of moves"
		elsif(data[1].to_i > move_limit)
			puts "Cannot move more than "+move_limit.to_s+" square/s at a time."
		else
			pawn.move(data[1].to_i)
			pawn.moved = true
		end
	elsif accepted_commands.any? { command }
		case command
		when 'exit'
			finished = true
			puts "Ending simulation"
		when 'left'
			pawn.rotate(-1)
		when 'right'
			pawn.rotate(1)
		when command.include?('place')
			placed = true
		when 'report'
			puts pawn.x_coordinate.to_s+", "+ pawn.y_coordinate.to_s+", "+ pawn.facing+", "+ pawn.color
		end
	else
		puts "Invalid command. "
	end
end

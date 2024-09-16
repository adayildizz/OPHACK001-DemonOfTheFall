extends Walker
class_name WalkerType1



const ALL_DIRECTIONS = [
Vector2.RIGHT,
Vector2.LEFT,
Vector2.UP,
Vector2.DOWN,
Vector2.RIGHT + Vector2.UP,
Vector2.LEFT + Vector2.UP,
Vector2.LEFT + Vector2.DOWN,
Vector2.RIGHT + Vector2.DOWN
]

@export var size : int 
var borders : Rect2
var room_info = {}
#this is hypothetical
var available_cells = {}
#this is real occupation
var occupied_cells = []
var position :Vector2

func initialize(starting_position: Vector2, new_borders: Rect2):
	position = starting_position
	borders = new_borders
	initialize_avaliable_cells()
	
	
	
func create_rooms():
	var new_room_position = position
	for i in range(size):
		if available_cells.size() > 0:
			new_room_position = available_cells.keys()[randi()% available_cells.size()]
			occupied_cells.append_array(create_room(new_room_position))
	return occupied_cells
	

func create_room(location: Vector2):
	room_info[location] = true
	var subnum = (randi() % 3) + 2
	var room_cells = []
	print("subnum: ", subnum)
	#mark_occupied(location)
	for i in range(subnum):
		var new_location = shift_center(location)
		print("location", new_location)
		var width = randi()%room_variance+min_room_width
		var height = randi()%room_variance + min_room_height
		var size = Vector2(width, height)
		print("Size", size)
		var top_left_corner = (new_location - size/2).ceil()
		room_cells.append_array(create_subroom(top_left_corner, size))
	
	return room_cells
		
func shift_center(center):
	var new_center = center + ALL_DIRECTIONS[randi()%ALL_DIRECTIONS.size()]
	return new_center
	
func create_subroom(top_left_corner, size):
	var subroom_cells = []
	for i in range(size.x):
		for j in range(size.y):
			var new_cell = top_left_corner + Vector2(i, j)
			if borders.has_point(new_cell):
				available_cells[new_cell] = false
				subroom_cells.append(new_cell)
	return subroom_cells



func initialize_avaliable_cells():
	for x in range(borders.position.x, borders.position.x + borders.size.x):
		for y in range(borders.position.y, borders.position.y + borders.size.y):
			available_cells[Vector2(x, y)] = true
	


func create_halls():
	var room_positions = room_info.keys()

	for i in range(room_positions.size()):
		for j in range(i + 1, room_positions.size()):
			var from = room_positions[i]
			var to = room_positions[j]
			if (from - to).length() <= max_hall_length:
				occupied_cells.append_array(create_hall(from, to))


func walk():
	occupied_cells = []
	create_rooms()
	#create_halls()
	
	return occupied_cells

func create_hall(from : Vector2, to : Vector2):
	var hall_cells = []
	
	# Create horizontal part of the hall
	var step_x = 1 if from.x <= to.x else -1
	for i in range(from.x, to.x + step_x, step_x):
		var cell = Vector2(i, from.y)
		if available_cells[cell] == true:
			available_cells[cell] = false
			hall_cells.append(cell)
	
	# Create vertical part of the hall
	var step_y = 1 if from.y <= to.y else -1
	for j in range(from.y, to.y + step_y, step_y):
		var cell = Vector2(to.x, j)
		if available_cells[cell] == true:
			available_cells[cell] = false
			hall_cells.append(cell)

	return hall_cells



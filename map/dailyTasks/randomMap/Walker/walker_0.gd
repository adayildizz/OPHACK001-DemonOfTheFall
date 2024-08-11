extends Walker
class_name WalkerType0

const DIRECTIONS = [
Vector2.RIGHT,
Vector2.LEFT,
Vector2.UP,
]

@export var size : int 
var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var steps_since_turn = 0
var rooms = []


func initialize(starting_position: Vector2, new_borders: Rect2):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders


func walk():
	var steps = size*40
	create_room(position)
	for step in steps:
		#if randf() <= 0.50 and steps_since_turn >= 4:
		if steps_since_turn >= max_hall_length:
			change_direction()
		
		if step():
			step_history.append(position)
		else:
			change_direction()
		
	return step_history
	
func step():
	var target_position = position + direction
	if(borders.has_point(target_position)):
		steps_since_turn += 1
		position = target_position
		return true
	return false
		
func change_direction():
	create_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position+direction):
		direction = directions.pop_front()
	
func room_info(position, size):
	return {position = position, size = size}
	
func create_room(position):
	var size = Vector2(randi() % room_variance + min_room_width, randi() % room_variance + min_room_height)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(room_info(position, size))
	
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)
	


	

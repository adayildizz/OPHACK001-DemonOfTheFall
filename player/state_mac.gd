extends Node

@export
var starting_state: P_state
@export
var current_state: P_state

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(player: Player) -> void:
	for child in get_children():
		child.player = player

	
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: P_state) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	

func process_physics(delta: float, input: Vector2) -> void:
	#print(current_state)
	var new_state = current_state.process_physics(delta, input)
	if new_state:
		change_state(new_state)

func get_current_state():
	return current_state

extends Node2D

var input_active : bool = false
@onready var knob = $Knob

@export var max_length : float 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _input(event):
	
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			print("classical")
			_handle_input(event.position)
	elif event is InputEventScreenDrag or event is InputEventMouseMotion:
		if input_active:
			print("what the hell")
			_reset_handle()
	elif event is InputEventScreenTouch or event is InputEventMouseButton:
		if not event.pressed:
			print("resetting")
			
			
			
func _handle_input(event_position : Vector2):
	var position_vector = event_position - position
	if position_vector.length() > max_length:
		knob.position = position_vector.normalized() * max_length
	else: 
		knob.position = position_vector
		
	input_active = true


func _reset_handle():
	input_active = false
	knob.position = position

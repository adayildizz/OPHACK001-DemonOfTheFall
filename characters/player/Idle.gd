extends State_0

@export
var run_state:State_0
@export
var die_state: State_0
@onready var timer = $"../../Timer"
var state_name = "idle"
@onready var animator = $"../../AnimatedSprite2D"

@export var actor : CharacterBody2D

func enter() -> void:
	pass

	

func process_physics(delta: float,input: Vector2) -> State_0:
		
	if input != Vector2.ZERO:
		return run_state
	return null

func exit() -> void:
	pass



	

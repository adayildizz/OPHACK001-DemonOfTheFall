extends State_0
@onready var timer = $"../../Timer"

@export
var idle_state: State_0
@export
var die_state: State_0

var state_name = "move"

@export var actor : CharacterBody2D
@onready var animator = $"../../AnimatedSprite2D"

func enter() -> void:
	pass
	

func process_physics(delta: float, input: Vector2) -> State_0:
	actor.velocity = input * actor.MAX_SPEED
	
	if actor.velocity == Vector2.ZERO:
		return idle_state
		
	return null
	

func exit() -> void:
	actor.animator.stop()


extends CharacterBody2D
class_name Enemy0

@export var victim : CharacterBody2D
@onready var animator = $AnimatedSprite2D

@onready var fsm = $FiniteStateMachine
@onready var chase_state_0 = $FiniteStateMachine/ChaseState0
@onready var wander_state_0 = $FiniteStateMachine/WanderState0
@onready var attack_state_0 = $FiniteStateMachine/AttackState0

signal born_now
signal simply_die

# Called when the node enters the scene tree for the first time.
func _ready():
	wander_state_0.back_to_chase.connect(fsm.change_state.bind(chase_state_0))
	
	chase_state_0.back_to_wander.connect(fsm.change_state.bind(wander_state_0))
	chase_state_0.back_to_attack.connect(fsm.change_state.bind(attack_state_0))
	
	attack_state_0.back_to_chase.connect(fsm.change_state.bind(chase_state_0))
	
	
func set_inner_map(scene_map):
	var pathfind : PathFindComponent = find_child("PathFindComponent")
	pathfind.the_map = scene_map
	
	
func set_victim(the_victim: CharacterBody2D):
	victim = the_victim
	
	
func _physics_process(delta):
	if velocity.x >= 0:
		animator.flip_h = false
	else:
		animator.flip_h = true



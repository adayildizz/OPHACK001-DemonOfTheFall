extends CharacterBody2D
class_name Soul

#here is the child components
@onready var animator = $AnimatedSprite2D
@onready var health_component = $HealthComponent

#the fsm states
@onready var fsm = $FiniteStateMachine
@onready var soul_move_state = $FiniteStateMachine/SoulMoveState
@onready var soul_hurt_state = $FiniteStateMachine/SoulHurtState


@export var victim : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	soul_move_state.state_to_hurt.connect(fsm.change_state.bind(soul_hurt_state))
	soul_hurt_state.state_to_move.connect(fsm.change_state.bind(soul_move_state))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_victim(new_victim: CharacterBody2D):
	victim = new_victim

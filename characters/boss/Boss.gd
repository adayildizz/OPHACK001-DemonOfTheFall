extends CharacterBody2D
class_name Boss

@onready var fsm = $FiniteStateMachine
@onready var boss_attack = $FiniteStateMachine/BossAttack
@onready var boss_chase = $FiniteStateMachine/BossChase
@onready var health_component = $HealthComponent
@onready var animator = $AnimatedSprite2D

@export var victim : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	boss_attack.back_to_chase.connect(fsm.change_state.bind(boss_chase))
	boss_chase.back_to_attack.connect(fsm.change_state.bind(boss_attack))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_victim(new_victim: CharacterBody2D):
	print("boss set victim: ", new_victim)
	victim = new_victim



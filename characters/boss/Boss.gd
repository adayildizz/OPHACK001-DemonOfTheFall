extends CharacterBody2D

@onready var fsm = $FiniteStateMachine
@onready var boss_attack = $FiniteStateMachine/Attack
@onready var boss_chase = $FiniteStateMachine/BossChase

@export var victim : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	boss_attack.back_to_chase.connect(fsm.change_state(boss_chase))
	boss_chase.back_to_attack.connect(fsm.change_state(boss_attack))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_victim(new_victim: CharacterBody2D):
	victim = new_victim

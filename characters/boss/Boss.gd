extends CharacterBody2D
class_name Boss
signal attacked 
@onready var fsm = $FiniteStateMachine
@onready var boss_attack = $FiniteStateMachine/BossAttack
@onready var boss_chase = $FiniteStateMachine/BossChase
@onready var health_component = $HealthComponent
@onready var animator = $AnimatedSprite2D
@onready var boss_hurt = $FiniteStateMachine/BossHurt

@onready var hit_flash = $HitFlash
@onready var boss_dash = $FiniteStateMachine/BossDash
@onready var boss_idle = $FiniteStateMachine/BossIdle
@onready var audio = $AudioStreamPlayer2D

@export var victim : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	boss_idle.back_to_chase.connect(fsm.change_state.bind(boss_chase))
	boss_chase.back_to_attack.connect(fsm.change_state.bind(boss_attack))
	
	boss_attack.back_to_chase.connect(fsm.change_state.bind(boss_chase))
	
	health_component.health_changed.connect(fsm.change_state.bind(boss_hurt))
	boss_hurt.back_to_chase.connect(fsm.change_state.bind(boss_chase))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func set_victim(new_victim: CharacterBody2D):
	print("boss set victim: ", new_victim)
	victim = new_victim

func get_victims_relative_position():
	return to_local(victim.position - position)
	
	


func _on_hit_flash_animation_finished(anim_name):
	hit_flash.stop()


func _on_hitbox_component_body_entered(body):
	if fsm.state == boss_attack:
		attacked.emit()
		audio.play()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_scene_file_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"current_health" : health_component.health_remaining,
		"victim": victim
		#"last_attack" : last_attack
	}
	return save_dict

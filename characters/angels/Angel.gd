extends CharacterBody2D
class_name Angel

@onready var velocity_component = $VelocityComponent
@onready var path_find_component = $PathFindComponent
@onready var health_component = $HealthComponent
@onready var hit_flash = $HitFlash

@onready var animator = $AnimatedSprite2D
@onready var vision_cast = $VisionCast
@onready var fire_point = $FirePoint

signal saw_player
signal lost_player

#states
@onready var temp = $FiniteStateMachine/Temp
@onready var wander = $FiniteStateMachine/Wander
@onready var attack = $FiniteStateMachine/Attack
@onready var fsm = $FiniteStateMachine


var victim : Player
var last_vision : bool

func _ready():
	vision_cast.collide_with_bodies = true
	saw_player.connect(fsm.change_state.bind(attack))
	lost_player.connect(fsm.change_state.bind(wander))



func _physics_process(delta):
	if victim:
		vision_cast.target_position = to_local(victim.position)
		check_visioncast()
	fsm.state._physics_process(delta)
		
	
	

func set_victim(player: Player):
	if player:
		victim = player
	else:
		print("Cannot set Angel's victim as player. Player is not instantiated yet.")



	
func is_seeing_player():
	if vision_cast.is_colliding():
		var collider = vision_cast.get_collider()
		if collider == victim:
			return true
		return false
	return false
		
	
func check_visioncast():

	if (last_vision == false) and is_seeing_player():
		saw_player.emit()
		
	
	if (last_vision == true) and !is_seeing_player():
		
		lost_player.emit()
	
	last_vision = is_seeing_player()
	
	
func _on_hit_flash_animation_finished(anim_name):
	hit_flash.stop()

	

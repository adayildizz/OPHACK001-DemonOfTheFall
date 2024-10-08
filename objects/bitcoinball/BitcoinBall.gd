extends Area2D

@export var speed : float
var direction : Vector2

var actor: CharacterBody2D
@onready var animator = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D

@export var damage_rate : float

func _ready():
	set_actor()
	direction = (actor.vision_cast.target_position - position).normalized()
	audio.play()
	
func _process(delta):
	position += direction * speed * delta

func _physics_process(delta):
	#animator.play("temp")
	await get_tree().create_timer(3).timeout
	set_physics_process(false)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	#if it hit to the player
	if body.is_in_group("player"):
		#check player current state
		if body.attack_timer.is_stopped():
			body.health_component.take_damage(damage_rate)
	
	queue_free()

func set_actor():
	#We instantiate bitcoinballs within a container.
	actor = get_parent().get_parent()

extends Area2D

@export var speed : float
var direction : Vector2
var SampleScene = preload("res://map/sample/Sample.tscn")
var actor: CharacterBody2D
@onready var animator = $AnimatedSprite2D

@export var damage_rate : float

func _ready():
	set_actor()
	direction = (actor.vision_cast.target_position - position).normalized()
	
func _process(delta):
	position += direction * speed * delta

func _physics_process(delta):
	#animator.play("temp")
	await get_tree().create_timer(3).timeout
	set_physics_process(false)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.health_component.take_damage(damage_rate)
	else:
		queue_free()

func set_actor():
	#We instantiate bitcoinballs within a container.
	actor = get_parent().get_parent()

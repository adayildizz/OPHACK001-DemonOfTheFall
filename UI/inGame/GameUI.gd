extends CanvasLayer
class_name GameUI
@onready var player_healthbar = $TextureProgressBar
var actor: CharacterBody2D

func _ready():
	SceneManager.level_changed.connect(_on_level_changed)
	

func update():
	player_healthbar.value = (actor.health_component.health_remaining / actor.health_component.max_health)* 100 



func _on_health_changed():
	update()

func set_actor():
	actor = get_parent().find_child("Player")

func _on_level_changed():
	set_actor()
	actor.health_component.health_changed.connect(_on_health_changed)
	update()

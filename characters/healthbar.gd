extends TextureProgressBar

@export var actor: CharacterBody2D


func _ready():
	actor.health_component.health_changed.connect(_on_health_changed)
	update()

func update():
	value = (actor.health_component.health_remaining / actor.health_component.max_health)* 100 
	print(value)


func _on_health_changed():
	update()

extends TextureProgressBar

@export var actor: CharacterBody2D
@export var health_component : HealthComponent
"actor"
func _ready():
	
	health_component.health_changed.connect(_on_health_changed)
	update()

func update():
	value = (health_component.health_remaining / health_component.max_health)* 100 
	print(value)


func _on_health_changed():
	update()

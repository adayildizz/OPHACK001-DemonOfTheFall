extends CanvasLayer
class_name GameUI
@onready var player_healthbar = $TextureProgressBar
@onready var transition = $Transition
@onready var quit_button = $MarginContainer/HBoxContainer/QuitButton
@export var main_menu_path : String 

@export var exit_door : ExitDoor
@export var next_level_path : String

signal create_new_environment

var actor: CharacterBody2D

func _ready():
	transition.play("fade_in")
	exit_door.change_level_request.connect(_on_change_level_request)
	

func update():
	
	player_healthbar.value = (actor.health_component.health_remaining / actor.health_component.max_health)* 100 
	print(player_healthbar.value)


func _on_health_changed():
	update()

func set_actor(new_actor):
	actor = new_actor
	print("Handle Game UI... Actor is null obviously: ",actor)
	actor.health_component.health_changed.connect(_on_health_changed)
	update()
	

	

func _on_quit_button_button_down():
	Save.save_game(Save.game_number)
	SceneManager.change_scene(main_menu_path)


func _on_change_level_request():
	transition.play("fade_out")
	
			


func _on_transition_animation_finished(anim_name):
	if anim_name == "fade_out":
		create_new_environment.emit()

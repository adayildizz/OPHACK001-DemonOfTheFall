extends CanvasLayer
class_name GameUI
@onready var player_healthbar = $TextureProgressBar
@onready var transition = $Transition
@onready var quit_button = $MarginContainer/HBoxContainer/QuitButton
@export var main_menu_path : String 

var actor: CharacterBody2D

func _ready():
	transition.play("fade_in")
	set_actor()

func update():
	player_healthbar.value = (actor.health_component.health_remaining / actor.health_component.max_health)* 100 



func _on_health_changed():
	update()

func set_actor():
	actor = get_parent().find_child("Player")
	print("HERE IS OUR ACTOR",actor)

func _on_level_changed():
	set_actor()
	actor.health_component.health_changed.connect(_on_health_changed)
	update()


func _on_quit_button_button_down():
	Save.save_game(Save.game_number)
	SceneManager.change_scene(main_menu_path)

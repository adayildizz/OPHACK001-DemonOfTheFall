extends CanvasLayer
class_name GameUI
@onready var in_game_container = $InGameMenu/InGameContainer
@onready var settings_container = $InGameMenu/SettingsContainer
@onready var color_rect = $InGameMenu/ColorRect2
@onready var audio2 = $AudioStreamPlayer2D2

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

@onready var player_healthbar = $TextureProgressBar
@onready var transition = $Transition
@onready var quit_button = $MarginContainer/HBoxContainer/QuitButton
@export var main_menu_path : String 
@onready var label = $InGameMenu/InGameContainer/Label

@export var exit_door : ExitDoor
@export var next_level_path : String

signal create_new_environment

var actor: CharacterBody2D

func _ready():
	SceneManager.coin_changed.connect(on_coin_changed)
	in_game_container.visible = true
	settings_container.visible = false
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
	settings_container.visible = true
	in_game_container.visible = false
	color_rect.visible = true


func _on_change_level_request():
	transition.play("fade_out")
	
			


func _on_transition_animation_finished(anim_name):
	if anim_name == "fade_out":
		create_new_environment.emit()


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)


func _on_return_button_button_down():
	in_game_container.visible = true
	settings_container.visible = false
	color_rect.visible = false


func _on_save_and_quit_button_button_down():
	print("Count is here: ")
	if SceneManager.is_new_game:
		SceneManager.save_and_quit_game(Save.game_count)
	else:
		SceneManager.save_and_quit_game(Save.game_number)
	


func _on_quit_wo_save_button_button_down():
	SceneManager.quit_without_saving_game()


func on_coin_changed():
	label.text = str(SceneManager.coin_count)
	audio2.play()

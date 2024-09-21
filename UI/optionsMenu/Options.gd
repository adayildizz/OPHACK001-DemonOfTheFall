extends Control

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

@export var starting_level_path : String
@export var main_menu : String

func _on_geto_button_button_down():
	SceneManager.player_mood = "geto"
	


func _on_rika_button_button_down():
	SceneManager.player_mood = "rika"
	


func _on_new_game_button_button_down():
	#start from the very first level
	SceneManager.change_scene(starting_level_path)
	#a new game with new levels
	SceneManager.is_new_game = true
	SceneManager.is_new_level = true


func _on_back_button_button_down():
	SceneManager.change_scene(main_menu)


func _on_music_slider_value_changed(value):
	
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

extends Control



@onready var new_game_button = $MarginContainer/VBoxContainer/ButtonsVBox/NewGameButton
@onready var continue_button = $MarginContainer/VBoxContainer/ButtonsVBox/ContinueButton
@onready var back_button = $MarginContainer/VBoxContainer/ButtonsVBox/BackButton

@onready var saved_games = $MarginContainer/VBoxContainer/SavedGamesContainer/ScrollContainer/SavedGames

@export var main_menu : String
@export var start_level : String

func _ready():
	new_game_button.grab_focus()
	get_saved_games()

func _on_new_game_button_button_down():
	SceneManager.change_scene(start_level)
	SceneManager.is_new_game = true

func _on_continue_button_button_down():
	SceneManager.is_new_game = false
	SceneManager.start_saved_game(Save.game_number)
	if not Save.game_number:
		pass
	

func _on_back_button_button_down():
	SceneManager.change_scene(main_menu)


func get_saved_games():
	var file_list = Save.get_games()
	var counter = 0
	for file in file_list:
		
		var button = Button.new()
		button.button_down.connect(_on_button_down.bind(counter))
		button.text = "Game {count}".format({"count": counter + 1})
		counter += 1
		saved_games.add_child(button)
		

func _on_button_down(new_game_number):
	Save.game_number = new_game_number
	

extends StaticBody2D
@onready var orange_1 = $orange1
@onready var green_1 = $green1
@onready var orange_2 = $orange2
@onready var green_2 = $green2


var green_sprites = [
	"green1",
	"green2",
	
]
var orange_sprites = [
	"orange1",
	"orange2"
]
func _ready():
	pass

func choose_type(theme):
	var sprites 
	if theme == 1:
		print("what is theme")
		sprites = green_sprites
		print(sprites)
	else:
		sprites = orange_sprites
		
	var type = sprites[randi() % sprites.size()]
	for sprite in sprites:
		print(sprite, "SPRITE")
		if sprite == type:
			find_child(sprite).visible = true

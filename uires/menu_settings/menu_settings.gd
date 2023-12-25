extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	preload("res://scenes/test_scene.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Options/ButtonShadows.pressed == true):
		pass
	
	if ($Options/ButtonDustEffects.pressed == true):
		pass

	if ($ButtonBack.pressed == true):
		get_tree().change_scene("res://uires/menu_main/menu_main.tscn")
	
	if ($ButtonConfirm.pressed == true):
		pass

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
	if ($Options/ButtonOff.pressed == true):
		Settings.opt_dust_effects = 0
		Settings.opt_shadows = 0
	
	if ($Options/ButtonLow.pressed == true):
		Settings.opt_dust_effects = 1
		Settings.opt_shadows = 1
	
	if ($Options/ButtonMedium.pressed == true):
		Settings.opt_dust_effects = 2
		Settings.opt_shadows = 2
	
	if ($Options/ButtonHigh.pressed == true):
		Settings.opt_dust_effects = 3
		Settings.opt_shadows = 3
	
	if ($ButtonBack.pressed == true):
		get_tree().change_scene("res://uires/menu_main/menu_main.tscn")
	
	if ($ButtonConfirm.pressed == true):
		pass

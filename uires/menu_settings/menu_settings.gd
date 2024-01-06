extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.load_data()
	
	# Push in dust effect button corresponding to setting on load
	if Settings.opt_dust_effects == 0:
		$Panes/OptionsDust/ButtonOff.pressed = true
	if Settings.opt_dust_effects == 1:
		$Panes/OptionsDust/ButtonLow.pressed = true
	if Settings.opt_dust_effects == 2:
		$Panes/OptionsDust/ButtonMedium.pressed = true
	if Settings.opt_dust_effects == 3:
		$Panes/OptionsDust/ButtonHigh.pressed = true
	
	if Settings.opt_shadows == 0:
		$Panes/OptionsShadows/ButtonOff.pressed = true
	if Settings.opt_shadows == 1:
		$Panes/OptionsShadows/ButtonLow.pressed = true
	if Settings.opt_shadows == 2:
		$Panes/OptionsShadows/ButtonMedium.pressed = true
	if Settings.opt_shadows == 3:
		$Panes/OptionsShadows/ButtonHigh.pressed = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Panes/OptionsDust/ButtonOff.pressed == true):
		Settings.opt_dust_effects = 0
	if ($Panes/OptionsDust/ButtonLow.pressed == true):
		Settings.opt_dust_effects = 1
	if ($Panes/OptionsDust/ButtonMedium.pressed == true):
		Settings.opt_dust_effects = 2
	if ($Panes/OptionsDust/ButtonHigh.pressed == true):
		Settings.opt_dust_effects = 3
	
	if ($Panes/OptionsShadows/ButtonOff.pressed == true):
		Settings.opt_shadows = 0
	if ($Panes/OptionsShadows/ButtonLow.pressed == true):
		Settings.opt_shadows = 1
	if ($Panes/OptionsShadows/ButtonMedium.pressed == true):
		Settings.opt_shadows = 2
	if ($Panes/OptionsShadows/ButtonHigh.pressed == true):
		Settings.opt_shadows = 3

	if ($ButtonBack.pressed == true):
		get_tree().change_scene("res://uires/menu_main/menu_main.tscn")
	
	if ($ButtonSave.pressed == true):
		Settings.save_data()

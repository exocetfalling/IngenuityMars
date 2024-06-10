extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.load_data()
	
	# Push in button corresponding to setting on load
	if Settings.opt_dust_effects == 0:
		$Panes/Dust/ButtonOff.pressed = true
	if Settings.opt_dust_effects == 1:
		$Panes/Dust/ButtonLow.pressed = true
	if Settings.opt_dust_effects == 2:
		$Panes/Dust/ButtonMedium.pressed = true
	if Settings.opt_dust_effects == 3:
		$Panes/Dust/ButtonHigh.pressed = true
	
	if Settings.opt_shadows == 0:
		$Panes/Shadows/ButtonOff.pressed = true
	if Settings.opt_shadows == 1:
		$Panes/Shadows/ButtonLow.pressed = true
	if Settings.opt_shadows == 2:
		$Panes/Shadows/ButtonMedium.pressed = true
	if Settings.opt_shadows == 3:
		$Panes/Shadows/ButtonHigh.pressed = true
	
	if Settings.opt_rotor_sounds == 0:
		$Panes/RotorSounds/ButtonOff.pressed = true
	if Settings.opt_rotor_sounds == 1:
		$Panes/RotorSounds/ButtonLow.pressed = true
	if Settings.opt_rotor_sounds == 2:
		$Panes/RotorSounds/ButtonMedium.pressed = true
	if Settings.opt_rotor_sounds == 3:
		$Panes/RotorSounds/ButtonHigh.pressed = true
	
	if Settings.opt_wind_sounds == 0:
		$Panes/WindSounds/ButtonOff.pressed = true
	if Settings.opt_wind_sounds == 1:
		$Panes/WindSounds/ButtonLow.pressed = true
	if Settings.opt_wind_sounds == 2:
		$Panes/WindSounds/ButtonMedium.pressed = true
	if Settings.opt_wind_sounds == 3:
		$Panes/WindSounds/ButtonHigh.pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Panes/Dust/ButtonOff.pressed == true):
		Settings.opt_dust_effects = 0
	if ($Panes/Dust/ButtonLow.pressed == true):
		Settings.opt_dust_effects = 1
	if ($Panes/Dust/ButtonMedium.pressed == true):
		Settings.opt_dust_effects = 2
	if ($Panes/Dust/ButtonHigh.pressed == true):
		Settings.opt_dust_effects = 3
	
	if ($Panes/Shadows/ButtonOff.pressed == true):
		Settings.opt_shadows = 0
	if ($Panes/Shadows/ButtonLow.pressed == true):
		Settings.opt_shadows = 1
	if ($Panes/Shadows/ButtonMedium.pressed == true):
		Settings.opt_shadows = 2
	if ($Panes/Shadows/ButtonHigh.pressed == true):
		Settings.opt_shadows = 3
	
	if ($Panes/RotorSounds/ButtonOff.pressed == true):
		Settings.opt_rotor_sounds = 0
	if ($Panes/RotorSounds/ButtonLow.pressed == true):
		Settings.opt_rotor_sounds = 1
	if ($Panes/RotorSounds/ButtonMedium.pressed == true):
		Settings.opt_rotor_sounds = 2
	if ($Panes/RotorSounds/ButtonHigh.pressed == true):
		Settings.opt_rotor_sounds = 3
	
	if ($Panes/WindSounds/ButtonOff.pressed == true):
		Settings.opt_wind_sounds = 0
	if ($Panes/WindSounds/ButtonLow.pressed == true):
		Settings.opt_wind_sounds = 1
	if ($Panes/WindSounds/ButtonMedium.pressed == true):
		Settings.opt_wind_sounds = 2
	if ($Panes/WindSounds/ButtonHigh.pressed == true):
		Settings.opt_wind_sounds = 3
	
	if ($ButtonBack.pressed == true):
		get_tree().change_scene("res://uires/menu_main/menu_main.tscn")
	
	if ($ButtonSave.pressed == true):
		Settings.save_data()

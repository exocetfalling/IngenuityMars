extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.load_data()
	
	# Set SpinBox values from settings on load
	$Options/DustEffects.value = Settings.opt_dust_effects
	$Options/Shadows.value = Settings.opt_shadows
	$Options/RotorSounds.value = Settings.opt_rotor_sounds
	$Options/WindSounds.value = Settings.opt_wind_sounds
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Set settings values from SpinBox at runtime
	Settings.opt_dust_effects = $Options/DustEffects.value
	Settings.opt_shadows = $Options/Shadows.value
	Settings.opt_rotor_sounds = $Options/RotorSounds.value
	Settings.opt_wind_sounds = $Options/WindSounds.value
	
	if $ButtonBack.pressed == true:
		get_tree().change_scene("res://uires/menu_main/menu_main.tscn")
	
	if $ButtonSave.pressed == true:
		Settings.save_data()

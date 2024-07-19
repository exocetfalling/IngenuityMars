extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Setting, 0-3
# 0 -> off
# 1 -> low
# 2 -> med
# 3 -> high
export var opt_shadows: int = 1
export var opt_dust_effects: int = 1
export var opt_rotor_sounds: int = 2
export var opt_wind_sounds: int = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	
#	DebugOverlay.stats.add_property(self, "opt_rotor_sounds", "")


func load_data():
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://settings.ini")

	# If the file didn't load, ignore it.
	if err != OK:
		return 0

	# Load data
	opt_dust_effects = config.get_value("graphics", "opt_dust_effects", 1)
	opt_shadows = config.get_value("graphics", "opt_shadows", 1)
	opt_rotor_sounds = config.get_value("sounds", "opt_rotor_sounds", 2)
	opt_wind_sounds = config.get_value("sounds", "opt_wind_sounds", 2)


func save_data():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("graphics", "opt_dust_effects", opt_dust_effects)
	config.set_value("graphics", "opt_shadows", opt_shadows)
	config.set_value("sounds", "opt_rotor_sounds", opt_rotor_sounds)
	config.set_value("sounds", "opt_wind_sounds", opt_wind_sounds)

	# Save it to a file (overwrite if already exists).
	config.save("user://settings.ini")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

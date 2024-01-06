extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Setting, 0-3
# 0 -> off
# 1 -> low
# 2 -> med
# 3 -> high
export var opt_shadows: int = 2
export var opt_dust_effects: int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()


func load_data():
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://settings.ini")

	# If the file didn't load, ignore it.
	if err != OK:
		return

	# Load data
	opt_dust_effects = config.get_value("graphics", "opt_dust_effects")
	opt_shadows = config.get_value("graphics", "opt_shadows")


func save_data():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("graphics", "opt_dust_effects", opt_dust_effects)
	config.set_value("graphics", "opt_shadows", opt_shadows)

	# Save it to a file (overwrite if already exists).
	config.save("user://settings.ini")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

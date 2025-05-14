extends GPUParticles3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fx_intensity: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set particle amounts
	if Settings.opt_dust_effects == 0:
		amount = 0
	if Settings.opt_dust_effects == 1:
		amount = 100
	if Settings.opt_dust_effects == 2:
		amount = 200
	if Settings.opt_dust_effects == 3:
		amount = 300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	amount_ratio = fx_intensity

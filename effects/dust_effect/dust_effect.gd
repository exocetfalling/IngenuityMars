extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fx_intensity: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set particle amounts
	if Settings.opt_dust_effects == 0:
		$Particles.amount = 0
	if Settings.opt_dust_effects == 1:
		$Particles.amount = 100
	if Settings.opt_dust_effects == 2:
		$Particles.amount = 200
	if Settings.opt_dust_effects == 3:
		$Particles.amount = 300


func calc_fx_intensity(vec_rcs_commands):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fx_intensity > 0:
		$Particles.scale = Vector3.ONE * fx_intensity
	else:
		$Particles.scale = Vector3.ONE * 0.000001

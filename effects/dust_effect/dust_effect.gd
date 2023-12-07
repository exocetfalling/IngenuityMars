extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fx_intensity: float = 0
var vec_result: Vector3 = Vector3.ZERO
export var rcs_vectors: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func calc_fx_intensity(vec_rcs_commands):
	vec_result = vec_rcs_commands * rcs_vectors
	fx_intensity = clamp((vec_result.x + vec_result.y + vec_result.z), 0, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fx_intensity > 0:
		$Particles.scale = Vector3.ONE * fx_intensity
	else:
		$Particles.scale = Vector3.ONE * 0.000001

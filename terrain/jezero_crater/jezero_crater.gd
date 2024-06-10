extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Settings.opt_shadows > 0:
		$Sun.shadow_enabled = true
		
		if Settings.opt_shadows == 1:
			$Sun.directional_shadow_mode = DirectionalLight.SHADOW_ORTHOGONAL
		if Settings.opt_shadows == 2:
			$Sun.directional_shadow_mode = DirectionalLight.SHADOW_PARALLEL_2_SPLITS
		if Settings.opt_shadows == 3:
			$Sun.directional_shadow_mode = DirectionalLight.SHADOW_PARALLEL_4_SPLITS
	
	else:
		$Sun.shadow_enabled = false

	if Settings.opt_wind_sounds > 0:
		$WindSounds.volume_db = 10 * log(Settings.opt_wind_sounds / 3) - 3
		$WindSounds.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

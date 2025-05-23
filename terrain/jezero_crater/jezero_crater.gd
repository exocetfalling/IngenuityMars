extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Shadows
	if Settings.opt_shadows == 0:
		$Sun.shadow_enabled = false
	if Settings.opt_shadows == 1:
		$Sun.shadow_enabled = true
	if Settings.opt_shadows == 2:
		$Sun.shadow_enabled = true
	if Settings.opt_shadows == 3:
		$Sun.shadow_enabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

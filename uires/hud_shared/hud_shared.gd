extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hud_visible : bool = true
var wpt_vector : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pause_handle():
	if (get_tree().paused == false):
		$MenuPause.visible = true
		get_tree().paused = true
	else:
		$MenuPause.visible = false
		get_tree().paused = false

func hud_visibility_handle():
	if hud_visible == true:
		hud_visible = false
		visible = false
		$UI.visible = false
	else:
		hud_visible = true
		visible = true
		$UI.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input(delta)
	
	$GaugeSPD.value_displayed = AeroDataBus.aircraft_spd_true
	$GaugeHDG.value_displayed = AeroDataBus.aircraft_hdg
	$GaugeALT.value_displayed = AeroDataBus.aircraft_alt_asl
	$GaugeVVT.value_displayed = AeroDataBus.aircraft_spd_vertical_tgt
	$GaugeVVI.value_displayed = AeroDataBus.aircraft_spd_vertical
	
	$Minimap/Centre.rotation_degrees = -AeroDataBus.aircraft_hdg
	$Minimap/Centre/FlightPath.points[1] = \
		5 * Vector2(AeroDataBus.aircraft_linear_velocity.x, AeroDataBus.aircraft_linear_velocity.z)
	
	wpt_vector = Vector2( \
		AeroDataBus.aircraft_nav_waypoint_data.x, \
		AeroDataBus.aircraft_nav_waypoint_data.z \
		)
	
	# Clamp and ghost symbol if outside map bounds
	if wpt_vector.length() <= 50:
		$Minimap/Centre/Waypoint.position = 1 * wpt_vector
		$Minimap/Centre/Waypoint.default_color = Color(1, 1, 1, 1)
	else:
		$Minimap/Centre/Waypoint.position = 50 * wpt_vector.normalized()
		$Minimap/Centre/Waypoint.default_color = Color(1, 1, 1, 0.1)
	
	if ($ButtonPause.pressed == true):
		pause_handle()

func get_input(delta):
	# Pause input
	if (Input.is_action_just_pressed("ui_cancel")):
		pause_handle()
	# UI visibility input (for screenshots)
	if (Input.is_action_just_pressed("hud_toggle")):
		hud_visibility_handle()

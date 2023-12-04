extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hud_visible : bool = true

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
	$GaugeALT.value_displayed = AeroDataBus.aircraft_alt_barometric
	$GaugeVVT.value_displayed = AeroDataBus.aircraft_spd_vertical_tgt
	$GaugeVVI.value_displayed = AeroDataBus.aircraft_spd_vertical
	
	if ($ButtonPause.pressed == true):
		pause_handle()

func get_input(delta):
	# Pause input
	if (Input.is_action_just_pressed("ui_cancel")):
		pause_handle()
	# UI visibility input (for screenshots)
	if (Input.is_action_just_pressed("hud_toggle")):
		hud_visibility_handle()

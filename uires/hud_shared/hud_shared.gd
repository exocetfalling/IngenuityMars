extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hud_visible: bool = true

@export var wpt_array: PackedVector3Array = [Vector3.ZERO]
var wpt_vector : Vector2 = Vector2.ZERO
var wpt_index: int = 0

var memo_duration: float = 0
var memo_active: bool = false


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


func update_cas_warnings():
	$MsgBlock/Warnings.text = ""
	
	if AeroDataBus.aircraft_battery_level <= 25:
		$MsgBlock/Warnings.text += "BATT LOW" + "\n"
	if AeroDataBus.aircraft_alt_agl >= 25:
		$MsgBlock/Warnings.text += "ABOVE MAX ALT" + "\n"


func set_cas_memos(message_array: PackedStringArray):
	memo_active = true
	
	$MsgBlock/Memos.text = ""
	
	for msg in message_array:
		$MsgBlock/Memos.text += msg + "\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input(delta)
	
	$GaugeSPD.value_displayed = AeroDataBus.aircraft_spd_true
	$GaugeBAT.value_displayed = AeroDataBus.aircraft_battery_level
	$GaugeALT.value_displayed = AeroDataBus.aircraft_alt_agl
	$GaugeVVT.value_displayed = AeroDataBus.aircraft_spd_vertical_tgt
	$GaugeVVI.value_displayed = AeroDataBus.aircraft_spd_vertical
	
	$Minimap/Centre.rotation_degrees = -AeroDataBus.aircraft_hdg
	$Minimap/Centre/FlightPath.points[1] = \
		5 * Vector2(AeroDataBus.aircraft_linear_velocity.x, AeroDataBus.aircraft_linear_velocity.z)
	
	wpt_vector = Vector2( \
		(wpt_array[wpt_index].x - AeroDataBus.aircraft_global_translation.x), \
		(wpt_array[wpt_index].z - AeroDataBus.aircraft_global_translation.z) \
		)
	
	# Clamp and ghost symbol if outside map bounds
	if wpt_vector.length() <= 50:
		$Minimap/Centre/Waypoint.position = 1 * wpt_vector
		$Minimap/Centre/Waypoint.default_color = Color(1, 1, 1, 1)
	else:
		$Minimap/Centre/Waypoint.position = 50 * wpt_vector.normalized()
		$Minimap/Centre/Waypoint.default_color = Color(1, 1, 1, 0.1)
	
	# If waypoint button pushed in
	# Enable increase/decrease buttons
	# Show waypoint symbol and number
	# Else, hide/disable
	if $ButtonWptDisp.button_pressed:
		$ButtonWptDec.disabled = false
		$ButtonWptInc.disabled = false
		$Minimap/Centre/Waypoint.visible = true
		$ButtonWptDisp.text = "WPT " + str("%02d" % [wpt_index + 1])
	else:
		$ButtonWptDec.disabled = true
		$ButtonWptInc.disabled = true
		$Minimap/Centre/Waypoint.visible = false
		$ButtonWptDisp.text = "WPT XX"
	
	# CAS warnings/memos
	update_cas_warnings()
	
	if memo_active:
		memo_duration += delta
		
		if memo_duration > 5:
			memo_active = false
			memo_duration = 0
			set_cas_memos([])


func get_input(delta):
	# Pause input
	if (Input.is_action_just_pressed("ui_cancel")):
		pause_handle()
	
	# UI visibility input (for screenshots)
	if (Input.is_action_just_pressed("hud_toggle")):
		hud_visibility_handle()

# Buttons
func _on_ButtonWptDec_button_pressed():
	if wpt_index > 0:
		wpt_index -= 1


func _on_ButtonWptInc_button_pressed():
	if wpt_index < len(wpt_array) - 1:
		wpt_index += 1


func _on_ButtonPause_button_pressed():
	pause_handle()


func _on_button_camera_pressed() -> void:
	print("Camera change requested. ")
	Input.action_press("camera_switch", 1.0)
	Input.action_release("camera_switch")

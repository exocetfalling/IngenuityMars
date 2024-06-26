extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var aircraft_active : bool = true
var aircraft_pitch : float = 0
var aircraft_roll : float = 0
var aircraft_alpha : float = 0
var aircraft_beta : float = 0
var aircraft_angle_inertial_y : float = 0
var aircraft_angle_inertial_x : float = 0
var aircraft_spd_indicated : float = 0
var aircraft_spd_true : float = 0
var aircraft_alt_asl : float = 0
var aircraft_alt_agl : float = 0
var aircraft_spd_vertical : float = 0
var aircraft_spd_vertical_tgt : float = 0
var aircraft_hdg : float = 0
var aircraft_flaps : float = 0
var aircraft_trim : float = 0
var aircraft_gear : float = 0
var aircraft_throttle : float = 0
var aircraft_ap : int = 0
var aircraft_cws : int = 0
var aircraft_MFD_mode : int = 0
var aircraft_nav_active : bool = false
var aircraft_nav_brg : int = 0
var aircraft_nav_range : int = 0
var aircraft_nav_waypoint : int = 0
var aircraft_nav_waypoint_data : Vector3 = Vector3.ZERO
var aircraft_cam_rotation_deg : Vector3 = Vector3.ZERO
var aircraft_cam_global_rotation_deg : Vector3 = Vector3.ZERO
var aircraft_linear_velocity : Vector3 = Vector3.ZERO
var aircraft_linear_velocity_local : Vector3 = Vector3.ZERO
var aircraft_global_translation : Vector3 = Vector3.ZERO
var aircraft_battery_level: float = 0


# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

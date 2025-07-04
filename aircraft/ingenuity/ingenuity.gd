extends AeroBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cmd_sas : Vector3 = Vector3.ZERO
@export var sas_mode : int = 2
var att_limit : float = 20 # Maximum angle from vertical permitted
var tgt_attitude : Vector2 = Vector2.ZERO # x for roll, y for pitch 

var rotation_target : Vector3 = Vector3.ZERO

var thrust_rated : float = 10
var thrust_current : float = 0

var output_throttle : float = 0

# Total lift force from both rotors
var rotor_lift_force : float = 0

# Uses RPM because the RL specs are in RPM
var rotor_rpm : float = 0
var rotor_rpm_tgt : float = 0
var rotor_rpm_range_min : float = 2400
var rotor_rpm_range_max : float = 2700

var rotor_angular_velocity : float = 0

# Blade pitch angles
var rotor_blade_angle : float = 0

# Rotor coefficient of lift
var rotor_cl : float = 0

var linear_velocity_target : Vector3 = Vector3.ZERO

var linear_velocity_rotated : Vector3 = Vector3.ZERO

var camera_mode : int = 0
var camera_mouse_delta = 0

var input_hold_time : float = 0
@export var rotor_active : bool = false

@export var battery_level: float = 100

var rotor_sound_vol: float = 1.0
#var adc_data: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity_wind = Vector3(0, 0, 0)
	
#	DebugOverlay.stats.add_property(self, "input_joystick", "round")
#	DebugOverlay.stats.add_property(self, "linear_velocity_local", "round")
#	DebugOverlay.stats.add_property(self, "angular_velocity_local", "round")
#	DebugOverlay.stats.add_property(self, "input_throttle", "")
#	DebugOverlay.stats.add_property(self, "output_throttle", "")
#	DebugOverlay.stats.add_property(self, "linear_velocity_target", "round")
#	DebugOverlay.stats.add_property(self, "air_temperature", "")
#	DebugOverlay.stats.add_property(self, "air_pressure", "")
#	DebugOverlay.stats.add_property(self, "air_density", "")
#	DebugOverlay.stats.add_property(self, "wpt_current", "")
#	DebugOverlay.stats.add_property(self, "adc_alt_agl", "round")
	#DebugOverlay.stats.add_property(self, "thrust_current", "round")
#	DebugOverlay.stats.add_property(self, "global_translation", "round")
#	DebugOverlay.stats.add_property(self, "adc_pitch", "round")
#	DebugOverlay.stats.add_property(self, "adc_roll", "round")
	pass # Replace with function body.
	
func calc_atmo_properties(height_metres):
	# Store atmospheric properties as Vector3
	# X value is air temperature, deg K
	# Y value is air pressure, Pa
	# Z value is air density, kg m^-3
	
	# From https://www.grc.nasa.gov/www/k-12/airplane/atmosmrm.html
	
	var atmo_properties : Vector3 = Vector3.ZERO
	
	if (height_metres <= 7000):
		atmo_properties.x = 242.15 - 0.000998 * height_metres
	if (height_metres > 7000):
		atmo_properties.x = 249.15 - 0.00222 * height_metres
	
	atmo_properties.y = 699 * pow(2.718281828, (-0.00009 * height_metres))
	atmo_properties.z = atmo_properties.x / (19.210 * atmo_properties.y)
	
	return atmo_properties


func velocity_y_map(altitude_agl, throttle_pos):
	var ALT_LOW: float = 3
	var ALT_MED: float = 10
	var ALT_HIGH: float = 15
	
	# If climbing, don't limit vertical speed
	if throttle_pos > 0:
		return throttle_pos * 3
	
	# Reduce vertical speed target when low down, for smoother landings
	else:
		if altitude_agl <= ALT_LOW:
			return throttle_pos * 0.5
		if altitude_agl > ALT_LOW and altitude_agl <= ALT_MED:
			return throttle_pos * 1
		if altitude_agl > ALT_MED and altitude_agl <= ALT_HIGH:
			return throttle_pos * 2
		if altitude_agl > ALT_HIGH:
			return throttle_pos * 3


func _calc_sound_volume(vol_float):
	return 10.0 * log(vol_float)


# Takes input and makes the result vector lie within a circle, not a square
# See https://web.archive.org/web/20240324115012/https://raw.org/article/how-to-map-a-square-to-a-circle/
func map_vector_square_to_circle(vector_square: Vector2):
	var vector_circle: Vector2 = Vector2.ZERO
	
	vector_circle.x = vector_square.x * sqrt(1 - pow(vector_square.y, 2) / 2)
	vector_circle.y = vector_square.y * sqrt(1 - pow(vector_square.x, 2) / 2)
	
	return vector_circle


# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta): 
	super(delta)
	
	if (control_type == 1):
		# Panel updates
		AeroDataBus.aircraft_pitch = adc_pitch
		AeroDataBus.aircraft_roll = adc_roll
		AeroDataBus.aircraft_alpha = adc_alpha
		AeroDataBus.aircraft_beta = adc_beta
		
		AeroDataBus.aircraft_angle_inertial_y = angle_inertial_y
		AeroDataBus.aircraft_angle_inertial_x = angle_inertial_x
		
		AeroDataBus.aircraft_spd_indicated = adc_spd_indicated
		AeroDataBus.aircraft_spd_true = adc_spd_true
		AeroDataBus.aircraft_alt_asl = adc_alt_asl
		AeroDataBus.aircraft_alt_agl = adc_alt_agl
		
		AeroDataBus.aircraft_hdg = adc_hdg
		AeroDataBus.aircraft_flaps = input_flaps
		AeroDataBus.aircraft_trim = output_elevator_trim
		AeroDataBus.aircraft_gear = gear_current
		AeroDataBus.aircraft_throttle = output_throttle
		AeroDataBus.aircraft_cws = autopilot_on
		AeroDataBus.aircraft_spd_vertical = linear_velocity.y
		AeroDataBus.aircraft_spd_vertical_tgt = linear_velocity_target.y
		
		AeroDataBus.aircraft_linear_velocity = linear_velocity
		AeroDataBus.aircraft_linear_velocity_local = linear_velocity_local
		AeroDataBus.aircraft_global_translation = global_position
		
		AeroDataBus.aircraft_battery_level = battery_level
		
#		adc_data["pitch"] = adc_pitch
#		adc_data["roll"] = adc_roll
#
	
	$RadioAltimeter.rotation_degrees.x = clamp(-adc_pitch, -30, +30)
	$RadioAltimeter.rotation_degrees.z = clamp(+adc_roll, -30, +30)
	
	
	if ($RadioAltimeter.is_colliding() == true):
		adc_alt_agl = (global_position - $RadioAltimeter.get_collision_point()).length()
	else:
		# Set value to show sensor is out of range
		adc_alt_agl = 9999
	
#		if (camera_mode == 0):
#			$Camera_FPV/FPV_HUD.visible = true
#		if (camera_mode == 1):
#			$Camera_FPV/FPV_HUD.visible = false
	
	calc_atmo_properties(global_transform.origin.y)
	
	tgt_rates.x = deg_to_rad(input_joystick.y * 10)
	tgt_rates.y = deg_to_rad(input_rudder * 90)
	tgt_rates.z = deg_to_rad(input_joystick.x * 10)
	
	linear_velocity_rotated = linear_velocity.rotated(Vector3.UP, -global_rotation.y)
	
	if output_throttle > 0.01:
		# Basic attitude mode
		if (sas_mode == 1):
			tgt_attitude.y = 20 * input_joystick.y
			tgt_attitude.x = 20 * input_joystick.x
		# Velocity referenced mode
		if (sas_mode == 2):
			tgt_attitude.y = $PIDCalcVelocityZ.calc_PID_output(\
				linear_velocity_target.z, \
				linear_velocity_rotated.z \
			)
			tgt_attitude.x = $PIDCalcVelocityX.calc_PID_output(\
					linear_velocity_target.x, \
					linear_velocity_rotated.x \
			)
		
		# Keep attitude within limits 
		if tgt_attitude.length() > att_limit:
			tgt_attitude = tgt_attitude.normalized() * att_limit
	
	
	linear_velocity_target.x = 10 * input_joystick.x
	linear_velocity_target.y = velocity_y_map(adc_alt_agl, input_throttle)
	linear_velocity_target.z = 10 * input_joystick.y
	
	cmd_sas.x = 1.0 * $PIDCalcPitch.calc_PID_output(tgt_attitude.y, adc_pitch)
	cmd_sas.y = 1.0 * $PIDCalcYaw.calc_PID_output(tgt_rates.y, -angular_velocity.y)
	cmd_sas.z = 1.0 * $PIDCalcRoll.calc_PID_output(tgt_attitude.x, adc_roll)
	
	# Rotor sounds
	rotor_sound_vol = pow(rotor_rpm / rotor_rpm_range_max, 2) * Settings.opt_rotor_sounds / 3
	$RotorSounds.volume_db = 10 * log(rotor_sound_vol)
	if not $RotorSounds.playing:
		$RotorSounds.play()
	
	# Rotor on/off
	if adc_alt_agl < 0.25:
		if input_throttle > 0.95:
			input_hold_time += delta
			
			if input_hold_time >= 1:
				input_hold_time = 0
				rotor_active = true
		
		if input_throttle < -0.95:
			input_hold_time += delta
			
			if input_hold_time >= 1:
				input_hold_time = 0
				rotor_active = false
	
	if rotor_active:
		output_throttle = clamp(\
			$PIDCalcVelocityY.calc_PID_output(\
				linear_velocity_target.y, \
				linear_velocity.y), \
			0, 1)
		rotor_rpm_tgt = 2500
	else:
		rotor_rpm_tgt = 0
		output_throttle = 0
	
	rotor_rpm = lerp(rotor_rpm, rotor_rpm_tgt, 0.05)
	rotor_angular_velocity = rotor_rpm * 0.10472
	rotor_blade_angle = PI / 12 * output_throttle
	rotor_cl = 1.2 * sin(3 * rotor_blade_angle)
	
	# thrust_current = thrust_rated * output_throttle * rotor_rpm / rotor_rpm_range_max
	thrust_current = 0.5 * air_density * pow((rotor_angular_velocity * 0.605), 2) * 0.1 * rotor_cl
	
	# Battery consumption
	if rotor_active:
		battery_level -= rotor_rpm / rotor_rpm_range_min * 0.9 * delta
	if battery_level < 0:
		rotor_active = false
	
	
	apply_force_local(Vector3(0, thrust_current, 0), Vector3.ZERO)
	
#		add_torque_local(20 * Vector3(input_joystick.y, -input_rudder, -input_joystick.x))
	apply_torque_local(Vector3(cmd_sas.x, -cmd_sas.y, -cmd_sas.z))
	
	# Basic drag
	apply_central_force(-0.1 * air_density * (linear_velocity + linear_velocity_wind).length_squared() * (linear_velocity + linear_velocity_wind).normalized())
	
	# Reset integral on ground
	if (adc_alt_agl < 0.25):
		$PIDCalcVelocityX.integral = 0
		$PIDCalcVelocityY.integral = 0
		$PIDCalcVelocityZ.integral = 0
	
	# Anims
	# Props
	if (rotor_rpm > 100):
		$Ingenuity_v3/bus/PropBlur01.visible = true
		$Ingenuity_v3/bus/PropBlur02.visible = true
		
	else:
		$Ingenuity_v3/bus/PropBlur01.visible = false
		$Ingenuity_v3/bus/PropBlur02.visible = false
		
	$Ingenuity_v3/bus/rotors_01.rotate_x(+rotor_angular_velocity * delta)
	$Ingenuity_v3/bus/rotors_02.rotate_x(-rotor_angular_velocity * delta)
	
	# Dust effects
	if Settings.opt_dust_effects > 0:
		$DustEffect.global_position = $DustRayCast.get_collision_point()
		$DustEffect.global_transform.basis = align_up(global_transform.basis, $DustRayCast.get_collision_normal())
		$DustEffect.fx_intensity = clamp(thrust_current / adc_alt_agl * 2, 0, 1)


func get_input(delta):
	super(delta)
	
	# Check if aircraft is under player control
	if (control_type == 1):
		# Throttle input
		input_throttle = Input.get_axis("throttle_down", "throttle_up")

		# Joystick input as axes
		input_joystick.x = Input.get_axis("roll_left", "roll_right")
		input_joystick.y = Input.get_axis("pitch_down", "pitch_up")
		
		# Circle the square input 
		input_joystick = map_vector_square_to_circle(input_joystick)
		
		# Yaw input
		input_rudder = Input.get_axis("yaw_left", "yaw_right")
	
	if Input.is_action_just_pressed("camera_switch"):
		if ($CameraExt.current == true):
			$CameraRTE.current = true
		elif ($CameraRTE.current == true):
			$CameraNAV.current = true
		elif ($CameraNAV.current == true):
			$CameraExt.current = true


func align_up(node_basis, normal):
	var result = Basis()
	var scale = node_basis.get_scale() # Only if your node might have a scale other than (1,1,1)

	result.x = normal.cross(node_basis.z)
	result.y = normal
	result.z = node_basis.x.cross(normal)

	result = result.orthonormalized()
	result.x *= scale.x 
	result.y *= scale.y 
	result.z *= scale.z 

	return result

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var start_pos: Vector3 = Vector3(0, 0, 0)
var mission_name: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	raise()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input(delta)
	pass


func get_input(delta):

	# Pause input
	if (Input.is_action_just_pressed("ui_cancel")):
		if (get_tree().paused == false):
			$MenuPause.visible = true
			get_tree().paused = true
		else:
			$MenuPause.visible = false
			get_tree().paused = false

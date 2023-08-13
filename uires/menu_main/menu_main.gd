extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Options/ButtonFreeFlight.pressed == true):
#		get_tree().change_scene("res://uires/menu_free_flight/menu_free_flight.tscn")
		get_tree().change_scene("res://scenes/test_scene.tscn")
	
	if($Options/ButtonTutorials.pressed == true):
		get_tree().change_scene("res://uires/menu_tutorials/menu_tutorials.tscn")
	
	if($Options/ButtonMissions.pressed == true):
		pass
	
	if($Options/ButtonCredits.pressed == true):
		get_tree().change_scene("res://uires/menu_credits/menu_credits.tscn")
	
	if($Options/ButtonExit.pressed == true):
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
	
	
	if (get_tree().paused == true):
		get_tree().paused = false
	pass

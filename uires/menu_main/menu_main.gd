extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	preload("res://scenes/test_scene.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Options/ButtonFreeFlight.pressed == true):
#		get_tree().change_scene("res://uires/menu_free_flight/menu_free_flight.tscn")
		$LoadingNotice.visible = true
		$Options.visible = false
		$Timer.start()
	
	if ($Options/ButtonTutorials.pressed == true):
		get_tree().change_scene("res://uires/menu_tutorials/menu_tutorials.tscn")
	
	if ($Options/ButtonMissions.pressed == true):
		pass
	
	if ($Options/ButtonCredits.pressed == true):
		get_tree().change_scene("res://uires/menu_credits/menu_credits.tscn")
	
	if ($Options/ButtonSettings.pressed == true):
		get_tree().change_scene("res://uires/menu_settings/menu_settings.tscn")
	
	if ($Options/ButtonExit.pressed == true):
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
	
	if (get_tree().paused == true):
		get_tree().paused = false
	pass



func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/test_scene.tscn")

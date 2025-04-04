extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# If running in webpage, hide exit button 
	# User can just close browswer tab
	# Using the button makes it freeze in the browser anyway
	if OS.has_feature("HTML5"):
		$Options/ButtonExit.visible = false
	
#	preload("res://scenes/test_scene.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Options/ButtonFreeFlight.button_pressed == true):
#		get_tree().change_scene("res://uires/menu_free_flight/menu_free_flight.tscn")
		$LoadingNotice.visible = true
		$Options.visible = false
		$Timer.start()
	
	if ($Options/ButtonTutorials.button_pressed == true):
		get_tree().change_scene_to_file("res://uires/menu_tutorials/menu_tutorials.tscn")
	
	if ($Options/ButtonMissions.button_pressed == true):
		pass
	
	if ($Options/ButtonCredits.button_pressed == true):
		get_tree().change_scene_to_file("res://uires/menu_credits/menu_credits.tscn")
	
	if ($Options/ButtonSettings.button_pressed == true):
		get_tree().change_scene_to_file("res://uires/menu_settings/menu_settings.tscn")
	
	if ($Options/ButtonExit.button_pressed == true):
		#get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
		pass
	
	if (get_tree().paused == true):
		get_tree().paused = false
	pass




func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")

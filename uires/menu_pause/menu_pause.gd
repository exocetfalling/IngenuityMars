extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Options/ButtonMainMenu.pressed == true):
		get_tree().paused = false
		get_tree().change_scene("res://uires/menu_main/menu_main.tscn")
	if($Options/ButtonResume.pressed == true):
		visible = false
		get_tree().paused = false
	if($Options/ButtonExit.pressed == true):
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

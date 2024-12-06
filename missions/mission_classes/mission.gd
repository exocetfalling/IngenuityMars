extends Node

class_name Mission


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var use_mission_waypoints: bool = true

var goals_array: Array = []
var wpt_array: PoolVector3Array = []

export var title_text: String
var goals_text: PoolStringArray

var timer_goal: float = 0

var is_complete: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is MissionGoal:
			goals_array.append(child)
			wpt_array.append(child.translation)
	
	if use_mission_waypoints:
		$Ingenuity/HUDShared.wpt_array = wpt_array # Copy mission waypoints to craft
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

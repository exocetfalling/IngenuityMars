extends Node

class_name Mission


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var use_mission_waypoints: bool = true

var goals_array: Array
export var wpt_array: PoolVector3Array = [Vector3.ZERO]

export var title_text: String
export var goals_text: PoolStringArray

enum goal_type {LOCATION, TIME, WAIT}

var is_complete: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

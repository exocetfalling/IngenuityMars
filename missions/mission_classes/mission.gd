extends Node

class_name Mission


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var use_mission_waypoints: bool = true

#export var player_path := @""; onready var player := get_node(player_path)

var goals_array: Array = []
var wpt_array: PackedVector3Array = []

@export var title_text: String
var goals_text: PackedStringArray
var goal_index: int = 0

var time_elapsed: float = 0
var time_left_goal: float = 0

var is_complete: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is MissionGoal:
			goals_array.append(child)
			wpt_array.append(child.position)
	
	if use_mission_waypoints:
		$Ingenuity/HUDShared.wpt_array = wpt_array # Copy mission waypoints to craft
	pass # Replace with function body.


# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time_elapsed += delta
	time_left_goal -= delta

	if (goals_array[goal_index].global_position - $Ingenuity.global_position).length() < goals_array[goal_index].radius:
		if goal_index < goals_array.size() - 1:
			goal_index += 1
#			print("Waypoint reached: ", goal_index)
			$Ingenuity/HUDShared.set_cas_memos(["WPT REACHED", "SEL NEXT WPT"])
		elif is_complete == false:
			is_complete = true
#			print("Mission complete. ")
			$Ingenuity/HUDShared.set_cas_memos(["MISSION COMPLETE"])

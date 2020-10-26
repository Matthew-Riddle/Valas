extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("StateMachine/Move").connect("s_direction", get_node("WallRay"), "on_dir_change")
	get_node("WallRay").connect("s_jump", get_node("StateMachine/Move"), "jump")
	get_node("StateMachine/Move/Falling").connect("s_falling", get_node("WallRay"), "set_fall_flag")
	get_node("GroundRay").connect("s_on_ground", get_node("WallRay"), "set_ground_flag")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

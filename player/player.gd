extends Node

#static func get_move_direction() -> Vector2:
#	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
#		1.0)
#
#onready var camera = get_node("Camera2D")
#var target = "left"
#
#func _process(delta):
#	print(camera.offset.x)
#	change_cam_direction()
#
#	if target == "left" && camera.offset.x > -100:
#		camera.offset.x -= 3
#	if target == "right" && camera.offset.x < 100:
#		camera.offset.x += 3
#
#func change_cam_direction() -> void:
#	print(get_move_direction())
#	if get_move_direction().x < 0:
#		target = "left"
##		camera.offset.x = -100
#	if get_move_direction().x > 0:
#		target = "right"
##		camera.offset.x = 100
#	pass
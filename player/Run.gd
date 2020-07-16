extends State

func unhandled_input(event: InputEvent) -> void:
	pass

func physics_process(delta: float) -> void:
	var move := get_parent()
	
	if owner.is_on_floor():
		if move.get_move_direction().x == 0.0:
			_state_machine.transition_to("Move/Idle")
		elif Input.is_action_pressed("ui_accept"):
			_state_machine.transition_to("Move/Jump")
		
	else:
		_state_machine.transition_to("Move/Falling")
	
	_state_machine.AnimationPlayer.play("Run")
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	#print('run')
#	if msg.has("direction"):
#		print('DIRECTION: ', msg.direction)
	pass


func exit() -> void:
#	_state_machine.AnimationPlayer.play("skid")
	#print(_state_machine.AnimationPlayer.current_animation)
	#_on_AnimationPlayer_animation_finished("skid")
	#yield(_state_machine.AnimationPlayer, "animation_finished")
	#print('exiting run')
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

#func _on_AnimationPlayer_animation_finished(anim_name):
#	print('HI THERE', anim_name)
#	if anim_name == "Run":
#		print('we ran')
#		_state_machine.AnimationPlayer.play("skid")
#		yield(_state_machine.AnimationPlayer, "animation_finished")
#
#
#func _on_AnimationPlayer_animation_changed(old_name, new_name):
#	print(old_name, new_name)
#	print('ooookkkk')
#
#
#func _on_AnimationPlayer_animation_started(anim_name):
#	if anim_name == "skid":
#		print('yeppers')
#	print('seriously')

extends EnemyState

func unhandled_input(event: InputEvent) -> void:
	pass

func unhandled_key_input(event: InputEventKey) -> void:
	pass

func physics_process(delta: float) -> void:
#	_state_machine.AnimationPlayer.play("idle")
	var move := get_parent();
	if owner.is_on_floor():
		if move.need_to_jump == true:
			_state_machine.transition_to("Move/Jump")
		else:
			_state_machine.transition_to("Move/Patrol")
	if !owner.is_on_floor():
		_state_machine.transition_to("Move/Falling")
	move.physics_process(delta)

func enter(msg: Dictionary = {}) -> void:
#	yield(_state_machine.AnimationPlayer, "animation_finished")
#	_state_machine.AnimationPlayer.play("idle")
	print('idle')
	var move := get_parent()
	
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO


func exit() -> void:
	#print('exiting idle')
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

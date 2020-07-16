extends PState

func unhandled_input(event: InputEvent) -> void:
	pass

func unhandled_key_input(event: InputEventKey) -> void:
	pass

func physics_process(delta: float) -> void:
	_state_machine.AnimationPlayer.play("idle")
	var move := get_parent();
	if owner.is_on_floor() && move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif Input.is_action_pressed("ui_accept"):
		_state_machine.transition_to("Move/Jump")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Falling")
	move.physics_process(delta)

func enter(msg: Dictionary = {}) -> void:
#	yield(_state_machine.AnimationPlayer, "animation_finished")
#	_state_machine.AnimationPlayer.play("idle")
	#print('idle')
	var move := get_parent()
	
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO


func exit() -> void:
	#print('exiting idle')
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("p_state_machine"):
		return _get_state_machine(node.get_parent())
	return node

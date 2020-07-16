extends State

func unhandled_input(event: InputEvent) -> void:
	pass

func physics_process(delta: float) -> void:
#	_state_machine.AnimationPlayer.play("idle")
	var move := get_parent()

	if owner.is_on_floor():
		if move.get_move_direction().x != 0.0:
			_state_machine.transition_to("Move/Run")
		else:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Falling")
	move.physics_process(delta)

func enter(msg: Dictionary = {}) -> void:
	#print('Jumping')
	var move := get_parent()
	move.velocity = Vector2(move.get_move_direction().x, move.get_move_direction().y - move.jump_impulse)
	pass


func exit() -> void:
	#print('exiting falling')
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

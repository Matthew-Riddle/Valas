extends EnemyState

signal s_falling(flag)

func unhandled_input(event: InputEvent) -> void:
	pass

func unhandled_key_input(event: InputEventKey) -> void:
	pass

func physics_process(delta: float) -> void:
#	_state_machine.AnimationPlayer.play("idle")
	var move := get_parent()

	if owner.is_on_floor():
		if move.get_move_direction().x != 0.0:
			_state_machine.transition_to("Move/Patrol")
		else:
			_state_machine.transition_to("Move/Idle")

	if move.pdir.y == 0:
		move.pdir.y = 1
	move.physics_process(delta)

func enter(msg: Dictionary = {}) -> void:
	var move := get_parent()
	move.need_to_jump = false
	print('falling')
	pass


func exit() -> void:
	#print('exiting falling')
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

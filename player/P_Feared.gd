extends PState

func unhandled_input(event: InputEvent) -> void:
	pass

func unhandled_key_input(event: InputEventKey) -> void:
	pass

func physics_process(delta: float) -> void:
	_state_machine.AnimationPlayer.play("idle")
	var move := get_parent();
	
	if Input.is_key_pressed(KEY_C):
		move.velocity.x = rand_range(-1000000, 1000000)
		print(move.velocity.x)
		move.physics_process(delta)
	else:
		exit()
	

func enter(msg: Dictionary = {}) -> void:
#	yield(_state_machine.AnimationPlayer, "animation_finished")
#	_state_machine.AnimationPlayer.play("idle")
	print('feared')
	var move := get_parent()
	
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO


func exit() -> void:
	print('exiting feared')
	var move := get_parent();
	move.velocity = Vector2.ZERO
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("p_state_machine"):
		return _get_state_machine(node.get_parent())
	return node
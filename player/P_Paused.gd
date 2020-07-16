extends PState

func unhandled_input(event: InputEvent) -> void:
	pass

func unhandled_key_input(event: InputEventKey) -> void:
	pass

func physics_process(delta: float) -> void:
	var move := get_parent()
	move.velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_record"):
		exit()
	pass

func enter(msg: Dictionary = {}) -> void:
#	yield(_state_machine.AnimationPlayer, "animation_finished")
#	_state_machine.AnimationPlayer.play("idle")
	print('paused man')
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
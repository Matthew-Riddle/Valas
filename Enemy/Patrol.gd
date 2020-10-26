extends EnemyState

onready var player = get_tree().get_root().get_node("World/Player")
func unhandled_input(event: InputEvent) -> void:
	pass

func physics_process(delta: float) -> void:
	if player == null:
		return
	var move := get_parent()
	if !owner.is_on_floor():
		_state_machine.transition_to("Move/Falling")
	if move.need_to_jump == true && owner.is_on_floor() == true:
		_state_machine.transition_to("Move/Jump")
	if owner.is_on_floor() && move.need_to_jump == false && move.velocity.x == 0:
		_state_machine.transition_to("Move/Idle")
	var vec_to_player = player.get_global_position() - owner.get_global_position()
	vec_to_player = vec_to_player.normalized()
	move.pdir = vec_to_player
	
	move.velocity.y = 1
	
#	move.pdir = move.pdir.round()
	move.pdir.y = 1
	move.physics_process(delta)
	pass


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

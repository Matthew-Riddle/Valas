extends EnemyState

onready var player = get_tree().get_root().get_node("World/Player")
func unhandled_input(event: InputEvent) -> void:
	pass

func physics_process(delta: float) -> void:
	if player == null:
		return
	var move := get_parent()
	var vec_to_player = player.get_global_position() - owner.get_global_position()
	vec_to_player = vec_to_player.normalized()
	move.pdir = vec_to_player
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

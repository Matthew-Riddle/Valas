extends PState

export var FIRE_RATE = .000001
var cooldown = 0.0

func unhandled_input(event: InputEvent) -> void:
#	var gun = get_node("../../Gun")
#	var gunVec = get_node("../../Gun/GunVector")
#	gun.rotation = gunVec.get_angle_to(gunVec.get_global_mouse_position())
	pass
	
func unhandled_key_input(event: InputEventKey) -> void:
	pass

func _process(delta):
	cooldown -= delta

func physics_process(delta: float) -> void:
	var move := get_node("../Move")
	var projectile = _state_machine.projectile.instance()
	var gun = get_node("../../Gun")
	var gunVec = get_node("../../Gun/GunVector")
	
	if owner.is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			_state_machine.transition_to("Move/Jump")
	gun.rotation = get_parent().get_parent().get_angle_to(get_parent().get_parent().get_global_mouse_position())
	projectile.position = gunVec.get_global_position()
	projectile.rotation = get_parent().get_parent().get_angle_to(get_parent().get_parent().get_global_mouse_position())
	
	if cooldown <= 0.0:
		get_parent().get_parent().get_parent().add_child(projectile)
		cooldown = FIRE_RATE
	
	move.physics_process(delta)  
	exit()

func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("p_state_machine"):
		return _get_state_machine(node.get_parent())
	return node

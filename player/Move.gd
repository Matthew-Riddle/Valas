extends State

export var max_speed_default: = Vector2(300.0, 100000.0)
export var acceleration_default: = Vector2(100000, 3000.0)
export var jump_impulse: = 700.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO
var facing: = "left"

func unhandled_input(event: InputEvent) -> void:
	pass

func physics_process(delta: float) -> void:
	if get_move_direction() == Vector2(1,1):
		facing = "left"
	elif get_move_direction() == Vector2(-1,1):
		facing = "right"
		
	var target_state: = get_node("Feared")
	
	if Input.is_key_pressed(KEY_C) && _state_machine.states.front() != target_state:
		_state_machine.push_state("Move/Feared", {})
	
	if Input.is_action_just_released("ui_left") || Input.is_action_just_released("ui_right"):
		velocity.x = 0
	
	if facing == "left":
		_state_machine.Sprite.set_flip_h(false)
	if facing == "right":
		_state_machine.Sprite.set_flip_h(true)
		
	velocity = calculate_velocity(velocity, max_speed, acceleration, delta, get_move_direction())
	velocity = owner.move_and_slide(velocity, Vector2.UP)
	#Events.emit_signal("player_moved", owner)

func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
	
static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity := old_velocity
	
	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	
	return new_velocity

static func get_move_direction() -> Vector2:
	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		1.0)
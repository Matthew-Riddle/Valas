extends EnemyState

export var max_speed_default: = Vector2(100.0, 100000)
export var acceleration_default: = Vector2(100000, 3000.0)
export var jump_impulse: = 700.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO
var facing: = "right"
var old_dir: = facing
var need_to_jump = false
signal s_direction(facing)
var paused := false
var pdir := Vector2(0, 0)



func unhandled_input(event: InputEvent) -> void:
#	print("yes")
	pass
	
func unhandled_key_input(event: InputEventKey) -> void:
	
	pass
	
func physics_process(delta: float) -> void:
#	if Input.is_action_pressed("ui_fire"):
#		_state_machine.push_state("Shooting", {})
	if velocity.x > 0:
		facing = "right"
	if velocity.x < 0:
		facing = "left"
		
	if facing == "left":
		if facing != old_dir:
			_state_machine.Sprite.set_flip_h(true)
			emit_signal("s_direction", "left")
			old_dir = facing
	if facing == "right":
		if facing != old_dir:
			_state_machine.Sprite.set_flip_h(false)
			emit_signal("s_direction", "right")
			old_dir = facing
	
	velocity = calculate_velocity(velocity, max_speed, acceleration, delta, pdir)
	owner.move_and_slide(velocity, Vector2.UP)
	print(velocity)

func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	_state_machine.states.pop_front()
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

func jump():
	if need_to_jump == false && owner.is_on_floor():
		need_to_jump = true
	else:
		need_to_jump = false

static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		pdir: Vector2
	) -> Vector2:
	var new_velocity := old_velocity
	new_velocity += pdir * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	
	return new_velocity

static func get_move_direction() -> Vector2:
	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		1.0)

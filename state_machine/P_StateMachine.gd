extends Node
class_name PStateMachine
"""
Generic State Machine. Initializes states and delegates engine callbacks
(_physics_process, _unhandled_input) to the active state.
"""
export var AnimationPlayerPath = NodePath()
export var SpritePath = NodePath()
export var CharacterPath = NodePath()
export var GunPositionPath = NodePath()

onready var AnimationPlayer = get_node(AnimationPlayerPath)
onready var Sprite = get_node(SpritePath)
onready var Character = get_node(CharacterPath)
onready var GunPosition = get_node(GunPositionPath)

onready var projectile = preload("res://Bullet.tscn")

export var CameraPath = NodePath()
onready var Cam = get_node(CameraPath)

export var initial_state: = NodePath()
onready var states: Array = []

onready var state: PState = get_node(initial_state) setget set_state
onready var _state_name: = state.name
onready var captured_state : Array = []

func _init() -> void:
	add_to_group("p_state_machine")


func _ready() -> void:
	yield(owner, "ready")
	states.push_front(state)
	states.front().enter()


func _unhandled_input(event: InputEvent) -> void:
	if states.front() != null:
		states.front().unhandled_input(event)

func _unhandled_key_input(event: InputEventKey) -> void:
	if states.front() != null:
		states.front().unhandled_key_input(event)


func _physics_process(delta: float) -> void:
	if states.front() != null:
		states.front().physics_process(delta)


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		return

	var target_state: = get_node(target_state_path)
	
	
	states.front().exit();
	states.push_front(target_state)
	states.front().enter(msg)
	
#	state.exit()
#	self.state = target_state
#	state.enter(msg)

func push_state(target_state_path: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		return

	var target_state: = get_node(target_state_path)
	
	states.push_front(target_state)
	states.front().enter(msg)

func set_state(value: PState) -> void:
	state = value
	_state_name = state.name


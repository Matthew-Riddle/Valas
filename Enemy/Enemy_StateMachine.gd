extends Node
class_name EnemyStateMachine
"""
Generic State Machine. Initializes states and delegates engine callbacks
(_physics_process, _unhandled_input) to the active state.
"""
onready var AnimationPlayer = get_node("../AnimationPlayer")
onready var Sprite = get_node("../Sprite")

export var PlayerPath := NodePath()
onready var Player = get_tree().get_root().get_node("Player")

export var initial_state: = NodePath()
onready var states: Array = []

onready var state: EnemyState = get_node(initial_state) setget set_state
onready var _state_name: = state.name

func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	yield(owner, "ready")
	states.push_front(state)
	states.front().enter()


func _unhandled_input(event: InputEvent) -> void:
	if states.front() != null:
		states.front().unhandled_input(event)


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

func set_state(value: EnemyState) -> void:
	state = value
	_state_name = state.name


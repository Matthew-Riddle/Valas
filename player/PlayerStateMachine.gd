extends PStateMachine
"""
Generic State Machine. Initializes states and delegates engine callbacks
(_physics_process, _unhandled_input) to the active state.
"""

func _init() -> void:
	pass


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	pass

func _unhandled_key_input(event: InputEventKey) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	pass

func push_state(target_state_path: String, msg: Dictionary = {}) -> void:
	pass

func set_state(value: State) -> void:
	pass


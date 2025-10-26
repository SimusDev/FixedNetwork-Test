extends Node

var _states: PackedStringArray = []
var _applied_states: PackedStringArray = []

var _progress: int = 0

signal states_synchronized()
signal state_synchronized(state: String)

var _is_states_synchronized: bool = false

func is_states_synchronized() -> bool:
	return _is_states_synchronized

func create_state(state: String) -> void:
	if _states.has(state):
		return
	
	_states.append(state)

func apply_state(state: String) -> void:
	if _is_states_synchronized:
		return
	
	if _states.has(state) and !_applied_states.has(state):
		_progress += 1
		_applied_states.append(state)
		state_synchronized.emit(state)
		check_states()

func check_states() -> void:
	if _progress >= _states.size():
		_is_states_synchronized = true
		states_synchronized.emit()

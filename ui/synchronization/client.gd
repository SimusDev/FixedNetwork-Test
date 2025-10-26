extends CanvasLayer

func _ready() -> void:
	SimusDev.game.pause_add_priority()
	
	Synchronization.state_synchronized.connect(_on_state_sync)
	Synchronization.states_synchronized.connect(_on_states_sync)
	#Synchronization.check_states()

func _on_state_sync(state: String) -> void:
	SD_Console.i().write_success("state synchronized: %s" % state)

func _on_states_sync() -> void:
	SD_Console.i().write_success("all states synchronized!")
	SimusDev.game.pause_subtract_priority()
	queue_free()

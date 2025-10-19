extends Node
class_name LevelHandler

@export var root: Node
@export var initial: R_Level
@onready var cmd: SD_ConsoleCommand = SD_ConsoleCommand.get_or_create("level.change")

var _current: R_Level
var _node: Node

func get_current() -> R_Level:
	return _current

func get_current_node() -> Node:
	return _node

func _ready() -> void:
	SD_Network.register_object(self)
	SD_Network.register_functions([
		_send,
		_recieve,
		_change_to_local
	])
	
	cmd.executed.connect(_on_cmd_executed)
	
	if SD_Network.is_server():
		_change_to_local(initial)
	
	synchronize()

func synchronize() -> void:
	if !SD_Network.is_server():
		SD_Network.call_func_on_server(_send)

func _send() -> void:
	SD_Network.call_func_on(SD_Network.get_remote_sender_id(), _recieve, [get_current().get_code()])

func _recieve(code: String) -> void:
	if not Levels.get_by_code(code):
		SD_Console.i().write_error("failed change level to %s" % code)
		return
		
	_change_to_local(Levels.get_by_code(code))

func _change_to_local(level: R_Level) -> void:
	if not level:
		return
	
	var scene: PackedScene = Levels.load_scene(level)
	
	if not scene:
		SD_Console.i().write_error("packed scene not found: %s" % level.path)
		return
	
	if is_instance_valid(_node):
		_node.get_parent().remove_child(_node)
		_node.queue_free()
		await get_tree().process_frame
	
	_current = level
	_node = scene.instantiate()
	_node.name = "level"
	root.add_child(_node)
	level._changed_in_game()
	
	SD_Console.i().write_info("level changed to: %s" % level.get_code())

func change_to(level: R_Level) -> void:
	if SD_Network.is_server():
		SD_Network.call_func(_recieve, [level.get_code()]) 
	else:
		SD_Console.i().write_error("only server can change level.")

func _on_cmd_executed() -> void:
	var level_str: String = cmd.get_value_as_string()
	if not Levels.get_by_code(level_str):
		SD_Console.i().write_error("failed change level to %s" % level_str)
		return
	
	change_to(Levels.get_by_code(level_str))

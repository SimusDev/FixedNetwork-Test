extends Node
class_name EntityInput

@export var interact_input: StringName = "interact"
@export var root: Node
@export var menu_cooldown: float = 0.5

var _menu_cooldown_max: float = 0.0

@export var _raycast: EntityRayCast3D
var _node_input: SD_NodeInput

var _interact_button_is_pressed: bool = false

func _ready() -> void:
	SD_Network.register_object(self)
	SD_Network.register_functions([
		
	])
	
	if !root:
		root = get_parent()
	
	SD_Components.append_to(root, self)
	
	_menu_cooldown_max = menu_cooldown
	menu_cooldown = 0.0
	
	if !_raycast:
		_raycast = SD_Components.find_first(root, EntityRayCast3D)
	
	set_process(SD_Network.is_authority(self))
	
	if SD_Network.is_authority(self):
		_node_input = SD_NodeInput.new()
		_node_input.name = "input"
		_node_input.on_action_just_released.connect(_on_action_just_released)
		_node_input.on_action_just_pressed.connect(_on_action_just_pressed)
		add_child(_node_input)
	

func _process(delta: float) -> void:
	if _node_input.is_action_pressed(interact_input):
		menu_cooldown += delta
		
		if menu_cooldown >= _menu_cooldown_max:
			menu_cooldown = 0
			_raycast.try_interact(EntityRayCast3D.FLAGS.ACTIONS)

func _on_action_just_released(action: String, bind: SD_Keybind) -> void:
	if not _node_input.get_input_status():
		return
	
	if action == interact_input and menu_cooldown < _menu_cooldown_max:
		_raycast.try_interact()


func _on_action_just_pressed(action: String, bind: SD_Keybind) -> void:
	if not _node_input.get_input_status():
		return
	
	if action == interact_input:
		menu_cooldown = 0

@tool
extends RichTextLabel
class_name SD_RichTextLabel

signal localization_updated()

@export_group("Font")
@export var font: Font : set = set_font
@export var font_size: int = 16 : set = set_font_size
@export var font_size_minimum: int = 1 : set = set_font_size_minimum

@export_group("AutoSize")
@export var autosize_font_base_size: int = 16 : set = set_autosize_font_base_size
@export var autosize_snap := Vector2(0, 0)
@export var autosize_rect: bool = false : set = set_autosize_rect
@export var autosize_rect_scale: float = 1.0 : set = set_autosize_rect_scale
@export var autosize_characters: bool = false : set = set_autosize_characters
@export var autosize_characters_scale: float  = 1.0 : set = set_autosize_characters_scale


@export_group("Localization")
@export var localization_enabled: bool = false : set = set_localization_enabled, get = get_localization_enabled
@export var localization_key: String = "" : set = set_localization_key, get = get_localization_key
@export_multiline var localization_placeholder: String = "" : set = set_localization_placeholder, get = get_localization_placeholder
@export var format: Array[String] = [] : set = set_format
var _format_parsed: Array[String] = []

var _last_text: String = ""

signal text_changed()

func set_font(new_font: Font) -> void:
	font = new_font
	set("theme_override_fonts/normal_font", font)

func set_font_size(f_size: int) -> void:
	if f_size < font_size_minimum:
		f_size = font_size_minimum
	
	font_size = f_size
	
	set("theme_override_font_sizes/normal_font_size", font_size)
	

func set_font_size_minimum(f_size: int) -> void:
	font_size_minimum = f_size

func _ready() -> void:
	_last_text = get_parsed_text()
	update_autosize()
	
	if Engine.is_editor_hint():
		set_font(font)
		set_font_size(font_size)
	
	if Engine.is_editor_hint():
		return
	
	get_localization().updated.connect(_on_localization_updated)
	
	update_localization()

func _on_localization_updated() -> void:
	update_localization()

func get_localization() -> SD_TrunkLocalization:
	return SimusDev.localization as SD_TrunkLocalization

func set_localization_enabled(enabled: bool) -> void:
	localization_enabled = enabled
	update_localization()

func set_localization_key(key: String) -> void:
	localization_key = key
	update_localization()

func set_localization_placeholder(placeholder: String) -> void:
	localization_placeholder = placeholder
	update_localization()

func get_localization_key() -> String:
	return localization_key
 
func get_localization_enabled() -> bool:
	return localization_enabled

func get_localization_placeholder() -> String:
	return localization_placeholder

func _parse_format(from: Array[String]) -> void:
	_format_parsed.clear()
	
	if Engine.is_editor_hint():
		_format_parsed = from.duplicate()
	else:
		for string in from:
			_format_parsed.append(get_localization().get_text_from_key(string))


func set_format(new_format: Array[String]) -> void:
	format = new_format
	update_localization()

func update_localization() -> void:
	if localization_enabled:
		_parse_format(format)
		
		if Engine.is_editor_hint():
			
			var editor_text: String = localization_placeholder
			if editor_text.is_empty():
				editor_text = localization_key
			
			if format.is_empty():
				text = editor_text
			else:
				text = editor_text % format
			
			return
		
		var text_key: String = get_localization().get_text_from_key(localization_key)
		if format.is_empty():
			text = text_key
		else:
			text = text_key % _format_parsed
		_update_text_change()
	
	
	_on_localization_update()
	localization_updated.emit()

func _on_localization_update() -> void:
	pass

func _process(delta: float) -> void:
	_update_text_change()

func _update_text_change() -> void:
	if get_parsed_text() != _last_text:
		text_changed.emit()
		update_autosize()
		_last_text = get_parsed_text()

func set_autosize_font_base_size(value: int) -> void:
	autosize_font_base_size = value
	update_autosize()

func set_autosize_characters(value: bool) -> void:
	autosize_characters = value
	update_autosize()

func set_autosize_characters_scale(value: float) -> void:
	autosize_characters_scale = value
	update_autosize()

func set_autosize_rect(value: bool) -> void:
	autosize_rect = value
	update_autosize()

func set_autosize_rect_scale(value: float) -> void:
	autosize_rect_scale = value
	update_autosize()
	

func update_autosize() -> void:
	if autosize_rect or autosize_characters:
		var actual: int = SD_Label.get_parsed_autosize(
			self,
			get_parsed_text(),
			autosize_rect,
			autosize_characters,
			autosize_font_base_size,
			autosize_snap,
			autosize_rect_scale,
			autosize_characters_scale,
		)
		
		set_font_size(actual)

@icon("res://textures/components/footstep.png")
class_name FootstepComponent extends Node

@export var entity:Entity

@export var footstep_assets:Array[AudioStream]
@export var jump_assets:Array[AudioStream]
@export var grounding_assets:Array[AudioStream]

func _ready() -> void:
	if is_instance_valid(entity.state_machine):
		entity.state_machine.state_enter.connect(on_entity_state_enter)
	if is_instance_valid(entity.model):
		entity.model.footstep.connect(do_footstep)
	

func on_entity_state_enter(state:SD_State) -> void:
	if state.name == "jump":
		do_jump_footstep()

func play_sound(stream:AudioStream, pitch_range:Vector2 = Vector2(1, 1))-> void:
	var audio_player:AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	audio_player.stream = stream
	audio_player.pitch_scale = randf_range(pitch_range.x, pitch_range.y)
	audio_player.finished.connect(audio_player.queue_free)
	
	entity.add_child(audio_player)
	audio_player.play()

func do_footstep() -> void:
	if footstep_assets.is_empty():
		return
	
	play_sound( footstep_assets.pick_random() )

func do_jump_footstep() -> void:
	if jump_assets.is_empty():
		return
	
	play_sound( jump_assets.pick_random() )

func do_grounding_footstep() -> void:
	if grounding_assets.is_empty():
		return
	
	play_sound( grounding_assets.pick_random() )

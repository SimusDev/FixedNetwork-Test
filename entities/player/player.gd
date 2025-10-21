extends Entity
class_name Player

static var local: Player

var network: SD_NetworkPlayer

func _ready() -> void:
	super()
	
	if SD_Network.is_authority(self):
		network = SD_NetworkPlayer.get_local()
		local = self

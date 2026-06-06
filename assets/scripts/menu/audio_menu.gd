extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_master_h_slider_value_changed(value: float) -> void:
	# MasterBus index at 0
	AudioServer.set_bus_volume_db(0, value)

func _on_music_h_slider_value_changed(value: float) -> void:
	# MusicBus index at 1
	AudioServer.set_bus_volume_db(1, value)


func _on_sfxh_slider_value_changed(value: float) -> void:
	# SFXBus index at 2
	AudioServer.set_bus_volume_db(2, value)

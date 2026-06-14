extends Node2D


func _on_hurtbox_died() -> void:
	print("Bot damaged")


func _on_hurtbox_received_damage() -> void:
	print("Bot died")
	queue_free()

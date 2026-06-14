extends Node2D



func _on_hurtbox_received_damage() -> void:
	print("Monkey damaged")


func _on_hurtbox_died() -> void:
	print("Monkey died")

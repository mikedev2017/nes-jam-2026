extends Node2D

func _on_hurtbox_received_damage() -> void:
	print("Ball damaged")


func _on_hurtbox_died() -> void:
	print("Ball died")
	queue_free()

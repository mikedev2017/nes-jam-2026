# Pickup.gd
extends Area2D

@export var item_data: ItemData # Assign your .tres file here

func _on_body_entered(body: PlayerController):
	if body.has_method("add_to_inventory"):
		body.add_to_inventory(item_data)
		queue_free() # Destroys node (Destroy() in Unity)

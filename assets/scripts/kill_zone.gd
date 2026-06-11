extends Area2D

@export var collision_shape_2d: CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if GameManager.player_lives >0:
			GameManager.player_lives -= 1
		GameManager.player_killed = true
		
		if GameManager.player_lives <= 0:
			print("Game Over. I say to you, you dead!")

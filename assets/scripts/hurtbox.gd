extends Area2D

signal received_damage()
signal died()

@export var health_points : int = 1


func get_damage(damage_value : int):
	health_points -= damage_value
	received_damage.emit()
	
	if health_points <= 0:
		died.emit()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_damage"):
		print("Player damage")
		get_damage(area.damage)
	if area.is_in_group("enemy_damage"):
		print("Enemy damage")
		get_damage(area.damage)

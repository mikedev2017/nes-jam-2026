class_name Hurtbox extends Area2D

signal hurt_entity()
signal died()

@export var health_points : int = 1

func get_damage(damage_value : int):
	health_points -= damage_value
	
	hurt_entity.emit()
	
	if health_points <= 0:
		died.emit()

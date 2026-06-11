extends CanvasLayer

@onready var life_count_label: Label = $life_count_label
@onready var gem_count_label: Label = $gem_count_label
@onready var score_label: Label = $score_label

func _ready() -> void:
	life_count_label.text = "x " + str(GameManager.player_lives)
	gem_count_label.text = "x " + str(GameManager.gem_count)
	score_label.text = "SCORE: " + str(GameManager.score)

func _process(delta: float) -> void:
	life_count_label.text = "x " + str(GameManager.player_lives)
	gem_count_label.text = "x " + str(GameManager.gem_count)
	score_label.text = "SCORE: " + str(GameManager.score)

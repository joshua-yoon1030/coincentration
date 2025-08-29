extends Node2D

var high_scores: Array = []   # stores { "name": String, "score": int }

const SAVE_PATH := "user://highscores.json"
const MAX_SCORES := 10  # how many top scores to keep

func _ready():
	load_scores()
	var user_path = ProjectSettings.globalize_path("user://")
	print("User path is: ", user_path)

func add_score(score: int) -> void:
	# Add the new score
	print("is this workign")
	high_scores.append(score)

	# Sort by score descending
	high_scores.sort_custom(func(a, b): return a > b)

	# Trim to max scores
	if high_scores.size() > MAX_SCORES:
		high_scores.resize(MAX_SCORES)

	# Save immediately
	save_scores()

func save_scores() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(high_scores))

func load_scores() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_ARRAY:
			high_scores = data

func debug_scores() -> void:
	for score in high_scores:
		print(score)

extends CanvasLayer



func init():
	var leaderboard_names = [$"Panel/ScoresList/First", $"Panel/ScoresList/Second", $"Panel/ScoresList/Third", $"Panel/ScoresList/Fourth", $"Panel/ScoresList/Fifth"]
	var leaderboard_scores = [$"Panel/ScoresList/First/Score", $"Panel/ScoresList/Second/Score", $"Panel/ScoresList/Third/Score", $"Panel/ScoresList/Fourth/Score", $"Panel/ScoresList/Fifth/Score"]
	$"Panel/Your Score/Label".text = str(globals.current_coins)
	for i in persistent_data.high_scores.size():
		leaderboard_names[i].text = persistent_data.high_scores[i]["name"]
		leaderboard_scores[i].text = str(persistent_data.high_scores[i]["score"])


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")
	


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_title.tscn")

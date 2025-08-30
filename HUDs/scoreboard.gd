extends CanvasLayer


var leaderboard_names = [$"Panel/ScoresList/1st", $"Panel/ScoresList/2nd", $"Panel/ScoresList/3rd", $"Panel/ScoresList/4th", $"Panel/ScoresList/5th"]
var leaderboard_scores = [$"Panel/ScoresList/1st/Score", $"Panel/ScoresList/2nd/Score", $"Panel/ScoresList/3rd/Score", $"Panel/ScoresList/4th/Score", $"Panel/ScoresList/5th/Score"]
func init():
	$"Panel/Your Score/Label".text = str(globals.current_coins)
	#Read from file and update scores accordingly
	#Still need to link buttons and make an opening page
	

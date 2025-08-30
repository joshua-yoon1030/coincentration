extends CanvasLayer

func _process(delta: float):
	$Panel/ScoreLabel.text = str(globals.current_coins)

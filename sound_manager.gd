extends Control

func block_click(times: int):
	for i in range(times):
		$block_click.play()
		await get_tree().create_timer(0.5).timeout

func coin_collect(times: int):
	for i in range(times):
		$coin_collect.play()
		await get_tree().create_timer(0.5).timeout

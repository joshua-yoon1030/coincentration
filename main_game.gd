extends Node2D


var emptyBlock = preload("res://Blocks/emptyBlock.tscn")
var oneCoinBlock = preload("res://Blocks/OneCoinBlock.tscn")
var twoCoinBlock = preload("res://Blocks/TwoCoinBlock.tscn")
var threeCoinBlock = preload("res://Blocks/ThreeCoinBlock.tscn")
var coinScene = preload("res://coin.tscn")

var blocks = []

var positions = []

var opening_cutscene_coins = globals.TOTAL_COINS


func _ready():
	globals.current_coins = 0
	position_setup()

	block_setup()
	$"ScoreHUD".visible = false
	await get_tree().create_timer(3).timeout
	$"Beginning Hud".visible = false
	coin_setup()
	
func _process(delta: float):
	$ScoreHUD/Panel/ScoreLabel.text = str(globals.current_coins)

func position_setup():
	for y in range(200, 601, 200):
		for x in range(50, 1153, 105):
			positions.append(Vector2(x, y))
	positions.shuffle()

func block_setup():
	for i in len(positions):
		var block
		if i < 8:
			block = threeCoinBlock.instantiate()
			block.global_position = positions[i]
		elif i < 17:
			block = twoCoinBlock.instantiate()
			block.global_position = positions[i]
		elif i < 25:
			block = oneCoinBlock.instantiate()
			block.global_position = positions[i]
		else:
			block = emptyBlock.instantiate()
			block.global_position = positions[i]
		add_child(block)
		block.z_index = 1
		block.input_pickable = false
		block.on_click.connect(on_block_clicked)
		blocks.append(block)

func coin_setup():
	for i in len(positions):
		if i < 8:
			for j in range(3):
				var coin = coinScene.instantiate()
				add_child(coin)
				coin.coin_done.connect(on_coin_done)
				coin.init(blocks[i])
		elif i < 17:
			for j in range(2):
				var coin = coinScene.instantiate()
				add_child(coin)
				coin.coin_done.connect(on_coin_done)
				coin.init(blocks[i])
		elif i < 25:
			for j in range(1):
				var coin = coinScene.instantiate()
				add_child(coin)
				coin.coin_done.connect(on_coin_done)
				coin.init(blocks[i])

func on_coin_done():
	opening_cutscene_coins -= 1
	if opening_cutscene_coins <= 0:
		await get_tree().create_timer(1).timeout
		$"ScoreHUD".visible = true
		for block in blocks:
			block.input_pickable = true

func on_block_clicked(num_coin: int):
	globals.current_coins += num_coin
	if num_coin == 0:
		persistent_data.add_score(globals.current_coins)
		persistent_data.debug_scores()
	#I need to handle what happens if you click a 0 box, and I need to handle what happens when you click all of them
	# Need to research into persisitent data in godot

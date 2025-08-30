extends Node2D

#GOs
var emptyBlock = preload("res://Blocks/emptyBlock.tscn")
var oneCoinBlock = preload("res://Blocks/OneCoinBlock.tscn")
var twoCoinBlock = preload("res://Blocks/TwoCoinBlock.tscn")
var threeCoinBlock = preload("res://Blocks/ThreeCoinBlock.tscn")
var coinScene = preload("res://coin.tscn")

#HUDS
var begHudScene = preload("res://HUDs/beginning_hud.tscn")
var begHud
var nameEntryScene = preload("res://HUDs/NameEntry.tscn")
var nameEntry
var scoreHudScene = preload("res://HUDs/score_hud.tscn")
var scoreHud
var scoreboardHudScene = preload("res://HUDs/scoreboard.tscn")
var scoreboard

var blocks = []

var positions = []

var opening_cutscene_coins = globals.TOTAL_COINS


func _ready():
	globals.current_coins = 0
	position_setup()
	hud_setup()
	block_setup()
	await get_tree().create_timer(3).timeout
	begHud.visible = false
	coin_setup()


func position_setup():
	for y in range(200, 601, 200):
		for x in range(50, 1153, 105):
			positions.append(Vector2(x, y))
	positions.shuffle()

func hud_setup():
	begHud = begHudScene.instantiate()
	add_child(begHud)
	
	scoreHud = scoreHudScene.instantiate()
	add_child(scoreHud)
	scoreHud.visible = false
	
	nameEntry = nameEntryScene.instantiate()
	add_child(nameEntry)
	nameEntry.visible = false
	nameEntry.name_inputted.connect(on_name_entered)
	
	scoreboard = scoreboardHudScene.instantiate()
	add_child(scoreboard)
	scoreboard.visible = false

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
		scoreHud.visible = true
		for block in blocks:
			block.input_pickable = true

func on_block_clicked(num_coin: int):
	globals.current_coins += num_coin
	if num_coin == 0:
		end_game_sequence()
		await get_tree().create_timer(1).timeout
		nameEntry.visible = true

func on_name_entered(name: String):
	nameEntry.visible = false
	scoreboard.init()
	scoreboard.visible = true
	scoreHud.visible = false
func end_game_sequence():
	for block in blocks:
		block.input_pickable = false

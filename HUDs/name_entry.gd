extends CanvasLayer


signal name_inputted(player_name: String)

func _ready():
	$Panel/LineEdit.text = ""
	$Panel/LineEdit.placeholder_text = "Name"
	


func _on_button_pressed() -> void:
	var player_name = $Panel/LineEdit.text
	persistent_data.add_score(player_name, globals.current_coins)
	name_inputted.emit(player_name)

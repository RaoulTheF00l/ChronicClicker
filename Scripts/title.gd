extends Control

@onready var title_label: Label = $Layout/TitleLabel
@onready var play_button: Button = $Layout/PlayButton
@onready var quit_button: Button = $Layout/QuitButton
@onready var layout: VBoxContainer = $Layout


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_play_button_pressed()


func _on_play_button_pressed() -> void:
00	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed() -> void:
	pass # Replace with function body.

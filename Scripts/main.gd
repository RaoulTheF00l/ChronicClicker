extends Control

var product: float = 0.0
var harvest_amount: float = 0.5
var money: float = 0.00
var dub_value: float = 20.00
var sell_amount: float = 2.5



@onready var harvest_button: Button = $ButtonsLayout/HarvestButton
@onready var weight_unit_label: Label = $Layout/WeightUnitLabel
@onready var weight_label: Label = $Layout/WeightLabel
@onready var money_label: Label = $CurrencyLayout/MoneyLabel
@onready var sell_button: Button = $ButtonsLayout/SellButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	harvest_button.pressed.connect(_on_harvest_button_pressed)
	sell_button.pressed.connect(_on_sell_button_pressed)
	_update_display()



func _harvest() -> void:
	product += harvest_amount
	_update_display()


func _update_display() -> void:
	weight_label.text = str(product)
	money_label.text = str("Cash: ", money)



func _on_harvest_button_pressed() -> void:
	_harvest()


func _sell() -> void:
	money += dub_value
	product -= sell_amount
	_update_display()


func _on_sell_button_pressed() -> void:
	_sell()
	

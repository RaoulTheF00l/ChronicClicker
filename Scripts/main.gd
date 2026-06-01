extends Control

var product: float = 0.0
var harvest_amount: float = 0.5

var money: float = 0.0
var dub_value: float = 20.0
var sell_amount: float = 2.5

var workers_hired: int = 1
var worker_cost: float = 10.0

var farmers_hired: int = 0
var farmers_assigned: int = 0
var farmer_cost: float = 100.0
var farmer_production_per_second: float = 0.5


@onready var harvest_button: Button = $MobileLayout/ButtonsLayout/HarvestButton
@onready var weight_label: Label = $MobileLayout/Layout/WeightLabel
@onready var money_label: Label = $MobileLayout/CurrencyLayout/MoneyLabel
@onready var sell_button: Button = $MobileLayout/ButtonsLayout/SellButton
@onready var hire_button: Button = $MobileLayout/StoreLayout/HireButton
@onready var assign_farmers_button: Button = $MobileLayout/StoreLayout/AssignFarmersButton


func _ready() -> void:
	harvest_button.pressed.connect(_on_harvest_button_pressed)
	sell_button.pressed.connect(_on_sell_button_pressed)
	hire_button.pressed.connect(_on_hire_button_pressed)
	assign_farmers_button.pressed.connect(_on_assign_farmers_button_pressed)

	_update_display()


func _process(delta: float) -> void:
	_auto_harvest(delta)


func _auto_harvest(delta: float) -> void:
	if farmers_assigned <= 0:
		return

	product += farmers_assigned * farmer_production_per_second * delta
	_update_display()


func _harvest() -> void:
	product += harvest_amount
	_update_display()


func _sell() -> void:
	if product < sell_amount:
		return

	money += dub_value
	product -= sell_amount
	_update_display()


func _hire_worker() -> void:
	if money < worker_cost:
		return

	money -= worker_cost
	workers_hired += 1
	harvest_amount += 0.5

	_update_display()


func _hire_farmer() -> void:
	if money < farmer_cost:
		return

	money -= farmer_cost
	farmers_hired += 1

	_update_display()


func _assign_farmer() -> void:
	if farmers_hired <= farmers_assigned:
		return

	farmers_assigned += 1

	_update_display()


func _update_display() -> void:
	weight_label.text = "Product: " + str(snapped(product, 0.01))
	money_label.text = "Cash: $" + str(snapped(money, 0.01))

	harvest_button.text = "Harvest"
	sell_button.text = "Sell Dub ($" + str(dub_value) + ")"
	hire_button.text = "Hire x1 Worker ($" + str(worker_cost) + ")"
	assign_farmers_button.text = "Assign Farmer " + str(farmers_assigned) + "/" + str(farmers_hired)


func _on_harvest_button_pressed() -> void:
	_harvest()


func _on_sell_button_pressed() -> void:
	_sell()


func _on_hire_button_pressed() -> void:
	_hire_worker()


func _on_assign_farmers_button_pressed() -> void:
	# For now, this button does two things:
	if farmers_assigned <= 0:
		_hire_farmer()
		

	if farmers_hired <= farmers_assigned:
		_hire_farmer()
	else:
		_assign_farmer()

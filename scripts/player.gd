extends CharacterBody2D

const SPEED = 300.0
@export var health: float = 150:
	set(value):
		health = clamp(value, 0, max_health)
		#health_changed.emit(health)
@export var max_health: float = 200
@export var attributes = {"strength" : 0, "intelligence" : 0, "dexterity" : 0 }
var inventory : Array[String]
var inventory_activated: bool = false
var attributes_activated: bool = false
@onready var inventory_list: Label = %InventoryList
@onready var attributes_list: Label = %AttributesList


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		inventory_activated = !inventory_activated
		show_inventory()
	elif event.is_action_pressed("ui_accept"):
		attributes_activated = !attributes_activated
		show_attributes()


func _physics_process(_delta: float) -> void:
	var input_directions = Input.get_vector("left", "right", "up", "down")
	velocity = input_directions * SPEED
	move_and_slide()


func pickup(item: String) -> void:
	inventory.append(item)


func increase_attribute(attribute: int, value: float):
	match (attribute) :
		0:
			health += value
		1:
			attributes.strength += value
		2:
			attributes.intelligence += value
		3:
			attributes.dexterity += value
#	health_bar.value = health


func show_inventory():
	inventory_list.text = ""
	if inventory_activated:
		if inventory.is_empty():
			inventory_activated = false
		else:
			inventory_list.show()
			var a: String
			inventory.sort()
			for i in inventory:
				if a != i:
					inventory_list.text += ("%s x%s\n" % [i, str(inventory.count(i))])
				a = i
	else:
		inventory_list.hide()


func show_attributes():
	attributes_list.text = ""
	if attributes_activated:
		attributes_list.show()
		for key in attributes:
			attributes_list.text += ("%s: %s\n" % [key, attributes[key]])
		attributes_list.text += ("health: %s" % [health])
	else:
		attributes_list.hide()

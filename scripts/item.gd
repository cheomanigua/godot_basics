extends Area2D

enum ATTRIBUTE { health, strength, intelligence, dexterity }
@export var attribute: ATTRIBUTE
@export var value: float
@export var item_name: String
@onready var item_label: Label = %ItemLabel


func _ready() -> void:
	item_label.text = item_name
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.has_method("pickup"):
		var message: String
		body.inventory.append(item_name)
		if value > 0:
			body.increase_attribute(attribute, value)
			message = "Your %s has been increased by %s points" % [ATTRIBUTE.keys()[attribute], value]
		else:
			message = ""
		Signals.log.emit("%s picked up a %s. %s" % [body.name, item_name, message])
		queue_free()

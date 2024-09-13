extends Area2D

@export var item_needed: String


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player":
		if body.inventory.has(item_needed):
			Signals.log.emit("You have used the %s" % [item_needed])

extends Label


func _ready() -> void:
	Signals.log.connect(_on_log_event)


func _on_log_event(message) -> void:
	text = message
	await get_tree().create_timer(5.0).timeout
	text = ""

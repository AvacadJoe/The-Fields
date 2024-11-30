extends HSlider

func _ready() -> void:
    value_changed.connect(_on_value_changed)
    

func _on_value_changed(value: float) -> void:
    GameManager.camera_sens = value

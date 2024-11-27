extends Button

func _ready():
    self.connect("pressed",_button_pressed)

func _button_pressed():
    var tween = get_tree().create_tween()
    tween.tween_property(%FadeRect, "color", Color(0, 0, 0, 1), 2)
    %PlayButton.hide()
    %QuitButton.hide()
    %Title.hide()
    await get_tree().create_timer(2).timeout
    %WorldEnvironment.environment.volumetric_fog_enabled = false
    get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

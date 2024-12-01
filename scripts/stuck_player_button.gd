extends Button

func _ready():
    self.connect("pressed",_button_pressed)

func _button_pressed():
    %WorldEnvironment.fade_to_reset()

extends Button

func _ready():
    self.connect("pressed",_button_pressed)

func _button_pressed():
    %EscMenu.hide()
    %Player.capture_mouse()

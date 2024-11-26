extends ColorRect

var leaving_color = Color(1,1,1,1)

@export var text_color_bright = Color(1,1,1,1)
@export var text_color_dark = Color(0,0,0,1)

var in_credits = false
@onready var credits = %CreditsText

func _process(delta):
    if in_credits and Input.is_anything_pressed():
        get_tree().quit()

    if GameManager.ending_job:
        leaving_color = Color(0,0,0,1)
        credits.add_theme_color_override("default_color", text_color_bright)
        end_game()
    elif GameManager.ending_leave:
        leaving_color = Color(1,1,1,1)
        credits.add_theme_color_override("default_color", text_color_dark)
        end_game()
    elif GameManager.ending_stay:
        leaving_color = Color(0,0,0,1)
        credits.add_theme_color_override("default_color", text_color_bright)
        end_game()
    pass

func end_game():
    self.show()
    %CluesLabel.hide()
    var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(self, "color", leaving_color, 5)
    tween.tween_callback(credits.show)   
    await get_tree().create_timer(7).timeout
    in_credits = true
    pass

extends Node


var balloon_unlocked = true :
    set (value):
        balloon_unlocked = value
        %BalloonLabel.visible = value
    get:
        return balloon_unlocked


var flashlight_unlocked = true :
    set (value):
        flashlight_unlocked = value
        %FlashlightLabel.visible = value
    get:
        return flashlight_unlocked

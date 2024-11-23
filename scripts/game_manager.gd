extends Node

var balloon_unlocked = false :
    set (value):
        balloon_unlocked = value
    get:
        return balloon_unlocked

var flashlight_unlocked = false :
    set (value):
        flashlight_unlocked = value
    get:
        return flashlight_unlocked

# Quest variables
var ghost_hunt_started = false
var pinky = false
var inky  = false
var sue = false
var clyde = false

extends Node

###Player###
#movement attributes
var fwd_speed = -8.0
var fall_accel = 65
var jump_force = 15
var grav_scale = 1
var steer_speed = 10

###Resources and Score###
var water_lvl = 0
var high_score = 0

###Pickups###
var small_water = 10
var big_water = 20
var time_pickup = 5.0

###Timer Attributes###
var base_time = 30.0

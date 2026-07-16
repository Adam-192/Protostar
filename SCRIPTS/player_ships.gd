extends Node


@onready var ship_skins := {
	1: [
		preload("res://SPRITES/Player/Ship1/skin1.png"),
		preload("res://SPRITES/Player/Ship1/skin2.png"),
		preload("res://SPRITES/Player/Ship1/skin3.png"),
		preload("res://SPRITES/Player/Ship1/skin4.png"),
		preload("res://SPRITES/Player/Ship1/skin5.png")
	],
	
	2:[
		preload("res://SPRITES/Player/Ship2/skin1.png"),
		preload("res://SPRITES/Player/Ship2/skin2.png"),
		preload("res://SPRITES/Player/Ship2/skin3.png"),
		preload("res://SPRITES/Player/Ship2/skin4.png"),
		preload("res://SPRITES/Player/Ship2/skin5.png")
	],
	
	3:[
		preload("res://SPRITES/Player/Ship3/skin1.png"),
		preload("res://SPRITES/Player/Ship3/skin2.png"),
		preload("res://SPRITES/Player/Ship3/skin3.png"),
		preload("res://SPRITES/Player/Ship3/skin4.png"),
		preload("res://SPRITES/Player/Ship3/skin5.png")
	],
	
	4:[
		preload("res://SPRITES/Player/Ship4/skin1.png"),
		preload("res://SPRITES/Player/Ship4/skin2.png"),
		preload("res://SPRITES/Player/Ship4/skin3.png"),
		preload("res://SPRITES/Player/Ship4/skin4.png"),
		preload("res://SPRITES/Player/Ship4/skin5.png")
	],
	
	5:[
		preload("res://SPRITES/Player/Ship5/skin1.png"),
		preload("res://SPRITES/Player/Ship5/skin2.png"),
		preload("res://SPRITES/Player/Ship5/skin3.png"),
		preload("res://SPRITES/Player/Ship5/skin4.png"),
		preload("res://SPRITES/Player/Ship5/skin5.png")
	],
	
	6:[
		preload("res://SPRITES/Player/Ship6/skin1.png"),
		preload("res://SPRITES/Player/Ship6/skin2.png"),
		preload("res://SPRITES/Player/Ship6/skin3.png"),
		preload("res://SPRITES/Player/Ship6/skin4.png"),
		preload("res://SPRITES/Player/Ship6/skin5.png")
	],
	
	7:[
		preload("res://SPRITES/Player/Ship7/skin1.png"),
		preload("res://SPRITES/Player/Ship7/skin2.png"),
		preload("res://SPRITES/Player/Ship7/skin3.png"),
		preload("res://SPRITES/Player/Ship7/skin4.png"),
		preload("res://SPRITES/Player/Ship7/skin5.png")
	],
	
	8:[
		preload("res://SPRITES/Player/Ship8/skin1.png"),
		preload("res://SPRITES/Player/Ship8/skin2.png"),
		preload("res://SPRITES/Player/Ship8/skin3.png"),
		preload("res://SPRITES/Player/Ship8/skin4.png"),
		preload("res://SPRITES/Player/Ship8/skin5.png")
	],
	
	9:[
		preload("res://SPRITES/Player/Ship9/skin1.png"),
		preload("res://SPRITES/Player/Ship9/skin2.png"),
		preload("res://SPRITES/Player/Ship9/skin3.png"),
		preload("res://SPRITES/Player/Ship9/skin4.png"),
		preload("res://SPRITES/Player/Ship9/skin5.png")
	],
	
	10:[
		preload("res://SPRITES/Player/Ship10/skin1.png"),
		preload("res://SPRITES/Player/Ship10/skin2.png"),
		preload("res://SPRITES/Player/Ship10/skin3.png"),
		preload("res://SPRITES/Player/Ship10/skin4.png"),
		preload("res://SPRITES/Player/Ship10/skin5.png"),
		preload("res://SPRITES/Player/Ship10/skin6.png"),
		preload("res://SPRITES/Player/Ship10/skin7.png")
	],
	
	11:[
		preload("res://SPRITES/Player/Ship11/skin1.png"),
		preload("res://SPRITES/Player/Ship11/skin2.png"),
		preload("res://SPRITES/Player/Ship11/skin3.png"),
		preload("res://SPRITES/Player/Ship11/skin4.png"),
		preload("res://SPRITES/Player/Ship11/skin5.png"),
		preload("res://SPRITES/Player/Ship11/skin6.png"),
		preload("res://SPRITES/Player/Ship11/skin7.png")
	],
	
	12:[
		preload("res://SPRITES/Player/Ship12/skin1.png"),
		preload("res://SPRITES/Player/Ship12/skin2.png"),
		preload("res://SPRITES/Player/Ship12/skin3.png"),
		preload("res://SPRITES/Player/Ship12/skin4.png"),
		preload("res://SPRITES/Player/Ship12/skin5.png"),
		preload("res://SPRITES/Player/Ship12/skin6.png"),
		preload("res://SPRITES/Player/Ship12/skin7.png")
	],
	
	13:[
		preload("res://SPRITES/Player/Ship13/skin1.png"),
		preload("res://SPRITES/Player/Ship13/skin2.png"),
		preload("res://SPRITES/Player/Ship13/skin3.png"),
		preload("res://SPRITES/Player/Ship13/skin4.png"),
		preload("res://SPRITES/Player/Ship13/skin5.png"),
		preload("res://SPRITES/Player/Ship13/skin6.png"),
		preload("res://SPRITES/Player/Ship13/skin7.png")
	],
	
	14:[
		preload("res://SPRITES/Player/Ship14/skin1.png"),
		preload("res://SPRITES/Player/Ship14/skin2.png"),
		preload("res://SPRITES/Player/Ship14/skin3.png"),
		preload("res://SPRITES/Player/Ship14/skin4.png"),
		preload("res://SPRITES/Player/Ship14/skin5.png"),
		preload("res://SPRITES/Player/Ship14/skin6.png"),
		preload("res://SPRITES/Player/Ship14/skin7.png")
	]
}

@onready var ship_skins_select_color := {
	1: [
		Color(0.0, 0.4, 0.0, 1.0),
		Color(0.122, 0.43, 0.457, 1.0),
		Color(0.175, 0.303, 0.275, 1.0),
		Color(0.284, 0.198, 0.299, 1.0),
		Color(0.325, 0.483, 0.847, 1.0)
	],
	
	2:[
		Color(0.498, 0.024, 0.137, 1.0),
		Color(0.173, 0.409, 0.217, 1.0),
		Color(0.357, 0.0, 0.049, 1.0),
		Color(0.154, 0.313, 0.474, 1.0),
		Color(0.089, 0.294, 0.264, 1.0)
	],
	
	3:[
		Color(0.0, 0.529, 0.139, 1.0),
		Color(0.365, 0.307, 0.533, 1.0),
		Color(0.164, 0.237, 0.122, 1.0),
		Color(0.377, 0.105, 0.526, 1.0),
		Color(0.195, 0.038, 0.126, 1.0)
	],
	
	4:[
		Color(0.0, 0.66, 0.182, 1.0),
		Color(0.194, 0.267, 0.2, 1.0),
		Color(0.357, 0.036, 0.341, 1.0),
		Color(0.078, 0.108, 0.428, 1.0),
		Color(0.205, 0.46, 0.267, 1.0)
	],
	
	5:[
		Color(0.23, 0.698, 0.785, 1.0),
		Color(0.326, 0.766, 0.297, 1.0),
		Color(0.451, 0.114, 0.172, 1.0),
		Color(0.165, 0.161, 0.376, 1.0),
		Color(0.174, 0.37, 0.246, 1.0)
	],
	6:[
		Color(0.0, 0.389, 0.092, 1.0),
		Color(0.17, 0.317, 0.329, 1.0),
		Color(0.626, 0.143, 0.3, 1.0),
		Color(0.152, 0.353, 0.662, 1.0),
		Color(0.457, 0.23, 0.627, 1.0)
	],
	7:[
		Color(0.188, 0.417, 0.227, 1.0),
		Color(0.133, 0.321, 0.308, 1.0),
		Color(0.625, 0.144, 0.255, 1.0),
		Color(0.148, 0.195, 0.677, 1.0),
		Color(0.461, 0.214, 0.482, 1.0)
	],
	8:[
		Color(0.3, 0.507, 0.486, 1.0),
		Color(0.222, 0.377, 0.369, 1.0),
		Color(0.111, 0.205, 0.275, 1.0),
		Color(0.124, 0.314, 0.148, 1.0),
		Color(0.18, 0.066, 0.184, 1.0)
	],
	9:[
		Color(0.216, 0.399, 0.399, 1.0),
		Color(0.198, 0.677, 0.35, 1.0),
		Color(0.176, 0.021, 0.596, 1.0),
		Color(0.398, 0.165, 0.076, 1.0),
		Color(0.263, 0.047, 0.104, 1.0)
	],
	
	
	10:[
		Color(0.328, 0.722, 0.769, 1.0),
		Color(0.322, 0.559, 0.269, 1.0),
		Color(0.149, 0.295, 0.482, 1.0),
		Color(0.699, 0.394, 0.119, 1.0),
		Color(0.347, 0.028, 0.411, 1.0),
		Color(0.601, 0.113, 0.102, 1.0),
		Color(0.854, 0.762, 0.226, 1.0)
	],
	11:[
		Color(0.328, 0.722, 0.769, 1.0),
		Color(0.322, 0.559, 0.269, 1.0),
		Color(0.149, 0.295, 0.482, 1.0),
		Color(0.699, 0.394, 0.119, 1.0),
		Color(0.347, 0.028, 0.411, 1.0),
		Color(0.601, 0.113, 0.102, 1.0),
		Color(0.854, 0.762, 0.226, 1.0)
	],
	12:[
		Color(0.328, 0.722, 0.769, 1.0),
		Color(0.322, 0.559, 0.269, 1.0),
		Color(0.149, 0.295, 0.482, 1.0),
		Color(0.699, 0.394, 0.119, 1.0),
		Color(0.347, 0.028, 0.411, 1.0),
		Color(0.601, 0.113, 0.102, 1.0),
		Color(0.854, 0.762, 0.226, 1.0)
	],
	13:[
		Color(0.328, 0.722, 0.769, 1.0),
		Color(0.322, 0.559, 0.269, 1.0),
		Color(0.149, 0.295, 0.482, 1.0),
		Color(0.699, 0.394, 0.119, 1.0),
		Color(0.347, 0.028, 0.411, 1.0),
		Color(0.601, 0.113, 0.102, 1.0),
		Color(0.854, 0.762, 0.226, 1.0)
	],
	14:[
		Color(0.328, 0.722, 0.769, 1.0),
		Color(0.322, 0.559, 0.269, 1.0),
		Color(0.149, 0.295, 0.482, 1.0),
		Color(0.699, 0.394, 0.119, 1.0),
		Color(0.347, 0.028, 0.411, 1.0),
		Color(0.601, 0.113, 0.102, 1.0),
		Color(0.854, 0.762, 0.226, 1.0)
	],
}

#var ship_skins_unlocked := {
	#1: [1,1,1,1,1],
	#
	#2:[1,1,1,1,1],
	#
	#3:[1,1,1,1,1],
	#
	#4:[1,1,1,1,1],
	#
	#5:[1,1,1,1,1],
	#
	#6:[1,1,1,1,1],
	#
	#7:[1,1,1,1,1],
	#
	#8:[1,1,1,1,1],
	#
	#9:[1,1,1,1,1],
	#
	#10:[1,1,1,1,1,1,1],
	#
	#11:[1,1,1,1,1,1,1],
	#
	#12:[1,1,1,1,1,1,1],
	#
	#13:[1,1,1,1,1,1,1],
	#
	#14:[1,1,1,1,1,1,1],
#}

var ship_skins_unlocked := {
	1: [0,0,0,0,0],
	
	2:[0,0,0,0,0],
	
	3:[0,0,0,0,0],
	
	4:[0,0,0,0,0],
	
	5:[0,0,0,0,0],
	
	6:[1,0,1,1,0],
	
	7:[1,0,0,0,0],
	
	8:[1,0,0,0,0],
	
	9:[0,0,0,0,0],
	
	10:[0,0,0,0,0,0,0],
	
	11:[0,0,0,0,0,0,0],
	
	12:[0,0,0,0,0,0,0],
	
	13:[0,0,0,0,0,0,0],
	
	14:[0,0,0,0,0,0,0],
}

class_name ModifiersTooltipElement extends HBoxContainer

@onready var modifier_name = $ModifierName
@onready var multiplier = $Multiplier
@onready var resource_icon = $ResourceIcon

@export var modifier: MultiplicationModifier

func _ready():
	modifier_name.text = modifier.modifier_name
	multiplier.text = str(modifier.multiplication_factor)

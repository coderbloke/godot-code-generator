@tool
class_name CodeGeneratorTemplateAction extends Object

@export var tag: String:
	set(new_value):
		if new_value != tag:
			tag = new_value
			emit_changed()
			
@export var close_tag: String:
	set(new_value):
		if new_value != close_tag:
			close_tag = new_value
			emit_changed()
			
@export var comment_handling: CodeGenerator.CommentHandling:
	set(new_value):
		if new_value != comment_handling:
			comment_handling = new_value
			emit_changed()

@export var action_method: String:
	set(new_value):
		if new_value != action_method:
			action_method = new_value
			emit_changed()

@export var method_receives_object: bool:
	set(new_value):
		if new_value != method_receives_object:
			method_receives_object = new_value
			emit_changed()

@export var prefix_handling: CodeGenerator.PrefixHandling:
	set(new_value):
		if new_value != prefix_handling:
			prefix_handling = new_value
			emit_changed()

@export var additional_indent: int = 0:
	set(new_value):
		if new_value != additional_indent:
			additional_indent = new_value
			emit_changed()

@export var suffix_handling: CodeGenerator.SuffixHandling:
	set(new_value):
		if new_value != suffix_handling:
			suffix_handling = new_value
			emit_changed()

signal changed()

func emit_changed():
	changed.emit()
	
#func _get_property_list():
#	var properties = []
#	properties.append({
#		"name": "tag",
#		"class_name": "",
#		"type": TYPE_STRING,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_NONE,
#		"hint_string": ""
#	})
#	properties.append({
#		"name": "details/close_tag",
#		"class_name": "",
#		"type": TYPE_STRING,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_NONE,
#		"hint_string": ""
#	})
#	properties.append({
#		"name": "details/comment_handling",
#		"class_name": "",
#		"type": TYPE_INT,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_ENUM,
#		"hint_string": ",".join(CodeGenerator.CommentHandling.keys().map(func (s): return s.capitalize()))
#	})
#	properties.append({
#		"name": "details/action_method",
#		"class_name": "",
#		"type": TYPE_STRING,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_NONE,
#		"hint_string": ""
#	})
#	properties.append({
#		"name": "details/method_receives_object",
#		"class_name": "",
#		"type": TYPE_BOOL,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_NONE,
#		"hint_string": ""
#	})
#	properties.append({
#		"name": "details/prefix_handling",
#		"class_name": "",
#		"type": TYPE_INT,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_ENUM,
#		"hint_string": ",".join(CodeGenerator.PrefixHandling.keys().map(func (s): return s.capitalize()))
#	})
#	properties.append({
#		"name": "details/additional_indent",
#		"class_name": "",
#		"type": TYPE_INT,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_NONE,
#		"hint_string": ""
#	})
#	properties.append({
#		"name": "details/suffix_handling",
#		"class_name": "",
#		"type": TYPE_INT,
#		"usage": PROPERTY_USAGE_DEFAULT,
#		"hint": PROPERTY_HINT_ENUM,
#		"hint_string": ",".join(CodeGenerator.SuffixHandling.keys().map(func (s): return s.capitalize()))
#	})
#	return properties
#
#func _set(property: StringName, value: Variant):
#	print("[_set] %s = %s" % [property, value])
#	property = property.trim_prefix("details/")
#	print("[_set] %s = %s" % [property, value])
#	match property:
#		"tag":
#			tag = value
#		"close_tag":
#			close_tag = value
#		"comment_handling":
#			comment_handling = value
#		"action_method":
#			action_method = value
#		"method_receives_object":
#			method_receives_object = value
#		"prefix_handling":
#			prefix_handling = value
#		"additional_indent":
#			additional_indent = value
#		"suffix_handling":
#			suffix_handling = value
#
#func _get(property: StringName) -> Variant:
#	property = property.trim_prefix("details/")
#	match property:
#		"tag":
#			return tag
#		"close_tag":
#			return close_tag
#		"comment_handling":
#			return comment_handling
#		"action_method":
#			return action_method
#		"method_receives_object":
#			return method_receives_object
#		"prefix_handling":
#			return prefix_handling
#		"additional_indent":
#			return additional_indent
#		"suffix_handling":
#			return suffix_handling
#	return null
#
func _hide_script_from_inspector():
	return true

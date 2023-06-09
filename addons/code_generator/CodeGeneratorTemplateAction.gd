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

@export var action_type: CodeGenerator.ActionType:
	set(new_value):
		if new_value != action_type:
			action_type = new_value
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

@export var comment_handling: CodeGenerator.CommentHandling:
	set(new_value):
		if new_value != comment_handling:
			comment_handling = new_value
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

func _hide_script_from_inspector():
	return true

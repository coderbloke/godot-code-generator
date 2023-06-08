@tool
class_name CodeGeneratorTemplateAction extends Resource

@export var tag: String:
	set(new_value):
		if new_value != tag:
			tag = new_value
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

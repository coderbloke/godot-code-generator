# godot-code-generator

A lightweight Godot library for code generation from template (or just for any general text template processing)

You can generate output (e.g. script):
- From a source template file containing tags
- According to generator specification, where you describe the tags
- Using a context (any object), which provides to subtitution for the tags 

Driving force:
- Was needed for this: https://github.com/coderbloke/godot-inspector-architect<br>
  Code snippets coming from different places, they put together into a script, which then can be loaded and used dynamically on-the-fly
- It turned out to be a quite neat reusable, even int he early phase
  Can be help usefull for anyone
  
Contact:
- Indicate/share your presence, interest, ideas, give inspiration, or ask here:<br>
  [ https://github.com/coderbloke/godot-code-generator/discussions/5 ](https://github.com/coderbloke/godot-code-generator/discussions/5)
- See already existing plans/progress/issues, suggest or indiate new ones here:<br>
  https://github.com/coderbloke/godot-code-generator/issues

Usage
--

1. Make source tample files. Put tags into it, where you want text substitution. (First image / Left side)<br>
   Tags don't have any predefined form. They are just simple tags you define later, so you don't have to follow the below example.<br>
   
   With possibilty of different way of handling comment and prefixes by the generator, it is possible to make such a template file,<br>
   which is syntactically/semantically a correct source file, so won't be full of compiler errors for example.
   
2. Make a`CodeGeneratorSpecification` specification resource. (First image / Right side)<br>
   Define your tags (any text, no fixed format). Specify how the generator should handle the surrounding of the tags.
   Specify methods names (Action Method), from which the generator will get the text to insert, and which will be implemented in the context object.
   
3. Implement the methods in your class, which will serve as context for the generator.<br>
   Currently these are simple function returning string (as not yet other feature in the generator yet, which would require else.)
   Built your text in this functions. You don't have to care about the indentification outside the tags.
   Just deal with the indentification of your snippets. The generator will extend the indentification according to the source template.
   (Currently you have to use tabs or spaces as they will be required in the out file. But auto converting ident format is planned.)
 

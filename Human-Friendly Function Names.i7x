Version 1 of Human-Friendly Function Names (for Glulx only) by Brady Garvin begins here.

"Facilities for printing and parsing human-friendly names for Glulx functions."

Include Compiler Version Checks by Brady Garvin.
Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

Chapter "Use Options" - unindexed

Use a function name hash table size of at least 2311 translates as (- Constant HFFN_FUNCTION_NAME_HASH_SIZE={N}; -).

To decide what number is the function name hash table size: (- HFFN_FUNCTION_NAME_HASH_SIZE -).

Chapter "Rulebooks"

The function name setup rules are [rulebook is] a rulebook.
The function-naming rules are [rulebook is] a rulebook.

Book "Phrase Stubs"

Chapter "Routine Kernel Guessing might be Unavailable without GRIF" (for use without Glulx Runtime Instrumentation Framework by Brady Garvin)

Section "Routine Kernel Guessing is Unavailable without GRIF or Debug File Parsing" (for use without Debug File Parsing by Brady Garvin)

To guess the routine kernel for (A - a sayable value):
	do nothing.

Book "Lazy Initialization" - unindexed

Chapter "Lazily Initializing Shell-and-Kernel Storage" - unindexed

Shell-and-kernel storage initialized is a truth state that varies.  Shell-and-kernel storage initialized is false.

To ensure that the shell-and-kernel storage is initialized:
	if shell-and-kernel storage initialized is false:
		now shell-and-kernel storage initialized is true;
		allocate permanent hash tables for routine shells and kernels.

Chapter "Lazily Initializing Human-Friendly Function Names" - unindexed

Human-friendly function names initialized is a truth state that varies.  Human-friendly function names initialized is false.

To ensure that the human-friendly function names are initialized:
	ensure that the shell-and-kernel storage is initialized;
	if human-friendly function names initialized is false:
		now human-friendly function names initialized is true;
		traverse the function name setup rulebook;
		traverse the function-naming rulebook.

Book "Permanent Hash Tables"

Chapter "Rule Hash Tables" - unindexed

[Map a function address to a text extracted from the I6 routine RulePrintingRule.]
The rule name hash table is a permanent hash table that varies.
[Map a canonical rule name to a function address.]
The rule lookup hash table is a permanent hash table that varies.

A function name setup rule (this is the allocate permanent hash tables for rule names rule):
	now the rule name hash table is a new permanent hash table with the function name hash table size buckets;
	now the rule lookup hash table is a new permanent hash table with the function name hash table size buckets.

Section "Rule Hash Table Accessors" - unindexed

To decide what text is the name for the rule at address (A - a number) (this is determining the name of a rule):
	ensure that the human-friendly function names are initialized;
	decide on the first text value matching the key A in the rule name hash table or "" if there are no matches.

To decide what linked list is the list of function addresses for the rules with the canonical name (T - some text) (this is determining the rules matching a name):
	ensure that the human-friendly function names are initialized;
	let the result be an empty linked list;
	repeat with the address running through the number values matching the textual key T in the rule lookup hash table:
		push the key address onto the result;
	decide on the result.

Section "Rule Hash Table Mutators"

To give the rule at address (A - a number) the rule name (T - some text):
	insert the key A and the value T into the rule name hash table;
	let the canonical input form be the canonical input form of the function name T;
	insert the textual key the canonical input form and the value A into the rule lookup hash table.

Chapter "Phrase Hash Tables" - unindexed

[Map a function address to a text extracted from the I6 Closure_* arrays or else a phrase preamble.]
The phrase name hash table is a permanent hash table that varies.
[Map a canonical phrase name to a function address.]
The phrase lookup hash table is a permanent hash table that varies.

A function name setup rule (this is the allocate permanent hash tables for phrase names rule):
	now the phrase name hash table is a new permanent hash table with the function name hash table size buckets;
	now the phrase lookup hash table is a new permanent hash table with the function name hash table size buckets.

Section "Phrase Hash Table Accessors" - unindexed

To decide what text is the name for the phrase function at address (A - a number) (this is determining the name of a phrase):
	ensure that the human-friendly function names are initialized;
	decide on the first text value matching the key A in the phrase name hash table or "" if there are no matches.

To decide what linked list is the list of function addresses for the phrases with the canonical name (T - some text) (this is determining the phrases matching a name):
	ensure that the human-friendly function names are initialized;
	let the result be an empty linked list;
	repeat with the address running through the number values matching the textual key T in the phrase lookup hash table:
		push the key address onto the result;
	decide on the result.

Section "Phrase Hash Table Mutators"

To give the phrase function at address (A - a number) the phrase name (T - some text):
	insert the key A and the value T into the phrase name hash table;
	let the canonical input form be the canonical input form of the function name T;
	insert the textual key the canonical input form and the value A into the phrase lookup hash table.

Chapter "Routine Hash Tables" - unindexed

[Map a function address to a text provided by something like the extension I6 Routine Names.]
The routine name hash table is a permanent hash table that varies.
[Map a I6 routine name to a function address.]
The routine lookup hash table is a permanent hash table that varies.
[Map a veneer routine's function address to a truth state, true if the routine is known to be overridden, false if it is known not to be.  Non-veneer routines should not be keys.]
The veneer routine override hash table is a permanent hash table that varies.
[Map a function address to a text that describes the routine's purpose, e.g. "displaying a box quote" for the I6 routine Box__Routine.]
The function annotation hash table is a permanent hash table that varies.

A function name setup rule (this is the allocate permanent hash tables for routine names rule):
	now the routine name hash table is a new permanent hash table with the function name hash table size buckets;
	now the routine lookup hash table is a new permanent hash table with the function name hash table size buckets;
	now the veneer routine override hash table is a new permanent hash table with the function name hash table size buckets;
	now the function annotation hash table is a new permanent hash table with the function name hash table size buckets.

Section "Private Routine Hash Table Accessors" - unindexed

To decide what text is the name for the routine at address (A - a number) (this is determining the name of a routine):
	ensure that the human-friendly function names are initialized;
	decide on the first text value matching the key A in the routine name hash table or "" if there are no matches.

To decide what linked list is the list of function addresses for the routines with the canonical name (T - some text) (this is determining the routines matching a name):
	ensure that the human-friendly function names are initialized;
	let the result be an empty linked list;
	repeat with the address running through the number values matching the textual key T in the routine lookup hash table:
		push the key address onto the result;
	decide on the result.

Section "Public Routine Hash Table Accessors"

To decide whether the function at address (A - a number) is a veneer routine (this is determining whether a routine is a veneer routine):
	ensure that the human-friendly function names are initialized;
	decide on whether or not the veneer routine override hash table contains the key A.

To decide whether the function at address (A - a number) is a default veneer routine (this is determining whether a routine is a default veneer routine):
	ensure that the human-friendly function names are initialized;
	decide on whether or not (the first truth state value matching the key A in the veneer routine override hash table or true if there are no matches) is false.

To decide whether the function at address (A - a number) is an overridden veneer routine (this is determining whether a routine is an overridden veneer routine):
	ensure that the human-friendly function names are initialized;
	decide on the first truth state value matching the key A in the veneer routine override hash table or false if there are no matches.

To decide what text is the annotation for the function at address (A - a number) (this is determining a veneer routine annotation):
	ensure that the human-friendly function names are initialized;
	decide on the first text value matching the key A in the function annotation hash table or "" if there are no matches.

Section "Routine Hash Table Mutators"

To give the veneer routine at address (A - a number) the override flag (F - a truth state) and the routine name (T - some text) and the annotation (Z - some text) (this is naming each veneer routine):
	insert the key A and the value F into the veneer routine override hash table;
	insert the key A and the value T into the routine name hash table;
	let the canonical input form be the canonical input form of the function name T;
	insert the textual key the canonical input form and the value A into the routine lookup hash table;
	insert the key A and the value Z into the function annotation hash table.

To give the routine at address (A - a number) the routine name (T - some text) (this is naming each standard template routine):
	insert the key A and the value T into the routine name hash table;
	let the canonical input form be the canonical input form of the function name T;
	insert the textual key the canonical input form and the value A into the routine lookup hash table.

Chapter "Routine Shell Hash Tables" - unindexed

[Map a function address to the address of the routine shell that encloses it.  Non-kernels should not be keys.]
The routine shell hash table is a permanent hash table that varies.
[Map a function address to the address of the routine kernel that it encloses.  Non-shells should not be keys.]
The routine kernel hash table is a permanent hash table that varies.

To allocate permanent hash tables for routine shells and kernels:
	now the routine shell hash table is a new permanent hash table with the function name hash table size buckets;
	now the routine kernel hash table is a new permanent hash table with the function name hash table size buckets.

Section "Routine Shell Hash Table Accessors"

To decide what number is the routine shell address of the function at address (A - a number) (this is determining a routine shell):
	ensure that the shell-and-kernel storage is initialized;
	decide on the first number value matching the key A in the routine shell hash table or zero if there are no matches.

To decide what number is the routine kernel address of the function at address (A - a number) (this is determining a routine kernel):
	ensure that the shell-and-kernel storage is initialized;
	decide on the first number value matching the key A in the routine kernel hash table or zero if there are no matches.

Section "Routine Shell Hash Table Mutators"

To associate the routine shell at address (A - a number) with the routine kernel at address (B - a number) (this is associating a routine shell with a routine kernel):
	ensure that the shell-and-kernel storage is initialized;
	insert the key A and the value B into the routine kernel hash table;
	insert the key B and the value A into the routine shell hash table.

Chapter "Core Hash Tables" - unindexed

[Map a function address to a text that describes it in a standard, maximally unambiguous, human-friendly way.]
The human-friendly function name hash table is a permanent hash table that varies.

A function name setup rule (this is the allocate permanent hash tables for human-friendly function names rule):
	now the human-friendly function name hash table is a new permanent hash table with the function name hash table size buckets.

Book "Setup"

Chapter "Rules" - unindexed

[These magic numbers are fairly sensitive to the workings of both ni and the I6N compiler.]

To repeat with (I - a nonexisting number variable) running through the rule-printing branch addresses begin -- end: (-
	for({I}=RulePrintingRule+79:(llo_getInt({I})==624492800)&&(llo_getShort({I}+9)==29187):{I}={I}+18)
-).

To decide what number is the function address of the rule-printing branch at address (A - a number): (- llo_getField({A},1) -).
To decide what text is the name of the rule-printing branch at address (A - a number): (- llo_getInt({A}+11) -).

A function-naming rule (this is the name rules rule):
	repeat with the rule-printing branch address running through the rule-printing branch addresses:
		let the function address be the function address of the rule-printing branch at address rule-printing branch address;
		if the name for the rule at address function address is empty:
			let the name be the name of the rule-printing branch at address rule-printing branch address;
			give the rule at address function address the rule name name.

Chapter "Phrases" - unindexed

[These magic numbers are fairly sensitive to the workings of both ni and the I6N compiler.]

To repeat with (I - a nonexisting number variable) running through the phrase addresses begin -- end: (-
	for({I}=Closure_0:(llo_getField((+ the phrase that guarantees that we have at least one named phrase +),1))({I}):{I}={I}+12)
-).

To decide what number is the function address of the phrase at address (A - a number): (- llo_getField({A},1) -).
To decide what number is the name address of the phrase at address (A - a number): (- llo_getField({A},2) -).
To decide what text is the name of the phrase at address (A - a number): (- llo_getField({A},2) -).

To decide whether address (A - a number) could contain a phrase (this is the phrase that guarantees that we have at least one named phrase):
	let the function address be the function address of the phrase at address A;
	unless address function address could contain a function:
		decide no;
	let the name address be the name address of the phrase at address A;
	unless address name address could contain a string:
		decide no;
	decide yes.

A function-naming rule (this is the name phrases rule):
	repeat with the phrase address running through the phrase addresses:
		let the function address be the function address of the phrase at address phrase address;
		let the name be the name of the phrase at address phrase address;
		give the phrase function at address function address the phrase name name.

Chapter "Main" - unindexed

To decide what number is the address of I6_Main: (- Main -).

A function-naming rule (this is the name main rule):
	if the address of I6_Main is not zero:
		insert the key the address of I6_Main and the value "the main story routine" into the human-friendly function name hash table;
		insert the textual key "main" and the value the address of I6_Main into the routine lookup hash table;
		insert the textual key "main routine" and the value the address of I6_Main into the routine lookup hash table;
		insert the textual key "main story routine" and the value the address of I6_Main into the routine lookup hash table.

Book "Common Substrings" - unindexed

The source text rule keyword is some text that varies.
The source text definite article is some text that varies.
The source text indefinite article for vowel sounds is some text that varies.
The source text indefinite article for consonant sounds is some text that varies.
The zeroth canonically removed function name prefix is some text that varies.
The first canonically removed function name prefix is some text that varies.
The second canonically removed function name prefix is some text that varies.
The third canonically removed function name prefix is some text that varies.
The fourth canonically removed function name prefix is some text that varies.
The fifth canonically removed function name prefix is some text that varies.
The sixth canonically removed function name prefix is some text that varies.
The kernel prefix is some text that varies.
The kernel suffix is some text that varies.
A function name setup rule (this is the allocate the synthetic text for the routine shell prefix and suffix rule):
	now the source text rule keyword is a new permanent synthetic text copied from "rule";
	now the source text definite article is a new permanent synthetic text copied from "the ";
	now the source text indefinite article for vowel sounds is a new permanent synthetic text copied from "an ";
	now the source text indefinite article for consonant sounds is a new permanent synthetic text copied from "a ";
	now the zeroth canonically removed function name prefix is a new permanent synthetic text copied from "overridden i6 veneer routine ";
	now the first canonically removed function name prefix is a new permanent synthetic text copied from "overridden veneer routine ";
	now the second canonically removed function name prefix is a new permanent synthetic text copied from "overridden i6 routine ";
	now the third canonically removed function name prefix is a new permanent synthetic text copied from "i6 veneer routine ";
	now the fourth canonically removed function name prefix is a new permanent synthetic text copied from "veneer routine ";
	now the fifth canonically removed function name prefix is a new permanent synthetic text copied from "i6 routine ";
	now the sixth canonically removed function name prefix is a new permanent synthetic text copied from "routine ";
	now the kernel prefix is a new permanent synthetic text copied from "kernel of '";
	now the kernel suffix is a new permanent synthetic text copied from "'".

Book "Rewriting States" - unindexed

A function name rewrite state is a kind of value.
The function name rewrite states are transitioning to gobble whitespace, transitioning after function name whitespace, and transitioning after a function name symbol.
The specification of a function name rewrite state is "Function name rewrite states are used inside Human-Friendly Function Names to represent the various states that its function name canonicalizer, specifically the part dealing with punctuation and whitespace, can be in.  Transitioning to gobble whitespace means that whitespace is being removed completely, transitioning after function name whitespace means that one or more whitespace characters in the middle of a function name are being collapsed into a single space, and transitioning after a function name symbol means that no whitespace transformations are ongoing."

Book "Output"

Chapter "Canonical Output Forms of Rule and Phrase Names" - unindexed

To destructively say the canonical output form of the synthetic rule or phrase name (T - some text) with the article flag set to (F - a truth state):
	let the length be the length of the synthetic text T;
	if the length is at least two:
		let the second character code be the character code at index two of the synthetic text T;
		if the second character code is the Latin-1 character code second character code downcased:
			let the first character code be the character code at index one of the synthetic text T;
			now the first character code is the Latin-1 character code first character code downcased;
			write the character code first character code to index one of the synthetic text T;
	if F is true and the synthetic text T ends with the synthetic text the source text rule keyword:
		unless the synthetic text T begins with the synthetic text the source text definite article or the synthetic text T begins with the synthetic text the source text indefinite article for vowel sounds or the synthetic text T begins with the synthetic text the source text indefinite article for consonant sounds:
			say "[the source text definite article]";
	let the current state be transitioning to gobble whitespace;
	repeat with the character code running through the character codes in the synthetic text T:
		if the character code is:
			-- 32: [space]
				if the current state is transitioning after a function name symbol:
					now the current state is transitioning after function name whitespace;
			-- 40: [open parenthesis]
				say "[if the current state is transitioning after function name whitespace] [end if][the character code converted to a unicode character]";
				now the current state is transitioning to gobble whitespace;
			-- 41: [close parenthesis]
				say "[the character code converted to a unicode character]";
				now the current state is transitioning after a function name symbol;
			-- otherwise:
				say "[if the current state is transitioning after function name whitespace] [end if][the character code converted to a unicode character]";
				now the current state is transitioning after a function name symbol.

To decide what text is the canonical output form of the rule or phrase name (T - some text), adding an article if necessary:
	let the source be a new synthetic text copied from T;
	let the maximum length be the length of the synthetic text source plus the length of the synthetic text source text definite article;
	let the destination be a new uninitialized permanent synthetic text with length maximum length characters;
	overwrite the synthetic text destination with the text printed when we destructively say the canonical output form of the synthetic rule or phrase name source with the article flag set to whether or not adding an article if necessary;
	delete the synthetic text source;
	decide on the destination.

Chapter "Canonical Output Forms of Routine Names" - unindexed

To decide what text is the canonical output form of the routine name (T - some text) for the routine at address (A - a number):
	let the permanent linked list vertex be the first match for the key A in the veneer routine override hash table;
	let the annotation be the annotation for the function at address A;
	let the length be the length of T plus the length of the annotation plus 36;
	let the result be a new uninitialized permanent synthetic text with length length characters;
	overwrite the synthetic text result with the text printed when we say "the [if the permanent linked list vertex is null]I6[otherwise if the truth state value of the permanent linked list vertex is true]overridden I6 veneer[otherwise]I6 veneer[end if] routine [T converted to some text][if the annotation is not empty] ([the annotation])[end if]";
	decide on the result.

Chapter "Human-Friendly Output Names"

To decide whether the function at address (A - a number) already has a human-friendly name:
	decide on whether or not the rule name hash table contains the key A or the phrase name hash table contains the key A or the routine shell hash table contains the key A or the routine name hash table contains the key A.

To decide what text is the human-friendly name for the function at address (A - a number) (this is determining the human-friendly name of a function):
	ensure that the human-friendly function names are initialized;
	let the result be the first text value matching the key A in the human-friendly function name hash table or "" if there are no matches;
	if the result is not empty:
		decide on the result;
	now the result is the name for the rule at address A;
	if the result is not empty:
		now the result is the canonical output form of the rule or phrase name result, adding an article if necessary;
	otherwise:
		now the result is the name for the phrase function at address A;
		if the result is not empty:
			now the result is the canonical output form of the rule or phrase name result;
		otherwise:
			let the routine shell address be the routine shell address of the function at address A;
			if the routine shell address is not zero:
				let the shell name be the human-friendly name for the function at address routine shell address;
				let the length be 16 plus the length of the synthetic text shell name;
				now the result is a new uninitialized permanent synthetic text with length length characters;
				overwrite the synthetic text result with the text printed when we say "the kernel of '[the shell name]'";
			otherwise:
				now the result is the name for the routine at address A;
				if the result is not empty:
					now the result is the canonical output form of the routine name result for the routine at address A;
				otherwise:
					decide on "an unnamed rule or phrase";
	insert the key A and the value result into the human-friendly function name hash table;
	decide on the result.

Book "Input"

Chapter "Removing Parentheticals and Normalizing Spacing" - unindexed

To decide whether (C - a number) is a character code for punctuation: (- (({C}>=33)&&({C}<=47)||({C}>=58)&&({C}<=64)||({C}>=91)&&({C}<=96)||({C}>=123)&&({C}<=126)) -).

To say (T - some text) after removing parentheticals and normalizing spacing:
	let the current state be transitioning to gobble whitespace;
	let the nesting level be zero;
	repeat with the character code running through the character codes in the synthetic text T:
		if the character code is:
			-- 32: [space]
				if the nesting level is zero and the current state is transitioning after a function name symbol:
					now the current state is transitioning after function name whitespace;
			-- 40: [open parenthesis]
				increment the nesting level;
			-- 41: [close parenthesis]
				decrement the nesting level;
			-- otherwise:
				if the nesting level is zero:
					let the punctuation flag be whether or not the character code is a character code for punctuation;
					say "[if the punctuation flag is true or the current state is transitioning after function name whitespace] [end if][the character code converted to a unicode character]";
					if the punctuation flag is true:
						now the current state is transitioning after function name whitespace;
					otherwise:
						now the current state is transitioning after a function name symbol.

To decide what text is the synthetic text (T - some text) after removing parentheticals and normalizing spacing:
	let the length be the length of the synthetic text T;
	let the destination be a new uninitialized permanent synthetic text with length two times length characters;
	overwrite the synthetic text destination with the text printed when we say T after removing parentheticals and normalizing spacing;
	decide on the destination.

Chapter "The Canonical Input Form" - unindexed

To decide what text is the canonical input form of the function name (T - some text) (this is determining the canonical input form of a function name):
	ensure that the human-friendly function names are initialized;
	let the downcased original be a new synthetic text copied from T;
	downcase the synthetic text downcased original;
	let the result be the synthetic text downcased original after removing parentheticals and normalizing spacing;
	delete the synthetic text downcased original;
	[Performance: These substring operations could be faster, if profiling shows a bottleneck here.]
	possibly remove the synthetic text prefix source text definite article from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix source text indefinite article for vowel sounds from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix source text indefinite article for consonant sounds from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the zeroth canonically removed function name prefix from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the first canonically removed function name prefix from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the second canonically removed function name prefix from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the third canonically removed function name prefix from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the fourth canonically removed function name prefix from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the fifth canonically removed function name prefix from the beginning of the synthetic text result;
	possibly remove the synthetic text prefix the sixth canonically removed function name prefix from the beginning of the synthetic text result;
	decide on the result.

Chapter "General Lookup"

To decide what linked list is the list of addresses matching the function name (T - some text) (this is determining the functions matching a name):
	ensure that the human-friendly function names are initialized;
	let the downcased original be a new synthetic text copied from T;
	downcase the synthetic text downcased original;
	let the name be the synthetic text downcased original after removing parentheticals and normalizing spacing;
	delete the synthetic text downcased original;
	[These substring operations could be faster, if profiling shows a bottleneck here.]
	possibly remove the synthetic text prefix source text definite article from the beginning of the synthetic text name;
	possibly remove the synthetic text prefix source text indefinite article for vowel sounds from the beginning of the synthetic text name;
	possibly remove the synthetic text prefix source text indefinite article for consonant sounds from the beginning of the synthetic text name;
	let the result be an empty linked list;
	if the synthetic text name begins with the synthetic text kernel prefix and the synthetic text name ends with the synthetic text kernel suffix:
		let the prefix length be the length of the synthetic text kernel prefix;
		let the suffix length be the length of the synthetic text kernel suffix;
		remove prefix length characters from the beginning of the synthetic text name;
		remove suffix length characters from the end of the synthetic text name;
		let the shell list be the list of addresses matching the function name name;
		repeat with the routine shell address running through the number keys of the shell list:
			guess the routine kernel for the routine shell address;
			let the routine kernel address be the routine kernel address of the function at address routine shell address;
			if the routine kernel address is not zero:
				push the key routine kernel address onto the result;
		decide on the result;
	let the rules-and-phrases flag be true;
	let the non-veneer routines flag be true;
	let the default veneer routines flag be true;
	if we successfully remove the synthetic text prefix the zeroth canonically removed function name prefix from the beginning of the synthetic text name or we successfully remove the synthetic text prefix the first canonically removed function name prefix from the beginning of the synthetic text name or we successfully remove the synthetic text prefix the second canonically removed function name prefix from the beginning of the synthetic text name:
		now the rules-and-phrases flag is false;
		now the non-veneer routines flag is false;
		now the default veneer routines flag is false;
	if we successfully remove the synthetic text prefix the third canonically removed function name prefix from the beginning of the synthetic text name or we successfully remove the synthetic text prefix the fourth canonically removed function name prefix from the beginning of the synthetic text name:
		now the rules-and-phrases flag is false;
		now the non-veneer routines flag is false;
	if we successfully remove the synthetic text prefix the fifth canonically removed function name prefix from the beginning of the synthetic text name or we successfully remove the synthetic text prefix the sixth canonically removed function name prefix from the beginning of the synthetic text name:
		now the rules-and-phrases flag is false;
	if the rules-and-phrases flag is true:
		let the address list be the list of function addresses for the rules with the canonical name name;
		repeat with the address running through the number keys of the address list:
			push the key address onto the result;
		delete the address list;
		now the address list is the list of function addresses for the phrases with the canonical name name;
		repeat with the address running through the number keys of the address list:
			push the key address onto the result;
		delete the address list;
	let the address list be the list of function addresses for the routines with the canonical name name;
	repeat with the address running through the number keys of the address list:
		if the non-veneer routines flag is true or the function at address address is a veneer routine:
			if the default veneer routines flag is true or the function at address address is an overridden veneer routine:
				push the key address onto the result;
	delete the address list;
	decide on the result.

Book "Shielding" (for use with Glulx Runtime Instrumentation Framework by Brady Garvin)

A GRIF shielding rule (this is the shield human-friendly function name rules and phrases rule):
	shield determining the name of a rule against instrumentation;
	shield determining the rules matching a name against instrumentation;
	shield determining the name of a phrase against instrumentation;
	shield determining the phrases matching a name against instrumentation;
	shield determining the name of a routine against instrumentation;
	shield determining the routines matching a name against instrumentation;
	shield determining whether a routine is a veneer routine against instrumentation;
	shield determining whether a routine is an overridden veneer routine against instrumentation;
	shield determining a veneer routine annotation against instrumentation;
	shield determining a routine shell against instrumentation;
	shield determining a routine kernel against instrumentation;
	shield associating a routine shell with a routine kernel against instrumentation;
	shield determining the human-friendly name of a function against instrumentation;
	shield determining the canonical input form of a function name against instrumentation;
	shield determining the functions matching a name against instrumentation.

Human-Friendly Function Names ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Human-Friendly Function Names allows debugging extensions to print rules,
phrases, and other functions in a form that the author is likely to understand,
such as "instead of jumping", "the start in the correct scenes rule",
"doubling", or the "the I6 routine ScopeCeiling", even when the debugging tool
doesn't know the kind of the function.  The extension also makes it possible to
parse these names.

Details are in the following chapters.

Chapter: Usage

Section: Introduction

By the time a story has been compiled for the Glulx virtual machine, every bit
of source text capable of changing the world at runtime has been stashed away in
one or more Glulx functions.  These functions correspond almost exactly to
Inform 6 routines, some of which come from I7 rules or I7 phrases.  For each
function and each way of thinking about a function, Human-Friendly Function
Names tracks a set of names.  For instance, the function that implements this
rule:

	Instead of waving hands: say "You wave hello."

would be called by one name,

	"instead of waving hands"

when we think about it as a rule, but perhaps

	"the I6 routine R_2748"

when we regard it as an I6 routine.  It would have no known names if we treated
it as a phrase, since it isn't one.

There are some complications, first of all because rules and phrases might
compile to two I6 routines instead of one.  For example, the rule

	Instead of singing: let a temporary value be some indexed text.

will normally be converted to an outer routine---"R_2750" perhaps---that
reserves memory for the indexed text, invokes an inner routine with a name like
"R_SHELL_0", and then frees the memory up again.  Here we call the outer routine
a "routine shell" and the inner one a "routine kernel" (though this is a little
confusing because the kernel has the word "SHELL" in its name).  The shell is
named normally, that is

	"instead of singing"

as a rule and

	"the I6 routine R_2750"

as an I6 routine, while the kernel is named based on the shell:

	"the kernel of 'instead of singing'"

and

	"the I6 routine R_SHELL_0"

Another complication is that certain I6 routines can be overridden, so that,
despite having the same name, they no may longer do what an I6 programmer would
expect.  These are the veneer routines documented in the Inform technical
manual:

	"The 'veneer' is a thin section of code generated by Inform as an
	intermediate layer between the code compiled from the source, and the
	[virtual machine] itself: like the veneer on a table, it gilds the
	surface of the [virtual machine], or so the term is supposed to mean."

Human-Friendly Function Names treats veneer routines specially, calling them out
as such and indicating whether or not they are overridden.  To illustrate,
CA__Pr might be named

	"the overridden I6 veneer routine CA__Pr (calling a property value)"

Note also the parenthetical annotation, which is included because the internal
names for veneer routines can be fairly cryptic to the uninitiated.

Section: The contents of the database

We should mention up front that Human-Friendly Function Names only goes so far
in populating its database.  Rule names, for instance, are entered
automatically, as are phrase names given by "this is".  But the presence of
other function information depends on whether we include code capable of finding
it and storing it in the database.  There are currently three examples of such
code:

The extension I6 Routine Names is little more than a table of commonly appearing
I6 routines, including all of the veneer routines.  When it detects the presence
of Human-Friendly Function Names, it stores its information in the database.

The Glulx Runtime Instrumentation Framework includes I6 Routine Names and also
notes any routine shell/kernel pairs that it comes across during
instrumentation.

Debug File Parsing requires a bit of setup and slows down the story when it
loads its data, but it can name every statically compiled function in a story,
which for most stories is all of them.  It can also detect routine shell/kernel
pairs on its own, or, when the Glulx Runtime Instrumentation Framework is also
included, using a more robust hybrid algorithm.

Section: Looking up a name (and related information) by function address

To obtain a function name, we request

	the human-friendly name for the function at address (A - a number)

where A is the memory address of the function.  This phrase will decide on the
name most likely to make sense to an I7 programmer: a rule name if one is
available, a phrase name if not, a routine kernel name if neither exists, an I6
routine name after that, and, if all else fails, the text "an unnamed rule or
phrase".  Ties between names in the same category are broken by choosing the
name that was given last.

We can also ask whether a function is a veneer routine:

	if the function at address (A - a number) is a veneer routine:
		....

or specifically an overridden veneer routine:

	if the function at address (A - a number) is an overridden veneer routine:
		....

on non-overridden veneer routine:

	if the function at address (A - a number) is a default veneer routine:
		....

If the function is a veneer routine, the phrase

	the annotation for the function at address (A - a number)

will decide on some text that describes the routine's purpose in English.

Section: Looking up a function address by name

Similarly, given a name, we can request a set of function addresses:

	the list of addresses matching the function name (T - some text)

(Note that the phrase takes text, not indexed text.  If we need to compute the
name at runtime, we must use synthetic text from the extension Low-Level Text.)

The result is a new linked list (which we are responsible for deleting) (see the
extension Low-Level Linked Lists) where each linked list vertex's key is the
address of a function having that name.  It is not necessary for the name to be
formatted exactly, nor for it to be the preferred name for a function.  For
instance, the rule

	Before going through a closed door (called the blocking door):
		....

could be identified with

	"Before going through a closed door (called the blocking door)"

or

	"before going through a closed door"

or even

	"  beFoRe gOInG   tHRoUGH    a   cLoSEd dOoR(   BlOCkInG dOOr )   "

(In the HTML format that Inform generates, the whitespace issues in the last
example might not be visible.)

Section: Routine shells and kernels

Having the address of a function that might be a kernel, we can ask for

	the routine shell address of the function at address (A - a number)

If the function is in fact a kernel and the database knows its shell, this
phrase will return the shell's function address.  Otherwise it will return zero.

Likewise, with the address of a possible shell

	the routine kernel address of the function at address (A - a number)

is the function address of its kernel, if a kernel is known to exist, and zero
otherwise.  Authors using either the Glulx Runtime Instrumentation Framework
(GRIF) or Debug File Parsing (or both) can write the phrase

	guess the routine kernel for (A - a sayable value)

with A being a function address to guarantee that, if a kernel of A exists, it
will be known.  The similar phrase

	guess the routine shell for (A - a sayable value)

should guarantee that a request for a routine shell will return one if one
exists.  It is only provided by Debug File Parsing, but becomes more robust when
GRIF is available.

Section: Updating human-friendly function names

If we would like to add function names of our own to the database, we must write
a function-naming rule.  For example:

	A function-naming rule (this is the name quux rule):
		....

The function-naming rulebook is traversed exactly once, whenever the first
database query is made.  (If the Glulx Runtime Instrumentation Framework is
included, the first query might be made in a instrumentation context, where
certain normal Inform operations are unsafe.  See that extension's
documentation.)

Within a function-naming rule we have four phrases available that should not
otherwise be used.  The first,

	give the rule at address (A - a number) the rule name (T - some text)

treats A as the address of a rule and assigns a new name.  Such names should
usually end with the word "rule", as in "the block thinking rule".

The second is similar:

	give the phrase function at address (A - a number) the phrase name (T - some text)

The only thing to note here is that A is the address of the function
implementing the phrase, which is different from the address of the phrase data
structure.  The extra word "function" is included as a reminder.

Third,

	give the veneer routine at address (A - a number) the override flag (F - a truth state) and the routine name (T - some text) and the annotation (Z - some text)

In addition to the function address and a name in a certain category, veneer
routines are expected to be marked as overridden or not, hence F, and to have an
explanation of what they do, Z.  Normally all of this data is taken from I6
Routine Names, and we do not have to worry about it.

The final one,

	give the routine at address (A - a number) the routine name (T - some text)

acts much like the other three, but applies to routines that don't fit in any of
the above categories.

Section: Updating routine shells and kernels 

Just as we can associate names with functions, we can also manually associate
routine shells and routine kernels.  The relevant phrase is

	associate the routine shell at address (A - a number) with the routine kernel at address (B - a number)

It can be invoked at any time, not just when the function-naming rules are
running.

Section: Some words of caution

Most text stored by Human-Friendly Function Names is synthetic (see the
extension Low-Level Text).  As a consequence, a test like

	if the human-friendly name for the function at address 72 is "the I6 routine ShowExtensionVersions":
		....

might always be false, even if the I6 routine ShowExtensionVersions is located
at address 72: the two texts will hold the same sequence of characters, but be
located separately in memory, and Inform's "is" will therefore consider them to
be different.  Instead of comparing function names with "is", we should write
the condition with "is identical to":

	if the human-friendly name for the function at address 72 is identical to "the I6 routine ShowExtensionVersions":
		....

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Section: Regarding bugs

If you encounter a bug, check first on the project website
(https://sourceforge.net/projects/i7grip/) to see whether a newer version of
this extension is available.  If, even using the latest version, the fault
remains, please file a bug report: On the website, choose "Support" from the
toolbar and follow the link in the box titled "Best Way to Get Help".

I will try to respond quickly, at least with an estimate of when the bug might
be fixed, though sometimes I am away from the internet for a week or two at a
time.

Chapter: Acknowledgements

Human-Friendly Function Names was prepared as part of the Glulx Runtime
Instrumentation Project (https://sourceforge.net/projects/i7grip/).  For this
first edition of the project, special thanks go to these people, in
chronological order:

- Graham Nelson, Emily Short, and others, not only for Inform, but also for the
  countless hours the high-quality technical documentation saved me and for the
  work that made the Glulx VM possible,

- Andrew Plotkin for the Glulx VM and the Glk library, as well as their clear,
  always up-to-date specifications,

- Jacqueline Lott, David Welbourn, and all of the other attendees for Club
  Floyd, my first connection to the interactive fiction community,

- Jesse McGrew and Emily Short for getting me involved with Inform 7,

- all of the Inform 7 developers for their hard work, the ceaseless flow of
  improvements, and their willingness to take me on as a collaborator,

- Ron Newcomb and Esteban Montecristo for the idea to write Call Stack Tracking
  and Verbose Diagnostics,

- Roger Carbol, Jesse McGrew, Michael Martin, Dan Shiovitz, Johnny Rivera, and
  everyone else for their helpful comments on ifMUD's I6 and I7 channels,

- Esteban Montecristo, for invaluable alpha testing,

- and all of the beta testers who are reading this.

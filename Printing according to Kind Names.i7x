Version 1 of Printing according to Kind Names (for Glulx only) by Brady Garvin begins here.

"Validates and prints values according to kinds given by name."

Include Compiler Version Checks by Brady Garvin.
Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Glulx Text Decoding by Brady Garvin.
Include Punctuated Word Parsing Engine by Brady Garvin.
Include Disambiguation Framework by Brady Garvin.
Include Human-Friendly Function Names by Brady Garvin.
Include Debug File Parsing by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

Chapter "Use Options" - unindexed

Use a kind name hash table size of at least 311 translates as (- Constant PKN_NAME_HASH_SIZE={N}; -).

To decide what number is the kind name hash table size: (- PKN_NAME_HASH_SIZE -).

Chapter "Rulebooks"

The kind printing setup rules are [rulebook is] a rulebook.

Chapter "Temporary Workarounds" - unindexed

To decide whether the understood value (X - a number) with the base kind code (C - a number) is valid in the command (T - some text) using a workaround for Inform bug 825:
	decide on whether or not the understood value X with the base kind code C is valid in the command T.

To say the understood value (X - a number) with the base kind code (C - a number) in the command (T - some text) using a workaround for Inform bug 825:
	say "[the understood value X with the base kind code C in the command T]".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex) and a workaround for Inform bug 848:
	decide on the validation error for X using the kind parse rooted at V.

To say the kind parse rooted at (V - a parse tree vertex) with plural flag (F - a truth state) and a workaround for Inform bug 848:
	say "[the kind parse rooted at V with plural flag F]".

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at building a semi-punctuated word array from changing text:
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I tried to build a semi-punctuated word array from some text, which means first counting the number of words and then recording each of them.  But the recording process came up with a different number of words than I had originally counted, which means that this text is changing as I print it.[terminating the story]".

To fail at finding kind parameters in (V - a parse tree vertex):
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I was trying to print a value with a given parameterized kind, like 'list of _', but I wasn't able to fill in the blank.  In case it's helpful, the kind parse tree looked like this:[paragraph break][V converted to a parse tree vertex with indentation][terminating the story]".

To fail at finding the expected number of children when canonicalizing parse tree vertices for rules and rulebooks:
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I was cleaning up my parse of a kind name and found more parameterization of a rule or rulebook kind than should be possible.  That means that my canonicalization code, which performs that clean-up, must have failed recently.[terminating the story]".

To fail at saying a value according to a nonexistent previous kind name parse:
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I was asked to say a value according to the most recently parsed kind name, but there way no most recently parsed kind name.[terminating the story]".

To fail at saying a nonexistent previous kind name parse:
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I was asked to say the most recently parsed kind name, but there way no most recently parsed kind name.[terminating the story]".

To fail at saying a previous kind name parse that was not understood:
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I was asked to say the most recently parsed kind name unambiguously, but I didn't understand it, so I can't then identify or remove any ambiguities.[terminating the story]".

To fail at saying a kind because of (S - a parseme):
	say "[low-level runtime failure in]Printing according to Kind Names[with explanation]I was asked to say a kind, but was unable to find all of the entries in my kind name bookkeeping; it might be corrupted.  In case it's helpful, one offending parseme was [S converted to a parseme].[terminating the story]".

Book "Forced Inclusion of the Block Value Management Routines" - unindexed

The variable that forces inclusion of the block value management routines is some indexed text that varies.

Book "Kind Name Parsing" - unindexed

Chapter "The Kind Name Parser" - unindexed

The kind name parser is a context-free parser that varies.

Chapter "Kind Name Parsemes" - unindexed

A kind in the singular and
	a kind in the plural and
	a kind preferably in the singular and
	a kind preferably in the plural and
	a kind pedantically in the plural [for cases where Inform would use the plural but a human would probably use the singular] and
	an optional kind preferably in the singular and
	an optional kind preferably in the plural and
	an optional kind pedantically in the plural and
	a list of kinds and
	a nonempty list of kinds and
	a nothing kind and
	a nothing meaning action kind and
	a nonkind in the singular and
	a truth state in the singular and
	a truth state in the plural and
	a rulebook outcome in the singular and
	a rulebook outcome in the plural and
	a number in the singular and
	a number in the plural and
	a time in the singular and
	a time in the plural and
	a value in the singular and
	a value in the plural and
	a value in the particular singular and
	a value in the particular plural and
	a use option in the singular and
	a use option in the plural and
	a Unicode character in the singular and
	a Unicode character in the plural and
	a text in the singular and
	a text in the plural and
	an indexed text in the singular and
	an indexed text in the plural and
	a snippet in the singular and
	a snippet in the plural and
	a topic in the singular and
	a topic in the plural and
	an action name in the singular and
	an action name in the plural and
	a stored action in the singular and
	a stored action in the plural and
	a scene in the singular and
	a scene in the plural and
	a figure name in the singular and
	a figure name in the plural and
	a sound name in the singular and
	a sound name in the plural and
	an external file in the singular and
	an external file in the plural and
	a list in the singular and
	a list in the plural and
	a table name in the singular and
	a table name in the plural and
	a table column in the singular and
	a table column in the plural and
	an equation name in the singular and
	an equation name in the plural and
	a relation in the singular and
	a relation in the plural and
	an object in the singular and
	an object in the plural and
	an object in the particular singular and
	an object in the particular plural and
	an either/or property in the singular and
	an either/or property in the plural and
	a valued property in the singular and
	a valued property in the plural and
	a description in the singular and
	a description in the plural and
	a phrase in the singular and
	a phrase in the plural and
	a routine in the singular and
	a routine in the plural and
	a rule in the singular and
	a based rule in the singular and
	a rule in the plural and
	a based rule in the plural and
	a rulebook in the singular and
	a based rulebook in the singular and
	a rulebook in the plural and
	a based rulebook in the plural and
	an activity in the singular and
	an activity in the plural are parsemes that vary.

Chapter "Kind Name Printing Hash Tables" - unindexed

[Maps kind parsemes to the singular and plural names (without articles) for their kinds, unless those names are parameterized.]
The singular kind name hash table is a hash table that varies.
The plural kind name hash table is a hash table that varies.

To associate the kind name parseme (S - a parseme) with the singular (T - some text) and the plural (U - some text):
	insert the key S and the value T into the singular kind name hash table;
	insert the key S and the value U into the plural kind name hash table.

To decide what text is the kind name for (S - a parseme) with plural flag (F - a truth state):
	let the result be some text;
	if F is true:
		now the result is the first text value matching the key S in the plural kind name hash table or "" if there are no matches;
	otherwise:
		now the result is the first text value matching the key S in the singular kind name hash table or "" if there are no matches;
	if the result is empty:
		fail at saying a kind because of S;
	decide on the result.

Chapter "Kind Name Parser Setup and Grammar" - unindexed

The global for saying a custom kind name is some text that varies.

A kind printing setup rule (this is the set up the kind name parser rule):
	now the kind name parser is a new context-free parser;
	now the singular kind name hash table is a new hash table with the kind name hash table size buckets;
	now the plural kind name hash table is a new hash table with the kind name hash table size buckets;
	now a kind in the singular is a new nonterminal in the kind name parser named "a kind (written in the singular)";
	now a kind in the plural is a new nonterminal in the kind name parser named "a kind (written in the plural)";
	now a kind preferably in the singular is a new nonterminal in the kind name parser named "a kind";
	now a kind preferably in the plural is a new nonterminal in the kind name parser named "a kind";
	now a kind pedantically in the plural is a new nonterminal in the kind name parser named "a kind";
	now an optional kind preferably in the singular is a new nonterminal in the kind name parser named "an optional kind";
	now an optional kind preferably in the plural is a new nonterminal in the kind name parser named "an optional kind";
	now an optional kind pedantically in the plural is a new nonterminal in the kind name parser named "an optional kind";
	now a list of kinds is a new nonterminal in the kind name parser named "a (possibly empty) list of kinds";
	now a nonempty list of kinds is a new nonterminal in the kind name parser named "a partial list of kinds";
	now a nothing kind is a new nonterminal in the kind name parser named "nothing";
	associate the kind name parseme a nothing kind with the singular "nothing" and the plural "nothing";
	now a nothing meaning action kind is a new nonterminal in the kind name parser named "action";
	associate the kind name parseme a nothing meaning action kind with the singular "action" and the plural "action";
	now a nonkind in the singular is a new nonterminal in the kind name parser named "an unknown or absent kind";
	associate the kind name parseme a nonkind in the singular with the singular "<unknown kind>" and the plural "<unknown kind>";
	now a truth state in the singular is a new nonterminal in the kind name parser named "a truth state";
	associate the kind name parseme a truth state in the singular with the singular "truth state" and the plural "truth states";
	now a truth state in the plural is a new nonterminal in the kind name parser named "truth states";
	associate the kind name parseme a truth state in the plural with the singular "truth state" and the plural "truth states";
	now a rulebook outcome in the singular is a new nonterminal in the kind name parser named "a rulebook outcome";
	associate the kind name parseme a rulebook outcome in the singular with the singular "rulebook outcome" and the plural "a rulebook outcomes";
	now a rulebook outcome in the plural is a new nonterminal in the kind name parser named "rulebook outcomes";
	associate the kind name parseme a rulebook outcome in the plural with the singular "rulebook outcome" and the plural "rulebook outcomes";
	now a number in the singular is a new nonterminal in the kind name parser named "a number";
	associate the kind name parseme a number in the singular with the singular "number" and the plural "numbers";
	now a number in the plural is a new nonterminal in the kind name parser named "numbers";
	associate the kind name parseme a number in the plural with the singular "number" and the plural "numbers";
	now a time in the singular is a new nonterminal in the kind name parser named "a time";
	associate the kind name parseme a time in the singular with the singular "time" and the plural "times";
	now a time in the plural is a new nonterminal in the kind name parser named "times";
	associate the kind name parseme a time in the plural with the singular "time" and the plural "times";
	now a value in the singular is a new nonterminal in the kind name parser named "a custom kind of value";
	now a value in the plural is a new nonterminal in the kind name parser named "a custom kind of value";
	now a use option in the singular is a new nonterminal in the kind name parser named "a use option";
	associate the kind name parseme a use option in the singular with the singular "use option" and the plural "use options";
	now a use option in the plural is a new nonterminal in the kind name parser named "use options";
	associate the kind name parseme a use option in the plural with the singular "use option" and the plural "use options";
	now a Unicode character in the singular is a new nonterminal in the kind name parser named "a Unicode character";
	associate the kind name parseme a Unicode character in the singular with the singular "Unicode character" and the plural "Unicode characters";
	now a Unicode character in the plural is a new nonterminal in the kind name parser named "Unicode characters";
	associate the kind name parseme a Unicode character in the plural with the singular "Unicode character" and the plural "Unicode characters";
	now a text in the singular is a new nonterminal in the kind name parser named "a text";
	associate the kind name parseme a text in the singular with the singular "text" and the plural "texts";
	now a text in the plural is a new nonterminal in the kind name parser named "texts";
	associate the kind name parseme a text in the plural with the singular "text" and the plural "texts";
	now an indexed text in the singular is a new nonterminal in the kind name parser named "an indexed text";
	associate the kind name parseme an indexed text in the singular with the singular "indexed text" and the plural "indexed texts";
	now an indexed text in the plural is a new nonterminal in the kind name parser named "indexed texts";
	associate the kind name parseme an indexed text in the plural with the singular "indexed text" and the plural "indexed texts";
	now a snippet in the singular is a new nonterminal in the kind name parser named "a snippet";
	associate the kind name parseme a snippet in the singular with the singular "snippet" and the plural "snippets";
	now a snippet in the plural is a new nonterminal in the kind name parser named "snippets";
	associate the kind name parseme a snippet in the plural with the singular "snippet" and the plural "snippets";
	now a topic in the singular is a new nonterminal in the kind name parser named "a topic";
	associate the kind name parseme a topic in the singular with the singular "topic" and the plural "topics";
	now a topic in the plural is a new nonterminal in the kind name parser named "topics";
	associate the kind name parseme a topic in the plural with the singular "topic" and the plural "topics";
	now an action name in the singular is a new nonterminal in the kind name parser named "an action name";
	associate the kind name parseme an action name in the singular with the singular "action name" and the plural "action names";
	now an action name in the plural is a new nonterminal in the kind name parser named "action names";
	associate the kind name parseme an action name in the plural with the singular "action name" and the plural "action names";
	now a stored action in the singular is a new nonterminal in the kind name parser named "a stored action";
	associate the kind name parseme a stored action in the singular with the singular "stored action" and the plural "stored actions";
	now a stored action in the plural is a new nonterminal in the kind name parser named "stored actions";
	associate the kind name parseme a stored action in the plural with the singular "stored action" and the plural "stored actions";
	now a scene in the singular is a new nonterminal in the kind name parser named "a scene";
	associate the kind name parseme a scene in the singular with the singular "scene" and the plural "scenes";
	now a scene in the plural is a new nonterminal in the kind name parser named "scenes";
	associate the kind name parseme a scene in the plural with the singular "scene" and the plural "scenes";
	now a figure name in the singular is a new nonterminal in the kind name parser named "a figure name";
	associate the kind name parseme a figure name in the singular with the singular "figure name" and the plural "figure names";
	now a figure name in the plural is a new nonterminal in the kind name parser named "figure names";
	associate the kind name parseme a figure name in the plural with the singular "figure name" and the plural "figure names";
	now a sound name in the singular is a new nonterminal in the kind name parser named "a sound name";
	associate the kind name parseme a sound name in the singular with the singular "sound name" and the plural "sound names";
	now a sound name in the plural is a new nonterminal in the kind name parser named "sound names";
	associate the kind name parseme a sound name in the plural with the singular "sound name" and the plural "sound names";
	now an external file in the singular is a new nonterminal in the kind name parser named "an external file";
	associate the kind name parseme an external file in the singular with the singular "external file" and the plural "external files";
	now an external file in the plural is a new nonterminal in the kind name parser named "external files";
	associate the kind name parseme an external file in the plural with the singular "external file" and the plural "external files";
	now a list in the singular is a new nonterminal in the kind name parser named "a list";
	now a list in the plural is a new nonterminal in the kind name parser named "lists";
	now a table name in the singular is a new nonterminal in the kind name parser named "a table name";
	associate the kind name parseme a table name in the singular with the singular "table name" and the plural "table names";
	now a table name in the plural is a new nonterminal in the kind name parser named "table names";
	associate the kind name parseme a table name in the plural with the singular "table name" and the plural "table names";
	now a table column in the singular is a new nonterminal in the kind name parser named "a table column";
	now a table column in the plural is a new nonterminal in the kind name parser named "table columns";
	now an equation name in the singular is a new nonterminal in the kind name parser named "an equation name";
	associate the kind name parseme an equation name in the singular with the singular "equation name" and the plural "equation names";
	now an equation name in the plural is a new nonterminal in the kind name parser named "equation names";
	associate the kind name parseme an equation name in the plural with the singular "equation name" and the plural "equation names";
	now a relation in the singular is a new nonterminal in the kind name parser named "a relation";
	now a relation in the plural is a new nonterminal in the kind name parser named "relations";
	now an object in the singular is a new nonterminal in the kind name parser named "a kind of object";
	associate the kind name parseme an object in the singular with the singular "object" and the plural "objects";
	now an object in the plural is a new nonterminal in the kind name parser named "a kind of object";
	associate the kind name parseme an object in the plural with the singular "object" and the plural "objects";
	now an either/or property in the singular is a new nonterminal in the kind name parser named "an either/or property";
	associate the kind name parseme an either/or property in the singular with the singular "either/or property" and the plural "either/or properties";
	now an either/or property in the plural is a new nonterminal in the kind name parser named "either/or properties";
	associate the kind name parseme an either/or property in the plural with the singular "either/or property" and the plural "either/or properties";
	now a valued property in the singular is a new nonterminal in the kind name parser named "a valued property";
	now a valued property in the plural is a new nonterminal in the kind name parser named "valued properties";
	now a description in the singular is a new nonterminal in the kind name parser named "a description";
	now a description in the plural is a new nonterminal in the kind name parser named "descriptions";
	now a phrase in the singular is a new nonterminal in the kind name parser named "a phrase";
	now a phrase in the plural is a new nonterminal in the kind name parser named "phrases";
	now a routine in the singular is a new nonterminal in the kind name parser named "a routine";
	associate the kind name parseme a routine in the singular with the singular "routine" and the plural "routines";
	now a routine in the plural is a new nonterminal in the kind name parser named "routines";
	associate the kind name parseme a routine in the plural with the singular "routine" and the plural "routines";
	now a rule in the singular is a new nonterminal in the kind name parser named "a rule";
	now a based rule in the singular is a new nonterminal in the kind name parser named "a rule with its basis given";
	now a rule in the plural is a new nonterminal in the kind name parser named "rules";
	now a based rule in the plural is a new nonterminal in the kind name parser named "rules with their basis given";
	now a rulebook in the singular is a new nonterminal in the kind name parser named "a rulebook";
	now a based rulebook in the singular is a new nonterminal in the kind name parser named "a rulebook with its basis given";
	now a rulebook in the plural is a new nonterminal in the kind name parser named "rulebooks";
	now a based rulebook in the plural is a new nonterminal in the kind name parser named "rulebooks with their basis given";
	now an activity in the singular is a new nonterminal in the kind name parser named "an activity";
	now an activity in the plural is a new nonterminal in the kind name parser named "activities";
	[//]
	understand "([a kind in the singular])" as a kind in the singular;
	understand "a [a kind in the singular]" or "an [a kind in the singular]" as a kind in the singular regardless of case;
	understand "([a kind in the plural])" as a kind in the plural;
	understand "some [a kind in the plural]" as a kind in the plural regardless of case;
	[//]
	understand "[a kind in the singular]" or "[a kind in the plural]" as a kind preferably in the singular;
	understand "[a kind in the singular]" or "[a kind in the plural]" as a kind preferably in the plural;
	understand "[a kind in the singular]" or "[a kind in the plural]" as a kind pedantically in the plural;
	understand "[a kind preferably in the singular]" or "[a nothing kind]" as an optional kind preferably in the singular;
	understand "[a kind preferably in the plural]" or "[a nothing kind]" as an optional kind preferably in the plural;
	understand "[a kind pedantically in the plural]" or "[a nothing kind]" as an optional kind pedantically in the plural;
	[//]
	understand "[a nothing kind]" or "[a nonempty list of kinds]" as a list of kinds regardless of case;
	understand "([a list of kinds])" as a list of kinds;
	understand "[a kind preferably in the singular]" as a nonempty list of kinds regardless of case;
	understand "[a kind preferably in the singular], [a nonempty list of kinds]" as a nonempty list of kinds;
	[//]
	understand "nothing" as a nothing kind regardless of case;
	[//]
	understand "[a nonkind in the singular]" as a kind in the singular;
	understand "[a truth state in the singular]" as a kind in the singular;
	understand "[a rulebook outcome in the singular]" as a kind in the singular;
	understand "[a number in the singular]" as a kind in the singular;
	understand "[a time in the singular]" as a kind in the singular;
	understand "[a value in the singular]" as a kind in the singular;
	understand "[a use option in the singular]" as a kind in the singular;
	understand "[a Unicode character in the singular]" as a kind in the singular;
	understand "[a text in the singular]" as a kind in the singular;
	understand "[an indexed text in the singular]" as a kind in the singular;
	understand "[a snippet in the singular]" as a kind in the singular;
	understand "[a topic in the singular]" as a kind in the singular;
	understand "[an action name in the singular]" as a kind in the singular;
	understand "[a stored action in the singular]" as a kind in the singular;
	understand "[a scene in the singular]" as a kind in the singular;
	understand "[a figure name in the singular]" as a kind in the singular;
	understand "[a sound name in the singular]" as a kind in the singular;
	understand "[an external file in the singular]" as a kind in the singular;
	understand "[a list in the singular]" as a kind in the singular;
	understand "[a table name in the singular]" as a kind in the singular;
	understand "[a table column in the singular]" as a kind in the singular;
	understand "[an equation name in the singular]" as a kind in the singular;
	understand "[a relation in the singular]" as a kind in the singular;
	understand "[an object in the singular]" as a kind in the singular;
	understand "[an either/or property in the singular]" as a kind in the singular;
	understand "[a valued property in the singular]" as a kind in the singular;
	understand "[a description in the singular]" as a kind in the singular;
	understand "[a phrase in the singular]" as a kind in the singular;
	understand "[a routine in the singular]" as a kind in the singular;
	understand "[a rule in the singular]" as a kind in the singular;
	understand "[a rulebook in the singular]" as a kind in the singular;
	understand "[an activity in the singular]" as a kind in the singular;
	[//]
	understand "[a truth state in the plural]" as a kind in the plural;
	understand "[a rulebook outcome in the plural]" as a kind in the plural;
	understand "[a number in the plural]" as a kind in the plural;
	understand "[a time in the plural]" as a kind in the plural;
	understand "[a value in the plural]" as a kind in the plural;
	understand "[a use option in the plural]" as a kind in the plural;
	understand "[a Unicode character in the plural]" as a kind in the plural;
	understand "[a text in the plural]" as a kind in the plural;
	understand "[an indexed text in the plural]" as a kind in the plural;
	understand "[a snippet in the plural]" as a kind in the plural;
	understand "[a topic in the plural]" as a kind in the plural;
	understand "[an action name in the plural]" as a kind in the plural;
	understand "[a stored action in the plural]" as a kind in the plural;
	understand "[a scene in the plural]" as a kind in the plural;
	understand "[a figure name in the plural]" as a kind in the plural;
	understand "[a sound name in the plural]" as a kind in the plural;
	understand "[an external file in the plural]" as a kind in the plural;
	understand "[a list in the plural]" as a kind in the plural;
	understand "[a table name in the plural]" as a kind in the plural;
	understand "[a table column in the plural]" as a kind in the plural;
	understand "[an equation name in the plural]" as a kind in the plural;
	understand "[a relation in the plural]" as a kind in the plural;
	understand "[an object in the plural]" as a kind in the plural;
	understand "[an either/or property in the plural]" as a kind in the plural;
	understand "[a valued property in the plural]" as a kind in the plural;
	understand "[a description in the plural]" as a kind in the plural;
	understand "[a phrase in the plural]" as a kind in the plural;
	understand "[a routine in the plural]" as a kind in the plural;
	understand "[a rule in the plural]" as a kind in the plural;
	understand "[a rulebook in the plural]" as a kind in the plural;
	understand "[an activity in the plural]" as a kind in the plural;
	[//]
	understand "<no kind>" or "<unknown kind>" as a nonkind in the singular regardless of case;
	understand "truth state" as a truth state in the singular regardless of case;
	understand "truth states" as a truth state in the plural regardless of case;
	understand "rulebook outcome" as a rulebook outcome in the singular regardless of case;
	understand "rulebook outcomes" as a rulebook outcome in the plural regardless of case;
	understand "number" as a number in the singular regardless of case;
	understand "numbers" as a number in the plural regardless of case;
	understand "time" as a time in the singular regardless of case;
	understand "times" as a time in the plural regardless of case;
	understand "use option" as a use option in the singular regardless of case;
	understand "use options" as a use option in the plural regardless of case;
	understand "Unicode character" as a Unicode character in the singular regardless of case;
	understand "Unicode characters" as a Unicode character in the plural regardless of case;
	understand "text" as a text in the singular regardless of case;
	understand "text" as a text in the plural regardless of case; [since it can be used as a mass noun]
	understand "texts" as a text in the plural regardless of case;
	understand "indexed text" as an indexed text in the singular regardless of case;
	understand "indexed texts" as an indexed text in the plural regardless of case;
	understand "snippet" as a snippet in the singular regardless of case;
	understand "snippets" as a snippet in the plural regardless of case;
	understand "topic" as a topic in the singular regardless of case;
	understand "topics" as a topic in the plural regardless of case;
	understand "action name" as an action name in the singular regardless of case;
	understand "action names" as an action name in the plural regardless of case;
	understand "stored action" as a stored action in the singular regardless of case;
	understand "stored actions" as a stored action in the plural regardless of case;
	understand "scene" as a scene in the singular regardless of case;
	understand "scenes" as a scene in the plural regardless of case;
	understand "figure name" as a figure name in the singular regardless of case;
	understand "figure names" as a figure name in the plural regardless of case;
	understand "sound name" as a sound name in the singular regardless of case;
	understand "sound names" as a sound name in the plural regardless of case;
	understand "external file" as an external file in the singular regardless of case;
	understand "external files" as an external file in the plural regardless of case;
	understand "table name" as a table name in the singular regardless of case;
	understand "table names" as a table name in the plural regardless of case;
	understand "equation name" as an equation name in the singular regardless of case;
	understand "equation names" as an equation name in the plural regardless of case;
	understand "either/or property" as an either/or property in the singular regardless of case;
	understand "either/or properties" as an either/or property in the plural regardless of case;
	[//]
	repeat with the kind-of-value name running through the underlying text keys of the kind-of-value hash table:
		now a value in the particular singular is a new nonterminal in the kind name parser named "a custom kind of value";
		now the global for saying a custom kind name is the kind-of-value name;
		understand "[the global for saying a custom kind name]" as a value in the particular singular regardless of case;
		understand "[a value in the particular singular]" as a value in the singular;
		associate the kind name parseme a value in the particular singular with the singular the kind-of-value name and the plural the debug plural of the kind-of-value name;
		now a value in the particular plural is a new nonterminal in the kind name parser named "a custom kind of value";
		now the global for saying a custom kind name is the debug plural of the kind-of-value name;
		understand "[the global for saying a custom kind name]" as a value in the particular plural regardless of case;
		understand "[a value in the particular plural]" as a value in the plural;
		associate the kind name parseme a value in the particular plural with the singular the kind-of-value name and the plural the debug plural of the kind-of-value name;
	[//]
	understand "object" as an object in the singular regardless of case;
	understand "objects" as an object in the plural regardless of case;
	understand "room" as an object in the singular regardless of case;
	understand "rooms" as an object in the plural regardless of case;
	understand "thing" as an object in the singular regardless of case;
	understand "things" as an object in the plural regardless of case;
	understand "direction" as an object in the singular regardless of case;
	understand "directions" as an object in the plural regardless of case;
	understand "region" as an object in the singular regardless of case;
	understand "regions" as an object in the plural regardless of case;
	repeat with the kind-of-object name running through the underlying text keys of the kind-of-object hash table:
		now an object in the particular singular is a new nonterminal in the kind name parser named "a custom kind of object";
		now the global for saying a custom kind name is the kind-of-object name;
		understand "[the global for saying a custom kind name]" as an object in the particular singular regardless of case;
		understand "[an object in the particular singular]" as an object in the singular;
		associate the kind name parseme an object in the particular singular with the singular the kind-of-object name and the plural the debug plural of the kind-of-object name;
		now an object in the particular plural is a new nonterminal in the kind name parser named "a custom kind of object";
		now the global for saying a custom kind name is the debug plural of the kind-of-object name;
		understand "[the global for saying a custom kind name]" as an object in the particular plural regardless of case;
		understand "[an object in the particular plural]" as an object in the plural;
		associate the kind name parseme an object in the particular plural with the singular the kind-of-object name and the plural the debug plural of the kind-of-object name;
	[//]
	understand "list of [a kind preferably in the plural]" as a list in the singular regardless of case;
	understand "lists of [a kind preferably in the plural]" as a list in the plural regardless of case;
	understand "[a kind pedantically in the plural] valued table column" as a table column in the singular regardless of case;
	understand "[a kind pedantically in the plural] valued table columns" as a table column in the plural regardless of case;
	understand "relation of [a kind preferably in the plural] to [a kind preferably in the plural]" as a relation in the singular regardless of case;
	understand "relations of [a kind preferably in the plural] to [a kind preferably in the plural]" as a relation in the plural regardless of case;
	understand "[a kind pedantically in the plural] valued property" as a valued property in the singular regardless of case;
	understand "[a kind pedantically in the plural] valued properties" as a valued property in the plural regardless of case;
	understand "description of [a kind preferably in the plural]" as a description in the singular regardless of case;
	understand "descriptions of [a kind preferably in the plural]" as a description in the plural regardless of case;
	understand "phrase [a list of kinds] -> [an optional kind preferably in the singular]" as a phrase in the singular regardless of case;
	understand "phrases [a list of kinds] -> [an optional kind preferably in the singular]" as a phrase in the plural regardless of case;
	understand "routine" as a routine in the singular regardless of case;
	understand "routines" as a routine in the plural regardless of case;
	understand "rule" as a rule in the singular regardless of case;
	understand "action based rule" as a rule in the singular regardless of case;
	understand "rule producing [an optional kind preferably in the plural]" as a rule in the singular regardless of case;
	understand "action based rule producing [an optional kind preferably in the plural]" as a rule in the singular regardless of case;
	understand "[a based rule in the singular]" as a rule in the singular regardless of case;
	understand "[an optional kind pedantically in the plural] based rule" as a based rule in the singular regardless of case;
	understand "[an optional kind pedantically in the plural] based rule producing [an optional kind preferably in the plural]" as a based rule in the singular regardless of case;
	understand "rules" as a rule in the plural regardless of case;
	understand "action based rules" as a rule in the plural regardless of case;
	understand "rules producing [an optional kind preferably in the plural]" as a rule in the plural regardless of case;
	understand "action based rules producing [an optional kind preferably in the plural]" as a rule in the plural regardless of case;
	understand "[a based rule in the plural]" as a rule in the singular regardless of case;
	understand "[an optional kind pedantically in the plural] based rules" as a based rule in the plural regardless of case;
	understand "[an optional kind pedantically in the plural] based rules producing [an optional kind preferably in the plural]" as a based rule in the plural regardless of case;
	understand "rulebook" as a rulebook in the singular regardless of case;
	understand "action based rulebook" as a rulebook in the singular regardless of case;
	understand "rulebook producing [an optional kind preferably in the plural]" as a rulebook in the singular regardless of case;
	understand "action based rulebook producing [an optional kind preferably in the plural]" as a rulebook in the singular regardless of case;
	understand "[a based rulebook in the singular]" as a rulebook in the singular regardless of case;
	understand "[an optional kind pedantically in the plural] based rulebook" as a based rulebook in the singular regardless of case;
	understand "[an optional kind pedantically in the plural] based rulebook producing [an optional kind preferably in the plural]" as a based rulebook in the singular regardless of case;
	understand "rulebooks" as a rulebook in the plural regardless of case;
	understand "action based rulebooks" as a rulebook in the plural regardless of case;
	understand "rulebooks producing [an optional kind preferably in the plural]" as a rulebook in the plural regardless of case;
	understand "action based rulebooks producing [an optional kind preferably in the plural]" as a rulebook in the plural regardless of case;
	understand "[a based rulebook in the plural]" as a rulebook in the singular regardless of case;
	understand "[an optional kind pedantically in the plural] based rulebooks" as a based rulebook in the plural regardless of case;
	understand "[an optional kind pedantically in the plural] based rulebooks producing [an optional kind preferably in the plural]" as a based rulebook in the plural regardless of case;
	understand "activity on [an optional kind preferably in the plural]" as an activity in the singular regardless of case;
	understand "activities on [an optional kind preferably in the plural]" as an activity in the plural regardless of case;
	[//]
	put the kind name parser into normal form.

Chapter "Kind Name Canonicalization" - unindexed

The kind name canonicalization rules are [rulebook is] a rulebook.

A kind name canonicalization rule (this is the eliminate punctuated word terminals from kind parse trees rule):
	let the previous child be a null parse tree vertex;
	let the child be the first child of the parse tree vertex to canonicalize;
	while the child is not null:
		let the next child be the right sibling of the child;
		if the parseme of the child is a punctuated word terminal:
			delete the child and its descendants;
		otherwise:
			if the previous child is null:
				write the first child the child to the parse tree vertex to canonicalize;
			otherwise:
				write the right sibling the child to the previous child;
			write the left sibling the previous child to the child;
			now the previous child is the child;
		now the child is the next child;
	if the previous child is null:
		write the first child a null parse tree vertex to the parse tree vertex to canonicalize;
	otherwise:
		write the right sibling a null parse tree vertex to the previous child;
	write the last child the previous child to the parse tree vertex to canonicalize.

A kind name canonicalization rule (this is the substitute into non-root placeholders in kind parse trees rule):
	let the previous child be a null parse tree vertex;
	let the child be the first child of the parse tree vertex to canonicalize;
	while the child is not null:
		let the next child be the right sibling of the child;
		let the parseme be the parseme of the child;
		if the parseme is a kind in the singular or the parseme is a kind in the plural or the parseme is a kind preferably in the singular or the parseme is a kind preferably in the plural or the parseme is a kind pedantically in the plural or the parseme is an optional kind preferably in the singular or the parseme is an optional kind preferably in the plural or the parseme is an optional kind pedantically in the plural or the parseme is list of kinds or the parseme is a nonempty list of kinds:
			let the grandchild be the first child of the child;
			delete the child but not its descendants;
			if the grandchild is not null:
				if the previous child is null:
					write the first child the grandchild to the parse tree vertex to canonicalize;
				otherwise:
					write the right sibling the grandchild to the previous child;
				write the left sibling the previous child to the grandchild;
				while the grandchild is not null:
					write the parent (the parse tree vertex to canonicalize) to the grandchild;
					now the previous child is the grandchild;
					now the grandchild is the right sibling of the grandchild;
		otherwise:
			if the previous child is null:
				write the first child the child to the parse tree vertex to canonicalize;
			otherwise:
				write the right sibling the child to the previous child;
			write the left sibling the previous child to the child;
			now the previous child is the child;
		now the child is the next child;
	if the previous child is null:
		write the first child a null parse tree vertex to the parse tree vertex to canonicalize;
	otherwise:
		write the right sibling a null parse tree vertex to the previous child;
	write the last child the previous child to the parse tree vertex to canonicalize.

A last kind name canonicalization rule (this is the canonicalize rules and rulebooks in kind parse trees to two children rule):
	let the parseme be the parseme of the parse tree vertex to canonicalize;
	let the first child be the first child of the parse tree vertex to canonicalize;
	let the last child be the last child of the parse tree vertex to canonicalize;
	if the parseme is a based rule in the singular or the parseme is a based rule in the plural or the parseme is a based rulebook in the singular or the parseme is a based rulebook in the plural:
		always check that first child is not null or else fail at finding the expected number of children when canonicalizing parse tree vertices for rules and rulebooks;
		if the first child is the last child:
			let the outcome child be a new parse tree vertex for a nothing kind with the parent the parse tree vertex to canonicalize;
		otherwise:
			always check that right sibling of the first child is the last child or else fail at finding the expected number of children when canonicalizing parse tree vertices for rules and rulebooks;
	otherwise if the parseme is a rule in the singular or the parseme is a rule in the plural or the parseme is a rulebook in the singular or the parseme is a rulebook in the plural:
		if the first child is null:
			let the basis child be a new parse tree vertex for a nothing meaning action kind with the parent the parse tree vertex to canonicalize;
			let the outcome child be a new parse tree vertex for a nothing kind with the parent the parse tree vertex to canonicalize;
		otherwise if the first child is the last child:
			now the parseme is the parseme of the first child;
			if the parseme is a based rule in the singular or the parseme is a based rule in the plural or the parseme is a based rulebook in the singular or the parseme is a based rulebook in the plural:
				let the basis child be the first child of the first child;
				let the outcome child be the last child of the first child;
				always check that right sibling of the basis child is the outcome child or else fail at finding the expected number of children when canonicalizing parse tree vertices for rules and rulebooks;
				delete the first child but not its descendants;
				write the first child the basis child to the parse tree vertex to canonicalize;
				write the last child the outcome child to the parse tree vertex to canonicalize;
				write the parent (the parse tree vertex to canonicalize) to the basis child;
				write the parent (the parse tree vertex to canonicalize) to the outcome child;
			otherwise:
				let the basis child be a new parse tree vertex for a nothing meaning action kind with the parent the parse tree vertex to canonicalize, placed on the left;
		otherwise:
			always check that right sibling of the first child is the last child or else fail at finding the expected number of children when canonicalizing parse tree vertices for rules and rulebooks.

Chapter "Kind Name Scoring" - unindexed

The kind name scoring rules are [rulebook is] a rulebook.

Section "Pluralization Errors" - unindexed

To decide what number is the weighted pluralization error count of (V - a parse tree vertex):
	decide on zero.

To decide what number is the weighted pluralization error count of (V - a parse tree vertex that has the parseme a kind preferably in the singular):
	if the parseme of the first child of V is a kind in the singular:
		decide on zero;
	decide on two.

To decide what number is the weighted pluralization error count of (V - a parse tree vertex that has the parseme a kind preferably in the plural):
	if the parseme of the first child of V is a kind in the plural:
		decide on zero;
	decide on two.

To decide what number is the weighted pluralization error count of (V - a parse tree vertex that has the parseme a kind pedantically in the plural):
	[if the parseme of the first child of V is a kind in the plural:
		decide on zero;
	decide on one.] [Frankly, I find Inform's conventions here unusual enough that I'd rather not expect the author to know and follow them.]
	decide on zero.

To decide what number is the weighted pluralization error count under (V - a parse tree vertex):
	let the result be the weighted pluralization error count of V;
	repeat with the child running through the children of V:
		increase the result by the weighted pluralization error count under the child;
	decide on the result.

A kind name scoring rule (this is the penalize pluralization errors rule):
	let the result be the weighted pluralization error count under the root of the parse tree to score;
	give the parse tree to score zero minus the result points for "pluralization errors".

Section "Value Validity" - unindexed

The kind name validity check flag is a truth state that varies.
The value to check kind name validity with is a number that varies.

A kind name scoring rule (this is the reward value validity rule):
	if the kind name validity check flag is true:
		if the value to check kind name validity with is completely valid using the kind parse rooted at the root of the canonicalized parse tree to score:
			give the parse tree to score one point for "value validity";
		otherwise:
			give the parse tree to score zero points for "value validity".

Chapter "Kind Name Filtration" - unindexed

The kind name filtration rules are [rulebook is] a rulebook.

Book "Validation and Printing" - unindexed

Part "Kind Code Validation" - unindexed

To decide what number is the boolean base kind code: (- TRUTH_STATE_TY -).
To decide what number is the rulebook outcome base kind code: (- RULEBOOK_OUTCOME_TY -).
To decide what number is the number base kind code: (- NUMBER_TY -).
To decide what number is the dimensional number base kind code: (- INTERMEDIATE_TY -).

To decide what number is the use option base kind code: (- USE_OPTION_TY -).

To decide what number is the Unicode character base kind code: (- UNICODE_CHARACTER_TY -).
To decide what number is the text base kind code: (- TEXT_TY -).
To decide what number is the indexed text base kind code: (- INDEXED_TEXT_TY -).
To decide what number is the snippet base kind code: (- SNIPPET_TY -).
To decide what number is the understanding base kind code: (- UNDERSTANDING_TY -).

To decide what number is the list base kind code: (- LIST_OF_TY -).
To decide what number is the table name base kind code: (- TABLE_TY -).
To decide what number is the table column base kind code: (- TABLE_COLUMN_TY -).
To decide what number is the equation name base kind code: (- EQUATION_TY -).
To decide what number is the relation base kind code: (- RELATION_TY -).

To decide what number is the object base kind code: (- OBJECT_TY -).
To decide what number is the property base kind code: (- PROPERTY_TY -).

To decide what number is the description base kind code: (- DESCRIPTION_OF_TY -).
To decide what number is the phrase base kind code: (- PHRASE_TY -).
To decide what number is the rule base kind code: (- RULE_TY -).
To decide what number is the rulebook base kind code: (- RULEBOOK_TY -).
To decide what number is the activity base kind code: (- ACTIVITY_TY -).

Definition: a number is boolean-kind-identifying if it is the boolean base kind code.
Definition: a number is rulebook-outcome-kind-identifying if it is the rulebook outcome base kind code.
Definition: a number is number-kind-identifying if it is the number base kind code.
Definition: a number is dimensional-number-kind-identifying if it is the dimensional number base kind code.

Definition: a number is use-option-kind-identifying if it is the use option base kind code.

Definition: a number is Unicode-character-kind-identifying if it is the Unicode character base kind code.
Definition: a number is text-kind-identifying if it is the text base kind code.
Definition: a number is indexed text-kind-identifying if it is the indexed text base kind code.
Definition: a number is snippet-kind-identifying if it is the snippet base kind code.
Definition: a number is understanding-kind-identifying if it is the understanding base kind code.

Definition: a number is list-kind-identifying if it is the list base kind code.
Definition: a number is table-name-kind-identifying if it is the table name base kind code.
Definition: a number is table-column-kind-identifying if it is the table column base kind code.
Definition: a number is equation-name-kind-identifying if it is the equation name base kind code.
Definition: a number is relation-kind-identifying if it is the relation base kind code.

Definition: a number is object-kind-identifying if it is the object base kind code.
Definition: a number is property-kind-identifying if it is the property base kind code.

Definition: a number is description-kind-identifying if it is the description base kind code.
Definition: a number is phrase-kind-identifying if it is the phrase base kind code.
Definition: a number is rule-kind-identifying if it is the rule base kind code.
Definition: a number is rulebook-kind-identifying if it is the rulebook base kind code.
Definition: a number is activity-kind-identifying if it is the activity base kind code.

To decide whether the base kind code (C - a number) is legal: (- llo_unsignedLessThan({C},BASE_KIND_HWM) -).

To decide whether the kind code (C - a number) is legal:
	if the base kind code C is legal:
		decide yes;
	decide on whether or not C is a valid integer address and the base kind code the integer at address C is legal.

To decide whether the kind code (C - a number) represents a phrase:
	if C is the phrase base kind code:
		decide yes;
	decide on whether or not C is a valid integer address and the integer at address C is the phrase base kind code.

Part "Paranoid Text Manipulation" - unindexed

Chapter "Characters" - unindexed

[Almost completely covered by Glulx Text Decoding.]

To decide whether (A - a decoding vertex) is of indirect or unknown type: (- llo_unsignedGreaterThan(llo_getByte({A}),5) -).

Chapter "Text" - unindexed

Section "Text Validation" - unindexed

To decide whether (T - some text) could be substitution-free compressed text:
	let the address be T converted to a number;
	if the address is zero or the address is an invalid byte address or the byte at address address is not 225:
		decide no;
	repeat with the decoding vertex running with paranoia through the compressed T:
		if the decoding vertex is of indirect or unknown type:
			decide no;
	decide yes.

To decide whether (T - some text) could be text:
	let the address be T converted to a number;
	if the address is zero or the address is an invalid byte address:
		decide no;
	let the indicator be the byte at address address;
	if the indicator is:
		-- 224: [null-terminated Latin-1]
			let the maximum possible extent be the size of memory minus the address;
			let the extent be the index of the byte zero in the maximum possible extent bytes at address address;
			decide on whether or not the extent is at least zero;
		-- 225: [compressed]
			repeat with the decoding vertex running with paranoia through the compressed T:
				if the decoding vertex is of unknown type:
					decide no;
			decide yes;
		-- 226: [null-terminated Unicode]
			let the maximum possible extent be the size of memory minus the address;
			now the maximum possible extent is the maximum possible extent divided by four;
			let the extent be the index of the integer zero in the maximum possible extent integers at address address;
			decide on whether or not the extent is at least zero;
		-- otherwise: [unknown]
			decide on whether or not the indicator is a function type indicator.

Section "Text Printing" - unindexed

To say (T - some text) with paranoia:
	let the address be T converted to a number;
	if the byte at address address is:
		-- 224: [null-terminated Latin-1]
			repeat with the character running with paranoia through the Latin-1 T:
				say "[if the character is printable][the character][otherwise]?[end if]";
		-- 225: [compressed]
			repeat with the decoding vertex running with paranoia through the compressed T:
				say "[the decoding vertex]";
		-- 226: [null-terminated Unicode]
			repeat with the character running with paranoia through the Unicode T:
				say "[if the character is printable][the character][otherwise]?[end if]";
		-- otherwise: [must be a function type]
			say "[the human-friendly name for the function at address address]".

Part "Paranoid Block Value Manipulation" - unindexed

Chapter "The Memory Block Kind" - unindexed

A memory block is a kind of value.
A memory block is an invalid memory block.  [See the note in the book "Extension Information."]
The specification of a decoding vertex is "A memory block is a contiguous region of memory occupied by an Inform block value; blocks are defined by the BlockValues.i6t (and also Flex.i6t), which see."

Section "Memory Block Constants" - unindexed

To decide what memory block is the zero block: (- 0 -).
To decide what memory block is the null block: (- NULL -).

Section "The Memory Block Structure" - unindexed

[Layout:
		<--BLK_HEADER_N is the byte offset to here; 0 bytes
	1 byte for the binary logarithm of the block size
		<--BLK_HEADER_FLAGS is the byte offset to here; 1 byte
	1 byte for flags (BLK_FLAG_MULTIPLE, BLK_FLAG_16_BIT, BLK_FLAG_WORD, and/or BLK_FLAG_RESIDENT)
	2 bytes padding
		<--BLK_HEADER_KOV is the word offset to here; 1 word = 4 bytes
	4 bytes for the base kind
		<--BLK_DATA_OFFSET is the byte offset to here; 8 bytes
		<--BLK_NEXT is the word offset to here; 2 words = 8 bytes
	4 (optional) bytes for the next pointer of a multiblock header
		<--BLK_PREV is the word offset to here; 3 words = 12 bytes
	4 (optional) bytes for the previous pointer of a multiblock header]

Section "Memory Block Accessors" - unindexed

To decide what number is the size in memory of (A - a memory block): (- llo_leftShift(1,llo_getByte({A}+BLK_HEADER_N)) -).
To decide what number is the flags of (A - a memory block): (- llo_getByte({A}+BLK_HEADER_FLAGS) -).
To decide whether (A - a memory block) is a multiblock: (- (llo_getByte({A}+BLK_HEADER_FLAGS)&BLK_FLAG_MULTIPLE) -).
To decide what number is the base kind code of (A - a memory block): (- llo_getField({A},BLK_HEADER_KOV) -).
To decide what memory block is the memory block before (A - a memory block): (- llo_getField({A},BLK_PREV) -).
To decide what memory block is the memory block after (A - a memory block): (- llo_getField({A},BLK_NEXT) -).

To decide what number is the extent of (A - a memory block): (- BlkValueExtent({A}) -).
To decide what number is datum number (I - a number) of (A - a memory block): (- BlkValueRead({A},{I}) -).

Section "Memory Block Validation" - unindexed

To decide whether (A - a memory block) is valid:
	if A is the null block or A is the zero block or A is an invalid memory block:
		decide no;
	let the maximum possible size be the size of memory minus A converted to a number;
	if the maximum possible size is less than 16:
		decide no;
	let the size be the size in memory of A;
	if the size is less than 16 or the size is greater than the maximum possible size:
		decide no;
	decide yes.

To decide whether (A - a memory block) is a valid head block:
	unless A is valid:
		decide no;
	unless A is a multiblock:
		decide yes;
	if the memory block before A is not the null block:
		decide no;
	let the base kind code be the base kind code of A;
	let the visited blocks hash table be a new hash table with 131 buckets;
	let the current block be A;
	repeat until a break:
		insert the key the current block into the visited blocks hash table;
		now the current block is the memory block after the current block;
		if the current block is the null block:
			delete the visited blocks hash table;
			decide yes;
		if the visited blocks hash table contains the key the current block or the base kind code of the current block is not the base kind code:
			delete the visited blocks hash table;
			decide no;
		unless the current block is valid:
			delete the visited blocks hash table;
			decide no.

Part "Semi-Punctuated Words" - unindexed

Chapter "Character Classes" - unindexed

Include (-
	Constant PKN_SEMI_PUNCTUATION_COUNT = 3;
	Array pkn_semi_punctuation ->
		34  ! "
		44  ! ,
		46  ! .
		;
-) after "Definitions.i6t".

To decide whether (C - a number) is a character code for independent semi-punctuation: (- (llo_byteIndex({C},pkn_semi_punctuation,PKN_SEMI_PUNCTUATION_COUNT)~=-1) -).

Chapter "State Machine" - unindexed

A semi-punctuated word state is a kind of value.
The semi-punctuated word states are
	transitioning after whitespace between semi-punctuated words,
	transitioning after independent semi-punctuation,
	and transitioning after non-semi-punctuation.
The specification of a semi-punctuated word state is "Semi-punctuated word states are used to classify between-character positions when Printing according to Kind Names breaks a command into snippet words."

To decide what semi-punctuated word state is the semi-punctuated word state that follows (C - a number):
	if C is a character code for whitespace:
		decide on transitioning after whitespace between semi-punctuated words;
	if C is a character code for independent semi-punctuation:
		decide on transitioning after independent semi-punctuation;
	decide on transitioning after non-semi-punctuation.

To decide whether (A - a semi-punctuated word state) followed by (B - a semi-punctuated word state) ends a semi-punctuated word:
	decide on whether or not A is transitioning after independent semi-punctuation or A is not transitioning after whitespace between semi-punctuated words and A is not B.

To decide whether (A - a semi-punctuated word state) followed by no semi-punctuated word state ends a semi-punctuated word:
	decide on whether or not A is not transitioning after whitespace between semi-punctuated words.

To decide whether (A - a semi-punctuated word state) followed by (B - a semi-punctuated word state) begins a semi-punctuated word:
	decide on whether or not B is transitioning after independent semi-punctuation or B is not transitioning after whitespace between semi-punctuated words and B is not A.

Chapter "Topic Match Values of Commands" - unindexed

To decide whether the topic match value (X - a number) of the command (T - some text) is valid, saying it:
	let the beginning word number be X divided by 100;
	let the end word number be the beginning word number plus the remainder after dividing X by 100;
	let the current state be transitioning after whitespace between semi-punctuated words;
	let the word index be one;
	let the printing flag be false;
	let the printed flag be false;
	repeat with the character code running through the character codes in the synthetic text T:
		let the previous state be the current state;
		now the current state is the semi-punctuated word state that follows the character code;
		if the previous state followed by the current state ends a semi-punctuated word:
			increment the word index;
			if the word index is at least the end word number:
				now the printing flag is false;
		if the previous state followed by the current state begins a semi-punctuated word:
			if the word index is the beginning word number:
				now the printing flag is true;
				now the printed flag is true;
		if saying it and the printing flag is true:
			say "[the character code converted to a Unicode character]";
	if the current state followed by no semi-punctuated word state ends a semi-punctuated word:
		increment the word index;
		if the word index is greater than the end word number:
			now the printing flag is false;
	decide on whether or not the printing flag is false and the printed flag is true.

To say the topic match value (X - a number) of the command (T - some text):
	let the discarded value be whether or not the topic match value X of the command T is valid, saying it.

Part "Validation and Printing Phrases" - unindexed

Chapter "All Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex) with plural flag (F - a truth state):
	say "[the kind name for the parseme of V with plural flag F]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a kind in the singular) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag F and brackets as necessary]".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a kind in the singular):
	decide on the validation error for X using the kind parse rooted at the first child of V and a workaround for Inform bug 848.

To decide whether (X - a number) is completely valid using the kind parse rooted at (V - a parse tree vertex):
	[//// Workaround for Inform bug ### ////]
	if V has the parseme a list in the singular or V has the parseme a list in the plural:
		decide on whether or not the list value X is completely valid using the kind parse rooted at V;
	[//// Workaround for Inform bug ### ////]
	let the error be the validation error for X using the kind parse rooted at V and a workaround for Inform bug 848;
	decide on whether or not the error is empty.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex):
	say "[the human-friendly name of the parseme of V]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a kind in the singular):
	say "[X using the kind parse rooted at the first child of V with paranoia]".

Chapter "Nonkind Values" - unindexed

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a nonkind in the singular):
	decide on "".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a nonkind in the singular):
	say "[X converted to a number] / [X converted to a number in hexadecimal]".

Chapter "Boolean Values" - unindexed

To decide what text is the validation error for the truth state value (X - a number):
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a truth state in the singular):
	decide on the validation error for the truth state value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a truth state in the plural):
	decide on the validation error for the truth state value X.

To say the truth state value (X - a number): (- DA_TruthState({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a truth state in the singular):
	say "[the truth state value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a truth state in the plural):
	say "[the truth state value X]".

Chapter "Rulebook Outcome Values" - unindexed

To decide what text is the validation error for the rulebook outcome value (X - a number):
	if X converted to some text could be substitution-free compressed text:
		decide on "";
	decide on "<invalid rulebook outcome>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook outcome in the singular):
	decide on the validation error for the rulebook outcome value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook outcome in the plural):
	decide on the validation error for the rulebook outcome value X.

To say the rulebook outcome value (X - a number):
	say X converted to some text with paranoia.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook outcome in the singular):
	say "[the rulebook outcome value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook outcome in the plural):
	say "[the rulebook outcome value X]".

Chapter "Number Values" - unindexed

To decide what text is the validation error for the number value (X - a number):
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a number in the singular):
	decide on the validation error for the number value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a number in the plural):
	decide on the validation error for the number value X.

To say the number value (X - a number):
	say "[X converted to a number]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a number in the singular):
	say "[the number value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a number in the plural):
	say "[the number value X]".

Chapter "Time Values" - unindexed

To decide what text is the validation error for the time value (X - a number):
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a time in the singular):
	decide on the validation error for the time value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a time in the plural):
	decide on the validation error for the time value X.

To say the time value (X - a number):
	let the minutes be X;
	let the hours be X divided by 60;
	if X is less than zero:
		decrement the hours;
	decrease the minutes by the hours times 60;
	let the half-days be the hours divided by 12;
	if X is less than zero:
		decrement the half-days;
	decrease the hours by the half-days times 12;
	let the days be the half-days divided by 2;
	if X is less than zero:
		decrement the days;
	decrease the half-days by the days times 2;
	say "[the hours]:[if the minutes are less than 10]0[end if][the minutes] [if the half-days are zero]am[otherwise]pm[end if]";
	if the days are less than zero:
		say ", [zero minus the days] day[unless the days are -1]s[end if] in the past (an out-of-bounds time)";
	otherwise if the days are greater than zero:
		say ", [the days] day[unless the days are one]s[end if] in the future (an out-of-bounds time)";
	now the minutes are X;
	now the hours are X divided by 60;
	decrease the minutes by the hours times 60;
	now the half-days are the hours divided by 12;
	decrease the hours by the half-days times 12;
	now the days are the half-days divided by 2;
	decrease the half-days by the days times 2;
	say " (also, an interval of [the days] day[unless the days are one]s[end if], [the hours] hour[unless the hours are one]s[end if], and [the minutes] minute[unless the minutes are one]s[end if])".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a time in the singular):
	say "[the time value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a time in the plural):
	say "[the time value X]".

Chapter "Use Option Values" - unindexed

To decide what text is the validation error for the use option value (X - a number):
	let the capture be a new uninitialized synthetic text with length one character;
	overwrite the synthetic text capture with the text printed when we say "[the use option value X]";
	let the capture length be the length of the synthetic text capture;
	delete the synthetic text capture;
	if the capture length is greater than zero:
		decide on "";
	decide on "<invalid use option>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a use option in the singular):
	decide on the validation error for the use option value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a use option in the plural):
	decide on the validation error for the use option value X.

To say the use option value (X - a number):  (- PrintUseOption({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a use option in the singular):
	say "[the use option value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a use option in the plural):
	say "[the use option value X]".

Chapter "Unicode Character Values" - unindexed

To decide what text is the validation error for the Unicode character value (X - a number):
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a Unicode character in the singular):
	decide on the validation error for the Unicode character value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a Unicode character in the plural):
	decide on the validation error for the Unicode character value X.

To say the Unicode character value (X - a number):
	if X is:
		-- 9:
			say "<tab>";
		-- 10:
			say "<newline character>";
		-- 91:
			say "<open bracket>";
		-- 93:
			say "<close bracket>";
		-- otherwise:
			let the character be X converted to a Unicode character;
			say "[if the character is printable][the character][otherwise]<unprintable Unicode character [X converted to a number]>[end if]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a Unicode character in the singular):
	say "[the Unicode character value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a Unicode character in the plural):
	say "[the Unicode character value X]".

Chapter "Text Values" - unindexed

To decide what text is the validation error for the text value (X - a number):
	if X converted to some text could be text:
		decide on "";
	decide on "<invalid text>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a text in the singular):
	decide on the validation error for the text value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a text in the plural):
	decide on the validation error for the text value X.

To say the text value (X - a number):
	if address X could contain a function:
		say "<text with unknown substitutions>";
	otherwise:
		say X converted to some text with paranoia.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a text in the singular):
	say "[the text value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a text in the plural):
	say "[the text value X]".

Chapter "Indexed Text Values" - unindexed

To decide what text is the validation error for the indexed text value (X - a number):
	let the block be X converted to a memory block;
	if the block is a valid head block and the base kind code of the block is the indexed text base kind code:
		decide on "";
	decide on "<invalid indexed text>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an indexed text in the singular):
	decide on the validation error for the indexed text value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an indexed text in the plural):
	decide on the validation error for the indexed text value X.

To say the indexed text value (X - a number):
	let the block be X converted to a memory block;
	let the limit be the extent of the block;
	repeat with the index running over the half-open interval from zero to the limit:
		let the character code be datum number index of the block;
		if the character code is zero:
			stop;
		say "[the Unicode character value character code]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an indexed text in the singular):
	say "[the indexed text value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an indexed text in the plural):
	say "[the indexed text value X]".

Chapter "Snippet Values" - unindexed

To decide what number is the fixed maximum valid word number: (- ((PARSE_BUFFER_LEN-1)/3) -).
To decide what number is the current maximum valid word number: (- WordCount() -).
To decide what number is the address of the characters constituting word number (I - a number): (- WordAddress({I}) -).
To decide what number is the number of characters constituting word number (I - a number): (- WordLength({I}) -).
To decide what number is the beginning command character address: (- buffer -).
To decide what number is the end command character address: (- (buffer+INPUT_BUFFER_LEN) -).

To decide what text is the validation error for the snippet value (X - a number):
	let the beginning word number be X divided by 100;
	let the end word number be the remainder after dividing X by 100;
	if the beginning word number is one and the end word number is zero:
		decide on "";
	if the beginning word number is less than one or the beginning word number is greater than the end word number or the end word number is greater than the fixed maximum valid word number:
		decide on "<invalid snippet>";
	if the end word number is less than the beginning word number or the end word number is greater than the current maximum valid word number:
		decide on "<out-of-bounds snippet>";
	let the beginning address be the address of the characters constituting word number beginning word number;
	let the end address be the address of the characters constituting word number end word number;
	increase the end address by the number of characters constituting word number end word number;
	decrement the end address;
	if the end address is less than the beginning address or the beginning address is less than the beginning command character address or the beginning address is at least the end command character address or the end address is less than the beginning command character address or the end address is at least the end command character address:
		decide on "<out-of-bounds snippet>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a snippet in the singular):
	decide on the validation error for the snippet value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a snippet in the plural):
	decide on the validation error for the snippet value X.

To say the snippet value (X - a number):
	let the beginning word number be X divided by 100;
	let the end word number be the remainder after dividing X by 100;
	if the beginning word number is one and the end word number is zero:
		say "<empty snippet>";
		stop;
	let the beginning address be the address of the characters constituting word number beginning word number;
	let the end address be the address of the characters constituting word number end word number;
	increase the end address by the number of characters constituting word number end word number;
	repeat with the character code address running over the half-open interval from the beginning address to the end address:
		let the character code be the byte at address character code address;
		say "[the Unicode character value character code]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a snippet in the singular):
	say "[the snippet value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a snippet in the plural):
	say "[the snippet value X]".

Chapter "Topic Values" - unindexed

To decide what text is the validation error for the topic value (X - a number):
	if X is zero or X is an invalid byte address:
		decide on "<invalid topic>";
	if address X could contain a function:
		decide on "";
	decide on "<invalid topic>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a topic in the singular):
	decide on the validation error for the topic value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a topic in the plural):
	decide on the validation error for the topic value X.

To say the topic value (X - a number):
	say "[the human-friendly name for the function at address X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a topic in the singular):
	say "[the topic value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a topic in the plural):
	say "[the topic value X]".

Chapter "Action Name Values" - unindexed

To decide what text is the validation error for the action name value (X - a number):
	let the capture be a new uninitialized synthetic text with length one character;
	overwrite the synthetic text capture with the text printed when we say "[the action name value X]";
	let the capture length be the length of the synthetic text capture;
	delete the synthetic text capture;
	if the capture length is greater than zero:
		decide on "";
	decide on "<invalid action name>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a action name in the singular):
	decide on the validation error for the action name value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a action name in the plural):
	decide on the validation error for the action name value X.

To say the action name value (X - a number): (- DB_Action_Details({X},0,0,2); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a action name in the singular):
	say "[the action name value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a action name in the plural):
	say "[the action name value X]".

Chapter "Stored Action Values" - unindexed

To decide what number is the action data offset for the action name value (Y - a number): (- FindAction({Y}) -).
To decide what number is the datum at action data offset (I - a number): (- llo_getField(ActionData,{I}) -).
To decide what number is the noun kind offset: (- 2 -).
To decide what number is the second noun kind offset: (- 3 -).

To decide what number is the base kind code of the noun of the action name value (Y - a number):
	let the offset be the noun kind offset plus the action data offset for the action name value Y;
	decide on the datum at action data offset offset.

To decide what number is the base kind code of the second noun of the action name value (Y - a number):
	let the offset be the second noun kind offset plus the action data offset for the action name value Y;
	decide on the datum at action data offset offset.

To decide whether the understood value (X - a number) with the base kind code (C - a number) is valid in the command (T - some text):
	decide yes.

To decide whether the understood value (X - a number) with the base kind code (C - an boolean-kind-identifying number) is valid in the command (T - some text):
	decide on whether or not the validation error for the truth state value X is empty.

To decide whether the understood value (X - a number) with the base kind code (C - an number-kind-identifying number) is valid in the command (T - some text):
	decide on whether or not the validation error for the number value X is empty.

To decide whether the understood value (X - a number) with the base kind code (C - an understanding-kind-identifying number) is valid in the command (T - some text):
	decide on whether or not the topic match value X of the command T is valid.

To decide whether the understood value (X - a number) with the base kind code (C - an object-kind-identifying number) is valid in the command (T - some text):
	decide on whether or not the validation error for the object value X is empty.

The indexed text address for capturing stored action commands is a number that varies.

To decide what text is the validation error for the stored action value (X - a number):
	let the block be X converted to a memory block;
	unless the block is valid and the size in memory of the block is 32:
		decide on "<invalid stored action>";
	let the action name be datum number zero of the block;
	unless the validation error for the action name value the action name is empty:
		decide on "<invalid stored action>";
	let the command be datum number five of the block;
	unless the command is zero or the validation error for the indexed text value the command is empty:
		decide on "<invalid stored action>";
	now the indexed text address for capturing stored action commands is the command;
	let the command capture be a new synthetic text copied from "[unless the indexed text address for capturing stored action commands is zero][the indexed text value the indexed text address for capturing stored action commands][end if]";
	let the noun be datum number one of the block;
	unless the understood value the noun with the base kind code the base kind code of the noun of the action name value the action name is valid in the command the command capture using a workaround for Inform bug 825:
		delete the synthetic text the command capture;
		decide on "<invalid stored action>";
	let the second noun be datum number two of the block;
	unless the understood value the second noun with the base kind code the base kind code of the second noun of the action name value the action name is valid in the command the command capture using a workaround for Inform bug 825:
		delete the synthetic text the command capture;
		decide on "<invalid stored action>";
	delete the synthetic text the command capture;
	let the actor be datum number three of the block;
	unless the validation error for the object value the actor is empty:
		decide on "<invalid stored action>";
	let the request flag be datum number four of the block;
	unless the request flag is zero or the request flag is one:
		decide on "<invalid stored action>";
	decide on "".	

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a stored action in the singular):
	decide on the validation error for the stored action value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a stored action in the plural):
	decide on the validation error for the stored action value X.

To say the understood value (X - a number) with the base kind code (C - a number) via PrintKindValuePair: (- PrintKindValuePair({C},{X}); -).

To say the understood value (X - a number) with the base kind code (C - a number) in the command (T - some text):
	if the base kind code C is legal:
		say "[the understood value X with the base kind code C via PrintKindValuePair]";
	otherwise:
		say "[the number value X] (unable to format this kind of understood value)".

To say the understood value (X - a number) with the base kind code (C - a boolean-kind-identifying number) in the command (T - some text):
	say "[the truth state value X]".

To say the understood value (X - a number) with the base kind code (C - a number-kind-identifying number) in the command (T - some text):
	say "[the number value X]".

To say the understood value (X - a number) with the base kind code (C - an object-kind-identifying number) in the command (T - some text):
	say "[the object value X]".

To say the understood value (X - a number) with the base kind code (C - an understanding-kind-identifying number) in the command (T - some text):
	say "~[the topic match value X of the command T]~".

To say the stored action value (X - a number):
	let the block be X converted to a memory block;
	let the action name be datum number zero of the block;
	let the noun be datum number one of the block;
	let the second noun be datum number two of the block;
	let the actor be datum number three of the block;
	let the request flag be datum number four of the block;
	let the command be datum number five of the block;
	now the indexed text address for capturing stored action commands is the command;
	let the command capture be a new synthetic text copied from "[unless the indexed text address for capturing stored action commands is zero][the indexed text value the indexed text address for capturing stored action commands][end if]";
	say "[if the request flag is one]asking [the object value the actor] to try[otherwise][the object value the actor][end if] [the action name value the action name]";
	say ", with the noun [the understood value the noun with the base kind code the base kind code of the noun of the action name value the action name in the command the command capture]";
	say " and the second noun [the understood value the second noun with the base kind code the base kind code of the second noun of the action name value the action name in the command the command capture]";
	say "[unless the command is zero] (from the command ~[the indexed text value the command]~)[end if]";
	delete the synthetic text the command capture.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a stored action in the singular):
	say "[the stored action value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a stored action in the plural):
	say "[the stored action value X]".

Chapter "Scene Values" - unindexed

The invalid scene string is a text that varies.
To decide what number is the number of characters needed to identify an invalid scene: (- 15 -).
A kind printing setup rule (this is the allocate synthetic text for the string used to identify invalid scenes rule):
	now the invalid scene string is a new permanent synthetic text copied from "<invalid scene>".

To decide what text is the validation error for the scene value (X - a number):
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an invalid scene characters;
	overwrite the synthetic text capture with the text printed when we say the scene value X;
	unless the synthetic text capture is identical to the synthetic text the invalid scene string:
		delete the synthetic text capture;
		decide on "";
	delete the synthetic text capture;
	decide on "<invalid scene>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a scene in the singular):
	decide on the validation error for the scene value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a scene in the plural):
	decide on the validation error for the scene value X.

To say the scene value (X - a number): (- PrintSceneName({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a scene in the singular):
	say "[the scene value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a scene in the plural):
	say "[the scene value X]".

Chapter "Figure Name Values" - unindexed

The invalid figure name string is a text that varies.
To decide what number is the number of characters needed to identify an invalid figure name: (- 21 -).
A kind printing setup rule (this is the allocate synthetic text for the string used to identify invalid figure names rule):
	now the invalid figure name string is a new permanent synthetic text copied from "<invalid figure name>".

To decide what text is the validation error for the figure name value (X - a number):
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an invalid figure name characters;
	overwrite the synthetic text capture with the text printed when we say the figure name value X;
	unless the synthetic text capture is identical to the synthetic text the invalid figure name string:
		delete the synthetic text capture;
		decide on "";
	delete the synthetic text capture;
	decide on "<invalid figure name>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a figure name in the singular):
	decide on the validation error for the figure name value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a figure name in the plural):
	decide on the validation error for the figure name value X.

To say the figure name value (X - a number): (- PrintFigureName({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a figure name in the singular):
	say "[the figure name value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a figure name in the plural):
	say "[the figure name value X]".

Chapter "Sound Name Values" - unindexed

The invalid sound name string is a text that varies.
To decide what number is the number of characters needed to identify an invalid sound name: (- 20 -).
A kind printing setup rule (this is the allocate synthetic text for the string used to identify invalid sound names rule):
	now the invalid sound name string is a new permanent synthetic text copied from "<invalid sound name>".

To decide what text is the validation error for the sound name value (X - a number):
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an invalid sound name characters;
	overwrite the synthetic text capture with the text printed when we say the sound name value X;
	unless the synthetic text capture is identical to the synthetic text the invalid sound name string:
		delete the synthetic text capture;
		decide on "";
	delete the synthetic text capture;
	decide on "<invalid sound name>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a sound name in the singular):
	decide on the validation error for the sound name value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a sound name in the plural):
	decide on the validation error for the sound name value X.

To say the sound name value (X - a number): (- PrintSoundName({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a sound name in the singular):
	say "[the sound name value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a sound name in the plural):
	say "[the sound name value X]".

Chapter "External File Values" - unindexed

The invalid external file string is a text that varies.
To decide what number is the number of characters needed to identify an invalid external file: (- 23 -).
A kind printing setup rule (this is the allocate synthetic text for the string used to identify invalid external files rule):
	now the invalid external file string is a new permanent synthetic text copied from "<invalid external file>".

To decide what text is the validation error for the external file value (X - a number):
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an invalid external file characters;
	overwrite the synthetic text capture with the text printed when we say the external file value X;
	unless the synthetic text capture is identical to the synthetic text the invalid external file string:
		delete the synthetic text capture;
		decide on "";
	delete the synthetic text capture;
	decide on "<invalid external file>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a external file in the singular):
	decide on the validation error for the external file value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a external file in the plural):
	decide on the validation error for the external file value X.

To say the external file value (X - a number): (- PrintExternalFileName({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a external file in the singular):
	say "[the external file value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a external file in the plural):
	say "[the external file value X]".

Chapter "List Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the singular) with plural flag (F - a truth state):
	say "list[if F is true]s[end if] of [the kind parse rooted at the first child of V with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the plural) with plural flag (F - a truth state):
	say "list[if F is true]s[end if] of [the kind parse rooted at the first child of V with plural flag true and brackets as necessary]".

To decide what number is the list length datum index: (- LIST_LENGTH_F -).
To decide what number is the list element kind datum index: (- LIST_ITEM_KOV_F -).
To decide what number is the list contents datum offset: (- LIST_ITEM_BASE -).

To decide what text is the validation error for the list value (X - a number):
	let the block be X converted to a memory block;
	unless the block is a valid head block and the base kind code of the block is the list base kind code:
		decide on "<invalid list>";
	let the extent be the extent of the block;
	if the list length datum index is at least the extent or the list element kind datum index is at least the extent:
		decide on "<invalid list>";
	let the length be datum number list length datum index of the block;
	let the beginning datum index be the list contents datum offset;
	let the end datum index be the list contents datum offset plus the length;
	if the length is less than zero or the end datum index is greater than the extent:
		decide on "<invalid list>";
	let the kind code be datum number list element kind datum index of the block;
	unless the kind code the kind code is legal:
		decide on "<invalid list>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the singular):
	decide on the validation error for the list value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the plural):
	decide on the validation error for the list value X.

To decide whether the list value (X - a number) is completely valid using the kind parse rooted at (V - a parse tree vertex):
	if the validation error for the list value X is not empty:
		decide no;
	let the subkind vertex be the first child of V;
	always check that the subkind vertex is not null or else fail at finding kind parameters in V;
	let the block be X converted to a memory block;
	let the length be datum number list length datum index of the block;
	if the length is greater than zero:
		let the beginning datum index be the list contents datum offset;
		let the end datum index be the list contents datum offset plus the length;
		repeat with the index running over the half-open interval from the beginning datum index to the end datum index:
			unless datum number index of the block is completely valid using the kind parse rooted at the subkind vertex:
				decide no;
	decide yes.

[//// Workaround for Inform bug ### above ////]
[To decide whether (X - a number) is completely valid using the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the singular):
	decide on whether or not the list value X is completely valid using the kind parse rooted at V.
To decide whether (X - a number) is completely valid using the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the plural):
	decide on whether or not the list value X is completely valid using the kind parse rooted at V.]

To say the list value (X - a number) using the kind parse rooted at (V - a parse tree vertex):
	let the subkind vertex be the first child of V;
	always check that the subkind vertex is not null or else fail at finding kind parameters in V;
	let the block be X converted to a memory block;
	let the length be datum number list length datum index of the block;
	if the length is at most zero:
		say "{}";
		stop;
	let the beginning datum index be the list contents datum offset;
	let the end datum index be the list contents datum offset plus the length;
	say "{ ";
	repeat with the index running over the half-open interval from the beginning datum index to the end datum index:
		say "[datum number index of the block using the kind parse rooted at the subkind vertex with paranoia][if the index is not the end datum index minus one], [end if]";
	say " }".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the singular):
	say "[the list value X using the kind parse rooted at V]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a list in the plural):
	say "[the list value X using the kind parse rooted at V]".

Chapter "Table Name Values" - unindexed

The empty table string is a text that varies.
The invalid table string is a text that varies.
To decide what number is the number of characters needed to identify an empty or invalid table: (- 19 -).
A kind printing setup rule (this is the allocate synthetic text for the strings used to identify empty and invalid tables rule):
	now the empty table string is a new permanent synthetic text copied from "(the empty table)";
	now the invalid table string is a new permanent synthetic text copied from "** No such table **".

To decide what text is the validation error for the table name value (X - a number):
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an empty or invalid table characters;
	overwrite the synthetic text capture with the text printed when we say "[the table name value X]";
	if the synthetic text capture is identical to the synthetic text the empty table string:
		delete the synthetic text capture;
		decide on "<empty table name>";
	if the synthetic text capture is identical to the synthetic text invalid table string:
		delete the synthetic text capture;
		decide on "<invalid table name>";
	delete the synthetic text capture;
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table name in the singular):
	decide on the validation error for the table name value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table name in the plural):
	decide on the validation error for the table name value X.

To say the table name value (X - a number): (- PrintTableName({X}); -).

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table name in the singular):
	say "[the table name value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table name in the plural):
	say "[the table name value X]".

Chapter "Table Column Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a table column in the singular) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] valued table column[if F is true]s[end if]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a table column in the plural) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] valued table column[if F is true]s[end if]".

To decide what number is the minimum table column value: (- 100 -).
To decide whether the table column value (X - a number) is an unknown table column: (- (TC_KOV({X})==UNKNOWN_TY) -).
To decide what number is the address of I6_TC_KOV: (- TC_KOV -).

To decide what text is the validation error for the table column value (X - a number):
	if the table column value X is an unknown table column:
		decide on "<invalid table column>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table column in the singular):
	decide on the validation error for the table column value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table column in the plural):
	decide on the validation error for the table column value X.

The table column comment prefix is a text that varies.
The table column comment infix is a text that varies.
A kind printing setup rule (this is the allocate synthetic text for the I6 substrings used to identify and split table column comments rule):
	now the table column comment prefix is a new permanent synthetic text copied from "! ";
	now the table column comment infix is a new permanent synthetic text copied from ": ".

To say the table column value (X - a number):
	let the routine record be the routine record for the address of I6_TC_KOV;
	let the beginning line number be the beginning line number of the routine record;
	let the end line number be the end line number of the routine record;
	let the guessed line number be the beginning line number plus two plus X minus the minimum table column value;
	if the guessed line number is less than the beginning line number or the guessed line number is at least the end line number:
		say "<table column [X minus the minimum table column value]>";
		stop;
	let the I6 be the I6 of the source line record for line number guessed line number;
	let the result be a new synthetic text extracted from the synthetic text I6 between the synthetic prefix the table column comment prefix and the synthetic suffix the table column comment infix or the interned empty string if there is no match;
	if the result is empty:
		say "<table column [X minus the minimum table column value]>";
		stop;
	say "[the result]";
	delete the synthetic text the result.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table column in the singular):
	say "[the table column value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a table column in the plural):
	say "[the table column value X]".

Chapter "Equation Name Values" - unindexed

To decide what text is the validation error for the equation name value (X - a number):
	if X is zero or X is an invalid byte address:
		decide on "<invalid equation name>";
	if address X could contain a function: 
		decide on "";
	decide on "<invalid equation name>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an equation name in the singular):
	decide on the validation error for the equation name value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an equation name in the plural):
	decide on the validation error for the equation name value X.

To say the equation name value (X - a number):
	say "[the human-friendly name for the function at address X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an equation name in the singular):
	say "[the equation name value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an equation name in the plural):
	say "[the equation name value X]".

Chapter "Relation Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a relation in the singular) with plural flag (F - a truth state):
	say "relation[if F is true]s[end if] of [the kind parse rooted at the first child of V with plural flag true and brackets as necessary] to [the kind parse rooted at the last child of V with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a relation in the plural) with plural flag (F - a truth state):
	say "relation[if F is true]s[end if] of [the kind parse rooted at the first child of V with plural flag true and brackets as necessary] to [the kind parse rooted at the last child of V with plural flag true and brackets as necessary]".

To decide what number is the relation name offset: (- (4*RR_NAME) -).

The anonymous relation string is a text that varies.
To decide what number is the number of characters needed to identify an anonymous relation: (- 18 -).
A kind printing setup rule (this is the allocate synthetic text for the string used to identify anonymous relations rule):
	now the anonymous relation string is a new permanent synthetic text copied from "anonymous relation".

To decide what text is the validation error for the relation value (X - a number):
	if X is zero:
		decide on "<invalid relation>";
	let the name address be X plus the relation name offset;
	if the name address is an invalid integer address:
		decide on "<invalid relation>";
	if the integer at address name address converted to some text could be substitution-free compressed text:
		decide on "";
	decide on "<invalid relation>".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a relation in the singular):
	decide on the validation error for the relation value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a relation in the plural):
	decide on the validation error for the relation value X.

To say the relation value (X - a number):
	let the name address be X plus the relation name offset;
	let the name be the integer at address name address converted to some text;
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an anonymous relation characters;
	overwrite the synthetic text capture with the text printed when we say the name with paranoia;
	if the synthetic text capture is identical to the synthetic text anonymous relation string:
		say "<anonymous relation at address [X in hexadecimal]>";
	otherwise:
		say the name with paranoia;
	delete the synthetic text capture.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a relation in the singular):
	say "[the relation value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a relation in the plural):
	say "[the relation value X]".

Chapter "Custom Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a value in the singular) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag F and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a value in the plural) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag F and brackets as necessary]".

The kind name for validating custom values is a text that varies.
The value for validating custom values is a number that varies.
The base kind code for validating custom values is a number that varies.

To decide what text is the validation error for the custom value (X - a number) using the kind parse rooted at (V - a parse tree vertex):
	now the kind name for validating custom values is a new synthetic text representing the words matched by V;
	now the base kind code for validating custom values is the first number value matching the synthetic textual key the kind name for validating custom values in the kind-of-value hash table or zero if there are no matches;
	if the base kind code for validating custom values is zero:
		delete the synthetic text the kind name for validating custom values;
		decide on "<unprintable value>";
	now the value for validating custom values is X;
	if "[the understood value the value for validating custom values with the base kind code the base kind code for validating custom values via PrintKindValuePair]" is identical to "<invalid [the kind name for validating custom values]>":
		delete the synthetic text the kind name for validating custom values;
		decide on "<invalid value of custom kind>";
	delete the synthetic text the kind name for validating custom values;
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a value in the singular):
	decide on the validation error for the custom value X using the kind parse rooted at V.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a value in the plural):
	decide on the validation error for the custom value X using the kind parse rooted at V.

To say the custom value (X - a number) using the kind parse rooted at (V - a parse tree vertex):
	now the kind name for validating custom values is a new synthetic text representing the words matched by V;
	now the base kind code for validating custom values is the first number value matching the synthetic textual key the kind name for validating custom values in the kind-of-value hash table or zero if there are no matches;
	say "[the understood value the value for validating custom values with the base kind code the base kind code for validating custom values via PrintKindValuePair]";
	delete the synthetic text the kind name for validating custom values.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a value in the singular):
	say "[the custom value X using the kind parse rooted at V]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a value in the plural):
	say "[the custom value X using the kind parse rooted at V]".

Chapter "Object Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a object in the singular) with plural flag (F - a truth state):
	if the first child of V is null:
		say "[the kind name for the parseme of V with plural flag F]";
	otherwise:
		say "[the kind parse rooted at the first child of V with plural flag F and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a object in the plural) with plural flag (F - a truth state):
	if the first child of V is null:
		say "[the kind name for the parseme of V with plural flag F]";
	otherwise:
		say "[the kind parse rooted at the first child of V with plural flag F and brackets as necessary]".

To decide what number is the address of the I6 class Class: (- Class -).
To decide what number is the address of the I6 class String: (- String -).
To decide what number is the address of the I6 class Routine: (- Routine -).
To decide what number is the address of the I6 class Object: (- Object -).

To decide what number is the offset to an object parent: (- 20 -).

To decide whether (O - an object) has a short name: (- ({O}.&short_name) -).
To decide what text is the short name of (O - an object): (- ({O}.short_name) -).

To decide what text is the validation error for the object value (X - a number):
	if X is zero:
		decide on "";
	let the parent address address be X plus the offset to an object parent;
	if X is less than the size of read-only memory or the parent address address is an invalid integer address:
		decide on "<invalid object>";
	unless address X could contain an object:
		decide on "<invalid object>";
	let the parent address be the integer at address parent address address;
	if the parent address is not zero:
		if the parent address is an invalid byte address or address parent address could not contain an object:
			decide on "<invalid object>";
	let the conversion be X converted to an object;
	if the conversion has a short name:
		unless the short name of the conversion could be text:
			decide on "<object with invalid short name>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an object in the singular):
	decide on the validation error for the object value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an object in the plural):
	decide on the validation error for the object value X.

To say the object value (X - a number):
	if X is zero:
		say "nothing";
		stop;
	if X is the address of the I6 class Class:
		say "<the Class class>";
		stop;
	if X is the address of the I6 class String:
		say "<the String class>";
		stop;
	if X is the address of the I6 class Routine:
		say "<the Routine class>";
		stop;
	if X is the address of the I6 class Object:
		say "<the Object class>";
		stop;
	let the parent address address be X plus the offset to an object parent;
	let the parent address be the integer at address parent address address;
	if the parent address is the address of the I6 class Class:
		say "<a declared class at address [X converted to a number]>";
		stop;
	let the conversion be X converted to an object;
	unless the conversion has a short name:
		say "<anonymous object at address [X converted to a number]>";
		stop;
	let the short name be the short name of the conversion;
	if address the short name converted to a number could contain a string:
		say "[the short name with paranoia]";
	otherwise:
		say "an object named by [the short name with paranoia]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an object in the singular):
	say "[the object value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an object in the plural):
	say "[the object value X]".

Chapter "Property Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a valued property in the singular) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] valued propert[if F is true]ies[otherwise]y[end if]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a valued property in the plural) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] valued propert[if F is true]ies[otherwise]y[end if]".

To decide what number is the limit on attributed properties: (- attributed_property_offsets_SIZE -).
To decide what number is the limit on valued properties: (- valued_property_offsets_SIZE -).
To decide what number is the metadata offset of the attributed property (P - a number): (- attributed_property_offsets-->{P} -).
To decide what number is the metadata offset of the valued property (P - a number): (- valued_property_offsets-->{P} -).

To decide what text is the name at the property metadata offset (M - a number): (- property_metadata-->{M} -).

The anonymous property string is a text that varies.
To decide what number is the number of characters needed to identify an anonymous property: (- 10 -).
A kind printing setup rule (this is the allocate synthetic text for the string used to identify anonymous properties rule):
	now the anonymous property string is a new permanent synthetic text copied from "<nameless>".

To decide what text is the name of the attributed property value (X - a number):
	let the signless value be X;
	if the signless value is less than zero:
		now the signless value is the bitwise not of the signless value;
	if the signless value is unsigned at least the limit on attributed properties:
		decide on "";
	let the metadata offset be the metadata offset of the attributed property the signless value;
	if the metadata offset is less than zero:
		decide on "";
	let the result be the name at the property metadata offset metadata offset;
	unless the result could be text:
		decide on "";
	decide on the result.

To decide what text is the name of the valued property value (X - a number):
	if X is unsigned at least the limit on valued properties:
		decide on "";
	let the metadata offset be the metadata offset of the valued property X;
	if the metadata offset is less than zero:
		decide on "";
	let the result be the name at the property metadata offset metadata offset;
	unless the result could be text:
		decide on "";
	decide on the result.

To decide what text is the validation error for the attributed property value (X - a number):
	let the signless value be X;
	if the signless value is less than zero:
		now the signless value is the bitwise not of the signless value;
	if the name of the attributed property value the signless value is empty:
		decide on "<invalid either/or property>";
	decide on "".

To decide what text is the validation error for the valued property value (X - a number):
	if the name of the valued property value X is empty:
		decide on "<invalid property>";
	decide on "".

[Either/or properties are extra tricky because they can mean either an I6 attribute or a truth state valued property.]
To decide what text is the validation error for the either-or property value (X - a number):
	let the attributed validation error be the validation error for the attributed property value X;
	if the attributed validation error is empty:
		decide on "";
	let the valued validation error be the validation error for the valued property value X;
	if the valued validation error is empty:
		decide on "";
	decide on the attributed validation error.

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an either/or property in the singular):
	decide on the validation error for the either-or property value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an either/or property in the plural):
	decide on the validation error for the either-or property value X.

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a valued property in the singular):
	decide on the validation error for the valued property value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a valued property in the plural):
	decide on the validation error for the valued property value X.

To say the revised name of the attributed property value (X - a number):
	let the signless value be X;
	if the signless value is less than zero:
		now the signless value is the bitwise not of the signless value;
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an anonymous property characters;
	overwrite the synthetic text capture with the text printed when we say the name of the attributed property value the signless value with paranoia;
	if the synthetic text capture is identical to the synthetic text anonymous property string:
		say "<anonymous either/or property [the signless value]>";
	otherwise:
		say "[unless X is the signless value]not [end if][the name of the attributed property value the signless value with paranoia]";
	delete the synthetic text capture.

To say the revised name of the valued property value (X - a number):
	let the capture be a new uninitialized synthetic text with length the number of characters needed to identify an anonymous property characters;
	overwrite the synthetic text capture with the text printed when we say the name of the valued property value X with paranoia;
	if the synthetic text capture is identical to the synthetic text anonymous property string:
		say "<anonymous property [X converted to a number]>";
	otherwise:
		say "[the name of the valued property value X with paranoia]";
	delete the synthetic text capture.

To say the either-or property value (X - a number):
	let the attributed validation error be the validation error for the attributed property value X;
	if the attributed validation error is empty:
		say "[the revised name of the attributed property value X]";
	let the valued validation error be the validation error for the valued property value X;
	if the valued validation error is empty:
		say "[if the attributed validation error is empty] or else [end if][the revised name of the valued property value X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an either/or property in the singular):
	say "[the either-or property value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an either/or property in the plural):
	say "[the either-or property value X]".

To say the valued property value (X - a number):
	say "[the revised name of the valued property value X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a valued property in the singular):
	say "[the valued property value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a valued property in the plural):
	say "[the valued property value X]".

Chapter "Description Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a description in the singular) with plural flag (F - a truth state):
	say "description[if F is true]s[end if] of [the kind parse rooted at the first child of V with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a description in the plural) with plural flag (F - a truth state):
	say "description[if F is true]s[end if] of [the kind parse rooted at the first child of V with plural flag true and brackets as necessary]".

[We use I6 macros to include brackets without causing ni to emit a text routine.]
To decide what text is the nonsynthetic second-line description comment prefix: (- "! [ " -).
To decide what text is the nonsynthetic second-line description comment suffix: (- " ]" -).

The first-line description comment prefix is a text that varies.
The first-line description comment suffix is a text that varies.
The second-line description comment prefix is a text that varies.
The second-line description comment suffix is a text that varies.
A kind printing setup rule (this is the allocate synthetic text for the I6 substrings used to identify description comments rule):
	now the first-line description comment prefix is a new synthetic text copied from "! Abstraction for set of ";
	now the first-line description comment suffix is a new synthetic text copied from " such that";
	now the second-line description comment prefix is a new synthetic text copied from the nonsynthetic second-line description comment prefix;
	now the second-line description comment suffix is a new synthetic text copied from the nonsynthetic second-line description comment suffix.

To decide what text is the validation error for the description value (X - a number):
	if X is zero or X is an invalid byte address:
		decide on "<invalid description>";
	unless address X could contain a function:
		decide on "<invalid description>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a description in the singular):
	decide on the validation error for the description value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a description in the plural):
	decide on the validation error for the description value X.

To say the description value (X - a number):
	let the routine record be the routine record for X;
	if the routine record is an invalid routine record:
		[Note that the description might still be valid: it might have been compiled at runtime.]
		say "[the human-friendly name for the function at address X]";
		stop;
	let the beginning line number be the beginning line number of the routine record;
	if the beginning line number is less than three:
		say "[the human-friendly name for the function at address X]";
		stop;
	let the first comment line be the I6 of the source line record for line number beginning line number minus two;
	let the second comment line be the I6 of the source line record for line number beginning line number minus one;
	let the quantified terms be a new synthetic text extracted from the synthetic text first comment line between the synthetic prefix the first-line description comment prefix and the synthetic suffix the first-line description comment suffix or the interned empty string if there is no match;
	if the quantified terms are empty:
		say "[the human-friendly name for the function at address X]";
		stop;
	let the predicate be a new synthetic text extracted from the synthetic text second comment line between the synthetic prefix the second-line description comment prefix and the synthetic suffix the second-line description comment suffix or the interned empty string if there is no match;
	if the predicate is empty:
		delete the synthetic text the quantified terms;
		say "[the human-friendly name for the function at address X]";
		stop;
	say "[the quantified terms] such that [bracket] [the predicate] [close bracket]";
	delete the synthetic text the quantified terms;
	delete the synthetic text the predicate.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a description in the singular):
	say "[the description value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a description in the plural):
	say "[the description value X]".

Chapter "Phrase Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a phrase in the singular) with plural flag (F - a truth state):
	let the first child be the first child of V;
	let the last child be the last child of V;
	say "phrase[if F is true]s[end if] (";
	repeat with the child running through the children of V:
		if the child is not the last child:
			say "[if the child is not the first child], [end if][the kind parse rooted at the child with plural flag false and brackets as necessary]";
	say ") -> [the kind parse rooted at the last child with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a phrase in the plural) with plural flag (F - a truth state):
	let the first child be the first child of V;
	let the last child be the last child of V;
	say "phrase[if F is true]s[end if] (";
	repeat with the child running through the children of V:
		if the child is not the last child:
			say "[if the child is not the first child], [end if][the kind parse rooted at the child with plural flag false and brackets as necessary]";
	say ") -> [the kind parse rooted at the last child with plural flag true and brackets as necessary]".

To decide what text is the validation error for the phrase value (X - a number):
	let the name address be the name address of the phrase at address X;
	if the name address is an invalid integer address:
		decide on "<invalid phrase>";
	unless address X could contain a phrase:
		decide on "<invalid phrase>";
	let the kind code be the integer at address X;
	unless the kind code the kind code represents a phrase:
		decide on "<invalid phrase>";
	let the name be the name address converted to text;
	unless the name could be text:
		decide on "<invalid phrase>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a phrase in the singular):
	decide on the validation error for the phrase value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a phrase in the plural):
	decide on the validation error for the phrase value X.

To say the phrase value (X - a number):
	let the name be the name address of the phrase at address X converted to a text;
	say the name with paranoia.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a phrase in the singular):
	say "[the phrase value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a phrase in the plural):
	say "[the phrase value X]".

Chapter "Rulebook Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook in the singular) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] based rulebook[if F is true]s[end if] producing [the kind parse rooted at the last child of V with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook in the plural) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] based rulebook[if F is true]s[end if] producing [the kind parse rooted at the last child of V with plural flag true and brackets as necessary]".

To decide what number is the number of rulebooks created: (- NUMBER_RULEBOOKS_CREATED -).
To decide what text is the name of rulebook (X - a number): (- RulebookNames-->{X} -).

To decide what text is the validation error for the rulebook value (X - a number):
	if X is unsigned at least the number of rulebooks created:
		decide on "<invalid rulebook>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook in the singular):
	decide on the validation error for the rulebook value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook in the plural):
	decide on the validation error for the rulebook value X.

To say the rulebook value (X - a number):
	say "[the name of rulebook X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook in the singular):
	say "[the rulebook value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rulebook in the plural):
	say "[the rulebook value X]".

Chapter "Rule Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a rule in the singular) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] based rule[if F is true]s[end if] producing [the kind parse rooted at the last child of V with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme a rule in the plural) with plural flag (F - a truth state):
	say "[the kind parse rooted at the first child of V with plural flag true and brackets as necessary] based rule[if F is true]s[end if] producing [the kind parse rooted at the last child of V with plural flag true and brackets as necessary]".

To decide what text is the validation error for the rule value (X - a number):
	unless address X could contain a function:
		decide on "<invalid rule>";
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a routine in the singular):
	decide on the validation error for the rule value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a routine in the plural):
	decide on the validation error for the rule value X.

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rule in the singular):
	decide on the validation error for the rule value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rule in the plural):
	decide on the validation error for the rule value X.

To say the rule value (X - a number):
	say "[the human-friendly name for the function at address X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a routine in the singular):
	say "[the rule value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a routine in the plural):
	say "[the rule value X]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rule in the singular):
	say "[the rule value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme a rule in the plural):
	say "[the rule value X]".

Chapter "Activity Values" - unindexed

To say the kind parse rooted at (V - a parse tree vertex that has the parseme an activity in the singular) with plural flag (F - a truth state):
	say "activit[if F is true]ies[otherwise]y[end if] on [the kind parse rooted at the first child of V with plural flag true and brackets as necessary]".

To say the kind parse rooted at (V - a parse tree vertex that has the parseme an activity in the plural) with plural flag (F - a truth state):
	say "activit[if F is true]ies[otherwise]y[end if] on [the kind parse rooted at the first child of V with plural flag true and brackets as necessary]".

To decide what number is the address of the array of rulebooks for activities: (- Activity_for_rulebooks -).
To decide what number is the rulebook index for activity number (I - a number): (- (Activity_for_rulebooks-->{I}) -).

The number of activities created is a number that varies.
A kind printing setup rule (this is the count the number of activities created rule):
	let the maximum possible length be the size of memory minus the address of the array of rulebooks for activities;
	now the maximum possible length is the maximum possible length divided by four;
	now the number of activities created is the index of the integer -1 in the maximum possible length integers at address address of the array of rulebooks for activities.

The for-activity rulebook name prefix is a text that varies.
The for-activity rulebook name suffix is a text that varies.
A kind printing setup rule (this is the allocate synthetic text for the substrings used to identify and split for-activity rulebook names rule):
	now the for-activity rulebook name prefix is a new permanent synthetic text copied from "for ";
	now the for-activity rulebook name suffix is a new permanent synthetic text copied from " rulebook".

To decide what text is the validation error for the activity value (X - a number):
	if X is unsigned at least the number of activities created:
		decide on "<invalid activity>";
	let the rulebook index be the rulebook index for activity number X;
	if the validation error for the rulebook value rulebook index is not empty:
		decide on "<invalid activity>";
	let the rulebook name be a new synthetic text copied from the name of rulebook rulebook index;
	let the activity name be a new synthetic text extracted from the synthetic text rulebook name between the synthetic prefix the for-activity rulebook name prefix and the synthetic suffix the for-activity rulebook name suffix or the interned empty string if there is no match;
	delete the synthetic text the rulebook name;
	if the activity name is empty:
		decide on "<invalid activity>";
	delete the synthetic text the activity name;
	decide on "".

To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an activity in the singular):
	decide on the validation error for the activity value X.
To decide what text is the validation error for (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an activity in the plural):
	decide on the validation error for the activity value X.

To say the activity value (X - a number):
	let the rulebook index be the rulebook index for activity number X;
	let the rulebook name be a new synthetic text copied from the name of rulebook rulebook index;
	let the activity name be a new synthetic text extracted from the synthetic text rulebook name between the synthetic prefix the for-activity rulebook name prefix and the synthetic suffix the for-activity rulebook name suffix or the interned empty string if there is no match;
	delete the synthetic text the rulebook name;
	say "[the activity name]";
	delete the synthetic text the activity name.

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an activity in the singular):
	say "[the activity value X]".
To say (X - a number) using the kind parse rooted at (V - a parse tree vertex that has the parseme an activity in the plural):
	say "[the activity value X]".

Part "Redispatch Phrases" - unindexed

To say the kind parse rooted at (V - a parse tree vertex) with plural flag (F - a truth state) and brackets as necessary:
	if V is not a root and the parent of V is not a root and the first child of V is not null:
		say "([the kind parse rooted at V with plural flag F and a workaround for Inform bug 848])";
	otherwise:
		say "[the kind parse rooted at V with plural flag F and a workaround for Inform bug 848]".

To say (X - a number) using the kind parse rooted at (V - a parse tree vertex) with paranoia:
	let the validation error be the validation error for X using the kind parse rooted at V and a workaround for Inform bug 848;
	if the validation error is empty:
		say "[X using the kind parse rooted at V]";
	otherwise:
		say "[the validation error]".

Part "Private State and Phrases for the Public Phrases" - unindexed

The root of the kind parse in holding is a parse tree vertex that varies.

To clear the kind parse in holding:
	if the root of the kind parse in holding is an invalid parse tree vertex:
		set up kind printing;
	otherwise:
		unless the root of the kind parse in holding is null:
			delete the root of the kind parse in holding and its descendants;
		delete the punctuated words from the kind name parser;
	now the root of the kind parse in holding is an invalid parse tree vertex.

Part "Public Phrases"

To decide whether there is a kind named (T - some text):
	clear the kind parse in holding;
	now the kind name validity check flag is false;
	write the punctuated words of T to the kind name parser;
	let the result be false;
	repeat with the root running through matches for a kind in the singular:
		now the result is true;
		break;
	delete the punctuated words from the kind name parser;
	decide on the result.

To parse the kind name (T - some text) for (X - a number) with disambiguation by (D - a phrase (context-free parser, linked list, truth state) -> disambiguation feature):
	clear the kind parse in holding;
	now the kind name validity check flag is whether or not D is not the default value of a phrase (context-free parser, linked list, truth state) -> disambiguation feature;
	now the value to check kind name validity with is X;
	write the punctuated words of T to the kind name parser;
	now the root of the kind parse in holding is the root of the match for a kind in the singular canonicalized by the kind name canonicalization rulebook and disambiguated by scores from the kind name scoring rulebook and primary filtration from the kind name filtration rulebook and secondary filtration from the kind name filtration rulebook and disambiguating choices from D.

To parse the kind name (T - some text) for (X - a number):
	parse the kind name T for X with disambiguation by the default value of a phrase (context-free parser, linked list, truth state) -> disambiguation feature.

To decide whether the most recently parsed kind name was understood:
	decide on whether or not the root of the kind parse in holding is not null.

To say the most recently parsed kind name:
	always check that the root of the kind parse in holding is not an invalid parse tree vertex or else fail at saying a nonexistent previous kind name parse;
	always check that the root of the kind parse in holding is not null or else fail at saying a previous kind name parse that was not understood;
	say "[the kind parse rooted at the root of the kind parse in holding with plural flag false and a workaround for Inform bug 848]".

To say (X - a number) according to the most recently parsed kind name:
	always check that the root of the kind parse in holding is not an invalid parse tree vertex or else fail at saying a value according to a nonexistent previous kind name parse;
	if the root of the kind parse in holding is null:
		say "[X converted to a number] (unable to format a value of this kind)";
	otherwise:
		say "[X using the kind parse rooted at the root of the kind parse in holding with paranoia]".

To say (X - a number) according to the kind named (T - some text):
	parse the kind name T for X;
	say "[X according to the most recently parsed kind name]".

Book "Setup"

Chapter "Setup Flag" -- unindexed

The kind printing setup flag is a truth state that varies.  The kind printing setup flag is false.

Chapter "Setup Phrase" - unindexed

To set up kind printing:
	if the kind printing setup flag is false:
		traverse the kind printing setup rulebook;
		now the kind printing setup flag is true.

Printing according to Kind Names ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Printing according to Kind Names is a low-level extension for debugging tools.
It lets them safely say values in a human-understandable way, even when they're
stored as the wrong kind.  For instance, a line like

	say 273837 according to the kind named "person";

might produce the text

	"yourself"

Details are in the following chapters.

Chapter: Usage

Section: Preliminaries

Printing according to Kind Names depends on Debug File Parsing, which requires
some setup outside of the story file---see that extension's documentation.

Section: Phrases

After the preliminaries, there are only two phrases to worry about.  The first,

	if there is a kind named (T - some text):
		....

tests whether T is a legal and complete kind name; the condition will (in most
stories) hold for "list of people", but (in most stories) fail for "list".
Kinds of kinds are not kinds, so, for instance, there is (again, in most
stories) no kind named "sayable value".

The second phrase,

	say (X - a number) according to the kind named (T - some text)

prints X as if if has the kind named by T, failing gracefully if that's not
possible.  For example, if we use a conversion phrase from Low-Level Operations,
we could write

	let foo be yourself converted to a number;
	say foo according to the kind named "person";

and get the expected output

	"yourself"

whereas code like

	say four according to the kind named "person";

will serve up

	"<invalid object>"

More generally, we can expect text in the form

	"<invalid ...>"

whenever T names a valid kind but X cannot possibly match it.  If T isn't even a
legal kind name, as in

	say four according to the kind named "bogus";

then X is printed as a number with a parenthetical explanation:

	"4 (unable to format a value of this kind)"

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Section: Regarding bugs

If you encounter a bug, check first on the project website
(https://github.com/i7/i7grip) to see whether a newer version of this extension
is available.  If, even using the latest version, the fault remains, please file
a bug report: On the website, choose "Issues" from the toolbar and click on "New
Issue".

I will try to respond quickly, at least with an estimate of when the bug might
be fixed, though sometimes I am away from the internet for a week or two at a
time.

Chapter: Acknowledgements

Printing according to Kind Names was prepared as part of the Glulx Runtime
Instrumentation Project (https://github.com/i7/i7grip).  For this first edition
of the project, special thanks go to these people, in chronological order:

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

Version 1 of Punctuated Word Parsing Engine (for Glulx only) by Brady Garvin begins here.

"Convenience phrases for the most common use of Context-Free Parsing Engine, parsing sequences of (possibly punctuated) words."

Include Runtime Checks by Brady Garvin.
Include Context-Free Parsing Engine by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Punctuated Word Parsing Engine you will see a sentence like

	A punctuated word array is an invalid punctuated word array.

This bewildering statement actually sets up punctuated word arrays as a qualitative value with default value the punctuated word array at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on punctuated word arrays.]

Chapter "Use Options"

Use a punctuated word terminal hash table size of at least 1123 translates as (- Constant PWPE_TERMINAL_HASH_SIZE={N}; -).

To decide what number is the punctuated word terminal hash table size: (- PWPE_TERMINAL_HASH_SIZE -).

Chapter "Text Constants"

To decide what text is the parseme placeholder for understand lines: (- "placeholderForAParseme" -).

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at building a punctuated word array from changing text:
	say "[low-level runtime failure in]Punctuated Word Parsing Engine[with explanation]I tried to build a punctuated word array from some text, which means first counting the number of words and then recording each of them.  But the recording process came up with a different number of words than I had originally counted, which means that this text is changing as I print it.[terminating the story]".

To fail at understand line reentrancy:
	say "[low-level runtime failure in]Punctuated Word Parsing Engine[with explanation]I tried to interpret an understand line as part of interpreting an understand line.  But I can only handle one at a time.[terminating the story]".

To fail at understanding as multiple tokens:
	say "[low-level runtime failure in]Punctuated Word Parsing Engine[with explanation]I encountered a malformed understand line where the right-hand side was more than a single parseme.  (Sometimes this happens if you forget the square brackets.)[terminating the story]".

To fail at understanding as a single literal word:
	say "[low-level runtime failure in]Punctuated Word Parsing Engine[with explanation]I encountered a malformed understand line where the right-hand side was a single word rather than a single parseme.  Perhaps the square brackets were forgotten?[terminating the story]".

Book "Punctuated Words"

Chapter "Character Classes" - unindexed

Include (-
	Constant PWPE_PUNCTUATION_COUNT = 13;
	Array pwpe_punctuation ->
		33  ! !
		34  ! "
		40  ! (
		41  ! )
		44  ! ,
		47  ! /
		58  ! :
		59  ! ;
		63  ! ?
		91  ! [
		93  ! ]
		123 ! {
		125 ! }
		;
-) after "Definitions.i6t".

To decide whether (C - a number) is a character code for whitespace: (- llo_unsignedLessThanOrEqual({C},32) -).
To decide whether (C - a number) is a character code for independent punctuation: (- (llo_byteIndex({C},pwpe_punctuation,PWPE_PUNCTUATION_COUNT)~=-1) -).

Chapter "State Machine" - unindexed

A punctuated word state is a kind of value.
The punctuated word states are
	transitioning after whitespace,
	transitioning after independent punctuation,
	transitioning after a hyphen,
	transitioning after a full stop,
	and transitioning after nonpunctuation.
The specification of a punctuated word state is "Punctuated word states are used to classify between-character positions when Punctuated Word Parsing Engine breaks text into punctuated words."

To decide what punctuated word state is the punctuated word state that follows (C - a number):
	if C is a character code for whitespace:
		decide on transitioning after whitespace;
	if C is a character code for independent punctuation:
		decide on transitioning after independent punctuation;
	if C is 45 [hyphen]:
		decide on transitioning after a hyphen;
	if C is 46 [full stop]:
		decide on transitioning after a full stop;
	decide on transitioning after nonpunctuation.

To decide whether (A - a punctuated word state) followed by (B - a punctuated word state) ends a punctuated word:
	decide on whether or not A is transitioning after independent punctuation or A is not transitioning after whitespace and A is not B.

To decide whether (A - a punctuated word state) followed by no punctuated word state ends a punctuated word:
	decide on whether or not A is not transitioning after whitespace.

To decide whether (A - a punctuated word state) followed by (B - a punctuated word state) begins a punctuated word:
	decide on whether or not B is transitioning after independent punctuation or B is not transitioning after whitespace and B is not A.

Chapter "Word Counting"

To decide what number is the punctuated word count of the synthetic text (T - some text):
	let the result be zero;
	let the current state be transitioning after whitespace;
	repeat with the character code running through the character codes in the synthetic text T:
		let the previous state be the current state;
		now the current state is the punctuated word state that follows the character code;
		if the previous state followed by the current state begins a punctuated word:
			increment the result;
	decide on the result.

Chapter "Punctuated Word Arrays"

Section "The Punctuated Word Array Kind"

A punctuated word array is a kind of value.
A punctuated word array is an invalid punctuated word array.  [See the note in the book "Extension Information."]
The specification of a punctuated word array is "Punctuated word arrays represent a fixed number of immutable texts, numbered from zero on up.  They are using inside Punctuated Word Parsing Engine to represent the lexemes of input."

Section "The Punctuated Word Array Structure" - unindexed

[Layout:
	4 bytes for the number of words
	4 bytes per punctuated word]

To decide what number is the size in memory of a punctuated word array for (N - a number) punctuated words: (- (4+4*{N}) -).

Section "Punctuated Word Array Construction and Destruction"

To decide what punctuated word array is a new punctuated word array for the synthetic text (T - some text):
	let the word count be the punctuated word count of the synthetic text T;
	let the size be the size in memory of a punctuated word array for the word count punctuated words;
	let the result be a memory allocation of size bytes converted to a punctuated word array;
	write the word count the word count to the result;
	let the current address be the character array address of the synthetic text T;
	let the current state be transitioning after whitespace;
	let the word index be zero;
	let the last word address be a number;
	let the length be a number;
	let the character code be the byte at address current address;
	while the character code is not zero:
		let the previous state be the current state;
		now the current state is the punctuated word state that follows the character code;
		if the previous state followed by the current state ends a punctuated word:
			let the word be a new synthetic text extracted from the length bytes at address last word address;
			write the word to word word index of the result;
			increment the word index;
		if the previous state followed by the current state begins a punctuated word:
			now the last word address is the current address;
			now the length is zero;
		increment the current address;
		increment the length;
		now the character code is the byte at address current address;
	if the current state followed by no punctuated word state ends a punctuated word:
		let the word be a new synthetic text extracted from the length bytes at address last word address;
		write the word to word word index of the result;
		increment the word index;
	always check that the word index is the word count or else fail at building a punctuated word array from changing text;
	decide on the result.

To decide what punctuated word array is a new punctuated word array for the nonsynthetic text (T - some text):
	let the copy be a new synthetic text copied from T;
	let the result be a new punctuated word array for the synthetic text the copy;
	delete the synthetic text the copy;
	decide on the result.

To delete (A - a punctuated word array):
	repeat with the word running through A:
		delete the synthetic text the word;
	free the memory allocation at address A converted to a number.

Section "Private Punctuated Word Array Accessors and Mutators" - unindexed

To write the word count (N - a number) to (A - a punctuated word array): (- llo_setInt({A},{N}); -).

To write (X - some text) to word (I - a number) of (A - a punctuated word array): (- llo_setField({A},1+{I},{X}); -).

Section "Public Punctuated Word Array Accessors and Mutators"

To decide what number is the word count of (A - a punctuated word array): (- llo_getInt({A}) -).

To decide what text is word (I - a number) of (A - a punctuated word array): (- llo_getField({A},1+{I}) -).

Section "Iteration over Punctuated Word Arrays"

Include (-
	Global pwpe_iterator;
-).

To repeat with (I - a nonexisting text variable) running through (A - a punctuated word array) begin -- end: (-
	pwpe_iterator=0;
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull pwpe_iterator;
			if(llo_broken){
				break;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			pwpe_iterator++;
			if(pwpe_iterator>llo_getInt({A})){
				llo_broken=true;
				break;
			}
			@push pwpe_iterator;
			llo_advance=false;
			@aload {A} pwpe_iterator {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting text variable) running through (A - a punctuated word array) backwards begin -- end: (-
	pwpe_iterator=llo_getInt({A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull pwpe_iterator;
			if(llo_broken){
				break;
			}
			pwpe_iterator--;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(pwpe_iterator<=0){
				llo_broken=true;
				break;
			}
			@push pwpe_iterator;
			llo_advance=false;
			@aload {A} pwpe_iterator {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Book "Punctuated Word Parsing"

Chapter "The Punctuated Word Terminal Hash Table" - unindexed

[Maps terminal parsemes to the zero or more synthetic texts that they match, *in order*, not as alternatives.  For example the terminal that matches "xyzzy plugh" will be a key with values "xyzzy" and "plugh", where the former comes before the latter in iteration order.]
The punctuated word terminal hash table is a hash table that varies.

To ensure that the punctuated word terminal hash table is initialized:
	if the punctuated word terminal hash table is an invalid hash table:
		now the punctuated word terminal hash table is a new hash table with the punctuated word terminal hash table size buckets.

Chapter "Terminal Expansion" - unindexed

To parse for the punctuated word terminal (S - a parseme) beginning at lexeme index (I - a number) (this is parsing a punctuated word terminal):
	let the array content be the punctuated word array content of the owner of S;
	let the lexeme index be I;
	repeat with the lexeme running through the text values matching the key S in the punctuated word terminal hash table:
		if the lexeme index is at least the word count of the array content:
			stop;
		unless the synthetic text the lexeme is identical to the synthetic text word lexeme index of the array content:
			stop;
		increment the lexeme index;
	match S from lexeme index I to lexeme index the lexeme index.

To parse for the punctuated word terminal (S - a parseme) beginning at lexeme index (I - a number) ignoring case (this is parsing a punctuated word terminal ignoring case):
	let the array content be the punctuated word array content of the owner of S;
	let the lexeme index be I;
	repeat with the lexeme running through the text values matching the key S in the punctuated word terminal hash table:
		if the lexeme index is at least the word count of the array content:
			stop;
		let the downcased lexeme be a new synthetic text copied from word lexeme index of the array content;
		downcase the synthetic text the downcased lexeme;
		unless the synthetic text the lexeme is identical to the synthetic text the downcased lexeme:
			delete the synthetic text the downcased lexeme;
			stop;
		delete the synthetic text the downcased lexeme;
		increment the lexeme index;
	match S from lexeme index I to lexeme index the lexeme index.

Chapter "Understand Line Internals" - unindexed

The flag for building parsemes from understand text is a truth state that varies.  The flag for building parsemes from understand text is false.
The understand parseme linked list is a linked list that varies.

Definition: a parseme is understanding encoded if the flag for building parsemes from understand text is true.

To say (A - an understanding encoded parseme):
	say "[the parseme placeholder for understand lines]";
	push the key A onto the understand parseme linked list.

To decide what punctuated word array is (T - some text) with parsemes recorded for understanding:
	if the understand parseme linked list is an invalid linked list:
		now the understand parseme linked list is an empty linked list;
	always check that the understand parseme linked list is empty or else fail at understand line reentrancy;
	now the flag for building parsemes from understand text is true;
	let the signature be a new punctuated word array for the nonsynthetic text T;
	now the flag for building parsemes from understand text is false;
	decide on the signature.

To say (S - a parseme) as a punctuated word terminal:
	say "'";
	let the first time flag be true;
	repeat with the lexeme running through the text values matching the key S in the punctuated word terminal hash table:
		if the first time flag is true:
			now the first time flag is false;
		otherwise:
			say " ";
		say "[the lexeme]";
	say "'".

To name (S - a parseme) as a punctuated word terminal:
	let the length be one;
	repeat with the lexeme running through the text values matching the key S in the punctuated word terminal hash table:
		increment the length;
		increase the length by the length of the synthetic text the lexeme;
	let the result be a new uninitialized permanent synthetic text with length length characters;
	overwrite the synthetic text the result with the text printed when we say "[S as a punctuated word terminal]";
	write the human-friendly name the result to S.

To understand (T - some text) as a new production for (S - a parseme), ignoring case (this is understanding an understand text as a production):
	let the signature be T with parsemes recorded for understanding;
	let the production be a new production for S;
	ensure that the punctuated word terminal hash table is initialized;
	let the terminal be an invalid parseme;
	repeat with the word running through the signature backwards:
		if the synthetic text the word is identical to the parseme placeholder for understand lines:
			unless the terminal is an invalid parseme:
				name the terminal as a punctuated word terminal;
			now the terminal is an invalid parseme;
			let the nonterminal be a parseme key popped off of the understand parseme linked list;
			prepend the nonterminal to the production;
		otherwise:
			if the terminal is an invalid parseme:
				if ignoring case:
					now the terminal is a new terminal in the owner of S named "" and parsed by parsing a punctuated word terminal ignoring case;
				otherwise:
					now the terminal is a new terminal in the owner of S named "" and parsed by parsing a punctuated word terminal;
				prepend the terminal to the production;
			let the persistent word be a new permanent synthetic text copied from the word;
			if ignoring case:
				downcase the synthetic text the persistent word;
			insert the key the terminal and the value the persistent word into the punctuated word terminal hash table;
	unless the terminal is an invalid parseme:
		name the terminal as a punctuated word terminal;
	delete the signature;
	delete the understand parseme linked list;
	now the understand parseme linked list is an empty linked list.

To decide what parseme is the sole parseme in (T - some text) (this is deciding on a sole parseme):
	let the signature be T with parsemes recorded for understanding;
	always check that the word count of the signature is one or else fail at understanding as multiple tokens;
	let the word be word zero of the signature;
	always check that the synthetic text the word is identical to the parseme placeholder for understand lines or else fail at understanding as a single literal word;
	let the result be a parseme key popped off of the understand parseme linked list;
	delete the signature;
	delete the understand parseme linked list;
	now the understand parseme linked list is an empty linked list;
	decide on the result.

Book "Convenience Phrases"

Chapter "Punctuated Word Content"

Section "Content Accessor and Mutator for Punctuated Word Parsers"

To write the punctuated words of (T - some text) to (A - a context-free parser):
	let the words be a new punctuated word array for the nonsynthetic text T;
	write the content the words and the lexeme count the word count of the words to A.

To delete the punctuated words from (A - a context-free parser):
	delete the punctuated word array content of A.

Section "Private Globals for Text Extraction" - unindexed

The matched punctuated words accumulator is some text that varies.
The matched punctuated words accumulator's lexeme index is a number that varies.
The matched punctuated words accumulator's punctuated word array is a punctuated word array that varies.

Section "Text Extraction"

[Only works if the parser's content hasn't changed.]
To decide what text is a new synthetic text representing the words matched by (V - a parse tree vertex):
	let the beginning lexeme index be the beginning lexeme index of V;
	let the end lexeme index be the end lexeme index of V;
	now the matched punctuated words accumulator's punctuated word array is the punctuated word array content of the owner of V;
	if the end lexeme index is at most the beginning lexeme index:
		decide on a new synthetic text copied from "";
	repeat with the lexeme index running over the half-open interval from the beginning lexeme index to the end lexeme index:
		now the matched punctuated words accumulator's lexeme index is the lexeme index;
		if the lexeme index is the beginning lexeme index:
			now the matched punctuated words accumulator is a new synthetic text copied from "[word the matched punctuated words accumulator's lexeme index of the matched punctuated words accumulator's punctuated word array]";
		otherwise:
			let the accumulator replacement be a new synthetic text copied from "[the matched punctuated words accumulator] [word the matched punctuated words accumulator's lexeme index of the matched punctuated words accumulator's punctuated word array]";
			delete the synthetic text the matched punctuated words accumulator;
			now the matched punctuated words accumulator is the accumulator replacement;
	decide on the matched punctuated words accumulator.

Chapter "Identifying Punctuated Word Terminals"

Definition: a parseme (called S) is a punctuated word terminal:
	let the parsing phrase be the parsing phrase of S;
	decide on whether or not the parsing phrase is parsing a punctuated word terminal or the parsing phrase is parsing a punctuated word terminal ignoring case.

Chapter "Saying and Debugging Parse Tree Vertices"

Section "Recursive Phrase for Saying and Debugging Parse Tree Vertices" - unindexed

Line break needed for saying an indented parse tree vertex is a truth state that varies.

To say (A - a parse tree vertex) with indentation (I - a number):
	let the beginning lexeme index be the beginning lexeme index of A;
	let the end lexeme index be the end lexeme index of A;
	let the length be the end lexeme index minus the beginning lexeme index;
	if the length is less than zero:
		now the length is zero;
	if line break needed for saying an indented parse tree vertex is true:
		say "[line break]";
	repeat with a counter running from one to I:
		say "    ";
	let the match be a new synthetic text representing the words matched by A;
	say "[the human-friendly name of the parseme of A] : '[the match]'";
	now line break needed for saying an indented parse tree vertex is true;
	repeat with the child running through the children of A:
		say the child with indentation I plus one.

Section "Public Phrase for Saying and Debugging Parse Tree Vertices"

To say (A - a parse tree vertex) with indentation:
	now line break needed for saying an indented parse tree vertex is false;
	say A with indentation zero.

Chapter "Understanding Multiple Productions"

Section "Hidden Machinery for Understanding Multiple Productions" - unindexed

Include (-
	Global pwpe_parsemeUnderConstruction;
-) after "Definitions.i6t".

A list of understand texts becoming productions for a parseme is a kind of value.
The plural of list of understand texts becoming productions for a parseme is lists of understand texts becoming productions for a parseme.
The specification of a list of understand texts becoming productions for a parseme is "Long-windedly named, a list of understand texts becoming productions for a parseme is not actually used as a kind of value at all, but merely to represent a partial understanding line for Punctuated Word Parsing Engine."

A list of understand texts becoming case-insensitive productions for a parseme is a kind of value.
The plural of list of understand texts becoming case-insensitive productions for a parseme is lists of understand texts becoming case-insensitive productions for a parseme.
The specification of a list of understand texts becoming case-insensitive productions for a parseme is "Long-windedly named, a list of understand texts becoming case-insensitive productions for a parseme is not actually used as a kind of value at all, but merely to represent a partial understanding line for Punctuated Word Parsing Engine."

Section "Understanding Multiple Productions"

To understand (X - a list of understand texts becoming productions for a parseme): (- pwpe_parsemeUnderConstruction=({X}); -).
To decide what list of understand texts becoming productions for a parseme is (T - some text) or (L - a list of understand texts becoming productions for a parseme): (- {L},(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction) -).
To decide what list of understand texts becoming productions for a parseme is (T - some text) and (L - a list of understand texts becoming productions for a parseme): (- {L},(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction) -).
To decide what list of understand texts becoming productions for a parseme is (T - some text) as (S - a parseme): (- pwpe_parsemeUnderConstruction={S},(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction) -).
To decide what list of understand texts becoming productions for a parseme is (T - some text) as (U - some text): (- pwpe_parsemeUnderConstruction=(llo_getField((+ deciding on a sole parseme +),1))({U}),(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction) -).

To understand (X - a list of understand texts becoming case-insensitive productions for a parseme): (- pwpe_parsemeUnderConstruction=({X}); -).
To decide what list of understand texts becoming case-insensitive productions for a parseme is (T - some text) or (L - a list of understand texts becoming case-insensitive productions for a parseme): (- {L},(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction,1) -).
To decide what list of understand texts becoming case-insensitive productions for a parseme is (T - some text) and (L - a list of understand texts becoming case-insensitive productions for a parseme): (- {L},(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction,1) -).
To decide what list of understand texts becoming case-insensitive productions for a parseme is (T - some text) as (S - a parseme) regardless of case: (- pwpe_parsemeUnderConstruction={S},(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction,1) -).
To decide what list of understand texts becoming productions for a parseme is (T - some text) as (U - some text) regardless of case: (- pwpe_parsemeUnderConstruction=(llo_getField((+ deciding on a sole parseme +),1))({U}),(llo_getField((+ understanding an understand text as a production +),1))({T},pwpe_parsemeUnderConstruction,1) -).

Punctuated Word Parsing Engine ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Punctuated Word Parsing Engine specializes Context Free Parsing Engine for the
case where we want to parse punctuated words.  Mimicking Inform's syntax, the
extension allows us to write lines like

	understand "tell [an NPC] to [an imperative command]" as "[an imperative command]";

and then loop over parses that honor that grammar:

	write the punctuated words of "tell Jemison to tell Watson to kill Zoe" to the example parser;
	repeat with the parse running through matches for an imperative command:
		....

Details are in the following chapters.

Chapter: Basic Usage

Section: Background

Authors using this extension should be familiar with the documentation for
Context-Free Parsing Engine, although you the sections titled "Creating
productions" and "Loading input" are irrelevant because Punctuated Word Parsing
Engine introduces specialized syntax for both of these tasks.  Authors can also
ignore the section "Terminals' parsing phrases" for this chapter on basic usage.

Section: Creating productions (and terminals)

Productions for a punctuated word grammar are implicitly created by understand
lines, which have the form

	understand (TA - some text) and/or (TB - some text) and/or ... and/or (TZ - some text) as (S - a parseme)

where each text could contain other parsemes in brackets.  For instance,

	When play begins:
		understand "" or "the" as the/--;
		understand "Zoe" or "[the/--] enemy" as Zoe's name.

generates four new productions, just as one might expect.  Note that terminals
for matching literal words like "the" or "Zoe" or "enemy" are created
automatically.

It is also possible to include quotes and brackets after "as" to more closely
mimic Inform's understanding syntax:

	When play begins:
		understand "" or "the" as "[the/--]";
		understand "Zoe" or "[the/--] enemy" as "[Zoe's name]".

By default, the automatically generated terminals are case-sensitive, so "the
enemy" will be matched, but not "The Enemy".  To get case-insensitive terminals,
we add the words "regardless of case" to the end of the phrase:

	When play begins:
		understand "" or "the" as "[the/--]" regardless of case;
		understand "Zoe" or "[the/--] enemy" as "[Zoe's name]" regardless of case.

Both terminals can be later identified with the test

	if (S - a parseme) is a punctuated word terminal:
		....

Section: Loading input

The phrase

	write the punctuated words of (T - some text) to (A - a context-free parser)

gives a parser the input text T, while the phrase

	delete the punctuated words from (A - a context-free parser)

removes such an input.  We are responsible for alternating their use; if we
write punctuated words to a parser that already has input, the story will
irretrievably lose memory, and if we delete an input twice, we may crash the
story, possibly after some delay and in seemingly unrelated code.

Section: Extracting words matched by a parseme and debugging parses

In addition to the usual phrases for manipulating parse tree vertices, the phrase

	a new synthetic text representing the words matched by (V - a parse tree vertex)

will produce text snipped from the original input in the range matched by V.
Note that spacing will be normalized to one space between each punctuated word,
and, as with other synthetic texts, we are responsible for deleting the result
when we are done with it.  The phrase to use comes from Low-Level Text:

	delete the synthetic text (T - some text)

Another new phrase,

	say (V - a parse tree vertex) with indentation

prints V and all of its children in outline format, showing the parseme and
matched text for each.  For instance, "kill zoe" might be matched and printed as

	an imperative command : "kill zoe"
	"kill" : "kill"
	an NPC : "zoe"
		Zoe's name : "zoe"
			"zoe" : "zoe"

Both of these phrases depend on the parser still having access to the original
input.  We cannot safely apply them to parse tree vertices saved past the
input's lifetime.

Chapter: Advanced Usage

Section: Punctuated word arrays

Punctuated Word Parsing Engine manipulates text as a bundle of lexemes; the kind
is called

	a punctuated word array

and has the default value

	an invalid punctuated word array

which should never be passed to any of the phrases documented here.

In most cases we obtain valid punctuated word arrays by accessing the contents
of an initialized context-free parser, but we can also create valid arrays with
the phrase

	a new punctuated word array for the synthetic text (T - some text)

or the phrase

	a new punctuated word array for the nonsynthetic text (T - some text)

where the former is faster, but safe only when T is synthetic text, whereas the
latter will work in either case.  The results should be deleted when they are no
longer needed; we do so by writing

	delete (A - a punctuated word array)

Section: Inspecting punctuated word arrays

Punctuated word arrays know the number of words that they contain, available via

	the word count of (A - a punctuated word array)

as well as each of these words, accessed as synthetic text through

	word (I - a number) of (A - a punctuated word array)

where, importantly, the lexeme index I counts from zero.  This last phrase is
the one that most custom terminal parsing phrases are interested in.

In other situations, where we might want to iterate over all words in an array,
we have

	repeat with (I - a nonexisting text variable) running through (A - a punctuated word array):
		....

and its variation

	repeat with (I - a nonexisting text variable) running through (A - a punctuated word array) backwards:
		....

Section: Miscellaneous

The phrase

	the punctuated word count of the synthetic text (T - some text)

is also available.  It is a faster version of

	let the temporary punctuated word array be a new punctuated word array for the nonsynthetic text T;
	let the word count be the word count of the temporary punctuated word array;
	delete the temporary punctuated word array;

Example: * Parsing Testbed - Testing a grammar for the running example, "tell Jemison to tell Watson to kill Zoe"

Suppose that we have a grammar,

	...
	understand "Jemison" as Jemison's name regardless of case;
	understand "Watson" as Watson's name regardless of case;
	understand "Zoe" as Zoe's name regardless of case;
	understand "[Jemison's name]" or "[Watson's name]" or "[Zoe's name]" as an NPC;
	understand "kill [an NPC]" as an imperative command regardless of case;
	understand "tell [an NPC] to [an imperative command]" as an imperative command regardless of case;
	...

and some inputs that we'd like to test it with.  We can simplify this process by
routing the player's command to a testbed parser rather than the one built into
Inform, and then looping over all possible parses, printing them out:

	After reading a command:
		let the synthetic command be a new synthetic text copied from "[the player's command]";
		write the punctuated words of the synthetic command to the testbed parser;
		repeat with the parse running through matches for an imperative command:
			say "[the parse with indentation].";
		delete the punctuated words from the testbed parser;
		delete the synthetic text the synthetic command;
		reject the player's command.

After adding declarations of the parser and the parsemes, code to create them,
code to put the grammar in normal form, and a room, we have the following
"story":

	*: "Parsing Testbed" by Brady Garvin
	
	Use no deprecated features.
	Include Punctuated Word Parsing Engine by Brady Garvin.
	
	Testbed is a room.
	
	The testbed parser is a context-free parser that varies.
	
	Jemison's name and Watson's name and Zoe's name and an NPC and a command to kill and an imperative command are parsemes that vary.
	
	When play begins:
		now the testbed parser is a new context-free parser;
		now Jemison's name is a new nonterminal in the testbed parser named "Jemison's name";
		now Watson's name is a new nonterminal in the testbed parser named "Watson's name";
		now Zoe's name is a new nonterminal in the testbed parser named "Zoe's name";
		now an NPC is a new nonterminal in the testbed parser named "an NPC";
		now a command to kill is a new nonterminal in the testbed parser named "a command to kill";
		now an imperative command is a new nonterminal in the testbed parser named "an imperative command";
		understand "Jemison" as Jemison's name regardless of case;
		understand "Watson" as Watson's name regardless of case;
		understand "Zoe" as Zoe's name regardless of case;
		understand "[Jemison's name]" or "[Watson's name]" or "[Zoe's name]" as an NPC;
		understand "kill [an NPC]" as an imperative command regardless of case;
		understand "tell [an NPC] to [an imperative command]" as an imperative command regardless of case;
		put the testbed parser into normal form.
	
	After reading a command:
		let the synthetic command be a new synthetic text copied from "[the player's command]";
		write the punctuated words of the synthetic command to the testbed parser;
		repeat with the parse running through matches for an imperative command:
			say "[the parse with indentation].";
		delete the punctuated words from the testbed parser;
		delete the synthetic text the synthetic command;
		reject the player's command.

Given the input

	tell Jemison to tell Watson to kill Zoe

it outputs the parse tree

	an imperative command : "tell Jemison to tell Watson to kill Zoe"
		"tell" : "tell"
		an NPC : "Jemison"
			Jemison's name : "Jemison"
				"jemison" : "Jemison"
		"to" : "to"
		an imperative command : "tell Watson to kill Zoe"
			"tell" : "tell"
			an NPC : "Watson"
				Watson's name : "Watson"
					"watson" : "Watson"
			"to" : "to"
			an imperative command : "kill Zoe"
				"kill" : "kill"
				an NPC : "Zoe"
					Zoe's name : "Zoe"
						"zoe" : "Zoe"

which mirrors the outline from Context-Free Parsing Engine's documentation:

	1. "[an imperative command]"
	1.a. "tell"
	1.b. "[an NPC]"
	1.b.1. "Jemison"
	1.c. "to"
	1.d. "[an imperative command]"
	1.d.1. "tell"
	1.d.2. "[an NPC]"
	1.d.2.a. "Watson"
	1.d.3. "to"
	1.d.4. "[an imperative command]"
	1.d.4.a. "kill"
	1.d.4.b. "[an NPC]"
	1.d.4.b.1. "Zoe"

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

Punctuated Word Parsing Engine was prepared as part of the Glulx Runtime
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

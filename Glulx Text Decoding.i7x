Version 2 of Glulx Text Decoding (for Glulx only) by Brady Garvin begins here.

"Low-level phrases for looping over the components of substitution-free text, either characters or decoding vertices."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Glulx Text Decoding you will see a sentence like

	A decoding vertex is an invalid decoding vertex.

This bewildering statement actually sets up decoding vertices as a qualitative value with default value the decoding vertex at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on decoding vertices.]

Book "Text Decoding"

Chapter "Printable and Unprintable Characters"

Definition: a Unicode character is printable rather than unprintable if I6 condition "(glk_gestalt_ext(gestalt_CharOutput, *1, 0, 1) ~= gestalt_CharOutput_CannotPrint)" says so (it passes the Glk printability gestalt test).

Chapter "Subkinds of Text"

To decide whether (T - some text) could contain null-terminated Latin-1 (this is triaging for null-terminated Latin-1):
	if T converted to a number is an invalid byte address:
		decide no;
	decide on whether or not the byte at address T converted to a number is 224.

To decide whether (T - some text) could contain compressed text (this is triaging for compressed text):
	if T converted to a number is an invalid byte address:
		decide no;
	decide on whether or not the byte at address T converted to a number is 225.

To decide whether (T - some text) could contain null-terminated Unicode (this is triaging for null-terminated Unicode):
	if T converted to a number is an invalid byte address:
		decide no;
	decide on whether or not the byte at address T converted to a number is 226.

To decide whether (T - some text) could contain [@] substitution-free text (this is triaging for [@] substitution-free text):
	decide on whether or not address T converted to a number could contain a string.

Chapter "Decoding Vertices"

Section "The Decoding Vertex Kind"

A decoding vertex is a kind of value.  The plural of decoding vertex is decoding vertices.
A decoding vertex is an invalid decoding vertex.  [See the note in the book "Extension Information."]
The specification of a decoding vertex is "Decoding vertices describe the meaning of compressed text's bits; they are defined by the Glulx specification for compressed text."

Section "The Decoding Vertex Structure" - unindexed

[Layout:
	1 byte for the vertex type
	N bytes for the payload]

Section "Private Decoding Vertex Accessors" - unindexed

To decide what number is the decoding vertex type of (A - a decoding vertex): (- llo_getByte({A}) -).

To decide what Unicode character is the Latin-1 character of (A - a decoding vertex): (- llo_getByte({A} + 1) -).
To decide what Unicode character is the Unicode character of (A - a decoding vertex): (- llo_getInt({A} + 1) -).

[It's especially important that this next phrase be private because even if it's called on a decoding vertex where it makes sense, the text it returns will have a wrong indicator byte and therefore not work with phrases that check the indicator.]
To decide what text is the text of (A - a decoding vertex): (- {A} -).

Section "Public Decoding Vertex Accessors"

To decide whether (A - a decoding vertex) is of unknown type: (- (llo_unsignedGreaterThan(llo_getByte({A}), 11) || (llo_getByte({A}) == 6) || (llo_getByte({A}) == 7)) -).

[Decides on zero for invalid decoding vertices and indirect references (I6 printing variables).]
To decide what number is the character length of (A - a decoding vertex) (this is measuring a decoding vertex):
	if the decoding vertex type of A is:
		-- 2: [Latin-1 character]
			decide on one;
		-- 3: [null-terminated Latin-1]
			decide on the character length of the Latin-1 the text of A;
		-- 4: [Unicode character]
			decide on one;
		-- 5: [null-terminated Unicode]
			decide on the character length of the Unicode the text of A;
	if A is of unknown type:
		decide on -1;
	decide on zero.

Section "Decoding Vertex Say Phrases"

To say (A - a decoding vertex) (this is saying a decoding vertex):
	if the decoding vertex type of A is:
		-- 2: [Latin-1 character]
			say "[the Latin-1 character of A]";
		-- 3: [null-terminated Latin-1]
			repeat with the character running with paranoia through the Latin-1 the text of A:
				say "[if the character is printable][the character][otherwise]?[end if]";
		-- 4: [Unicode character]
			say "[the Unicode character of A]";
		-- 5: [null-terminated Unicode]
			repeat with the character running with paranoia through the Unicode the text of A:
				say "[if the character is printable][the character][otherwise]?[end if]";
		-- 8: [indirect reference]
			say "<I6 printing variable>";
		-- 9: [double indirect reference]
			say "<I6 printing variable>";
		-- 10: [indirect reference with arguments]
			say "<I6 printing variable>";
		-- 11: [double indirect reference with arguments]
			say "<I6 printing variable>".

Chapter "Repetition through Text"

Section "Repetition through Latin-1"

Include (-
	Global gtd_iterator;
	Global gtd_bits;
	Global gtd_offset;
-) after "Definitions.i6t".

To repeat with (I - a nonexisting Unicode character variable) running with paranoia through the Latin-1 (A - some text) begin -- end: (-
	gtd_iterator = {A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull gtd_iterator;
			if (llo_broken) {
				break;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			gtd_iterator++;
			if (~~llo_validByteAddress(gtd_iterator)) {
				llo_broken = true;
				break;
			}
			@aloadb gtd_iterator 0 {I};
			if (~~{I}) {
				llo_broken = true;
				break;
			}
			@push gtd_iterator;
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Section "Repetition through Unicode"

To repeat with (I - a nonexisting Unicode character variable) running with paranoia through the Unicode (A - some text) begin -- end: (-
	gtd_iterator = {A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull gtd_iterator;
			if (llo_broken) {
				break;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			gtd_iterator = gtd_iterator + 4;
			if (~~llo_validIntAddress(gtd_iterator)) {
				llo_broken = true;
				break;
			}
			@aload gtd_iterator 0 {I};
			if (~~{I}) {
				llo_broken = true;
				break;
			}
			@push gtd_iterator;
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Section "Repetition through Compressed Text"

Include (-
	[ gtd_getRootDecodingVertex result;
		@getstringtbl result;
		return llo_getInt(result + 8);
	];
-).

To repeat with (I - a nonexisting decoding vertex variable) running with paranoia through the compressed (T - some text) begin -- end: (-
	{I} = gtd_getRootDecodingVertex();
	@push {I};
	gtd_iterator = {T} + 1;
	@aloadb gtd_iterator 0 gtd_bits;
	gtd_bits = $10000 + gtd_bits;
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull gtd_bits;
			@pull gtd_iterator;
			if (llo_broken) {
				@pull {I};
				break;
			}
			if (llo_getByte({I})) {
				@stkpeek 0 {I};
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			llo_broken = true;
			if (gtd_bits & $100) {
				gtd_iterator++;
				if (~~llo_validByteAddress(gtd_iterator)) {
					@pull {I};
					break;
				}
				@aloadb gtd_iterator 0 gtd_bits;
				gtd_bits = $10000 + gtd_bits;	
			}
			{I}++;
			gtd_offset = gtd_bits & 1;
			@aload {I} gtd_offset {I};
			if (llo_getByte({I}) == 1) {
				@pull {I};
				break;
			}
			@push gtd_iterator;
			@ushiftr gtd_bits 1 sp;
			llo_broken = false;
			llo_advance = ~~llo_getByte({I});
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Chapter "Length of Text"

Section "Length of Latin-1"

To decide what number is the character length of the Latin-1 (T - some text) (this is measuring Latin-1 text):
	let the text address be T converted to a number plus one;
	if the text address is an invalid byte address:
		decide on -1;
	let the search extent be the size of memory minus the text address;
	decide on the index of the byte zero in the search extent bytes at address the text address.

Section "Length of Unicode"

To decide what number is the character length of the Unicode (T - some text) (this is measuring Unicode text):
	let the text address be T converted to a number plus one;
	if the text address is an invalid integer address:
		decide on -1;
	let the search extent be the size of memory minus the text address;
	decide on the index of the integer zero in the search extent integers at address the text address.

Section "Length of Compressed Text"

To decide what number is the character length of the compressed (T - some text) (this is measuring compressed text):
	let the result be zero;
	repeat with the decoding vertex running with paranoia through the compressed T:
		let the addition be the character length of the decoding vertex;
		if the addition is -1:
			decide on -1;
		increase the result by the addition;
	decide on the result.

Section "Length of [@] Substitution-Free Text"

To decide what number is the character length of the [@] substitution-free (T - some text) (this is measuring [@] substitution-free text):
	let the address be T converted to a number;
	if the address is zero or the address is an invalid byte address:
		decide on -1;
	let the indicator be the byte at address address;
	if the indicator is:
		-- 224: [null-terminated Latin-1]
			decide on the character length of the Latin-1 T;
		-- 225: [compressed]
			decide on the character length of the compressed T;
		-- 226: [null-terminated Unicode]
			decide on the character length of the Unicode T;
		-- otherwise: [unknown]
			decide on -1.

Chapter "Validity of Text"

Section "Validity of Latin-1"

To decide whether (T - some text) is valid Latin-1 (this is validating Latin-1 text):
	decide on whether or not the character length of the Latin-1 T is at least zero.

Section "Validity of Unicode"

To decide whether (T - some text) is valid Unicode (this is validating Unicode text):
	decide on whether or not the character length of the Unicode T is at least zero.

Section "Validity of Compressed Text"

To decide whether (T - some text) is valid compressed text (this is validating compressed text):
	decide on whether or not the character length of the compressed T is at least zero.

Section "Validity of [@] Substitution-Free Text"

To decide whether (T - some text) is valid [@] substitution-free text (this is validating [@] substitution-free text):
	decide on whether or not the character length of the [@] substitution-free T is at least zero.

Glulx Text Decoding ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Glulx Text Decoding is a low-level extension for measuring and inspecting [@]
substitution-free text without printing it or otherwise assuming that it is
valid.  It is rarely useful except in extensions to support debugging tools.

Details are in the following chapters.

Chapter: Usage

Glulx has three encodings for text, and Inform adds [@] one more for text with
substitutions.  Glulx Text Decoding lets us classify texts by encoding and
inspect the contents of texts in the first three encodings.

Section: Classifying substitution-free text

We can check whether a given text value could be [@] substitution-free via the
test

	if (T - some text) could contain [@] substitution-free text:
		....

Or, if we are looking for a specific kind of [@] substitution-free text, we can
ask

	if (T - some text) could contain null-terminated Latin-1:
		....

	if (T - some text) could contain null-terminated Unicode:
		....

or

	if (T - some text) could contain compressed text:
		....

These tests are designed to be fast but not thorough; they will classify a text
but they will not check its validity.  For that, we have the conditional

	if (T - some text) is valid [@] substitution-free text:
		....

Or, if we already know that T is a particular kind of text, we could ask

	if (T - some text) is valid Latin-1:
		....

	if (T - some text) is valid Unicode:
		....

or

	if (T - some text) is valid compressed text:
		....

Note that these last three do not verify that T is the kind of text claimed, and
if it is the wrong kind, there is no guarantee that the validity test will not
pass by chance.

Section: Measuring [@] substitution-free text

Given a text, we can count the number of characters in it via

	the character length of the [@] substitution-free (T - some text)

Length measurements automatically entail a validity check, and if T [@] has
substitutions or is invalid, this phrase will decide on -1.  If we are
interested both in checking validity and measuring length, it will be faster to
request the length and see if -1 is returned than to use the validity-checking
phrase and then repeat the test in the measurement.

Variations are also available for specific kinds of text:

	the character length of the Latin-1 (T - some text)

	the character length of the Unicode (T - some text)

and

	the character length of the compressed (T - some text)

Unlike the general phrase, these phrases blindly assume that T is of the
specified type; the result may be anything if we do not ensure that T is.

Section: Looping over [@] substitution-free text

For uncompressed text, we can loop over the constituent characters with

	repeat with (I - a nonexisting Unicode character variable) running with paranoia through the Latin-1 (A - some text):
		....

or

	repeat with (I - a nonexisting Unicode character variable) running with paranoia through the Unicode (A - some text):
		....

as appropriate.

For compressed text, we instead loop over the leaf decoding vertices that describe its contents:

	repeat with (I - a nonexisting decoding vertex variable) running with paranoia through the compressed (T - some text):
		....

Not much can be done with a decoding vertex.  We can measure its length by
writing

	the character length of (A - a decoding vertex)

or we can say it, using

	say (A - a decoding vertex)

Although I6 printing variables are not supported (see the section on
requirements and limitations), a small concession is made here in that printing
variables' decoding vertices will print as

	"<I6 printing variable>"

Section: Testing characters for printability

Glulx Text Decoding incidentally defines two adjectives that apply to Unicode
characters, which may be useful in other situations:

	printable

and

	unprintable

The former applies if the interpreter is able to print the character exactly or
approximately, the latter if the interpreter cannot print it at all.  Most
interpreters will show a question mark if we do try to display an unprintable
character.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It may not function under other
versions.

The Glulx specification allows the string decoding table to contain calls to
Glulx functions (see Section 1.6.1.4).  The validity of these calls will not
checked, nor will their output be counted in length measurements.  As best I can
tell, this limitation only affects authors who store routine addresses in I6
printing variables, and code of this sort will break on the Z-machine, so it's
not a good idea anyway.

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

Glulx Text Decoding was prepared as part of the Glulx Runtime Instrumentation
Project (https://github.com/i7/i7grip).

GRIP owes a great deal to everyone who made Inform possible and everyone who
continues to contribute.  I'd like to give especial thanks to Graham Nelson and
Emily Short, not only for their design and coding work, but also for all of the
documentation, both of the language and its internals---it proved indispensable.

I am likewise indebted to everybody who worked to make Glulx and Glk a reality.
Without them, there simply wouldn't have been any hope for this kind of project.
My special thanks to Andrew Plotkin, with further kudos for his work maintaining
the specifications.  They proved as essential as Inform's documentation.

The project itself was inspired by suggestions from Ron Newcomb and Esteban
Montecristo on Inform's feature request page.  It's only because of their posts
that I ever started.  (And here's hoping that late is better than never.)

Esteban Montecristo also made invaluable contributions as an alpha tester.  I
cannot thank him enough: he signed on as a beta tester but then quickly
uncovered a slew of problems that forced me to reconsider both the term ``beta''
and my timeline.  The impetus for the new, cleaner design and several clues that
led to huge performance improvements are all due to him.  Moreover, he
contributed code, since modified to fit the revised framework, for the extension
Verbose Diagnostics.

As for Ron Newcomb, I can credit him for nearly half of the bugs unearthed in
the beta proper, not to mention sound advice on the organization of the
documentation and the extensions.  GRIP is much sturdier as a result.

Roger Carbol, Jesse McGrew, Michael Martin, Dan Shiovitz, Johnny Rivera, and
probably several others deserve similar thanks for answering questions on
ifMUD's I6 and I7 channels.  I am grateful to Andrew Plotkin, David Kinder, and
others for the same sort of help on intfiction.org.

On top of that, David Kinder was kind enough to accommodate Debug File Parsing
in the Windows IDE; consequently, authors who have a sufficiently recent version
of Windows no longer need to write batch scripts.  His help is much appreciated,
particularly because the majority of downloaders are running Windows.

Even with the IDEs creating debug files, setting up symbolic links to those
files can be a chore.  Jim Aiken suggested an automated solution, which now
ships with the project.

And preliminary support for authors who want to debug inside a browser stems
from discussion with Erik Temple and Andrew Plotkin; my thanks for their ideas.

Finally, I should take this opportunity to express my gratitude to everyone who
helped me get involved in the IF community.  Notable among these people are
Jesse McGrew and Emily Short, not to mention Jacqueline Lott, David Welbourn,
and all of the other Club Floyd attendees.

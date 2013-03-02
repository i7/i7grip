Version 1 of Glulx Text Decoding (for Glulx only) by Brady Garvin begins here.

"Low-level phrases for looping over the components of substitution-free text, either characters or decoding vertices."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[For each of the kinds defined by Glulx Text Decoding you will see a sentence like

	A decoding vertex is an invalid decoding vertex.

This bewildering statement actually sets up decoding vertices as a qualitative value with default value the decoding vertex at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on decoding vertices.]

Book "Text Decoding"

Chapter "Printable and Unprintable Characters"

Definition: a Unicode character is printable rather than unprintable if I6 condition "(glk_gestalt_ext(gestalt_CharOutput,*1,0,1)~=gestalt_CharOutput_CannotPrint)" says so (it passes the Glk printability gestalt test).

Chapter "Subkinds of Text"

To decide whether (T - some text) could contain null-terminated Latin-1:
	if T converted to a number is an invalid byte address:
		decide no;
	decide on whether or not the byte at address T converted to a number is 224.

To decide whether (T - some text) could contain compressed text:
	if T converted to a number is an invalid byte address:
		decide no;
	decide on whether or not the byte at address T converted to a number is 225.

To decide whether (T - some text) could contain null-terminated Unicode:
	if T converted to a number is an invalid byte address:
		decide no;
	decide on whether or not the byte at address T converted to a number is 226.

To decide whether (T - some text) could contain substitution-free text:
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

To decide what Unicode character is the Latin-1 character of (A - a decoding vertex): (- llo_getByte({A}+1) -).
To decide what Unicode character is the Unicode character of (A - a decoding vertex): (- llo_getInt({A}+1) -).

[It's especially important that this next phrase be private because even if it's called on a decoding vertex where it makes sense, the text it returns will have a wrong indicator byte and therefore not work with phrases that check the indicator.]
To decide what text is the text of (A - a decoding vertex): (- {A} -).

Section "Public Decoding Vertex Accessors"

To decide whether (A - a decoding vertex) is of unknown type: (- (llo_unsignedGreaterThan(llo_getByte({A}),11)||(llo_getByte({A})==6)||(llo_getByte({A})==7)) -).

[Decides on zero for invalid decoding vertex and indirect references (I6 printing variables).]
To decide what number is the character length of (A - a decoding vertex):
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

To say (A - a decoding vertex):
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
	Global k_iterator;
	Global k_branchBits;
	Global k_branchOffset;
-) after "Definitions.i6t".

To repeat with (I - a nonexisting Unicode character variable) running with paranoia through the Latin-1 (A - some text) begin -- end: (-
	k_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull k_iterator;
			if(llo_broken){
				break;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			k_iterator++;
			if(~~llo_validByteAddress(k_iterator)){
				llo_broken=true;
				break;
			}
			@aloadb k_iterator 0 {I};
			if(~~{I}){
				llo_broken=true;
				break;
			}
			@push k_iterator;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Section "Repetition through Unicode"

To repeat with (I - a nonexisting Unicode character variable) running with paranoia through the Unicode (A - some text) begin -- end: (-
	k_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull k_iterator;
			if(llo_broken){
				break;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			k_iterator=k_iterator+4;
			if(~~llo_validIntAddress(k_iterator)){
				llo_broken=true;
				break;
			}
			@aload k_iterator 0 {I};
			if(~~{I}){
				llo_broken=true;
				break;
			}
			@push k_iterator;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Section "Repetition through Compressed Text"

Include (-
	[ k_getRootDecodingVertex result;
		@getstringtbl result;
		return llo_getInt(result+8);
	];
-).

To repeat with (I - a nonexisting decoding vertex variable) running with paranoia through the compressed (T - some text) begin -- end: (-
	{I}=k_getRootDecodingVertex();
	@push {I};
	k_iterator={T}+1;
	@aloadb k_iterator 0 k_branchBits;
	k_branchBits=$10000+k_branchBits;
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull k_branchBits;
			@pull k_iterator;
			if(llo_broken){
				@pull {I};
				break;
			}
			if(llo_getByte({I})){
				@stkpeek 0 {I};
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			llo_broken=true;
			if(k_branchBits&$100){
				k_iterator++;
				if(~~llo_validByteAddress(k_iterator)){
					@pull {I};
					break;
				}
				@aloadb k_iterator 0 k_branchBits;
				k_branchBits=$10000+k_branchBits;	
			}
			{I}++;
			k_branchOffset=k_branchBits&1;
			@aload {I} k_branchOffset {I};
			if(llo_getByte({I})==1){
				@pull {I};
				break;
			}
			@push k_iterator;
			@ushiftr k_branchBits 1 sp;
			llo_broken=false;
			llo_advance=~~llo_getByte({I});
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Chapter "Length of Text"

Section "Length of Latin-1"

To decide what number is the character length of the Latin-1 (T - some text):
	let the text address be T converted to a number plus one;
	if the text address is an invalid byte address:
		decide on -1;
	let the search extent be the size of memory minus the text address;
	decide on the index of the byte zero in the search extent bytes at address the text address.

Section "Length of Unicode"

To decide what number is the character length of the Unicode (T - some text):
	let the text address be T converted to a number plus one;
	if the text address is an invalid integer address:
		decide on -1;
	let the search extent be the size of memory minus the text address;
	decide on the index of the integer zero in the search extent integers at address the text address.

Section "Length of Compressed Text"

To decide what number is the character length of the compressed (T - some text):
	let the result be zero;
	repeat with the decoding vertex running with paranoia through the compressed T:
		let the addition be the character length of the decoding vertex;
		if the addition is -1:
			decide on -1;
		increase the result by the addition;
	decide on the result.

Section "Length of Substitution-Free Text"

To decide what number is the character length of the substitution-free (T - some text):
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

To decide whether (T - some text) is valid Latin-1:
	decide on whether or not the character length of the Latin-1 T is at least zero.

Section "Validity of Unicode"

To decide whether (T - some text) is valid Unicode:
	decide on whether or not the character length of the Unicode T is at least zero.

Section "Validity of Compressed Text"

To decide whether (T - some text) is valid compressed text:
	decide on whether or not the character length of the compressed T is at least zero.

Section "Validity of Substitution-Free Text"

To decide whether (T - some text) is valid substitution-free text:
	decide on whether or not the character length of the substitution-free T is at least zero.

Glulx Text Decoding ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Glulx Text Decoding is a low-level extension for measuring and inspecting
substitution-free text without printing it or otherwise assuming that it is
valid.  It is rarely useful except in extensions to support debugging tools.

Details are in the following chapters.

Chapter: Usage

Glulx has three encodings for text, and Inform adds one more for text with
substitutions.  Glulx Text Decoding lets us classify texts by encoding and
inspect the contents of texts in the first three encodings.

Section: Classifying substitution-free text

We can check whether a given text value could be substitution-free via the test

	if (T - some text) could contain substitution-free text:
		....

Or, if we are looking for a specific kind of substitution-free text, we can ask

	if (T - some text) could contain null-terminated Latin-1:
		....

	if (T - some text) could contain null-terminated Unicode:
		....

or

	if (T - some text) could contain compressed text:
		....

These tests are designed to be fast but not thorough; they will classify a text
but they will not check its validity.  For that, we have the conditional

	if (T - some text) is valid substitution-free text:
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

Section: Measuring substitution-free text

Given a text, we can count the number of characters in it via

	the character length of the substitution-free (T - some text)

Length measurements automatically entail a validity check, and if T has
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

Section: Looping over substitution-free text

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

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

The Glulx specification allows the string decoding table to contain calls to
Glulx functions (see Section 1.6.1.4 of the Glulx specification).  The validity
of these calls will not checked, nor will their output be counted in length
measurements.  As best I can tell, this limitation only affects authors who
store routine addresses in I6 printing variables, and code of this sort will
break on the Z-machine, so it's not a good idea anyway.

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

Glulx Text Decoding was prepared as part of the Glulx Runtime Instrumentation
Project (https://sourceforge.net/projects/i7grip/).  For this first edition of
the project, special thanks go to these people, in chronological order:

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

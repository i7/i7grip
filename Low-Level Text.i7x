Version 1 of Low-Level Text (for Glulx only) by Brady Garvin begins here.

"Mutable text for situations where Inform's indexed text isn't an option."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[Inform already has mutable text in the form of indexed text.  But for the Glulx Runtime Instrumentation Framework we need to worry about:

1. Reentrancy---if we inject a call into the middle of a block value management routine (which we will), the callee can't be sure that the block value record keeping is in a consistent state.

and

2. Speed---the interpreter-provided malloc is usually much faster than Inform's non-native, space-conscious equivalent.

So we use our own implementation.  However, the adjective ``low-level'' is important: synthetic text is more awkward and less forgiving than the nicely encapsulated indexed text.  It is suitable for use in the instrumentation framework and instrumentation extensions because that's what it was designed for.  It might be appropriate in some other obscure situations.  But it is not fit for general use in a story.  (Besides, it doesn't support non-Latin-1 characters.)]

Book "Runtime Checks"

Chapter "Environment Checks"

An environment check rule (this is the check for dynamic memory allocation to support synthetic text rule):
	always check that memory allocation is supported or else say "[low-level runtime failure in]Low-Level Text[with explanation]This story uses low-level text, which in turn depends on dynamic memory allocation.  But this interpreter doesn't allow dynamic memory allocation, meaning that the story cannot safely run.[terminating the story]".

Book "Synthetic Text"

Chapter  "The Synthetic Text Structure" - unindexed

[Layout:
	4 bytes padding (at offset -8 bytes)
	4 bytes for the length (at offset -4 bytes)
	1 byte for Glulx's marker for uncompressed Latin-1 text
	length bytes for the characters
	1 byte for the null terminator]

Chapter "Construction and Destruction of Synthetic Text"

To decide what text is a new uninitialized synthetic text with length (L - a number) character/characters:
	let the result be a memory allocation of L plus ten bytes;
	increase the result by four;
	write the integer L to address result;
	increase the result by four;
	write the byte 224 to address result;
	write the byte zero to address result plus L plus one;
	decide on the result converted to some text.

To decide what text is a new uninitialized permanent synthetic text with length (L - a number) character/characters:
	let the result be a permanent memory allocation of L plus ten bytes;
	increase the result by four;
	write the integer L to address result;
	increase the result by four;
	write the byte 224 to address result;
	write the byte zero to address result plus L plus one;
	decide on the result converted to some text.

[We assume that T doesn't change length, for example because of substitutions' side-effects.]
To decide what text is a new synthetic text copied from (T - some text) (this is copying text to synthetic text):
	let the length be the length of T;
	let the metrics structure address be a memory allocation of length plus ten bytes;
	let the result be the metrics structure address plus eight;
	write the byte 224 to address result;
	print the text T to the Latin-1 array at address result plus one with length length and metrics structure at address metrics structure address;
	write the byte zero to address result plus the length plus one;
	decide on the result converted to some text.

[We assume that T doesn't change length, for example because of substitutions' side-effects.]
To decide what text is a new permanent synthetic text copied from (T - some text) (this is copying text to permanent synthetic text):
	let the length be the length of T;
	let the metrics structure address be a permanent memory allocation of length plus ten bytes;
	let the result be the metrics structure address plus eight;
	write the byte 224 to address result;
	print the text T to the Latin-1 array at address result plus one with length length and metrics structure at address metrics structure address;
	write the byte zero to address result plus the length plus one;
	decide on the result converted to some text.

To decide what text is a new synthetic text extracted from the (N - a number) bytes at address (A - a number):
	let the result be a new uninitialized synthetic text with length N characters;
	copy N bytes from address A to address the character array address of the synthetic text result;
	decide on the result.

To decide what text is a new permanent synthetic text extracted from the (N - a number) bytes at address (A - a number):
	let the result be a new uninitialized permanent synthetic text with length N characters;
	copy N bytes from address A to address the character array address of the synthetic text result;
	decide on the result.

[The result is taken to be the text between the first occurrence of P and the first subsequent occurrence of S in T (all of which are synthetic), returned as a new synthetic text.  If there is no such text, this phrase returns the interned empty string.]
To decide what text is a new synthetic text extracted from the synthetic text (T - some text) between the synthetic prefix (P - some text) and the synthetic suffix (S - some text) or the interned empty string if there is no match:
	let the beginning index be the index of the synthetic text P in the synthetic text T;
	if beginning index is zero:
		decide on "";
	increase the beginning index by the length of the synthetic text P minus one;
	let the end index be the index of the synthetic text S in the synthetic text T starting after index beginning index;
	if the end index is zero:
		decide on "";
	let the length be the end index minus the beginning index;
	decrement the length;
	let the array address be the character array address of the synthetic text T plus the beginning index;
	decide on a new synthetic text extracted from the length bytes at address array address.

[The result is taken to be the text between the first occurrence of P and the first subsequent occurrence of S in T (all of which are synthetic), returned as a new permanent synthetic text.  If there is no such text, this phrase returns the interned empty string.]
To decide what text is a new permanent synthetic text extracted from the synthetic text (T - some text) between the synthetic prefix (P - some text) and the synthetic suffix (S - some text) or the interned empty string if there is no match:
	let the beginning index be the index of the synthetic text P in the synthetic text T;
	if beginning index is zero:
		decide on "";
	increase the beginning index by the length of the synthetic text P minus one;
	let the end index be the index of the synthetic text S in the synthetic text T starting after index beginning index;
	if the end index is zero:
		decide on "";
	let the length be the end index minus the beginning index;
	decrement the length;
	let the array address be the character array address of the synthetic text T plus the beginning index;
	decide on a new permanent synthetic text extracted from the length bytes at address array address.

To delete the synthetic text (T - some text) (this is deleting synthetic text):
	let the text address be T converted to a number;
	free the memory allocation at address text address minus eight.

Chapter "Private Synthetic Text Accessors and Mutators" - unindexed

To write the length (L - a number) to the synthetic text (T - some text): (- llo_setField({T},-1,{L}); -).

Chapter "Public Synthetic Text Accessors and Mutators"

To decide what number is the length of the synthetic text (T - some text): (- llo_getField({T},-1) -).

To decide what number is the character array address of the synthetic text (T - some text): (- ({T}+1) -).

To decide what Unicode character is the character at index (I - a number) of the synthetic text (T - some text): (- llo_getByte({T}+{I}) -).  [I is one-based; no plus one]
To decide what number is the character code at index (I - a number) of the synthetic text (T - some text): (- llo_getByte({T}+{I}) -).  [I is one-based; no plus one]

To write (C - a Unicode character) to index (I - a number) of the synthetic text (T - some text): (- llo_setByte({T}+{I},{C}); -).  [I is one-based; no plus one]
To write the character code (C - a number) to index (I - a number) of the synthetic text (T - some text): (- llo_setByte({T}+{I},{C}); -).  [I is one-based; no plus one]

Section "Capture to Synthetic Text"

Include (-
	Global llt_oldStream;
	Global llt_stream;
	Global llt_oldLength;
	Global llt_length;
-) after "Definitions.i6t".

[Using a pure stream implementation, CocoaGlk spends too much time flushing streams, and as a result some ordinarily split-second operations in Debug File Parsing take half a minute or so.  If we detect CocoaGlk, we want the option of the filter I/O system available.]

Include (-
[ llt_enter text;
#ifndef COCOA_QUIET;
	llt_oldStream=glk_stream_get_current();
#endif;
	llt_oldLength=llo_getField(text,-1);
	if(llo_cocoaGlkDetected){
#ifndef COCOA_QUIET;
		glk_stream_set_current(0);
#endif;
		llo_cocoaTargetAddress=text+1;
		llo_cocoaSpaceRemaining=llt_oldLength;
		rtrue;
	}
	llt_stream=glk_stream_open_memory(text+1,llt_oldLength,filemode_Write,0);
	if(llt_stream){
		glk_stream_set_current(llt_stream);
		rtrue;
	}
	llt_length=0;
	rfalse;
];

[ llt_exit text;
#ifndef COCOA_QUIET;
	glk_stream_set_current(llt_oldStream);
#endif;
	if(llo_cocoaGlkDetected){
		llt_length=llt_oldLength-llo_cocoaSpaceRemaining;
	}else{
		glk_stream_close(llt_stream,llo_streamToStringMetrics);
		llt_length=llo_getField(llo_streamToStringMetrics,1);
	}
	if(llt_length<llt_oldLength){
		llo_setField(text,-1,llt_length);
		llo_setByte(text+llt_length+1,0);
	}else{
		llo_setByte(text+llt_oldLength+1,0);
	}
];
-).

To overwrite the synthetic text (T - some text) with the text printed when we (P - a phrase): (-
	@push say__p;
	@push say__pc;
	@push llt_oldStream;
	@push llt_stream;
	@push llt_oldLength;
	@push llt_length;
	llt_oldLength=llo_getField({T},-1);
	if(llo_cocoaGlkDetected){
		@getiosys sp sp;
		@setiosys 1 llo_cocoaPrint;
		@push llo_cocoaTargetAddress;
		@push llo_cocoaSpaceRemaining;
	}
	if(llt_enter({T})){
		if(true) {P}
		llt_exit({T});
	}
	if(llo_cocoaGlkDetected){
		@pull llo_cocoaSpaceRemaining;
		@pull llo_cocoaTargetAddress;
		@stkswap;
		@setiosys sp sp;
	}
	@pull llt_length;
	@pull llt_oldLength;
	@pull llt_stream;
	@pull llt_oldStream;
	@pull say__pc;
	@pull say__p;
-).

Section "Synthetic Text Case Changes"

To decide what number is the Latin-1 character code (C - a number) downcased: (- glk_char_to_lower({C}) -).
To decide what number is the Latin-1 character code (C - a number) upcased: (- glk_char_to_upper({C}) -).

To downcase the synthetic text (T - some text):
	let the length be the length of the synthetic text T;
	let the character array address be the character array address of the synthetic text T;
	let the limit be the character array address plus the length;
	repeat with the character code address running from the character array address to the limit:
		let the downcased character code be the Latin-1 character code the byte at address character code address downcased;
		write the byte downcased character code to address character code address.

To upcase the synthetic text (T - some text):
	let the length be the length of the synthetic text T;
	let the character array address be the character array address of the synthetic text T;
	let the limit be the character array address plus the length;
	repeat with the character code address running from the character array address to the limit:
		let the downcased character code be the Latin-1 character code the byte at address character code address downcased;
		write the byte downcased character code to address character code address.

Section "Synthetic Text Prefix and Suffix Removal"

To remove (N - a number) character/characters from the beginning of the synthetic text (T - some text):
	let the destination address be the character array address of the synthetic text T;
	let the source address be the destination address plus N;
	let the new length be the length of the synthetic text T minus N;
	copy one plus the new length bytes from address source address to address destination address;
	write the length new length to the synthetic text T.

To remove (N - a number) character/characters from the end of the synthetic text (T - some text):
	let the new length be the length of the synthetic text T minus N;
	write the length new length to the synthetic text T;
	let the terminator address be the new length plus the character array address of the synthetic text T;
	write the byte zero to address the terminator address.

To possibly remove the synthetic text prefix (P - some text) from the beginning of the synthetic text (T - some text):
	if the synthetic text T begins with the synthetic text P:
		let the prefix length be the length of the synthetic text P;
		remove prefix length characters from the beginning of the synthetic text T.

To decide whether we successfully remove the synthetic text prefix (P - some text) from the beginning of the synthetic text (T - some text):
	if the synthetic text T begins with the synthetic text P:
		let the prefix length be the length of the synthetic text P;
		remove prefix length characters from the beginning of the synthetic text T;
		decide yes;
	decide no.

To possibly remove the synthetic text suffix (S - some text) from the end of the synthetic text (T - some text):
	if the synthetic text T ends with the synthetic text S:
		let the suffix length be the length of the synthetic text S;
		remove suffix length characters from the end of the synthetic text T.

To decide whether we successfully remove the synthetic text suffix (S - some text) from the end of the synthetic text (T - some text):
	if the synthetic text T ends with the synthetic text S:
		let the suffix length be the length of the synthetic text S;
		remove suffix length characters from the end of the synthetic text T;
		decide yes;
	decide no.

Section "Iteration over Synthetic Text"

Include (-
	Global llt_iterator;
-) after "Definitions.i6t".

To repeat with (I - a nonexisting number variable) running through the character codes in the synthetic text (T - some text) begin -- end: (-
	llt_iterator={T}+1;
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llt_iterator;
			if(llo_broken){
				break;
			}
			llt_iterator++;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			@aloadb llt_iterator 0 {I};
			if(~~{I}){
				llo_broken=true;
				break;
			}
			@push llt_iterator;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Chapter "Synthetic Text Equality Tests"

To decide whether the synthetic text (S - some text) is identical to the synthetic text (T - some text) (this is testing equality between synthetic text and synthetic text):
	decide on whether or not the length of the synthetic text S is the length of the synthetic text T and the synthetic text S begins with the synthetic text T.

To decide whether the synthetic text (S - some text) is identical to (T - some text) (this is testing equality between synthetic text and text):
	let the conversion be a new synthetic text copied from T;
	let the result be whether or not the synthetic text S is identical to the synthetic text the conversion;
	delete the synthetic text conversion;
	decide on the result.

To decide whether (S - some text) is identical to the synthetic text (T - some text) (this is testing equality between text and synthetic text):
	let the conversion be a new synthetic text copied from S;
	let the result be whether or not the synthetic text the conversion is identical to the synthetic text T;
	delete the synthetic text conversion;
	decide on the result.

To decide whether (S - some text) is identical to (T - some text) (this is testing equality between text and text):
	let the conversion of S be a new synthetic text copied from S;
	let the conversion of T be a new synthetic text copied from T;
	let the result be whether or not the synthetic text the conversion of S is identical to the synthetic text the conversion of T;
	delete the synthetic text conversion of S;
	delete the synthetic text conversion of T;
	decide on the result.

Chapter "Synthetic Text Substring Tests"

To decide what number is the index of (C - a Unicode character) in the synthetic text (T - some text):
	let the length be the length of the synthetic text T;
	let the array address be the character array address of the synthetic text T;
	decide on one plus the index of the byte C converted to a number in the length bytes at address array address.

To decide what number is the index of the character code (C - a number) in the synthetic text (T - some text):
	let the length be the length of the synthetic text T;
	let the array address be the character array address of the synthetic text T;
	decide on one plus the index of the byte C in the length bytes at address array address.

To decide what number is the index of the synthetic text (S - some text) in the synthetic text (T - some text):
	let the first length be the length of the synthetic text S;
	let the second length be the length of the synthetic text T;
	let the first array address be the character array address of the synthetic text S;
	let the second array address be the character array address of the synthetic text T;
	decide on one plus the index of the first length bytes at address first array address in the second length bytes at address second array address.

To decide what number is the index of (C - a Unicode character) in the synthetic text (T - some text) starting after index (I - a number):
	let the length be the length of the synthetic text T minus I;
	if the length is at most zero:
		decide on zero;
	let the array address be I plus the character array address of the synthetic text T;
	let the result be the index of the byte C converted to a number in the length bytes at address array address;
	if the result is less than zero:
		decide on zero;
	decide on one plus I plus the result.

To decide what number is the index of the character code (C - a number) in the synthetic text (T - some text) starting after index (I - a number):
	let the length be the length of the synthetic text T minus I;
	if the length is at most zero:
		decide on zero;
	let the array address be I plus the character array address of the synthetic text T;
	let the result be the index of the byte C in the length bytes at address array address;
	if the result is less than zero:
		decide on zero;
	decide on one plus I plus the result.

To decide what number is the index of the synthetic text (S - some text) in the synthetic text (T - some text) starting after index (I - a number):
	let the second length be the length of the synthetic text T minus I;
	if the second length is at most zero:
		decide on zero;
	let the first length be the length of the synthetic text S;
	let the first array address be the character array address of the synthetic text S;
	let the second array address be I plus the character array address of the synthetic text T;
	let the result be the index of the first length bytes at address first array address in the second length bytes at address second array address;
	if the result is less than zero:
		decide on zero;
	decide on one plus I plus the result.

Chapter "Synthetic Text Prefix and Suffix Tests"

To decide whether the synthetic text (T - some text) begins with the synthetic text (S - some text):
 	decide on whether or not the index of the synthetic text S in the synthetic text T is one.

To decide whether the synthetic text (T - some text) ends with the synthetic text (S - some text):
	let the excess be the length of the synthetic text T minus the length of the synthetic text S;
	decide on whether or not the excess is at least zero and the index of the synthetic text S in the synthetic text T starting after index excess is one plus the excess.

Low-Level Text ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

When we build on the extension Glulx Runtime Instrumentation Framework to create
Inform debugging tools, we often encounter situations where Inform's block value
management system needs to remain untouched, and we are unable to use Inform's
indexed text.  Low-Level Text contains a replacement text implementation that,
while less elegant, is a safe alternative even in these scenarios.

Details are in the following chapters.

Chapter: Usage

As story authors we have Inform's indexed text for text that we generate on the
fly.  But when we write instrumentation with the Glulx Runtime Instrumentation
Framework, any phrases involving Inform's block value management system are
unsafe, so indexed text is not an option.  Low-Level Text offers a modest
replacement.

As with all of these replacement extensions, the adjectives "low-level" and
"modest" are important: the phrases in Low-Level Text give us more chances to
commit subtle and hard-to-debug errors.  Unless we have a compelling reason,
like the fact that we're writing instrumentation, we will be better off with the
safer implementation provided by the Inform language.

Section: Overview

Low-Level Text introduces a new kind of text, synthetic text.  It behaves very
much like indexed text except that we cannot change its length, we cannot use
non-Latin-1 characters (at least in the current version; see
http://en.wikipedia.org/wiki/ISO/IEC_8859-1 for a description of the Latin-1
encoding and its list of characters), and we must watch out for two potential
pitfalls:

First, Inform understandably does not allow declarations like

	Synthetic text is a kind of text.

so it is up to us to keep track of which texts are synthetic and which are not;
the story will likely crash if we apply synthetic text phrases to ordinary text.

Second, we must be very careful with the word "is".  Suppose that we have
synthetic text called X with the contents "plugh".  The line

	showme whether or not X is "plugh";

will, perhaps surprisingly, say false.  "Is" compares the identity of texts, and
X is separate from Inform's copy of the word, even if it happens to have the
same string of characters.  Similarly, if Y is a distinct synthetic text also
containing "plugh",

	showme whether or not X is Y;

will print false.  See the section titled "Comparing" for phrases that compare
the contents of synthetic text.

Section: Creating and destroying synthetic text

We can obtain a gibberish text by asking for

	a new uninitialized synthetic text with length (L - a number) character/characters

and then correct its contents later.  We can copy characters from another text
(ordinary or synthetic, so long as it doesn't contain substitutions that will
change length after being said) as in

	a new synthetic text copied from (T - some text)

Or we can build text from an I6 byte array of character codes:

	a new synthetic text extracted from the (N - a number) bytes at address (A - a number)

If we add the word "permanent" before the words "synthetic text" in these
phrases, we will get back a synthetic text that cannot be subsequently
destroyed, but will affect story performance less, at least under some
interpreters.

When we're done with synthetic text that isn't permanent, we should ask the VM
to reclaim its memory:

	delete the synthetic text (T - some text)

Section: Measuring and indexing

In Low-Level Operations, text is measured with the phrase

	the length of the text (T - some text)

If we know T to be synthetic text, we can substitute the slightly faster phrase

	the length of the synthetic text (T - some text)

The contents of synthetic text are available as the address of a byte array of
character codes:

	the character array address of the synthetic text (T - some text)

as single characters:

	the character at index (I - a number) of the synthetic text (T - some text)

as single character codes:

	the character code at index (I - a number) of the synthetic text (T - some text)

or as character codes traversed by a loop:

	repeat with (I - a nonexisting number variable) running through the character codes in the synthetic text (T - some text):
		....

Note that, as with indexed text, character indices are numbered from one.

To change the contents, we have the phrase

	write (C - a Unicode character) to index (I - a number) of the synthetic text (T - some text)

and its relative

	write the character code (C - a number) to index (I - a number) of the synthetic text (T - some text)

Another option is to write

	overwrite the synthetic text (T - some text) with the text printed when we ...

where the ellipses can be any one line of Inform code, just as with an "if"
followed by a comma.  For instance,

	overwrite the synthetic text T with the text printed when we say "Hi!";

is legal, but not

	overwrite the synthetic text T with the text printed when we repeat with foo running from one to two:
		say "[foo]";

T will be replaced with whatever is said by that line, except that the output
may be cut off if it is longer than T has room to store.

Section: Comparing

We can compare the contents---rather than the identities---of two texts by
asking

	if (S - some text) is identical to (T - some text):
		....

Faster-running variations on this pattern are available if we know that S or T
is synthetic:

	if (S - some text) is identical to the synthetic text (T - some text):
		....

	if the synthetic text (S - some text) is identical to (T - some text):
		....

and

	if the synthetic text (S - some text) is identical to the synthetic text (T - some text):
		....

Section: Searching

We can request the location of one synthetic text in another:

	the index of the synthetic text (S - some text) in the synthetic text (T - some text)

The result here is the (one-based) index of the first character of the first
exact copy of S in T, or zero if no exact copy exists.  To find later matches we
can ask for

	the index of the synthetic text (S - some text) in the synthetic text (T - some text) starting after index (I - a number)

which behaves identically except that it only considers occurrences of S that
begin after index I (an occurrence at index I is not considered).

If we are searching for a single character, the phrases

	the index of (C - a Unicode character) in the synthetic text (T - some text)

and

	the index of (C - a Unicode character) in the synthetic text (T - some text) starting after index (I - a number)

behave analogously, while the phrases

	the index of the character code (C - a number) in the synthetic text (T - some text)

and

	the index of the character code (C - a number) in the synthetic text (T - some text) starting after index (I - a number)

take character codes in place of characters.

In a similar vein we can check text for a prefix,

	the synthetic text (T - some text) begins with the synthetic text (S - some text)
		....

or a suffix:

	the synthetic text (T - some text) ends with the synthetic text (S - some text)
		....

Section: Recasing

We can overwrite synthetic text with its lowercase version via the phrase

	downcase the synthetic text (T - some text)

In the same way, to make T uppercase, we use the phrase

	upcase the synthetic text (T - some text)

The same operations on Latin-1 character codes are accomplished by requesting

	the Latin-1 character code (C - a number) downcased

or

	the Latin-1 character code (C - a number) upcased

Section: Trimming

To remove characters from the beginning or end of synthetic text, we have the
two phrases

	remove (N - a number) character/characters from the beginning of the synthetic text (T - some text)

and

	remove (N - a number) character/characters from the end of the synthetic text (T - some text)

A often more convenient pair of phrases,

	possibly remove the synthetic text prefix (P - some text) from the beginning of the synthetic text (T - some text)

and

	possibly remove the synthetic text suffix (S - some text) from the end of the synthetic text (T - some text)

do the same thing, where N is given by the length of P or S, except that they
first check that characters to destroy are exactly those in P or S, and do
nothing if they are not.  Yet another variation has the two phrases

	if we successfully remove the synthetic text prefix (P - some text) from the beginning of the synthetic text (T - some text):
		....

and

	if we successfully remove the synthetic text suffix (S - some text) from the end of the synthetic text (T - some text):
		....

which do the same, but this time decide yes if and only if the removal actually
took place.

Section: Extracting

The last possibility is a tad more eccentric than the others, and mainly
provided to support other extensions in the Glulx Runtime Instrumentation
Project.  Still, here it is:

If we ask for

	a new synthetic text extracted from the synthetic text (T - some text) between the synthetic prefix (P - some text) and the synthetic suffix (S - some text) or the interned empty string if there is no match

we get back, as a synthetic text, all of the text between the first occurrence
of P and the first subsequent occurrence of S, both in T.  But if either P or S
cannot be found, we don't get a synthetic text at all---we get Inform's copy of
the empty string, "".  The qualifier "permanent" can be used here, just as with
the other synthetic text constructors.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Section: Obscure limitations, which should affect almost nobody

A few actions, like throwing an exception or calling glk_set_stream, ought not
to take place inside text routines used with these phrases, for reasons that are
hopefully obvious.  Inform will never pull such shenanigans on its own.

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

Low-Level Text was prepared as part of the Glulx Runtime Instrumentation Project
(https://sourceforge.net/projects/i7grip/).  For this first edition of the
project, special thanks go to these people, in chronological order:

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

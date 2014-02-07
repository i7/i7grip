Version 2 of Low-Level Vectors (for Glulx only) by Brady Garvin begins here.

"Vectors for situations where Inform's lists aren't an option."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Object Pools by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2014 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[Inform already has lists in the form of, well, lists, and when they can't be used, Low-Level Linked Lists is almost always a suitable alternative.  We would, however, like an easily indexed alternative for one case: the partition data structures in the SMT solver.

As always, the adjective ``low-level'' is important: these lists are more awkward and less forgiving than the nicely encapsulated Inform lists.  They are suitable for use in the instrumentation framework and instrumentation extensions because that's what they were designed for.  They might be appropriate in some other obscure situations.  But they are not fit for general use in a story.]

[For each of the kinds defined by Low-Level Vectors you will see a sentence like

	A vector is an invalid vector.

This bewildering statement actually sets up vectors as a qualitative value with default value the vector at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on vectors.]

Book "Runtime Checks"

Chapter "Environment Checks"

An environment check rule (this is the check for dynamic memory allocation to support vectors rule):
	always check that memory allocation is supported or else say "[low-level runtime failure in]Low-Level Vectors[with explanation]This story uses low-level vectors, which in turn depend on dynamic memory allocation.  But this interpreter doesn't allow dynamic memory allocation, meaning that the story cannot safely run.[terminating the story]".

Book "Vectors"

Chapter "The Vector Kind"

A vector is a kind of value.
A vector is an invalid vector.  [See the note in the book "Extension Information."]
The specification of a vector is "A flexible-length list, much like the list kind that is built into Inform, and also similar to a low-level linked list, except with different performance characteristics.  These vectors differ from Inform lists in two notable ways: (1) They do not use Inform's block value management system, which means that they can be used safely even when that management system is in an intermediate or inconsistent state.  This, in fact, is why they were introduced.  But it also means that vectors must be explicitly allocated and freed.  (2) They support a slightly different (and slightly more error-prone) interface.  Consult the extension documentation for details."

Chapter "Vector Structure" - unindexed

[Layout:
	4 bytes for the capacity
	4 bytes for the size
	4 bytes for the array address]

To decide what number is the size of a vector: (- 12 -).

Chapter "Private Vector Construction and Destruction" - unindexed

To initialize (A - a vector) with capacity (C - a number):
	let the array address be a possibly zero-length memory allocation of four times C bytes;
	write the capacity C to A;
	write the size zero to A;
	write the array address the array address to A.

To delete the contents of (A - a vector):
	free the possibly zero-length memory allocation at address the array address of A.

Chapter "Public Vector Construction and Destruction"

To decide what vector is a new vector with capacity (C - a number):
	let the result be a memory allocation of the size of a vector bytes converted to a vector;
	initialize the result with capacity C;
	decide on the result.

To delete (A - a vector):
	delete the contents of A;
	free the memory allocation at address A converted to a number.

Chapter "Private Vector Accessors and Mutators" - unindexed

To write the capacity (C - a number) to (A - a vector): (- llo_setInt({A}, {C}); -).

To write the size (S - a number) to (A - a vector): (- llo_setField({A}, 1, {S}); -).

To write the array address (B - a number) to (A - a vector): (- llo_setField({A}, 2, {B}); -).

Chapter "Public Vector Accessors and Mutators"

To decide what number is the capacity of (A - a vector): (- llo_getInt({A}) -).

To decide what number is the size of (A - a vector): (- llo_getField({A}, 1) -).

To decide what number is the array address of (A - a vector): (- llo_getField({A}, 2) -).

[This accessor produces an l-value for the sake of vectors containing linked lists.]
To decide what K is (D - a description of values of kind K) datum (I - a number) of (A - a vector): (- (llo_getField({A}, 2)-->{I}) -).
To write (X - a value) to datum (I - a number) of (A - a vector): (- llo_setField(llo_getField({A}, 2), {I}, {X}); -).

Chapter "Vector Resizing"

To resize (A - a vector) to hold (S - a number) data:
	let the capacity be the capacity of A;
	if the capacity is zero:
		now the capacity is one;
	if S is greater than the capacity:
		while S is greater than the capacity:
			now the capacity is the capacity shifted one bit left;
		let the relocation size be four times the size of A;
		let the old array address be the array address of A;
		let the new array address be a memory allocation of four times the capacity bytes;
		copy relocation size bytes from address the old array address to address the new array address;
		free the memory allocation at address the old array address;
		write the array address the new array address to A;
		write the capacity the capacity to A;
	write the size S to A.

Chapter "Iteration Interface"

Section "Iterator Variables used by the Iteration Interface" - unindexed

Include (-
	Global llv_array;
	Global llv_limit;
	Global llv_iterator;
-) after "Definitions.i6t".

Section "Unfiltered Repetition"

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) data in (A - a vector) begin -- end: (-
	llv_array = llo_getField({A}, 2);
	@push llv_array;
	llv_limit = llo_getField({A}, 1);
	@push llv_limit;
	llv_iterator = 0;
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llv_iterator;
			if (llo_broken) {
				@pull llv_limit;
				@pull llv_array;
				break;
			}
			llv_iterator++;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			@push llv_iterator;
			@stkpeek 1 llv_limit;
			llo_advance = llo_broken = (llv_iterator >= llv_limit);
			if (~~llo_broken) {
				@stkpeek 2 llv_array;
				@aload llv_array llv_iterator {I};
			}
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Low-Level Vectors ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

When we write instrumentation code for use with the Glulx Runtime
Instrumentation Framework or a library that supports such code, we must consider
the possibility that the instrumentation will be called from within Inform's
block value management system.  The block value management routines are not
reentrant, so in such a case we cannot safely use Inform's lists; we must turn
to another data structure.  Low-Level Vectors, like its relative Low-Level
Linked Lists, contains a replacement list implementation that, while more
demanding on the programmer, is a safe alternative even in these extreme
scenarios.

Details are in the following chapters.

Chapter: Usage

Normally we have Inform's lists for expressing a set or sequence of concepts.
But when we write instrumenting rules for the Glulx Runtime Instrumentation
Framework, lists are forbidden because they might involve Inform's block value
management system.  Low-Level Vectors is a modest substitution.

The adjectives "low-level" and "modest" are important: these lists open up
opportunities for subtle and hard-to-debug errors.  Unless we have a compelling
reason, like the fact that we're writing instrumentation code, we will be better
off with the safer implementations provided by the Inform language.

Even if we do have a strong motive for avoiding Inform's lists, we should also
consider the possibility that Low-Level Linked Lists will be a better fit.

Section: Creating, resizing, and deleting vectors

Low-Level Vectors stores lists as values of the kind "vector".  The default
value of this kind is

	an invalid vector

to mark variables that have not been initialized.  To create a new vector, we
write

	let (A - a name not so far used) be a new vector with capacity (C - a number)

or

	now (A - a vector variable) is a new vector with capacity (C - a number)

The vector will put a chunk of memory on reserve large enough to hold C
elements, but it won't actually use any of that memory because a vector's
initial size is zero elements.  We can change the situation with the phrase

	resize (A - a vector) to hold (S - a number) data

after which the vector will have S elements.  If a resize makes a vector
shorter, the elements at the end of the vector are dropped; if it enlarges the
vector, elements are likewise added at the end---but they are not initialized,
so we must remember to set them to valid values.  Any resizes that exceed the
vector's capacity will implicity cause capacity to increase.  It takes time,
though, to exchange a chunk of memory for a larger one, so we should try to set
C to a reasonable value to begin with.

The current capacity of a vector is always available as

	the capacity of (A - a vector)

similarly, its size can be gotten by writing

	the size of (A - a vector)

When we are done with a vector, we should invoke the phrase

	delete (A - a vector)

and the virtual machine will reclaim its memory.

Section: Accessing and changing vector elements

To read the Ith element of a vector, we supply the element kind and index to
the phrase

	(K - a kind) datum (I - a number) of (A - a vector)

Likewise, to write to an element, we give a value and an index (the value
implies the kind):

	write (X - a value) to datum (I - a number) of (A - a vector):

For some operations it is faster to have all of the elements laid out in a
contiguous block of memory.  The phrase

	the array address of (A - a vector)

will return the address of such a block, but the block is only guaranteed valid
until the next resize.

Chapter: Requirements, Limitations and Bugs

This version was tested with Inform 6G60.  It may not function under other
versions.

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

Low-Level Operations was prepared as part of the Glulx Runtime Instrumentation
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

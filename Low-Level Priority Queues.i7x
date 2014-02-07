Version 1 of Low-Level Priority Queues (for Glulx only) by Brady Garvin begins here.

"Priority queues based on Low-Level Vectors."

Include Runtime Checks by Brady Garvin.
Include Low-Level Vectors by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2014 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Low-Level Priority Queues you will see a sentence like

	A priority queue is an invalid priority queue.

This bewildering statement actually sets up priority queues as a qualitative value with default value the priority queue at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on priority queues.]

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at dequeuing from an empty priority queue:
	say "[low-level runtime failure in]Low-Level Priority Queues[with explanation]I was asked to dequeue a value from an empty queue.[terminating the story]".

Book "Priority Queues"

Chapter "The Priority Queue Kind"

A priority queue is a kind of value.
A priority queue is an invalid priority queue.  [See the note in the book "Extension Information."]
The specification of a priority queue is "As WI says, a queue is a list of values waiting for attention.  A priority queue differs from a regular queue in that values can jump ahead in line if the queue's ranking function deems that they should be addressed sooner.  These priority queues are unlike continually resorted Inform lists in that (1) They have slightly better performance characteristics.  (2) They do not use Inform's block value management system, which means that they can be used safely even when that management system is in an intermediate or inconsistent state.  This, in fact, is one reason that they were introduced.  But it also means that priority queues must be explicitly allocated and freed.  (3) They support a slightly different (and slightly more error-prone) interface.  Consult the extension documentation for details."

Chapter "Priority Queue Structure" - unindexed

[The priority queue type is an alias for the vector type.]

Chapter "Private Priority Queue Construction and Destruction" - unindexed

To initialize (A - a priority queue) with capacity (C - a number):
	initialize A converted to a vector with capacity C.

To delete the contents of (A - a priority queue):
	delete the contents of A converted to a vector.

Chapter "Public Priority Queue Construction and Destruction"

To decide what priority queue is a new priority queue with capacity (C - a number):
	decide on a new vector with capacity C converted to a priority queue.

To delete (A - a priority queue):
	delete A converted to a vector.

Chapter "Public Priority Queue Accessors and Mutators"

[These depend on the vector layout.]

To decide what number is the capacity of (A - a priority queue): (- llo_getInt({A}) -).

To decide what number is the size of (A - a priority queue): (- llo_getField({A}, 1) -).

To decide what number is the array address of (A - a priority queue): (- llo_getField({A}, 2) -).

Chapter "Priority Queue Interface"

Section "Private Priority Queue Operations" - unindexed

To decide what number is the parent index of (I - a number): (- (({I} - 1) / 2) -).
To decide what number is the left child index of (I - a number): (- ((2 * {I}) + 1) -).
To decide what number is the right child index of (I - a number): (- ((2 * {I}) + 2) -).

To bubble (X - a value of kind K) in (A - a priority queue) from index (I - a number) with ranking phrase (R - a phrase K -> number):
	let the underlying vector be A converted to a vector;
	let the rank be R applied to X;
	let the index be I;
	while the index is greater than zero:
		let the parent index be the parent index of the index;
		let the other value be K datum parent index of the underlying vector;
		let the other rank be R applied to the other value;
		if the rank is greater than the other rank:
			break;
		write the other value to datum index of the underlying vector;
		now the index is the parent index;
	write X to datum index of the underlying vector.

Section "Public Priority Queue Operations"

To enqueue (X - a value of kind K) in (A - a priority queue) with ranking phrase (R - a phrase K -> number):
	let the underlying vector be A converted to a vector;
	let the index be the size of the underlying vector;
	resize the underlying vector to hold one plus the index data;
	bubble X in A from index the index with ranking phrase R.

To decide what K is (D - a description of values of kind K) dequeued from (A - a priority queue) with ranking phrase (R - a phrase K -> number):
	let the underlying vector be A converted to a vector;
	let the size be the size of the underlying vector;
	always check that the size is greater than zero or else fail at dequeuing from an empty priority queue;
	let the result be K datum zero of the underlying vector;
	let the index be zero;
	repeat until a break:
		let the left index be the left child index of the index;
		let the child index be the left index;
		if the left index is at least the size:
			break;
		let the left value be K datum left index of the underlying vector;
		let the child value be the left value;
		let the right index be the right child index of the index;
		if the right index is less than the size:
			let the left rank be R applied to the left value;
			let the right value be K datum right index of the underlying vector;
			let the right rank be R applied to the right value;
			if the left rank is greater than the right rank:
				now the child index is the right index;
				now the child value is the right value;
		write the child value to datum index of the underlying vector;
		now the index is the child index;
	let the extra index be the size of the underlying vector minus one;
	if the index is not the extra index:
		let the extra value be K datum extra index of the underlying vector;
		bubble the extra value in A from index the index with ranking phrase R;
	resize the underlying vector to hold the extra index data;
	decide on the result.

Low-Level Priority Queues ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

When we write instrumentation code for use with the Glulx Runtime
Instrumentation Framework or a library that supports such code, we must consider
the possibility that the instrumentation will be called from within Inform's
block value management system.  The block value management routines are not
reentrant, so in such a case we cannot safely use Inform's lists as priority
queues; we must turn to another data structure.  Low-Level Priority Queues ,
like its relatives Low-Level Vectors and Low-Level Linked Lists, contains a
replacement list implementation (in this case specialized for priority queue
operations) that, while more demanding on the programmer, is a safe alternative
even in these extreme scenarios.

Details are in the following chapters.

Chapter: Usage

As WI says, a queue is a list of values waiting for attention.  A priority queue
differs from a regular queue in that values can jump ahead in line if the
queue's ranking function deems that they should be addressed sooner.  Using an
inform list as the underlying implementation, we would write a priority queue
enqueuings as

	add the enqueued value to the priority queue;
	sort the priority queue;

(where we assume that sorting has been set up to put more urgent entries at
lower indices) and dequeuings as

	let the dequeued value be entry one of the priority queue;
	remove entry one from the priority queue;

But when we write instrumenting rules for the Glulx Runtime Instrumentation
Framework, lists are forbidden because they might involve Inform's block value
management system.  Low-Level Priority Queues is a modest substitution.

The adjectives "low-level" and "modest" are important: these queues open up
opportunities for subtle and hard-to-debug errors.  Unless we have a compelling
reason, like the fact that we're writing instrumentation code, we will be better
off with the safer list implementation provided by the Inform language.

Section: Creating, resizing, and deleting priority queues

Low-Level Priority Queues stores priority queues as values of the kind "priority
queue".  The default value of this kind is

	an invalid priority queue

to mark variables that have not been initialized.  To create a new priority
queue, we write

	let (A - a name not so far used) be a new priority queue with capacity (C - a number)

or

	now (A - a priority queue variable) is a new priority queue with capacity (C - a number)

The priority queue will put a chunk of memory on reserve large enough to hold C
elements, but it won't actually use any of that memory because a priority
queue's initial size is zero elements.

The current capacity of a priority queue is always available as

	the capacity of (A - a priority queue)

similarly, its size can be gotten by writing

	the size of (A - a priority queue)

When we are done with a priority queue, we should invoke the phrase

	delete (A - a priority queue)

and the virtual machine will reclaim its memory.

Section: Accessing and changing priority queue elements

To add an element to a priority queue, we use the phrase

	enqueue (X - a value of kind K) in (A - a priority queue) with ranking phrase (R - a phrase K -> number)

where R is consulted to keep the priority queue orderly.  It should decide on
low numbers for values that we want to exit the queue quickly, high numbers for
values that can wait until later.  If it decides on the same number for two
different values, they may come out in either order.

To retrieve elements, the phrase to use is

	(K - a kind name) dequeued from (A - a priority queue) with ranking phrase (R - a phrase K -> number)

It will complain if the queue is empty.  Again, R is called on the reinstate
order after the departing element leaves a gap.

Finally, for some operations it is faster to have all of the waiting elements
laid out in a contiguous block of memory.  The phrase

	the array address of (A - a priority queue)

will return the address of such a block, but the block is only guaranteed valid
until the priority queue operation.

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

Version 2 of Object Pools (for Glulx only) by Brady Garvin begins here.

"A caching system for speeding up memory allocations when the number of simultaneous allocations can be reasonably bounded."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Object Pools you will see a sentence like

	A object pool is an invalid object pool.

This bewildering statement actually sets up object pools as a qualitative value with default value the object pool at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on object pools.]

Book "Runtime Checks"

Chapter "Environment Checks"

An environment check rule (this is the check for dynamic memory allocation to support object pools rule):
	always check that memory allocation is supported or else say "[low-level runtime failure in]Object Pools[with explanation]This story uses object pools, which in turn depend on dynamic memory allocation.  But this interpreter doesn't allow dynamic memory allocation, meaning that the story cannot safely run.[terminating the story]".

Book "Transfer Variables" - unindexed

Include (-
	Global op_transfer;
-).

Book "Object Pools"

Chapter "Object Pools"

Section "The Object Pool Kind"

An object pool is a kind of value.
An object pool is an invalid object pool.  [See the note in the book "Extension Information."]
The specification of an object pool is "Object pools reserve memory for allocations of a particular type, which can speed up the process of finding space for an allocation so long as the reserved space doesn't run out.  In general, an object pool only makes sense if objects are created and destroyed frequently, and, at the same time, the total number of objects in existence tends to stay below a given bound."

Section "The Object Pool Structure" - unindexed

[Layout:
	4 bytes for the object size (in bytes, which we call M [it must be at least four; see the layout below]) (at offset -8 bytes)
	4 bytes for the pool size (the total in bytes, which, letting N be the number of available objects, is N times M) (at offset -4 bytes)
	4 bytes for the next available object address
	(M * N_0) bytes for the reserved memory (N_0 means the initial value of N, which must be nonnegative)]
[Layout of an unallocated object:
	4 bytes for the pointer to the next unallocated object
	(M - 4) bytes left over]

Section "Object Pool Construction"

Include (-
	[ op_newPool count objectSize
		poolSize result objectAddress otherObjectAddress limit;
		poolSize = 12 + count * objectSize;
		result = llo_permanentMalloc(poolSize);
		poolSize = poolSize - 12;
		result = result + 12;
		@astore result (-3) objectSize;
		@astore result (-2) poolSize;
		@astore result (-1) result;
		limit = result + poolSize;
		for (objectAddress = result::) {
			otherObjectAddress = objectAddress + objectSize;
			if (otherObjectAddress == limit) {
				@astore objectAddress 0 0;
				return result - 4;
			}
			@astore objectAddress 0 otherObjectAddress;
			objectAddress = otherObjectAddress + objectSize;
			if (objectAddress == limit) {
				@astore otherObjectAddress 0 0;
				return result-4;
			}
			@astore otherObjectAddress 0 objectAddress;
		}
	];
-).

To decide what object pool is a new permanent object pool with (N - a number) objects of size (M - a number) bytes: (- op_newPool({N}, {M}) -).

Section "Object Pool Allocators"

Include (-
	[ op_poolAllocate pool
		result objectSize poolSize objectAddress otherObjectAddress limit;
		@aload pool 0 result;
		if (result) {
			@mcopy 4 result pool;
			return result;
		}
		@aload pool (-2) objectSize;
		@aload pool (-1) poolSize;
		result = llo_permanentMalloc(poolSize);
		objectAddress = result + objectSize;
		limit = result + poolSize;
		poolSize = poolSize + poolSize;
		@astore pool (-1) poolSize;
		@astore pool 0 objectAddress;
		if (objectAddress ~= limit) {
			for (::) {
				otherObjectAddress = objectAddress + objectSize;
				if (otherObjectAddress == limit) {
					@astore objectAddress 0 0;
					return result;
				}
				@astore objectAddress 0 otherObjectAddress;
				objectAddress = otherObjectAddress + objectSize;
				if (objectAddress == limit) {
					@astore otherObjectAddress 0 0;
					return result;
				}
				@astore otherObjectAddress 0 objectAddress;
			}
		}
		return result;
	];
	[ op_poolFree pool address;
		@mcopy 4 pool address;
		@astore pool 0 address;
	];
-).

To decide what number is a memory allocation from (A - an object pool): (- op_poolAllocate({A}) -).

To free the memory allocation at address (X - a number) to (A - an object pool): (- op_poolFree({A}, {X}); -).

Chapter "Batch Object Pools"

Section "The Batch Object Pool Kind"

A batch object pool is a kind of value.
A batch object pool is an invalid batch object pool.  [See the note in the book "Extension Information."]
The specification of a batch object pool is "Batch object pools act like object pools, except that they are specialized for cases where all objects are destroyed together."

Section "The Batch Object Pool Structure" - unindexed

[Layout:
	4 bytes for the previous address (the initial number of addresses we call N)
	4 bytes for the object size (in bytes, which we call M)
	4 bytes for the pool size (the total, in bytes)
	(M * N) bytes for the reserved memory]

Section "Batch Object Pool Construction"

Include (-
	[ op_newBatchPool count objectSize
		poolSize result end;
		poolSize = 12 + count * objectSize;
		result = llo_permanentMalloc(poolSize);
		end = result + poolSize;
		@astore result 0 end;
		@astore result 1 objectSize;
		@astore result 2 poolSize;
		return result;
	];
-).

To decide what batch object pool is a new permanent batch object pool with (N - a number) objects of size (M - a number) bytes: (- op_newBatchPool({N}, {M}) -).

Section "Batch Object Pool Allocators"

Include (-
	[ op_batchPoolAllocate pool objectSize
		result offset;
		@aload pool 1 objectSize;
		@aload pool 0 result;
		result = result - objectSize;
		@astore pool 0 result;
		offset = result - pool;
		if (offset >= 12) {
			return result;
		}
		return llo_malloc(objectSize);
	];
	[ op_batchPoolFreeInternals pool
		result poolSize end;
		@aload pool 0 result;
		result = ((result - pool) >= 12);
		@aload pool 2 poolSize;
		end = pool + poolSize;
		@astore pool 0 end;
		return result;
	];
	[ op_batchPoolFree pool address
		offset poolSize index;
		offset = address - pool;
		@aload pool 2 poolSize;
		@"3:42" offset poolSize 0; !jltu
		llo_free(address);
	];
-).

To decide what number is a memory allocation from (A - a batch object pool): (- op_batchPoolAllocate({A}) -).

To free internal memory allocations to (A - a batch object pool): (- op_batchPoolFreeInternals({A}); -).
To decide whether all relevant allocations are accounted for after freeing internal memory allocations to (A - a batch object pool): (- op_batchPoolFreeInternals({A}) -).
To free the memory allocation at address (X - a number) to (A - a batch object pool) if it is external: (- op_batchPoolFree({A}, {X}); -).

Object Pools ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Object Pools is a low-level extension for speeding up temporary memory
allocations when many of them have the same size.  It is only useful in code
that would otherwise invoke Glulx's malloc directly---a debugging extension for
instance, but not a typical story.

Details are in the following chapters.

Chapter: Usage

Section: Introduction

Whenever an instruction in a story file accesses memory, the interpreter has to
convert from the Glulx memory address to the address in its own memory where the
data is actually stored.  For statically allocated memory this is fairly easy;
it just adds one offset if the address is in ROM and another if the address is
in RAM (and the offsets might be the same).  But for memory in the dynamically
allocated range, it must first determine which allocation the address is inside
of, and only then can it add the appropriate offset.  The speed of this lookup
depends mostly on how many separate allocations the story has outstanding---more
allocations means more possibilities to consider.

Therefore, considering that memory accesses are quite frequent, it's to our
advantage to limit our allocation count.  For the fairly common case where we
can identify a family of like-sized allocations, there's a standard technique we
can use---an object pool.

An "object pool", in computer science terms, is a collection of unused, equally
sized memory blocks set aside for future use.  We "allocate" a block from a pool
simply by removing it from the collection; we "free" a block by adding it back
in.  If ever we need more blocks than are on hand, we ask the interpreter for a
large chunk of new memory, divide it up into blocks, and then place them in the
pool.  Thus, we only pay for the number of refills, not the number of blocks.

Section: Ordinary object pools

The ordinary object pools defined by this extension are of the kind

	an object pool

The default value for this kind is

	an invalid object pool

which, as one might expect, cannot actually be used to make allocations.  It is
an error to use an invalid pool in any of the extension's phrases.

To create a useful value, we call on the phrase

	a new permanent object pool with (N - a number) objects of size (M - a number) bytes

which decides on a pool holding N blocks of M bytes and the policy that the
total number of blocks should double whenever the pool is exhausted.  Note that
M is required to be at least four, but this isn't much of a restriction when
four or fewer bytes can just as well be stored directly as by address.

We gain access to allocations by requesting

	a memory allocation from (A - an object pool)

which will return the address of an unused size-M block---we usually want to
apply the conversion phrases from Low-Level Operations to give the block the
appropriate kind.  When we are done with a block, we invoke the phrase

	free the memory allocation at address (X - a number) to (A - an object pool)

after which the address X should be considered invalid, at least until it's
recycled and returned again by the allocating phrase.

Section: Batch object pools

Batch object pools are like ordinary object pools, except specialized for
situations where allocations are made in batches and no allocations survive from
one batch to the next.  As with ordinary object pools, batch object pools have a
kind:

	a batch object pool

and a default value for that kind, which is not a valid argument to the
extension's phrases:

	an invalid batch object pool

The similarities continue with the phrase for creating a valid batch object pool:

	a new permanent batch object pool with (N - a number) objects of size (M - a number) bytes

and for obtaining a memory allocation from it:

	a memory allocation from (A - a batch object pool)

The only difference is in how allocations are freed.  We use first the phrase

	unless all relevant allocations are accounted for after freeing internal memory allocations to (A - a batch object pool):
		....

which will free all allocations that were in fact made from the pool and not
dynamic memory.  If some allocations were missed out, the ellipses execute,
wherein we typically want to loop over the objects' addresses applying the
phrase

	free the memory allocation at address (X - a number) to (A - a batch object pool) if it is external

which will clean up the extra objects while ignoring those that have already
been put back in the pool.

If we know that the pool has not been exceeded, there is the option to just write

	free internal memory allocations to (A - a batch object pool)

Chapter: Requirements, Limitations, and Bugs

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

Object Pools was prepared as part of the Glulx Runtime Instrumentation Project
(https://github.com/i7/i7grip).

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

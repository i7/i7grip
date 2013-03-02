Version 1 of Object Pools (for Glulx only) by Brady Garvin begins here.

"A caching system for speeding up memory allocations when the number of simultaneous allocations can be reasonably bounded."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

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
	M*N_0 bytes for the reserved memory (N_0 means the initial value of N, which must be nonnegative)]
[Layout of an unallocated object:
	4 bytes for the pointer to the next unallocated object
	M-4 bytes left over]

Section "Object Pool Construction"

Include (-
	[ op_newPool count objectSize
		poolSize result objectAddress otherObjectAddress limit;
		poolSize=12+count*objectSize;
		result=llo_permanentMalloc(poolSize);
		poolSize=poolSize-12;
		result=result+12;
		@astore result (-3) objectSize;
		@astore result (-2) poolSize;
		@astore result (-1) result;
		limit=result+poolSize;
		for(objectAddress=result: :){
			otherObjectAddress=objectAddress+objectSize;
			if(otherObjectAddress==limit){
				@astore objectAddress 0 0;
				return result-4;
			}
			@astore objectAddress 0 otherObjectAddress;
			objectAddress=otherObjectAddress+objectSize;
			if(objectAddress==limit){
				@astore otherObjectAddress 0 0;
				return result-4;
			}
			@astore otherObjectAddress 0 objectAddress;
		}
	];
-).

To decide what object pool is a new permanent object pool with (N - a number) objects of size (M - a number) bytes: (- op_newPool({N},{M}) -).

Section "Object Pool Allocators"

Include (-
	[ op_poolAllocate pool
		result objectSize poolSize objectAddress otherObjectAddress limit;
		@aload pool 0 result;
		if(result){
			@mcopy 4 result pool;
			return result;
		}
		@aload pool (-2) objectSize;
		@aload pool (-1) poolSize;
		result=llo_permanentMalloc(poolSize);
		objectAddress=result+objectSize;
		limit=result+poolSize;
		poolSize=poolSize+poolSize;
		@astore pool (-1) poolSize;
		@astore pool 0 objectAddress;
		if(objectAddress~=limit){
			for(::){
				otherObjectAddress=objectAddress+objectSize;
				if(otherObjectAddress==limit){
					@astore objectAddress 0 0;
					return result;
				}
				@astore objectAddress 0 otherObjectAddress;
				objectAddress=otherObjectAddress+objectSize;
				if(objectAddress==limit){
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

To free the memory allocation at address (X - a number) to (A - an object pool): (- op_poolFree({A},{X}); -).

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
	MN bytes for the reserved memory]

Section "Batch Object Pool Construction"

Include (-
	[ op_newBatchPool count objectSize poolSize result end;
		poolSize=12+count*objectSize;
		result=llo_permanentMalloc(poolSize);
		end=result+poolSize;
		@astore result 0 end;
		@astore result 1 objectSize;
		@astore result 2 poolSize;
		return result;
	];
-).

To decide what batch object pool is a new permanent batch object pool with (N - a number) objects of size (M - a number) bytes: (- op_newBatchPool({N},{M}) -).

Section "Batch Object Pool Allocators"

Include (-
	[ op_batchPoolAllocate pool objectSize result offset;
		@aload pool 1 objectSize;
		@aload pool 0 result;
		result=result-objectSize;
		@astore pool 0 result;
		offset=result-pool;
		if(offset>=12){
			return result;
		}
		return llo_malloc(objectSize);
	];
	[ op_batchPoolFreeInternals pool result poolSize end;
		@aload pool 0 result;
		result=((result-pool)>=12);
		@aload pool 2 poolSize;
		end=pool+poolSize;
		@astore pool 0 end;
		return result;
	];
	[ op_batchPoolFree pool address offset poolSize index;
		offset=address-pool;
		@aload pool 2 poolSize;
		@"3:42" offset poolSize 0; !jltu
		llo_free(address);
	];
-).

To decide what number is a memory allocation from (A - a batch object pool): (- op_batchPoolAllocate({A}) -).

To free internal memory allocations to (A - a batch object pool): (- op_batchPoolFreeInternals({A}); -).
To decide whether all relevant allocations are accounted for after freeing internal memory allocations to (A - a batch object pool): (- op_batchPoolFreeInternals({A}) -).
To free the memory allocation at address (X - a number) to (A - a batch object pool) if it is external: (- op_batchPoolFree({A},{X}); -).

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

Therefore, considering that memory accesses are quite common, it's to our
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

The only difference is in how allocations are freed.  We use the phrase

	free the memory allocations made from (A - a batch object pool)

which frees every outstanding allocation at once.

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

Object Pools was prepared as part of the Glulx Runtime Instrumentation Project
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

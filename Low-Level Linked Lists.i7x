Version 1 of Low-Level Linked Lists (for Glulx only) by Brady Garvin begins here.

"Linked lists for situations where Inform's lists aren't an option."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Object Pools by Brady Garvin.
Include Low-Level Text by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[Inform already has lists in the form of, well, lists.  But for the Glulx Runtime Instrumentation Framework we need to worry about:

1. Reentrancy---if we inject a call into the middle of a block value management routine (which we will), the callee can't be sure that the block value record keeping is in a consistent state.

2. Speed---the interpreter-provided malloc is usually much faster than Inform's non-native, space-conscious equivalent.

and

3. Payload size---the contents of Inform lists are individual items, either stored literally or by pointer.  But there are several situation in the framework where it makes more sense to let the elements be pairs or even triples.

So we use our own implementation.  However, the adjective ``low-level'' is important: these lists are more awkward and less forgiving than the nicely encapsulated Inform lists.  They are suitable for use in the instrumentation framework and instrumentation extensions because that's what they were designed for.  They might be appropriate in some other obscure situations.  But they are not fit for general use in a story.]

[For each of the kinds defined by Low-Level Linked Lists you will see a sentence like

	A linked list is an invalid linked list.

This bewildering statement actually sets up linked lists as a qualitative value with default value the linked list at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on linked lists.]

[We use comparators to check equality of underlying keys (see below).  Properly speaking a comparator is a (phrase (value of kind K,K) -> truth state), but because of an Inform bug we have to write (phrase (value of kind K,K) -> nothing) instead.  The first argument is the key being searched for and the second is the key being checked (comparators need not be symmetric).  The result is true for equality, false otherwise.]

Chapter "Use Options"

Use a linked list vertex preallocation of at least 65536 translates as (- Constant LLLL_VERTEX_PREALLOC={N}; -).

Book "Runtime Checks"

Chapter "Environment Checks"

An environment check rule (this is the check for dynamic memory allocation to support linked lists rule):
	always check that memory allocation is supported or else say "[low-level runtime failure in]Low-Level Linked Lists[with explanation]This story uses low-level linked lists, which in turn depend on dynamic memory allocation.  But this interpreter doesn't allow dynamic memory allocation, meaning that the story cannot safely run.[terminating the story]".

Book "Transfer Registers" - unindexed

[We have some non-void phrases that need to (1) take l-values and (2) cause side-effects between the time that they compute their result and return it.  (1) means that we use I6 inlining, in which (2) gets expressed with the comma operator, as in (computeResult(),sideEffects(),result).  For this to work, however, we need a place to store the result between computeResult() and the final operand's evaluation.  We call such a place a transfer register; one is defined below.]

Include (-
	Global llll_transfer;
-) after "Definitions.i6t".

The low-level linked list transfer register is a number that varies.
The low-level linked list transfer register variable translates into I6 as "llll_transfer".

Book "Linked List Vertices"

Chapter "The Linked List Vertex Kind"

A linked list vertex is a kind of value.  The plural of linked list vertex is linked list vertices.
A linked list vertex is an invalid linked list vertex.  [See the note in the book "Extension Information."]
The specification of a linked list vertex is "Linked list vertices are the storage unit for low-level linked lists; each list entry occupies exactly one vertex.  A linked list vertex knows its key and underlying key, its value, and the linked list vertex that follows it, and can be asked for these values.  The contents---the keys and the value---can also be changed.  There are two exceptions, however: A null linked list vertex signifies the end of the list, and therefore has neither contents nor successor; it is invalid to ask for them or try to change them.  Likewise for an invalid linked list vertex, which exists only to indicate that a linked list vertex variable has not been initialized."

Section "Linked List Vertex Constants"

To decide what linked list vertex is a null linked list vertex: (- 0 -).

Section "Linked List Vertex Adjectives"

[Performance note: If warranted, this definition could be inlined.]
Definition: a linked list vertex is null if it is a null linked list vertex.

Chapter "The Linked List Vertex Structure" - unindexed

[Layout:
	4 bytes for the key
	4 bytes for the value
	4 bytes for the underlying key
	4 bytes for the link to the next entry]
[We call the two payloads ``key'' and ``value'' since that nomenclature works nicely with Low-Level Hash Tables.  By convention, if only one payload is in use, it should be the ``key.'']
[The field called ``underlying key'' is for block-value cases: often we use the hash of the block-value as the key proper, but we need someway to recover what we think of as the key.  So we store the hash as the ``key'' and the pointer as the ``underlying key.'']
[It might more organizational sense to put the key and underlying key together, but the key and value are better stored contiguously when we use @linkedsearch to look for a particular key/value pair.]
[Linked list vertices do not ordinarily manage the lifetime of their links, but we can delete everything reachable from a beginning vertex if we so choose.]

To decide what number is the size in memory of a linked list vertex: (- 16 -).

Section "Linked List Vertex Construction and Destruction" - unindexed

The linked list vertex object pool is an object pool that varies.

[Bind to the real implementation only after allocating the pool.]
Include (-
	Global llll_new=llll_newResolve;
-) after "Definitions.i6t".

Include (-
	[ llll_newByPool key value underlyingKey link result;
		result=op_poolAllocate((+ the linked list vertex object pool +));
		@astore result 0 key;
		@astore result 1 value;
		@astore result 2 underlyingKey;
		@astore result 3 link;
		return result;
	];
	[ llll_newResolve key value underlyingKey link;
		(+ the linked list vertex object pool +)=op_newPool(LLLL_VERTEX_PREALLOC,16);
		llll_new=llll_newByPool;
		return llll_newByPool(key,value,underlyingKey,link);
	];
-).
To decide what linked list vertex is a new linked list vertex with the key (K - a value) and the underlying key (U - a value) and the value (V - a value) and the link (L - a linked list vertex): (- llll_new({K},{V},{U},{L}) -).

To decide what linked list vertex is a new linked list vertex with the key (K - a value) and the link (L - a linked list vertex):
	decide on a new linked list vertex with the key K and the underlying key zero and the value zero and the link L.

To decide what linked list vertex is a new linked list vertex with the key (K - a value) and the underlying key (U - a value) and the link (L - a linked list vertex):
	decide on a new linked list vertex with the key K and the underlying key U and the value zero and the link L.

To decide what linked list vertex is a new linked list vertex with the textual key (K - some text) and the link (L - a linked list vertex):
	decide on a new linked list vertex with the key the normal hash of K and the underlying key K and the value zero and the link L.

To decide what linked list vertex is a new linked list vertex with the key (K - a value) and the value (V - a value) and the link (L - a linked list vertex):
	decide on a new linked list vertex with the key K and the underlying key zero and the value V and the link L.

To decide what linked list vertex is a new linked list vertex with the textual key (K - some text) and the value (V - a value) and the link (L - a linked list vertex):
	decide on a new linked list vertex with the key the normal hash of K and the underlying key K and the value V and the link L.

To delete (A - a linked list vertex):
	free the memory allocation at address (A converted to a number) to the linked list vertex object pool.

To delete (A - a linked list vertex) and its successors:
	let the link be the link of A;
	free the memory allocation at address (A converted to a number) to the linked list vertex object pool;
	while the link is not null:
		let the vertex be the link;
		now the link is the link of the vertex;
		free the memory allocation at address (vertex converted to a number) to the linked list vertex object pool.

Section "Private Linked List Vertex Accessors and Mutators" - unindexed

To write the link (L - a linked list vertex) to (A - a linked list vertex): (- llo_setField({A},3,{L}); -).

Section "Public Linked List Vertex Accessors and Mutators"

To decide what K is the (D - a description of values of kind K) key of (A - a linked list vertex): (- llo_getInt({A}) -).
To write the key (K - a value) to (A - a linked list vertex): (- llo_setInt({A},{K}); -).

To decide what K is the (D - a description of values of kind K) value of (A - a linked list vertex): (- llo_getField({A},1) -).
To write the value (V - a value) to (A - a linked list vertex): (- llo_setField({A},1,{V}); -).

To decide what K is the underlying (D - a description of values of kind K) key of (A - a linked list vertex): (- llo_getField({A},2) -).
To write the underlying key (U - a value) to (A - a linked list vertex): (- llo_setField({A},2,{U}); -).

To decide what linked list vertex is the link of (A - a linked list vertex): (- llo_getField({A},3) -).

Book "Linked Lists"

[Many of the public phrases expect their linked list arguments to be l-values.  Unfortunately, there's no good way to tell the I7 compiler that, so passing an r-value is likely to get us an I6 error.]

Chapter "The Linked List Kind"

A linked list is a kind of value.
A linked list is an invalid linked list.  [See the note in the book "Extension Information."]
The specification of a linked list is "A flexible-length list, much like the list kind that is built into Inform.  These linked lists differ in three notable ways: (1) They do not use Inform's block value management system, which means that they can be used safely even when that management system is in an intermediate or inconsistent state.  This, in fact, is why they were introduced.  But it also means that linked lists must be explicitly allocated and freed.  (2) They store up to three pieces of content per entry: a key, an underlying key, and a value.  See the extension documentation for the differences between these kinds of content.  (3) They support a slightly different (and slightly more error-prone) interface.  Again, consult the extension documentation for details."

Section "Linked List Constants"

To decide what linked list is an empty linked list: (- 0 -).

Section "Assignment"

To write (S - a linked list) to (D - a linked list): (- {D}={S}; -).

Section "Deep Copying"

To decide what linked list is a new copy of (L - a linked list):
	let the result be an empty linked list;
	let the result's tail be an empty linked list's tail;
	repeat with the linked list vertex running through L:
		enqueue the key the number key of the linked list vertex and the underlying key the underlying number key of the linked list vertex and the value the number value of the linked list vertex in the result through the result's tail;
	decide on the result.

To decide what linked list is a new copy of (L - a permanent linked list):
	let the result be an empty linked list;
	let the result's tail be an empty linked list's tail;
	repeat with the linked list vertex running through L:
		enqueue the key the number key of the linked list vertex and the underlying key the underlying number key of the linked list vertex and the value the number value of the linked list vertex in the result through the result's tail;
	decide on the result.

Section "Linked List Adjectives"

[Performance note: If warranted, these definitions could be inlined.]
Definition: a linked list is empty if it is zero converted to a linked list.
Definition: a linked list is unit if the link of it converted to a linked list vertex is null.

Section "Linked List Length"

To decide what number is the length of (L - a linked list):
	let the result be zero;
	repeat with a linked list vertex running through L:
		increment the result;
	decide on the result.

Section "Linked List Destruction"

To delete (A - a linked list):
	unless A is empty:
		delete A converted to a linked list vertex and its successors.

Book "Linked List Tails"

[Many of the public phrases expect their linked list tail arguments to be l-values.  Unfortunately, there's no good way to tell the I7 compiler that, so passing an r-value is likely to get us an I6 error.]

Chapter "The Linked List Tail Kind"

A linked list tail is a kind of value.
A linked list tail is an invalid linked list tail.  [See the note in the book "Extension Information."]
The specification of a linked list tail is "A linked list tail is an opaque kind (meaning that we don't get to see what's inside) whose values are used to improve the efficiency of some linked list operations, notably enqueuing and dequeuing."

Section "Linked List Tail Constants" - unindexed

To decide what linked list tail is an empty linked list's tail: (- 0 -).

Section "Linked List Tail Extraction"

Include (-
	[ llll_justBefore address link result;
		if(~~address||address==link){
			return 0;
		}
		@linkedsearch
			link ! the ``key'' to search for
			4 ! the size of the ``key'' in bytes
			address ! the address of the first structure to search
			12 ! the offset to the ``key''
			12 ! the offset to the link
			0 ! the options (no need for special options)
			result;
		return result;
	];
-).

To decide what linked list tail is the tail of (A - a linked list): (- llll_justBefore({A},0) -).

Book "Permanent Linked List Vertices"

Chapter "The Permanent Linked List Vertex Kind"

A permanent linked list vertex is a kind of value.  The plural of permanent linked list vertex is permanent linked list vertices.
A permanent linked list vertex is an invalid permanent linked list vertex.  [See the note in the book "Extension Information."]
The specification of a permanent linked list vertex is "Permanent linked list vertices are the storage unit for low-level, permanent linked lists; each list entry occupies exactly one vertex.  A permanent linked list vertex knows its key and underlying key, its value, and the linked list vertex that follows it, and can be asked for these values.  The contents---the keys and the value---can also be changed.  There are two exceptions, however: A null permanent linked list vertex signifies the end of the list, and therefore has neither contents nor successor; it is invalid to ask for them or try to change them.  Likewise for an invalid permanent linked list vertex, which exists only to indicate that a permanent linked list vertex variable has not been initialized."

Section "Permanent Linked List Vertex Constants"

To decide what permanent linked list vertex is a null permanent linked list vertex: (- 0 -).

Section "Permanent Linked List Vertex Adjectives"

[Performance note: If warranted, this definition could be inlined.]
Definition: a permanent linked list vertex is null if it is a null permanent linked list vertex.

Chapter "The Permanent Linked List Vertex Structure"

Section "Permanent Linked List Vertex Construction" - unindexed

To decide what permanent linked list vertex is a new permanent linked list vertex with the key (K - a value) and the link (L - a permanent linked list vertex):
	let the result be a permanent memory allocation of the size in memory of a linked list vertex bytes converted to a permanent linked list vertex;
	write the key K to the result;
	write the link L to the result;
	decide on the result.

To decide what permanent linked list vertex is a new permanent linked list vertex with the key (K - a value) and the underlying key (U - a value) and the link (L - a permanent linked list vertex):
	let the result be a permanent memory allocation of the size in memory of a linked list vertex bytes converted to a permanent linked list vertex;
	write the key K to the result;
	write the underlying key U to the result;
	write the link L to the result;
	decide on the result.

To decide what permanent linked list vertex is a new permanent linked list vertex with the textual key (K - some text) and the link (L - a permanent linked list vertex):
	let the result be a permanent memory allocation of the size in memory of a linked list vertex bytes converted to a permanent linked list vertex;
	write the key the normal hash of K to the result;
	write the underlying key K to the result;
	write the link L to the result;
	decide on the result.

To decide what permanent linked list vertex is a new permanent linked list vertex with the key (K - a value) and the value (V - a value) and the link (L - a permanent linked list vertex):
	let the result be a permanent memory allocation of the size in memory of a linked list vertex bytes converted to a permanent linked list vertex;
	write the key K to the result;
	write the value V to the result;
	write the link L to the result;
	decide on the result.

To decide what permanent linked list vertex is a new permanent linked list vertex with the key (K - a value) and the underlying key (U - a value) and the value (V - a value) and the link (L - a permanent linked list vertex):
	let the result be a permanent memory allocation of the size in memory of a linked list vertex bytes converted to a permanent linked list vertex;
	write the key K to the result;
	write the underlying key U to the result;
	write the value V to the result;
	write the link L to the result;
	decide on the result.

To decide what permanent linked list vertex is a new permanent linked list vertex with the textual key (K - some text) and the value (V - a value) and the link (L - a permanent linked list vertex):
	let the result be a permanent memory allocation of the size in memory of a linked list vertex bytes converted to a permanent linked list vertex;
	write the key the normal hash of K to the result;
	write the underlying key K to the result;
	write the value V to the result;
	write the link L to the result;
	decide on the result.

Section "Private Permanent Linked List Vertex Accessors and Mutators" - unindexed

To write the link (L - a permanent linked list vertex) to (A - a permanent linked list vertex): (- llo_setField({A},3,{L}); -).

Section "Public Permanent Linked List Vertex Accessors and Mutators"

To decide what K is the (D - a description of values of kind K) key of (A - a permanent linked list vertex): (- llo_getInt({A}) -).
To write the key (K - a value) to (A - a permanent linked list vertex): (- llo_setInt({A},{K}); -).

To decide what K is the (D - a description of values of kind K) value of (A - a permanent linked list vertex): (- llo_getField({A},1) -).
To write the value (V - a value) to (A - a permanent linked list vertex): (- llo_setField({A},1,{V}); -).

To decide what K is the underlying (D - a description of values of kind K) key of (A - a permanent linked list vertex): (- llo_getField({A},2) -).
To write the underlying key (U - a value) to (A - a permanent linked list vertex): (- llo_setField({A},2,{U}); -).

To decide what permanent linked list vertex is the link of (A - a permanent linked list vertex): (- llo_getField({A},3) -).

Book "Permanent Linked Lists"

[Many of the public phrases expect their permanent linked list arguments to be l-values.  Unfortunately, there's no good way to tell the I7 compiler that, so passing an r-value is likely to get us an I6 error.]

Chapter "The Permanent Linked List Kind"

A permanent linked list is a kind of value.
A permanent linked list is an invalid permanent linked list.  [See the note in the book "Extension Information."]
The specification of a permanent linked list is "A flexible-length list, much like the list kind that is built into Inform.  These linked lists differ in four notable ways: (1) They do not use Inform's block value management system, which means that they can be used safely even when that management system is in an intermediate or inconsistent state.  This, in fact, is why they were introduced.  But it also means that linked lists must be explicitly allocated.  (2) They store up to three pieces of content per entry: a key, an underlying key, and a value.  See the extension documentation for the differences between these kinds of content.  (3) They support a slightly different (and slightly more error-prone) interface.  Again, consult the extension documentation for details.  (4) Entries are 'permanent'.  We can add entries to such a list, but we can never remove them.  We cannot delete the list either.  See the kind 'linked list' for a version that does not have this restriction, though at the expense of performance under certain interpreters."

Section "Permanent Linked List Constants"

To decide what permanent linked list is an empty permanent linked list: (- 0 -).

Section "Assignment"

To write (S - a permanent linked list) to (D - a permanent linked list): (- {D}={S}; -).

Section "Deep Copying"

To decide what permanent linked list is a new permanent copy of (L - a linked list):
	let the result be an empty permanent linked list;
	let the result's tail be an empty permanent linked list's tail;
	repeat with the linked list vertex running through L:
		enqueue the key the number key of the linked list vertex and the underlying key the underlying number key of the linked list vertex and the value the number value of the linked list vertex in the result through the result's tail;
	decide on the result.

To decide what permanent linked list is a new permanent copy of (L - a permanent linked list):
	let the result be an empty permanent linked list;
	let the result's tail be an empty permanent linked list's tail;
	repeat with the linked list vertex running through L:
		enqueue the key the number key of the linked list vertex and the underlying key the underlying number key of the linked list vertex and the value the number value of the linked list vertex in the result through the result's tail;
	decide on the result.

Section "Permanent Linked List Adjectives"

[Performance note: If warranted, these definitions could be inlined.]
Definition: a permanent linked list is empty if it is zero converted to a permanent linked list.
Definition: a permanent linked list is unit if the link of it converted to a permanent linked list vertex is null.

Section "Permanent Linked List Length"

To decide what number is the length of (L - a permanent linked list):
	let the result be zero;
	repeat with a permanent linked list vertex running through L:
		increment the result;
	decide on the result.

Book "Permanent Linked List Tails"

[Many of the public phrases expect their permanent linked list tail arguments to be l-values.  Unfortunately, there's no good way to tell the I7 compiler that, so passing an r-value is likely to get us an I6 error.]

Chapter "The Permanent Linked List Tail Kind"

A permanent linked list tail is a kind of value.
A permanent linked list tail is an invalid permanent linked list tail.  [See the note in the book "Extension Information."]
The specification of a permanent linked list tail is "A permanent linked list tail is an opaque kind (meaning that we don't get to see what's inside) whose values are used to improve the efficiency of some permanent linked list operations, notably enqueuing and dequeuing."

Section "Permanent Linked List Tail Constants" - unindexed

To decide what permanent linked list tail is an empty permanent linked list's tail: (- 0 -).

Section "Permanent Linked List Tail Extraction"

To decide what permanent linked list tail is the tail of (A - a permanent linked list): (- llll_justBefore({A},0) -).

Book "Linked List Interfaces"

Chapter "Stack Interface"

Section "Linked List Transformations used by the Stack Interface" - unindexed

To decide what linked list is (A - a linked list) after pushing the key (K - a number) (this is pushing a key onto a linked list):
	let the result be a new linked list vertex with the key K and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.
To decide what linked list is (A - a linked list) after pushing the key (K - a value):
	let the result be a new linked list vertex with the key K and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.

To decide what linked list is (A - a linked list) after pushing the key (K - a number) and the underlying key (U - a number) (this is pushing a key and underlying key onto a linked list):
	let the result be a new linked list vertex with the key K and the underlying key U and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.
To decide what linked list is (A - a linked list) after pushing the key (K - a value) and the underlying key (U - a value):
	let the result be a new linked list vertex with the key K and the underlying key U and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.

To decide what linked list is (A - a linked list) after pushing the key (K - a number) and the value (V - a number) (this is pushing a key and value onto a linked list):
	let the result be a new linked list vertex with the key K and the value V and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.
To decide what linked list is (A - a linked list) after pushing the key (K - a value) and the value (V - a value):
	let the result be a new linked list vertex with the key K and the value V and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.

To decide what linked list is (A - a linked list) after pushing the key (K - a number) and the underlying key (U - a number) and the value (V - a number) (this is pushing a key and underlying key and value onto a linked list):
	let the result be a new linked list vertex with the key K and the underlying key U and the value V and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.
To decide what linked list is (A - a linked list) after pushing the key (K - a value) and the underlying key (U - a value) and the value (V - a value):
	let the result be a new linked list vertex with the key K and the underlying key U and the value V and the link A converted to a linked list vertex;
	decide on the result converted to a linked list.

To decide what linked list is (A - a linked list) after popping a linked list vertex (this is popping a linked list vertex off of a linked list):
	now the low-level linked list transfer register is A converted to a number;
	if A is empty:
		decide on an empty linked list;
	let the result be the link of A converted to a linked list vertex;
	decide on the result converted to a linked list.

To decide what linked list is (A - a linked list) after popping a key (this is popping a key off of a linked list):
	let the beginning linked list vertex be A converted to a linked list vertex;
	if the beginning linked list vertex is null:
		now the low-level linked list transfer register is zero;
		decide on an empty linked list;
	now the low-level linked list transfer register is the number key of the beginning linked list vertex;
	let the result be the link of the beginning linked list vertex converted to a linked list;
	delete the beginning linked list vertex;
	decide on the result.

To decide what linked list is (A - a linked list) after popping an underlying key (this is popping an underlying key off of a linked list):
	let the beginning linked list vertex be A converted to a linked list vertex;
	if the beginning linked list vertex is null:
		now the low-level linked list transfer register is zero;
		decide on an empty linked list;
	now the low-level linked list transfer register is the underlying number key of the beginning linked list vertex;
	let the result be the link of the beginning linked list vertex converted to a linked list;
	delete the beginning linked list vertex;
	decide on the result.

To decide what linked list is (A - a linked list) after popping a value (this is popping a value off of a linked list):
	let the beginning linked list vertex be A converted to a linked list vertex;
	if the beginning linked list vertex is null:
		now the low-level linked list transfer register is zero;
		decide on an empty linked list;
	now the low-level linked list transfer register is the number value of the beginning linked list vertex;
	let the result be the link of the beginning linked list vertex converted to a linked list;
	delete the beginning linked list vertex;
	decide on the result.

To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a number) (this is pushing a key onto a permanent linked list):
	let the result be a new permanent linked list vertex with the key K and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.
To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a value):
	let the result be a new permanent linked list vertex with the key K and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.

To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a number) and the underlying key (U - a number) (this is pushing a key and underlying key onto a permanent linked list):
	let the result be a new permanent linked list vertex with the key K and the underlying key U and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.
To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a value) and the underlying key (U - a value):
	let the result be a new permanent linked list vertex with the key K and the underlying key U and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.

To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a number) and the value (V - a number) (this is pushing a key and value onto a permanent linked list):
	let the result be a new permanent linked list vertex with the key K and the value V and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.
To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a value) and the value (V - a value):
	let the result be a new permanent linked list vertex with the key K and the value V and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.

To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a number) and the underlying key (U - a number) and the value (V - a number) (this is pushing a key and underlying key and value onto a permanent linked list):
	let the result be a new permanent linked list vertex with the key K and the underlying key U and the value V and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.
To decide what permanent linked list is (A - a permanent linked list) after pushing the key (K - a value) and the underlying key (U - a value) and the value (V - a value):
	let the result be a new permanent linked list vertex with the key K and the underlying key U and the value V and the link A converted to a permanent linked list vertex;
	decide on the result converted to a permanent linked list.

Section "Pushing"

To push the key (K - a value) onto (A - a linked list): (- {A}=(llo_getField((+ pushing a key onto a linked list +),1))({A},{K}); -).

To push the key (K - a value) and the underlying key (U - a value) onto (A - a linked list): (- {A}=(llo_getField((+ pushing a key and underlying key onto a linked list +),1))({A},{K},{U}); -).

To push the textual key (K - some text) onto (A - a linked list): (- {A}=(llo_getField((+ pushing a key and underlying key onto a linked list +),1))({A},llo_stringHash32({K}),{K}); -).

To push the key (K - a value) and the value (V - a value) onto (A - a linked list): (- {A}=(llo_getField((+ pushing a key and value onto a linked list +),1))({A},{K},{V}); -).

To push the key (K - a value) and the underlying key (U - a value) and the value (V - a value) onto (A - a linked list): (- {A}=(llo_getField((+ pushing a key and underlying key and value onto a linked list +),1))({A},{K},{U},{V}); -).

To push the textual key (K - some text) and the value (V - a value) onto (A - a linked list): (- {A}=(llo_getField((+ pushing a key and underlying key and value onto a linked list +),1))({A},llo_stringHash32({K}),{K},{V}); -).

To push the key (K - a value) onto (A - a permanent linked list): (- {A}=(llo_getField((+ pushing a key onto a permanent linked list +),1))({A},{K}); -).

To push the key (K - a value) and the underlying key (U - a value) onto (A - a permanent linked list): (- {A}=(llo_getField((+ pushing a key and underlying key onto a permanent linked list +),1))({A},{K},{U}); -).

To push the textual key (K - some text) onto (A - a permanent linked list): (- {A}=(llo_getField((+ pushing a key and underlying key onto a permanent linked list +),1))({A},llo_stringHash32({K}),{K}); -).

To push the key (K - a value) and the value (V - a value) onto (A - a permanent linked list): (- {A}=(llo_getField((+ pushing a key and value onto a permanent linked list +),1))({A},{K},{V}); -).

To push the key (K - a value) and the underlying key (U - a value) and the value (V - a value) onto (A - a permanent linked list): (- {A}=(llo_getField((+ pushing a key and underlying key and value onto a permanent linked list +),1))({A},{K},{U},{V}); -).

To push the textual key (K - some text) and the value (V - a value) onto (A - a permanent linked list): (- {A}=(llo_getField((+ pushing a key and underlying key and value onto a permanent linked list +),1))({A},llo_stringHash32({K}),{K},{V}); -).

Section "Popping"

To decide what linked list vertex is a linked list vertex popped off of (A - a linked list): (- ({A}=(llo_getField((+ popping a linked list vertex off of a linked list +),1))({A}),llll_transfer) -).

To decide what K is a/an (D - a description of values of kind K) key popped off of (A - a linked list): (- ({A}=(llo_getField((+ popping a key off of a linked list +),1))({A}),llll_transfer) -).

To decide what K is an underlying (D - a description of values of kind K) key popped off of (A - a linked list): (- ({A}=(llo_getField((+ popping an underlying key off of a linked list +),1))({A}),llll_transfer) -).

To decide what K is a/an (D - a description of values of kind K) value popped off of (A - a linked list): (- ({A}=(llo_getField((+ popping a value off of a linked list +),1))({A}),llll_transfer) -).

Chapter "Queue Interface"

Section "Linked List Transformations used by the Queue Interface" - unindexed

To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a number) (this is enqueuing a key in a linked list):
	let the new end linked list vertex be a new linked list vertex with the key K and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.
To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a value):
	let the new end linked list vertex be a new linked list vertex with the key K and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.

To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a number) and the underlying key (U - a number) (this is enqueuing a key and underlying key in a linked list):
	let the new end linked list vertex be a new linked list vertex with the key K and the underlying key U and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.
To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a value) and the underlying key (U - a value):
	let the new end linked list vertex be a new linked list vertex with the key K and the underlying key U and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.

To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a number) and the value (V - a number) (this is enqueuing a key and value in a linked list):
	let the new end linked list vertex be a new linked list vertex with the key K and the value V and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.
To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a value) and the value (V - a value):
	let the new end linked list vertex be a new linked list vertex with the key K and the value V and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.

To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a number) and the underlying key (U - a number) and the value (V - a number) (this is enqueuing a key and underlying key and value in a linked list):
	let the new end linked list vertex be a new linked list vertex with the key K and the underlying key U and the value V and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.
To decide what linked list tail is (B - a linked list tail) after enqueuing the key (K - a value) and the underlying key (U - a value) and the value (V - a value):
	let the new end linked list vertex be a new linked list vertex with the key K and the underlying key U and the value V and the link a null linked list vertex;
	let the old end linked list vertex be B converted to a linked list vertex;
	if the old end linked list vertex is not null:
		write the link new end linked list vertex to the old end linked list vertex;
	decide on the new end linked list vertex converted to a linked list tail.

To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a number) (this is enqueuing a key in a permanent linked list):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.
To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a value):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.

To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a number) and the underlying key (U - a number) (this is enqueuing a key and underlying key in a permanent linked list):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the underlying key U and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.
To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a value) and the underlying key (U - a value):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the underlying key U and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.

To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a number) and the value (V - a number) (this is enqueuing a key and value in a permanent linked list):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the value V and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.
To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a value) and the value (V - a value):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the value V and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.

To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a number) and the underlying key (U - a number) and the value (V - a number) (this is enqueuing a key and underlying key and value in a permanent linked list):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the underlying key U and the value V and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.
To decide what permanent linked list tail is (B - a permanent linked list tail) after enqueuing the key (K - a value) and the underlying key (U - a value) and the value (V - a value):
	let the new end permanent linked list vertex be a new permanent linked list vertex with the key K and the underlying key U and the value V and the link a null permanent linked list vertex;
	let the old end permanent linked list vertex be B converted to a permanent linked list vertex;
	if the old end permanent linked list vertex is not null:
		write the link new end permanent linked list vertex to the old end permanent linked list vertex;
	decide on the new end permanent linked list vertex converted to a permanent linked list tail.

Section "Enqueuing"

To enqueue the key (K - a value) in (A - a linked list) through (B - a linked list tail): (- {B}=(llo_getField((+ enqueuing a key in a linked list +),1))({B},{K});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) and the underlying key (U - a value) in (A - a linked list) through (B - a linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key in a linked list +),1))({B},{K},{U});if(~~{A}) {A}={B}; -).

To enqueue the textual key (K - some text) in (A - a linked list) through (B - a linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key in a linked list +),1))({B},llo_stringHash32({K}),{K});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) and the value (V - a value) in (A - a linked list) through (B - a linked list tail): (- {B}=(llo_getField((+ enqueuing a key and value in a linked list +),1))({B},{K},{V});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (A - a linked list) through (B - a linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key and value in a linked list +),1))({B},{K},{U},{V});if(~~{A}) {A}={B}; -).

To enqueue the textual key (K - some text) and the value (V - a value) in (A - a linked list) through (B - a linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key and value in a linked list +),1))({B},llo_stringHash32({K}),{K},{V});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) in (A - a permanent linked list) through (B - a permanent linked list tail): (- {B}=(llo_getField((+ enqueuing a key in a permanent linked list +),1))({B},{K});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) and the underlying key (U - a value) in (A - a permanent linked list) through (B - a permanent linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key in a permanent linked list +),1))({B},{K},{U});if(~~{A}) {A}={B}; -).

To enqueue the textual key (K - some text) in (A - a permanent linked list) through (B - a permanent linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key in a permanent linked list +),1))({B},llo_stringHash32({K}),{K});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) and the value (V - a value) in (A - a permanent linked list) through (B - a permanent linked list tail): (- {B}=(llo_getField((+ enqueuing a key and value in a permanent linked list +),1))({B},{K},{V});if(~~{A}) {A}={B}; -).

To enqueue the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (A - a permanent linked list) through (B - a permanent linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key and value in a permanent linked list +),1))({B},{K},{U},{V});if(~~{A}) {A}={B}; -).

To enqueue the textual key (K - some text) and the value (V - a value) in (A - a permanent linked list) through (B - a permanent linked list tail): (- {B}=(llo_getField((+ enqueuing a key and underlying key and value in a permanent linked list +),1))({B},llo_stringHash32({K}),{K},{V});if(~~{A}) {A}={B}; -).

Section "Dequeuing"

To decide what linked list vertex is a linked list vertex dequeued from (A - a linked list) through (B - a linked list tail): (- ({A}=(llo_getField((+ popping a linked list vertex off of a linked list +),1))({A}),{A}||({B}=0),llll_transfer) -).

To decide what K is a/an (D - a description of values of kind K) key dequeued from (A - a linked list) through (B - a linked list tail): (- ({A}=(llo_getField((+ popping a key off of a linked list +),1))({A}),{A}||({B}=0),llll_transfer) -).

To decide what K is an underlying (D - a description of values of kind K) key dequeued from (A - a linked list) through (B - a linked list tail): (- ({A}=(llo_getField((+ popping an underlying key off of a linked list +),1))({A}),{A}||({B}=0),llll_transfer) -).

To decide what K is a/an (D - a description of values of kind K) value dequeued from (A - a linked list) through (B - a linked list tail): (- ({A}=(llo_getField((+ popping a value off of a linked list +),1))({A}),{A}||({B}=0),llll_transfer) -).

Chapter "Search Interface"

Section "Linked List Traversals used by the Search Interface" - unindexed

Include (-
	[ llll_atOrAfter key address result;
		if(~~address){
			return 0;
		}
		@linkedsearch
			key ! the key to search for
			4 ! the size of the key in bytes
			address ! the address of the first structure to search
			0 ! the offset to the key
			12 ! the offset to the link
			0 ! the options (no need for special options)
			result;
		return result;
	];
	Array llll_keyValuePair --> 0 0;
	[ llll_atOrAfterWithValue key value address result;
		if(~~address){
			return 0;
		}
		llo_setInt(llll_keyValuePair,key);
		llo_setField(llll_keyValuePair,1,value);
		@linkedsearch
			llll_keyValuePair ! the address of the key to search for
			8 ! the size of the key in bytes
			address ! the address of the first structure to search
			0 ! the offset to the key
			12 ! the offset to the link
			1 ! the options (the key is given as an address)
			result;
		return result;
	];
	[ llll_atOrAfterWithUnderlying key underlyingKey address comparator result;
		comparator=llo_getField(comparator,1);
		for(result=llll_atOrAfter(key,address):result:result=llll_atOrAfter(key,llo_getField(result,3))){
			if(comparator(underlyingKey,llo_getField(result,2))){
				break;
			}
		}
		return result;
	];
	[ llll_atOrAfterSynthetic key underlyingKey address comparator result;
		comparator=llo_getField((+ testing equality between synthetic text and text +),1);
		for(result=llll_atOrAfter(key,address):result:result=llll_atOrAfter(key,llo_getField(result,3))){
			if(comparator(underlyingKey,llo_getField(result,2))){
				break;
			}
		}
		return result;
	];
	[ llll_atOrAfterWithBoth key underlyingKey value address comparator result;
		comparator=llo_getField(comparator,1);
		for(result=llll_atOrAfterWithValue(key,value,address):result:result=llll_atOrAfterWithValue(key,value,llo_getField(result,3))){
			if(comparator(underlyingKey,llo_getField(result,2))){
				break;
			}
		}
		return result;
	];
-).

Section "Searching by Key"

To decide what linked list vertex is the first match for the key (K - a value) in (A - a linked list): (- llll_atOrAfter({K},{A}) -).

To decide what linked list vertex is the first match for the key (K - a value) at or after (A - a linked list vertex): (- llll_atOrAfter({K},{A}) -).

To decide what linked list vertex is the first match for the key (K - a value) after (A - a linked list vertex):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the key K at or after the link of A.

To decide what permanent linked list vertex is the first match for the key (K - a value) in (A - a permanent linked list): (- llll_atOrAfter({K},{A}) -).

To decide what permanent linked list vertex is the first match for the key (K - a value) at or after (A - a permanent linked list vertex): (- llll_atOrAfter({K},{A}) -).

To decide what permanent linked list vertex is the first match for the key (K - a value) after (A - a permanent linked list vertex):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the key K at or after the link of A.

Section "Searching by Underlying Key"

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) in (A - a linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithUnderlying({K},{U},{A},{P}) -).

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) in (A - a linked list): (- llll_atOrAfterSynthetic(llo_stringHash32({K}),{K},{A}) -).

To decide what linked list vertex is the first match for the textual key (K - some text) in (A - a linked list):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key in A;
	delete the synthetic text key;
	decide on the result.

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) at or after (A - a linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithUnderlying({K},{U},{A},{P}) -).

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) at or after (A - a linked list vertex): (- llll_atOrAfterSynthetic(llo_stringHash32({K}),{K},{A}) -).

To decide what linked list vertex is the first match for the textual key (K - some text) at or after (A - a linked list vertex):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key at or after A;
	delete the synthetic text key;
	decide on the result.

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) after (A - a linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the key K and the underlying key U at or after the link of A with the comparator P.

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) after (A - a linked list vertex):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the synthetic textual key K at or after the link of A.

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) after (A - a linked list vertex):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the textual key K at or after the link of A.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) in (A - a permanent linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithUnderlying({K},{U},{A},{P}) -).

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) in (A - a permanent linked list): (- llll_atOrAfterSynthetic(llo_stringHash32({K}),{K},{A}) -).

To decide what permanent linked list vertex is the first match for the textual key (K - some text) in (A - a permanent linked list):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key in A;
	delete the synthetic text key;
	decide on the result.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) at or after (A - a permanent linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithUnderlying({K},{U},{A},{P}) -).

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) at or after (A - a permanent linked list vertex): (- llll_atOrAfterSynthetic(llo_stringHash32({K}),{K},{A}) -).

To decide what permanent linked list vertex is the first match for the textual key (K - some text) at or after (A - a permanent linked list vertex):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key at or after A;
	delete the synthetic text key;
	decide on the result.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) after (A - a permanent linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the key K and the underlying key U at or after the link of A with the comparator P.

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) after (A - a permanent linked list vertex):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the synthetic textual key K at or after the link of A.

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) after (A - a permanent linked list vertex):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the textual key K at or after the link of A.

Section "Searching by Key and Value"

To decide what linked list vertex is the first match for the key (K - a value) and the value (V - a value) in (A - a linked list): (- llll_atOrAfterWithValue({K},{V},{A}) -).

To decide what linked list vertex is the first match for the key (K - a value) and the value (V - a value) at or after (A - a linked list vertex): (- llll_atOrAfterWithValue({K},{V},{A}) -).

To decide what linked list vertex is the first match for the key (K - a value) and the value (V - a value) after (A - a linked list vertex):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the key K and the value V at or after the link of A.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the value (V - a value) in (A - a permanent linked list): (- llll_atOrAfterWithValue({K},{V},{A}) -).

To decide what permanent linked list vertex is the first match for the key (K - a value) and the value (V - a value) at or after (A - a permanent linked list vertex): (- llll_atOrAfterWithValue({K},{V},{A}) -).

To decide what permanent linked list vertex is the first match for the key (K - a value) and the value (V - a value) after (A - a permanent linked list vertex):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the key K and the value V at or after the link of A.

Section "Searching by Underlying Key and Value"

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (A - a linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithBoth({K},{U},{V},{A},{P}) -).

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) in (A - a linked list): (- llll_atOrAfterWithBoth(llo_stringHash32({K}),{K},{V},{A},(+ testing equality between synthetic text and text +)) -).

To decide what linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) in (A - a linked list):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key and the value V in A;
	delete the synthetic text key;
	decide on the result.

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) at or after (A - a linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithBoth({K},{U},{V},{A},{P}) -).

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) at or after (A - a linked list vertex): (- llll_atOrAfterWithBoth(llo_stringHash32({K}),{K},{V},{A},(+ testing equality between synthetic text and text +)) -).

To decide what linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) at or after (A - a linked list vertex):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key and the value V at or after A;
	delete the synthetic text key;
	decide on the result.

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) after (A - a linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the key K and the underlying key U and the value V at or after the link of A with the comparator P.

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) after (A - a linked list vertex):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the synthetic textual key K and the value V at or after the link of A with the comparator P.

To decide what linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) after (A - a linked list vertex):
	if A is null:
		decide on a null linked list vertex;
	decide on the first match for the textual key K and the value V at or after the link of A with the comparator P.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (A - a permanent linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithBoth({K},{U},{V},{A},{P}) -).

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) in (A - a permanent linked list): (- llll_atOrAfterWithBoth(llo_stringHash32({K}),{K},{V},{A},(+ testing equality between synthetic text and text +)) -).

To decide what permanent linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) in (A - a permanent linked list):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key and the value V in A;
	delete the synthetic text key;
	decide on the result.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) at or after (A - a permanent linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- llll_atOrAfterWithBoth({K},{U},{V},{A},{P}) -).

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) at or after (A - a permanent linked list vertex): (- llll_atOrAfterWithBoth(llo_stringHash32({K}),{K},{V},{A},(+ testing equality between synthetic text and text +)) -).

To decide what permanent linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) at or after (A - a permanent linked list vertex):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key and the value V at or after A;
	delete the synthetic text key;
	decide on the result.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) after (A - a permanent linked list vertex) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the key K and the underlying key U and the value V at or after the link of A with the comparator P.

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) after (A - a permanent linked list vertex):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the synthetic textual key K and the value V at or after the link of A with the comparator P.

To decide what permanent linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) after (A - a permanent linked list vertex):
	if A is null:
		decide on a null permanent linked list vertex;
	decide on the first match for the textual key K and the value V at or after the link of A with the comparator P.

Chapter "Map Interface"

Section "Linked List Traversals used by the Map Interface" - unindexed

To decide what linked list vertex is the linked list vertex just before (B - a linked list vertex) in (A - a linked list): (- llll_justBefore({A},{B}) -).

To decide what permanent linked list vertex is the permanent linked list vertex just before (B - a permanent linked list vertex) in (A - a permanent linked list): (- llll_justBefore({A},{B}) -).

Section "Linked List Transformations used by the Map Interface" - unindexed

To decide what linked list is (A - a linked list) after removing (B - a linked list vertex) (this is removing a vertex from a linked list):
	if B is null:
		decide on A;
	let the predecessor linked list vertex be the linked list vertex just before B in A;
	let the successor linked list vertex be the link of B;
	delete B;
	if the predecessor linked list vertex is null:
		decide on the successor linked list vertex converted to a linked list;
	write the link successor linked list vertex to the predecessor linked list vertex;
	decide on A.

Section "Map Operations by Key"

To decide whether (A - a linked list) contains the key (K - a value):
	decide on whether or not the first match for the key K in A is not null.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) in (A - a linked list) or (V - a K) if there are no matches:
	let the linked list vertex be the first match for the key K in A;
	if the linked list vertex is null:
		decide on V;
	decide on the D value of the linked list vertex.

To remove the first occurrence of the key (K - a value) from (A - a linked list): (- {A}=(llo_getField((+ removing a vertex from a linked list +),1))({A},llll_atOrAfter({K},{A})); -).

To decide whether (A - a permanent linked list) contains the key (K - a value):
	decide on whether or not the first match for the key K in A is not null.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) in (A - a permanent linked list) or (V - a K) if there are no matches:
	let the permanent linked list vertex be the first match for the key K in A;
	if the permanent linked list vertex is null:
		decide on V;
	decide on the D value of the permanent linked list vertex.

Section "Map Operations by Underlying Key"

To decide whether (A - a linked list) contains the key (K - a value) and the underlying key (U - a value) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U in A with the comparator P is not null.

To decide whether (A - a linked list) contains the synthetic textual key (K - some text):
	decide on whether or not the first match for the synthetic textual key K in A is not null.

To decide whether (A - a linked list) contains the textual key (K - some text):
	decide on whether or not the first match for the textual key K in A is not null.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) and the underlying key (U - a value) in (A - a linked list) with the comparator (P - a phrase (value of kind L,L) -> nothing) or (V - a K) if there are no matches:
	let the linked list vertex be the first match for the key K and the underlying key U in A with the comparator P;
	if the linked list vertex is null:
		decide on V;
	decide on the D value of the linked list vertex.

To decide what K is the first (D - a description of values of kind K) value matching the synthetic textual key (K - some text) in (A - a linked list) or (V - a K) if there are no matches:
	let the linked list vertex be the first match for the synthetic textual key K in A with the comparator P;
	if the linked list vertex is null:
		decide on V;
	decide on the D value of the linked list vertex.

To decide what K is the first (D - a description of values of kind K) value matching the textual key (K - some text) in (A - a linked list) or (V - a K) if there are no matches:
	let the linked list vertex be the first match for the textual key K in A with the comparator P;
	if the linked list vertex is null:
		decide on V;
	decide on the D value of the linked list vertex.

To remove the first occurrence of the key (K - a value) and the underlying key (U - a value) from (A - a linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- {A}=(llo_getField((+ removing a vertex from a linked list +),1))({A},llll_atOrAfterWithUnderlying({K},{U},{A},{P})); -).

To remove the first occurrence of the synthetic textual key (K - some text) from (A - a linked list): (- {A}=(llo_getField((+ removing a vertex from a linked list +),1))({A},llll_atOrAfterSynthetic(llo_stringHash32({K}),{K},{A})); -).

To remove the first occurrence of the textual key (K - some text) from (A - a linked list):
	let the key be a new synthetic text copied from K;
	remove the first occurrence of the synthetic textual key key from A;
	delete the synthetic text key.

To decide whether (A - a permanent linked list) contains the key (K - a value) and the underlying key (U - a value) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U in A with the comparator P is not null.

To decide whether (A - a permanent linked list) contains the synthetic textual key (K - some text):
	decide on whether or not the first match for the synthetic textual key K in A is not null.

To decide whether (A - a permanent linked list) contains the textual key (K - some text):
	decide on whether or not the first match for the textual key K in A is not null.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) and the underlying key (U - a value) in (A - a permanent linked list) with the comparator (P - a phrase (value of kind L,L) -> nothing) or (V - a K) if there are no matches:
	let the permanent linked list vertex be the first match for the key K and the underlying key U in A with the comparator P;
	if the permanent linked list vertex is null:
		decide on V;
	decide on the D value of the permanent linked list vertex.

To decide what K is the first (D - a description of values of kind K) value matching the synthetic textual key (K - some text) in (A - a permanent linked list) or (V - a K) if there are no matches:
	let the permanent linked list vertex be the first match for the synthetic textual key K in A with the comparator P;
	if the permanent linked list vertex is null:
		decide on V;
	decide on the D value of the permanent linked list vertex.

To decide what K is the first (D - a description of values of kind K) value matching the textual key (K - some text) in (A - a permanent linked list) or (V - a K) if there are no matches:
	let the permanent linked list vertex be the first match for the textual key K in A with the comparator P;
	if the permanent linked list vertex is null:
		decide on V;
	decide on the D value of the permanent linked list vertex.

Section "Map Operations by Key/Value Pairs"

To decide whether (A - a linked list) contains the key (K - a value) and the value (V - a value):
	decide on whether or not the first match for the key K and the value V in A is not null.

To remove the first occurrence of the key (K - a value) and the value (V - a value) from (A - a linked list): (- {A}=(llo_getField((+ removing a vertex from a linked list +),1))({A},llll_atOrAfterWithValue({K},{V},{A})); -).

To decide whether (A - a permanent linked list) contains the key (K - a value) and the value (V - a value):
	decide on whether or not the first match for the key K and the value V in A is not null.

Section "Map Operations by Underlying Key/Value Pairs"

To decide whether (A - a linked list) contains the key (K - a value) and the underlying key (U - a value) and the value (V - a value) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U and the value V in A with the comparator P is not null.

To decide whether (A - a linked list) contains the synthetic textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the synthetic textual key K and the value V in A is not null.

To decide whether (A - a linked list) contains the textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the textual key K and the value V in A is not null.

To remove the first occurrence of the key (K - a value) and the underlying key (U - a value) and the value (V - a value) from (A - a linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing): (- {A}=(llo_getField((+ removing a vertex from a linked list +),1))({A},llll_atOrAfterWithBoth({K},{U},{V},{A},{P})); -).

To remove the first occurrence of the synthetic textual key (K - some text) and the value (V - a value) from (A - a linked list): (- {A}=(llo_getField((+ removing a vertex from a linked list +),1))({A},llll_atOrAfterWithBoth(llo_stringHash32({K}),{K},{V},{A},(+ testing equality between synthetic text and text +))); -).

To remove the first occurrence of the textual key (K - some text) and the value (V - a value) from (A - a linked list):
	let the key be a new synthetic text copied from K;
	remove the first occurrence of the synthetic textual key key and the value V from A;
	delete the synthetic text key.

To decide whether (A - a permanent linked list) contains the key (K - a value) and the underlying key (U - a value) and the value (V - a value) with the comparator (P - a phrase (value of kind K,K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U and the value V in A with the comparator P is not null.

To decide whether (A - a permanent linked list) contains the synthetic textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the synthetic textual key K and the value V in A is not null.

To decide whether (A - a permanent linked list) contains the textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the textual key K and the value V in A is not null.

Chapter "Iteration Interface"

Section "Iterator Variables used by the Iteration Interface" - unindexed

Include (-
	Global llll_iterator;
	Global llll_hash;
	Global llll_syntheticCopy;
-) after "Definitions.i6t".

Section "Unfiltered Repetition"

To repeat with (I - a nonexisting linked list vertex variable) running through (A - a linked list) begin -- end: (-
	for({I}={A}:{I}:{I}=llo_getField({I},3))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) keys of (A - a linked list) begin -- end: (-
	llll_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 0 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the underlying (D - a description of values of kind K) keys of (A - a linked list) begin -- end: (-
	llll_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 2 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values of (A - a linked list) begin -- end: (-
	llll_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through (A - a permanent linked list) begin -- end: (-
	for({I}={A}:{I}:{I}=llo_getField({I},3))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) keys of (A - a permanent linked list) begin -- end: (-
	llll_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 0 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the underlying (D - a description of values of kind K) keys of (A - a permanent linked list) begin -- end: (-
	llll_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 2 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values of (A - a permanent linked list) begin -- end: (-
	llll_iterator={A};
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Section "Repetition Filtered by Key"

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the key (K - a value) in (A - a linked list) begin -- end: (-
	for({I}=llll_atOrAfter({K},{A}):{I}:{I}=llll_atOrAfter({K},llo_getField({I},3)))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) in (A - a linked list) begin -- end: (-
	llll_iterator=llll_atOrAfter({K},{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfter({K},llll_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the key (K - a value) in (A - a permanent linked list) begin -- end: (-
	for({I}=llll_atOrAfter({K},{A}):{I}:{I}=llll_atOrAfter({K},llo_getField({I},3)))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) in (A - a permanent linked list) begin -- end: (-
	llll_iterator=llll_atOrAfter({K},{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfter({K},llll_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Section "Repetition Filtered by Underlying Key"

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the key (K - a value) and the underlying key (U - a value) in (A - a linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing) begin -- end: (-
	for({I}=llll_atOrAfterWithUnderlying({K},{U},{A},{P}):{I}:{I}=llll_atOrAfterWithUnderlying({K},{U},llo_getField({I},3),{P}))
-).

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the synthetic textual key (K - some text) in (A - a linked list) begin -- end: (-
	llll_hash=llo_stringHash32({K});
	{I}=llll_atOrAfterSynthetic(llll_hash,{K},{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_hash;
			if(llo_broken){
				break;
			}
			@aload {I} 3 {I};
			{I}=llll_atOrAfterSynthetic(llll_hash,{K},{I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~{I}){
				llo_broken=true;
				break;
			}
			@push llll_hash;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the textual key (K - some text) in (A - a linked list) begin -- end: (-
	llll_syntheticCopy=(llo_getField((+ copying text to synthetic text +),1))({K});
	llll_hash=llo_stringHash32(llll_syntheticCopy);
	{I}=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_hash;
			@pull llll_syntheticCopy;
			if(llo_broken){
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@aload {I} 3 {I};
			{I}=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,{I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~{I}){
				llo_broken=true;
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@push llll_syntheticCopy;
			@push llll_hash;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) and the underlying key (U - a value) in (A - a linked list) with the comparator (P - a phrase (value of kind L,L) -> nothing) begin -- end: (-
	llll_iterator=llll_atOrAfterWithUnderlying({K},{U},{A},{P});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfterWithUnderlying({K},{U},llll_iterator,{P});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the synthetic textual key (K - some text) in (A - a linked list) begin -- end: (-
	llll_hash=llo_stringHash32({K});
	llll_iterator=llll_atOrAfterSynthetic(llll_hash,{K},{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			@pull llll_hash;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfterSynthetic(llll_hash,{K},llll_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_hash;
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the textual key (K - some text) in (A - a linked list) begin -- end: (-
	llll_syntheticCopy=(llo_getField((+ copying text to synthetic text +),1))({K});
	llll_hash=llo_stringHash32(llll_syntheticCopy);
	llll_iterator=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			@pull llll_hash;
			@pull llll_syntheticCopy;
			if(llo_broken){
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,llll_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@push llll_syntheticCopy;
			@push llll_hash;
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the key (K - a value) and the underlying key (U - a value) in (A - a permanent linked list) with the comparator (P - a phrase (value of kind K,K) -> nothing) begin -- end: (-
	for({I}=llll_atOrAfterWithUnderlying({K},{U},{A},{P}):{I}:{I}=llll_atOrAfterWithUnderlying({K},{U},llo_getField({I},3),{P}))
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the synthetic textual key (K - some text) in (A - a permanent linked list) begin -- end: (-
	llll_hash=llo_stringHash32({K});
	{I}=llll_atOrAfterSynthetic(llll_hash,{K},{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_hash;
			if(llo_broken){
				break;
			}
			@aload {I} 3 {I};
			{I}=llll_atOrAfterSynthetic(llll_hash,{K},{I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~{I}){
				llo_broken=true;
				break;
			}
			@push llll_hash;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the textual key (K - some text) in (A - a permanent linked list) begin -- end: (-
	llll_syntheticCopy=(llo_getField((+ copying text to synthetic text +),1))({K});
	llll_hash=llo_stringHash32(llll_syntheticCopy);
	{I}=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_hash;
			@pull llll_syntheticCopy;
			if(llo_broken){
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@aload {I} 3 {I};
			{I}=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,{I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~{I}){
				llo_broken=true;
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@push llll_syntheticCopy;
			@push llll_hash;
			llo_advance=false;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) and the underlying key (U - a value) in (A - a permanent linked list) with the comparator (P - a phrase (value of kind L,L) -> nothing) begin -- end: (-
	llll_iterator=llll_atOrAfterWithUnderlying({K},{U},{A},{P});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfterWithUnderlying({K},{U},llll_iterator,{P});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the synthetic textual key (K - some text) in (A - a permanent linked list) begin -- end: (-
	llll_hash=llo_stringHash32({K});
	llll_iterator=llll_atOrAfterSynthetic(llll_hash,{K},{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			@pull llll_hash;
			if(llo_broken){
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfterSynthetic(llll_hash,{K},llll_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				break;
			}
			@push llll_hash;
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the textual key (K - some text) in (A - a permanent linked list) begin -- end: (-
	llll_syntheticCopy=(llo_getField((+ copying text to synthetic text +),1))({K});
	llll_hash=llo_stringHash32(llll_syntheticCopy);
	llll_iterator=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,{A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull llll_iterator;
			@pull llll_hash;
			@pull llll_syntheticCopy;
			if(llo_broken){
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@aload llll_iterator 3 llll_iterator;
			llll_iterator=llll_atOrAfterSynthetic(llll_hash,llll_syntheticCopy,llll_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if(~~llll_iterator){
				llo_broken=true;
				(llo_getField((+ deleting synthetic text +),1))(llll_syntheticCopy);
				break;
			}
			@push llll_syntheticCopy;
			@push llll_hash;
			@push llll_iterator;
			llo_advance=false;
			@aload llll_iterator 1 {I};
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Chapter "Filter Interface"

Section "Implementation the Filter Interface" - unindexed

To decide what linked list is (A - a linked list) after filtering it with (F - a phrase linked list vertex -> nothing) (this is filtering a linked list):
	let the first linked list vertex be A converted to a linked list vertex;
	let the previous linked list vertex be a null linked list vertex;
	let the linked list vertex be the first linked list vertex;
	while the linked list vertex is not null:
		let the next linked list vertex be the link of the linked list vertex;
		if F applied to the linked list vertex:
			now the previous linked list vertex is the linked list vertex;
		otherwise:
			if the previous linked list vertex is null:
				now the first linked list vertex is the next linked list vertex;
			otherwise:
				write the link the next linked list vertex to the previous linked list vertex;
			delete the linked list vertex;
		now the linked list vertex is the next linked list vertex;
	decide on the first linked list vertex converted to a linked list.

Section "Filtration"

To filter (A - a linked list) by (F - a phrase linked list vertex -> nothing): (- {A}=(llo_getField((+ filtering a linked list +),1))({A},{F}); -).

Low-Level Linked Lists ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

When we write instrumentation code for use with the Glulx Runtime
Instrumentation Framework or a library that supports such code, we must consider
the possibility that the instrumentation will be called from within Inform's
block value management system.  The block value management routines are not
reentrant, so in such a case we cannot safely use Inform's lists; we must turn
to another data structure.  Low-Level Linked Lists contains a replacement list
implementation that, while less elegant, is a safe alternative even in these
extreme scenarios.

Details are in the following chapters.

Chapter: Usage

Normally we have Inform's lists for expressing a set or sequence of concepts.
But when we write instrumenting rules for the Glulx Runtime Instrumentation
Framework, lists are forbidden because they might involve Inform's block value
management system.  Low-Level Linked Lists is a modest substitution.

The adjectives "low-level" and "modest" are important: these lists open up
opportunities for subtle and hard-to-debug errors.  Unless we have a compelling
reason, like the fact that we're writing instrumentation code, we will be better
off with the safer implementations provided by the Inform language.

Section: Some words of caution

Lest the warning above be taken lightly, we should mention several risks
associated with low-level linked lists up front.

First, many of the phrases in Low-Level Linked Lists expect to operate on
variables, either a global value that varies or a temporary named value, and not
on the result of some computation.  For instance, we can write

	let the demonstration list be an empty linked list;
	push the key four onto the demonstration list;

but not

	push the key four onto an empty linked list;

or

	To decide what linked list is foo:
		decide on an empty linked list.

and then

	push the key four onto foo;

Unfortunately, at least in the current version of Inform, the phrase
declarations cannot be written in a way that makes the Inform 7 compiler catch
such mistakes unless we (1) give up some type safety, and (2) bring in
undocumented syntax that stands a good chance of changing in future versions.
Neither seems advisable.  Instead, if a computed value is used where a variable
is wanted, we can expect errors from the Inform 6 compiler, which we will then
have to manually trace back to the source text.

There are what seem to be exceptions to this rule.  For instance, if we include
the Glulx Runtime Instrumentation Framework (GRIF), this code is legal

	let the demonstration vertex be an instruction vertex;
	...
	push the key four onto the jump predecessor linked list of the demonstration vertex;

despite the invocation of the GRIF phrase "the jump predecessor linked list of
(A - an instruction vertex)".  This is because the phrase is actually an I6
macro, and I6 macros can, in a limited way, decide on variables as well as
values.

Another caveat is that linked lists use a mechanism called shallow copying of
head pointers, which is good for performance but imposes some extra burdens on
the programmer.  The upshot is that if we add or remove entries from one copy of
a linked list---or delete it---we must consider all other copies to be
invalidated.  Subsequently uses of those copies might work, but they might also
give the wrong results, or crash the story, or corrupt memory and cause bugs
down the line in seemingly unrelated code.  For example,

	let the demonstration vertex be an instruction vertex;
	let the demonstration list be the jump predecessor linked list of the demonstration vertex;
	push the key four onto the demonstration list;

copies the jump predecessor linked list to the demonstration list and then adds
an entry to the demonstration list.  The jump predecessor linked list is
consequently rendered invalid, which is bad because we will probably need to use
it in the future.  We could either add the line

	write the demonstration list to the jump predecessor linked list of the demonstration vertex;

to copy the valid list back to the demonstration vertex (the phrase

	write (L - a linked list) to (K - a linked list)

is provided because neither "let" nor "now" can assign to variable decided on by
an I6 macro), or simply

	push the key four onto the jump predecessor linked list of the demonstration vertex;

Most of the time it is wisest to take the latter approach and not copy linked
lists in the first place.

And finally, there is a bug in the Inform 6 compilers that ship with early
Inform versions (at least the versions up through 6G60, and possibly others)
such that the popping and dequeuing phrases are sometimes miscompiled when used
inside of other phrases.  Lines like

	seed the random-number generator with a number key popped off of the demonstration list;

for instance, could do all manner of unexpected things.  Instead, we should
write the source text with a temporary named value:

	let the popped number be a number key popped off of the demonstration list;
	seed the random-number generator with the popped number;

Section: An overview of the kinds

Low-Level Linked Lists stores lists as values of the kind "linked list".  The
default value of this kind is

	an invalid linked list

to mark variables that have not been initialized.  To create a new list, we
write

	let (L - a name not so far used) be an empty linked list

or

	now (L - a linked list variable) is an empty linked list

or, if we want to make a copy without the invalidation caveats given above, we
can replace

	an empty linked list

with

	a new copy of (L - a linked list)

When we are done with a linked list (and any copies) we should invoke the phrase

	delete (L - a linked list)

so that the virtual machine can reclaim the list's memory.  As noted in the
previous section, any copies of L not made by the copy phrase will be
invalidated by this change; there is no need to delete them, and, in fact, it
would be dangerous to try.

Each entry in a linked list is represented by a "linked list vertex".  Again,
the default value for this kind is an invalid instance:

	an invalid linked list vertex

The end of a linked list is also denoted by a special vertex, which contains no
data:

	a null linked list vertex

Though we cannot create vertices directly, we are responsible for deleting them
if we detach them from their list.  For instance, in

	let foo be a linked list vertex popped off of the demonstration list;

foo is either null or a vertex disconnected from the demonstration list.  If the
latter, it must be given to the phrase

	delete (L - a linked list vertex)

as in

	delete foo;

when we are done with it.  Invalid or null linked list vertices should not be
deleted.

In addition to linked lists and linked list vertices, there is another kind,
"linked list tail", that holds auxiliary information to make some phrases in
Low-Level Linked Lists run faster.  Tails, other than

	the invalid linked list tail

are obtained via the phrase

	the tail of (L - a linked list)

All of the caveats in the previous section that applied to linked lists also
apply to tails: most phrases expect to be given a variable, not a computed
value, and changing one copy of a tail invalidates the others.  A further
restriction also comes into play: if we change a linked list without mentioning
its tail, we invalidate any tails for that list.  Code like

	let the demonstration tail be the tail of the demonstration list;
	enqueue the key four in the demonstration list through the demonstration tail;
	enqueue the key four in the demonstration list through the demonstration tail;

is okay, because the intermediate change mentions the tail, but code like

	let the demonstration tail be the tail of the demonstration list;
	push the key four onto the demonstration list;
	enqueue the key four in the demonstration list through the demonstration tail;

is invalid: the third line uses a tail that the second line has rendered
useless.  We can crash the story with such code.

The onus is also on us to keep tails matched with their lists.  Giving a phrase
a mismatched tail will, in the best case, cause some memory to become forever
unusable.  In more typical cases such transgressions lead to delayed crashes.

Lastly, all three of these kinds have permanent versions:

	a permanent linked list

	a permanent linked list vertex

	a permanent linked list tail

Phrases for the permanent kinds run faster under some interpreters, but they
are, as the name suggests, indestructible.  If we create a permanent linked
list, we must keep it around forever.  If we add a vertex to a permanent linked
list, we can change the entry, but we can never get rid of it.

Most operations on permanent kinds are worded the same as the corresponding
operations on the temporary kinds.  The creation and copying phrases, however
are exceptions.  For an empty but permanent list, we use the wording

	an empty permanent linked list

and similarly include the word "permanent" when preparing permanent copies:

	a new permanent copy of (L - a linked list)

	a new permanent copy of (L - a permanent linked list)

Section: Manipulating linked list vertices

Linked list vertices, unlike entries in Inform's built-in lists, can store up to
three data at a time.  In the most ordinary of circumstances we only use one of
these storage locations, the "key", according to terminology borrowed from
computer science.  A key can be accessed with the phrase

	the (D - a kind) key of (X - a linked list vertex)

and altered with the phrase

	write the key (K - a value) to (X - a linked list vertex)

(Note that in the first case we must specify the kind of the key: low-level
linked lists currently carry no information about their contents' kinds.)

Keys are normally only useful for kinds where distinct values are guaranteed to
be unequal.  There is no way to equate seven and four, for instance, so numbers
can be used as keys.  Likewise with text because, at least in ordinary
situations, a text like "foo" is unalterable and cannot be made into "bar".  But
if we were to include the extension Low-Level Text, then we could alter the
characters inside of synthetic text, and such text would not be suitable.

If we have a value that is unsuitable as a key, we instead store it as an
"underlying key", via the following phrases:

	the underlying (D - a kind) key of (X - a linked list vertex)

	write the underlying key (U - a value) to (X - a linked list vertex)

We are then responsible for setting the key to a numeric summary of the
underlying key's value.  The idea is that values with different summaries must
be unequal, and only in the case that two summaries match do we have to carry
out a full equality check.  It is always safe---though not necessarily
efficient---to give every value the same summary.

The third datum is called the "value", and is used if we want to store extra
information associated with a key.  The relevant phrases follow the pattern
established above:

	the (D - a kind) value of (X - a linked list vertex)

and

	write the value (V - a value) to (X - a linked list vertex)

It is also possible to ask a vertex for the vertex that follows it, provided
that a vertex does in fact follow it:

	the link of (X - a linked list vertex)

Should we ask for the link of an invalid vertex, a null vertex, or a detached
vertex, the answer that we get back will be meaningless and liable to crash the
story if used.

All of the phrase from this section can be used in the same way with permanent
linked list vertices.

Section: The stack interface

In computer science parlance a stack is sequence of data that can only be
manipulated from one end, the "top" of the stack.  We can represent such a
sequence with a linked list, using the beginning of the list as the top.
(Unlike with Inform's lists, with low-level linked lists this arrangement is
faster than putting the stack's top at the end.)

There are two operations available for a stack: we can add new data, which is
called pushing, or we can remove it, which is called popping.  For pushing we
have the phrase

	push the key (K - a value) and the underlying key (U - a value) and the value (V - a value) onto (L - a linked list)

where the underlying key, or the value, or both can be omitted, in which case
the phrase will select numbers for these parameters arbitrarily:

	push the key (K - a value) and the underlying key (U - a value) onto (L - a linked list)

	push the key (K - a value) and the value (V - a value) onto (L - a linked list)

	push the key (K - a value) onto (L - a linked list)

There are also convenience versions for the most common use of the underlying
key field, text.  Both

	push the textual key (K - some text) and the value (V - a value) onto (L - a linked list)

and

	push the textual key (K - some text) onto (L - a linked list)

will store K as the underlying key of the new vertex and compute the matching
key with a phrase from Low-Level Operations:

	the normal hash of (T - some text)

All of the pushing phrases can be used with the permanent kinds as well.

As for popping, which is only possible with the non-permanent kinds, we can
detach an entire vertex from the list via the phrase

	a linked list vertex popped off of (L - a linked list)

The result will be null if the list is empty.  Recall that it is our
responsibility to delete non-null detached vertices.

Alternatively, we can retrieve a single datum from the detached vertex and then
delete that vertex automatically:

	a/an (D - a kind) key popped off of (L - a linked list)

or

	an underlying (D - a kind) key popped off of (L - a linked list)

or

	a/an (D - a kind) value popped off of (L - a linked list)

It is invalid to apply these last three phrases to an empty linked list.

Section: The queue interface

A queue is like a stack except that data is added to the other end.  As with
pushing, we have the general phrase

	enqueue the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (L - a linked list) through (T - a linked list tail)

along with variations in which we may omit some of the parameters:

	enqueue the key (K - a value) and the underlying key (U - a value) in (L - a linked list) through (T - a linked list tail)

	enqueue the key (K - a value) and the value (V - a value) in (L - a linked list) through (T - a linked list tail)

	enqueue the key (K - a value) in (L - a linked list) through (T - a linked list tail)

and specializations for automatically summarizing underlying text keys with the
normal hash phrase:

	enqueue the textual key (K - some text) and the value (V - a value) in (L - a linked list) through (T - a linked list tail)

	enqueue the textual key (K - some text) in (L - a linked list) through (T - a linked list tail)

Like the pushing phrases, these operations also apply to the permanent kinds.

In analogy to the popping phrases, we can request

	a linked list vertex dequeued from (L - a linked list) through (T - a linked list tail)

or one of its data, automatically deleting the vertex in the process:

	a/an (D - a kind) key dequeued from (L - a linked list) through (T - a linked list tail)

	an underlying (D - a kind) key dequeued from (L - a linked list) through (T - a linked list tail)

	a/an (D - a kind) value dequeued from (L - a linked list) through (T - a linked list tail)

The dequeuing phrases are equivalent to the popping phrases in the sense that
they remove one vertex from the beginning of the linked list, but they do not
invalidate the linked list tail, which makes them more suitable for chains of
queue operations.

Section: The search and lookup interface

The phrase

	the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (L - a linked list) with the comparator (C - a phrase (value, value) -> truth state)

locates, but does not detach, the first linked list vertex with the given key,
underlying key, and value, or, if none exists, it decides on a null linked list
vertex.  The key and value must be exactly K and V, respectively, but some
lenience is allowed when checking U.  If the phrase C, when given U as its first
argument and a vertex's underlying key as its second, decides on true, the
underlying keys are considered sufficiently similar to constitute a match.

Yet again, we may omit some of the data, in which case they will not be
considered when deciding whether a vertex matches:

	the first match for the key (K - a value) and the underlying key (U - a value) in (L - a linked list) with the comparator (C - a phrase (value, value) -> truth state)

	the first match for the key (K - a value) and the value (V - a value) in (L - a linked list)

	the first match for the key (K - a value) in (L - a linked list)

And as with all of the prior phrases, there are specialized variants for dealing
with text.  The phrase

	the first match for the textual key (T - some text) and the value (V - a value) in (L - a linked list)

or its simplification

	the first match for the textual key (T - some text) in (L - a linked list)

search for a vertex whose key is the normal hash of T and whose underlying key
is text containing the same character sequence as T.  The word "synthetic" may
be added if we know that T is synthetic text (see the extension Low-Level Text):

	the first match for the synthetic textual key (text) and the value (value) in (linked list)

Matching texts known to be synthetic is slightly faster than matching general
text.

The part of the foregoing phrases that reads

	... in (L - a linked list) ...

can be replaced with

	... after (X - a linked list vertex) ...

as in

	the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) after (X - a linked list vertex) with the comparator (C - a phrase (value, value) -> truth state)

or with

	... at or after (X - a linked list vertex) ...

as in

	the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) at or after (X - a linked list vertex) with the comparator (C - a phrase (value, value) -> truth state)

to restrict the range of the search or to find later matches.  But also see the
section on loops, which explains how to loop through vertices matching given
criteria.

Sometimes we are not interested in the matching linked list vertex, but only its
value.  The phrase

	first (D - a kind) value matching the key (K - a value) and the underlying key (U - a value) in (L - a linked list) with the comparator (C - a phrase (value, value) -> truth state) or (V - a value) if there are no matches

will return it directly, though we must provide the backup value V in case the
search cannot find a suitable vertex.  Like the other phrases, the underlying
key and comparator can be omitted.

At other times we may not be interested in the vertex's contents at all, but
only in whether a match exists.  The convenience phrases for such tests have
this form:

	if (L - a linked list) contains the key (K - a value) and the underlying key (U - a value) and the value (V - a value) with the comparator (C - phrase (value, value) -> truth state):
		....

Or, for text specifically, the form is

	if (L - a linked list) contains the textual key (T - some text) and the value (V - a value): 
		....

where the modifier "synthetic" can be added before "textual" if we know T to be
synthetic.

Lastly, we can remove matching vertices, using

	remove the first occurrence of the key (K - a value) and the underlying key (U - a value) and the value (V - a value) from (L - a linked list) with the comparator (C - a phrase (value, value) -> truth state)

and its variations, which include phrases like

	remove the first occurrence of the textual key (T - some text) and the value (V - a value) from (L - a linked list)

and

	remove the first occurrence of the synthetic textual key (T - some text) and the value (V - a value) from (L - a linked list)

All of the search phrases, save those that remove vertices, are equally
applicable to permanent linked lists.

Section: Loops

The phrase

	repeat with (I - a name not used so far) running through (L - a linked list):
		....

causes the block of phrases following it to be repeated once for each non-null
vertex in L, storing the current vertex in I.  If we are only interested in one
of the data held by these vertices, we can use the variations

	repeat with (I - a name not used so far) running through the (D - a kind) keys of (L - a linked list):
		....

	repeat with (I - a name not used so far) running through the underlying (D - a kind) keys of (L - a linked list):
		....

	repeat with (I - a name not used so far) running through the (D - a kind) values of (L - a linked list):
		....

An analogous family of phrases allows us to repeat over just the vertices
matching some key or key/underlying key pair.  For instance,

	repeat with (I - a name not used so far) running through occurrences of the key (K - a value) and the underlying key (U - a value) in (L - a linked list) with the comparator (C - phrase (value, value) -> truth state):
		....

or

	repeat with (I - a name not used so far) running through occurrences of the textual key (T - some text) in (L - a linked list):
		....

And when we are only interested in the corresponding values, we use:

	repeat with (I - a name not used so far) running through the (D - a kind) values matching the key (K - a value) and the underlying key (U - a value) in (L - a linked list) with the comparator (C - phrase (value, value) -> truth state):
		....

or

	repeat with (I - a name not used so far) running through the (D - a kind) values matching the textual key (T - some text) in (L - a linked list):
		....

and their variations.

Note that it is safe to modify linked list vertices while looping over their
enclosing list, but it is not safe to modify the list itself.

Section: Length

The phrase

	the length of (A - a linked list)

counts the number of vertices in a linked list.  Similarly,

	the length of (A - a permanent linked list)

counts vertices in a permanent linked list.

Section: Filtration

The phrase

	filter (L - a linked list) by (F - a phrase linked list vertex -> truth state)

can be used to alter a linked list while looping over it.  Each vertex of A is
given to F, but only those vertices for which F decides on true are retained.
The others are deleted.

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

Low-Level Linked Lists was prepared as part of a project on Glulx runtime
instrumentation.  For this first edition of the project, special thanks go to
these people, in chronological order:

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

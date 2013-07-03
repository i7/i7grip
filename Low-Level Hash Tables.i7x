Version 2 of Low-Level Hash Tables (for Glulx only) by Brady Garvin begins here.

"Hash tables for situations where Inform's relations aren't an option."

Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[Inform already has hash tables in the form of relations.  But for the Glulx Runtime Instrumentation Framework we need to worry about:

1. Reentrancy---if we inject a call into the middle of a block value management routine (which we will), the callee can't be sure that the block value record keeping is in a consistent state.

and

[@]
2. Speed---the interpreter-provided malloc is usually much faster than Inform's non-native, space-conscious equivalent.

So we use our own implementation.  However, the adjective ``low-level'' is important: these hash tables are more awkward and less forgiving than the nicely encapsulated Inform relations.  They are suitable for use in the instrumentation framework and instrumentation extensions because that's what they were designed for.  They might be appropriate in some other obscure situations.  But they are not fit for general use in a story.]

[These hash tables are an array of buckets, each of which holds a linked list of key/value pairs.]
[To call them hash maps would not be quite accurate; duplicate keys and even duplicate pairs are allowed.  Really they are bags (or multisets if you prefer) of ordered pairs where lookup is specialized for the first coordinate.]

[For each of the kinds defined by Low-Level Hash Tables you will see a sentence like

	A hash table is an invalid hash table.

This bewildering statement actually sets up hash tables as a qualitative value with default value the hash table at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on hash tables.]

Book "Low-Level Hash Tables"

Chapter "The Hash Table Kind"

A hash table is a kind of value.
A hash table is an invalid hash table.  [See the note in the book "Extension Information."]
The specification of a hash table is "A collection of associated pairs, much like the relation kind that is built into Inform.  Hash tables differ in four notable ways: (1) They do not use Inform's block value management system, which means that they can be used safely even when that management system is in an intermediate or inconsistent state.  This, in fact, is why they were introduced.  But it also means that hash tables must be explicitly allocated and freed.  (2) They store up to three pieces of content per entry: a key, an underlying key, and a value (where the semantic pair involves one of the keys and the value).  See the extension documentation for the differences between these kinds of content.  (3) They allow repeat entries.  (4) They support a slightly different (and slightly more error-prone) interface.  Again, consult the extension documentation for details."

Chapter "The Hash Table Structure" - unindexed

[Layout:
	4 bytes for the size of the table
	4 * size bytes for each bucket's linked list]
[Hash tables manage the lifetime of their linked lists; the linked list vertices are freed when the table is cleared.]
[They do *not* check for insertion of duplicate keys, nor even duplicate pairs.]
[Hash table buckets are numbered from one.  [Why?  Because, like in an I6 table, element zero is reserved for the size.  Also, because the one-based indexing is invisible to hash table users, and the only opportunity for off-by-one errors is in this code, which we test pretty carefully.]]

Section "Hash Table Construction and Destruction"

To decide what hash table is a new hash table with (N - a number) buckets (this is creating a hash table):
	let the byte count be N times four;
	let the result be a memory allocation of byte count plus four bytes;
	write the integer N to address result;
	zero byte count bytes at address result plus four;
	decide on the result converted to a hash table.

To delete (A - a hash table) (this is deleting a hash table):
	clear A;
	free the memory allocation at address A converted to a number.

Section "Hash Table Accessors and Mutators" - unindexed

To decide what number is the number of buckets in (A - a hash table): (- llo_getInt({A}) -).

[This procedure is hot, so it gets hand optimization.]
Include (-
	[ llht_bucketIndex key table count result;
		@aload table 0 count;
		@mod key count result;
		if (result < 0) {
			result = result + count;
		}
		return result + 1;
	];
-).

To decide what number is the bucket index of (K - a value) in (A - a hash table): (- llht_bucketIndex({K}, {A}) -).

To decide what linked list is bucket number (I - a number) of (A - a hash table): (- ({A})-->{I} -).
To decide what linked list is the bucket for (K - a value) in (A - a hash table): (- ({A})-->(llht_bucketIndex({K}, {A})) -).

Section "Hash Table Clearing"

To clear (A - a hash table) (this is clearing a hash table):
	let the size be the number of buckets in A;
	repeat with the index running from one to the size:
		delete bucket number index of A;
	let the byte count be the size times four;
	zero byte count bytes at address A converted to a number plus four.

[These quirky methods let us clear the hash table more quickly when it is sparsely populated and we have a convenient way to iterate over the keys.]
To clear the bucket for the key (K - a number) in (A - a hash table) (this is clearing a bucket in a hash table by key):
	let the index be the bucket index of K in A;
	delete bucket number index of A;
	write an empty linked list to bucket number index of A.

To clear the bucket for the textual key (K - some text) in (A - a hash table) (this is clearing a bucket in a hash table by textual key):
	let the index be the bucket index of the normal hash of K in A;
	delete bucket number index of A;
	write an empty linked list to bucket number index of A.

Section "Hash Table Adjectives"

Definition: a hash table (called A) is empty:
	let the size be the number of buckets in A;
	repeat with the index running from one to the size:
		unless bucket number index of A is empty:
			decide no;
	decide yes.

Section "Hash Table Properties"

To decide what number is the number of entries in (A - a hash table) (this is measuring a hash table):
	let the result be zero;
	repeat with a linked list vertex running through A:
		increment the result;
	decide on the result.

Chapter "The Permanent Hash Table Kind"

A permanent hash table is a kind of value.
A permanent hash table is an invalid permanent hash table.  [See the note in the book "Extension Information."]
The specification of a permanent hash table is "A collection of associated pairs, much like the relation kind that is built into Inform.  Hash tables differ in five notable ways: (1) They do not use Inform's block value management system, which means that they can be used safely even when that management system is in an intermediate or inconsistent state.  This, in fact, is why they were introduced.  But it also means that hash tables must be explicitly allocated and freed.  (2) They store up to three pieces of content per entry: a key, an underlying key, and a value (where the semantic pair involves one of the keys and the value).  See the extension documentation for the differences between these kinds of content.  (3) They allow repeat entries.  (4) They support a slightly different (and slightly more error-prone) interface.  Again, consult the extension documentation for details.  (5) Entries are 'permanent'.  We can add pairs to such a hash table, but we can never remove them.  We cannot delete the hash table either.  See the kind 'hash table' for a version that does not have this restriction, though at the expense of performance under certain interpreters."

Chapter "The Permanent Hash Table Structure" - unindexed

Section "Permanent Hash Table Construction"

To decide what permanent hash table is a new permanent hash table with (N - a number) buckets (this is creating a permanent hash table):
	let the byte count be N times four;
	let the result be a permanent memory allocation of byte count plus four bytes;
	write the integer N to address result;
	zero byte count bytes at address result plus four;
	decide on the result converted to a permanent hash table.

Section "Permanent Hash Table Accessors and Mutators" - unindexed

To decide what number is the number of buckets in (A - a permanent hash table): (- llo_getInt({A}) -).

To decide what number is the bucket index of (K - a value) in (A - a permanent hash table): (- llht_bucketIndex({K}, {A}) -).

To decide what permanent linked list is bucket number (I - a number) of (A - a permanent hash table): (- ({A})-->{I} -).
To decide what permanent linked list is the bucket for (K - a value) in (A - a permanent hash table): (- ({A})-->(llht_bucketIndex({K}, {A})) -).

Section "Permanent Hash Table Adjectives"

Definition: a permanent hash table (called A) is empty:
	let the size be the number of buckets in A;
	repeat with the index running from one to the size:
		unless bucket number index of A is empty:
			decide no;
	decide yes.

Section "Permanent Hash Table Properties"

To decide what number is the number of entries in (A - a permanent hash table) (this is measuring a permanent hash table):
	let the result be zero;
	repeat with a linked list vertex running through A:
		increment the result;
	decide on the result.

Book "Hash Table Interfaces"

Chapter "Map Interface"

Section "Insertion"

[Reminder: Hash tables do *not* check for multiple insertion of equivalent pairs.]

To insert the key (K - a value) into (A - a hash table):
	push the key K onto the bucket for K in A.

To insert the key (K - a value) and the underlying key (U - a value) into (A - a hash table):
	push the key K and the underlying key U onto the bucket for K in A.

To insert the textual key (K - some text) into (A - a hash table) (this is inserting a textual key into a hash table):
	let the hash be the normal hash of K;
	push the key the hash and the underlying key K onto the bucket for the hash in A.

To insert the key (K - a value) and the value (V - a value) into (A - a hash table):
	push the key K and the value V onto the bucket for K in A.

To insert the key (K - a value) and the underlying key (U - a value) and the value (V - a value) into (A - a hash table):
	push the key K and the underlying key U and the value V onto the bucket for K in A.

To insert the textual key (K - some text) and the value (V - a value) into (A - a hash table):
	let the hash be the normal hash of K;
	push the key the hash and the underlying key K and the value V onto the bucket for the hash in A.

To insert the key (K - a value) into (A - a permanent hash table):
	push the key K onto the bucket for K in A.

To insert the key (K - a value) and the underlying key (U - a value) into (A - a permanent hash table):
	push the key K and the underlying key U onto the bucket for K in A.

To insert the textual key (K - some text) into (A - a permanent hash table) (this is inserting a textual key into a permanent hash table):
	let the hash be the normal hash of K;
	push the key the hash and the underlying key K onto the bucket for the hash in A.

To insert the key (K - a value) and the value (V - a value) into (A - a permanent hash table):
	push the key K and the value V onto the bucket for K in A.

To insert the key (K - a value) and the underlying key (U - a value) and the value (V - a value) into (A - a permanent hash table):
	push the key K and the underlying key U and the value V onto the bucket for K in A.

To insert the textual key (K - some text) and the value (V - a value) into (A - a permanent hash table):
	let the hash be the normal hash of K;
	push the key the hash and the underlying key K and the value V onto the bucket for the hash in A.

Section "Removal"

To remove the first occurrence of the key (K - a value) from (A - a hash table):
	remove the first occurrence of the key K from the bucket for K in A.

To remove the first occurrence of the key (K - a value) and the underlying key (U - a value) from (A - a hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	remove the first occurrence of the key K and the underlying key U from the bucket for K in A with the comparator P.

To remove the first occurrence of the synthetic textual key (K - some text) from (A - a hash table) (this is removing the first occurrence of a synthetic textual key from a hash table):
	let the hash be the normal hash of K;
	remove the first occurrence of the key the hash and the underlying key K from the bucket for the hash in A with the comparator testing equality between synthetic text and text.

To remove the first occurrence of the textual key (K - some text) from (A - a hash table) (this is removing the first occurrence of a textual key from a hash table):
	let the key be a new synthetic text copied from K;
	remove the first occurrence of the synthetic textual key key from A;
	delete the synthetic text key.

To remove the first occurrence of the key (K - a value) and the value (V - a value) from (A - a hash table):
	remove the first occurrence of the key K and the value V from the bucket for K in A.

To remove the first occurrence of the key (K - a value) and the underlying key (U - a value) and the value (V - a value) from (A - a hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	remove the first occurrence of the key K and the underlying key U and the value V from the bucket for K in A with the comparator P.

To remove the first occurrence of the synthetic textual key (K - some text) and the value (V - a value) from (A - a hash table):
	let the hash be the normal hash of K;
	remove the first occurrence of the key the hash and the underlying key K and the value V from the bucket for the hash in A with the comparator testing equality between synthetic text and text.

To remove the first occurrence of the textual key (K - some text) and the value (V - a value) from (A - a hash table):
	let the key be a new synthetic text copied from K;
	remove the first occurrence of the synthetic textual key key and the value V from A;
	delete the synthetic text key.

Section "Membership"

To decide whether (A - a hash table) contains the key (K - a value):
	decide on whether or not the first match for the key K in A is not null.

To decide whether (A - a hash table) contains the key (K - a value) and the underlying key (U - a value) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U in A with the comparator P is not null.

To decide whether (A - a hash table) contains the synthetic textual the key (K - some text) (this is testing synthetic textual key presence in a hash table):
	decide on whether or not the first match for the synthetic textual key K in A is not null.

To decide whether (A - a hash table) contains the textual key (K - some text) (this is testing textual key presence in a hash table):
	decide on whether or not the first match for the textual key K in A is not null.

To decide whether (A - a hash table) contains the key (K - a value) and the value (V - a value):
	decide on whether or not the first match for the key K and the value V in A is not null.

To decide whether (A - a hash table) contains the key (K - a value) and the underlying key (U - a value) and the value (V - a value) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U and the value V in A with the comparator P is not null.

To decide whether (A - a hash table) contains the synthetic textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the synthetic textual key K is not null.

To decide whether (A - a hash table) contains the textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the textual key K is not null.

To decide whether (A - a permanent hash table) contains the key (K - a value):
	decide on whether or not the first match for the key K in A is not null.

To decide whether (A - a permanent hash table) contains the key (K - a value) and the underlying key (U - a value) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U in A with the comparator P is not null.

To decide whether (A - a permanent hash table) contains the synthetic textual the key (K - some text) (this is testing synthetic textual key presence in a permanent hash table):
	decide on whether or not the first match for the synthetic textual key K in A is not null.

To decide whether (A - a permanent hash table) contains the textual key (K - some text) (this is testing textual key presence in a permanent hash table):
	decide on whether or not the first match for the textual key K in A is not null.

To decide whether (A - a permanent hash table) contains the key (K - a value) and the value (V - a value):
	decide on whether or not the first match for the key K and the value V in A is not null.

To decide whether (A - a permanent hash table) contains the key (K - a value) and the underlying key (U - a value) and the value (V - a value) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on whether or not the first match for the key K and the underlying key U and the value V in A with the comparator P is not null.

To decide whether (A - a permanent hash table) contains the synthetic textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the synthetic textual key K is not null.

To decide whether (A - a permanent hash table) contains the textual key (K - some text) and the value (V - a value):
	decide on whether or not the first match for the textual key K is not null.

Section "Lookup"

To decide what linked list vertex is the first match for the key (K - a value) in (A - a hash table):
	decide on the first match for the key K in the bucket for K in A.

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) in (A - a hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on the first match for the key K and the underlying key U in the bucket for K in A with the comparator P.

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) in (A - a hash table) (this is finding the first match for a synthetic textual key in a hash table):
	let the hash be the normal hash of K;
	decide on the first match for the key the hash and the underlying key K in the bucket for the hash in A with the comparator testing equality between synthetic text and text.

To decide what linked list vertex is the first match for the textual key (K - some text) in (A - a hash table) (this is finding the first match for a textual key in a hash table):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key in A;
	delete the synthetic text key;
	decide on the result.

To decide what linked list vertex is the first match for the key (K - a value) and the value (V - a value) in (A - a hash table):
	decide on the first match for the key K and the value V in the bucket for K in A.

To decide what linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (A - a hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on the first match for the key K and the underlying key U and the value V in the bucket for K in A with the comparator P.

To decide what linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) in (A - a hash table):
	let the hash be the normal hash of K;
	decide on the first match for the key the hash and the underlying key K and the value V in the bucket for the hash in A with the comparator testing equality between synthetic text and text.

To decide what linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) in (A - a hash table):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key and the value V in A;
	delete the synthetic text key;
	decide on the result.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) in (A - a hash table) or (V - a K) if there are no matches:
	decide on the first D value matching the key K in the bucket for K in A or V if there are no matches.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) and the underlying key (U - a value) in (A - a hash table) with the comparator (P - a phrase (value of kind L, L) -> nothing) or (V - a value) if there are no matches:
	decide on the first D value matching the key K and the underlying key U in the bucket for K in A with the comparator P or V if there are no matches.

To decide what K is the first (D - a description of values of kind K) value matching the synthetic textual key (K - a value) in (A - a hash table) or (V - a value) if there are no matches:
	let the hash be the normal hash of K;
	decide on the first D value matching the key the hash and the underlying key K in the bucket for the hash in A with the comparator testing equality between synthetic text and text or V if there are no matches.

To decide what K is the first (D - a description of values of kind K) value matching the textual key (K - a value) in (A - a hash table) or (V - a value) if there are no matches:
	let key be a new synthetic text copied from K;
	let the result be the first D value matching the synthetic textual key key in A or V if there are no matches;
	delete the synthetic text key;
	decide on the result.

To decide what permanent linked list vertex is the first match for the key (K - a value) in (A - a permanent hash table):
	decide on the first match for the key K in the bucket for K in A.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) in (A - a permanent hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on the first match for the key K and the underlying key U in the bucket for K in A with the comparator P.

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) in (A - a permanent hash table) (this is finding the first match for a synthetic textual key in a permanent hash table):
	let the hash be the normal hash of K;
	decide on the first match for the key the hash and the underlying key K in the bucket for the hash in A with the comparator testing equality between synthetic text and text.

To decide what permanent linked list vertex is the first match for the textual key (K - some text) in (A - a permanent hash table) (this is finding the first match for a textual key in a permanent hash table):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key in A;
	delete the synthetic text key;
	decide on the result.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the value (V - a value) in (A - a permanent hash table):
	decide on the first match for the key K and the value V in the bucket for K in A.

To decide what permanent linked list vertex is the first match for the key (K - a value) and the underlying key (U - a value) and the value (V - a value) in (A - a permanent hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing):
	decide on the first match for the key K and the underlying key U and the value V in the bucket for K in A with the comparator P.

To decide what permanent linked list vertex is the first match for the synthetic textual key (K - some text) and the value (V - a value) in (A - a permanent hash table):
	let the hash be the normal hash of K;
	decide on the first match for the key the hash and the underlying key K and the value V in the bucket for the hash in A with the comparator testing equality between synthetic text and text.

To decide what permanent linked list vertex is the first match for the textual key (K - some text) and the value (V - a value) in (A - a permanent hash table):
	let the key be a new synthetic text copied from K;
	let the result be the first match for the synthetic textual key key and the value V in A;
	delete the synthetic text key;
	decide on the result.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) in (A - a permanent hash table) or (V - a K) if there are no matches:
	decide on the first D value matching the key K in the bucket for K in A or V if there are no matches.

To decide what K is the first (D - a description of values of kind K) value matching the key (K - a value) and the underlying key (U - a value) in (A - a permanent hash table) with the comparator (P - a phrase (value of kind L, L) -> nothing) or (V - a value) if there are no matches:
	decide on the first D value matching the key K and the underlying key U in the bucket for K in A with the comparator P or V if there are no matches.

To decide what K is the first (D - a description of values of kind K) value matching the synthetic textual key (K - a value) in (A - a permanent hash table) or (V - a value) if there are no matches:
	let the hash be the normal hash of K;
	decide on the first D value matching the key the hash and the underlying key K in the bucket for the hash in A with the comparator testing equality between synthetic text and text or V if there are no matches.

To decide what K is the first (D - a description of values of kind K) value matching the textual key (K - a value) in (A - a permanent hash table) or (V - a value) if there are no matches:
	let key be a new synthetic text copied from K;
	let the result be the first D value matching the synthetic textual key key in A or V if there are no matches;
	delete the synthetic text key;
	decide on the result.

Chapter "Iteration Interface"

Section "Unfiltered Repetition"

Include (-
	Global llht_bucket;
	Global llht_iterator;
	Global llht_hash;
	Global llht_copy;
-) after "Definitions.i6t".

To repeat with (I - a nonexisting linked list vertex variable) running through (A - a hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	{I} = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull {I};
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if ({I}) {
				@aload {I} 3 {I};
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~{I}) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				{I} = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push {I};
			llo_advance = ~~(llo_broken = {I});
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) keys of (A - a hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	llht_iterator = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if (llht_iterator) {
				@aload llht_iterator 3 llht_iterator;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				llht_iterator = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push llht_iterator;
			llo_advance = ~~(llo_broken = llht_iterator);
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true, {I} = llo_getInt(llht_iterator): llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the underlying (D - a description of values of kind K) keys of (A - a hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	llht_iterator = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if (llht_iterator) {
				@aload llht_iterator 3 llht_iterator;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				llht_iterator = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push llht_iterator;
			llo_advance = ~~(llo_broken = llht_iterator);
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true, {I} = llo_getField(llht_iterator, 2): llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values of (A - a hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	llht_iterator = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if (llht_iterator) {
				@aload llht_iterator 3 llht_iterator;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				llht_iterator = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push llht_iterator;
			llo_advance = ~~(llo_broken = llht_iterator);
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true, {I} = llo_getField(llht_iterator, 1): llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through (A - a permanent hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	{I} = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull {I};
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if ({I}) {
				@aload {I} 3 {I};
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~{I}) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				{I} = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push {I};
			llo_advance = ~~(llo_broken = {I});
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) keys of (A - a permanent hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	llht_iterator = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if (llht_iterator) {
				@aload llht_iterator 3 llht_iterator;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				llht_iterator = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push llht_iterator;
			llo_advance = ~~(llo_broken = llht_iterator);
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true, {I} = llo_getInt(llht_iterator): llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the underlying (D - a description of values of kind K) keys of (A - a permanent hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	llht_iterator = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if (llht_iterator) {
				@aload llht_iterator 3 llht_iterator;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				llht_iterator = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push llht_iterator;
			llo_advance = ~~(llo_broken = llht_iterator);
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true, {I} = llo_getField(llht_iterator, 2): llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values of (A - a permanent hash table) begin -- end: (-
	llht_bucket = llo_getInt({A});
	@push llht_bucket;
	llht_iterator = llo_getField({A}, llht_bucket);
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				@pull llht_bucket;
				break;
			}
			if (llht_iterator) {
				@aload llht_iterator 3 llht_iterator;
			}
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				@pull llht_bucket;
				llht_bucket--;
				if (~~llht_bucket) {
					llo_broken = true;
					break;
				}
				llht_iterator = llo_getField({A}, llht_bucket);
				@push llht_bucket;
			}
			@push llht_iterator;
			llo_advance = ~~(llo_broken = llht_iterator);
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true, {I} = llo_getField(llht_iterator, 1): llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Section "Repetition Filtered by Key"

Include (-
	[ llht_firstMatch key address;
		return llll_atOrAfter(key, llo_getField(address, llht_bucketIndex(key, address)));
	];
	[ llht_firstMatchWithValue key value address;
		return llll_atOrAfterWithValue(key, value, llo_getField(address, llht_bucketIndex(key, address)));
	];
	[ llht_firstMatchWithUnderlying key underlyingKey address comparator;
		return llll_atOrAfterWithUnderlying(key, underlyingKey, llo_getField(address, llht_bucketIndex(key, address)), comparator);
	];
	[ llht_firstMatchSynthetic key underlyingKey address;
		return llll_atOrAfterSynthetic(key, underlyingKey, llo_getField(address, llht_bucketIndex(key, address)));
	];
	[ llht_firstMatchWithBoth key underlyingKey value address comparator;
		return llll_atOrAfterWithBoth(key, underlyingKey, value, llo_getField(address, llht_bucketIndex(key, address)), comparator);
	];
-).

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the key (K - a value) in (A - a hash table) begin -- end: (-
	for ({I} = llht_firstMatch({K}, {A}): {I}: {I} = llll_atOrAfter({K}, llo_getField({I}, 3)))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) in (A - a hash table) begin -- end: (-
	llht_iterator = llht_firstMatch({K}, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfter({K}, llht_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				break;
			}
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the key (K - a value) in (A - a permanent hash table) begin -- end: (-
	for ({I} = llht_firstMatch({K}, {A}): {I}: {I} = llll_atOrAfter({K}, llo_getField({I}, 3)))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) in (A - a permanent hash table) begin -- end: (-
	llht_iterator = llht_firstMatch({K}, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfter({K}, llht_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				break;
			}
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Section "Repetition Filtered by Underlying Key"

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the key (K - a value) and the underlying key (U - a value) in (A - a hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing) begin -- end: (-
	for ({I} = llht_firstMatchWithUnderlying({K}, {U}, {A}, {P}): {I}: {I} = llll_atOrAfterWithUnderlying({K}, {U}, llo_getField({I}, 3), {P}))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) and the underlying key (U - a value) in (A - a hash table) with the comparator (P - a phrase (value of kind L, L) -> nothing) begin -- end: (-
	llht_iterator = llht_firstMatchWithUnderlying({K}, {U}, {A}, {P});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfterWithUnderlying({K}, {U}, llht_iterator, {P});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				break;
			}
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the synthetic textual key (K - some text) in (A - a hash table) begin -- end: (-
	llht_hash = llo_stringHash32({K});
	{I} = llht_firstMatchSynthetic(llht_hash, {K}, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull {I};
			@pull llht_hash;
			if (llo_broken) {
				break;
			}
			@aload {I} 3 {I};
			{I} = llll_atOrAfterSynthetic(llht_hash, {K}, {I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~{I}) {
				llo_broken = true;
				break;
			}
			@push llht_hash;
			@push {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting linked list vertex variable) running through occurrences of the textual key (K - some text) in (A - a hash table) begin -- end: (-
	llht_copy = (llo_getField((+ copying text to synthetic text +), 1))({K});
	llht_hash = llo_stringHash32(llht_copy);
	{I} = llht_firstMatchSynthetic(llht_hash, llht_copy, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull {I};
			@pull llht_hash;
			@pull llht_copy;
			if (llo_broken) {
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@aload {I} 3 {I};
			{I} = llll_atOrAfterSynthetic(llht_hash, llht_copy, {I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~{I}) {
				llo_broken = true;
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@push llht_copy;
			@push llht_hash;
			@push {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the synthetic textual key (K - some text) in (A - a hash table) begin -- end: (-
	llht_hash = llo_stringHash32({K});
	llht_iterator = llht_firstMatchSynthetic(llht_hash, {K}, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			@pull llht_hash;
			if (llo_broken) {
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfterSynthetic(llht_hash, {K}, llht_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				break;
			}
			@push llht_hash;
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the textual key (K - some text) in (A - a hash table) begin -- end: (-
	llht_copy = (llo_getField((+ copying text to synthetic text +), 1))({K});
	llht_hash = llo_stringHash32(llht_copy);
	llht_iterator = llht_firstMatchSynthetic(llht_hash, llht_copy, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			@pull llht_hash;
			@pull llht_copy;
			if (llo_broken) {
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfterSynthetic(llht_hash, llht_copy, llht_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@push llht_copy;
			@push llht_hash;
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the key (K - a value) and the underlying key (U - a value) in (A - a permanent hash table) with the comparator (P - a phrase (value of kind K, K) -> nothing) begin -- end: (-
	for ({I} = llht_firstMatchWithUnderlying({K}, {U}, {A}, {P}): {I}: {I} = llll_atOrAfterWithUnderlying({K}, {U}, llo_getField({I}, 3), {P}))
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the key (K - a value) and the underlying key (U - a value) in (A - a permanent hash table) with the comparator (P - a phrase (value of kind L, L) -> nothing) begin -- end: (-
	llht_iterator = llht_firstMatchWithUnderlying({K}, {U}, {A}, {P});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			if (llo_broken) {
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfterWithUnderlying({K}, {U}, llht_iterator, {P});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				break;
			}
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the synthetic textual key (K - some text) in (A - a permanent hash table) begin -- end: (-
	llht_hash = llo_stringHash32({K});
	{I} = llht_firstMatchSynthetic(llht_hash, {K}, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull {I};
			@pull llht_hash;
			if (llo_broken) {
				break;
			}
			@aload {I} 3 {I};
			{I} = llll_atOrAfterSynthetic(llht_hash, {K}, {I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~{I}) {
				llo_broken = true;
				break;
			}
			@push llht_hash;
			@push {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting permanent linked list vertex variable) running through occurrences of the textual key (K - some text) in (A - a permanent hash table) begin -- end: (-
	llht_copy = (llo_getField((+ copying text to synthetic text +), 1))({K});
	llht_hash = llo_stringHash32(llht_copy);
	{I} = llht_firstMatchSynthetic(llht_hash, llht_copy, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull {I};
			@pull llht_hash;
			@pull llht_copy;
			if (llo_broken) {
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@aload {I} 3 {I};
			{I} = llll_atOrAfterSynthetic(llht_hash, llht_copy, {I});
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~{I}) {
				llo_broken = true;
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@push llht_copy;
			@push llht_hash;
			@push {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the synthetic textual key (K - some text) in (A - a permanent hash table) begin -- end: (-
	llht_hash = llo_stringHash32({K});
	llht_iterator = llht_firstMatchSynthetic(llht_hash, {K}, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			@pull llht_hash;
			if (llo_broken) {
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfterSynthetic(llht_hash, {K}, llht_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				break;
			}
			@push llht_hash;
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

To repeat with (I - a nonexisting K variable) running through the (D - a description of values of kind K) values matching the textual key (K - some text) in (A - a permanent hash table) begin -- end: (-
	llht_copy = (llo_getField((+ copying text to synthetic text +), 1))({K});
	llht_hash = llo_stringHash32(llht_copy);
	llht_iterator = llht_firstMatchSynthetic(llht_hash, llht_copy, {A});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for (::)
		if (llo_advance) {
			@pull llht_iterator;
			@pull llht_hash;
			@pull llht_copy;
			if (llo_broken) {
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@aload llht_iterator 3 llht_iterator;
			llht_iterator = llll_atOrAfterSynthetic(llht_hash, llht_copy, llht_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			if (~~llht_iterator) {
				llo_broken = true;
				(llo_getField((+ deleting synthetic text +), 1))(llht_copy);
				break;
			}
			@push llht_copy;
			@push llht_hash;
			@push llht_iterator;
			@aload llht_iterator 1 {I};
			llo_advance = false;
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Low-Level Hash Tables ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

When we write instrumentation code for use with the Glulx Runtime
Instrumentation Framework or a library that supports such code, we must consider
the possibility that the instrumentation will be called from within Inform's
block value management system.  The block value management routines are not
reentrant, so in such a case we cannot safely use Inform's relations; we must
turn to another data structure.  Low-Level Hast Tables contains a replacement
relation implementation that, while less cleanly encapsulated, is a safe
alternative even in these extreme scenarios.

Details are in the following chapters.

Chapter: Usage

Normally we have Inform's lists for expressing a set of concepts and Inform's
relations for expressing connections between concepts.  But when we write
instrumenting rules for the Glulx Runtime Instrumentation Framework, lists and
relations are forbidden because they might involve Inform's block value
management system.  Low-Level Hash Tables is a modest substitution.

The adjectives "low-level" and "modest" are important: these hash tables open up
opportunities for subtle and hard-to-debug errors.  Unless we have a compelling
reason, like the fact that we're writing instrumentation code, we will be better
off with the safer implementations provided by the Inform language.

Section: Some words of caution

Before anything else, authors should familiarize themselves with the extension
Low-Level Linked Lists.  Linked lists play a crucial role in the implementation
and use of these hash tables, and all of the caveats mentioned in that
extension's documentation apply here.

Section: An overview of the kinds

Low-Level Hash Tables stores sets and relations (and bags, and multigraphs,
etc.) as values of the kind "hash table".  A hash table, as we use the term
here, is a set of linked lists numbered from zero on up.  We call them
"buckets".  Whenever we store an entry in a hash table, we convert its key to a
number, divide it by the bucket count, and place the entry in the bucket whose
number is the remainder.  When we need to look up an entry, we repeat the
computation with the key we are searching for, giving us only one list out of
many to search through.

To represent a relation with a hash table, we treat items from one of the groups
being related as keys or underlying keys, and the other group's items become
values.  We can then look up corresponding values given a key.  If we also need
to perform lookups in the other direction, we store the same pairs in another
hash table, but with the keys and values reversed.

To represent a set of items, we do much the same thing, except that there are no
corresponding elements, so we can ignore the value field.  We must also check
for containment before inserting a key, so that we do not store it twice.

As might be expected from the Low-Level Linked Lists documentation, the default
value for the "hash table" kind is

	an invalid hash table

which cannot safely be given to any of the extension's phrases.  We create more
useful values via the phrase

	a new hash table with (N - a number) buckets

The more buckets there are, the fewer list entries we can expect per bucket, and
the faster search will be.  On the other hand, buckets take up memory, and they
also take time to process whenever we need to loop over all of a hash table's
entries.  Another consideration is the distribution of keys; if all of the keys
are divisible by four, say, and N is also, then the remainders will always be
multiples of four and three quarters of the buckets will go unused.  We can
avoid such trouble (and other, similar inefficiencies) if we choose a moderately
large prime for N.

(Authors familiar with other hash table implementations will note that the
number of buckets is unchanging, which is not the norm elsewhere.  As a
consequence, hash table operations that would asymptotically take amortized
constant time in a traditional implementation are in fact linear time here.
Still, we have control over the coefficient, which in many cases is enough.)

When we are done with a hash table, we can either clear and reuse it for other
data or else delete it.  The phrase

	clear (H - a hash table)

clears its argument, and the phrase

	delete (H - a hash table)

deletes its argument, which amounts to deleting all of its linked lists.

(In the special case where we have fewer data than buckets and independent means
for looping over all of their keys, code like the following is a faster way to
clear a hash table:

	repeat with the key running through the keys:
		clear the bucket for the key the key in the hash table;

And if the keys are normal hashes of underlying text keys, we can write

	repeat with the underlying key running through the underlying keys:
		clear the bucket for the textual key the underlying key in the hash table;

instead.)

There is also a permanent version of the hash table kind, the "permanent hash
table" kind, whose values are either

	an invalid permanent hash table

or something created by the phrase

	a new permanent hash table with (N - a number) buckets

As with permanent linked lists, entries in a permanent hash table cannot be
removed, nor can a permanent hash table be deleted.  But there is also a
significant speed-up under some interpreters if we use permanent hash tables in
place of their ordinary counterparts.

Section: Manipulating hash tables

Every phrase in the sections titled "The search and lookup interface" and
"Loops" in the Low-Level Linked Lists documentation also applies to hash tables
and permanent hash tables.  The only difference is that instead of using the
stack or queue interface to add elements, we have a separate family of insertion
phrases.  The general form is

	insert the key (K - a value) and the underlying key (U - a value) and the value (V - a value) into (H - a hash table)

The underlying key, the value, or both can be omitted, in which case they will
be set to some convenient number:

	insert the key (K - a value) and the underlying key (U - a value) into (H - a hash table)

	insert the key (K - a value) and the value (V - a value) into (H - a hash table)

	insert the key (K - a value) into (H - a hash table)

As the most common use of the underlying key field is for text, there are also
the convenience phrases:

	insert the textual key (K - some text) and the value (V - a value) into (H - a hash table)

and

	insert the textual key (K - some text) into (H - a hash table)

The insertion phrases for permanent hash tables are the same.

Section: Counting entries

The phrase

	the number of entries in (H - a hash table)

counts the number of entries in a hash table.  Similarly,

	the number of entries in (H - a permanent hash table)

counts entries in a permanent hash table.

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

Low-Level Hash Tables was prepared as part of the Glulx Runtime Instrumentation
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

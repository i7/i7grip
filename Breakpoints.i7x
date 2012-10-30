Version 1 of Breakpoints (for Glulx only) by Brady Garvin begins here.

"Breakpoint injection and management routines, for use by debugging extensions."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Object Pools by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Debug File Parsing by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.
Include Call Stack Tracking by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2012 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[For each of the kinds defined by Breakpoints you will see a sentence like

	A simple breakpoint is an invalid simple breakpoint.

This bewildering statement actually sets up simple breakpoints as a qualitative value with default value the simple breakpoint at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on simple breakpoints.]

Chapter "Use Options"

Use universal breakpoint flags of at least 1 translates as (- Constant B_UNIVERSAL_FLAGS={N}; -).

Use a breakpoint flag address address hash table size of at least 11213 translates as (- Constant B_FLAG_ADDRESS_ADDRESS_HASH_SIZE={N}; -).
Use a simple breakpoint hash table size of at least 311 translates as (- Constant B_SIMPLE_BREAKPOINT_HASH_SIZE={N}; -).

Use a simple breakpoint preallocation of at least 32768 translates as (- Constant B_SIMPLE_BREAKPOINT_PREALLOC={N}; -).

To decide what number is the number of universal breakpoint flags: (- B_UNIVERSAL_FLAGS -).

To decide what number is the breakpoint flag address address hash table size: (- B_FLAG_ADDRESS_ADDRESS_HASH_SIZE -).
To decide what number is the simple breakpoint hash table size: (- B_SIMPLE_BREAKPOINT_HASH_SIZE -).

To decide what number is the simple breakpoint preallocation: (- B_SIMPLE_BREAKPOINT_PREALLOC -).

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at deleting a simple breakpoint still in use:
	say "[low-level runtime failure in]Breakpoints[with explanation]I tried to delete a simple breakpoint while it was still a member of one or more compound breakpoints.  My breakpoint bookkeeping must be confused.[terminating the story]".

To fail at finding a sequence point for a yield:
	say "[low-level runtime failure in]Breakpoints[with explanation]While processing [the human-friendly name for the function at address the address of the function owning the chunk being instrumented] (at address [the address of the function owning the chunk being instrumented]/[the address of the function owning the chunk being instrumented in hexadecimal]), I found a location where the story might be interrupted to give a debugging tool its share of processing time, but also a location with no associated sequence point.  Without a sequence point, I wouldn't be able to communicate the story's state to the debugging tool.  Therefore, I should have prevented interruptions from happening here, but it seems that I did not.[terminating the story]".

Book "Globals"

Include (-
	Array b_universalBreakpointFlags --> B_UNIVERSAL_FLAGS;
	Array b_lastSeenSequencePoint --> 1;
	Array b_lastSeenResumePoint --> 1;
-).

To decide what number is universal breakpoint flag address (I - a number): (- (b_universalBreakpointFlags+4*{I}) -).

To decide whether universal breakpoint flag (I - a number) is set: (- llo_getField(b_universalBreakpointFlags,{I}) -).
To reset universal breakpoint flag (I - a number): (- llo_setField(b_universalBreakpointFlags,{I},0); -).
To set universal breakpoint flag (I - a number): (- llo_setField(b_universalBreakpointFlags,{I},1); -).

To decide what number is the address of the last-seen sequence point before the last-seen breakpoint: (- b_lastSeenSequencePoint -).

To decide what number is the last-seen sequence point before the last-seen breakpoint: (- llo_getInt(b_lastSeenSequencePoint) -).

To decide what number is the address of the last-seen resume point before the last-seen breakpoint: (- b_lastSeenResumePoint -).

To decide what number is the last-seen resume point before the last-seen breakpoint: (- llo_getInt(b_lastSeenResumePoint) -).

Book "Breakpoint Instrumentation"

Chapter "Frame-Local Breakpoints"

The frame-local breakpoint index is a number that varies.

A GRIF setup rule (this is the reserve space for frame-local breakpoints rule):
	now the frame-local breakpoint index is the index of a newly reserved call frame field.

To enable the frame-local breakpoint in (F - a call frame):
	write true to extra field frame-local breakpoint index of F.

To disable the frame-local breakpoint in (F - a call frame):
	write false to extra field frame-local breakpoint index of F.

Chapter "Breakpoint Instruction Vertices"

[Note that the default phrase always returns zero.]
The phrase that chooses the universal breakpoint flag index for a sequence point is a phrase number -> number that varies.

[ @jnz b_universalBreakpointFlags-->I <constant>; ] [where I is deteremined by the phrase that chooses the universal breakpoint flag index for a sequence point, and b_universalBreakpointFlags-->I might already be replaced if the sequence point has a corresponding simple breakpoint]
[Layout:
	4 bytes for the op-code
	1 byte for the addressing modes
	4 bytes for the breakpoint flag address
	4 bytes for the label]
To decide what instruction vertex is a new breakpoint branch instruction vertex for the sequence point (A - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-jnz to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	let the simple breakpoint be the first simple breakpoint value matching the key A in the simple breakpoint hash table or an invalid simple breakpoint if there are no matches;
	if the simple breakpoint is an invalid simple breakpoint:
		let the index be the phrase that chooses the universal breakpoint flag index for a sequence point applied to A;
		write universal breakpoint flag address index to parameter zero of the result;
	otherwise:
		write the breakpoint flag address of the simple breakpoint to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

[ @jnz <frame-local-breakpoint-flag> <constant>; ]
To decide what instruction vertex is a new frame-local breakpoint branch instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-jnz to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write extra field address frame-local breakpoint index of call frames for the chunk being instrumented as seen by that chunk to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

To decide whether (V - an instruction vertex) is a breakpoint branch instruction vertex:
	unless the operation code of V is op-jnz:
		decide no;
	unless the addressing mode of parameter zero of V is the zero-based-dereference addressing mode:
		decide no;
	unless the addressing mode of parameter one of V is the constant addressing mode:
		decide no;
	decide yes.

[ @copy A b_lastSeenSequencePoint-->0; ]
To decide what instruction vertex is a new escape-recording instruction vertex for the sequence point (A - a number):
	decide on a new artificial instruction vertex for a copy with source mode constant addressing mode and source parameter A and destination mode zero-based-dereference addressing mode and destination parameter the address of the last-seen sequence point before the last-seen breakpoint.

To decide whether (V - an instruction vertex) is an escape-recording instruction vertex for a sequence point:
	unless parameter one of V is the address of the last-seen sequence point before the last-seen breakpoint:
		decide no;
	unless the operation code of V is op-copy:
		decide no;
	unless the addressing mode of parameter zero of V is the constant addressing mode:
		decide no;
	unless the addressing mode of parameter one of V is the zero-based-dereference addressing mode:
		decide no;
	decide yes.

To decide what number is the sequence point recorded by the escape-recording (V - an instruction vertex):
	decide on parameter zero of V.

[ @copy 0 b_lastSeenResumePoint-->0; ] [The zero will be later replaced by <address-of-instruction-after-V>, where V is the jnz from above.]
To decide what instruction vertex is a new escape-recording instruction vertex for a resume point:
	decide on a new artificial instruction vertex for a copy with source mode zero-or-discard addressing mode and destination mode zero-based-dereference addressing mode and destination parameter the address of the last-seen resume point before the last-seen breakpoint.

[ @jumpabs <escape-chunk>; ]
To decide what instruction vertex is a new breakpoint escape instruction vertex:
	decide on a new artificial instruction vertex for an absolute jump with mode zero-based-dereference addressing mode and parameter the breakpoint escape chunk address's address.

[ @add gi_yieldCountdown-->0 1 gi_yieldCountdown-->0; ]
To decide what instruction vertex is a new yield-countdown-incrementing instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-add to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write the address of the yield countdown to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write one to parameter one of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter two of the result;
	write the address of the yield countdown to parameter two of the result;
	decide on the result.

Chapter "Breakpoint Handler and the Escape Chunk"

Handling a breakpoint is a nothing based rulebook.  [Only for the purposes of easily creating nothing-based rules.]
The breakpoint handler is a nothing based rule that varies.

Include (-
	Array b_breakpointEscapeChunk --> 1;
	Global b_resumePointTransfer;
	[ b_breakpointEscapeChunkFunction;
		(+ the breakpoint handler +)();
		b_forced=false;
		b_resumePointTransfer=llo_getInt(b_lastSeenResumePoint);
		@"1:260" b_resumePointTransfer; ! absolute jump
	];
-).

To decide what number is the breakpoint escape chunk address's address: (- b_breakpointEscapeChunk -).
To decide what number is the breakpoint escape chunk's enclosing function's address: (- b_breakpointEscapeChunkFunction -).

A GRIF setup rule (this is the find the breakpoint escape chunk rule):
	let the breakpoint escape chunk address be the breakpoint escape chunk's enclosing function's address plus the size of the function header at address breakpoint escape chunk's enclosing function's address;
	write the integer breakpoint escape chunk address to address breakpoint escape chunk address's address.

A GRIF shielding rule (this is the shield the breakpoint escape chunk rule):
	shield the integer at address breakpoint escape chunk address's address against instrumentation.

Chapter "Breakpoint Insertion"

The resume point adjustment list is a linked list that varies.

To decide what number is the sequence point to graft onto (V - an instruction vertex) with (A - a number) as a backup:
	let the reverse probe vertex be V;
	while the reverse probe vertex is not null:
		let the result be the source address of the reverse probe vertex;
		if the result is a sequence point:
			decide on the result;
		let the old reverse probe vertex be the reverse probe vertex;
		now the reverse probe vertex is the previous link of the reverse probe vertex;
		unless the reverse probe vertex is not null and the fallthrough flag is set in reverse probe vertex:
			now the reverse probe vertex is a null instruction vertex;
			repeat with the jump predecessor running through the instruction vertex keys of the jump predecessor linked list of the old reverse probe vertex:
				unless the jump predecessor is V:
					now the reverse probe vertex is the jump predecessor;
					break;
	decide on A.

To insert a breakpoint before (V - an instruction vertex) for the sequence point (A - a number):
	let the frame-local breakpoint branch instruction vertex be a new frame-local breakpoint branch instruction vertex;
	insert the frame-local breakpoint branch instruction vertex before V;
	let the breakpoint branch instruction vertex be a new breakpoint branch instruction vertex for the sequence point A;
	insert the breakpoint branch instruction vertex before V;
	let the first escape-recording instruction vertex be a new escape-recording instruction vertex for the sequence point A;
	insert the first escape-recording instruction vertex at the end of the arrangement;
	let the second escape-recording instruction vertex be a new escape-recording instruction vertex for a resume point;
	push the key the second escape-recording instruction vertex and the value the breakpoint branch instruction vertex onto the resume point adjustment list;
	insert the second escape-recording instruction vertex at the end of the arrangement;
	let the escape instruction vertex be a new breakpoint escape instruction vertex;
	insert the escape instruction vertex at the end of the arrangement;
	establish a jump link from the frame-local breakpoint branch instruction vertex to the first escape-recording instruction vertex;
	establish a jump link from the breakpoint branch instruction vertex to the first escape-recording instruction vertex.

A first GRIF instrumentation rule (this is the insert breakpoints rule):
	start a new generation of artificial vertices;
	now the resume point adjustment list is an empty linked list;
	let the last-seen sequence point be zero;
	repeat with the instruction vertex running through the scratch space:
		let the candidate sequence point be the source address of the instruction vertex;
		if the candidate sequence point is a sequence point:
			insert a breakpoint before the instruction vertex for the sequence point the candidate sequence point;
			now the last-seen sequence point is the candidate sequence point;
		otherwise if the last-seen sequence point is not zero and the influence on control flow of the instruction vertex is jump without call:
			unless the instruction vertex is artificial:
				[Make sure that obvious infinite loops have at least one sequence point.]
				[Hopefully that can eventually be guaranteed by the I6 compiler because it's not always obvious what sequence point to use for the loop.]
				let the probe vertex be the jump link of the instruction vertex;
				if the probe vertex is null:
					let the parameter limit be the parameter limit of the instruction vertex;
					let the plain chunk mode be the addressing mode of parameter parameter limit of the instruction vertex;
					unless the plain chunk mode is the zero-or-discard addressing mode or the plain chunk mode is the constant addressing mode:
						let the graft sequence point be the sequence point to graft onto the instruction vertex with the last-seen sequence point as a backup;
						insert a breakpoint before the instruction vertex for the sequence point the graft sequence point;
				otherwise:
					let the target address be the source address of the probe vertex;
					if target address is greater than the last-seen sequence point and the target address is at most the candidate sequence point:
						let the graft sequence point be the sequence point to graft onto the instruction vertex with the last-seen sequence point as a backup;
						insert a breakpoint before the instruction vertex for the sequence point the graft sequence point;
		unless the fallthrough flag is set in the instruction vertex:
			now the last-seen sequence point is zero.

A GRIF instrumentation adjustment rule (this is the adjust resume points rule):
	repeat with the linked list vertex running through the resume point adjustment list:
		let the escape-recording instruction vertex be the instruction vertex key of the linked list vertex;
		let the breakpoint branch instruction vertex be the instruction vertex value of the linked list vertex;
		write the addressing mode start-of-vertex addressing mode to parameter zero of the escape-recording instruction vertex;
		write (the next link of the breakpoint branch instruction vertex converted to a number) to parameter zero of the escape-recording instruction vertex.

A GRIF capture rule (this is the capture breakpoint flag address addresses for sequence points rule):
	repeat with the instruction vertex running through the instruction vertex values of the resume point adjustment list:
		if the instruction vertex is a breakpoint branch instruction vertex:
			let the candidate vertex be the jump link of the instruction vertex;
			while the candidate vertex is not null:
				if the candidate vertex is an escape-recording instruction vertex for a sequence point:
					let the sequence point be the sequence point recorded by the escape-recording candidate vertex;
					let the breakpoint flag address address be the beginning of instructions in the emitted chunk plus the destination offset of the instruction vertex plus five [see the layout above];
					insert the key the sequence point and the value the breakpoint flag address address into the breakpoint flag address address hash table;
					insert the key the breakpoint flag address address and the value the sequence point into the reverse breakpoint flag address address hash table;
					break;
				unless the fallthrough flag is set in the candidate vertex:
					break;
				now the candidate vertex is the next link of the candidate vertex;
	delete the resume point adjustment list;
	now the resume point adjustment list is an empty linked list.

Section "Sequence Point Recording for Selects" (for use with Glk Interception by Brady Garvin)

A GRIF instrumentation rule (this is the record sequence points for selects rule):
	repeat with the instruction vertex running through occurrences of the operation code op-glk in the scratch space:
		let the identifier mode be the addressing mode of parameter zero of the instruction vertex;
		let the identifier parameter be parameter zero of the instruction vertex;
		if the identifier mode is not the constant addressing mode or the identifier parameter is 192 [glk_select]:
			let the backup sequence point be zero;
			repeat with the candidate backup sequence point running through the number keys of the sequence point linked list of the routine record for the address of the function owning the chunk being instrumented:
				if the candidate backup sequence point is unsigned less than the backup sequence point or the backup sequence point is zero:
					now the backup sequence point is the candidate backup sequence point;
			let the sequence point be the sequence point to graft onto the instruction vertex with the backup sequence point as a backup;
			[The sequence point could be zero if glk_select is called from a pure assembly routine, and, unfortunately, we can't do anything about that.]
			let the escape-recording instruction vertex be a new escape-recording instruction vertex for the sequence point the sequence point;
			insert the escape-recording instruction vertex before the instruction vertex.

The record sequence points for selects rule is listed before the replace Glk invocations rule in the GRIF instrumentation rulebook.

Section "Sequence Point Recording for Yields" (for use with Glk Interception by Brady Garvin)

A GRIF instrumentation rule (this is the record sequence points for yields rule):
	repeat with the instruction vertex running through occurrences of the operation code op-jz in the scratch space:
		if the instruction vertex is a yield branch instruction vertex:
			if the sequence point linked list of the routine record for the address of the function owning the chunk being instrumented is empty:
				[Disable the yield.]
				let the yield-countdown-incrementing instruction vertex be a new yield-countdown-incrementing instruction vertex;
				insert the yield-countdown-incrementing instruction vertex before the instruction vertex;
				establish a jump link from the instruction vertex to the next link of the instruction vertex;
			otherwise:
				let the backup sequence point be a number;
				repeat with the candidate backup sequence point running through the number keys of the sequence point linked list of the routine record for the address of the function owning the chunk being instrumented:
					if the candidate backup sequence point is unsigned less than the backup sequence point or the backup sequence point is zero:
						now the backup sequence point is the candidate backup sequence point;
				let the sequence point be the sequence point to graft onto the instruction vertex with the backup sequence point as a backup;
				always check that the sequence point is not zero or else fail at finding a sequence point for a yield;
				let the escape-recording instruction vertex be a new escape-recording instruction vertex for the sequence point the sequence point;
				insert the escape-recording instruction vertex before the jump link of the instruction vertex.

The record sequence points for yields rule is listed after the insert yields rule in the GRIF instrumentation rulebook.

Book "Simple Breakpoints"

Chapter "Breakpoint Flag Address Addresses"

[Associates sequence points with breakpoint flag address addresses.]
The breakpoint flag address address hash table is a permanent hash table that varies.

[Associates breakpoint flag address addresses with sequence points.]
The reverse breakpoint flag address address hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate a hash table for the breakpoint flag address addresses rule):
	now the breakpoint flag address address hash table is a new permanent hash table with the breakpoint flag address address hash table size buckets;
	now the reverse breakpoint flag address address hash table is a new permanent hash table with the breakpoint flag address address hash table size buckets.

Chapter "Simple Breakpoints"

Section "The Simple Breakpoint Kind" - unindexed

A simple breakpoint is a kind of value.
A simple breakpoint is an invalid simple breakpoint.  [See the note in the book "Extension Information."]
The specification of a simple breakpoint is "Simple breakpoints represent conditional interruption at one particular sequence point.  Simple breakpoints are generally aggregated into compound breakpoints; the extension Breakpoints will enable a simple breakpoint whenever it is a member of an enabled compound breakpoint."

Section "The Simple Breakpoint Structure" - unindexed

[Layout:
	4 bytes for the sequence point
	4 bytes for the breakpoint flag
	4 bytes for the replaced breakpoint flag address
	4 bytes for the compound breakpoint list]
[Simple breakpoints do not manage the lifetime of their linked lists; they should only be deleted when the list is empty.]

To decide what number is the size of a simple breakpoint: (- 16 -).

Section "Simple Breakpoint Construction and Destruction"

The simple breakpoint object pool is an object pool that varies.

A GRIF setup rule (this is the allocate an object pool for simple breakpoints rule):
	now the simple breakpoint object pool is a new permanent object pool with the simple breakpoint preallocation objects of size the size of a simple breakpoint bytes.

[This constructor is for internal use only.]
To decide what simple breakpoint is a new unhashed simple breakpoint for the sequence point (A - a number):
	let the result be a memory allocation from the simple breakpoint object pool converted to a simple breakpoint;
	zero the size of a simple breakpoint bytes at address result converted to a number;
	write the sequence point A to the result;
	let the index be the phrase that chooses the universal breakpoint flag index for a sequence point applied to A;
	write the replaced breakpoint flag address universal breakpoint flag address index to the result;
	decide on the result.

[This destructor is for internal use only.]
To delete (A - a simple breakpoint):
	if the compound breakpoint list of A is not empty:
		fail at deleting a simple breakpoint still in use;
	free the memory allocation at address (A converted to a number) to the simple breakpoint object pool.

Section "Simple Breakpoint Accessors and Mutators"

To decide what number is the sequence point of (A - a simple breakpoint): (- llo_getInt({A}) -).
To write the sequence point (X - a number) to (A - a simple breakpoint): (- llo_setInt({A},{X}); -).

To decide what number is the breakpoint flag address of (A - a simple breakpoint): (- ({A}+4) -).
To decide whether the breakpoint flag is set in (A - a simple breakpoint): (- llo_getField({A},1) -).
To reset the breakpoint flag in (A - a simple breakpoint): (- llo_setField({A},1,0); -).
To set the breakpoint flag in (A - a simple breakpoint): (- llo_setField({A},1,1); -).

To decide what number is the replaced breakpoint flag address of (A - a simple breakpoint): (- llo_getField({A},2) -).
To write the replaced breakpoint flag address (X - a number) to (A - a simple breakpoint): (- llo_setField({A},2,{X}); -).

To decide what linked list is the compound breakpoint list of (A - a simple breakpoint): (- ({A}-->3) -).
To write the compound breakpoint list (X - a linked list) to (A - a simple breakpoint): (- llo_setField({A},3,{X}); -).

To decide whether (A - a simple breakpoint) is attached to an enabled compound breakpoint:
	repeat with the compound breakpoint running through the compound breakpoint keys of the compound breakpoint list of A:
		if the compound breakpoint is enabled:
			decide yes;
	decide no.

Chapter "The Simple Breakpoint Hash Table"

[Associates sequence points with simple breakpoints.]
The simple breakpoint hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for the simple breakpoints rule):
	now the simple breakpoint hash table is a new hash table with the simple breakpoint hash table size buckets.

Section "Private Simple Breakpoint Hash Table Accessors and Mutators" - unindexed

To reclaim (B - a simple breakpoint) if possible:
	if the compound breakpoint list of B is empty:
		let the sequence point be the sequence point of B;
		repeat with the breakpoint flag address address running through the number values matching the key the sequence point in the breakpoint flag address address hash table:
			let the replaced breakpoint flag address be the replaced breakpoint flag address of B;
			write the integer the replaced breakpoint flag address to address the breakpoint flag address address;
		remove the first occurrence of the key the sequence point from the simple breakpoint hash table;
		delete B;
	otherwise if the breakpoint flag is set in B:
		unless B is attached to an enabled compound breakpoint:
			reset the breakpoint flag in B.

Section "Public Simple Breakpoint Hash Table Accessors and Mutators"

To decide what simple breakpoint is the simple breakpoint representing the sequence point (A - a number):
	decide on the first simple breakpoint value matching the key A in the simple breakpoint hash table or an invalid simple breakpoint if there are no matches;

To decide what simple breakpoint is the legal simple breakpoint representing the sequence point (A - a number) once attached to (C - a compound breakpoint):
	let the result be the first simple breakpoint value matching the key A in the simple breakpoint hash table or an invalid simple breakpoint if there are no matches;
	if the result is an invalid simple breakpoint:
		now the result is a new unhashed simple breakpoint for the sequence point A;
		insert the key A and the value the result into the simple breakpoint hash table;
		let the breakpoint flag address be the breakpoint flag address of the result;
		repeat with the breakpoint flag address address running through the number values matching the key A in the breakpoint flag address address hash table:
			write the integer the breakpoint flag address to address the breakpoint flag address address;
		push the key C onto the compound breakpoint list of the result;
		push the key the result onto the simple breakpoint list of C;
	otherwise unless the compound breakpoint list of the result contains the key C:
		push the key C onto the compound breakpoint list of the result;
		push the key the result onto the simple breakpoint list of C;
	decide on the result.

To attach the sequence point (A - a number) to (C - a compound breakpoint):
	let the discarded value be the legal simple breakpoint representing the sequence point A once attached to C.

To detach (B - a simple breakpoint) from (C - a compound breakpoint):
	remove the first occurrence of the key B from the simple breakpoint list of C;
	remove the first occurrence of the key C from the compound breakpoint list of B;
	reclaim B if possible.

To clear (C - a compound breakpoint):
	while the simple breakpoint list of C is not empty:
		let the simple breakpoint be a simple breakpoint key popped off of the simple breakpoint list of C;
		remove the first occurrence of the key C from the compound breakpoint list of the simple breakpoint;
		reclaim the simple breakpoint if possible.

Book "Compound Breakpoints"

Chapter "Compound Breakpoints"

Section "The Compound Breakpoint Kind" - unindexed

A compound breakpoint is a kind of value.
A compound breakpoint is an invalid compound breakpoint.  [See the note in the book "Extension Information."]
The specification of a compound breakpoint is "Compound breakpoints represent conditional interruption, possibly at several sequence point.  Because they hide the details of multiple sequence points per logical breakpoint and breakpoint interaction, they correspond to an author's concept of a breakpoint."

Section "The Compound Breakpoint Structure" - unindexed

[Layout:
	4 bytes for the numeric identifier
	4 bytes for the human-friendly name as synthetic text
	4 bytes for the simple breakpoint list
	4 bytes for the enabled flag]
[Compound breakpoints manage the lifetime of their human-friendly names; those names will be deleted when the breakpoint is.]
[By virtue of phrases in earlier books, compound breakpoints manage the lifetime of their simple breakpoints.]

To decide what number is the size of a compound breakpoint: (- 16 -).

Section "Breakpoint Counter"

The breakpoint counter is a number that varies.  The breakpoint counter is zero.

Section "Compound Breakpoint Construction and Destruction"

[T need not be synthetic; it will be copied.]
To decide what compound breakpoint is a new compound breakpoint with human-friendly name (T - some text):
	let the result be a memory allocation of the size of a compound breakpoint bytes converted to a compound breakpoint;
	zero the size of a compound breakpoint bytes at address the result converted to a number;
	write the numeric identifier the breakpoint counter to the result;
	increment the breakpoint counter;
	let the human-friendly name be a new synthetic text copied from T;
	write the human-friendly name the human-friendly name to the result;
	decide on the result.

To decide what compound breakpoint is a new unnumbered compound breakpoint with human-friendly name (T - some text):
	let the result be a memory allocation of the size of a compound breakpoint bytes converted to a compound breakpoint;
	zero the size of a compound breakpoint bytes at address the result converted to a number;
	write the numeric identifier -1 to the result;
	let the human-friendly name be a new synthetic text copied from T;
	write the human-friendly name the human-friendly name to the result;
	decide on the result.

To delete (A - a compound breakpoint):
	disable A;
	delete the synthetic text the human-friendly name of A;
	clear A;
	free the memory allocation at address A converted to a number.

Section "Compound Breakpoint Accessors and Mutators"

To decide what number is the numeric identifier of (A - a compound breakpoint): (- llo_getInt({A}) -).
To write the numeric identifier (X - a number) to (A - a compound breakpoint): (- llo_setInt({A},{X}); -).

To decide what text is the human-friendly name of (A - a compound breakpoint): (- llo_getField({A},1) -).
To write the human-friendly name (X - some text) to (A - a compound breakpoint): (- llo_setField({A},1,{X}); -).

To decide what linked list is the simple breakpoint list of (A - a compound breakpoint): (- ({A}-->2) -).
To write the simple breakpoint list (X - a linked list) to (A - a compound breakpoint): (- llo_setField({A},2,{X}); -).

To decide whether (A - a compound breakpoint) is disabled: (- (~~llo_getField({A},3)) -).
To decide whether (A - a compound breakpoint) is enabled: (- llo_getField({A},3) -).
To reset the enabled flag in (A - a compound breakpoint): (- llo_setField({A},3,0); -).
To set the enabled flag in (A - a compound breakpoint): (- llo_setField({A},3,1); -).

To disable (A - a compound breakpoint):
	if A is enabled:
		reset the enabled flag in A;
		repeat with the simple breakpoint running through the simple breakpoint keys of the simple breakpoint list of A:
			unless the simple breakpoint is attached to an enabled compound breakpoint:
				reset the breakpoint flag in the simple breakpoint.

To enable (A - a compound breakpoint):
	if A is disabled:
		set the enabled flag in A;
		repeat with the simple breakpoint running through the simple breakpoint keys of the simple breakpoint list of A:
			set the breakpoint flag in the simple breakpoint.

Chapter "The Universal Breakpoint as a Compound Breakpoint"

Section "Universal Breakpoint Accessors and Mutators"

To disable the universal breakpoint in flag (I - a number) (this is disabling the universal breakpoint in one flag):
	if universal breakpoint flag I is set:
		reset universal breakpoint flag I;
		let the replaced breakpoint flag address be universal breakpoint flag address I;
		repeat with the simple breakpoint running through the simple breakpoint values of the simple breakpoint hash table:
			if the replaced breakpoint flag address of the simple breakpoint is the replaced breakpoint flag address:
				if the simple breakpoint is attached to an enabled compound breakpoint:
					set the breakpoint flag in the simple breakpoint;
				otherwise:
					reset the breakpoint flag in the simple breakpoint.

To enable the universal breakpoint in flag (I - a number) (this is enabling the universal breakpoint in one flag):
	unless universal breakpoint flag I is set:
		set universal breakpoint flag I;
		let the replaced breakpoint flag address be universal breakpoint flag address I;
		repeat with the simple breakpoint running through the simple breakpoint values of the simple breakpoint hash table:
			if the replaced breakpoint flag address of the simple breakpoint is the replaced breakpoint flag address:
				set the breakpoint flag in the simple breakpoint.

To disable the universal breakpoint (this is disabling the universal breakpoint):
	let idempotent be true;
	repeat with the index running over the half-open interval from zero to the number of universal breakpoint flags:
		if universal breakpoint flag index is set:
			now idempotent is false;
			break;
	if idempotent is true:
		stop;
	repeat with the index running over the half-open interval from zero to the number of universal breakpoint flags:
		reset universal breakpoint flag index;
	repeat with the simple breakpoint running through the simple breakpoint values of the simple breakpoint hash table:
		if the simple breakpoint is attached to an enabled compound breakpoint:
			set the breakpoint flag in the simple breakpoint;
		otherwise:
			reset the breakpoint flag in the simple breakpoint.

To enable the universal breakpoint (this is enabling the universal breakpoint):
	let idempotent be true;
	repeat with the index running over the half-open interval from zero to the number of universal breakpoint flags:
		unless universal breakpoint flag index is set:
			now idempotent is false;
			break;
	if idempotent is true:
		stop;
	repeat with the index running over the half-open interval from zero to the number of universal breakpoint flags:
		set universal breakpoint flag index;
	repeat with the simple breakpoint running through the simple breakpoint values of the simple breakpoint hash table:
		set the breakpoint flag in the simple breakpoint.

Section "Forcing a Breakpoint"

Include (-
	Global b_forced = false;
-) after "Definitions.i6t".

[This phrase is for use in instrumented code.]
[The @nop is to give an extra sequence point.]
To force a breakpoint named (T - some text): (- b_forced={T};(llo_getField((+ enabling the universal breakpoint +),1))();@nop; -).

To decide whether the breakpoint was forced: (- b_forced -).
To decide what text is the name of the forced breakpoint: (- b_forced -).

A GRIF shielding rule (this is the shield toggling the universal breakpoint from instrumentation rule):
	shield the function address of disabling the universal breakpoint against instrumentation;
	shield the function address of enabling the universal breakpoint against instrumentation.

Breakpoints ends here.

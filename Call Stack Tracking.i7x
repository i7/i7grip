Version 1 of Call Stack Tracking (for Glulx only) by Brady Garvin begins here.

"Tracks which parts of the story the interpreter is executing."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Object Pools by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include I6 Routine Names by Brady Garvin.
Include Human-Friendly Function Names by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2012 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[For each of the kinds defined by Call Stack Tracking you will see a sentence like

	A call frame is an invalid call frame.

This bewildering statement actually sets up call frames as a qualitative value with default value the call frame at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on call frames.]

Chapter "Use Options" - unindexed

Use a call substack hash table size of at least 2311 translates as (- Constant CST_CALL_SUBSTACK_HASH_SIZE={N}; -).
Use a call stack reconstruction hash table size of at least 311 translates as (- Constant CST_RECONSTRUCTION_HASH_SIZE={N}; -).
Use an elided function hash table size of at least 1123 translates as (- Constant CST_ELIDED_FUNCTION_HASH_SIZE={N}; -).

Use a call stack vertex preallocation of at least 128 translates as (- Constant CST_CALL_STACK_VERTEX_PREALLOC={N}; -).

To decide what number is the call substack hash table size: (- CST_CALL_SUBSTACK_HASH_SIZE -).
To decide what number is the call stack reconstruction hash table size: (- CST_RECONSTRUCTION_HASH_SIZE -).
To decide what number is the elided function hash table size: (- CST_ELIDED_FUNCTION_HASH_SIZE -).

To decide what number is the call stack vertex preallocation: (- CST_CALL_STACK_VERTEX_PREALLOC -).

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at giving a call frame several children:
	say "[low-level runtime failure in]Call Stack Tracking[with explanation]I tried to reconstruct the call stack, but I found several outstanding calls from a single call frame; the reconstruction machinery must have gone wrong somewhere.[terminating the story]".

To fail at reconstructing a call from a non-call:
	say "[low-level runtime failure in]Call Stack Tracking[with explanation]I tried to reconstruct the call stack, but I found an outstanding call from an instruction that cannot call anything; the reconstruction machinery must have gone wrong somewhere.[terminating the story]".

To fail at recording extra non-stack call arguments:
	say "[low-level runtime failure in]Call Stack Tracking[with explanation]While I was adding code to keep track of the call stack, I found a call instruction that seems to pass arguments both on the stack and as assembly parameters.  But no such instructions exist, as far as I know.  Most likely the instruction decoding machinery has been derailed.[terminating the story]".

To fail at finding a call stack vertex for an instrumented function:
	say "[runtime failure in]Call Stack Tracking[with explanation]While I was revising code to keep track of the call stack, I discovered that this code refers to memory that was never set aside.  Either you've unlisted rules that I need or something has gone terribly wrong.[terminating the story]".

To fail at finding a corresponding peek jump lookup instruction:
	say "[low-level runtime failure in]Call Stack Tracking[with explanation]While I was revising code to keep track of the call stack, I found that the argument-recording code had been fragmented by intervening jumps, making me uncertain about which instructions are the associated ones.  The most likely culprit is an interaction between Call Stack Tracking and some other instrumentation whose rules appear later in the GRIF instrumentation rulebook.  (Call Stack Tracking rules should almost always come last, so perhaps there was a rule-ordering mistake?)[terminating the story]".

To fail at finding a corresponding peek instruction:
	say "[low-level runtime failure in]Call Stack Tracking[with explanation]While I was revising code to keep track of the call stack, I found at least one excess instruction embedded in conditional argument-recording code, which is almost certainly wrong.  The most likely culprits are (1) an interaction between Call Stack Tracking and some other instrumentation whose rules appear later in the GRIF instrumentation rulebook or (2) flat-out bugs in such rules.  (Call Stack Tracking rules should almost always come last, so perhaps a rule-ordering mistake caused an unintended interaction?)[terminating the story]".

Book "The Call Stack"

Part "Internal Representation"

Chapter "Call Stack Vertices"

Section "The Call Stack Vertex Kind" - unindexed

A call stack vertex is a kind of value.  The plural of call stack vertex is call stack vertices.
A call stack vertex is an invalid call stack vertex.  [See the note in the book "Extension Information."]
The specification of a call stack vertex is "Call stack vertices are Call Stack Tracking's internal analog to call frames.  When combined with knowledge of the uninstrumented function address of the outermost instrumented function, call stack vertices contain enough information to reconstruct the call stack.  They keep this data in a format that is easy for instrumentation to update, but not very convenient for anything else.  Consequently, they are not much use outside of Call Stack Tracking's internals."

Section "Call Stack Vertex Constants" - unindexed

To decide what call stack vertex is a null call stack vertex: (- 0 -).

Section "Call Stack Vertex Adjectives" - unindexed

Definition: a call stack vertex is null if it is a null call stack vertex.

Section "The Call Stack Vertex Structure" - unindexed

[Layout:
	4 bytes for the nearest same-function ancestor vertex (the invalid call stack vertex if the vertex is not on the call stack, null if there is no such ancestor)
	4 bytes for the catch token linked list
	64 bytes for the current locals
	4 bytes for the address of the most recent call instruction
	4 bytes for the number of arguments passed in the most recent call (not valid for calls taking a fixed number of arguments)
	4 bytes for the uninstrumented address of the function called (not valid for calls taking a constant or local destination)
	64 bytes for the arguments passed (not valid for the out-of-bounds arguments or arguments that were passed directly from constants or locals)
	4*? bytes for extras]

To decide what number is the base size in memory of a call stack vertex: (- 148 -).
The mutable size in memory of a call stack vertex is a number that varies.  The mutable size in memory of a call stack vertex is 148.
To decide what number is the size in memory of a call stack vertex: (- (+ the mutable size in memory of a call stack vertex +) -).	

Section "Extra Fields in Call Stack Vertices"

To decide what number is the index of a newly reserved call frame field:
	let the result be the size in memory of a call stack vertex divided by four;
	increase the mutable size in memory of a call stack vertex by four;
	decide on the result.

Section "Call Stack Vertex Construction and Destruction" - unindexed

To decide what call stack vertex is a new permanent call stack vertex:
	let the result be a permanent memory allocation of the size in memory of a call stack vertex bytes converted to a call stack vertex;
	write the nearest same-function ancestor the invalid call stack vertex to the result;
	write the catch token linked list an empty linked list to the result;
	write the most recent call instruction address zero to the result;
	decide on the result.

The call stack vertex object pool is a object pool that varies.

[Because GRIF setup rules determine the size of the call stack, we must not allocate the pool in the setup rulebook---we have to wait for the final size and do the allocation in the anticipation rulebook.]
A GRIF anticipation rule (this is the allocate a object pool for call stack vertices rule):
	now the call stack vertex object pool is a new permanent object pool with the call stack vertex preallocation objects of size the size in memory of a call stack vertex bytes.

To decide what call stack vertex is a new ancestor call stack vertex copied from (A - a call stack vertex):
	let the result be a memory allocation from the call stack vertex object pool converted to a call stack vertex;
	copy A to the result;
	write the nearest same-function ancestor result to A;
	decide on the result.

To delete (A - a call stack vertex):
	free the memory allocation at address (A converted to a number) to the call stack vertex object pool.

Section "Copying Call Stack Vertices" - unindexed

To copy (A - a call stack vertex) to (B - a call stack vertex):
	copy the size in memory of a call stack vertex bytes from address (A converted to a number) to address (B converted to a number).

Section "Annexing and Ceding Call Stack Vertices" - unindexed

To annex a call stack vertex to replace (A - a call stack vertex) (this is annexing a call stack vertex):
	let the discarded value be a new ancestor call stack vertex copied from A;
	write the most recent call instruction address zero to A;
	zero the size in memory of a call stack vertex minus the base size in memory of a call stack vertex bytes at address A converted to a number plus the base size in memory of a call stack vertex.

To cede (A - a call stack vertex) (this is ceding a call stack vertex):
	let the ancestor call stack vertex be the nearest same-function ancestor of A;
	copy the ancestor call stack vertex to A;
	delete the ancestor call stack vertex.

Section "Call Stack Vertex Accessors and Mutators" - unindexed

To decide what number is the nearest same-function ancestor address of (A - a call stack vertex): (- {A} -).
To decide what call stack vertex is the nearest same-function ancestor of (A - a call stack vertex): (- llo_getInt({A}) -).
To decide whether (A - a call stack vertex) is occupied:
	decide on whether or not the nearest same-function ancestor of A is not an invalid call stack vertex.
To write the nearest same-function ancestor (X - a call stack vertex) to (A - a call stack vertex): (- llo_setInt({A},{X}); -).

To decide what number is the catch token linked list address of (A - a call stack vertex): (- ({A}+4) -).
To decide what linked list is the catch token linked list of (A - a call stack vertex): (- ({A}-->1) -).
To write the catch token linked list (X - a linked list) to (A - a call stack vertex): (- llo_setField({A},1,{X}); -).

To decide what number is local address (I - a number) of (A - a call stack vertex): (- ({A}+8+4*{I}) -).
To decide what number is the local index for the local address (B - a number) in (A - a call stack vertex): (- (({B}-{A}-8)/4) -).
To decide what number is local (I - a number) of (A - a call stack vertex): (- llo_getField({A},2+{I}) -).
To write (X - a number) to local (I - a number) of (A - a call stack vertex): (- llo_setField({A},2+{I},{X}); -).

To decide what number is the most recent call instruction address address of (A - a call stack vertex): (- ({A}+72) -).
To decide what number is the most recent call instruction address of (A - a call stack vertex): (- llo_getField({A},18) -).
To write the most recent call instruction address (X - a number) to (A - a call stack vertex): (- llo_setField({A},18,{X}); -).

To decide what number is the most recent outgoing argument count address of (A - a call stack vertex): (- ({A}+76) -).
To decide what number is the most recent outgoing argument count of (A - a call stack vertex): (- llo_getField({A},19) -).
To write the most recent outgoing argument count (X - a number) to (A - a call stack vertex): (- llo_setField({A},19,{X}); -).

To decide what number is the address for outgoing call parameter (I - a number) of (A - a call stack vertex): (- ({A}+80+4*{I}) -).
To decide what number is the address for outgoing argument (I - a number) of (A - a call stack vertex): (- ({A}+84+4*{I}) -).
To decide what number is the most recent uninstrumented call destination of (A - a call stack vertex): (- llo_getField({A},20) -).
To decide what number is most recent outgoing argument (I - a number) of (A - a call stack vertex): (- llo_getField({A},21+{I}) -).
To write (X - a number) to most recent outgoing call parameter (I - a number) of (A - a call stack vertex): (- llo_setField({A},20+{I},{X}); -).

To decide what number is extra field (I - a number) of (A - a call stack vertex): (- llo_getField({A},{I}) -).
To decide what number is extra field address (I - a number) of (A - a call stack vertex): (- ({A}+4*{I}) -).
To write (X - a value) to extra field (I - a number) of (A - a call stack vertex): (- llo_setField({A},{I},{X}); -).

Section "Iteration over Call Stack Vertices" - unindexed

To repeat with (I - a nonexisting call stack vertex variable) running through (A - a call stack vertex) and its same-function ancestors begin -- end: (-
	for({I}={A}:{I}&&({I}~=1):{I}=llo_getInt({I}))
-).

Section "Shielding for Call Stack Vertex Phrases"

A GRIF shielding rule (this is the shield the phrases that annex and cede call stack vertices rule):
	shield annexing a call stack vertex against instrumentation;
	shield ceding a call stack vertex against instrumentation.

Chapter "The Call Substack Hash Table" - unindexed

The call substack hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for the call substacks rule):
	now the call substack hash table is a new hash table with the call substack hash table size buckets.

Chapter "The Outermost Instrumented Function"

The uninstrumented function address of the outermost instrumented function is a number that varies.  The uninstrumented function address of the outermost instrumented function is zero.

Part "External Representation"

Chapter "Call Frames"

Section "The Call Frame Kind"

A call frame is a kind of value.
A call frame is an invalid call frame.  [See the note in the book "Extension Information."]
The specification of a call frame is "Call frames represent an outstanding call to a Glulx function.  They store the function's address, its original arguments and how those arguments were passed, the current values of the call's temporary named values, the catch tokens generated by the call, and its position relative to other outstanding calls.  They also track the most recent instruction to be executed in every call except the most recent one."

Section "Call Frame Constants"

To decide what call frame is a null call frame: (- 0 -).

Section "Call Frame Adjectives"

Definition: a call frame is null if it is a null call frame.

Section "The Call Frame Structure" - unindexed

[Layout:
	4 bytes for the uninstrumented function address
	4 bytes for the call stack vertex
	4 bytes for the most recent instruction address
	4 bytes for the outward link (null if this frame is on the bottom)
	4 bytes for the inward link (null if this frame is on the top)]
[Ordinarily we would have a linked list of structures rather than structures with links inside.  In this case, however, some of the data that we think of as being owned by a call frame are really owned by a neighboring call frame, so it's easier if frames know who they're next to.]
[The most recent instruction address is kept here (rather than computed by referring to the linked vertex) only for the purposes of Interactive Debugger.]

To decide what number is the size in memory of a call frame: (- 20 -).

Section "Call Frame Construction" - unindexed

To decide what call frame is a new call frame for the uninstrumented function address (A - a number) and (V - a call stack vertex) and the parent (P - a call frame):
	let the result be a memory allocation of the size in memory of a call frame bytes converted to a call frame;
	write the uninstrumented function address A to the result;
	write the call stack vertex V to the result;
	write the most recent instruction address the most recent call instruction address of V to the result;
	write the outward link P to the result;
	write the inward link a null call frame to the result;
	unless P is null:
		always check that the inward link of P is a null call frame or else fail at giving a call frame several children;
		write the inward link result to P;
	decide on the result.

Section "Call Frame Destruction"

To delete (A - a call frame) and its ancestors:
	if A is an invalid call frame or A is null:
		stop;
	let the link be the outward link of A;
	free the memory allocation at address A converted to a number;
	while the link is not null:
		let the frame be the link;
		now the link is the outward link of the frame;
		free the memory allocation at address frame converted to a number.

Section "Private Call Frame Accessors and Mutators" - unindexed

To write the uninstrumented function address (X - a number) to (A - a call frame): (- llo_setInt({A},{X}); -).

To decide what call stack vertex is the call stack vertex of (A - a call frame): (- llo_getField({A},1) -).
To write the call stack vertex (X - a call stack vertex) to (A - a call frame): (- llo_setField({A},1,{X}); -).

To write the outward link (X - a call frame) to (A - a call frame): (- llo_setField({A},3,{X}); -).

To write the inward link (X - a call frame) to (A - a call frame): (- llo_setField({A},4,{X}); -).

To decide what number is the most recent outgoing argument count of (A - a call frame):
	decide on the most recent outgoing argument count of the call stack vertex of A.

To decide what number is most recent outgoing argument (I - a number) of (A - a call frame):
	decide on most recent outgoing argument I of the call stack vertex of A.

Section "Public Call Frame Accessors and Mutators"

To decide what number is the uninstrumented function address of (A - a call frame): (- llo_getInt({A}) -).

To decide whether (A - a call frame) had its original arguments passed on the stack:
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	decide on whether or not the byte at address the actual function address is not 193.

To decide what call frame is the outward link of (A - a call frame): (- llo_getField({A},3) -).

To decide what call frame is the inward link of (A - a call frame): (- llo_getField({A},4) -).

To decide what call frame is the root of (A - a call frame):
	if A is null:
		decide on a null call frame;
	let the current call frame be A;
	while the outward link of the current call frame is not null:
		now the current call frame is the outward link of the current call frame;
	decide on the current call frame.

To decide what call frame is the leaf of (A - a call frame):
	if A is null:
		decide on a null call frame;
	let the current call frame be A;
	while the inward link of the current call frame is not null:
		now the current call frame is the inward link of the current call frame;
	decide on the current call frame.

To decide what linked list is the catch token linked list of (A - a call frame):
	[We intentionally return a r-value, not an l-value.]
	decide on the catch token linked list of the call stack vertex of A.

To decide what number is the temporary named value count of (A - a call frame):
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	decide on the local count of the function at address the actual function address.

To decide what number is temporary named value (I - a number) of (A - a call frame):
	decide on local I of the call stack vertex of A.

To write (X - a number) to temporary named value (I - a number) of (A - a call frame):
	write X to local I of the call stack vertex of A.

To decide whether the original arguments of (A - a call frame) are known:
	decide on whether or not the outward link of A is not null.

To decide what number is the original argument count of (A - a call frame):
	if the original arguments of A are known:
		decide on the most recent outgoing argument count of the outward link of A;
	decide on zero.

To decide what number is original argument (I - a number) of (A - a call frame):
	decide on most recent outgoing argument I of the outward link of A.

To decide what number is the most recent instruction address of (A - a call frame): (- llo_getField({A},2) -).
To write the most recent instruction address (X - a number) to (A - a call frame): (- llo_setField({A},2,{X}); -).

To decide what number is extra field (I - a number) of (A - a call frame):
	decide on extra field I of the call stack vertex of A.

To decide what number is extra field address (I - a number) of (A - a call frame):
	decide on extra field address I of the call stack vertex of A.

To write (X - a value) to extra field (I - a number) of (A - a call frame):
	write X to extra field I of the call stack vertex of A.

Section "Iteration over Call Frames"

To repeat with (I - a nonexisting call frame variable) running through (A - a call frame) and its ancestors begin -- end: (-
	for({I}={A}:{I}:{I}=llo_getField({I},3))
-).

Part "Converting from the Internal Representation to the External Representation"

Chapter "Call Frame Reconstruction"

To decide what call frame is the innermost call frame of a reconstructed call stack (this is reconstructing a call stack):
	let the reconstruction hash table be a new hash table with the call stack reconstruction hash table size buckets;
	let the current call frame be a null call frame;
	let the current function address be the uninstrumented function address of the outermost instrumented function;
	repeat until a break:
		let the first call stack vertex be the first call stack vertex value matching the key the current function address in the call substack hash table or an invalid call stack vertex if there are no matches;
		let the current call stack vertex be the first call stack vertex value matching the key the current function address in the reconstruction hash table or an invalid call stack vertex if there are no matches;
		if the current call stack vertex is an invalid call stack vertex:
			unless the first call stack vertex is occupied:
				break;
			insert the key the current function address and the value a null call stack vertex into the reconstruction hash table;
			repeat with the discovered call stack vertex running through the first call stack vertex and its same-function ancestors:
				insert the key the current function address and the value the discovered call stack vertex into the reconstruction hash table;
			now the current call stack vertex is the first call stack vertex value matching the key the current function address in the reconstruction hash table or an invalid call stack vertex if there are no matches;
		if the current call stack vertex is null:
			break;
		remove the first occurrence of the key the current function address from the reconstruction hash table;
		now the current call frame is a new call frame for the uninstrumented function address current function address and the current call stack vertex and the parent the current call frame;
		if the most recent call instruction address of the current call stack vertex is zero:
			break;
		let the instruction vertex be a new instruction vertex for the instruction at address the most recent call instruction address of the current call stack vertex, detached from the scratch space;
		check that the influence on control flow of the instruction vertex is function call or else fail at reconstructing a call from a non-call;
		let the operation code be the operation code of the instruction vertex;
		if the operation code is op-call or the operation code is op-tailcall:
			let the parameter mode be the addressing mode of parameter one of the instruction vertex;
			let the parameter be parameter one of the instruction vertex;
			if the parameter mode is:
				-- the zero-or-discard addressing mode:
					write the most recent outgoing argument count zero to the current call stack vertex;
				-- the constant addressing mode:
					write the most recent outgoing argument count parameter to the current call stack vertex;
				-- the zero-based-dereference addressing mode:
					let the local index be the local index for the local address parameter in the first call stack vertex;
					if the local index is unsigned less than 16:
						write the most recent outgoing argument count local local index of the current call stack vertex to the current call stack vertex;
		otherwise:
			let the argument count be the load parameter limit of the instruction vertex;
			write the most recent outgoing argument count argument count to the current call stack vertex;
			repeat with the parameter index running from one to the argument count:
				let the parameter mode be the addressing mode of parameter parameter index of the instruction vertex;
				let the parameter be parameter parameter index of the instruction vertex;
				if the parameter mode is:
					-- the zero-or-discard addressing mode:
						write zero to most recent outgoing call parameter parameter index of the current call stack vertex;
					-- the constant addressing mode:
						write the parameter to most recent outgoing call parameter parameter index of the current call stack vertex;
					-- the zero-based-dereference addressing mode:
						let the local index be the local index for the local address parameter in the first call stack vertex;
						if the local index is unsigned less than 16:
							write local local index of the current call stack vertex to most recent outgoing call parameter parameter index of the current call stack vertex;
		delete the instruction vertex;
		now the current function address is the most recent uninstrumented call destination of the current call stack vertex;
		now the current function address is the first number value matching the key current function address in the instrumented chunks hash table or zero if there are no matches;
		now the current function address is the first number value matching the key current function address in the instrumented chunk origin hash table or zero if there are no matches;
	delete the reconstruction hash table;
	decide on the current call frame.

Chapter "Shielding for Call Frame Reconstruction"

A GRIF shielding rule (this is the shield the phrases that reconstruct the call stack rule):
	shield reconstructing a call stack against instrumentation.

Part "Saying the Call Stack"

Chapter "Call Stack Preferences"

The original arguments flag is a truth state that varies.  The original arguments flag is false.
The temporary named values flag is a truth state that varies.  The temporary named values flag is false.
The catch tokens flag is a truth state that varies.  The catch tokens flag is false.
The call stack simplification flag is a truth state that varies.  The call stack simplification flag is true.
The call frame numbering flag is a truth state that varies.  The call frame numbering flag is false.
The call stack addresses flag is a truth state that varies.  The call stack addresses flag is false.

Chapter "Pretending to Ensure that All Routines have Names" (for use without Debug File Parsing by Brady Garvin)

To ensure that all routines have names: (- -).

Chapter "Printing Regardless of Kind Name" (for use without Printing according to Kind Names by Brady Garvin)

To say (X - a number) according to the kind named (T - some text):
	say "[X converted to a number]".

Chapter "Locations for Finding I7 Local Names"

Section "No Innermost Location Available for Finding I7 Local Names" (for use without Interactive Debugger by Brady Garvin)

To decide what number is the last-seen innermost sequence point:
	decide on zero.

Section "Breakpoint-Based Innermost Location for Finding I7 Local Names" (for use with Interactive Debugger by Brady Garvin)

To decide what number is the last-seen innermost sequence point:
	decide on the last-seen sequence point before the last-seen breakpoint;

Section "No Locations by Sequence Point Mapping" (for use without Debug File Parsing by Brady Garvin)

To decide what number is the last-seen sequence point of (A - a call frame) or (I - a number) if it is innermost:
	if the inward link of A is null:
		decide on I;
	decide on zero.

Section "Locations by Sequence Point Mapping" (for use with Debug File Parsing by Brady Garvin)

[Associates instrumented instruction addresses with sequence points.]
The reverse sequence point hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate a hash table for the reverse sequence point lookups rule):
	now the reverse sequence point hash table is a new permanent hash table with the sequence point hash table size buckets.

A GRIF capture rule (this is the capture sequence point mappings rule):
	repeat with the instruction vertex running through the scratch space:
		let the source address be the source address of the instruction vertex;
		if the source address is a sequence point:
			let the destination address be the beginning of instructions in the emitted chunk plus the destination offset of the instruction vertex;
			insert the key the destination address and the value the source address into the reverse sequence point hash table.

To decide what number is the last-seen sequence point of (A - a call frame) or (I - a number) if it is innermost:
	if the inward link of A is null:
		decide on I;
	let the bytecode address be the most recent instruction address of A;
	while the bytecode address is greater than zero and ((whether or not the reverse sequence point hash table contains the key the bytecode address) is false):
		decrement the bytecode address;
	decide on the first number value matching the key the bytecode address in the reverse sequence point hash table or zero if there are no matches.

Chapter "Simplification of the Call Stack"

Section "Simplification Hash Tables" - unindexed

The elided function hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate a hash table for the elided functions rule):
	now the elided function hash table is a new permanent hash table with the elided function hash table size buckets.

Section "Checking Elision"

To decide whether the function at address (A - a number) is elided in the simplified call stack:
	decide on whether or not the elided function hash table contains the key A.

To decide whether the function at address (A - a number) is not elided in the simplified call stack:
	let the result be whether or not the elided function hash table contains the key A;
	decide on whether or not the result is false.

To decide whether (A - a call frame) is elided in the simplified call stack:
	decide on whether or not the elided function hash table contains the key the uninstrumented function address of A.

To decide whether (A - a call frame) is not elided in the simplified call stack:
	let the result be whether or not the elided function hash table contains the key the uninstrumented function address of A;
	decide on whether or not the result is false.

Section "Simplification by Eliding Veneer Routines" - unindexed

To elide calls to the veneer routine at address (A - a number) with the override flag (F - a truth state) and the routine name (T - some text) and the annotation (Z - some text) (this is eliding calls to each veneer routine):
	insert the key A into the elided function hash table.

A GRIF setup rule (this is the elide veneer routines rule):
	traverse the veneer routines with the visitor eliding calls to each veneer routine.

Chapter "Simplification by Eliding Standard Template Routines" - unindexed

To elide calls to the routine at address (A - a number) with the routine name (T - some text) (this is eliding calls to each standard template routine):
	insert the key A into the elided function hash table.

A GRIF setup rule (this is the elide standard template routines rule):
	traverse the standard template routines with the visitor eliding calls to each standard template routine.

Chapter "Simplification by Eliding Resolvers" (for use with Debug File Parsing by Brady Garvin)

The resolver index for capturing names of potentially elidable resolvers is a number that varies.

A GRIF setup rule (this is the elide resolvers rule):
	ensure that all routines have names;
	now the resolver index for capturing names of potentially elidable resolvers is zero;
	repeat until a break:
		let the resolver name be a new synthetic text copied from "resolver _ [the resolver index for capturing names of potentially elidable resolvers]";
		let the resolver addresses be the list of function addresses for the routines with the canonical name the resolver name;
		if the resolver addresses are empty:
			break;
		repeat with the resolver address running through the number keys of the resolver addresses:
			insert the key the resolver address into the elided function hash table;
		increment the resolver index for capturing names of potentially elidable resolvers.

The elide resolvers rule is listed after the set up debug files as part of the GRIF setup rule in the GRIF setup rulebook.

Chapter "Voluntary Elision"

To elide calls to (A - a value) in the simplified call stack:
	insert the key A into the elided function hash table.

Chapter "Comma Separation for Call Frame Say Phrases" - unindexed

[We use the serial comma whether the use option is active or not.  The missing comma can be really disconcerting when the items are laid out vertically, and we want authors to focus on debugging, not layout quirks.]
To say delimiter index (I - a number) for (N - a number) items:
	unless I is N minus one:
		say "[if N is greater than two],[end if][if I is N minus two] and[end if]".
To say delimiter index (I - a number) for (N - a number) items with a comma if the list continues:
	unless I is N minus one:
		say ",[if I is N minus two] and[end if]".

Chapter "Saying a Location"

To say custom annotations for (A - a call frame) with frame number (I - a number):
	say "".

To say the location of (A - a call frame) with frame number (I - a number) (this is saying the location of each call frame):
	ensure that all routines have names;
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the human-friendly name be the human-friendly name for the function at address function address;
	let the actual human-friendly name be the human-friendly name for the function at address actual function address;
	if the call frame numbering flag is true:
		say "[I converted to a number]. ";
	say "within [the actual human-friendly name]";
	if the call stack addresses flag is true:
		say " (at address [the actual function address]";
		if the function address is not the actual function address:
			say ", a substitution for [the human-friendly name] at address [the function address]";
		say ")";
	otherwise:
		if the function address is not the actual function address:
			say " (a substitution for [the human-friendly name] at address [the function address])";
	say "[custom annotations for A with frame number I]".

Chapter "Saying Original Arguments"

To say the original argument introduction of (A - a call frame):
	let the original argument count be the original argument count of A;
	say "    (";
	unless the original arguments of A are known:
		say "the original arguments are unknown";
	otherwise if the original argument count is zero:
		say "no original arguments";
	otherwise if the original argument count is one:
		say "the original argument was";
	otherwise if the original argument count is unsigned greater than 16 and A had its original arguments passed on the stack:
		say "the first 17 original arguments were";
	otherwise if the original argument count is unsigned greater than 16:
		say "the first 16 original arguments were";
	otherwise:
		say "the original arguments were".

To say the implicit original arguments of (A - a call frame):
	if A had its original arguments passed on the stack and the original arguments of A are known:
		let the original argument count be the original argument count of A;
		let the item count be one plus the original argument count;
		say "[line break]        _vararg_count = [the original argument count], implicitly[delimiter index zero for the item count items with a comma if the list continues]".

To say annotated original argument (I - a number) of (A - a call frame):
	let the kind name be original argument kind name I of A;
	say "[line break]        [original argument name I of A] = [the kind name]: [original argument I of A according to the kind named the kind name]";
	let the item index be I;
	let the item count be the original argument count of A;
	if A had its original arguments passed on the stack:
		let the last argument index be the item count minus one;
		increment the item index;
		increment the item count;
		if the last argument index is greater than zero:
			if I is zero:
				say ", at the top of the stack[delimiter index item index for the item count items with a comma if the list continues]";
				stop;
			if I is the last argument index:
				say ", at the bottom of the stack[delimiter index item index for the item count items with a comma if the list continues]";
				stop;
	say "[delimiter index item index for the item count items]".

To say the original arguments conclusion of (A - a call frame):
	say ")".

To say the original arguments of (A - a call frame):
	say "[the original argument introduction of A][the implicit original arguments of A]";
	let the original argument count be the original argument count of A;
	repeat with the argument index running over the half-open interval from zero to the original argument count:
		say "[annotated original argument argument index of A]";
	say "[the original arguments conclusion of A]".

Section "Original Argument Names and Kinds by Number" (for use without Debug File Parsing by Brady Garvin)

To say original argument name (I - a number) of (A - a call frame):
	say "<[if A had its original arguments passed on the stack]argument[otherwise]temporary named value[end if] [I converted to a number]>".

To decide what text is original argument kind name (I - a number) of (A - a call frame):
	decide on "<unknown kind>".

Section "Original Argument Names and Kinds by Source Text" (for use with Debug File Parsing by Brady Garvin)

To say original argument name (I - a number) of (A - a call frame):
	if A had its original arguments passed on the stack:
		say "<argument [I converted to a number]>";
		stop;
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the routine record be the routine record for the actual function address;
	if the routine record is an invalid routine record:
		say "<temporary named value [I converted to a number]>";
	otherwise:
		let the sequence point be the last-seen sequence point of A or the last-seen innermost sequence point if it is innermost;
		if the routine record owning the sequence point the sequence point is the routine record:
			let the line number be the I7 line number for the sequence point the sequence point in the routine record the routine record;
			let the source line record be the source line record for line number the line number;
			unless the source line record is an invalid source line record:
				let the local name be I7 local name number I of the source line record;
				unless the local name is the name for invalid local number I:
					say "[the local name]";
					stop;
				now the local name is sample I7 local name number I of the routine record;
				unless the local name is the name for invalid local number I:
					say "[I6 local name number I of the routine record] [bracket][the local name][close bracket]";
					stop;
		say "[I6 local name number I of the routine record]".

To decide what text is original argument kind name (I - a number) of (A - a call frame):
	if A had its original arguments passed on the stack:
		decide on "<no kind>";
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the routine record be the routine record for the actual function address;
	if the routine record is an invalid routine record:
		decide on "<no kind>";
	let the sequence point be the last-seen sequence point of A or the last-seen innermost sequence point if it is innermost;
	unless the routine record owning the sequence point the sequence point is the routine record:
		decide on "<unknown kind>";
	decide on I7 local kind name number I of the routine record.

Chapter "Saying Temporary Named Values"

To say the temporary named value introduction of (A - a call frame):
	let the temporary named value count be the temporary named value count of A;
	say "    (";
	if the temporary named value count is zero:
		say "no temporary named values";
	otherwise if the temporary named value count is one:
		say "the temporary named value is";
	otherwise if the temporary named value count is unsigned greater than 16:
		say "the first 16 temporary named values are";
	otherwise:
		say "the temporary named values are".

To say annotated temporary named value (I - a number) of (A - a call frame):
	let the item count be the temporary named value count of A;
	let the kind name be temporary named value kind name I of A;
	say "[line break]        [temporary name I of A] = [the kind name]: [temporary named value I of A according to the kind named the kind name][delimiter index I for the item count items]".

To say the temporary named values conclusion of (A - a call frame):
	say ")".

To say the temporary named values of (A - a call frame):
	say "[the temporary named value introduction of A]";
	let the temporary named value count be the temporary named value count of A;
	repeat with the temporary named value index running over the half-open interval from zero to the temporary named value count:
		say "[annotated temporary named value temporary named value index of A]";
	say "[the temporary named values conclusion of A]".

Section "Temporary Names and Kinds by Number" (for use without Debug File Parsing by Brady Garvin)

To say temporary name (I - a number) of (A - a call frame):
	say "<temporary named value [I converted to a number]>".

To decide what text is temporary named value kind name (I - a number) of (A - a call frame):
	decide on "<unknown kind>".

Section "Temporary Names and Kinds by Source Text" (for use with Debug File Parsing by Brady Garvin)

To say temporary name (I - a number) of (A - a call frame):
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the routine record be the routine record for the actual function address;
	if the routine record is an invalid routine record:
		say "<temporary named value [I converted to a number]>";
	otherwise:
		let the sequence point be the last-seen sequence point of A or the last-seen innermost sequence point if it is innermost;
		if the routine record owning the sequence point the sequence point is the routine record:
			let the line number be the I7 line number for the sequence point the sequence point in the routine record the routine record;
			let the source line record be the source line record for line number the line number;
			unless the source line record is an invalid source line record:
				let the local name be I7 local name number I of the source line record;
				unless the local name is the name for invalid local number I:
					say "[the local name]";
					stop;
				now the local name is sample I7 local name number I of the routine record;
				unless the local name is the name for invalid local number I:
					say "[I6 local name number I of the routine record] [bracket][the local name][close bracket]";
					stop;
		say "[I6 local name number I of the routine record]".

To decide what text is temporary named value kind name (I - a number) of (A - a call frame):
	let the function address be the uninstrumented function address of A;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the routine record be the routine record for the actual function address;
	if the routine record is an invalid routine record:
		decide on "<no kind>";
	let the sequence point be the last-seen sequence point of A or the last-seen innermost sequence point if it is innermost;
	if the routine record owning the sequence point the sequence point is the routine record:
		decide on I7 local kind name number I of the routine record;
	decide on "<unknown kind>".

Chapter "Saying Catch Tokens"

To say the catch token introduction of (A - a call frame):
	let the catch token linked list be the catch token linked list of A;
	say "    (";
	if the catch token linked list is empty:
		say "no catch tokens";
	otherwise if the catch token linked list is unit:
		say "the catch token is";
	otherwise:
		say "the catch tokens are".

To say (T - a number) as an annotated catch token at index (I - a number) of (N - a number) catch tokens in (A - a call frame):
	say " [T converted to a number][delimiter index I for N items]".

To say the catch tokens conclusion of (A - a call frame):
	say ")".

To say the catch tokens of (A - a call frame):
	say "[the catch token introduction of A]";
	let the catch token linked list be the catch token linked list of A;
	let the catch token count be zero;
	repeat with the linked list vertex running through the catch token linked list:
		increment the catch token count;
	let the catch token index be zero;
	repeat with the linked list vertex running through the catch token linked list:
		say "[the number key of the linked list vertex as an annotated catch token at index catch token index of catch token count catch tokens in A]";
		increment the catch token index;
	say "[the catch tokens conclusion of A]".

Chapter "Saying a Call Frame"

To say (A - a call frame) with frame number (I - a number):
	say "[the location of A with frame number I]";
	if the original arguments flag is true:
		say "[line break][the original arguments of A]";
	if the temporary named values flag is true:
		say "[line break][the temporary named values of A]";
	if the catch tokens flag is true:
		say "[line break][the catch tokens of A]".

Chapter "Saying a Call Stack after Introducing another Call Frame" - unindexed

To say the call stack after introducing another call frame (this is saying the call stack after introducing another call frame):
	let the innermost call frame be the innermost call frame of a reconstructed call stack;
	if the innermost call frame is a null call frame or the innermost call frame is an invalid call frame:
		say "within no instrumented functions.[paragraph break]";
	otherwise:
		let the frame number be zero;
		repeat with the call frame running through the innermost call frame and its ancestors:
			unless the call stack simplification flag is true and the call frame is elided in the simplified call stack:
				say the call frame with frame number the frame number;
				if the outward link of the call frame is null:
					say "[if the uninstrumented function address of the call frame is the address of I6_Main].[paragraph break][otherwise],[line break]which is the outermost instrumented function.[paragraph break][end if]";
					delete the innermost call frame and its ancestors;
					stop;
				say ",[line break]";
				increment the frame number;
		say "which is the outermost instrumented function[if the call stack simplification flag is true], apart from the elided Inform internals[end if].[paragraph break]";
		delete the innermost call frame and its ancestors.

Section "Shielding the Phrases that Say a Call Stack by Saying Call Frames"

A GRIF shielding rule (this is the shield the phrases that say a call stack by saying call frames rule):
	 shield saying the call stack after introducing another call frame against instrumentation.

Chapter "Saying a Call Stack"

To say the call stack (this is saying the call stack):
	say the call stack after introducing another call frame.

Book "Instrumentation"

Chapter "Temporary Space" - unindexed

Include (-
	Array cst_jumpPops --> 8;
	Array cst_callPops --> 8;
	Array cst_throwPops --> 8;
	Array cst_catchPops --> 8;
	Array cst_catchDestination --> 1;
	Array cst_thrownValue --> 1;
-).

To decide what number is where stack pops from jumps are temporarily saved for call stack tracking: (- cst_jumpPops -).
To decide what number is where stack pops from calls are temporarily saved for call stack tracking: (- cst_callPops -).
To decide what number is where stack pops from throws are temporarily saved for call stack tracking: (- cst_throwPops -).
To decide what number is where stack pops from catches are temporarily saved for call stack tracking: (- cst_catchPops -).

To decide what number is where a catch destination is temporarily saved for call stack tracking: (- cst_catchDestination -).
To decide what number is where a thrown value is temporarily saved for call stack tracking: (- cst_thrownValue -).

Chapter "Utility Phrases for Instrumentation"

Section "Counting Locals" - unindexed

To decide what number is the local count of the function at address (A - a number):
	let the local format address be A plus one;
	let the result be zero;
	while the short at address local format address is not zero:
		increment the local format address;
		increase the result by the byte at address local format address;
		increment the local format address;
	decide on the result.

Section "Local Offsets" - unindexed

To decide what number is the local offset for local (I - a number): (- (4*{I}) -).
To decide what number is the local index for local offset (O - a number): (- ({O}/4) -).

Section "Checking for Catches" - unindexed

To decide whether the scratch space contains catches older than the current generation:
	repeat with the instruction vertex running through occurrences of exception catch in the scratch space:
		if the instruction vertex is older than the current generation:
			decide yes;
	decide no.

Chapter "Everywhere Instrumentation" - unindexed

To displace local references from the stack to (A - a call stack vertex):
	repeat with the instruction vertex running through the scratch space:
		repeat with the parameter index running from zero to the parameter limit of the instruction vertex:
			if the addressing mode of parameter parameter index of the instruction vertex is the call-frame-local addressing mode:
				let the local offset be parameter parameter index of the instruction vertex;
				let the local index be the local index for local offset local offset;
				write the addressing mode the zero-based-dereference addressing mode to parameter parameter index of the instruction vertex;
				write local address local index of A to parameter parameter index of the instruction vertex.

Chapter "Entry Instrumentation" - unindexed

Section "Occupying Call Stack Vertices" - unindexed

[ @jne A-->0 1 <constant>; ]
To decide what instruction vertex is a new occupancy-checking instruction vertex for (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-jne to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write the nearest same-function ancestor address of A to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write one to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

[ @copy 0 A-->0; ]
To decide what instruction vertex is a new vertex-occupying instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode zero-or-discard addressing mode and destination mode zero-based-dereference addressing mode and destination parameter the nearest same-function ancestor address of A.

[ @copy 0 A-->18; ]
To decide what instruction vertex is a new vertex-resetting instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode zero-or-discard addressing mode and destination mode zero-based-dereference addressing mode and destination parameter the most recent call instruction address address of A.

[ @mzero <size-beyond-base> (A+<base-size>); ]
To decide what instruction vertex is a new vertex-extras-resetting instruction vertex for (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-mzero to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write the size in memory of a call stack vertex minus the base size in memory of a call stack vertex to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write (A converted to a number) plus the base size in memory of a call stack vertex to parameter one of the result;
	decide on the result.

[ @jumpabs <constant>; ]
To decide what instruction vertex is a new annex-skipping instruction vertex:
	decide on a new artificial instruction vertex for an absolute jump with constant destination.

[ @callfi <annexing-function> A 0; ]
To decide what instruction vertex is a new vertex-annexing instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a one-argument call to the function at address the function address of annexing a call stack vertex with mode constant addressing mode and parameter A converted to a number and return mode zero-or-discard addressing mode.

To occupy (A - a call stack vertex) at the function entry point:
	if the chunk being instrumented contains the function entry point:
		let the occupancy-checking instruction vertex be a new occupancy-checking instruction vertex for A;
		let the vertex-occupying instruction vertex be a new vertex-occupying instruction vertex for A;
		let the vertex-resetting instruction vertex be a new vertex-resetting instruction vertex for A;
		let the annex-skipping instruction vertex be a new annex-skipping instruction vertex;
		let the vertex-annexing instruction vertex be a new vertex-annexing instruction vertex for A;
		insert the vertex-annexing instruction vertex before entry;
		insert the occupancy-checking instruction vertex before the vertex-annexing instruction vertex;
		insert the vertex-occupying instruction vertex before the vertex-annexing instruction vertex;
		insert the vertex-resetting instruction vertex before the vertex-annexing instruction vertex;
		unless the size in memory of a call stack vertex is the base size in memory of a call stack vertex:
			let the vertex-extras-resetting instruction vertex be a new vertex-extras-resetting instruction vertex for A;
			insert the vertex-extras-resetting instruction vertex before the vertex-annexing instruction vertex;
		insert the annex-skipping instruction vertex before the vertex-annexing instruction vertex;
		establish a jump link from the occupancy-checking instruction vertex to the vertex-annexing instruction vertex;
		establish a jump link from the annex-skipping instruction vertex to the next link of the vertex-annexing instruction vertex.

Section "Detaching a Catch Token Linked List" - unindexed

[ @copy 0 A-->1; ]
To decide what instruction vertex is a new catch-token-linked-list-detaching instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode zero-or-discard addressing mode and destination mode zero-based-dereference addressing mode and destination parameter the catch token linked list address of A.

To detach any catch token linked list from (A - a call stack vertex) at the function entry point:
	if the chunk being instrumented contains the function entry point and the scratch space contains catches older than the current generation:
		let the catch-token-linked-list-detaching instruction vertex be a new catch-token-linked-list-detaching instruction vertex for A;
		insert the catch-token-linked-list-detaching instruction vertex before entry.

Section "Displacing Locals from the Stack to a Call Stack Vertex" - unindexed

[ @copy <local-I> (A+8)-->I; ]
To decide what instruction vertex is a new local-displacing instruction vertex for local (I - a number) in (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode call-frame-local addressing mode and source parameter the local offset for local I and destination mode zero-based-dereference addressing mode and destination parameter local address I of A.

To displace locals to (A - a call stack vertex) at the function entry point:
	if the chunk being instrumented contains the function entry point and the byte at address the address of the chunk being instrumented is 193:
		let the local count be the local count of the function at address the address of the chunk being instrumented;
		repeat with the local index running over the half-open interval from zero to the local count:
			insert a new local-displacing instruction vertex for local local index in A before entry.

Section "Main Phrase for Entry Instrumentation" - unindexed

To insert call stack tracking in (A - a call stack vertex) at the function entry point:
	detach any catch token linked list from A at the function entry point;
	displace locals to A at the function entry point;
	occupy A at the function entry point.

Chapter "Exit Instrumentation" - unindexed

Section "Instrumentation to Eliminate Tailcalls" - unindexed

[ @return <stack>; ]
To decide what instruction vertex is a new tailcall return instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-return to the result;
	write the addressing mode stack addressing mode to parameter zero of the result;
	decide on the result.

To eliminate tailcalls:
	repeat with the instruction vertex running through occurrences of the operation code op-tailcall in the scratch space:
		unless the instruction vertex is older than the current generation:
			next;
		write the operation code op-call to the instruction vertex;
		write the addressing mode stack addressing mode to parameter two of the instruction vertex;
		let the tailcall return instruction vertex be a new tailcall return instruction vertex;
		insert the tailcall return instruction vertex after the instruction vertex.

Section "Instrumentation to Convert Conditional Returns into Conditional Jumps to Returns" - unindexed

[ @jltu <P-in-mode-M> 2 <constant>; ]
To decide what instruction vertex is a new conditional jump-to-return instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-jltu to the result;
	write the addressing mode M to parameter zero of the result;
	write P to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write two to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

[ @return <P-in-mode-M>; ]
To decide what instruction vertex is a new conditional return instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-return to the result;
	write the addressing mode M to parameter zero of the result;
	write P to parameter zero of the result;
	decide on the result.

To convert the conditional return (V - an instruction vertex) into a conditional jump to a return:
	unless V is older than the current generation and the jump link of V is null and the relative jump addressing flag is set in V:
		stop;
	let the parameter index be the jump parameter index of V;
	let the plain chunk mode be the addressing mode of parameter parameter index of V;
	if the plain chunk mode is the zero-or-discard addressing mode or the plain chunk mode is the constant addressing mode:
		let the plain chunk parameter be parameter parameter index of V;
		if the plain chunk mode is the zero-or-discard addressing mode or the plain chunk parameter is zero or the plain chunk parameter is one:
			write the addressing mode constant addressing mode to parameter parameter index of V;
			let the conditional return instruction vertex be a new conditional return instruction vertex for mode plain chunk mode and parameter plain chunk parameter;
			insert the conditional return instruction vertex at the end of the arrangement;
			establish a jump link from V to the conditional return instruction vertex;
		stop;
	[At this point we know that we're dealing with a computed relative jump, and that we need to vacate exactly when the computed address is zero or one.]
	[Cleanse the instruction of stack pops first, so we don't have to worry about the order of reads.]
	cleanse V of stack pops using the array at address where stack pops from jumps are temporarily saved for call stack tracking;
	[In case the plain chunk mode changed in the cleansing:]
	now the plain chunk mode is the addressing mode of parameter parameter index of V;
	let the plain chunk parameter be parameter parameter index of V;
	let the conditional jump-to-return instruction vertex be a new conditional jump-to-return instruction vertex for mode plain chunk mode and parameter plain chunk parameter;
	insert the conditional jump-to-return instruction vertex before V;
	let the conditional return instruction vertex be a new conditional return instruction vertex for mode plain chunk mode and parameter plain chunk parameter;
	insert the conditional return instruction vertex at the end of the arrangement;
	establish a jump link from the conditional jump-to-return instruction vertex to the conditional return instruction vertex.

To convert conditional returns into conditional jumps to returns:
	repeat with the instruction vertex running through occurrences of jump without call in the scratch space:
		convert the conditional return the instruction vertex into a conditional jump to a return;
	repeat with the instruction vertex running through occurrences of exception catch in the scratch space:
		convert the conditional return the instruction vertex into a conditional jump to a return.

Section "Deleting Catch Token Linked Lists" - unindexed

To delete the catch token linked list in (A - a call stack vertex) (this is deleting a catch token linked list):
	delete the catch token linked list of A.

A GRIF shielding rule (this is the shield the phrase that deletes catch token linked lists before a return rule):
	shield deleting a catch token linked list against instrumentation.

[ @callfi <catch-token-deleting-function> A 0; ]
To decide what instruction vertex is a new catch-token-deleting instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a one-argument call to the function at address the function address of deleting a catch token linked list with mode constant addressing mode and parameter A converted to a number and return mode zero-or-discard addressing mode.

To delete the catch token linked list in (A - a call stack vertex) just before (V - an instruction vertex):
	let the catch-token-deleting instruction vertex be a new catch-token-deleting instruction vertex for A;
	insert the catch-token-deleting instruction vertex before V.

Section "Restoring Locals from a Call Stack Vertex to the Stack" - unindexed

[ @copy (A+8)-->I <local-I>; ]
To decide what instruction vertex is a new local-restoring instruction vertex for local (I - a number) in (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode zero-based-dereference addressing mode and source parameter local address I of A and destination mode call-frame-local addressing mode and destination parameter the local offset for local I.

To restore locals from (A - a call stack vertex) just before (V - an instruction vertex):
	repeat with the parameter index running from zero to the parameter limit of V:
		if the addressing mode of parameter parameter index of V is the zero-based-dereference addressing mode:
			let the local address be parameter parameter index of V;
			let the local index be the local index for the local address local address in A;
			if the local index is unsigned less than 16:
				write the addressing mode the call-frame-local addressing mode to parameter parameter index of V;
				write the local offset for local local index to parameter parameter index of V;
				insert a new local-restoring instruction vertex for local local index in A before V.

Section "Vacating Call Stack Vertices" - unindexed

[ @jnz A-->0 <constant>; ]
To decide what instruction vertex is a new replaceability-checking instruction vertex for (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-jnz to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write the nearest same-function ancestor address of A to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

[ @copy 1 A-->0; ]
To decide what instruction vertex is a new vertex-vacating instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode constant addressing mode and source parameter one and destination mode zero-based-dereference addressing mode and destination parameter the nearest same-function ancestor address of A.

[ @jumpabs <constant>; ]
To decide what instruction vertex is a new cession-skipping instruction vertex:
	decide on a new artificial instruction vertex for an absolute jump with constant destination.

[ @callfi <ceding-function> A 0; ]
To decide what instruction vertex is a new vertex-ceding instruction vertex for (A - a call stack vertex):
	decide on a new artificial instruction vertex for a one-argument call to the function at address the function address of ceding a call stack vertex with mode constant addressing mode and parameter A converted to a number and return mode zero-or-discard addressing mode.

To vacate (A - a call stack vertex) just before (V - an instruction vertex):
	let the replaceability-checking instruction vertex be a new replaceability-checking instruction vertex for A;
	let the vertex-vacating instruction vertex be a new vertex-vacating instruction vertex for A;
	let the cession-skipping instruction vertex be a new cession-skipping instruction vertex;
	let the vertex-ceding instruction vertex be a new vertex-ceding instruction vertex for A;
	insert the vertex-ceding instruction vertex before V;
	insert the replaceability-checking instruction vertex before the vertex-ceding instruction vertex;
	insert the vertex-vacating instruction vertex before the vertex-ceding instruction vertex;
	insert the cession-skipping instruction vertex before the vertex-ceding instruction vertex;
	establish a jump link from the replaceability-checking instruction vertex to the vertex-ceding instruction vertex;
	establish a jump link from the cession-skipping instruction vertex to V.

Section "Main Phrase for Exit Instrumentation" - unindexed

To insert call stack tracking in (A - a call stack vertex) just before function exit points:
	eliminate tailcalls;
	convert conditional returns into conditional jumps to returns;
	repeat with the instruction vertex running through occurrences of the operation code op-return in the scratch space:
		if the scratch space contains catches older than the current generation:
			delete the catch token linked list in A just before the instruction vertex;
		restore locals from A just before the instruction vertex;
		vacate A just before the instruction vertex.

Chapter "Pre-Call Instrumentation" - unindexed

Section "Call Instruction Recording" - unindexed

[ @copy <address-of-V-instruction> A-->18; ]
To decide what instruction vertex is a new call-instruction-recording instruction vertex for (V - an instruction vertex) and (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode start-of-vertex addressing mode and source parameter V converted to a number and destination mode zero-based-dereference addressing mode and destination parameter the most recent call instruction address address of A.

To record the upcoming call in (A - a call stack vertex) just before (V - an instruction vertex):
	let the call-instruction-recording instruction vertex be a new call-instruction-recording instruction vertex for V and A;
	insert the call-instruction-recording instruction vertex before V.

Section "Call Argument Recording" - unindexed

[ @copy <P-in-mode-M> (A+80)-->I; ]
To decide what instruction vertex is a new call-parameter-recording instruction vertex for mode (M - an addressing mode) and parameter (P - a number) and outgoing call parameter (I - a number) of (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode M and source parameter P and destination mode zero-based-dereference addressing mode and destination parameter the address for outgoing call parameter I of A.

[ @copy <P-in-mode-M> A-->19; ]
To decide what instruction vertex is a new call-parameter-counting instruction vertex for mode (M - an addressing mode) and parameter (P - a number) and (A - a call stack vertex):
	decide on a new artificial instruction vertex for a copy with source mode M and source parameter P and destination mode zero-based-dereference addressing mode and destination parameter the most recent outgoing argument count address of A.

[ @jgeu A-->19 16 <constant>; ]
To decide what instruction vertex is a new default peek jump instruction vertex for (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-jgeu to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write the most recent outgoing argument count address of A to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write 16 to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

To decide whether (A - an instruction vertex) could be a default peek jump instruction vertex for the most recent outgoing argument count address (C - a number):
	unless parameter zero of A is C:
		decide no;
	unless parameter one of A is 16:
		decide no;
	unless the addressing mode of parameter zero of A is the zero-based-dereference addressing mode:
		decide no;
	unless the addressing mode of parameter one of A is the constant addressing mode:
		decide no;
	unless the addressing mode of parameter two of A is the constant addressing mode:
		decide no;
	decide yes.

[ @aload T A-->19 <stack>; ]
To decide what instruction vertex is a new peek jump lookup instruction vertex for the jump table at address (T - a number) and (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-aload to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write T to parameter zero of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter one of the result;
	write the most recent outgoing argument count address of A to parameter one of the result;
	write the addressing mode stack addressing mode to parameter two of the result;
	decide on the result.

To decide whether (A - an instruction vertex) could be a peek jump lookup instruction vertex for the most recent outgoing argument count address (C - a number):
	unless parameter one of A is C:
		decide no;
	unless the addressing mode of parameter zero of A is the constant addressing mode:
		decide no;
	unless the addressing mode of parameter one of A is the zero-based-dereference addressing mode:
		decide no;
	decide yes.

[ @jumpabs <stack>; ]
To decide what instruction vertex is a new peek-jumping instruction vertex:
	let the result be a new artificial instruction vertex for an absolute jump with mode stack addressing mode;
	set the shielded flag in the result;
	decide on the result.

[ @stkpeek I A-->(21+I); ]
To decide what instruction vertex is a new argument-peeking instruction vertex for outgoing argument (I - a number) and (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-stkpeek to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write I to parameter zero of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter one of the result;
	write the address for outgoing argument I of A to parameter one of the result;
	decide on the result.

To decide whether (A - an instruction vertex) could be an argument-peeking instruction vertex for outgoing argument (I - a number) and (C - a call stack vertex):
	if A is null or A is an invalid instruction vertex:
		decide no;
	unless the operation code of A is op-stkpeek:
		decide no;
	unless parameter one of A is the address for outgoing argument I of C:
		decide no;
	unless parameter zero of A is I:
		decide no;
	unless the addressing mode of parameter zero of A is the constant addressing mode:
		decide no;
	unless the addressing mode of parameter one of A is the zero-based-dereference addressing mode:
		decide no;
	decide yes.

To record call parameter (I - a number) as being mode (M - an addressing mode) and parameter (P - a number) in (A - a call stack vertex) just before (V - an instruction vertex):
	let the call-parameter-recording instruction vertex be a new call-parameter-recording instruction vertex for mode M and parameter P and outgoing call parameter I of A;
	insert the call-parameter-recording instruction vertex before V.

To record the upcoming call destination in (A - a call stack vertex) just before (V - an instruction vertex):
	let the parameter mode be the addressing mode of parameter zero of V;
	let the parameter be parameter zero of V;
	record call parameter zero as being mode parameter mode and parameter parameter in A just before V.

To record (N - a number) stack arguments in (A - a call stack vertex) just before (V - an instruction vertex):
	let the limit be N;
	if the limit is unsigned more than 16:
		now the limit is 16;
	repeat with the argument index running over the half-open interval from zero to the limit:
		let the argument-peeking instruction vertex be a new argument-peeking instruction vertex for outgoing argument argument index and A;
		insert the argument-peeking instruction vertex before V.

To record stack arguments counted by mode (M - an addressing mode) and parameter (P - a number) in (A - a call stack vertex) just before (V - an instruction vertex):
	let the jump table address be a permanent memory allocation of 64 bytes;
	let the call-parameter-counting instruction vertex be a new call-parameter-counting instruction vertex for mode M and parameter P and A;
	let the default peek jump instruction vertex be a new default peek jump instruction vertex for A;
	let the peek jump lookup instruction vertex be a new peek jump lookup instruction vertex for the jump table at address jump table address and A;
	let the peek-jumping instruction vertex be a new peek-jumping instruction vertex;
	insert the peek-jumping instruction vertex before V;
	insert the call-parameter-counting instruction vertex before the peek-jumping instruction vertex;
	insert the default peek jump instruction vertex before the peek-jumping instruction vertex;
	insert the peek jump lookup instruction vertex before the peek-jumping instruction vertex;
	let the argument index be 15;
	while the argument index is at least zero:
		let the argument-peeking instruction vertex be a new argument-peeking instruction vertex for outgoing argument argument index and A;
		insert the argument-peeking instruction vertex before V;
		decrement the argument index;
	establish a jump link from the default peek jump instruction vertex to the next link of the peek-jumping instruction vertex.

To record a fixed number of arguments in (A - a call stack vertex) just before (V - an instruction vertex):
	repeat with the parameter index running from one to the load parameter limit of V:
		let the parameter mode be the addressing mode of parameter parameter index of V;
		let the parameter be parameter parameter index of V;
		if the parameter mode is:
			-- the zero-or-discard addressing mode:
				do nothing;
			-- the constant addressing mode:
				do nothing;
			-- the call-frame-local addressing mode:
				do nothing;
			-- otherwise:
				record call parameter parameter index as being mode parameter mode and parameter parameter in A just before V.

To record a variable number of arguments in (A - a call stack vertex) just before (V - an instruction vertex):
	always check that the load parameter limit of V is one or else fail at recording extra non-stack call arguments;
	let the parameter mode be the addressing mode of parameter one of V;
	let the parameter be parameter one of V;
	if the parameter mode is:
		-- the zero-or-discard addressing mode:
			do nothing;
		-- the constant addressing mode:
			record parameter stack arguments in A just before V;
		-- otherwise:
			record stack arguments counted by mode parameter mode and parameter parameter in A just before V.

Section "Main Phrase for Pre-Call Instrumentation" - unindexed

To insert call stack tracking in (A - a call stack vertex) just before calls:
	repeat with the instruction vertex running through occurrences of function call in the scratch space:
		unless the instruction vertex is older than the current generation:
			next;
		record the upcoming call in A just before the instruction vertex;
		cleanse the instruction vertex of stack pops using the array at address where stack pops from calls are temporarily saved for call stack tracking;
		record the upcoming call destination in A just before the instruction vertex;
		if the operation code of the instruction vertex is op-call or the operation code of the instruction vertex is op-tailcall:
			record a variable number of arguments in A just before the instruction vertex;
		otherwise:
			record a fixed number of arguments in A just before the instruction vertex.

Section "Jump Table Initialization" - unindexed

To decide what number is the jump table address corresponding to (V - an instruction vertex) with the most recent outgoing argument count address (C - a number):
	let the result be V;
	while the result is not null:
		now the result is the next link of the result;
		if the result could be a peek jump lookup instruction vertex for the most recent outgoing argument count address C:
			decide on parameter zero of the result;
	fail at finding a corresponding peek jump lookup instruction;
	decide on zero.

A GRIF capture rule (this is the populate the jump tables for peeking at arguments rule):
	let the key be the address of the function owning the chunk being instrumented;
	let the call stack vertex be the first call stack vertex value matching the key the key in the call substack hash table or an invalid call stack vertex if there are no matches;
	always check that the call stack vertex is not an invalid call stack vertex or else fail at finding a call stack vertex for an instrumented function;
	let the most recent outgoing argument count address be the most recent outgoing argument count address of the call stack vertex;
	repeat with the instruction vertex running through occurrences of the operation code op-jgeu in the scratch space:
		unless the instruction vertex could be a default peek jump instruction vertex for the most recent outgoing argument count address the most recent outgoing argument count address:
			next;
		let the jump table address be the jump table address corresponding to the instruction vertex with the most recent outgoing argument count address the most recent outgoing argument count address;
		let the case instruction vertex be the jump link of the instruction vertex;
		always check that the case instruction vertex could be an argument-peeking instruction vertex for outgoing argument 15 and the call stack vertex or else fail at finding a corresponding peek instruction;
		now the case instruction vertex is the next link of the case instruction vertex;
		let the jump table index be 15;
		repeat until a break:
			always check that (the jump table index is zero or the case instruction vertex could be an argument-peeking instruction vertex for outgoing argument jump table index minus one and the call stack vertex) or else fail at finding a corresponding peek instruction;
			let the jump entry address be the jump table address plus four times the jump table index;
			let the jump destination address be the beginning of instructions in the emitted chunk plus the destination offset of the case instruction vertex;
			write the integer the jump destination address to address jump entry address;
			if the jump table index is zero:
				break;
			decrement the jump table index;
			now the case instruction vertex is the next link of the case instruction vertex.

Chapter "Instrumentation Shared by Pre-Throw and Post-Catch Instrumentation" - unindexed

Section "Vacating Variably Many Call Stack Vertices according to a Throw Token" - unindexed

To vacate the call stack vertices destroyed by throwing the token (T - a number) with excess data (A - a number) and (B - a number) and (C - a number) and (D - a number) (this is vacating call stack vertices destroyed by a throw):
	let the innermost call frame be the innermost call frame of a reconstructed call stack;
	if the innermost call frame is a null call frame or the innermost call frame is an invalid call frame:
		stop;
	repeat with the call frame running through the innermost call frame and its ancestors:
		let the call stack vertex be the call stack vertex of the call frame;
		if the catch token linked list of the call stack vertex contains the key T:
			stop;
		delete the catch token linked list of the call stack vertex;
		let the nearest same-function ancestor be the nearest same-function ancestor of the call stack vertex;
		if the nearest same-function ancestor is null:
			write the nearest same-function ancestor the invalid call stack vertex to the call stack vertex;
		otherwise:
			cede the call stack vertex;
			repeat with the candidate call frame running through the call frame and its ancestors:
				if the call stack vertex of the candidate call frame is the nearest same-function ancestor:
					write the call stack vertex the call stack vertex to the candidate call frame;
					break;
	delete the innermost call frame and its ancestors.

A GRIF shielding rule (this is the shield the phrase that vacates call stack vertices destroyed by a throw rule):
	shield vacating call stack vertices destroyed by a throw against instrumentation.

Chapter "Pre-Throw Instrumentation" - unindexed

Section "Vacating Variably Many Call Stack Vertices according to a Throw" - unindexed

[ @callfi <vacating-function> <P-in-mode-M> 0; ]
To decide what instruction vertex is a new throw vacation instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	decide on a new artificial instruction vertex for a one-argument call to the function at address the function address of vacating call stack vertices destroyed by a throw with mode M and parameter P and return mode zero-or-discard addressing mode.

To vacate the moribund call stack vertices among (A - a call stack vertex) and its ancestors just before (V - an instruction vertex):
	cleanse V of stack pops using the array at address where stack pops from throws are temporarily saved for call stack tracking;
	let the token mode be the addressing mode of parameter one of V;
	let the token parameter be parameter one of V;
	let the throw vacation instruction vertex be a new throw vacation instruction vertex for mode token mode and parameter token parameter;
	insert the throw vacation instruction vertex before V.

Section "Main Phrase for Pre-Throw Instrumentation" - unindexed

To insert call stack tracking in (A - a call stack vertex) just before throws:
	repeat with the instruction vertex running through occurrences of exception throw in the scratch space:
		vacate the moribund call stack vertices among A and its ancestors just before the instruction vertex.

Chapter "Catch Instrumentation" - unindexed

Section "Recording Generated Catch Tokens" - unindexed

[ @add <P-in-mode-M> B cst_catchDestination-->0; ]
To decide what instruction vertex is a new catch label adjustment instruction vertex for mode (M - an addressing mode) and parameter (P - a number) with base address (B - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-add to the result;
	write the addressing mode M to parameter zero of the result;
	write P to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write B to parameter one of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter two of the result;
	write where a catch destination is temporarily saved for call stack tracking to parameter two of the result;
	decide on the result.

[This function returns its argument only because that makes the assembly easier to rewrite.]
To decide what number is the catch token after recording the catch token (T - a number) in (A - a call stack vertex) (this is recording a catch token):
	push the key T onto the catch token linked list of A;
	decide on T.

A GRIF shielding rule (this is the shield the phrase that records catch tokens rule):
	shield recording a catch token against instrumentation.

[ @callfii <recording-function> <P-in-mode-M> A 0; ! when M is not the stack addressing mode ]
[ @callfii <recording-function> <stack> A <stack>; ! when M is the stack addressing mode ]
To decide what instruction vertex is a new catch-token-recording instruction vertex for recording mode (M - an addressing mode) and parameter (P - a number) in (A - a call stack vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-callfii to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write the function address of recording a catch token to parameter zero of the result;
	write the addressing mode M to parameter one of the result;
	write P to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	write (A converted to a number) to parameter two of the result;
	if M is the stack addressing mode:
		write the addressing mode stack addressing mode to parameter three of the result;
	otherwise:
		write the addressing mode zero-or-discard addressing mode to parameter three of the result;
	decide on the result.

[ @jumpabs <constant>; ]
To decide what instruction vertex is a new jump-for-constant-catch instruction vertex:
	decide on a new artificial instruction vertex for an absolute jump with constant destination.

[ @jumpabs cst_catchDestination-->0; ]
To decide what instruction vertex is a new jump-for-computed-catch instruction vertex:
	decide on a new artificial instruction vertex for an absolute jump with mode zero-based-dereference addressing mode and parameter where a catch destination is temporarily saved for call stack tracking.

To record generated catch tokens in (A - a call stack vertex) just after (V - an instruction vertex):
	let the token mode be the addressing mode of parameter zero of V;
	let the token parameter be parameter zero of V;
	let the plain chunk mode be the addressing mode of parameter one of V;
	let the plain chunk parameter be parameter one of V;
	let the jump link be the jump link of V;
	let the catch-recording instruction vertex be a new catch-token-recording instruction vertex for recording mode token mode and parameter token parameter in A;
	insert the catch-recording instruction vertex at the end of the arrangement;
	write the addressing mode constant addressing mode to parameter one of V;
	establish a jump link from V to the catch-recording instruction vertex;
	if the jump link is null:
		let the catch label adjustment instruction vertex be a new catch label adjustment instruction vertex for mode plain chunk mode and parameter plain chunk parameter with base address the source end address of V minus two;
		insert the catch label adjustment instruction vertex before the catch-recording instruction vertex;
		let the jump-for-computed-catch instruction vertex be a new jump-for-computed-catch instruction vertex;
		insert the jump-for-computed-catch instruction vertex at the end of the arrangement;
	otherwise:
		let the jump-for-constant-catch instruction vertex be a new jump-for-constant-catch instruction vertex;
		insert the jump-for-constant-catch instruction vertex at the end of the arrangement;
		establish a jump link from the jump-for-constant-catch instruction vertex to the jump link.

Section "Recording Caught Catch Tokens" - unindexed

[ @copy <P-in-mode-M> cst_thrownValue-->0; ]
To decide what instruction vertex is a new thrown-value-saving instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	decide on a new artificial instruction vertex for a copy with source mode M and source parameter P and destination mode zero-based-dereference addressing mode and destination parameter where a thrown value is temporarily saved for call stack tracking.

[ @catch <stack> <constant>; ]
To decide what instruction vertex is a new caught-catch-token-recovering instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-catch to the result;
	write the addressing mode stack addressing mode to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

[ @call <vacating-function> 5 0; ]
To decide what instruction vertex is a new caught-catch-token-recording instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-call to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write the function address of vacating call stack vertices destroyed by a throw to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write five to parameter one of the result;
	write the addressing mode zero-or-discard addressing mode to parameter two of the result;
	decide on the result.

[ @copy cst_thrownValue-->0 <P-in-mode-M>; ]
To decide what instruction vertex is a new thrown-value-restoring instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	decide on a new artificial instruction vertex for a copy with source mode zero-based-dereference addressing mode and source parameter where a thrown value is temporarily saved for call stack tracking and destination mode M and destination parameter P.

To record caught catch tokens in (A - a call stack vertex) just after (V - an instruction vertex):
	let the token mode be the addressing mode of parameter zero of V;
	let the token parameter be parameter zero of V;
	let the thrown-value-saving instruction vertex be a new thrown-value-saving instruction vertex for mode token mode and parameter token parameter;
	let the caught-catch-token-recovering instruction vertex be a new caught-catch-token-recovering instruction vertex;
	let the caught-catch-token-recording instruction vertex be a new caught-catch-token-recording instruction vertex;
	let the thrown-value-restoring instruction vertex be a new thrown-value-restoring instruction vertex for mode token mode and parameter token parameter;
	insert the thrown-value-restoring instruction vertex after V;
	insert the thrown-value-saving instruction vertex before the thrown-value-restoring instruction vertex;
	insert the caught-catch-token-recovering instruction vertex before the thrown-value-restoring instruction vertex;
	insert the caught-catch-token-recording instruction vertex before the thrown-value-restoring instruction vertex;
	establish a jump link from the caught-catch-token-recovering instruction vertex to the caught-catch-token-recording instruction vertex.

Section "Main Phrase for Catch Instrumentation" - unindexed

To insert call stack tracking in (A - a call stack vertex) just after catches:
	repeat with the instruction vertex running through occurrences of exception catch in the scratch space:
		unless the instruction vertex is older than the current generation:
			next;
		cleanse the instruction vertex of stack pops using the array at address where stack pops from catches are temporarily saved for call stack tracking;
		record generated catch tokens in A just after the instruction vertex;
		record caught catch tokens in A just after the instruction vertex.

Chapter "Instrumentation Orchestration"

Section "Determining the Owning Function"

The address of the function claiming to own the chunk being instrumented is a number that varies.  The address of the function claiming to own the chunk being instrumented is zero.

To decide what number is the address of the function owning the chunk being instrumented:
	if the chunk being instrumented contains the function entry point:
		decide on the address of the chunk being instrumented;
	if the address of the function claiming to own the chunk being instrumented is not zero:
		decide on the address of the function claiming to own the chunk being instrumented;	
	let the innermost call frame be the innermost call frame of a reconstructed call stack;
	if the innermost call frame is a null call frame or the innermost call frame is an invalid call frame:
		decide on the address of I6_Main;
	let the function address be the uninstrumented function address of the innermost call frame;
	let the result be the address of the function substituted for the function at address function address;
	delete the innermost call frame and its ancestors;
	decide on the result.

Section "Determining the Call Stack Vertex" - unindexed

To decide what call stack vertex is the permanent call stack vertex for the chunk being instrumented:
	let the key be the address of the function owning the chunk being instrumented;
	let the result be the first call stack vertex value matching the key key in the call substack hash table or an invalid call stack vertex if there are no matches;
	if the result is an invalid call stack vertex:
		let the result be a new permanent call stack vertex;
		insert the key the key and the value the result into the call substack hash table;
	decide on the result.

Section "Determining Extra Field Addresses"

To decide what number is extra field address (I - a number) of call frames for the chunk being instrumented as seen by that chunk:
	decide on extra field address I of the permanent call stack vertex for the chunk being instrumented.

Section "The Instrumentation Rule"

A last GRIF instrumentation rule (this is the add call stack tracking rule):
	start a new generation of artificial vertices;
	let the call stack vertex be the permanent call stack vertex for the chunk being instrumented;
	displace local references from the stack to the call stack vertex;
	insert call stack tracking in the call stack vertex at the function entry point;
	insert call stack tracking in the call stack vertex just before function exit points;
	insert call stack tracking in the call stack vertex just before calls;
	insert call stack tracking in the call stack vertex just before throws;
	insert call stack tracking in the call stack vertex just after catches.

Section "The Pre-Hijacking Rule"

A GRIF pre-hijacking rule (this is the set the uninstrumented function address of the outermost instrumented function to the uninstrumented function address of main when GRIF hijacks main rule):
	now the uninstrumented function address of the outermost instrumented function is the address of I6_Main.

Call Stack Tracking ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Call Stack Tracking keeps information about what parts of the story file the
interpreter is processing, which we can print for debugging.  For example,

	Instead of waiting:
		say "[the call stack]".

will produce text like

	within saying the call stack,
	within instead of waiting,
	within the instead stage rule,
	within the generate action rule,
	within the main story routine.

Details are in the following chapters.

Chapter: Usage

Section: Overview

Call Stack Tracking is an extension that tracks what parts of the story file the
interpreter is processing.  It is responsible for providing text like

	within saying the call stack,
	within instead of waiting,
	within the instead stage rule,
	within the generate action rule,
	within the main story routine.

in error messages.  In technical parlance this text is called the "backtrace",
or the "call stack".  The top line shows the rule or phrase in which the
interpreter is currently working, and subsequent lines list the rules and
phrases that precipitated it.  Thus, for this example we can see that the
interpreter is working on saying the call stack as part of a rule for what to do
instead of waiting.  That rule was triggered by the instead stage rule, which in
turn was fired by the generate action rule, itself called by the main story
routine in Inform's underlying machinery.

Section: Changing the information displayed in the call stack

In the previous section the call stack hid all but one internal routine (the
main story routine), and it left out information about the values of variables.
We can request this extra data by changing some truth states.  For instance,

	now the call stack simplification flag is false;

causes all of the internal routines to become visible:

	within saying the call stack,
	within instead of waiting,
	within the I6 routine ProcessRulebook,
	within the I6 routine ProcessRulebook,
	within the instead stage rule,
	within the I6 routine ProcessRulebook,
	within the I6 routine ProcessRulebook,
	within the I6 routine ActionPrimitive,
	within the I6 routine BeginAction,
	within the generate action rule,
	within the I6 routine ProcessRulebook,
	within the I6 routine ProcessRulebook,
	within the I6 routine FollowRulebook,
	within the main story routine.

Similarly,

	now the original arguments flag is true;
	now the temporary named values flag is true;
	now the catch tokens flag is true;

gives us the values of original arguments and temporary named values, not to
mention a list of generated catch tokens.  (Only a handful of authors ever need
to worry about catch tokens because Inform does not use them of its own accord.
But we include them for completeness.)  Running this code with the
instead-of-waiting example proves rather boring, so we will use some different
source text:

	To bar (X - a number) (this is barring):
		decrease X by 17;
		let the result be the player;
		say "[the simplified call stack with original arguments and temporary named values and catch tokens]".
	When play begins:
		let foo be 92;
		bar 55.

Its output is

	within saying the call stack
		(no original arguments)
		(no temporary named values)
		(no catch tokens),
	within barring
		(the original argument was
			<temporary named value 0> = <unknown kind>: 55)
		(the temporary named values are
			<temporary named value 0> = <unknown kind>: 38 and
			<temporary named value 1> = <unknown kind>: 395718)
		(no catch tokens),
	within when play begins
		(no original arguments)
		(the temporary named value is
			<temporary named value 0> = <unknown kind>: 92)
		(no catch tokens),
	within the when play begins stage rule
		(no original arguments)
		(no temporary named values)
		(no catch tokens),
	within the main story routine
		(the original arguments are unknown)
		(no temporary named values)
		(no catch tokens).

The 92, the 55, and the 38 are all straightforward.  The 395718, which is the
address of the yourself object in memory, is less obvious, especially because
Call Stack Tracking doesn't know the name of the result variable and calls it
<temporary named value 1>.  But if we include and configure the extensions Debug
File Parsing and Printing According to Kind Names, we get the following:

	within saying the call stack
		(no original arguments)
		(no temporary named values)
		(no catch tokens),
	within barring
		(the original argument was
			x = number: 55)
		(the temporary named values are
			x = number: 38 and
			the result = object: yourself)
		(no catch tokens),
	within when play begins
		(no original arguments)
		(the temporary named value is
			foo = number: 92)
		(no catch tokens),
	within the when play begins stage rule
		(no original arguments)
		(no temporary named values)
		(no catch tokens),
	within the main story routine
		(the original arguments are unknown)
		(no temporary named values)
		(no catch tokens).

We can also include memory addresses (to help us distinguish like-named rules or
phrases) with

	now the call stack addresses flag is true;

and add call frame numbers with

	now the call frame numbering flag is true;

To summarize:

	Table of Call Stack Flags
	Flag	Default Value	Meaning
	the original arguments flag	false	whether functions' original arguments are shown
	the temporary named values flag	false	whether functions' temporary named values are shown
	the catch tokens flag	false	whether catch tokens generated by functions are shown
	the call stack simplification flag	true	whether internal routines are hidden
	the call frame numbering flag	false	whether call frames are numbered
	the call stack addresses flag	false	whether function addresses are shown

Section: Inspecting the call stack programmatically

Internally Call Stack Tracking uses a fast but unwieldy data structure for
representing the call stack.  When we want to inspect the sequence of
outstanding calls in code, the first step is to request a translation from this
data structure to a collection of more usable values, which are of the kind
"call frame".  Such a request is made with the phrase

	the innermost call frame of a reconstructed call stack

whose result is a call frame for the most recent call, the one we think of as
being inside the others.

Each call frame will be of one of two sorts.  If it is

	a null call frame

then it serves only to represent the boundaries of the call stack, and it cannot
be inspected.  Otherwise, it represents an actual call, and we can apply the
phrases below.

To find neighboring call frames we can either loop over them, as in

	repeat with (I - a nonexisting call frame variable) running through (F - a call frame) and its ancestors:
		....

which sets I to F, then to the call just outside of F, and so on, or we can
request

	the outward link of (F - a call frame)

or

	the inward link of (F - a call frame)

which return the call frames immediately to the outside and inside of F.

Given a single call frame, we may ask for

	the uninstrumented function address of (F - a call frame)

which is the address of the function that it represents, before any
substitutions made by the Glulx Runtime Instrumentation Framework.  To obtain
the address after substitutions, we use code like the following:

	let the function address be the uninstrumented function address of F;
	let the actual function address be the address of the function substituted for the function at address function address;

Original arguments are available for every call frame except the outermost one.
If in doubt, we can ask:

	if the original arguments of (F - a call frame) are known:
		....

If they are known, they are counted by

	the original argument count of (F - a call frame)

and accessed by

	original argument (I - a number) of (F - a call frame)

We can check whether they were passed on the Glulx stack with

	if (F - a call frame) had its original arguments passed on the stack:
		....

Temporary named values work similarly, using

	the temporary named value count of (F - a call frame)

and

	temporary named value (I - a number) of (F - a call frame)

except that they are always known, and it is possible (if we are careful) to
modify them:

	write (X - a number) to temporary named value (I - a number) of (F - a call frame)

Catch tokens are kept in a read-only linked list (see the extension Low-Level
Linked Lists).  We can obtain it with the phrase

	the catch token linked list of (F - a call frame)

Finally, we should note that call frames are highly perishable, and any rule or
phrase that has obtained an innermost call frame must dispose of it before
finishing.  The appropriate wording to use is

	delete (F - a call frame) and its ancestors

Section: Saying individual call frames and controlling simplification

When we say the call stack, we are in fact saying call frames in various ways:

	say the location of (F - a call frame)

	say the original arguments of (F - a call frame)

	say the temporary named values of (F - a call frame)

and

	say the catch tokens of (F - a call frame)

These phrases produce output like

	within barring

	(the original argument was
		x = number: 55)

	(the temporary named values are
		x = number: 38 and
        	the result = object: yourself)

and

	(the catch tokens are 1280 and 1284)

respectively.  They can be accomplished with a single phrase like

	say (F - a call frame) with original arguments and temporary named variables and catch tokens

where items after "with" can be omitted, just as when saying the entire call
stack.

To decide whether a call frame would appear in a simplified call stack, we ask

	if (F - a call frame) is elided in the simplified call stack:
		....

or

	if (F - a call frame) is not elided in the simplified call stack:
		....

Calls to the functions tabulated in the extension I6 Routine Names and calls to
functions whose I6 names are Resolver_ followed by a number (if Debug File
Parsing is included) are ordinarily the only calls to have their frames hidden.
We can add more rules, phrases, or I6 routines to the set with the phrase

	elide calls to (A - a value) in the simplified call stack

Section: Frame-local variables

If we are writing GRIF instrumentation, it may be useful to know that Call Stack
Tracking includes facilities for simulating extra variables in a call frame,
automatically handling tricky cases like exception throws.  In a GRIF setup rule
we can write

	the index of a newly reserved call frame field

as in

	The scratch variable index is a number that varies.
	A GRIF setup rule (this is the allocate the scratch variable rule):
		now the scratch variable index is the index of a newly reserved call frame field.

to reserve space for one such variable.  The instrumentation can access it by
reading and writing to the address given by this phrase:

	extra field address (I - a number) of call frames for the chunk being instrumented as seen by that chunk

where I is the index obtained by the setup rule.

Although there is only one address, each call frame will see an unique variable;
in the event of recursion, Call Stack Tracking will swap variables in an out of
this space as appropriate.  Additionally, it will guarantee that such variables
are set to zero on function entry, so most instrumentation will not have to
worry about initialization.

If we need to recover such a variable from the call stack, the phrase to use is

	extra field (I - a number) of (A - a call frame)

This phrase returns a number, which we may have to convert to another kind with
the phrase from Low Level Operations.

As for changing a frame-local variable, the syntax is

	write (X - a value) to extra field (I - a number) of (A - a call frame)

A related phrase,

	extra field address (I - a number) of (A - a call frame)

is also available, but less often useful.  It returns the address where the
variable is saved at the moment, but remember that the variable might be moved
when the call stack changes.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Call Stack Tracking is subject to the caveats for the Glulx Runtime
Instrumentation Framework; see the requirements chapter in its documentation for
the technical details.

Section: Limitations that should not affect most authors

If the Glulx Runtime Instrumentation Framework is started manually, rather than
via the hijack main rule, the address of the outermost instrumented rule or
phrase must be declared beforehand, as in:

	now the uninstrumented function address of the outermost instrumented function is the function address of the quux rule;

After this function returns, the story should invoke the phrase

	now the uninstrumented function address of the outermost instrumented function is zero;

If a chunk not containing a function entry point is instrumented because of an
explicit request for the address of its instrumented version, the requester
should declare the owning function beforehand, as in

	now the address of the function claiming to own the chunk being instrumented is the function address of the quux rule;

and clear that declaration immediately after:

	now the address of the function claiming to own the chunk being instrumented is zero;

Section: Obscure limitations, which should affect almost nobody

The remaining restrictions are only relevant for authors who write Glulx
assembly code directly and authors who write self-modifying code:

A story file that includes Call Stack Tracking may throw exceptions in an
uninstrumented function and catch it in an instrumented one or vice versa, but
it may not throw and catch the exception in uninstrumented code when there are
intervening instrumented calls.

Instrumented functions must not share chunks.

Call Stack Tracking can only report values for the first sixteen locals.

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

Call Stack Tracking was prepared as part of the Glulx Runtime Instrumentation
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

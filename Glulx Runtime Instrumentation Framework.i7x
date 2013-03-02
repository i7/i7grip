Version 1 of Glulx Runtime Instrumentation Framework (for Glulx only) by Brady Garvin begins here.

"A framework for safely transforming a story's Glulx bytecode at runtime."

Include Compiler Version Checks by Brady Garvin.
Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Object Pools by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Human-Friendly Function Names by Brady Garvin.
Include I6 Routine Names by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[I'm not much for acronyms, but at the moment none of the IDEs complete I7 identifiers, and people get tired of typing long names.  Therefore, I will make one exception throughout the extension, beginning with this say phrase.]
To say GRIF:
	say "Glulx Runtime Instrumentation Framework".

[For each of the kinds defined by Glulx Runtime Instrumentation Framework you will see a sentence like

	A operation code record is an invalid operation code record.

This bewildering statement actually sets up operation code records as a qualitative value with default value the operation code record at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on operation code records.]

Chapter "Use Options" - unindexed

Use hot-swappable instrumentation translates as (- Constant GRIF_HOT_SWAP; -)

Use a GRIF substitution hash table size of at least 311 translates as (- Constant GRIF_SUBSTITUTION_HASH_SIZE={N}; -).
Use a GRIF operation code hash table size of at least 1123 translates as (- Constant GRIF_OPERATION_HASH_SIZE={N}; -).
Use a GRIF instruction vertex hash table size of at least 1123 translates as (- Constant GRIF_VERTEX_HASH_SIZE={N}; -).
Use a GRIF chunk translation hash table size of at least 3121 translates as (- Constant GRIF_CHUNK_HASH_SIZE={N}; -).
Use a GRIF hot-swap hash table size of at least 11213 translates as (- Constant GRIF_HOT_SWAP_HASH_SIZE={N}; -).
Use a GRIF disassembly label hash table size of at least 23 translates as (- Constant GRIF_DISASSEMBLY_LABEL_HASH_SIZE={N}; -).

Use a GRIF instruction vertex preallocation of at least 8192 translates as (- Constant GRIF_INSTRUCTION_VERTEX_PREALLOC={N}; -).

To decide what number is the GRIF substitution hash table size: (- GRIF_SUBSTITUTION_HASH_SIZE -).
To decide what number is the GRIF operation code hash table size: (- GRIF_OPERATION_HASH_SIZE -).
To decide what number is the GRIF instruction vertex hash table size: (- GRIF_VERTEX_HASH_SIZE -).
To decide what number is the GRIF chunk translation hash table size: (- GRIF_CHUNK_HASH_SIZE -).
To decide what number is the GRIF hot-swap hash table size: (- GRIF_HOT_SWAP_HASH_SIZE -).
To decide what number is the GRIF disassembly label hash table size: (- GRIF_DISASSEMBLY_LABEL_HASH_SIZE -).

To decide what number is the GRIF instruction vertex preallocation: (- GRIF_INSTRUCTION_VERTEX_PREALLOC -).

Chapter "Rulebooks"

The GRIF pre-hijacking rules are [rulebook is] a rulebook.
The GRIF setup rules are [rulebook is] a rulebook.
The GRIF anticipation rules are [rulebook is] a rulebook.
The GRIF shielding rules are [rulebook is] a rulebook.
The GRIF post-hijacking rules are [rulebook is] a rulebook.
The GRIF instrumented post-hijacking rules are [rulebook is] a rulebook.
The GRIF emendation rules are [rulebook is] a rulebook.
The GRIF instrumentation rules are [rulebook is] a rulebook.
The GRIF instrumentation adjustment rules are [rulebook is] a rulebook.
The GRIF internal instrumentation rules are [rulebook is] a rulebook.
The GRIF capture rules are [rulebook is] a rulebook.
    
Book "Runtime Checks"

Chapter "Environment Checks"

An environment check rule (this is the check for a modern Glulx to support GRIF rule):
	always check that the encoded Glulx version is at least 196864 or else say "[low-level runtime failure in]the [GRIF][with explanation]This story uses the [GRIF] (GRIF), which in turn depends on features added to the Glulx specification in version 3.1.0.  But this interpreter implements an older version of Glulx, meaning that GRIF cannot safely run.[terminating the story]".

An environment check rule (this is the check for dynamic memory allocation to support GRIF rule):
	always check that memory allocation is supported or else say "[low-level runtime failure in]the [GRIF][with explanation]This story uses the [GRIF] (GRIF), which in turn depends on dynamic memory allocation.  But this interpreter doesn't allow dynamic memory allocation, meaning that GRIF cannot safely run.[terminating the story]".

To decide what text is the last compiler version GRIF has been tested with:
	decide on "6G60".

An environment check rule (this is the check for a tested Inform version to support GRIF rule):
	always check that the current compiler version is at least the compiler version the last compiler version GRIF has been tested with or else say "[low-level runtime failure in]the [GRIF][with explanation]The story was compiled with Inform 7 version [the formatted current compiler version], but the [GRIF] has not been tested on versions of Inform before [the last compiler version GRIF has been tested with].  (If you understand the risks, you can suppress this message by writing[line break][line break][fixed letter spacing]    The check for a tested Inform version to support GRIF rule is not listed in the environment check rulebook.[variable letter spacing][warning type][line break][line break]in the source text.)[terminating the story]".

Chapter "Failure Messages" - unindexed

To fail at finding the hijack main rule in the startup rulebook (this is failing at finding the hijack main rule in the startup rulebook):
	say "[low-level runtime failure in]the [GRIF][with explanation]I tried to run the hijack main rule, but it wasn't called from within the startup rulebook, which is where it ought to be.[terminating the story]".

To fail at sign extending the lower (W - a number) bytes of (I - a number):
	say "[low-level runtime failure in]the [GRIF][with explanation]I tried to treat the lower [W in words] bytes of [I in hexadecimal] as something to sign extend, but I can only extend from zero, one, two, or four bytes.[terminating the story]".

To fail at reading (W - a number) bytes at address (A - a number):
	say "[low-level runtime failure in]the [GRIF][with explanation]I tried to read the [W in words] bytes at address [A in hexadecimal] as a unit, but I can only read zero-, one-, two-, or four-byte segments at a time.[terminating the story]".

To fail at recognizing the operation code (C - a number):
	say "[low-level runtime failure in]the [GRIF][with explanation][if the human-friendly function name hash table is not the invalid permanent hash table]While processing [the human-friendly name for the function at address the address of the chunk being instrumented] (at address [the address of the chunk being instrumented]/[the address of the chunk being instrumented in hexadecimal]), [end if]I encountered operation code [C in hexadecimal] ([C converted to a number] in decimal), which I know nothing about.  Perhaps the Table of Glulx Operation Codes is incomplete or corrupted?  Or maybe there is a mistake in the pointer arithmetic?[terminating the story]".

To fail at recognizing the function type (B - a number) for the function at address (A - a number):
	say "[low-level runtime failure in]the [GRIF][with explanation]I was expecting to find a function at address [A in hexadecimal], but the first byte was [B in hexadecimal], which, so far as I know, is not a valid starting byte for a function.  (Usually this means that the story tried to call a nonfunction as if it were a function, in which case it's about to crash.)[terminating the story]".

To fail at instrumenting nothing with (A - an instruction vertex):
	say "[low-level runtime failure in]the [GRIF][with explanation]I was asked to insert an instruction vertex ([the I6-like assembly of A]) at a time when nothing was being instrumented.[terminating the story]".

To fail at reusing (A - an instruction vertex):
	say "[low-level runtime failure in]the [GRIF][with explanation][if the human-friendly function name hash table is not the invalid permanent hash table]While processing [the human-friendly name for the function at address the address of the chunk being instrumented], [end if]I was asked to insert an instruction vertex ([the I6-like assembly of A]) twice, even though vertices can have only one location.[terminating the story]".

To fail at inserting (B - an instruction vertex) after (A - an instruction vertex) with no fallthrough:
	say "[low-level runtime failure in]the [GRIF][with explanation][if the human-friendly function name hash table is not the invalid permanent hash table]While processing [the human-friendly name for the function at address the address of the chunk being instrumented], [end if]I was asked to insert an instruction vertex ([the I6-like assembly of B]) after another vertex with no fallthrough ([the I6-like assembly of A]).[terminating the story]".

To fail at jumping vaguely from (A - an instruction vertex):
	say "[low-level runtime failure in]the [GRIF][with explanation][if the human-friendly function name hash table is not the invalid permanent hash table]While processing [the human-friendly name for the function at address the address of the chunk being instrumented], [end if]I tried to compute a jump parameter for an instruction ([the I6-like assembly of A]) without first figuring out where I was going to place it.[terminating the story]".

To fail at emitting the unplaced (A - an instruction vertex):
	say "[low-level runtime failure in]the [GRIF][with explanation][if the human-friendly function name hash table is not the invalid permanent hash table]While processing [the human-friendly name for the function at address the address of the chunk being instrumented], [end if]I tried to emit an instruction ([the I6-like assembly of A]) without first figuring out where I was going to place it.[terminating the story]".

To fail at self-instrumenting:
	say "[low-level runtime failure in]the [GRIF][with explanation]I was asked to instrument the [GRIF] itself, but I lack the requisite cleverness; to try would be like attempting a self-administered lobotomy.  Check that you aren't using the rules and phrases for instrumenting in the wrong context, either directly or by including instrumentation that injects them.[terminating the story]".

To fail at starting GRIF twice:
	say "[low-level runtime failure in]the [GRIF][with explanation]I was asked to start the [GRIF] a second time, but it can only be started once.[terminating the story]".

To fail at guessing the routine kernel of (A - a number) mid-instrumentation:
	say "[low-level runtime failure in]the [GRIF][with explanation]I was asked to ensure knowledge of any routine kernel of [the human-friendly name for the function at address A], but to do so I need access to the scratch space.  It's currently occupied.[terminating the story]".

To fail at initializing the disassembly label hash table twice with no intervening teardown:
	say "[low-level runtime failure in]the [GRIF][with explanation]I was asked to initialize the disassembly label hash table, but it was already initialized, and would need to be torn down before it could be initialized again.[terminating the story]".

To fail at tearing down the uninitialized disassembly label hash table:
	say "[low-level runtime failure in]the [GRIF][with explanation]I was asked to tear down the disassembly label hash table, but it wasn't initialized, and so could not be torn down.[terminating the story]".

Book "Additional Low-Level Operations" - unindexed

Chapter "Sign Extension" - unindexed

To decide what number is the sign extension of (I - a number) from (W - a number) byte/bytes:
	if W is:
		-- 0:
			decide on zero;
		-- 1:
			decide on I sign extended from a byte;
		-- 2:
			decide on I sign extended from a short;
		-- 4:
			decide on I;
	fail at sign extending the lower W bytes of I.

Chapter "Reading Memory" - unindexed

To decide what number is the (W - a number) byte/bytes at address (A - a number):
	if W is:
		-- 0:
			decide on zero;
		-- 1:
			decide on the byte at address A;
		-- 2:
			decide on the short at address A;
		-- 4:
			decide on the integer at address A;
	fail at reading W bytes at address A.

Chapter "Addressing modes"

Addressing mode is a kind of value.  The addressing modes are the invalid addressing mode, the zero-or-discard addressing mode, the constant addressing mode, the zero-based-dereference addressing mode, the stack addressing mode, the call-frame-local addressing mode, the ram-based-dereference addressing mode, the start-of-vertex addressing mode, and the near-end-of-vertex addressing mode.  The specification of an addressing mode is "The Glulx addressing modes represent the various ways that a Glulx instruction can read or write values.  They are documented in Section 1.5 of the Glulx VM specification, except for the start-of-vertex and near-end-of-vertex addressing modes.  GRIF changes the start-of-vertex addressing mode to a constant by following two steps: 1. find the instruction vertex at the address given and 2. determine where its instruction is emitted.  Near-end-of-vertex addressing mode is similar, and signifies a constant computed by those steps and also two more: 3. find the address at which a subsequent instruction could first appear, and 4. subtract two.  In other words, near-end-of-vertex addressing mode means the base address for relative jumps from the indicated vertex."

Section "Addressing Mode Encodings and Sizes" - unindexed

Every addressing mode has a number called the nybble for the widest encoding.
The nybble for the widest encoding of the invalid addressing mode is 4.
The nybble for the widest encoding of the zero-or-discard addressing mode is 0.
The nybble for the widest encoding of the constant addressing mode is 3.
The nybble for the widest encoding of the zero-based-dereference addressing mode is 7.
The nybble for the widest encoding of the stack addressing mode is 8.
The nybble for the widest encoding of the call-frame-local addressing mode is 11.
The nybble for the widest encoding of the ram-based-dereference addressing mode is 15.
The nybble for the widest encoding of the start-of-vertex addressing mode is 3.
The nybble for the widest encoding of the near-end-of-vertex addressing mode is 3.

Include (-
	Array GRIF_ADDRESSING_WIDTHS -->
		0 1 2 4
		0 1 2 4
		0 1 2 4
		0 1 2 4;
	Array GRIF_ADDRESSING_MODES -->
		(+ the zero-or-discard addressing mode +)		! 0
		(+ the constant addressing mode +)			! 1
		(+ the constant addressing mode +)			! 2
		(+ the constant addressing mode +)			! 3
		(+ the invalid addressing mode +)			! 4
		(+ the zero-based-dereference addressing mode +)		! 5
		(+ the zero-based-dereference addressing mode +)		! 6
		(+ the zero-based-dereference addressing mode +)		! 7
		(+ the stack addressing mode +)			! 8
		(+ the call-frame-local addressing mode +)		! 9
		(+ the call-frame-local addressing mode +)		! A
		(+ the call-frame-local addressing mode +)		! B
		(+ the invalid addressing mode +)			! C
		(+ the ram-based-dereference addressing mode +)		! D
		(+ the ram-based-dereference addressing mode +)		! E
		(+ the ram-based-dereference addressing mode +);		! F
-).

To decide what addressing mode is the addressing mode corresponding to the nybble (N - a number): (- llo_getField(GRIF_ADDRESSING_MODES,{N}) -).
To decide what number is the size corresponding to the nybble (N - a number): (- llo_getField(GRIF_ADDRESSING_WIDTHS,{N}) -).

Chapter "Operation Codes"

Section "Operation Code Parameters" - unindexed

Include (-
	Constant GRIF_MAX_PARAMETERS = 8;
-) after "Definitions.i6t".

To decide what number is the maximum number of parameters taken by any Glulx operation code: (- GRIF_MAX_PARAMETERS -).

Section "Influence on Control Flow"

Influence on control flow is a kind of value.  The plural of influence on control flow is influences on control flow.  The influences on control flow are ordinary control flow, jump without call, function call, string call, exception throw, exception catch, change of decoding table, and GLK call.  The specification of an influence on control flow is "The influences on control flow describe how a Glulx operation can affect the instruction pointer.  Most operations are marked with 'ordinary control flow' to indicate that they will fallthrough if their fallthrough flag is set, or else terminate the enclosing function (and perhaps the story as well).  Other possibilities include a jump, a call, an exception throw, etc.  In one unusual case an operation changes the decoding table before falling through, and the Glulx Runtime Instrumentation Framework treats that as a special case."

Section "The Table of Glulx Operation Codes"

Table of Glulx Operation Codes
I6 Assembly Name	Operation Code	Parameter Count	Load Parameter Count	Fallthrough	Influence on Control Flow	Relative Jump Addressing	Jump Parameter Index
"nop"	0	0	0	true	ordinary control flow	false	0
"add"	16	3	2	true	ordinary control flow	false	0
"sub"	17	3	2	true	ordinary control flow	false	0
"mul"	18	3	2	true	ordinary control flow	false	0
"div"	19	3	2	true	ordinary control flow	false	0
"mod"	20	3	2	true	ordinary control flow	false	0
"neg"	21	2	1	true	ordinary control flow	false	0
"bitand"	24	3	2	true	ordinary control flow	false	0
"bitor"	25	3	2	true	ordinary control flow	false	0
"bitxor"	26	3	2	true	ordinary control flow	false	0
"bitnot"	27	2	1	true	ordinary control flow	false	0
"shiftl"	28	3	2	true	ordinary control flow	false	0
"sshiftr"	29	3	2	true	ordinary control flow	false	0
"ushiftr"	30	3	2	true	ordinary control flow	false	0
"jump"	32	1	1	false	jump without call	true	0
"jz"	34	2	2	true	jump without call	true	1
"jnz"	35	2	2	true	jump without call	true	1
"jeq"	36	3	3	true	jump without call	true	2
"jne"	37	3	3	true	jump without call	true	2
"jlt"	38	3	3	true	jump without call	true	2
"jge"	39	3	3	true	jump without call	true	2
"jgt"	40	3	3	true	jump without call	true	2
"jle"	41	3	3	true	jump without call	true	2
"jltu"	42	3	3	true	jump without call	true	2
"jgeu"	43	3	3	true	jump without call	true	2
"jgtu"	44	3	3	true	jump without call	true	2
"jleu"	45	3	3	true	jump without call	true	2
"call"	48	3	2	true	function call	false	0
"return"	49	1	1	false	ordinary control flow	false	0
"catch"	50	2	1	true	exception catch	true	1
"throw"	51	2	2	false	exception throw	false	0
"tailcall"	52	2	2	false	function call	false	0
"copy"	64	2	1	true	ordinary control flow	false	0
"copys"	65	2	1	true	ordinary control flow	false	0
"copyb"	66	2	1	true	ordinary control flow	false	0
"sexs"	68	2	1	true	ordinary control flow	false	0
"sexb"	69	2	1	true	ordinary control flow	false	0
"aload"	72	3	2	true	ordinary control flow	false	0
"aloads"	73	3	2	true	ordinary control flow	false	0
"aloadb"	74	3	2	true	ordinary control flow	false	0
"aloadbit"	75	3	2	true	ordinary control flow	false	0
"astore"	76	3	3	true	ordinary control flow	false	0
"astores"	77	3	3	true	ordinary control flow	false	0
"astoreb"	78	3	3	true	ordinary control flow	false	0
"astorebit"	79	3	3	true	ordinary control flow	false	0
"stkcount"	80	1	0	true	ordinary control flow	false	0
"stkpeek"	81	2	1	true	ordinary control flow	false	0
"stkswap"	82	0	0	true	ordinary control flow	false	0
"stkroll"	83	2	2	true	ordinary control flow	false	0
"stkcopy"	84	1	1	true	ordinary control flow	false	0
"streamchar"	112	1	1	true	ordinary control flow	false	0
"streamnum"	113	1	1	true	ordinary control flow	false	0
"streamstr"	114	1	1	true	string call	false	0
"streamunichar"	115	1	1	true	ordinary control flow	false	0
"gestalt"	256	3	2	true	ordinary control flow	false	0
"debugtrap"	257	1	1	true	ordinary control flow	false	0
"getmemsize"	258	1	0	true	ordinary control flow	false	0
"setmemsize"	259	2	1	true	ordinary control flow	false	0
"jumpabs"	260	1	1	false	jump without call	false	0
"random"	272	2	1	true	ordinary control flow	false	0
"setrandom"	273	1	1	true	ordinary control flow	false	0
"quit"	288	0	0	false	ordinary control flow	false	0
"verify"	289	1	0	true	ordinary control flow	false	0
"restart"	290	0	0	false	ordinary control flow	false	0
"save"	291	2	1	true	ordinary control flow	false	0
"restore"	292	2	1	false	ordinary control flow	false	0
"saveundo"	293	1	0	true	ordinary control flow	false	0
"restoreundo"	294	1	0	true	ordinary control flow	false	0
"protect"	295	2	2	true	ordinary control flow	false	0
"glk"	304	3	2	true	GLK call	false	0
"getstringtbl"	320	1	0	true	ordinary control flow	false	0
"setstringtbl"	321	1	1	true	change of decoding table	false	0
"getiosys"	328	2	0	true	ordinary control flow	false	0
"setiosys"	329	2	2	true	ordinary control flow	false	0
"linearsearch"	336	8	7	true	ordinary control flow	false	0
"binarysearch"	337	8	7	true	ordinary control flow	false	0
"linkedsearch"	338	7	6	true	ordinary control flow	false	0
"callf"	352	2	1	true	function call	false	0
"callfi"	353	3	2	true	function call	false	0
"callfii"	354	4	3	true	function call	false	0
"callfiii"	355	5	4	true	function call	false	0
"mzero"	368	2	2	true	ordinary control flow	false	0
"mcopy"	369	3	3	true	ordinary control flow	false	0
"malloc"	376	2	1	true	ordinary control flow	false	0
"mfree"	377	1	1	true	ordinary control flow	false	0
"accelfunc"	384	2	2	true	ordinary control flow	false	0
"accelparam"	385	2	2	true	ordinary control flow	false	0
"numtof"	400	2	1	true	ordinary control flow	false	0
"ftonumz"	401	2	1	true	ordinary control flow	false	0
"ftonumn"	402	2	1	true	ordinary control flow	false	0
"ceil"	408	2	1	true	ordinary control flow	false	0
"floor"	409	2	1	true	ordinary control flow	false	0
"fadd"	416	3	2	true	ordinary control flow	false	0
"fsub"	417	3	2	true	ordinary control flow	false	0
"fmul"	418	3	2	true	ordinary control flow	false	0
"fdiv"	419	3	2	true	ordinary control flow	false	0
"fmod"	420	4	3	true	ordinary control flow	false	0
"sqrt"	424	2	1	true	ordinary control flow	false	0
"exp"	425	2	1	true	ordinary control flow	false	0
"log"	426	2	1	true	ordinary control flow	false	0
"pow"	427	3	2	true	ordinary control flow	false	0
"sin"	432	2	1	true	ordinary control flow	false	0
"cos"	433	2	1	true	ordinary control flow	false	0
"tan"	434	2	1	true	ordinary control flow	false	0
"asin"	435	2	1	true	ordinary control flow	false	0
"acos"	436	2	1	true	ordinary control flow	false	0
"atan"	437	2	1	true	ordinary control flow	false	0
"atan2"	438	3	2	true	ordinary control flow	false	0
"jfeq"	448	4	4	true	jump without call	true	3
"jfne"	449	4	4	true	jump without call	true	3
"jflt"	450	3	3	true	jump without call	true	2
"jfle"	451	3	3	true	jump without call	true	2
"jfgt"	452	3	3	true	jump without call	true	2
"jfge"	453	3	3	true	jump without call	true	2
"jisnan"	456	2	2	true	jump without call	true	1
"jisinf"	457	2	2	true	jump without call	true	1
"git"	31040	1	1	true	ordinary control flow	false	0

[To make writing literal operation codes easier, we define the following.  But we don't want them to take up any more space than necessary, so they are all inlined I6 constants.]
To decide what number is op-nop: (- 0 -).
To decide what number is op-add: (- 16 -).
To decide what number is op-sub: (- 17 -).
To decide what number is op-mul: (- 18 -).
To decide what number is op-div: (- 19 -).
To decide what number is op-mod: (- 20 -).
To decide what number is op-neg: (- 21 -).
To decide what number is op-bitand: (- 24 -).
To decide what number is op-bitor: (- 25 -).
To decide what number is op-bitxor: (- 26 -).
To decide what number is op-bitnot: (- 27 -).
To decide what number is op-shiftl: (- 28 -).
To decide what number is op-sshiftr: (- 29 -).
To decide what number is op-ushiftr: (- 30 -).
To decide what number is op-jump: (- 32 -).
To decide what number is op-jz: (- 34 -).
To decide what number is op-jnz: (- 35 -).
To decide what number is op-jeq: (- 36 -).
To decide what number is op-jne: (- 37 -).
To decide what number is op-jlt: (- 38 -).
To decide what number is op-jge: (- 39 -).
To decide what number is op-jgt: (- 40 -).
To decide what number is op-jle: (- 41 -).
To decide what number is op-jltu: (- 42 -).
To decide what number is op-jgeu: (- 43 -).
To decide what number is op-jgtu: (- 44 -).
To decide what number is op-jleu: (- 45 -).
To decide what number is op-call: (- 48 -).
To decide what number is op-return: (- 49 -).
To decide what number is op-catch: (- 50 -).
To decide what number is op-throw: (- 51 -).
To decide what number is op-tailcall: (- 52 -).
To decide what number is op-copy: (- 64 -).
To decide what number is op-copys: (- 65 -).
To decide what number is op-copyb: (- 66 -).
To decide what number is op-sexs: (- 68 -).
To decide what number is op-sexb: (- 69 -).
To decide what number is op-aload: (- 72 -).
To decide what number is op-aloads: (- 73 -).
To decide what number is op-aloadb: (- 74 -).
To decide what number is op-aloadbit: (- 75 -).
To decide what number is op-astore: (- 76 -).
To decide what number is op-astores: (- 77 -).
To decide what number is op-astoreb: (- 78 -).
To decide what number is op-astorebit: (- 79 -).
To decide what number is op-stkcount: (- 80 -).
To decide what number is op-stkpeek: (- 81 -).
To decide what number is op-stkswap: (- 82 -).
To decide what number is op-stkroll: (- 83 -).
To decide what number is op-stkcopy: (- 84 -).
To decide what number is op-streamchar: (- 112 -).
To decide what number is op-streamnum: (- 113 -).
To decide what number is op-streamstr: (- 114 -).
To decide what number is op-streamunichar: (- 115 -).
To decide what number is op-gestalt: (- 256 -).
To decide what number is op-debugtrap: (- 257 -).
To decide what number is op-getmemsize: (- 258 -).
To decide what number is op-setmemsize: (- 259 -).
To decide what number is op-jumpabs: (- 260 -).
To decide what number is op-random: (- 272 -).
To decide what number is op-setrandom: (- 273 -).
To decide what number is op-quit: (- 288 -).
To decide what number is op-verify: (- 289 -).
To decide what number is op-restart: (- 290 -).
To decide what number is op-save: (- 291 -).
To decide what number is op-restore: (- 292 -).
To decide what number is op-saveundo: (- 293 -).
To decide what number is op-restoreundo: (- 294 -).
To decide what number is op-protect: (- 295 -).
To decide what number is op-glk: (- 304 -).
To decide what number is op-getstringtbl: (- 320 -).
To decide what number is op-setstringtbl: (- 321 -).
To decide what number is op-getiosys: (- 328 -).
To decide what number is op-setiosys: (- 329 -).
To decide what number is op-linearsearch: (- 336 -).
To decide what number is op-binarysearch: (- 337 -).
To decide what number is op-linkedsearch: (- 338 -).
To decide what number is op-callf: (- 352 -).
To decide what number is op-callfi: (- 353 -).
To decide what number is op-callfii: (- 354 -).
To decide what number is op-callfiii: (- 355 -).
To decide what number is op-mzero: (- 368 -).
To decide what number is op-mcopy: (- 369 -).
To decide what number is op-malloc: (- 376 -).
To decide what number is op-mfree: (- 377 -).
To decide what number is op-accelfunc: (- 384 -).
To decide what number is op-accelparam: (- 385 -).
To decide what number is op-numtof: (- 400 -).
To decide what number is op-ftonumz: (- 401 -).
To decide what number is op-ftonumn: (- 402 -).
To decide what number is op-ceil: (- 408 -).
To decide what number is op-floor: (- 409 -).
To decide what number is op-fadd: (- 416 -).
To decide what number is op-fsub: (- 417 -).
To decide what number is op-fmul: (- 418 -).
To decide what number is op-fdiv: (- 419 -).
To decide what number is op-fmod: (- 420 -).
To decide what number is op-sqrt: (- 424 -).
To decide what number is op-exp: (- 425 -).
To decide what number is op-log: (- 426 -).
To decide what number is op-pow: (- 427 -).
To decide what number is op-sin: (- 432 -).
To decide what number is op-cos: (- 433 -).
To decide what number is op-tan: (- 434 -).
To decide what number is op-asin: (- 435 -).
To decide what number is op-acos: (- 436 -).
To decide what number is op-atan: (- 437 -).
To decide what number is op-atan2: (- 438 -).
To decide what number is op-jfeq: (- 448 -).
To decide what number is op-jfne: (- 449 -).
To decide what number is op-jflt: (- 450 -).
To decide what number is op-jfle: (- 451 -).
To decide what number is op-jfgt: (- 452 -).
To decide what number is op-jfge: (- 453 -).
To decide what number is op-jisnan: (- 456 -).
To decide what number is op-jisinf: (- 457 -).

Chapter "Operation Code Records" - unindexed

Section "The Operation Code Record Kind" - unindexed

A operation code record is a kind of value.
A operation code record is an invalid operation code record.  [See the note in the book "Extension Information."]
The specification of an operation code record is "Operation code records represent rows from the Table of Glulx Operation Codes in a form more convenient for the Glulx Runtime Instrumentation Framework.  They are only used internally."

Section "The Operation Code Record Structure" - unindexed

[Layout:
	4 bytes for the operation code
	4 bytes for the parameter limit (the parameter count less one)
	4 bytes for the parameter mode byte count (half the parameter count, rounded up)
	4 bytes for the fallthrough flag
	4 bytes for the influence on control flow
	4 bytes for the relative jump addressing flag
	4 bytes for the jump parameter index
	4 bytes for the I6 assembly name
	4 bytes for the load parameter limit entry]
[The first 28 bytes (up through the jump parameter index) must match the layout of instruction vertices.]

To decide what number is the size in memory of an operation code record: (- 36 -).

Section "Operation Code Record Construction and Destruction" - unindexed

To decide what operation code record is a new operation code record:
	decide on a permanent memory allocation of the size in memory of an operation code record bytes converted to an operation code record.

[Operation code records are never deleted.]

Section "Operation Code Record Accessors and Mutators" - unindexed

To decide what number is the operation code of (A - an operation code record): (- llo_getInt({A}) -).
To write the operation code (X - a number) to (A - an operation code record): (- llo_setInt({A},{X}); -).

To decide what number is the parameter limit of (A - an operation code record): (- llo_getField({A},1) -).
To write the parameter limit (X - a number) to (A - an operation code record): (- llo_setField({A},1,{X}); -).

To decide what number is the parameter mode byte count of (A - an operation code record): (- llo_getField({A},2) -).
To write the parameter mode byte count (X - a number) to (A - an operation code record): (- llo_setField({A},2,{X}); -).

To decide whether the fallthrough flag is set in (A - an operation code record): (- llo_getField({A},3) -).
To write the fallthrough flag (X - a truth state) to (A - an operation code record): (- llo_setField({A},3,{X}); -).

To decide what influence on control flow is the influence on control flow of (A - an operation code record): (- llo_getField({A},4) -).
To write the influence on control flow (X - an influence on control flow) to (A - an operation code record): (- llo_setField({A},4,{X}); -).

To decide whether the relative jump addressing flag is set in (A - an operation code record): (- llo_getField({A},5) -).
To write the relative jump addressing flag (X - a truth state) to (A - an operation code record): (- llo_setField({A},5,{X}); -).

To decide what number is the jump parameter index of (A - an operation code record): (- llo_getField({A},6) -).
To write the jump parameter index (X - a number) to (A - an operation code record): (- llo_setField({A},6,{X}); -).

To decide what text is the I6 assembly name of (A - an operation code record): (- llo_getField({A},7) -).
To write the I6 assembly name (X - some text) to (A - an operation code record): (- llo_setField({A},7,{X}); -).

To decide what number is the load parameter limit of (A - an operation code record): (- llo_getField({A},8) -).
To write the load parameter limit (X - a number) to (A - an operation code record): (- llo_setField({A},8,{X}); -).

To copy the shared fields of (A - an operation code record) to (B - an instruction vertex): (- llo_copy(28,{A},{B}); -).

Chapter "Operation Code Hash Table" - unindexed

The operation code hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate a permanent hash table for the Glulx operation codes rule):
	now the operation code hash table is a new permanent hash table with the GRIF operation code hash table size buckets;
	repeat through the Table of Glulx Operation Codes:
		let the record be a new operation code record;
		write the I6 assembly name I6 assembly name entry to the record;
		write the operation code operation code entry to the record;
		[The parameter limit is the parameter count minus one.]
		let the transformed parameter count be the parameter count entry minus one;
		write the parameter limit transformed parameter count to the record;
		[The parameter mode byte count is half the parameter count, rounding up.]
		now the transformed parameter count is the transformed parameter count arithmetically shifted one bit right;
		increment the transformed parameter count;
		write the parameter mode byte count transformed parameter count to the record;
		write the load parameter limit load parameter count entry minus one to the record;
		write the fallthrough flag fallthrough entry to the record;
		write the influence on control flow influence on control flow entry to the record;
		write the relative jump addressing flag relative jump addressing entry to the record;
		write the jump parameter index jump parameter index entry to the record;
		insert the key the operation code entry and the value the record into the operation code hash table.

To decide what operation code record is the record for the operation code (C - a number):
	let the permanent linked list vertex be the first match for the key C in the operation code hash table;
	always check that the permanent linked list vertex is not null or else fail at recognizing the operation code C;
	decide on the operation code record value of the permanent linked list vertex.

Book "Inform Information" - unindexed

Chapter "Routine Shell Identification" - unindexed

Section "Routine Shell Guesses" - unindexed

The kernel guess hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate a permanent hash table for tracking kernel guesses rule):
	now the kernel guess hash table is a new permanent hash table with the GRIF chunk translation hash table size buckets;

Section "Recognizing Routine Shell Components" - unindexed

To decide what number is blockv_stack: (- blockv_stack -).

To decide whether (A - an instruction vertex) couldn't be a pre-return aload in a routine shell:
	if A is null:
		decide yes;
	[This test is most likely to reject, so it goes first (apart from the nonnullness test).]
 	if parameter zero of A is not blockv_stack:
		decide yes;
	if the operation code of A is not op-aload:
		decide yes;
	if the addressing mode of parameter zero of A is not the constant addressing mode:
		decide yes;
	if the addressing mode of parameter one of A is not the stack addressing mode:
		decide yes;
	if the addressing mode of parameter one of A is not the stack addressing mode:
		decide yes;
	decide no.

Section "The Emendation Rule for Routine Shell Identification"

A GRIF emendation rule (this is the detect routine shells rule):
	if the kernel guess hash table contains the key the address of the chunk being instrumented:
		stop;
	insert the key the address of the chunk being instrumented into the kernel guess hash table;
	repeat with the instruction vertex running through occurrences of the operation code op-return in the scratch space:
		if the addressing mode of parameter zero of the instruction vertex is not the stack addressing mode or the previous link of the instruction vertex couldn't be a pre-return aload in a routine shell:
			stop;
	let the kernel address be zero;
	repeat with the instruction vertex running through occurrences of function call in the scratch space:
		if the addressing mode of parameter zero of the instruction vertex is not the constant addressing mode:
			stop;
		let the callee address be parameter zero of the instruction vertex;
		if the callee address is not the address of I6_RT__Err and the callee address is not the address of I6_BlkValueCreate and the callee address is not the address of I6_BlkFree:
			if the kernel address is not zero:
				stop;
			now the kernel address is the callee address;
	if the kernel address is not zero:
		associate the routine shell at address address of the chunk being instrumented with the routine kernel at address kernel address.

Section "Forcing Routine Shell Identification"

To guess the routine kernel for (A - a sayable value):
	let the function address be the function address of A;
	unless the kernel guess hash table contains the key the function address:
		always check that the mutable address of the chunk being instrumented is zero or else fail at guessing the routine kernel of the function address mid-instrumentation;
		parse the function at address the function address;
		now the mutable address of the chunk being instrumented is the function address;
		call the function at address the detect routine shells rule converted to a number;
		now the mutable address of the chunk being instrumented is zero.

Book "Directed Graph Representation of Instruction Chunks"

Chapter "Instruction Vertices"

Section "The Instruction Vertex Kind"

An instruction vertex is a kind of value.  The plural of instruction vertex is instruction vertices.
An instruction vertex is an invalid instruction vertex.  [See the note in the book "Extension Information."]
The specification of an instruction vertex is "Instruction vertices represent a single Glulx instruction during the Glulx Runtime Instrumentation Framework's rewrite process.  Besides gathering all of the information about an instruction into one data structure, instruction vertices also allow us to rearrange code quickly, and with the complications from jumps handled automatically."

Section "Instruction Vertex Constants"

To decide what instruction vertex is a null instruction vertex: (- 0 -).

Section "Instruction Vertex Adjectives"

Definition: an instruction vertex is null if it is a null instruction vertex.

Section "The Instruction Vertex Structure" - unindexed

[Layout:
	4 bytes for the operation code
	4 bytes for the parameter limit (the parameter count less one)
	4 bytes for the parameter mode byte count (half the parameter count, rounded up)
	4 bytes for the fallthrough flag
	4 bytes for the influence on control flow
	4 bytes for the relative jump addressing flag
	4 bytes for the jump parameter index
	4 bytes for the source address
	4 bytes for the source end address
	4 bytes for the destination offset
	4 bytes for the destination end offset
	4 bytes for the previous link
	4 bytes for the next link
	4 bytes for the sequence-ending instruction vertex address
	4 bytes for the jump predecessor linked list
	4 bytes for the jump link
	8 bytes per parameter (out to the maximum number of parameters, usually eight): 4 for the addressing mode and 4 for the value
	4 bytes for the shielded flag]
[The first 28 bytes (up through the jump parameter index) must match the layout of operation code records.]
[A new instruction vertex is normally filled with gibberish bits, except that none of the phrases that want to create new vertices will ever want the jump predecessor linked list address to be uninitialized or the shielded flag to be true; we guarantee that the former is null and the latter false.]
[Instruction vertices manage the lifetime of their jump predecessor linked lists; the linked list vertices are freed when the instruction vertex is deleted.]
[Parameters are numbered from zero.]

To decide what number is the size in memory of an instruction vertex:
	let the space for parameters be eight times the maximum number of parameters taken by any Glulx operation code;
	decide on 68 plus the space for parameters.

Section "Instruction Vertex Construction" - unindexed

The instruction vertex batch object pool is a batch object pool that varies.

A GRIF setup rule (this is the allocate a batch object pool for instruction vertices rule):
	now the instruction vertex batch object pool is a new permanent batch object pool with the GRIF instruction vertex preallocation objects of size the size in memory of an instruction vertex bytes.

[Reminder: we guarantee that the jump predecessor linked list address is null, and that the shielded flag is reset, but everything else could be gibberish.]
To decide what instruction vertex is a new instruction vertex:
	let the result be a memory allocation from the instruction vertex batch object pool converted to an instruction vertex;
	write the jump predecessor linked list an empty linked list to the result;
	reset the shielded flag in the result;
	decide on the result.

To decide what instruction vertex is a new detached instruction vertex:
	let the result be a memory allocation of the size in memory of an instruction vertex bytes converted to an instruction vertex;
	write the jump predecessor linked list an empty linked list to the result;
	reset the shielded flag in the result;
	decide on the result.

Section "Instruction Vertex Destruction"

[We are not careful to fix up the pointers that other instruction vertices have to the moribund vertex, because vertices should only be deleted when we toss the whole scratch space out the window.]
To delete (A - an instruction vertex):
	delete the jump predecessor linked list of A;
	free the memory allocation at address (A converted to a number) to the instruction vertex batch object pool if it is external.

Section "Private Instruction Vertex Accessors and Mutators" - unindexed

To write the source address (X - a number) to (A - an instruction vertex): (- llo_setField({A},7,{X}); -).

To write the source end address (X - a number) to (A - an instruction vertex): (- llo_setField({A},8,{X}); -).

To write the destination offset (X - a number) to (A - an instruction vertex): (- llo_setField({A},9,{X}); -).

To write the destination end offset (X - a number) to (A - an instruction vertex): (- llo_setField({A},10,{X}); -).

To write the previous link (X - an instruction vertex) to (A - an instruction vertex): (- llo_setField({A},11,{X}); -).

To write the next link (X - an instruction vertex) to (A - an instruction vertex): (- llo_setField({A},12,{X}); -).

To decide what instruction vertex is the sequence-ending instruction vertex of (A - an instruction vertex): (- llo_getField({A},13) -).
To write the sequence-ending instruction vertex (X - an instruction vertex) to (A - an instruction vertex): (- llo_setField({A},13,{X}); -).

To write the jump predecessor linked list (X - a linked list) to (A - an instruction vertex): (- llo_setField({A},14,{X}); -).

To write the jump link (X - an instruction vertex) to (A - an instruction vertex): (- llo_setField({A},15,{X}); -).

To decide what number is the source jump address of (A - an instruction vertex):
	let the influence on control flow be the influence on control flow of A;
	if the influence on control flow is jump without call or the influence on control flow is exception catch:
		let the jump parameter index be the jump parameter index of A;
		if the addressing mode of parameter jump parameter index of A is the constant addressing mode:
			let the offset be parameter jump parameter index of A;
			if the relative jump addressing flag is set in A:
				if the offset is not zero and the offset is not one:
					increase the offset by the source end address of A;
					decide on the offset minus two;
			otherwise:
				decide on the offset;
	decide on zero.

Section "Public Instruction Vertex Accessors and Mutators"

[We give the illusion that all of the data one could find in an operation code record are computed off the operation code: though those data are not writable, they change whenever the operation code does.  But in reality, we're caching it all and replacing the whole cache whenever the operation code is written.]
To decide what number is the operation code of (A - an instruction vertex): (- llo_getInt({A}) -).
To write the operation code (C - a number) to (A - an instruction vertex):
	copy the shared fields of the record for the operation code C to A.
To decide what text is the I6 assembly name of (A - an instruction vertex):
	[It's okay for this to be slow; it's just for debugging.]
	let the record be the record for the operation code the operation code of A;
	decide on the I6 assembly name of the record. 
To decide what number is the parameter limit of (A - an instruction vertex): (- llo_getField({A},1) -).
To decide what number is the parameter mode byte count of (A - an instruction vertex): (- llo_getField({A},2) -).
To decide what number is the load parameter limit of (A - an instruction vertex):
	[It's okay for this to be slow; it's rarely used.]
	let the record be the record for the operation code the operation code of A;
	decide on the load parameter limit of the record. 
To decide whether the fallthrough flag is set in (A - an instruction vertex): (- llo_getField({A},3) -).
To decide what influence on control flow is the influence on control flow of (A - an instruction vertex): (- llo_getField({A},4) -).
To decide whether the relative jump addressing flag is set in (A - an instruction vertex): (- llo_getField({A},5) -).
To decide what number is the jump parameter index of (A - an instruction vertex): (- llo_getField({A},6) -).

To decide what number is the source address of (A - an instruction vertex): (- llo_getField({A},7) -).

To decide what number is the source end address of (A - an instruction vertex): (- llo_getField({A},8) -).

To decide what number is the destination offset of (A - an instruction vertex): (- llo_getField({A},9) -).

To decide what number is the destination end offset of (A - an instruction vertex): (- llo_getField({A},10) -).

To decide what instruction vertex is the previous link of (A - an instruction vertex): (- llo_getField({A},11) -).

To decide what instruction vertex is the next link of (A - an instruction vertex): (- llo_getField({A},12) -).

To decide what linked list is the jump predecessor linked list of (A - an instruction vertex): (- ({A}-->14) -).

To decide what instruction vertex is the jump link of (A - an instruction vertex): (- llo_getField({A},15) -).
To establish a jump link from (A - an instruction vertex) to (B - an instruction vertex):
	let the old jump link be the jump link of A;
	if the old jump link is not null:
		remove the first occurrence of the key A from the jump predecessor linked list of the old jump link;
	write the jump link B to A;
	push the key A onto the jump predecessor linked list of B.

[Reminder: Parameters are numbered from zero.]
To decide what addressing mode is the addressing mode of parameter (P - a number) of (A - an instruction vertex): (- llo_getField({A},16+2*{P}) -).
To write the addressing mode (X - an addressing mode) to parameter (P - a number) of (A - an instruction vertex): (- llo_setField({A},16+2*{P},{X}); -).

To decide what number is parameter (P - a number) of (A - an instruction vertex): (- llo_getField({A},17+2*{P}) -).
To write (X - a number) to parameter (P - a number) of (A - an instruction vertex): (- llo_setField({A},17+2*{P},{X}); -).

To decide whether the shielded flag is set in (A - an instruction vertex): (- llo_getField({A},32) -).
To reset the shielded flag in (A - an instruction vertex): (- llo_setField({A},32,0); -).
To set the shielded flag in (A - an instruction vertex): (- llo_setField({A},32,1); -).

Section "Copying Instruction Vertices"

To copy the operation code and parameters from (A - an instruction vertex) to (B - an instruction vertex):
	let the space for parameters be eight times the maximum number of parameters taken by any Glulx operation code;
	copy 28 bytes from address (A converted to a number) to address (B converted to a number);
	copy the space for parameters bytes from address (A converted to a number plus 64) to address (B converted to a number plus 64).

Chapter "The Instrumentation Scratch Space"

Section "Scratch Space End Points"

[This is the vertex that represents the first instruction to execute in the chunk.]
The scratch space entry vertex is an instruction vertex that varies.

[This is the vertex that represents the first instruction of the chunk, according to our rearrangement.  For functions this must end up being the same as the entry vertex, though in the middle of instrumentation it could legally be something else.]
The scratch space beginning vertex is an instruction vertex that varies.

[This is the vertex that represents the last instruction of the chunk, according to our rearrangement.]
The scratch space end vertex is an instruction vertex that varies.

[This is the vertex that represents the first instruction of the last sequence of the chunk, according to our rearrangement.]
The scratch space last sequence-beginning vertex is an instruction vertex that varies.

Section "The Scratch Space Hash Table" - unindexed

[This table maps source addresses to instruction vertices.]
The scratch space hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for the scratch space rule):
	now the scratch space hash table is a new hash table with the GRIF instruction vertex hash table size buckets.

Section "Looking Up Instruction Vertices"

To decide what instruction vertex is the instruction vertex corresponding to source address (A - a number):
	decide on the first instruction vertex value matching the key A in the scratch space hash table or an invalid instruction vertex if there are no matches.

Section "Resetting the Scratch Space" - unindexed

To reset the scratch space:
	let light deletion possible be whether or not all relevant allocations are accounted for after freeing internal memory allocations to the instruction vertex batch object pool;
	let the current instruction vertex be the scratch space beginning vertex;
	if the current instruction vertex is not an invalid instruction vertex:
		if light deletion possible is true:
			while the current instruction vertex is not null:
				let the next instruction vertex be the next link of the current instruction vertex;
				let the key be the source address of the current instruction vertex;
				clear the bucket for the key key in the scratch space hash table;
				delete the jump predecessor linked list of the current instruction vertex;
				now the current instruction vertex is the next instruction vertex;
		otherwise:
			while the current instruction vertex is not null:
				let the next instruction vertex be the next link of the current instruction vertex;
				let the key be the source address of the current instruction vertex;
				clear the bucket for the key key in the scratch space hash table;
				delete the current instruction vertex;
				now the current instruction vertex is the next instruction vertex;
	now the scratch space entry vertex is a null instruction vertex;
	now the scratch space beginning vertex is a null instruction vertex;
	now the scratch space end vertex is a null instruction vertex.

Section "Iteration over the Scratch Space"

To repeat with (I - a nonexisting instruction vertex variable) running through the scratch space begin -- end: (-
	for({I}=(+ the scratch space beginning vertex +):{I}:{I}=llo_getField({I},12)) ! field 12 is the next link
-).

Include (-
	[ grif_atOrAfter key address offset result;
		if(~~address){
			return 0;
		}
		@linkedsearch
			key ! the key to search for
			4 ! the size of the key in bytes
			address ! the address of the first structure to search
			offset ! the offset to the key
			48 ! the offset to the link
			0 ! the options (no need for special options)
			result;
		return result;
	];
-).

To repeat with (I - a nonexisting instruction vertex variable) running through occurrences of the operation code (O - a number) in the scratch space begin -- end: (-
	for({I}=grif_atOrAfter({O},(+ the scratch space beginning vertex +),0):{I}:{I}=grif_atOrAfter({O},llo_getField({I},12),0)) ! field 12 is the next link, field 0 is the operation code
-).

To repeat with (I - a nonexisting instruction vertex variable) running through occurrences of (C - an influence on control flow) in the scratch space begin -- end: (-
	for({I}=grif_atOrAfter({C},(+ the scratch space beginning vertex +),16):{I}:{I}=grif_atOrAfter({C},llo_getField({I},12),16)) ! field 12 is the next link, field 4 is the influence on control flow
-).

Chapter "Debugging"

Section "Data Structures for Say Phrases" - unindexed

The disassembly label hash table is a hash table that varies.

Section "Data Structure Management for Say Phrases"

To initialize the disassembly label hash table:
	unless the disassembly label hash table is an invalid hash table:
		fail at initializing the disassembly label hash table twice with no intervening teardown;
	let the label count be zero;
	now the disassembly label hash table is a new hash table with the GRIF disassembly label hash table size buckets;
	repeat with the instruction vertex running through the scratch space:
		if the jump predecessor linked list of the instruction vertex is not empty:
			increment the label count;
			insert the key the instruction vertex and the value the label count into the disassembly label hash table.

To tear down the disassembly label hash table:
	if the disassembly label hash table is an invalid hash table:
		fail at tearing down the uninitialized disassembly label hash table;
	delete the disassembly label hash table;
	now the disassembly label hash table is an invalid hash table.

Section "Helper Functions for Partial Say Phrases" - unindexed

To print the I6-like assembly of (A - an instruction vertex), using labels if possible:
	say "[the I6 assembly name of A]";
	let the parameter limit be the parameter limit of A;
	repeat with the parameter index running from zero to the parameter limit:
		if the addressing mode of parameter parameter index of A is:
			-- the zero-or-discard addressing mode:
				say " <zero>";
			-- the constant addressing mode:
				if using labels if possible and the disassembly label hash table is not an invalid hash table and the parameter index is the jump parameter index of A:
					let the linked list vertex be the first match for the key the jump link of A in the disassembly label hash table;
					if the linked list vertex is not null:
						say " ?L[the number value of the linked list vertex]";
						next;
				say " [parameter parameter index of A in hexadecimal]";
			-- the zero-based-dereference addressing mode:
				say " *[parameter parameter index of A in hexadecimal]";
			-- the stack addressing mode:
				say " <stack>";
			-- the call-frame-local addressing mode:
				say " locals[bracket][parameter parameter index of A in hexadecimal][close bracket]";
			-- the ram-based-dereference addressing mode:
				say " *(RAM+[parameter parameter index of A in hexadecimal])";
			-- the start-of-vertex addressing mode:
				let the reference instruction vertex be parameter parameter index of A converted to an instruction vertex;
				let the reference offset be the destination offset of the reference instruction vertex;
				say " chunk+[the reference offset in hexadecimal](instruction [the source address of the reference instruction vertex in hexadecimal])";
			-- the near-end-of-vertex addressing mode:
				let the reference instruction vertex be parameter parameter index of A converted to an instruction vertex;
				let the reference offset be the destination end offset of the reference instruction vertex;
				say " chunk+[the reference offset minus two in hexadecimal](jump base after [the source address of the reference instruction vertex in hexadecimal])".

Section "Partial Say Phrases for Instructions"

To say the label of (A - an instruction vertex):
	if the disassembly label hash table is not the invalid hash table:
		let the linked list vertex be the first match for the key A in the disassembly label hash table;
		if the linked list vertex is not null:
			say ".L[the number value of the linked list vertex]:[line break]".

To say the source range of (A - an instruction vertex):
	let the source address be the source address of A;
	let the source end address be the source end address of A;
	say "[bracket][the source address in hexadecimal]--[the source end address in hexadecimal])".

To say the destination range of (A - an instruction vertex):
	let the destination offset be the destination offset of A;
	let the destination end offset be the destination end offset of A;
	say "[bracket][the destination offset in hexadecimal]--[the destination end offset in hexadecimal])/[bracket][the beginning of instructions in the emitted chunk plus the destination offset in hexadecimal]--[the beginning of instructions in the emitted chunk plus the destination end offset in hexadecimal])".

To say the fallthrough and jump of (A - an instruction vertex):
	if the fallthrough flag is set in A:
		let the next instruction vertex be the next link of A;
		if the next instruction vertex is null:
			say "(incomplete,";
		otherwise:
			say "([the source address of the next instruction vertex in hexadecimal],";
	otherwise:
		say "(none,";
	let the jump link be the jump link of A;
	if the jump link is null:
		say " none)";
	otherwise:
		say " [the source address of the jump link in hexadecimal])".

To say the I6-like assembly of (A - an instruction vertex):
	print the I6-like assembly of A.

To say the I6-like assembly of (A - an instruction vertex) using labels if possible:
	print the I6-like assembly of A, using labels if possible.

Section "The Human-Friendly Form of the Scratch Space"

To say the human-friendly form of (A - an instruction vertex):
	say "[the label of A]    [the source address of A in hexadecimal] [the I6-like assembly of A using labels if possible][line break]".

To say the human-friendly form of the scratch space:
	initialize the disassembly label hash table;
	say "[bracket]BEGINNING OF INSTRUCTIONS IN SCRATCH SPACE[close bracket][line break]";
	repeat with the instruction vertex running through the scratch space:
		say "[the human-friendly form of the instruction vertex]";
	say "[bracket]END OF INSTRUCTIONS IN SCRATCH SPACE[close bracket][paragraph break]";
	tear down the disassembly label hash table.

Section "The Detailed Human-Friendly Form of the Scratch Space"

[These are really only useful to someone maintaining GRIF or a GRIF extension.]

To say the detailed human-friendly form of (A - an instruction vertex):
	say "[the source range of A] [the fallthrough and jump of A] [the I6-like assembly of A][line break]".

To say the detailed human-friendly form of the scratch space:
	say "[bracket]BEGINNING OF INSTRUCTIONS IN SCRATCH SPACE[close bracket][line break]";
	repeat with the instruction vertex running through the scratch space:
		say "[the detailed human-friendly form of the instruction vertex]";
	say "[bracket]END OF INSTRUCTIONS IN SCRATCH SPACE[close bracket][paragraph break]".

Section "The Very Detailed Human-Friendly Form of the Scratch Space" - unindexed

[These are really only useful to someone maintaining GRIF.]

To say the very detailed human-friendly form of (A - an instruction vertex):
	say "[the source range of A] [the destination range of A] [the fallthrough and jump of A] [the I6-like assembly of A][line break]".

To say the very detailed human-friendly form of the scratch space:
	say "[bracket]BEGINNING OF INSTRUCTIONS IN SCRATCH SPACE[close bracket][line break]";
	repeat with the instruction vertex running through the scratch space:
		say "[the very detailed human-friendly form of the instruction vertex]";
	say "[bracket]END OF INSTRUCTIONS IN SCRATCH SPACE[close bracket][paragraph break]".

Chapter "Parsing"

Section "Parsing Instructions"

The shadowed address of the chunk being instrumented is a number that varies.

[We initialize every field except the destination offsets and the sequence-ending instruction vertex address.  The jump predecessors are initially none; that field might need tweaking in the caller.]
To decide what instruction vertex is a new instruction vertex for the instruction at address (A - a number), detached from the scratch space:
	let the result be an instruction vertex;
	if detached from the scratch space:
		[A little white lie to make GRIF failure messages less misleading if something goes wrong parsing the instruction at address A.]
		now the result is a new detached instruction vertex;
		now the shadowed address of the chunk being instrumented is the address of the chunk being instrumented;
		now the mutable address of the chunk being instrumented is A;
	otherwise:
		now the result is a new instruction vertex;
	let the relevant operation code be the byte at address A;
	let the mode address be A;
	if the relevant operation code is less than 128:
		increase the mode address by one;
	otherwise if the relevant operation code is less than 192:
		now the relevant operation code is the short at address A;
		decrease the relevant operation code by 32768;
		increase the mode address by two;
	otherwise:
		now the relevant operation code is the integer at address A;
		increase the relevant operation code by 1073741824;
		increase the mode address by four;
	write the operation code relevant operation code to the result;
	write the source address A to the result;
	let the instruction end address be the mode address plus the parameter mode byte count of the result;
	let the parameter limit be the parameter limit of the result;
	repeat with the parameter index running from zero to the parameter limit:
		let the primary address be the parameter index divided by two;
		increase the primary address by the mode address;
		let the secondary address be the bitwise and of the parameter index and one;
		let the mode be the nybble at address primary address and secondary address secondary address;
		let the addressing mode be the addressing mode corresponding to the nybble mode;
		let the size be the size corresponding to the nybble mode;
		write the addressing mode addressing mode to parameter parameter index of the result;
		let the parameter be the size bytes at address instruction end address;
		if the addressing mode is the constant addressing mode:
			now the parameter is the sign extension of the parameter from size bytes;
		write the parameter to parameter parameter index of the result;
		increase the instruction end address by the size;
	write the source end address instruction end address to the result;
	write the next link a null instruction vertex to the result;
	write the jump link a null instruction vertex to the result;
	if detached from the scratch space:
		write the previous link a null instruction vertex to the result;
		now the mutable address of the chunk being instrumented is the shadowed address of the chunk being instrumented;
	otherwise:
		if the scratch space end vertex is not null:
			write the next link the result to the scratch space end vertex;
		write the previous link the scratch space end vertex to the result;
		now the scratch space end vertex is the result;
		insert the key the source address of the result and the value result into the scratch space hash table;
	decide on the result.

Section "Helper Routines for Parsing Chunks" - unindexed

[We call this phrase when we realize that we saw the second half of a sequence before the first.  Because we must have just finished processing the first half, we want to move the second half (starting with the vertex A) so that the two join up.]
To relocate the instruction vertex sequence beginning with (A - an instruction vertex):
	let the sequence-ending instruction vertex be the sequence-ending instruction vertex of A;
	let the previous link be the previous link of A;
	let the next link be the next link of the sequence-ending instruction vertex;
	[Note that the next link cannot be null; if it were, then we would have a fallthrough cycle.]
	if the previous link is null:
		now the scratch space beginning vertex is the next link;
	otherwise:
		write the next link next link to the previous link;
	write the previous link previous link to the next link;
	write the next link A to the scratch space end vertex;
	write the previous link the scratch space end vertex to A;
	write the next link a null instruction vertex to the sequence-ending instruction vertex;
	now the scratch space end vertex is the sequence-ending instruction vertex;
	write the sequence-ending instruction vertex sequence-ending instruction vertex to the scratch space last sequence-beginning vertex.

To decide what instruction vertex is a new instruction vertex for the entry instruction at address (A - a number):
	let the result be a new instruction vertex for the instruction at address A;
	now the scratch space entry vertex is the result;
	now the scratch space beginning vertex is the result;
	now the scratch space last sequence-beginning vertex is the result;
	decide on the result.

To decide what instruction vertex is a new instruction vertex for the fallthrough-reached instruction at address (A - a number):
	let the result be a new instruction vertex for the instruction at address A;
	write the sequence-ending instruction vertex result to the scratch space last sequence-beginning vertex;
	decide on the result.

To decide what instruction vertex is a new instruction vertex for the jump-reached instruction at address (A - a number) seen by (B - an instruction vertex):
	let the result be a new instruction vertex for the instruction at address A;
	write the sequence-ending instruction vertex result to the result;
	now the scratch space last sequence-beginning vertex is the result;
	establish a jump link from B to the result;
	decide on the result.

[Return null if the instruction vertex would not be new.]
To decide what instruction vertex is a new instruction vertex for the instruction at address (A - a number) seen by (B - an instruction vertex):
	if the scratch space end vertex is null:
		decide on a new instruction vertex for the entry instruction at address A;
	let the known instruction vertex be the first instruction vertex value matching the key A in the scratch space hash table or a null instruction vertex if there are no matches;
	if the known instruction vertex is null:
		if the fallthrough flag is set in the scratch space end vertex:
			decide on a new instruction vertex for the fallthrough-reached instruction at address A;
		decide on a new instruction vertex for the jump-reached instruction at address A seen by B;
	if the fallthrough flag is set in the scratch space end vertex:
		relocate the instruction vertex sequence beginning with the known instruction vertex;
	otherwise:
		establish a jump link from B to the known instruction vertex;
	decide on a null instruction vertex.

Section "Parsing Chunks"

To parse the plain chunk at address (A - a number):
	reset the scratch space;
	let the jump worklist be an empty linked list;
	let the seeing instruction vertex be a null instruction vertex;
	let the current instruction address be A;
	[Outer loop: process a single chunk.]
	repeat until a break:
		[Inner loop: (possibly) process a single sequence.]
		repeat until a break:
			[Each iteration: (possibly) process a single instruction.]
			let the result be a new instruction vertex for the instruction at address current instruction address seen by the seeing instruction vertex;
			if the result is null:
				break;
			let the source jump address be the source jump address of the result;
			if the source jump address is not zero:
				push the key result and the value source jump address onto the jump worklist;
			unless the fallthrough flag is set in the result:
				break;
			now the seeing instruction vertex is the result;
			now the current instruction address is the source end address of the result;
		if the jump worklist is empty:
			break;
		let the next lead be a linked list vertex popped off of the jump worklist;
		now the seeing instruction vertex is the instruction vertex key of the next lead;
		now the current instruction address is the number value of the next lead;
		delete the next lead.

Section "Helper Routines for Parsing Functions" - unindexed

To decide what number is the size of the function header at address (A - a number):
	let the current address be A plus one;
	let the count be the size of memory minus the current address;
	now the count is the count logically shifted one bit right;
	decide on three plus two times the index of the short zero in the count shorts at address current address.

Section "Parsing Functions"

To parse the function at address (A - a number):
	always check that address A could contain a function or else fail at recognizing the function type the byte at address A for the function at address A;
	let the instruction pointer be A plus the size of the function header at address A;
	parse the plain chunk at address instruction pointer.

Chapter "Instrumenting"

Section "Artificial Source Addresses" - unindexed

The next available artificial source address is a number that varies.  The next available artificial source address is zero.
The first artificial source address is a number that varies.  The first artificial source address is zero.
The first artificial source address in the current generation is a number that varies.  The first artificial source address in the current generation is zero.

To prepare to instrument:
	now the next available artificial source address is the size of memory;
	now the first artificial source address is the next available artificial source address;
	now the first artificial source address in the current generation is the next available artificial source address.

Section "Managing Artificial Source Addresses"

To start a new generation of artificial vertices:
	now the first artificial source address in the current generation is the next available artificial source address.

Definition: an instruction vertex (called A) is artificial:
	decide on whether or not the source address of A is at least the first artificial source address.

To decide whether (A - an instruction vertex) is older than the current generation:
	decide on whether or not the source address of A is less than the first artificial source address in the current generation.

Section "Instruction Vertex Creation"

[This phrase used to exist, but it makes life unduly difficult with hot-swapping:  What would GRIF do if it needed to swap, mid-execution, to a reinstrumented version of the function, but the current program location no longer matched any vertex?  So, you may edit a non-artificial instruction vertex all you like, but you may not make it artificial.]
[To make (A - an instruction vertex) artificial and part of the current generation:
	write the source address next available artificial source address to A;
	increment the next available artificial source address;
	write the source end address next available artificial source address to A.]

[We only bother to set the source address fields and to clear the previous, next, and jump links.  The rest are up to the caller.]
To decide what instruction vertex is a new artificial instruction vertex:
	let the result be a new instruction vertex;
	write the source address next available artificial source address to the result;
	increment the next available artificial source address;
	write the source end address next available artificial source address to the result;
	write the previous link a null instruction vertex to the result;
	write the next link a null instruction vertex to the result;
	write the jump link a null instruction vertex to the result;
	insert the key the source address of the result and the value result into the scratch space hash table;
	decide on the result.

To decide what instruction vertex is a new artificial copy of (A - an instruction vertex):
	let the result be a new artificial instruction vertex;
	copy the operation code and parameters from A to the result;
	decide on the result.

Section "Internal Instruction Vertex Insertion" - unindexed

To insert (A - an instruction vertex) before (B - an instruction vertex) in the arrangement:
	let the previous link be the previous link of B;
	let the sequence-ending instruction vertex be the sequence-ending instruction vertex of B;
	if the previous link is null:
		now the scratch space beginning vertex is A;
	otherwise:
		write the next link A to the previous link;
	write the previous link the previous link to A;
	write the next link B to A;
	write the previous link A to B;
	write the sequence-ending instruction vertex the sequence-ending instruction vertex to A;
	if the scratch space entry vertex is B:
		now the scratch space entry vertex is A.

To insert (B - an instruction vertex) after the fallthrough of (A - an instruction vertex) in the arrangement:
	always check that the fallthrough flag is set in A or else fail at inserting B after A with no fallthrough;
	let the next link be the next link of A;
	write the next link B to A;
	write the previous link A to B;
	write the next link the next link to B;
	if the next link is null:
		now the scratch space end vertex is B;
	otherwise:
		write the previous link B to the next link.
	[No need to deal with sequence-ending fields because A is an instruction that could fall through, so it's not at the end of the sequence.]

Section "Abstracted Insertion of Insertion Vertices"

To insert (A - an instruction vertex) before entry:
	always check that the scratch space end vertex is not null or else fail at instrumenting nothing with A;
	always check that the scratch space end vertex is not A and the next link of A is null or else fail at reusing A;
	insert A before the scratch space entry vertex in the arrangement.

To insert (A - an instruction vertex) at the end of the arrangement:
	always check that the scratch space end vertex is not null or else fail at instrumenting nothing with A;
	always check that the scratch space end vertex is not A and the next link of A is null or else fail at reusing A;
	write the next link A to the scratch space end vertex;
	write the previous link the scratch space end vertex to A;
	now the scratch space end vertex is A.

To insert (A - an instruction vertex) before (B - an instruction vertex):
	always check that the scratch space end vertex is not A and the next link of A is null or else fail at reusing A;
	insert A before B in the arrangement;
	repeat with the jump predecessor running through the instruction vertex keys of the jump predecessor linked list of B:
		write the jump link A to the jump predecessor;
	write the jump predecessor linked list the jump predecessor linked list of B to A;
	write the jump predecessor linked list an empty linked list to B.

To insert (B - an instruction vertex) after (A - an instruction vertex):
	always check that the scratch space end vertex is not B and the next link of B is null or else fail at reusing B;
	insert B after the fallthrough of A in the arrangement.

Chapter "Arrangement of Instruction Vertices" - unindexed

To decide what number is the maximum size of (A - an instruction vertex):
	let the result be four plus the parameter mode byte count of A;
	let the parameter limit be the parameter limit of A;
	repeat with the parameter index running from zero to the parameter limit:
		let the mode be the addressing mode of parameter parameter index of A;
		if the mode is not the zero-or-discard addressing mode and the mode is not the stack addressing mode:
			increase the result by four;
	decide on the result.

To decide what number is the size of the laid out scratch space:
	let the next open destination offset be zero;
	repeat with the instruction vertex running through the scratch space:
		let the destination size be the maximum size of the instruction vertex;
		write the destination offset next open destination offset to the instruction vertex;
		increase the next open destination offset by the destination size;
		write the destination end offset the next open destination offset to the instruction vertex;
	decide on the next open destination offset.

Chapter "Emitting Instruction Vertices" - unindexed

The beginning of instructions in the emitted chunk is a number that varies.  The beginning of instructions in the emitted chunk is zero.

To decide which number is the destination jump parameter of (A - an instruction vertex):
	always check that the beginning of instructions in the emitted chunk is not zero or else fail at jumping vaguely from A;
	let the jump link be the jump link of A;
	if the jump link is not null:
		let the jump parameter be the destination offset of the jump link;
		if the relative jump addressing flag is set in A:
			decrease the jump parameter by the destination end offset of A;
			decide on the jump parameter plus two;
		otherwise:
			decide on the jump parameter plus the beginning of instructions in the emitted chunk;
	decide on zero.

To emit (A - an instruction vertex):
	always check that the beginning of instructions in the emitted chunk is not zero or else fail at emitting the unplaced A;
	let the current address be the beginning of instructions in the emitted chunk plus the destination offset of A;
	let the relevant operation code be the operation code of A;
	let the jump parameter index be the jump parameter index of A;
	let the jump parameter be the destination jump parameter of A;
	write the integer relevant operation code minus 1073741824 to address current address;
	increase the current address by four;
	let the parameter limit be the parameter limit of A;
	repeat with the parameter index running from zero to the parameter limit:
		let the mode be the constant addressing mode;
		if the parameter index is not the jump parameter index or the jump parameter is zero:
			now the mode is the addressing mode of parameter parameter index of A;
		let the current secondary address be the bitwise and of the parameter index and one;
		let the nybble be the nybble for the widest encoding of the mode;
		write the nybble nybble to address current address and secondary address current secondary address;
		if the current secondary address is one:
			increment the current address;
	if the parameter limit is even:
		write the nybble zero to address current address and secondary address one; [Just to be safe.]
		increment the current address;
	repeat with the parameter index running from zero to the parameter limit:
		if the parameter index is not the jump parameter index or the jump parameter is zero:
			let the mode be the addressing mode of parameter parameter index of A;
			if the mode is the start-of-vertex addressing mode:
				let the reference instruction vertex be parameter parameter index of A converted to an instruction vertex;
				let the reference address be the beginning of instructions in the emitted chunk plus the destination offset of the reference instruction vertex;
				write the integer reference address to address current address;
				increase the current address by four;
			otherwise if the mode is the near-end-of-vertex addressing mode:
				let the reference instruction vertex be parameter parameter index of A converted to an instruction vertex;
				let the reference address be the beginning of instructions in the emitted chunk plus the destination end offset of the reference instruction vertex;
				write the integer reference address minus two to address current address;
				increase the current address by four;
			otherwise if the mode is not the zero-or-discard addressing mode and the mode is not the stack addressing mode:
				write the integer parameter parameter index of A to address current address;
				increase the current address by four;
		otherwise:
			write the integer jump parameter to address current address;
			increase the current address by four.

[When A is zero, add no header.]
To decide what number is the address of the emitted scratch space with function header matching the function at address (A - a number):
	let the size be the size of the laid out scratch space;
	let the header size be zero;
	if A is not zero:
		now the header size is the size of the function header at address A;
	let the result be a permanent memory allocation of size plus the header size bytes;
	copy the header size bytes from address A to address result;
	now the beginning of instructions in the emitted chunk is the result;
	increase the beginning of instructions in the emitted chunk by the header size;
	repeat with the instruction vertex running through the scratch space:
		emit the instruction vertex;
	traverse the GRIF capture rulebook;
	now the beginning of instructions in the emitted chunk is zero;
	decide on the result.

Book "Instrumentation Workflow" - unindexed

Chapter "Instrumented Chunks" - unindexed

The instrumented chunks hash table is a permanent hash table that varies.
The instrumented chunk origin hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate permanent hash tables for tracking instrumented chunks rule):
	now the instrumented chunks hash table is a new permanent hash table with the GRIF chunk translation hash table size buckets;
	now the instrumented chunk origin hash table is a new permanent hash table with the GRIF chunk translation hash table size buckets.

Chapter "Hot-Swapping" - unindexed

[The code that triggers a hot-swap should always be uninstrumented.  That means that there are three cases where we might have to jump from an old instrumented version to a reinstrumented one: on entry to the old chunk (the old chunk may still be reachable because its address was folded into the caller/jumper), on returning from the swap-triggering call or one of its callers, or on catching a throw from within one of those callers.  Like Call Stack Tracking, we think of a throw/catch as a sequence of immediate returns, so the latter two cases happen at what we call ``return sites.'']

[Hot-swap points are implemented as jumps that read their destinations from memory.  Normally these jumps are to the next instruction, so they stay within one instrumented version and do not affect the program semantics.  But when a reinstrumentation comes along, its hot-swap points use the same memory locations as before, and the contents of those locations get updated in the instrumentation process.  Therefore, every old instrumented version will automatically swap to the latest version as soon as it encounters a hot-swap point, while the latest version will execute normally.

These permanent hash tables are where we store the memory locations (we call them redirection addresses) to use, keyed by source address of the chunk or return site.]

The chunk redirection hash table is a permanent hash table that varies.
The return site redirection hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate permanent hash tables for tracking redirection addresses rule):
	if the hot-swappable instrumentation option is active:
		now the chunk redirection hash table is a new permanent hash table with the GRIF chunk translation hash table size buckets;
		now the return site redirection hash table is a new permanent hash table with the GRIF hot-swap hash table size buckets.

To decide what number is the redirection address for the chunk at address (A - a number):
	let the permanent linked list vertex be the first match for the key A in the chunk redirection hash table;
	if the permanent linked list vertex is not null:
		decide on the number value of the permanent linked list vertex;
	let the result be a permanent memory allocation of four bytes;
	insert the key A and the value result into the chunk redirection hash table;
	decide on the result.

To decide what number is the redirection address for the return site at address (A - a number):
	let the permanent linked list vertex be the first match for the key A in the return site redirection hash table;
	if the permanent linked list vertex is not null:
		decide on the number value of the permanent linked list vertex;
	let the result be a permanent memory allocation of four bytes;
	insert the key A and the value result into the return site redirection hash table;
	decide on the result.

Chapter "Shielding"

Section "Permanent Hash Tables" - unindexed

The substitution hash table is a permanent hash table that varies.

A GRIF setup rule (this is the allocate a permanent hash table for storing substitutions rule):
	now the substitution hash table is a new permanent hash table with the GRIF substitution hash table size buckets.

Section "Shielding Phrases"

To shield (V - a sayable value) against instrumentation:
	let the function address be the function address of V;
	insert the key the function address and the value the function address into the instrumented chunks hash table.

To substitute the uninstrumented (S - a sayable value) for the instrumented (V - a sayable value):
	let the substitution be the function address of S;
	let the function address be the function address of V;
	insert the key the function address and the value the substitution into the instrumented chunks hash table;
	insert the key the function address and the value the substitution into the substitution hash table.

To substitute the instrumented (S - a sayable value) for the instrumented (V - a sayable value):
	let the uninstrumented substitution be the function address of S;
	let the substitution be the address of the instrumented version of the function at address uninstrumented substitution;
	[We handle chains of substitution on the next line.]
	now the uninstrumented substitution is the address of the function substituted for the function at address uninstrumented substitution;
	let the function address be the function address of V;
	insert the key the function address and the value the substitution into the instrumented chunks hash table;
	insert the key the function address and the value the uninstrumented substitution into the substitution hash table.

Section "Query Phrases"

To decide what number is the address of the function substituted for the function at address (A - a number):
	decide on the first number value matching the key A in the substitution hash table or A if there are no matches.

Chapter "Status"

Section "Private Status Data" - unindexed

The mutable address of the chunk being instrumented is a number that varies.  The mutable address of the chunk being instrumented is zero.

Containment of the function entry point by the chunk being instrumented is a truth state that varies.  Containment of the function entry point by the chunk being instrumented is false.

Section "Public Status Accessors"

To decide what number is the address of the chunk being instrumented: (- (+ the mutable address of the chunk being instrumented +) -).

To decide whether the chunk being instrumented contains the function entry point:
	decide on containment of the function entry point by the chunk being instrumented.

Chapter "Nonfunction Substitution Rule"

The nonfunction substitution rule is a rule that varies.

Chapter "Workflow Proper" - unindexed

To decide what number is the address of the instrumented version of the chunk at address (A - a number), a function and/or instrumenting anew (this is finding the address of the instrumented version of a chunk):
	let the permanent linked list vertex be the first match for the key A in the instrumented chunks hash table;
	if the permanent linked list vertex is not null and not instrumenting anew:
		decide on the number value of the permanent linked list vertex;
	always check that A is not the address of the function for finding the address of the instrumented version of a function or else fail at self-instrumenting;
	always check that A is not the address of the function for finding the address of the instrumented version of an offset plain chunk or else fail at self-instrumenting;
	now the mutable address of the chunk being instrumented is A;
	let the function header address be zero;
	if a function:
		unless address A could contain a function or the nonfunction substitution rule is the default value of a rule:
			substitute the instrumented nonfunction substitution rule for the instrumented A;
			decide on the address of the instrumented version of the function at address the function address of the nonfunction substitution rule;
		now the function header address is A;
		now containment of the function entry point by the chunk being instrumented is true;
		parse the function at address A;
	otherwise:
		now containment of the function entry point by the chunk being instrumented is false;
		parse the plain chunk at address A;
	prepare to instrument;
	traverse the GRIF emendation rulebook;
	traverse the GRIF instrumentation rulebook;
	traverse the GRIF instrumentation adjustment rulebook;
	traverse the GRIF internal instrumentation rulebook;
	[The GRIF capture rulebook is traversed as part of the next line, because the beginning of instructions in the emitted chunk can only be legally referenced while that phrase is running.]
	let the result be the address of the emitted scratch space with function header matching the function at address function header address;
	reset the scratch space;
	now the mutable address of the chunk being instrumented is zero;
	if the permanent linked list vertex is not null:
		write the value result to the permanent linked list vertex;
	otherwise:
		insert the key A and the value result into the instrumented chunks hash table;
	insert the key result and the value A into the instrumented chunk origin hash table;
	decide on the result.

Section "Reinstrumentation Phrases" - unindexed

To reinstrument the plain chunk at address (A - a number) (this is reinstrumenting a plain chunk):
	let the discarded address be the address of the instrumented version of the chunk at address A, instrumenting anew.

To reinstrument the function at address (A - a number) (this is reinstrumenting a function):
	let the discarded address be the address of the instrumented version of the chunk at address A, a function, instrumenting anew.

A GRIF shielding rule (this is the shield reinstrumenting phrases against instrumentation rule):
	shield reinstrumenting a plain chunk against instrumentation;
	shield reinstrumenting a function against instrumentation.

Chapter "Instrumentation Boundary Callbacks"

[We need these next two phrases to be named so that we can inject calls to them.  Besides, naming them makes it easier to recognize self-instrumentation bugs.]

Section "Private Callbacks" - unindexed

[A nonzero base address means that we should treat A as if it is a relative jump offset for an instruction ending at B; a zero value means that A is already an absolute address.]
[The address we return is absolute.  We do *not* convert it back to being relative from B.]
To decide what number is the address of the instrumented version of the plain chunk at offset (A - a number) relative to the base address (B - a number) (this is finding the address of the instrumented version of an offset plain chunk):
	let the chunk's absolute address be A;
	if B is not zero:
		increase the chunk's absolute address by B minus two;
	decide on the address of the instrumented version of the chunk at address the chunk's absolute address.

Section "Public Callbacks"

To decide what number is the address of the instrumented version of the function at address (A - a number) (this is finding the address of the instrumented version of a function):
	decide on the address of the instrumented version of the chunk at address A, a function.

Section "One-Time Call Translation" - unindexed

[Some duplicated code here.  Someday it will be cleaned up.]
To apply a one-time call translation of the function at address (A - a number) as requested by the instruction with jump base address (B - a number) (this is applying a one-time call translation):
	let the next instruction address be B plus two;
	zero the size in memory of a one-time call translation requester bytes at address the next instruction address minus the size in memory of a one-time call translation requester; [Zeros are @nops.]
	let the function address's address be the next instruction address;
	let the relevant operation code be the byte at address function address's address;
	if the relevant operation code is less than 128:
		increase the function address's address by one;
	otherwise if the relevant operation code is less than 192:
		now the relevant operation code is the short at address next instruction address;
		decrease the relevant operation code by 32768;
		increase the function address's address by two;
	otherwise:
		now the relevant operation code is the integer at address next instruction address;
		increase the relevant operation code by 1073741824;
		increase the function address's address by four;
	let the record be the record for the operation code relevant operation code;
	increase the function address's address by the parameter mode byte count of the record;
	let the translated address be the address of the instrumented version of the chunk at address A, a function;
	write the integer translated address to address function address's address.

Book "Instrumentation Idioms"

Chapter "Templates"

Section "Copy"

[ @copy <?-in-mode-SM> <?-in-mode-DM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a copy with source mode (SM - an addressing mode) and destination mode (DM - an addressing mode):
	let the result be a new artificial instruction vertex;
	write the operation code op-copy to the result;
	write the addressing mode SM to parameter zero of the result;
	write the addressing mode DM to parameter one of the result;
	decide on the result.

[ @copy <?-in-mode-SM> <DP-in-mode-DM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a copy with source mode (SM - an addressing mode) and destination mode (DM - an addressing mode) and destination parameter (DP - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-copy to the result;
	write the addressing mode SM to parameter zero of the result;
	write the addressing mode DM to parameter one of the result;
	write DP to parameter one of the result;
	decide on the result.

[ @copy <SP-in-mode-SM> <?-in-mode-DM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a copy with source mode (SM - an addressing mode) and source parameter (SP - a number) and destination mode (DM - an addressing mode):
	let the result be a new artificial instruction vertex;
	write the operation code op-copy to the result;
	write the addressing mode SM to parameter zero of the result;
	write SP to parameter zero of the result;
	write the addressing mode DM to parameter one of the result;
	decide on the result.

[ @copy <SP-in-mode-SM> <DP-in-mode-DM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a copy with source mode (SM - an addressing mode) and source parameter (SP - a number) and destination mode (DM - an addressing mode) and destination parameter (DP - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-copy to the result;
	write the addressing mode SM to parameter zero of the result;
	write SP to parameter zero of the result;
	write the addressing mode DM to parameter one of the result;
	write DP to parameter one of the result;
	decide on the result.

Section "Calls"

[ @callf A <?-in-mode-RM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a zero-argument call to the function at address (A - a number) with return mode (RM - an addressing mode):
	let the result be a new artificial instruction vertex;
	write the operation code op-callf to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write A to parameter zero of the result;
	write the addressing mode RM to parameter one of the result;
	decide on the result.

[ @callf A <RP-in-mode-RM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a zero-argument call to the function at address (A - a number) with return mode (RM - an addressing mode) and return parameter (RP - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-callf to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write A to parameter zero of the result;
	write the addressing mode RM to parameter one of the result;
	write RP to parameter one of the result;
	decide on the result.

[ @callfi A <P-in-mode-M> <?-in-mode-RM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a one-argument call to the function at address (A - a number) with mode (M - an addressing mode) and parameter (P - a number) and return mode (RM - an addressing mode):
	let the result be a new artificial instruction vertex;
	write the operation code op-callfi to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write A to parameter zero of the result;
	write the addressing mode M to parameter one of the result;
	write P to parameter one of the result;
	write the addressing mode RM to parameter two of the result;
	decide on the result.

[ @callfi A <P-in-mode-M> <RP-in-mode-RM>; ]
To decide what instruction vertex is a new artificial instruction vertex for a one-argument call to the function at address (A - a number) with mode (M - an addressing mode) and parameter (P - a number) and return mode (RM - an addressing mode) and return parameter (RP - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-callfi to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write A to parameter zero of the result;
	write the addressing mode M to parameter one of the result;
	write P to parameter one of the result;
	write the addressing mode RM to parameter two of the result;
	write RP to parameter two of the result;
	decide on the result.

Section "Jumps"

[ @jumpabs <constant>; ]
To decide what instruction vertex is a new artificial instruction vertex for an absolute jump with constant destination:
	let the result be a new artificial instruction vertex;
	write the operation code op-jumpabs to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	decide on the result.

[ @jumpabs <?-in-mode-M>; ]
To decide what instruction vertex is a new artificial instruction vertex for an absolute jump with mode (M - an addressing mode):
	let the result be a new artificial instruction vertex;
	write the operation code op-jumpabs to the result;
	write the addressing mode M to parameter zero of the result;
	decide on the result.

[ @jumpabs <P-in-mode-M>; ]
To decide what instruction vertex is a new artificial instruction vertex for an absolute jump with mode (M - an addressing mode) and parameter (P - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-jumpabs to the result;
	write the addressing mode M to parameter zero of the result;
	write P to parameter zero of the result;
	decide on the result.

Chapter "Stack Pop Cleansing"

Section "Stack Pop Cleansing Instruction Vertices" - unindexed

[ @copy sp S-->offset; ]
To decide what instruction vertex is a new stack-saving instruction vertex for parameter index (I - a number) using the array at address (S - a number):
	decide on a new artificial instruction vertex for a copy with source mode stack addressing mode and destination mode zero-based-dereference addressing mode and destination parameter where a stack pop for parameter index I is temporarily saved using the array at address S.

Section "Public Stack Pop Cleansing"

To decide what number is where a stack pop for parameter index (I - a number) is temporarily saved using the array at address (S - a number):
	decide on S plus I times four.

To cleanse (A - an instruction vertex) of stack pops using the array at address (S - a number):
	let the relevant operation code be the operation code of A;
	if the relevant operation code is op-catch:
		if the addressing mode of parameter one of A is the stack addressing mode:
			let the stack-saving instruction vertex be a new stack-saving instruction vertex for parameter index one using the array at address S;
			insert the stack-saving instruction vertex before A;
			write the addressing mode zero-based-dereference addressing mode to parameter one of A;
			write where a stack pop for parameter index one is temporarily saved using the array at address S to parameter one of A;
	otherwise:
		let the load parameter limit be the load parameter limit of A;
		repeat with the parameter index running from zero to the load parameter limit:
			if the addressing mode of parameter parameter index of A is the stack addressing mode:
				let the stack-saving instruction vertex be a new stack-saving instruction vertex for parameter index parameter index using the array at address S;
				insert the stack-saving instruction vertex before A;
				write the addressing mode zero-based-dereference addressing mode to parameter parameter index of A;
				write where a stack pop for parameter index parameter index is temporarily saved using the array at address S to parameter parameter index of A.

Book "Internal Emending" - unindexed

[This one requires some explanation.  Inform reserves some global variables for its own use in between sequence points.  On the Z machine there are seven, and under Glulx, eleven (at least, there were last time I looked in the I6N sources).  The trouble is, it's not at all unreasonable to want to put instrumentation between sequence points, and then, depending on how Inform compiled the instrumentation, we might clobber the reserved globals.  What we really want are two sets of reserved globals, one for instrumented functions and one for instrumentation.  We can't very easily change the instrumentation, so we change the instrumented functions.  There are two edge cases---where we switch from uninstrumented to instrumented as part of hijacking main and where we switch back again because of shielding---but both are safe because the switches only happen at sequence points.]

Include (-
	Constant GRIF_TEMPORARY_SPACE_COUNT = 11;
	Constant GRIF_TEMPORARY_SPACE_SIZE = 4*GRIF_TEMPORARY_SPACE_COUNT;
	Array grif_alternativeTemporarySpace -> GRIF_TEMPORARY_SPACE_SIZE;
-) after "Definitions.i6t".

To decide what number is the variable count of the temporary space: (- GRIF_TEMPORARY_SPACE_COUNT -).
To decide what number is the size of the temporary space: (- GRIF_TEMPORARY_SPACE_SIZE -).
To decide what number is the address of the alternative temporary space: (- grif_alternativeTemporarySpace -).

A GRIF emendation rule (this is the relocate temporary space rule):
	repeat with the instruction vertex running through the scratch space:
		let the parameter limit be the parameter limit of the instruction vertex;
		repeat with parameter index running from zero to the parameter limit:
			if the addressing mode of parameter parameter index of the instruction vertex is the ram-based-dereference addressing mode:
				let the offset be parameter parameter index of the instruction vertex;
				if the offset is unsigned less than the size of the temporary space:
					write the addressing mode zero-based-dereference addressing mode to parameter parameter index of the instruction vertex;
					write the address of the alternative temporary space plus the offset to parameter parameter index of the instruction vertex.

Book "Internal Instrumentation" - unindexed

Chapter "Addresses of Instrumentation Hooks" - unindexed

The address of the function for finding the address of the instrumented version of an offset plain chunk is a number that varies.  The address of the function for finding the address of the instrumented version of an offset plain chunk is zero.
The address of the function for finding the address of the instrumented version of a function is a number that varies.  The address of the function for finding the address of the instrumented version of a function is zero.
The address of the function for applying a one-time call translation is a number that varies.  The address of the function for applying a one-time call translation is zero.

A GRIF setup rule (this is the find the addresses of the instrumentation functions rule):
	now the address of the function for finding the address of the instrumented version of an offset plain chunk is the function address of finding the address of the instrumented version of an offset plain chunk;
	now the address of the function for finding the address of the instrumented version of a function is the function address of finding the address of the instrumented version of a function;
	now the address of the function for applying a one-time call translation is the function address of applying a one-time call translation.

Chapter "Internal Instrumentation for Jumps" - unindexed

Include (-
	Array grif_jumpPops --> 8;
	Array grif_jumpDestination --> 1;
-).
To decide what number is where stack pops are temporarily saved for GRIF jump instrumentation: (- grif_jumpPops -).
To decide what number is where a jump destination is temporarily saved for GRIF jump instrumentation: (- grif_jumpDestination -).

[ @jltu <P-in-mode-M> 2 <P-in-mode-M>; ]
To decide what instruction vertex is a new jump-as-return instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-jltu to the result;
	write the addressing mode M to parameter zero of the result;
	write P to parameter zero of the result;
	write the addressing mode M to parameter two of the result;
	write P to parameter two of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write two to parameter one of the result;
	decide on the result.

[ @callfii <finding-function> <P-in-mode-M> B grif_jumpDestination-->0; ]
To decide what instruction vertex is a new jump translation instruction vertex for mode (M - an addressing mode) and parameter (P - a number) at parameter index (I - a number) with base address (B - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-callfii to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write the address of the function for finding the address of the instrumented version of an offset plain chunk to parameter zero of the result;
	write the addressing mode M to parameter one of the result;
	write P to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	write B to parameter two of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter three of the result;
	write where a jump destination is temporarily saved for GRIF jump instrumentation to parameter three of the result;
	decide on the result.

[ @sub grif_jumpDestination-->0 <jump-base-for-vertex-V> grif_jumpDestination-->0; ]
To decide what instruction vertex is a new jump-correcting instruction vertex for (A - an instruction vertex):
	let the result be a new artificial instruction vertex;
	write the operation code op-sub to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where a jump destination is temporarily saved for GRIF jump instrumentation to parameter zero of the result;
	write the addressing mode near-end-of-vertex addressing mode to parameter one of the result;
	write (A converted to a number) to parameter one of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter two of the result;
	write where a jump destination is temporarily saved for GRIF jump instrumentation to parameter two of the result;
	decide on the result.

To convert (A - an instruction vertex) if it is an unknown jump:
	unless A is older than the current generation and the jump link of A is null:
		stop;
	if the shielded flag is set in A:
		stop;
	let the parameter limit be the parameter limit of A;
	let the plain chunk mode be the addressing mode of parameter parameter limit of A;
	if the plain chunk mode is the zero-or-discard addressing mode or the plain chunk mode is the constant addressing mode:
		stop;
	[Cleanse the instruction of stack pops first, so we don't have to worry about the order of reads.]
	cleanse A of stack pops using the array at address where stack pops are temporarily saved for GRIF jump instrumentation;
	[In case the plain chunk mode changed in the cleansing:]
	now the plain chunk mode is the addressing mode of parameter parameter limit of A;
	let the plain chunk parameter be parameter parameter limit of A;
	if the relative jump addressing flag is set in A:
		let the jump-as-return instruction vertex be a new jump-as-return instruction vertex for mode plain chunk mode and parameter plain chunk parameter;
		insert the jump-as-return instruction vertex before A;
		let the base address be the source end address of A;
		let the translation instruction vertex be a new jump translation instruction vertex for mode plain chunk mode and parameter plain chunk parameter at parameter index parameter limit with base address base address;
		insert the translation instruction vertex before A;
		let the jump-correcting instruction vertex be a new jump-correcting instruction vertex for A;
		insert the jump-correcting instruction vertex before A;
	otherwise:
		let the translation instruction vertex be a new jump translation instruction vertex for mode plain chunk mode and parameter plain chunk parameter at parameter index parameter limit with base address zero;
		insert the translation instruction vertex before A;
	write the addressing mode zero-based-dereference addressing mode to parameter parameter limit of A;
	write where a jump destination is temporarily saved for GRIF jump instrumentation to parameter parameter limit of A.

Chapter "Internal Instrumentation for Calls" - unindexed

Include (-
	Array grif_callDestination --> 1;
-).
To decide what number is where a call destination is temporarily saved for GRIF call instrumentation: (- grif_callDestination -).

[ @callfi <finding-function> <P-in-mode-M> grif_callDestination-->0; ]
To decide what instruction vertex is a new call translation instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	decide on a new artificial instruction vertex for a one-argument call to the function at address the address of the function for finding the address of the instrumented version of a function with mode M and parameter P and return mode zero-based-dereference addressing mode and return parameter where a call destination is temporarily saved for GRIF call instrumentation.

[ @callfii <finding-function> P <address-of-next-instruction-minus-two> 0; ]
To decide what instruction vertex is a new one-time call translation instruction vertex for parameter (P - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-callfii to the result;
	write the addressing mode constant addressing mode to parameter zero of the result;
	write the address of the function for applying a one-time call translation to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write P to parameter one of the result;
	write the addressing mode near-end-of-vertex addressing mode to parameter two of the result;
	write (the result converted to a number) to parameter two of the result;
	write the addressing mode zero-or-discard addressing mode to parameter three of the result;
	decide on the result.

[Four bytes for the op-code, two for addressing modes, four for each load parameter, and zero for the store parameter gives us 18 total bytes.]
To decide what number is the size in memory of a one-time call translation requester: (- 18 -).

To convert (A - an instruction vertex) if it is a call:
	if A is older than the current generation:
		if the shielded flag is set in A:
			stop;
		let the function mode be the addressing mode of parameter zero of A;
		let the function address be parameter zero of A;
		if the function mode is the constant addressing mode:
			let the permanent linked list vertex be the first match for the key function address in the instrumented chunks hash table;
			if the permanent linked list vertex is not null:
				let the translated address be the number value of the permanent linked list vertex;
				write the translated address to parameter zero of A;
				stop;
			unless the interpreter is git:
				let the translation instruction vertex be a new one-time call translation instruction vertex for parameter function address;
				insert the translation instruction vertex before A;
				stop;
		let the translation instruction vertex be a new call translation instruction vertex for mode function mode and parameter function address;
		insert the translation instruction vertex before A;
		write the addressing mode zero-based-dereference addressing mode to parameter zero of A;
		write where a call destination is temporarily saved for GRIF call instrumentation to parameter zero of A.

Chapter "Redirection for Reinstrumentation" - unindexed

Section "Hot-Swapping at the Chunk Entry Point" - unindexed

[Any changes to the scratch space after this phrase *must not* change the entry vertex or its next link.  Therefore, it's best to do this as late as possible.]
To add a hot-swapping point at the chunk entry point (this is adding a hot-swapping point at the chunk entry point):
	let the redirection address be the redirection address for the chunk at address the address of the chunk being instrumented;
	let the redirection instruction vertex be a new artificial instruction vertex for an absolute jump with mode zero-based-dereference addressing mode and parameter redirection address;
	insert the redirection instruction vertex before entry.

To capture the redirection for the hot-swapping point at the chunk entry point (this is capturing the redirection for the hot-swapping point at the chunk entry point):
	let the redirection address be the redirection address for the chunk at address the address of the chunk being instrumented;
	let the redirection destination instruction vertex be the next link of scratch space entry vertex;
	let the redirection destination address be the beginning of instructions in the emitted chunk plus the destination offset of redirection destination instruction vertex;
	write the integer redirection destination address to address redirection address.

Section "Hot-Swapping Mid-Chunk" - unindexed

To decide whether (A - an instruction vertex) is a return site harbinger:
	if A is artificial:
		decide no;
	let the influence on control flow be the influence on control flow of A;
	unless the influence on control flow is function call or the influence on control flow is exception catch:
		decide no;
	unless the fallthrough flag is set in A:
		decide no;
	decide yes.

To add a hot-swapping point after (A - an instruction vertex):
	let the source address be the source address of A;
	let the redirection address be the redirection address for the return site at address source address;
	let the redirection instruction vertex be a new artificial instruction vertex for an absolute jump with mode zero-based-dereference addressing mode and parameter redirection address;
	insert the redirection instruction vertex after A.

To capture the redirection for the hot-swapping point after (A - an instruction vertex):
	let the source address be the source address of A;
	let the redirection address be the redirection address for the return site at address source address;
	let the hot-swapping point be the next link of A;
	let the redirection destination be the next link of the hot-swapping point;
	let the redirection destination address be the beginning of instructions in the emitted chunk plus the destination offset of redirection destination;
	write the integer redirection destination address to address redirection address.

Chapter "Internal Instrumentation Rules" - unindexed

A GRIF internal instrumentation rule (this is the convert chunks reached by jumping and calling rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of jump without call in the scratch space:
		convert the instruction vertex if it is an unknown jump;
	repeat with the instruction vertex running through occurrences of exception catch in the scratch space:
		convert the instruction vertex if it is an unknown jump;
	repeat with the instruction vertex running through occurrences of function call in the scratch space:
		convert the instruction vertex if it is a call.

A GRIF internal instrumentation rule (this is the add hot-swapping points rule):
	if the hot-swappable instrumentation option is active:
		start a new generation of artificial vertices;
		add a hot-swapping point at the chunk entry point;
		repeat with the instruction vertex running through occurrences of function call in the scratch space:
			if the instruction vertex is a return site harbinger:
				add a hot-swapping point after the instruction vertex;
		repeat with the instruction vertex running through occurrences of exception catch in the scratch space:
			if the instruction vertex is a return site harbinger:
				add a hot-swapping point after the instruction vertex.

The add hot-swapping points rule is listed after the convert chunks reached by jumping and calling rule in the GRIF internal instrumentation rulebook.

Chapter "Internal Capture Rules" - unindexed

A GRIF capture rule (this is the capture redirections for hot-swapping points rule):
	if the hot-swappable instrumentation option is active:
		capture the redirection for the hot-swapping point at the chunk entry point;
		repeat with the instruction vertex running through occurrences of function call in the scratch space:
			if the instruction vertex is a return site harbinger:
				capture the redirection for the hot-swapping point after the instruction vertex;
		repeat with the instruction vertex running through occurrences of exception catch in the scratch space:
			if the instruction vertex is a return site harbinger:
				capture the redirection for the hot-swapping point after the instruction vertex.

Book "Git Integration" - unindexed

Include (-
	[ grif_isInterpreterGit result;
		@gestalt 31040 0 result;
		return result;
	];
	[ grif_gitCacheRAMFunctions;
		@"1:31040" 1; ! Thanks to Iain Merrick for the excellent operation code.
	];
-).

To decide whether the interpreter is git: (- grif_isInterpreterGit() -).
To ask git to cache RAM functions: (- grif_gitCacheRAMFunctions(); -).

A GRIF setup rule (this is the ask git to cache RAM functions rule):
	if the interpreter is git:
		ask git to cache RAM functions.

Book "Startup"

Chapter "Private Startup Data" - unindexed

GRIF already started is a truth state that varies.  GRIF already started is false.

Chapter "Manual Startup"

To start GRIF (this is starting GRIF):
	always check that GRIF already started is false or else fail at starting GRIF twice;
	now GRIF already started is true;
	traverse the GRIF setup rulebook;
	traverse the GRIF anticipation rulebook;
	traverse the GRIF shielding rulebook.

Chapter "Hijacking Startup" - unindexed

To start hijacking (this is starting GRIF hijacking):
	traverse the GRIF pre-hijacking rulebook.

To finish up hijacking (this is finishing up GRIF hijacking):
	traverse the GRIF post-hijacking rulebook.

Book "Hijacking Main"

Chapter "The Hijack Main Rule"

Include (-
	[ grif_redactStartupRulebook i j k;
		! Inform has two formats for rulebooks, one of which is cued by an initial -2.
		j=llo_getInt(B1_startup);
		if(j==-2){
			! Rules are divided into blocks with headers that say when they apply and how large they are.
			! We ignore the conditions, but we need to be sure that we don't overwrite them.
			for(i=3:j~=NULL:i=i+2){                        ! An outer loop where i points to the beginning of a block's rules; the header size is two entries.
				for(j=llo_getField(B1_startup,i),      ! i has moved each time we enter this inner loop, so we need to recompute j.
				    k=i+llo_getField(B1_startup,i-1):  ! The block length is in the previous entry; let k be the index where the next block starts.
				    i<k:                               ! Run the inner loop until the end of the block.
				    ++i,j=llo_getField(B1_startup,i)){ ! Increment in the same way as in the simple case.
					llo_setField(B1_startup,i,LITTLE_USED_DO_NOTHING_R);
					if(j==grif_hijackMain){
						rtrue;
					}
				}
			}
		}else{
			! Everything in the array is a rule address; life is simple.
			for(i=0:j~=NULL:++i,j=llo_getField(B1_startup,i)){
				llo_setField(B1_startup,i,LITTLE_USED_DO_NOTHING_R);
				if(j==grif_hijackMain){
					rtrue;
				}
			}
		}
		rfalse;
	];
	[ grif_hijackMain startup i persist;
		if(grif_redactStartupRulebook()){
			(llo_getField((+ starting GRIF hijacking +),1))();
			(llo_getField((+ starting GRIF +),1))();
			(llo_getField((+ finishing up GRIF hijacking +),1))();
			((llo_getField((+ finding the address of the instrumented version of a function +),1))(Main))();
		}else{
			(llo_getField((+ failing at finding the hijack main rule in the startup rulebook +),1))();
		}
		@quit;
	];
-).

The hijack main rule translates into I6 as "grif_hijackMain".

Chapter "The GRIF Instrumented Post-Hijacking Stage Rule"

This is the GRIF instrumented post-hijacking stage rule:
	traverse the GRIF instrumented post-hijacking rulebook.

Section "Placement of the Hijack Rules"

The GRIF instrumented post-hijacking stage rule is listed before the initialise memory rule in the startup rulebook.
The hijack main rule is listed before the GRIF instrumented post-hijacking stage rule in the startup rulebook.
The string-to-array implementation choosing rule is listed before the hijack main rule in the startup rulebook.

Book "Interactions with other Extensions"

Chapter "Safety for Runtime Checks"

A GRIF shielding rule (this is the shield runtime check reporting facilities against instrumentation rule):
	shield the address of I6_rc_ensureVisibility against instrumentation.

Chapter "Allowing or Disallowing Saves"

[Saving is often slow when GRIF and GRIF-based extensions are included because they use so much memory.  Consequently, GRIF doesn't interact well with extensions like Permadeath by Victor Gijsbers unless we do something to speed up the saving process.  The simplest thing we can do is simulate I/O errors so that saves always seem to fail.  But we predicate our fraud on a global boolean, and the author can overturn our policy either at compile time or while the story is running (for instance, via an Interactive Debugger perference).]

The GRIF allows saves flag is a truth state that varies.

Include (-
	[ grif_save stream;
		if(~~(+ the GRIF allows saves flag +)){
			return 1; ! return value for save failure
		}
		@save stream sp;
		@return sp;
	];
-).

To decide what number is the address of grif_save: (- grif_save -).

To convert (V - an instruction vertex) to an optional save:
	write the operation code op-callfi to V;
	write the addressing mode the addressing mode of parameter one of V to parameter two of V;
	write parameter one of V to parameter two of V;
	write the addressing mode the addressing mode of parameter zero of V to parameter one of V;
	write parameter zero of V to parameter one of V;
	write the addressing mode constant addressing mode to parameter zero of V;
	write the address of grif_save to parameter zero of V.

A GRIF internal instrumentation rule (this is the make saving conditionally successful rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of the operation code op-save in the scratch space:
		convert the instruction vertex to an optional save.

A GRIF shielding rule (this is the shield save interception against instrumentation rule):
	shield the address of grif_save against instrumentation.

Glulx Runtime Instrumentation Framework ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

The Glulx Runtime Instrumentation Framework (GRIF) is an extension for rewriting
a story while it is running.  The idea is that debugging tools can request the
insertion of extra programming, called instrumentation, to track story
information which is otherwise unavailable, and, if they wish, even alter the
story's behavior.

Chapter: Usage for Story Authors

GRIF is designed to be as invisible as possible to story authors.  So long as we
don't violate any of the restrictions in the requirements and limitations
chapter, all we should notice is a slight slow-down, depending mostly on the
amount of instrumentation being added.

Chapter: Background for Instrumentation and Extension Authors

Section: Glulx

Extensions built on GRIF operate almost directly on Glulx machine code, so a
working knowledge of the Glulx VM specification is more or less necessary.
Andrew Plotkin keeps an up-to-date version at

	http://eblong.com/zarf/glulx/

There is one point at which GRIF's view of the bytecode doesn't quite line up
with the specification.  In Glulx there are 14 legal addressing modes, some of
which act identically except in the number of bytes that they refer to.  But
GRIF always chooses full-width addressing modes, so from the perspective of
debugging tools the 14 become six:

	the zero-or-discard addressing mode

for Glulx addressing mode 0,

	the constant addressing mode

for Glulx addressing mode 3,

	the zero-based-dereference addressing mode

for Glulx addressing mode 7,

	the stack addressing mode

for Glulx addressing mode 8,

	the call-frame-local addressing mode

for Glulx addressing mode B, and

	the ram-based-dereference addressing mode

for Glulx addressing mode F.

Two other addressing modes,

	the start-of-vertex addressing mode

and

	the near-end-of-vertex addressing mode

are stand-ins for constants to be computed later.  The former takes an
instruction vertex (see below) converted to a number and produces the memory
address where that vertex's instruction is placed.  The latter does the same,
except that the address is two less than the end of the instruction, that being
the instruction's base address for jumps.

Section: Other terminology

GRIF also introduces some terminology of its own.  The Glulx functions as
compiled by Inform are called uninstrumented.  Each uninstrumented function may
have an instrumented version, which is the same function, but after GRIF has
rewritten it.

Actually, GRIF might not rewrite all of a function at once.  Instead, it
discovers functions in units called chunks and rewrites each chunk as needed.
For instance, if someone were to include assembly like

	@"1:32" sp;

(jump to the absolute address stored on the top of the stack) in an I6 routine,
GRIF would be unable to determine where the jump was destined, and it would be
forced to leave part of the function out of the chunk.  Only later, when the
actual stack value became known, would GRIF rewrite what remained.

Chapter: Overview for Instrumentation and Extension Authors

Section: How GRIF starts up

GRIF can start up in one of two ways.  Normally the extension puts two rules,
the hijack main rule and the GRIF instrumented post-hijacking stage rule, in the
startup rulebook.  The former runs through the GRIF setup process, removes any
startup rules that have already been executed, and then enters an instrumented
version of the I6 routine Main.  Main carries on with the startup, which means
that it triggers the stage rule, a general hook for debugging tools.  In effect
this means that GRIF extensions have complete control over everything that comes
after the hijack main rule.

However, sometimes when we're testing a debugging tool we want to focus on just
one or two functions.  For that case we can unlist the startup rules, and then
invoke an instrumented function manually:

	This is the interesting rule:
		....
	The hijack main rule is not listed in the startup rulebook.
	The GRIF instrumented post-hijacking stage rule is not listed in the startup rulebook.
	When play begins:
		start GRIF;
		let the uninstrumented function address be the function address of the interesting rule;
		let the instrumented function address be the address of the instrumented version of the function at address uninstrumented function address;
		call the function at address instrumented function address.

This code is very similar to the hijack main rule, except that the hijack main
rule traverses

	the GRIF pre-hijacking rulebook

before starting GRIF and

	the GRIF post-hijacking rulebook

afterwards.  If we need to simulate the hijacking process, we may want to do the
same.  For completeness, the instrumented post-hijacking stage rule traverses

	the GRIF post-hijacking rulebook

but it does so in instrumented code, which would correspond to the beginning of
the interesting rule in this example.

The phrase "start GRIF", whether used directly by us or through the hijack main
rule, can only be called once.  Its purpose is to run through three rulebooks:

	The GRIF setup rulebook
	The GRIF anticipation rulebook
	The GRIF shielding rulebook

GRIF setup rules are meant solely for initialization.  Call Stack Tracking, for
instance, contains this code to allocate storage:

	The call substack hash table is a hash table that varies.
	A GRIF setup rule (this is the allocate a hash table for the call substacks rule):
		now the call substack hash table is a new hash table with the call substack hash table size buckets.

It is not safe to use GRIF phrases with a setup rule, because GRIF too is in the
middle of allocating its data structures.

Next comes the anticipation rulebook.  It is for the rare cases where we need to
inspect a story's code before we commit to any instrumentation; we are allowed
to parse chunks, but not to alter them.  For example, if we are interested in
the address of a piece of text printed by an I6 routine, we could scour the
routine for @streamstr operation codes:

	A GRIF anticipation rule (this is the scour quux rule):
		let the uninstrumented function address be the function address of the quux rule;
		parse the function at address uninstrumented function address;
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			....

Finally, the GRIF shielding rulebook is where we can instruct GRIF that some
functions should not be instrumented, or that one function should be substituted
for another.  A shielding rule might look like this:

	This is the quux rule:
		....
	A GRIF shielding rule (this is the quux-shielding rule):
		shield the quux rule against instrumentation.

When all of these rulebooks have completed, GRIF is ready to rewrite code.

Section: How GRIF processes chunks

Much like when it starts up, GRIF consults a set of rulebooks every time it
rewrites a chunk.  These are:

	The GRIF emendation rulebook
	The GRIF instrumentation rulebook
	The GRIF instrumentation adjustment rulebook
	The GRIF internal instrumentation rulebook
	The GRIF capture rulebook

The emendation rulebook, as its name suggests, is for rules that make
corrections to a chunk, usually to fix problems that would be hard to identify
after instrumentation code has muddled things.  GRIF, for instance, uses an
emendation rule to keep instrumentation and instrumented code from clobbering
each other's memory.  Emendation rules are also a good place to take notes about
a function's original state.  For example, an instrumentation that wanted to
replace all instances of a certain instruction sequence should use an emendation
rule to note where those sequences appear.  But it should wait until the next
rulebook to make changes; otherwise it might disturb patterns that other
emendation rules are looking for.

The GRIF instrumentation rulebook comes next, and it contains the bulk of the
rewriting code.  As described in the following chapter, a GRIF instrumentation
rule is free to change a function's bytecode however it wishes, so long as it
leaves things in a valid state for the next rule.

After that comes the instrumentation adjustment rulebook.  Rarely used, this
rulebook is for detecting and counteracting problematic interactions between
instrumentation rules.  The extension Breakpoints, for instance, uses an
adjustment rule to make sure that triggered breakpoints do not skip over
instrumentation added by later rules.

Following that is the internal instrumentation rulebook, in which GRIF touches
up jumps and calls.  We should never change this rulebook: its rules must all
run, and they must come after every other instrumentation rule, or else the
story will almost surely crash.

Finally, when the bytecode has been finalized and written to memory, the GRIF
capture rulebook runs, giving extensions a chance to note where particular
instructions ended up being located.

Section: Restrictions during processing

Because GRIF rewrites functions as they are needed, it might need to do some
rewriting while Inform's block value management system is in the middle of
maintaining memory.  Therefore, it is safest not to mention any block value kind
at all; indexed text, lists, relations, and so on are all out.  Poor man's
replacements are available through the extensions Low-Level Text, Low-Level
Linked Lists, and Low-Level Hash Tables.

If we do accidentally mention such a kind, the failures may be intermittent and
only crop up in confusing errors long after the actual infraction.  (In early
development, one such bug went a whole week without being detected.)  The best
way to avoid trouble is to test the instrumentation on a minimal story,

	There is a room.

and check the intermediate I6 for routines with R_SHELL in their name.  These
routines must never match up with a rule or phrase that could run while GRIF is
processing a chunk (or, for that matter, a rule or phrase that could be called
by the instrumentation inserted in the block value management system).

We must also be careful not to change values that are visible to the story.
Tables are okay to use, but only if we don't disturb the current row.  In 6G60
and possibly other versions it is dangerous (but not necessarily fatal) to
follow, or consider, or abide by rules and rulebooks---we will alter Inform's
internal stack of rule frames.  We can, however, safely traverse a rulebook with
the phrase from Low-Level Operations.

Chapter: Guide to Phrases for Instrumentation and Extension Authors

Section: The chunk being instrumented

During the whole rewriting process, we have access to

	the address of the chunk being instrumented

which is either the address of the function in question if GRIF is working on a
function's first chunk, or the address of the first instruction if GRIF is
dealing with a subsequent chunk.  We can distinguish the two cases by asking

	if the chunk being instrumented contains the function entry point:
		....

But typically we will only check whether the address of the chunk being
instrumented is equal to the address of a function that we want to treat
specially.

Section: The scratch space and instruction vertices

While GRIF is rewriting, it represents bytecode as a set of vertices, one for
each instruction, linked together according to the flow of execution (in
computer science terminology, GRIF thinks of chunks in terms of their control
flow graph).  We can gain access to some vertices manually, by writing

	the scratch space entry vertex

for the vertex whose instruction will execute first,

	the scratch space beginning vertex

for the vertex whose instruction will appear first in memory, which is usually
the same (and in fact must be the same if the function entry point is present),
and

	the scratch space end vertex

for the vertex whose instruction will appear last.

Alternatively, we can look up vertices by the address of the instruction they
represent:

	the instruction vertex corresponding to source address (A - a number)

But the most common approach is to repeat over instruction vertices.  We can
loop over them all by writing

	repeat with (I - a nonexisting instruction vertex variable) running through the scratch space:
		....

over those with a particular operation code by writing

	repeat with (I - a nonexisting instruction vertex variable) running through occurrences of the operation code (O - a number) in the scratch space:
		....

or over those with a particular influence on control flow via

	repeat with (I - a nonexisting instruction vertex variable) running through occurrences of (C - an influence on control flow) in the scratch space:
		....

C in the last phrase should be one of the following values:

	ordinary control flow

meaning that no branching by the instruction is visible to GRIF,

	jump without call

for jump instructions,

	function call

for call instructions,

	string call

for instructions that might print compressed strings,

	exception throw

and
	exception catch

for @throw and @catch,

	change of decoding table

for @setstringtbl, and

	GLK call

for @glk.

Section: Navigating instruction vertices

We can find the vertex after another one by requesting

	the next link of (V - an instruction vertex)

If V has an operation code that permits fallthrough, this will be the vertex
that execution falls through to.  If not, it will be whatever vertex happens to
be arranged next in memory, or

	a null instruction vertex

if there is none.  Likewise,

	the previous link of (V - an instruction vertex)

gives the instruction vertex one place earlier in memory, or a null vertex if
there is none.  To follow branches forward we write

	the jump link of (V - an instruction vertex)

which decides on the vertex that this one jumps to, or a null vertex if there is
no jump or the jump destination isn't known.  We can ask for the vertices that
jump to the current one by obtaining

	the jump predecessor linked list of (V - an instruction vertex)

and then iterating over the list with the phrases from Low-Level Linked Lists.

Section: Debugging the scratch space and instruction vertices

We can print the scratch space or parts of it to the screen for debugging
purposes.  For the entire thing we write

	say "[the human-friendly form of the scratch space]";

Each line represents a single instruction or a jump label.  For instructions,
the first number says where the instruction lives in memory, and everything
after is a pseudocode version of the instruction's assembly.  For example,

	0x15E5D jne *(RAM+0x100) 0x1D ?L2

begins at byte 0x15E5D, and it will jump to the instruction labeled L2 if the
value offset 0x100 bytes from the start of RAM (the current action) is not 0x1D
(the jumping action).

If we had used

	say "[the detailed human-friendly form of the scratch space]";

instead, the same line would read

	(0x15E5D--0x15E67) (0x15E67, 0x15E9D) jne *(RAM+0x100) 0x1D 0x38

The first range is the set of addresses the instruction occupies, everything
from the 0x15E5D we saw earlier up to, but not including, 0x15E67.  (The left
bracket is normally square, but Inform would treat a lone square bracket in
extension documentation an an unclosed comment.)  The following pair shows two
addresses.  The first is for the instruction that will follow if the jump is not
taken, and the second represents the instruction that will run if it is.  The
pseudo-assembly is the same as before, except that we can see the actual values
behind jump labels.  But be warned that these values will be outdated if the
instrumentation process has redirected the jump.

If we only want to see pseudo-assembly for a particular instruction vertex, we
can use the phrase

	say the human-friendly form of (V - an instruction vertex)

or its relative

	say the detailed human-friendly form of (V - an instruction vertex)

The former will only print labels if they are available.  We can make them
available with the phrase

	initialize the disassembly label hash table

and we should remember to use the phrase

	tear down the disassembly label hash table

when we no longer need them.

We can also print parts of those phrases' output with

	say the label of (A - an instruction vertex)

	say the source range of (A - an instruction vertex)

	say the destination range of (A - an instruction vertex)

	say the I6-like assembly of (A - an instruction vertex)

and

	say the I6-like assembly of (A - an instruction vertex) using labels if possible

Saying the label will print nothing if the labels have not been made available;
similarly, the last say phrase will not use labels if it cannot find them.

Section: Inspecting instruction vertices

Instruction vertices provide a great deal of information about their
instructions.  We access it with the following phrases.

First, we can find out about the operation code, asking for it directly as a
number:

	the operation code of (V - an instruction vertex)

or as text:

	the I6 assembly name of (V - an instruction vertex)

GRIF pre-defines constants for the standard operation codes.  op-copy, for
instance, is the number 64, and we can check for a full-width copy with the
wording

	if the operation code of V is op-copy:
		....

rather than the cryptic

	if the operation code of V is 64:
		....

We can also request

	the parameter limit of (V - an instruction vertex)

which the largest legal parameter index for the operation.  GRIF numbers
parameters from zero, so an operation code like

	@copy L1 S1

has its load parameter numbered zero and its store parameter numbered one; the
parameter limit is one.  Likewise, for every operation code except @catch, we
can ask for

	the load parameter limit of (V - an instruction vertex)

which is the largest parameter index that still refers to a load parameter.
@copy has a load parameter limit of zero, whereas @getiosys, which takes no load
parameters, has a load parameter limit of negative one.

For jumps and catches, we may also be interested in

	the jump parameter index of (V - an instruction vertex)

which gives the index of the parameter that holds the jump label.  We can check
whether an instruction is a jump by asking for its effects on control flow:

	the influence on control flow of (V - an instruction vertex)

That phrase will decide on one of the possibilities that was mentioned in the
section on repeating through the scratch space.

For calls and jumps we may also wish to know if the following vertex is
reachable by fallthrough or not; we can ask

	if the fallthrough flag is set in (V - an instruction vertex)

and for jumps we can also determine whether the jump is relative or absolute:

	if the relative jump addressing flag is set in (V - an instruction vertex)

After the operation code and the derivative properties, the next most
interesting pieces of information are the parameters.  We have two phrases
available, both of which take a zero-based parameter index I:

	the addressing mode of parameter (I - a number) of (V - an instruction vertex)

and

	parameter (I - a number) of (V - an instruction vertex)

(Addressing modes are covered in the background chapter.)  The second phrase
returns whatever number is used by the corresponding addressing mode; it may be
a constant or an address.  Note that it is not meaningful to ask for the
parameter if the addressing mode is the zero-or-discard addressing mode or the
stack addressing mode.

Instruction vertices also track where they came from.  When we write

	the source address of (V - an instruction vertex)

we get the first address occupied by the instruction, and writing

	the source end address of (V - an instruction vertex)

gives us the smallest larger address that the instruction does not occupy.

In the GRIF capture rulebook, we can also find out where an instruction was
placed after the rewriting.  The two phrases

	the destination offset of (V - an instruction vertex)
and

	the destination end offset of (V - an instruction vertex)

give the endpoints as above, except that we must adjust them by adding

	the beginning of instructions in the emitted chunk

Finally, in rare cases an instruction vertex will be marked as "shielded", which
means that the internal instrumentation rules are not to touch it.  We can test
by asking

	if the shielded flag is set in (V - an instruction vertex):
		....

Section: Altering instruction vertices

The phrases for altering vertices are less numerous.  The syntax

	write the operation code (C - a number) to (V - an instruction vertex)

overwrites the operation code in the instruction vertex, as well as all of the
associated data.  To similarly change parameters we have

	write the addressing mode (X - an addressing mode) to parameter (I - a number) of (V - an instruction vertex)

and

	write (Y - a number) to parameter (I - a number) of (V - an instruction vertex)

Jump parameters are trickier though, because we usually don't know in advance
how the instructions will be rearranged in memory.  Rather than setting them
directly, we choose a suitable addressing mode and then write

	establish a jump link from (V - an instruction vertex) to (W - an instruction vertex)

GRIF will make the necessary corrections just before the GRIF capture rulebook
runs.

If we need to protect an instruction from this process, or any other internal
instrumentation process, we can mark it as shielded:

	set the shielded flag in (V - an instruction vertex)

If we later change our minds, we can remove the mark by saying

	reset the shielded flag in (V - an instruction vertex)

Lastly, we can make one vertex a clone of another:

	copy the operation code and parameters from (V - an instruction vertex) to (W - an instruction vertex)

Note that the previous, next, and jump links are not copied; they remain the
same as those that W had before.

Section: Artificial instruction vertices

To create vertices of our own, we ordinarily use the phrase

	a new artificial instruction vertex

An alternative is

	a new artificial copy of (V - an instruction vertex)

After setting its operation code and parameters, we can then place it in one of
four ways:

	insert (V - an instruction vertex) before entry

will make our vertex the new entry point for the chunk.  Jumps that were
pointing to the old chunk entry point will still point there, not to V.

	insert (V - an instruction vertex) before (W - an instruction vertex)

will ensure that our vertex's instruction is always executed before W.
Importantly, all jumps to the latter become jumps to V.

	insert (V - an instruction vertex) after (W - an instruction vertex)

is similar, except that our instruction will run after W (but only if it falls
through).

Lastly,

	insert (V - an instruction vertex) at the end of the arrangement

can be used to build whole new blocks of instructions: we add the block vertices
to the end of the arrangement in order and then establish jumps to make the new
block reachable.

Artificial instruction vertices must be placed.  To create an artificial
instruction vertex and then never use it can, in some situations, crash the
story.

Sometimes we still need to recognize artificial instruction vertices as such
after we've placed them.  The condition

	if (V - an instruction vertex) is artificial:
		....

is intended for this purpose.  If we further need to distinguish between
artificial instruction vertices, we can arrange them in generations.  The phrase

	start a new generation of artificial vertices

inaugurates a new generation, which will remain in effect until the phrase's
next invocation.  We can then test

	if (V - an instruction vertex) is older than the current generation:
		....

Section: Artificial instruction vertices via templates

For a few special cases we can create an artificial instruction vertex and set
its operation code and parameters all in one step.  The appropriate phrases
all begin with

	a new artificial instruction vertex for...

and the endings appear in the table below, along with the pseudoassembly for the
instruction that they create.  In some cases only the addressing mode is set;
usually these phrases are for use with the zero-or-discard addressing mode or
the stack addressing mode.

	Table of Instruction Template Phrases
	Pseudoassembly	Wording after "a new artificial instruction vertex for..."
	@copy <mode-SM> <mode-DM>;	a copy with source mode SM and destination mode DM
	@copy <mode-SM> <DP-in-mode-DM>;	a copy with source mode SM and destination mode DM and destination parameter DP
	@copy <SP-in-mode-SM> <mode-DM>;	a copy with source mode SM and source parameter SP and destination mode DM
	@copy <SP-in-mode-SM> <DP-in-mode-DM>;	a copy with source mode SM and source parameter SP and destination mode DM and destination parameter DP
	@callf A <mode-RM>;	a zero-argument call to the function at address A with return mode RM
	@callf A <RP-in-mode-RM>;	a zero-argument call to the function at address A with return mode RM and return parameter RP
	@callfi A <P-in-mode-M> <mode-RM>;	a one-argument call to the function at address A with mode M and parameter P and return mode RM
	@callfi A <P-in-mode-M> <RP-in-mode-RM>;	a one-argument call to the function at address A with mode M and parameter P and return mode RM and return parameter RP
	@jumpabs <constant>;	an absolute jump with constant destination
	@jumpabs <mode-M>;	an absolute jump with mode M
	@jumpabs <P-in-mode-M>;	an absolute jump with mode M and parameter P

Section: Anticipation phrases and detached instruction vertices

Anticipation rules are called by GRIF without the scratch space being
initialized.  If they are to inspect bytecode, they must tell GRIF to parse
instructions from memory.  Three phrases serve this purpose; the first two are

	parse the function at address (A - a number)

and

	parse the plain chunk at address (A - a number)

The former expects the address of a function, and the latter expects the address
of the first instruction of a chunk.  GRIF will handle the associated clean-up.

Occasionally we want GRIF to load instructions at other times, when we must be
careful not to clobber the scratch space.  At the moment this means using the
third phrase, which loads instructions one by one:

	a new instruction vertex for the instruction at address (A - a number), detached from the scratch space

(The text after the comma is mandatory.)  Because a vertex produced by this
phrase is not in the scratch space, it is not automatically managed.  On one
hand this is nice; we can keep vertices in memory for extended periods of time.
On the other hand, we incur responsibility for the vertices, and when we are
done with them we must use the phrase

	delete (A - an instruction vertex)

Section: Miscellaneous operations on instruction vertices

Given a suitably sized I6 array, in the form

	Array storage --> GRIF_MAX_PARAMETERS;

and a phrase to obtain its address, like

	To decide what number is the address of the example storage: (- storage -).

GRIF can convert instructions that pop values from the stack to instructions
that do not.  The phrase to use is

	cleanse (V - an instruction vertex) of stack pops using the array at address (S - a number)

For instance, in pseudo-assembly, the instruction

	@callfiii <stack> X <stack> Y <stack>;

with its vertex V would become

	@copy <stack> storage-->0;
	@copy <stack> storage-->2;
	@callfiii storage-->0 X storage-->2 Y <stack>;

if we wrote

	cleanse V of stack pops using the array at address the address of the example storage;

The last mention of <stack> is left untouched because it is a stack push, not a
stack pop.

Of course, we must be careful not to further cleanse the copy instructions with
the same array address; otherwise we might get something like

	@copy <stack> storage-->0;
	@copy <stack> storage-->0;
	@copy storage-->0 storage-->2;
	@callfiii storage-->0 X storage-->2 Y <stack>;

which is not at all the same.

The offsets into the array are determined by the parameter that is being
cleansed.  If we wish, we can obtain the address where the Ith parameter is
stored by computing

	where a stack pop for parameter index (I - a number) is temporarily saved using the array at address (S - a number)

Section: Other miscellaneous operations

As noted in the documentation for Human-Friendly Function Names, GRIF
automatically detects routine shells when it instruments them.  We can force it
to detect a routine shell earlier by writing

	guess the routine kernel for (A - a value)

where A is a rule or phrase or a function address that corresponds to a
candidate routine shell.

We can similarly force a function to be instrumented by asking for

	the address of the instrumented version of the function at address (A - a number)

But see the limitations chapter in Call Stack Tracking's documentation to avoid
unfortunate interactions between these phrases and its machinery.

Section: Shielding

When we have rules and phrases that we don't want to debug, we can protect them
from instrumentation by adding a shielding rule and using the phrase

	shield V against instrumentation

inside of it.  Here V is a rule, a phrase, or the address of an I6 routine.

We can also selectively replace code with either

	substitute the uninstrumented (S - a sayable value) for the instrumented (V - a sayable value)
or

	substitute the instrumented (S - a sayable value) for the instrumented (V - a sayable value)

again within a shielding rule.  The first means that calls to V from an
instrumented function will become calls to S, without any instrumentation.  The
second is in case we do want S to be instrumented.

Later, we can determine if a substitution has occurred by asking for

	the address of the function substituted for the function at address (A - a number)

which will be A if no substitution has been made, the function substituted
otherwise.

Chapter: Porting GRIF

At the time of writing at least three projects are underway with custom Glulx
operation codes.  If we are writing stories that use these operation codes, we
need to inform GRIF that they are legal.  We do so by extending the Table of
Glulx Operation Codes, as in:

	Table of Glulx Operation Codes (continued)
	I6 Assembly Name	Operation Code	Parameter Count	Load Parameter Count	Fallthrough	Influence on Control Flow	Relative Jump Addressing	Jump Parameter Index
	"textfyre"	4096	4	3	true	ordinary control flow	false	0

Most of the columns match up with phrases for inspecting instruction vertices.
One note though: the last two columns should be false and zero, respectively,
for non-jumping instructions.

Finally, as a convenience for instrumentation writers, we might want to give the
operation code an I7 name:

	To decide what number is op-textfyre: (- 4096 -).

Chapter: Regarding Undocumented Features

GRIF includes quite a few internal phrases, and it also comes packaged with some
incomplete, experimental features.  They are not documented here because they
may change without notice in future versions, and they certainly should not be
used in any publicly released extensions.  If something looks useful, and you
believe that it should become a documented feature, please file a suggestion on
the project's bugs and feature requests page.

Chapter: Requirements, Limitations, and Bugs

Extensions that include the framework, even indirectly, should include this
boilerplate text in their documentation:

	<Extension name> is subject to the caveats for the Glulx Runtime Instrumentation Framework; see the requirements chapter in its documentation for the technical details.

Section: Requirements that are relevant to most authors

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

It is wise, but not necessary, to have a fast interpreter running on a fast
machine; the framework will slow a story down.  For most stories, the Inform
development environment should be configured to use git rather than Glulxe as
the Glulx interpreter.

The framework depends on a virtual machine that supports version 3.1.0 or higher
of the Glulx specification, as well as dynamic memory.  At last check, all of
the interpreters that come with Inform met these requirements.

Saving can be quite slow when GRIF and GRIF-based extensions are included,
especially in an interpreter that uses CocoaGlk.  Therefore, GRIF forbids it by
default.  To allow it anyway, assert

	The GRIF allows saves flag is true.

in the source text.

Section: Obscure limitations, which should affect almost nobody

Rules before the hijack main rule in the startup rulebook are not instrumented.

GRIF alters the startup rulebook as part of its setup procedure.  The story
should not expect it to remain intact.

The Glulx specification allows the string decoding table to contain calls to
Glulx functions (see Section 1.6.1.4 of the Glulx specification).  Calls via
these nodes will run properly, but they will always invoke the uninstrumented
versions of their functions.  As best I can tell, this limitation only affects
authors who store routine addresses in I6 printing variables, and code of this
sort will break on the Z-machine, so it's not a good idea anyway.

There is no support for instrumenting self-modifying code, nor is it legal to
instrument the framework itself.  If the interpreter is git, the framework will
turn on caching for functions residing in RAM; any uninstrumented self-modifying
code is responsible for invalidating the appropriate cache entries when it
changes a function (see the documentation of the custom git operation codes).

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

Glulx Runtime Instrumentation Framework was prepared as the nucleus of the Glulx
Runtime Instrumentation Project (https://sourceforge.net/projects/i7grip/).  For
this first edition of the project, special thanks go to these people, in
chronological order:

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

For the Glulx Runtime Instrumentation Framework in particular, special thanks go
to Iain Merrick for the git opcodes to control whether functions in RAM are
cached by the interpreter.

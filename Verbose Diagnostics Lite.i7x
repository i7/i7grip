Version 1 of Verbose Diagnostics Lite (for Glulx only) by Brady Garvin begins here.

"Additional detail in the messages for runtime problems, programming errors, block value errors, and so on, to the extent that such detail can be given without loading debug information files (compare Verbose Diagnostics)."

"with the support for block value errors courtesy of Esteban Montecristo"

Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.
Include Call Stack Tracking by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

Chapter "Use Options" - unindexed

Use a block value routine hash table size of at least 311 translates as (- Constant VRPM_BLOCK_ROUTINE_HASH_SIZE={N}; -).
Use a indexed text routine hash table size of at least 311 translates as (- Constant VRPM_IT_ROUTINE_HASH_SIZE={N}; -).
Use a relation routine hash table size of at least 311 translates as (- Constant VRPM_REL_ROUTINE_HASH_SIZE={N}; -).
Use a memory stack routine hash table size of at least 311 translates as (- Constant VRPM_MST_ROUTINE_HASH_SIZE={N}; -).
Use a printing routine hash table size of at least 311 translates as (- Constant VRPM_PRINT_ROUTINE_HASH_SIZE={N}; -).
Use a miscellaneous routine hash table size of at least 311 translates as (- Constant VRPM_MISC_ROUTINE_HASH_SIZE={N}; -).

To decide what number is the block value routine hash table size: (- VRPM_BLOCK_ROUTINE_HASH_SIZE -).
To decide what number is the indexed text routine hash table size: (- VRPM_IT_ROUTINE_HASH_SIZE -).
To decide what number is the relation routine hash table size: (- VRPM_REL_ROUTINE_HASH_SIZE -).
To decide what number is the memory stack routine hash table size: (- VRPM_MST_ROUTINE_HASH_SIZE -).
To decide what number is the printing routine hash table size: (- VRPM_PRINT_ROUTINE_HASH_SIZE -).
To decide what number is the miscellaneous routine hash table size: (- VRPM_MISC_ROUTINE_HASH_SIZE -).

Book "The Call Stack Format"

To say the call stack for a verbose runtime problem message:
	say "[the call stack]".

Book "Runtime Problems" - unindexed

Responding to a runtime problem is a phrase nothing -> nothing that varies.

Chapter "Responding to a Runtime Problem" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a runtime problem (this is saying the call stack for a runtime problem):
	say "[the call stack for a verbose runtime problem message]".

Responding to a runtime problem is saying the call stack for a runtime problem.

Chapter "Responding to a Runtime Problem with a Breakpoint" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a runtime problem (this is forcing a breakpoint for a runtime problem):
	force a breakpoint named "Runtime problem".

Responding to a runtime problem is forcing a breakpoint for a runtime problem.

Chapter "The Custom Runtime Problem Handler" - unindexed

Include (-
	[ vrpm_RTPHandler n par1 par2 par3 In i c;
		enable_rte=true;
		RunTimeProblem(n,par1,par2,par3,In,i,c);
		(llo_getField((+ responding to a runtime problem +),1))();
	];
-).

Chapter "Runtime Problem Handler Addresses" - unindexed

To decide what rule is the default runtime problem handler: (- RunTimeProblem -).
To decide what rule is the custom runtime problem handler: (- vrpm_RTPHandler -).

Chapter "Shielding the Custom Runtime Problem Handler" - unindexed

A GRIF shielding rule (this is the substitute the custom runtime problem handler rule):
	substitute the uninstrumented custom runtime problem handler for the instrumented default runtime problem handler.

Book "Programming Errors" - unindexed

Responding to a programming error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Programming Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a programming error (this is saying the call stack for a programming error):
	say "[line break][the call stack for a verbose runtime problem message]".

Responding to a programming error is saying the call stack for a programming error.

Chapter "Responding to a Programming Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a programming error (this is forcing a breakpoint for a programming error):
	force a breakpoint named "Programming error".

Responding to a programming error is forcing a breakpoint for a programming error.

Chapter "The Custom Programming Error Handler" - unindexed

Include (-
	[ vrpm_PEHandler crime obj id size p q;
		RT__Err(crime,obj,id,size,p,q);
		(llo_getField((+ responding to a programming error +),1))();
	];
-).

Chapter "Programming Error Handler Addresses" - unindexed

To decide what rule is the default programming error handler: (- RT__Err -).
To decide what rule is the custom programming error handler: (- vrpm_PEHandler -).

Chapter "Shielding the Custom Programming Error Handler" - unindexed

A GRIF shielding rule (this is the substitute the custom programming error handler rule):
	substitute the uninstrumented custom programming error handler for the instrumented default programming error handler.

Book "Block Value Errors" - unindexed

[This is essentially what Esteban e-mailed in January of 2010, but tweaked to be more robust against changes to the Blk* implementations.]

Responding to a block value error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Block Value Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a block value error (this is saying the call stack for a block value error):
	say "[the call stack for a verbose runtime problem message]".

Responding to a block value error is saying the call stack for a block value error.

Chapter "Responding to a Block Value Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a block value error (this is forcing a breakpoint for a block value error):
	force a breakpoint named "Block value error".

Responding to a block value error is forcing a breakpoint for a block value error.

Chapter "The Custom Block Value Error Handler" - unindexed

Include (-
	[ vrpm_BVEHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a block value error +),1))();
	];
-).

Chapter "Block Value Error Handler Addresses" - unindexed

To decide what number is the address of the custom block value error handler: (- vrpm_BVEHandler -).

Chapter "Block Value Routines of Interest" - unindexed

The block value routine hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for block value routine identification rule):
	now the block value routine hash table is a new hash table with the block value routine hash table size buckets;
	insert the key the address of I6_BlkAllocate into the block value routine hash table;
	insert the key the address of I6_BlkAllocationError into the block value routine hash table;
	insert the key the address of I6_BlkDebug into the block value routine hash table;
	insert the key the address of I6_BlkDebugDecomposition into the block value routine hash table;
	insert the key the address of I6_BlkFree into the block value routine hash table;
	insert the key the address of I6_BlkFreeSingleBlock into the block value routine hash table;
	insert the key the address of I6_BlkMerge into the block value routine hash table;
	insert the key the address of I6_BlkRecut into the block value routine hash table;
	insert the key the address of I6_BlkResize into the block value routine hash table;
	insert the key the address of I6_BlkSize into the block value routine hash table;
	insert the key the address of I6_BlkTotalSize into the block value routine hash table;
	insert the key the address of I6_BlkType into the block value routine hash table;
	insert the key the address of I6_BlkValueCast into the block value routine hash table;
	insert the key the address of I6_BlkValueCompare into the block value routine hash table;
	insert the key the address of I6_BlkValueCopy into the block value routine hash table;
	insert the key the address of I6_BlkValueCreate into the block value routine hash table;
	insert the key the address of I6_BlkValueDestroy into the block value routine hash table;
	insert the key the address of I6_BlkValueExtent into the block value routine hash table;
	insert the key the address of I6_BlkValueHash into the block value routine hash table;
	insert the key the address of I6_BlkValueInitialCopy into the block value routine hash table;
	insert the key the address of I6_BlkValueRead into the block value routine hash table;
	insert the key the address of I6_BlkValueReadFromFile into the block value routine hash table;
	insert the key the address of I6_BlkValueSetExtent into the block value routine hash table;
	insert the key the address of I6_BlkValueWrite into the block value routine hash table;
	insert the key the address of I6_BlkValueWriteToFile into the block value routine hash table.

Chapter "Block Value Routine Instrumentation" - unindexed

Section "The Block Value Error Suffix" - unindexed

To decide what text is the first nonsynthetic block value error suffix: (- "***" -).
To decide what text is the second nonsynthetic block value error suffix: (- "***^" -).

The first block value error suffix is a text that varies.
The second block value error suffix is a text that varies.
A GRIF setup rule (this is the allocate the synthetic text for the block value error suffix rule):
	now the first block value error suffix is a new synthetic text copied from the first nonsynthetic block value error suffix;
	now the second block value error suffix is a new synthetic text copied from the second nonsynthetic block value error suffix.

Section "Block Value Routine Instrumentation Proper" - unindexed

[ !From @streamstr <parameter-zero>; ]
[ @callfi vrpm_BVEHandler <moved-from-parameter-zero> 0; ]
To replace (A - an instruction vertex) with a block value error handler invocation if it is printing a block value error:
	if the addressing mode of parameter zero of A is the constant addressing mode:
		let the message be parameter zero of A converted to some text;
		let the synthetic message be a new synthetic text copied from the message;
		if the synthetic text the synthetic message ends with the synthetic text the first block value error suffix or the synthetic text the synthetic message ends with the synthetic text the second block value error suffix:
			write the operation code op-callfi to A;
			write the addressing mode constant addressing mode to parameter zero of A;
			write the address of the custom block value error handler to parameter zero of A;
			write the addressing mode constant addressing mode to parameter one of A;
			write the (the message converted to a number) to parameter one of A;
			write the addressing mode zero-or-discard addressing mode to parameter two of A;
		delete the synthetic text the synthetic message.

A GRIF Instrumentation rule (this is the replace error-printing statements with error handler invocations in block value routines rule):
	if the block value routine hash table contains the key the address of the chunk being instrumented:
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			replace the instruction vertex with a block value error handler invocation if it is printing a block value error.

Chapter "Shielding the Custom Block Value Error Handler" - unindexed

A GRIF shielding rule (this is the shield the custom block value error handler rule):
	shield the address of the custom block value error handler against instrumentation.

Book "Indexed Text Errors" - unindexed

Responding to a indexed text error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Indexed Text Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a indexed text error (this is saying the call stack for a indexed text error):
	say "[the call stack for a verbose runtime problem message]".

Responding to a indexed text error is saying the call stack for a indexed text error.

Chapter "Responding to a Indexed Text Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a indexed text error (this is forcing a breakpoint for a indexed text error):
	force a breakpoint named "Indexed text error".

Responding to a indexed text error is forcing a breakpoint for a indexed text error.

Chapter "The Custom Indexed Text Error Handler" - unindexed

Include (-
	[ vrpm_IndexedTextHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a indexed text error +),1))();
	];
-).

Chapter "Indexed Text Error Handler Addresses" - unindexed

To decide what number is the address of the custom indexed text error handler: (- vrpm_IndexedTextHandler -).

Chapter "Indexed Text Routines of Interest" - unindexed

The indexed text routine hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for indexed text routine identification rule):
	now the indexed text routine hash table is a new hash table with the indexed text routine hash table size buckets;
	insert the key the address of I6_IT_BlobAccess into the indexed text routine hash table;
	insert the key the address of I6_IT_GetBlob into the indexed text routine hash table;
	insert the key the address of I6_IT_ReplaceBlob into the indexed text routine hash table;
	insert the key the address of I6_IT_ReplaceText into the indexed text routine hash table;
	insert the key the address of I6_IT_CharacterLength into the indexed text routine hash table;
	insert the key the address of I6_IT_GetCharacter into the indexed text routine hash table;
	insert the key the address of I6_IT_CharactersOfCase into the indexed text routine hash table;
	insert the key the address of I6_IT_CharactersToCase into the indexed text routine hash table;
	insert the key the address of I6_IT_Concatenate into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_SetTrace into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_Node into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_NodeAddress into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_DebugMatchVars into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_CreateMatchVars into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_EmptyMatchVars into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_GetMatchVar into the indexed text routine hash table;
	insert the key the address of I6_IT_MV_End into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_Clear_Markers into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_DebugTree into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_DebugSubtree into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_DebugNode into the indexed text routine hash table;
	insert the key the address of I6_IT_CHR_CompileTree into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_CompileTree into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_RangeSyntaxCorrect into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_ExpandChoices into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_CheckTree into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_Width into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_PrintNoRewinds into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_Parse into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_ParseAtPosition into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_SeekBacktrack into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_FailSubexpressions into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_EraseConstraints into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_MatchSubstring into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_Range into the indexed text routine hash table;
	insert the key the address of I6_IT_Replace_RE into the indexed text routine hash table;
	insert the key the address of I6_IT_RE_Concatenate into the indexed text routine hash table.

Chapter "Indexed Text Routine Instrumentation" - unindexed

Section "The Indexed Text Error Suffixes" - unindexed

To decide what text is the first nonsynthetic indexed text error suffix: (- "***" -).
To decide what text is the second nonsynthetic indexed text error suffix: (- "***^" -).
To decide what text is the third nonsynthetic indexed text error suffix: (- "OVERFLOW^" -).

The first indexed text error suffix is a text that varies.
The second indexed text error suffix is a text that varies.
The third indexed text error suffix is a text that varies.
A GRIF setup rule (this is the allocate the synthetic text for the indexed text error suffixes rule):
	now the first indexed text error suffix is a new synthetic text copied from the first nonsynthetic indexed text error suffix;
	now the second indexed text error suffix is a new synthetic text copied from the second nonsynthetic indexed text error suffix;
	now the third indexed text error suffix is a new synthetic text copied from the third nonsynthetic indexed text error suffix.

Section "Indexed Text Routine Instrumentation Proper" - unindexed

[ !From @streamstr <parameter-zero>; ]
[ @callfi vrpm_IndexedTextHandler <moved-from-parameter-zero> 0; ]
To replace (A - an instruction vertex) with an indexed text error handler invocation if it is printing an indexed text error:
	if the addressing mode of parameter zero of A is the constant addressing mode:
		let the message be parameter zero of A converted to some text;
		let the synthetic message be a new synthetic text copied from the message;
		if the synthetic text the synthetic message ends with the synthetic text the first indexed text error suffix or the synthetic text the synthetic message ends with the synthetic text the second indexed text error suffix or the synthetic text the synthetic message ends with the synthetic text the third indexed text error suffix:
			write the operation code op-callfi to A;
			write the addressing mode constant addressing mode to parameter zero of A;
			write the address of the custom indexed text error handler to parameter zero of A;
			write the addressing mode constant addressing mode to parameter one of A;
			write the (the message converted to a number) to parameter one of A;
			write the addressing mode zero-or-discard addressing mode to parameter two of A;
		delete the synthetic text the synthetic message.

A GRIF Instrumentation rule (this is the replace error-printing statements with error handler invocations in indexed text routines rule):
	if the indexed text routine hash table contains the key the address of the chunk being instrumented:
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			replace the instruction vertex with an indexed text error handler invocation if it is printing an indexed text error.

Chapter "Shielding the Custom Indexed Text Error Handler" - unindexed

A GRIF shielding rule (this is the shield the custom indexed text error handler rule):
	shield the address of the custom indexed text error handler against instrumentation.

Book "Relation Errors" - unindexed

Responding to a relation error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Relation Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a relation error (this is saying the call stack for a relation error):
	say "[the call stack for a verbose runtime problem message]".

Responding to a relation error is saying the call stack for a relation error.

Chapter "Responding to a Relation Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a relation error (this is forcing a breakpoint for a relation error):
	force a breakpoint named "Relation error".

Responding to a relation error is forcing a breakpoint for a relation error.

Chapter "The Custom Relation Error Handler" - unindexed

Include (-
	[ vrpm_RelationHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a relation error +),1))();
	];
-).

Chapter "Relation Error Handler Addresses" - unindexed

To decide what number is the address of the custom relation error handler: (- vrpm_RelationHandler -).

Chapter "Relation Routines of Interest" - unindexed

The relation routine hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for relation routine identification rule):
	now the relation routine hash table is a new hash table with the relation routine hash table size buckets;
	insert the key the address of I6_RelationTest into the relation routine hash table;
	insert the key the address of I6_EmptyRelationHandler into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Support into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Create into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Destroy into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Copy into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Compare into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Distinguish into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Say into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Name into the relation routine hash table;
	insert the key the address of I6_ChooseRelationHandler into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_SetValency into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_GetValency into the relation routine hash table;
	insert the key the address of I6_DoubleHashSetRelationHandler into the relation routine hash table;
	insert the key the address of I6_DoubleHashSetLookUp into the relation routine hash table;
	insert the key the address of I6_DoubleHashSetCheckResize into the relation routine hash table;
	insert the key the address of I6_DoubleHashSetEntryMatches into the relation routine hash table;
	insert the key the address of I6_HashListRelationHandler into the relation routine hash table;
	insert the key the address of I6_HashTableRelationHandler into the relation routine hash table;
	insert the key the address of I6_ReversedHashTableRelationHandler into the relation routine hash table;
	insert the key the address of I6_SymDoubleHashSetRelationHandler into the relation routine hash table;
	insert the key the address of I6_SymHashListRelationHandler into the relation routine hash table;
	insert the key the address of I6_Sym2in1HashTableRelationHandler into the relation routine hash table;
	insert the key the address of I6_HashCoreRelationHandler into the relation routine hash table;
	insert the key the address of I6_HashCoreLookUp into the relation routine hash table;
	insert the key the address of I6_HashCoreCheckResize into the relation routine hash table;
	insert the key the address of I6_HashCoreEntryMatches into the relation routine hash table;
	insert the key the address of I6_EquivHashTableRelationHandler into the relation routine hash table;
	insert the key the address of I6_TwoInOneHashTableRelationHandler into the relation routine hash table;
	insert the key the address of I6_TwoInOneDelete into the relation routine hash table;
	insert the key the address of I6_TwoInOneLookUp into the relation routine hash table;
	insert the key the address of I6_TwoInOneCheckResize into the relation routine hash table;
	insert the key the address of I6_TwoInOneEntryMatches into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Support into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Say into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Name into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_Empty into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_EquivalenceAdjective into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_SymmetricAdjective into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_OToOAdjective into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_OToVAdjective into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_VToOAdjective into the relation routine hash table;
	insert the key the address of I6_RELATION_TY_VToVAdjective into the relation routine hash table;
	insert the key the address of I6_Relation_Now1to1 into the relation routine hash table;
	insert the key the address of I6_Relation_NowN1toV into the relation routine hash table;
	insert the key the address of I6_Relation_Now1to1V into the relation routine hash table;
	insert the key the address of I6_Relation_NowN1toVV into the relation routine hash table;
	insert the key the address of I6_Relation_NowS1to1 into the relation routine hash table;
	insert the key the address of I6_Relation_NowSN1to1 into the relation routine hash table;
	insert the key the address of I6_Relation_NowS1to1V into the relation routine hash table;
	insert the key the address of I6_Relation_NowSN1to1V into the relation routine hash table;
	insert the key the address of I6_Relation_NowVtoV into the relation routine hash table;
	insert the key the address of I6_Relation_NowNVtoV into the relation routine hash table;
	insert the key the address of I6_Relation_TestVtoV into the relation routine hash table;
	insert the key the address of I6_Relation_NowEquiv into the relation routine hash table;
	insert the key the address of I6_Relation_NowNEquiv into the relation routine hash table;
	insert the key the address of I6_Relation_NowEquivV into the relation routine hash table;
	insert the key the address of I6_Relation_NowNEquivV into the relation routine hash table;
	insert the key the address of I6_Relation_ShowVtoV into the relation routine hash table;
	insert the key the address of I6_Relation_ShowOtoO into the relation routine hash table;
	insert the key the address of I6_Relation_RShowOtoO into the relation routine hash table;
	insert the key the address of I6_RSE_Flip into the relation routine hash table;
	insert the key the address of I6_RSE_Set into the relation routine hash table;
	insert the key the address of I6_Relation_ShowEquiv into the relation routine hash table;
	insert the key the address of I6_SignalMapChange into the relation routine hash table;
	insert the key the address of I6_MapRouteTo into the relation routine hash table;
	insert the key the address of I6_FastRouteTo into the relation routine hash table;
	insert the key the address of I6_FastCountRouteTo into the relation routine hash table;
	insert the key the address of I6_ComputeFWMatrix into the relation routine hash table;
	insert the key the address of I6_SlowRouteTo into the relation routine hash table;
	insert the key the address of I6_SlowCountRouteTo into the relation routine hash table;
	insert the key the address of I6_RelationRouteTo into the relation routine hash table;
	insert the key the address of I6_RelFollowVector into the relation routine hash table;
	insert the key the address of I6_OtoVRelRouteTo into the relation routine hash table;
	insert the key the address of I6_VtoORelRouteTo into the relation routine hash table;
	insert the key the address of I6_VtoVRelRouteTo into the relation routine hash table;
	insert the key the address of I6_FastVtoVRelRouteTo into the relation routine hash table;
	insert the key the address of I6_IterateRelations into the relation routine hash table.

Chapter "Relation Routine Instrumentation" - unindexed

Section "The Relation Error Suffix" - unindexed

To decide what text is the first nonsynthetic relation error suffix: (- "***" -).
To decide what text is the second nonsynthetic relation error suffix: (- "***^" -).

The first relation error suffix is a text that varies.
The second relation error suffix is a text that varies.
A GRIF setup rule (this is the allocate the synthetic text for the relation error suffix rule):
	now the first relation error suffix is a new synthetic text copied from the first nonsynthetic relation error suffix;
	now the second relation error suffix is a new synthetic text copied from the second nonsynthetic relation error suffix.

Section "Relation Routine Instrumentation Proper" - unindexed

[ !From @streamstr <parameter-zero>; ]
[ @callfi vrpm_RelationHandler <moved-from-parameter-zero> 0; ]
To replace (A - an instruction vertex) with a relation error handler invocation if it is printing a relation error:
	if the addressing mode of parameter zero of A is the constant addressing mode:
		let the message be parameter zero of A converted to some text;
		let the synthetic message be a new synthetic text copied from the message;
		if the synthetic text the synthetic message ends with the synthetic text the first relation error suffix or the synthetic text the synthetic message ends with the synthetic text the second relation error suffix:
			write the operation code op-callfi to A;
			write the addressing mode constant addressing mode to parameter zero of A;
			write the address of the custom relation error handler to parameter zero of A;
			write the addressing mode constant addressing mode to parameter one of A;
			write the (the message converted to a number) to parameter one of A;
			write the addressing mode zero-or-discard addressing mode to parameter two of A;
		delete the synthetic text the synthetic message.

A GRIF Instrumentation rule (this is the replace error-printing statements with error handler invocations in relation routines rule):
	if the relation routine hash table contains the key the address of the chunk being instrumented:
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			replace the instruction vertex with a relation error handler invocation if it is printing a relation error.

Chapter "Shielding the Custom Relation Error Handler" - unindexed

A GRIF shielding rule (this is the shield the custom relation error handler rule):
	shield the address of the custom relation error handler against instrumentation.

Book "Memory Stack Errors" - unindexed

Responding to a memory stack error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Memory Stack Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a memory stack error (this is saying the call stack for a memory stack error):
	say "[the call stack for a verbose runtime problem message]".

Responding to a memory stack error is saying the call stack for a memory stack error.

Chapter "Responding to a Memory Stack Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a memory stack error (this is forcing a breakpoint for a memory stack error):
	force a breakpoint named "Memory stack error".

Responding to a memory stack error is forcing a breakpoint for a memory stack error.

Chapter "The Custom Memory Stack Error Handler" - unindexed

Include (-
	[ vrpm_MemoryStackHandler;
		print "^^";
		(llo_getField((+ responding to a memory stack error +),1))();
	];
-).

Chapter "Memory Stack Error Handler Addresses" - unindexed

To decide what number is the address of the custom memory stack error handler: (- vrpm_MemoryStackHandler -).

Chapter "Memory Stack Routines of Interest" - unindexed

The memory stack routine hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for memory stack routine identification rule):
	now the memory stack routine hash table is a new hash table with the memory stack routine hash table size buckets;
	insert the key the address of I6_MstVO into the memory stack routine hash table;
	insert the key the address of I6_MstVON into the memory stack routine hash table.

Chapter "Memory Stack Routine Instrumentation" - unindexed

Section "The Memory Stack Error Suffix" - unindexed

To decide what text is the nonsynthetic memory stack error suffix: (- "^" -).

The memory stack error suffix is a text that varies.
A GRIF setup rule (this is the allocate the synthetic text for the memory stack error suffix rule):
	now the memory stack error suffix is a new synthetic text copied from the nonsynthetic memory stack error suffix.

Section "Memory Stack Routine Instrumentation Proper" - unindexed

[ !From @streamstr <parameter-zero>; ]
[ @callf vrpm_MemoryStackHandler 0; ]
To replace (A - an instruction vertex) with a memory stack error handler invocation if it is printing a memory stack error:
	if the addressing mode of parameter zero of A is the constant addressing mode:
		let the message be parameter zero of A converted to some text;
		let the synthetic message be a new synthetic text copied from the message;
		if the synthetic text the synthetic message ends with the synthetic text the memory stack error suffix:
			write the operation code op-callf to A;
			write the addressing mode constant addressing mode to parameter zero of A;
			write the address of the custom memory stack error handler to parameter zero of A;
			write the addressing mode zero-or-discard addressing mode to parameter one of A;
		delete the synthetic text the synthetic message.

A GRIF Instrumentation rule (this is the replace error-printing statements with error handler invocations in memory stack routines rule):
	if the memory stack routine hash table contains the key the address of the chunk being instrumented:
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			replace the instruction vertex with a memory stack error handler invocation if it is printing a memory stack error.

Chapter "Shielding the Custom Memory Stack Error Handler" - unindexed

A GRIF shielding rule (this is the shield the custom memory stack error handler rule):
	shield the address of the custom memory stack error handler against instrumentation.

Book "Printing Errors" - unindexed

Responding to a printing error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Printing Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a printing error (this is saying the call stack for a printing error):
	say "[the call stack for a verbose runtime problem message]".

Responding to a printing error is saying the call stack for a printing error.

Chapter "Responding to a Printing Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a printing error (this is forcing a breakpoint for a printing error):
	force a breakpoint named "Printing error".

Responding to a printing error is forcing a breakpoint for a printing error.

Chapter "The Custom Printing Error Handler" - unindexed

Include (-
	[ vrpm_PrintingErrorHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a printing error +),1))();
	];
-).

Chapter "Printing Error Handler Addresses" - unindexed

To decide what number is the address of the custom printing error handler: (- vrpm_PrintingErrorHandler -).

Chapter "Printing Routines of Interest" - unindexed

The printing routine hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for printing routine identification rule):
	now the printing routine hash table is a new hash table with the printing routine hash table size buckets;
	insert the key the address of I6_VM_PrintToBuffer into the printing routine hash table.

Chapter "Printing Routine Instrumentation" - unindexed

Section "The Printing Error Prefix" - unindexed

To decide what text is the nonsynthetic printing error prefix: (- "Error: " -).

The printing error prefix is a text that varies.
A GRIF setup rule (this is the allocate the synthetic text for the printing error prefix rule):
	now the printing error prefix is a new synthetic text copied from the nonsynthetic printing error prefix.

Section "Printing Routine Instrumentation Proper" - unindexed

[ !From @streamstr <parameter-zero>; ]
[ @callfi vrpm_PrintingErrorHandler <moved-from-parameter-zero> 0; ]
To replace (A - an instruction vertex) with a printing error handler invocation if it is printing a printing error:
	if the addressing mode of parameter zero of A is the constant addressing mode:
		let the message be parameter zero of A converted to some text;
		let the synthetic message be a new synthetic text copied from the message;
		if the synthetic text the synthetic message begins with the synthetic text the printing error prefix:
			write the operation code op-callfi to A;
			write the addressing mode constant addressing mode to parameter zero of A;
			write the address of the custom printing error handler to parameter zero of A;
			write the addressing mode constant addressing mode to parameter one of A;
			write the (the message converted to a number) to parameter one of A;
			write the addressing mode zero-or-discard addressing mode to parameter two of A;
		delete the synthetic text the synthetic message.

A GRIF Instrumentation rule (this is the replace error-printing statements with error handler invocations in printing routines rule):
	if the printing routine hash table contains the key the address of the chunk being instrumented:
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			replace the instruction vertex with a printing error handler invocation if it is printing a printing error.

Chapter "Shielding the Custom Printing Error Handler" - unindexed

A GRIF shielding rule (this is the shield the custom printing error handler rule):
	shield the address of the custom printing error handler against instrumentation.

Book "Miscellaneous Errors" - unindexed

Responding to a miscellaneous error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Miscellaneous Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a miscellaneous error (this is saying the call stack for a miscellaneous error):
	say "[the call stack for a verbose runtime problem message]".

Responding to a miscellaneous error is saying the call stack for a miscellaneous error.

Chapter "Responding to a Miscellaneous Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a miscellaneous error (this is forcing a breakpoint for a miscellaneous error):
	force a breakpoint named "Miscellaneous error".

Responding to a miscellaneous error is forcing a breakpoint for a miscellaneous error.

Chapter "The Custom Miscellaneous Error Handler" - unindexed

Include (-
	[ vrpm_MiscellaneousErrorHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a miscellaneous error +),1))();
	];
-).

Chapter "Miscellaneous Error Handler Addresses" - unindexed

To decide what number is the address of the custom miscellaneous error handler: (- vrpm_MiscellaneousErrorHandler -).

Chapter "Miscellaneous Routines of Interest" - unindexed

The miscellaneous routine hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for miscellaneous routine identification rule):
	now the miscellaneous routine hash table is a new hash table with the miscellaneous routine hash table size buckets;
	insert the key the address of I6_WriteListR into the miscellaneous routine hash table;
	insert the key the address of I6_CheckTableEntryIsBlank into the miscellaneous routine hash table;
	insert the key the address of I6_TestSinglePastState into the miscellaneous routine hash table.

Chapter "Miscellaneous Routine Instrumentation" - unindexed

Section "The Miscellaneous Error Suffixes" - unindexed

To decide what text is the first nonsynthetic miscellaneous error suffix: (- "***" -).
To decide what text is the second nonsynthetic miscellaneous error suffix: (- "***^" -).
To decide what text is the third nonsynthetic miscellaneous error suffix: (- "***^^" -).

The first miscellaneous error suffix is a text that varies.
The second miscellaneous error suffix is a text that varies.
The third miscellaneous error suffix is a text that varies.
A GRIF setup rule (this is the allocate the synthetic text for the miscellaneous error suffixes rule):
	now the first miscellaneous error suffix is a new synthetic text copied from the first nonsynthetic miscellaneous error suffix;
	now the second miscellaneous error suffix is a new synthetic text copied from the second nonsynthetic miscellaneous error suffix;
	now the third miscellaneous error suffix is a new synthetic text copied from the third nonsynthetic miscellaneous error suffix.

Section "Miscellaneous Routine Instrumentation Proper" - unindexed

[ !From @streamstr <parameter-zero>; ]
[ @callfi vrpm_MiscellaneousErrorHandler <moved-from-parameter-zero> 0; ]
To replace (A - an instruction vertex) with a miscellaneous error handler invocation if it is printing a miscellaneous error:
	if the addressing mode of parameter zero of A is the constant addressing mode:
		let the message be parameter zero of A converted to some text;
		let the synthetic message be a new synthetic text copied from the message;
		if the synthetic text the synthetic message ends with the synthetic text the first miscellaneous error suffix or the synthetic text the synthetic message ends with the synthetic text the second miscellaneous error suffix or the synthetic text the synthetic message ends with the synthetic text the third miscellaneous error suffix:
			write the operation code op-callfi to A;
			write the addressing mode constant addressing mode to parameter zero of A;
			write the address of the custom miscellaneous error handler to parameter zero of A;
			write the addressing mode constant addressing mode to parameter one of A;
			write the (the message converted to a number) to parameter one of A;
			write the addressing mode zero-or-discard addressing mode to parameter two of A;
		delete the synthetic text the synthetic message.

A GRIF Instrumentation rule (this is the replace error-miscellaneous statements with error handler invocations in miscellaneous routines rule):
	if the miscellaneous routine hash table contains the key the address of the chunk being instrumented:
		repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
			replace the instruction vertex with a miscellaneous error handler invocation if it is printing a miscellaneous error.

Chapter "Shielding the Custom Miscellaneous Error Handler" - unindexed

A GRIF shielding rule (this is the shield the custom miscellaneous error handler rule):
	shield the address of the custom miscellaneous error handler against instrumentation.

Book "Nonfunction Calls"

Chapter "Responding to a Nonfunction Call" - unindexed (for use without Interactive Debugger by Brady Garvin)

This is the print the call stack on nonfunctions rule:
	say "[low-level runtime failure in][the story title][with explanation]The story called a nonfunction as if it were a function.[line break][the call stack for a verbose runtime problem message][terminating the story]".

The nonfunction substitution rule is the print the call stack on nonfunctions rule.

A GRIF shielding rule (this is the shield the print the call stack on nonfunctions rule rule):
	shield the print the call stack on nonfunctions rule against instrumentation.

Chapter "Responding to a Nonfunction Call with a Breakpoint" - unindexed (for use with Interactive Debugger by Brady Garvin)

To fail with a nonfunction call (this is failing with a nonfunction call):
	say "[low-level runtime failure in][the story title][with explanation]The story called a nonfunction as if it were a function.[terminating the story]".

This is the break on nonfunctions rule:
	force a breakpoint named "Call to nonfunction";
	fail with a nonfunction call.

The nonfunction substitution rule is the break on nonfunctions rule.

A GRIF shielding rule (this is the shield the print the call stack on nonfunctions rule rule):
	shield failing with a nonfunction call against instrumentation.

Verbose Diagnostics Lite ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Verbose Diagnostics Lite is a less powerful version of Verbose Diagnostics that
gets by without debug information---if we include it, runtime problems will be
reported with a call stack, as in

	*** Run-time problem P1: Tried to move the chorus (a backdrop) to the stage, which is not a region.
	within instead of singing,
	within the instead stage rule,
	within the generate action rule,
	within the main story routine.

but these call stacks will not always be able to use human-friendly names.

Details are in the following chapters.

Chapter: Usage

When Verbose Diagnostics Lite is included, all of the known problem
messages for runtime trouble, both at the I7 and the I6 level, are accompanied
by a call stack.  These call stacks are printed using phrases from the extension
Call Stack Tracking (which see), and we can customize them by changing the truth
states from Call Stack Tracking in a GRIF setup rule.  For example,

	*: A GRIF setup rule:
		now the call stack simplification flag is false.

The available flags are:

	Table of Call Stack Flags
	Flag	Default Value	Meaning
	the original arguments flag	false	whether functions' original arguments are shown
	the temporary named values flag	false	whether functions' temporary named values are shown
	the catch tokens flag	false	whether catch tokens generated by functions are shown
	the call stack simplification flag	true	whether internal routines are hidden
	the call frame numbering flag	false	whether call frames are numbered
	the call stack addresses flag	false	whether function addresses are shown

If the extension Interactive Debugger is also included, Verbose Diagnostics Lite
forgoes the call stack and instead forces a breakpoint.  We can then use all of
the debugger's facilities to diagnose the problem, including the debug command
"examine the call stack".

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Verbose Diagnostics Lite is subject to the caveats for the Glulx Runtime
Instrumentation Framework; see the requirements chapter in its documentation for
the technical details.

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

Verbose Diagnostics Lite was prepared as part of the Glulx Runtime
Instrumentation Project (https://sourceforge.net/projects/i7grip/).  For this
first edition of the project, special thanks go to these people, in
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

For Verbose Diagnostics Lite in particular, I am grateful to
Esteban Montecristo for contributing the original code for block value errors.

Version 1 of Verbose Diagnostics Lite (for Glulx only) by Brady Garvin begins here.

"Additional detail in the messages for runtime problems, programming errors, block value errors, and so on, to the extent that such detail can be given without loading debug information files (compare Verbose Diagnostics)."

"with the support for block value errors courtesy of Esteban Montecristo"

Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.
Include Call Stack Tracking by Brady Garvin.
Include Glk Interception by Brady Garvin.
Include Output Interception by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

Chapter "Use Options" - unindexed

Use a block value routine hash table size of at least 311 translates as (- Constant VDL_BLOCK_ROUTINE_HASH_SIZE={N}; -).
Use a indexed text routine hash table size of at least 311 translates as (- Constant VDL_IT_ROUTINE_HASH_SIZE={N}; -).
Use a relation routine hash table size of at least 311 translates as (- Constant VDL_REL_ROUTINE_HASH_SIZE={N}; -).
Use a memory stack routine hash table size of at least 311 translates as (- Constant VDL_MST_ROUTINE_HASH_SIZE={N}; -).
Use a printing routine hash table size of at least 311 translates as (- Constant VDL_PRINT_ROUTINE_HASH_SIZE={N}; -).
Use a miscellaneous routine hash table size of at least 311 translates as (- Constant VDL_MISC_ROUTINE_HASH_SIZE={N}; -).

Use a extra Glk stream state hash table size of at least 311 translates as (- Constant VDL_EXTRA_STREAM_STATE_HASH_SIZE={N}; -).
Use a extra Glk file reference state hash table size of at least 311 translates as (- Constant VDL_EXTRA_FREF_STATE_HASH_SIZE={N}; -).

To decide what number is the block value routine hash table size: (- VDL_BLOCK_ROUTINE_HASH_SIZE -).
To decide what number is the indexed text routine hash table size: (- VDL_IT_ROUTINE_HASH_SIZE -).
To decide what number is the relation routine hash table size: (- VDL_REL_ROUTINE_HASH_SIZE -).
To decide what number is the memory stack routine hash table size: (- VDL_MST_ROUTINE_HASH_SIZE -).
To decide what number is the printing routine hash table size: (- VDL_PRINT_ROUTINE_HASH_SIZE -).
To decide what number is the miscellaneous routine hash table size: (- VDL_MISC_ROUTINE_HASH_SIZE -).

To decide what number is the extra Glk stream state hash table size: (- VDL_EXTRA_STREAM_STATE_HASH_SIZE -).
To decide what number is the extra Glk file reference state hash table size: (- VDL_EXTRA_FREF_STATE_HASH_SIZE -).

Book "Runtime Problems" - unindexed

Responding to a runtime problem is a phrase nothing -> nothing that varies.

Chapter "Responding to a Runtime Problem" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a runtime problem (this is saying the call stack for a runtime problem):
	say "[the call stack]".

Responding to a runtime problem is saying the call stack for a runtime problem.

Chapter "Responding to a Runtime Problem with a Breakpoint" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a runtime problem (this is forcing a breakpoint for a runtime problem):
	force a breakpoint named "Runtime problem".

Responding to a runtime problem is forcing a breakpoint for a runtime problem.

Chapter "The Custom Runtime Problem Handler" - unindexed

Include (-
	[ vdl_RTPHandler n par1 par2 par3 In i c;
		enable_rte=true;
		RunTimeProblem(n,par1,par2,par3,In,i,c);
		(llo_getField((+ responding to a runtime problem +),1))();
	];
-).

Chapter "Runtime Problem Handler Addresses" - unindexed

To decide what rule is the default runtime problem handler: (- RunTimeProblem -).
To decide what rule is the custom runtime problem handler: (- vdl_RTPHandler -).

Chapter "Shielding the Custom Runtime Problem Handler" - unindexed

A GRIF shielding rule (this is the substitute the custom runtime problem handler rule):
	substitute the uninstrumented custom runtime problem handler for the instrumented default runtime problem handler.

Book "Programming Errors" - unindexed

Responding to a programming error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Programming Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a programming error (this is saying the call stack for a programming error):
	say "[line break][the call stack]".

Responding to a programming error is saying the call stack for a programming error.

Chapter "Responding to a Programming Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a programming error (this is forcing a breakpoint for a programming error):
	force a breakpoint named "Programming error".

Responding to a programming error is forcing a breakpoint for a programming error.

Chapter "The Custom Programming Error Handler" - unindexed

Include (-
	[ vdl_PEHandler crime obj id size p q;
		RT__Err(crime,obj,id,size,p,q);
		(llo_getField((+ responding to a programming error +),1))();
	];
-).

Chapter "Programming Error Handler Addresses" - unindexed

To decide what rule is the default programming error handler: (- RT__Err -).
To decide what rule is the custom programming error handler: (- vdl_PEHandler -).

Chapter "Shielding the Custom Programming Error Handler" - unindexed

A GRIF shielding rule (this is the substitute the custom programming error handler rule):
	substitute the uninstrumented custom programming error handler for the instrumented default programming error handler.

Book "Block Value Errors" - unindexed

[This is essentially what Esteban e-mailed in January of 2010, but tweaked to be more robust against changes to the Blk* implementations.]

Responding to a block value error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Block Value Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a block value error (this is saying the call stack for a block value error):
	say "[the call stack]".

Responding to a block value error is saying the call stack for a block value error.

Chapter "Responding to a Block Value Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a block value error (this is forcing a breakpoint for a block value error):
	force a breakpoint named "Block value error".

Responding to a block value error is forcing a breakpoint for a block value error.

Chapter "The Custom Block Value Error Handler" - unindexed

Include (-
	[ vdl_BVEHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a block value error +),1))();
	];
-).

Chapter "Block Value Error Handler Addresses" - unindexed

To decide what number is the address of the custom block value error handler: (- vdl_BVEHandler -).

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
[ @callfi vdl_BVEHandler <moved-from-parameter-zero> 0; ]
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
	say "[the call stack]".

Responding to a indexed text error is saying the call stack for a indexed text error.

Chapter "Responding to a Indexed Text Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a indexed text error (this is forcing a breakpoint for a indexed text error):
	force a breakpoint named "Indexed text error".

Responding to a indexed text error is forcing a breakpoint for a indexed text error.

Chapter "The Custom Indexed Text Error Handler" - unindexed

Include (-
	[ vdl_IndexedTextHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a indexed text error +),1))();
	];
-).

Chapter "Indexed Text Error Handler Addresses" - unindexed

To decide what number is the address of the custom indexed text error handler: (- vdl_IndexedTextHandler -).

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
[ @callfi vdl_IndexedTextHandler <moved-from-parameter-zero> 0; ]
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
	say "[the call stack]".

Responding to a relation error is saying the call stack for a relation error.

Chapter "Responding to a Relation Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a relation error (this is forcing a breakpoint for a relation error):
	force a breakpoint named "Relation error".

Responding to a relation error is forcing a breakpoint for a relation error.

Chapter "The Custom Relation Error Handler" - unindexed

Include (-
	[ vdl_RelationHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a relation error +),1))();
	];
-).

Chapter "Relation Error Handler Addresses" - unindexed

To decide what number is the address of the custom relation error handler: (- vdl_RelationHandler -).

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
[ @callfi vdl_RelationHandler <moved-from-parameter-zero> 0; ]
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
	say "[the call stack]".

Responding to a memory stack error is saying the call stack for a memory stack error.

Chapter "Responding to a Memory Stack Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a memory stack error (this is forcing a breakpoint for a memory stack error):
	force a breakpoint named "Memory stack error".

Responding to a memory stack error is forcing a breakpoint for a memory stack error.

Chapter "The Custom Memory Stack Error Handler" - unindexed

Include (-
	[ vdl_MemoryStackHandler;
		print "^^";
		(llo_getField((+ responding to a memory stack error +),1))();
	];
-).

Chapter "Memory Stack Error Handler Addresses" - unindexed

To decide what number is the address of the custom memory stack error handler: (- vdl_MemoryStackHandler -).

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
[ @callf vdl_MemoryStackHandler 0; ]
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
	say "[the call stack]".

Responding to a printing error is saying the call stack for a printing error.

Chapter "Responding to a Printing Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a printing error (this is forcing a breakpoint for a printing error):
	force a breakpoint named "Printing error".

Responding to a printing error is forcing a breakpoint for a printing error.

Chapter "The Custom Printing Error Handler" - unindexed

Include (-
	[ vdl_PrintingErrorHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a printing error +),1))();
	];
-).

Chapter "Printing Error Handler Addresses" - unindexed

To decide what number is the address of the custom printing error handler: (- vdl_PrintingErrorHandler -).

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
[ @callfi vdl_PrintingErrorHandler <moved-from-parameter-zero> 0; ]
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

Book "Glk Errors" - unindexed

Responding to a Glk error is a phrase nothing -> nothing that varies.
The Glk error state is some text that varies.  The Glk error state is "".
The Glk error function selector is a number that varies.

To signal the Glk error (T - some text):
	now the Glk error state is T;
	apply responding to a Glk error.

Chapter "Responding to a Glk Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a Glk error (this is saying the call stack for a Glk error):
	say "[the Glk error state][line break](within the interpreter, under [the Glk function name for the selector the Glk error function selector],)[line break][the call stack]".

Responding to a Glk error is saying the call stack for a Glk error.

Chapter "Responding to a Glk Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a Glk error (this is forcing a breakpoint for a Glk error):
	force a breakpoint named "Glk error: [the Glk error state]".

Responding to a Glk error is forcing a breakpoint for a Glk error.

Chapter "Known Glk Function Names" - unindexed

Include (-
	[ vdl_glkName selector;
		switch(selector){
			4:
				print "glk_gestalt";
			5:
				print "glk_gestalt_ext";
			32:
				print "glk_window_iterate";
			33:
				print "glk_window_get_rock";
			34:
				print "glk_window_get_root";
			35:
				print "glk_window_open";
			36:
				print "glk_window_close";
			37:
				print "glk_window_get_size";
			38:
				print "glk_window_set_arrangement";
			39:
				print "glk_window_get_arrangement";
			40:
				print "glk_window_get_type";
			41:
				print "glk_window_get_parent";
			42:
				print "glk_window_clear";
			43:
				print "glk_window_move_cursor";
			44:
				print "glk_window_get_stream";
			45:
				print "glk_window_set_echo_stream";
			46:
				print "glk_window_get_echo_stream";
			47:
				print "glk_set_window";
			48:
				print "glk_window_get_sibling";
			64:
				print "glk_stream_iterate";
			65:
				print "glk_stream_get_rock";
			66:
				print "glk_stream_open_file";
			67:
				print "glk_stream_open_memory";
			68:
				print "glk_stream_close";
			69:
				print "glk_stream_set_position";
			70:
				print "glk_stream_get_position";
			71:
				print "glk_stream_set_current";
			72:
				print "glk_stream_get_current";
			96:
				print "glk_fileref_create_temp";
			97:
				print "glk_fileref_create_by_name";
			98:
				print "glk_fileref_create_by_prompt";
			99:
				print "glk_fileref_destroy";
			100:
				print "glk_fileref_iterate";
			101:
				print "glk_fileref_get_rock";
			102:
				print "glk_fileref_delete_file";
			103:
				print "glk_fileref_does_file_exist";
			104:
				print "glk_fileref_create_from_fileref";
			128:
				print "glk_put_char";
			129:
				print "glk_put_char_stream";
			130:
				print "glk_put_string";
			131:
				print "glk_put_string_stream";
			132:
				print "glk_put_buffer";
			133:
				print "glk_put_buffer_stream";
			134:
				print "glk_set_style";
			135:
				print "glk_set_style_stream";
			144:
				print "glk_get_char_stream";
			145:
				print "glk_get_line_stream";
			146:
				print "glk_get_buffer_stream";
			160:
				print "glk_char_to_lower";
			161:
				print "glk_char_to_upper";
			176:
				print "glk_stylehint_set";
			177:
				print "glk_stylehint_clear";
			178:
				print "glk_style_distinguish";
			179:
				print "glk_style_measure";
			192:
				print "glk_select";
			193:
				print "glk_select_poll";
			208:
				print "glk_request_line_event";
			209:
				print "glk_cancel_line_event";
			210:
				print "glk_request_char_event";
			211:
				print "glk_cancel_char_event";
			212:
				print "glk_request_mouse_event";
			213:
				print "glk_cancel_mouse_event";
			214:
				print "glk_request_timer_events";
			224:
				print "glk_image_get_info";
			225:
				print "glk_image_draw";
			226:
				print "glk_image_draw_scaled";
			232:
				print "glk_window_flow_break";
			233:
				print "glk_window_erase_rect";
			234:
				print "glk_window_fill_rect";
			235:
				print "glk_window_set_background_color";
			240:
				print "glk_schannel_iterate";
			241:
				print "glk_schannel_get_rock";
			242:
				print "glk_schannel_create";
			243:
				print "glk_schannel_destroy";
			248:
				print "glk_schannel_play";
			249:
				print "glk_schannel_play_ext";
			250:
				print "glk_schannel_stop";
			251:
				print "glk_schannel_set_volume";
			252:
				print "glk_sound_load_hint";
			244:
				print "glk_schannel_create_ext";
			247:
				print "glk_schannel_play_multi";
			253:
				print "glk_schannel_set_volume_ext";
			254:
				print "glk_schannel_pause";
			255:
				print "glk_schannel_unpause";
			256:
				print "glk_set_hyperlink";
			257:
				print "glk_set_hyperlink_stream";
			258:
				print "glk_request_hyperlink_event";
			259:
				print "glk_cancel_hyperlink_event";
			288:
				print "glk_buffer_to_lower_case_uni";
			289:
				print "glk_buffer_to_upper_case_uni";
			290:
				print "glk_buffer_to_title_case_uni";
			296:
				print "glk_put_char_uni";
			297:
				print "glk_put_string_uni";
			298:
				print "glk_put_buffer_uni";
			299:
				print "glk_put_char_stream_uni";
			300:
				print "glk_put_string_stream_uni";
			301:
				print "glk_put_buffer_stream_uni";
			304:
				print "glk_get_char_stream_uni";
			305:
				print "glk_get_buffer_stream_uni";
			306:
				print "glk_get_line_stream_uni";
			312:
				print "glk_stream_open_file_uni";
			313:
				print "glk_stream_open_memory_uni";
			320:
				print "glk_request_char_event_uni";
			321:
				print "glk_request_line_event_uni";
			291:
				print "glk_buffer_canon_decompose_uni";
			292:
				print "glk_buffer_canon_normalize_uni";
			336:
				print "glk_set_echo_line_event";
			337:
				print "glk_set_terminators_line_event";
			352:
				print "glk_current_time";
			353:
				print "glk_current_simple_time";
			360:
				print "glk_time_to_date_utc";
			361:
				print "glk_time_to_date_local";
			362:
				print "glk_simple_time_to_date_utc";
			363:
				print "glk_simple_time_to_date_local";
			364:
				print "glk_date_to_time_utc";
			365:
				print "glk_date_to_time_local";
			366:
				print "glk_date_to_simple_time_utc";
			367:
				print "glk_date_to_simple_time_local";
			73:
				print "glk_stream_open_resource";
			314:
				print "glk_stream_open_resource_uni";
			default:
				print "Glk function #", selector;
				rfalse;
		}
		print " [Glk function #", selector, "]";
		rtrue;
	];
-).

To say the Glk function name for the selector (A - a number): (- print (vdl_glkName) ({A}); -).

Chapter "infglk" - unindexed

Section "infglk Patches" - unindexed

Include (-
! For older versions of infglk.h, such as the one that ships with 6G60
#ifndef winmethod_Border;
	Constant winmethod_Border = $000;
#endif;
#ifndef winmethod_NoBorder;
	Constant winmethod_NoBorder = $100;
#endif;
#ifndef winmethod_BorderMask;
	Constant winmethod_BorderMask = $100;
#endif;
-) after "Definitions.i6t".

Section "infglk Accessors" - unindexed

[Note that the following are only masks for values actually in use.  The masks in glk.h are wider, to allow the standard to expand.]

To decide what number is the current Glk direction mask: (- (winmethod_Left|winmethod_Right|winmethod_Above|winmethod_Below) -).
To decide what number is the current Glk direction minimum: (- winmethod_Left -).
To decide what number is the current Glk direction maximum: (- winmethod_Below -).

To decide what number is the current Glk division mask: (- (winmethod_Fixed|winmethod_Proportional) -).
To decide what number is the current Glk division minimum: (- winmethod_Fixed -).
To decide what number is the current Glk division maximum: (- winmethod_Proportional -).

To decide what number is the current Glk border mask: (- (winmethod_Border|winmethod_NoBorder) -).
To decide what number is the current Glk border minimum: (- winmethod_Border -).
To decide what number is the current Glk border maximum: (- winmethod_NoBorder -).

To decide what number is proportional division: (- winmethod_Proportional -).

To decide what number is the current Glk creatable window type minimum: (- wintype_Blank -).
To decide what number is the current Glk creatable window type maximum: (- wintype_Graphics -).

To decide what number is the pair window type: (- wintype_Pair -).
To decide what number is the text buffer window type: (- wintype_TextBuffer -).
To decide what number is the graphics window type: (- wintype_Graphics -).

To decide what number is fixed division: (- winmethod_Fixed -).
To decide what number is the blank window type: (- wintype_Blank -).

To decide what number is the current Glk justification minimum: (- stylehint_just_LeftFlush -).
To decide what number is the current Glk justification maximum: (- stylehint_just_RightFlush -).

To decide what number is the write operation: (- filemode_Write -).
To decide what number is the read operation: (- filemode_Read -).
To decide what number is the read-write operation: (- filemode_ReadWrite -).
To decide what number is the write-append operation: (- filemode_WriteAppend -).

To decide what number is the current Glk file encoding mask: (- (fileusage_TextMode|fileusage_BinaryMode) -).
To decide what number is the current Glk file encoding minimum: (- fileusage_TextMode -).
To decide what number is the current Glk file encoding maximum: (- fileusage_BinaryMode -).

To decide what number is the text encoding: (- fileusage_TextMode -).

To decide what number is the current Glk file purpose mask: (- (fileusage_Data|fileusage_SavedGame|fileusage_Transcript|fileusage_InputRecord) -).
To decide what number is the current Glk file purpose minimum: (- fileusage_Data -).
To decide what number is the current Glk file purpose maximum: (- fileusage_InputRecord -).

To decide what number is the beginning-relative seekmode: (- seekmode_Start -).
To decide what number is the here-relative seekmode: (- seekmode_Current -).
To decide what number is the end-relative seekmode: (- seekmode_End -).

To decide what number is the current image alignment minimum: (- imagealign_InlineUp -).
To decide what number is the current image alignment maximum: (- imagealign_MarginRight -).

To decide what number is the margin-left image alignment: (- imagealign_MarginLeft -).
To decide what number is the margin-right image alignment: (- imagealign_MarginRight -).

To decide what number is the character input event type: (- evtype_CharInput -).
To decide what number is the line input event type: (- evtype_LineInput -).

Chapter "Support Phrases for Glk Error Checks" - unindexed

Section "Gestalt Lookups" - unindexed

To decide whether Glk gestalt (N - a number) is supported:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 4 [glk_gestalt] to the current Glk invocation;
	write the argument count two to the current Glk invocation;
	write N to argument number zero of the current Glk invocation;
	write zero to argument number one of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the support level be the result of the Glk invocation just delegated;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on whether or not the support level is greater than zero.

Section "Class Membership Lookups" - unindexed

To decide whether (X - a number) is a member of the Glk class with iteration function selector (F - a number) for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	let the instance be zero;
	repeat until a break:
		write the function selector F [glk_*_iterate] to the current Glk invocation;
		write the argument count two to the current Glk invocation;
		write the instance to argument number zero of the current Glk invocation;
		write zero to argument number one of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after Glk error detection;
		now the instance is the result of the Glk invocation just delegated;
		if the instance is zero:
			break;
		if X is the instance:
			prepare another Glk invocation from the pending invocation;
			delete the pending invocation;
			decide yes;
		prepare a spontaneous Glk invocation;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide no.

Section "Current Stream Lookups" - unindexed

To decide what number is the current stream for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 72 [glk_stream_get_current] to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the result of the Glk invocation just delegated;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the result.

Section "Stream Membership Lookups" - unindexed

To decide whether (S - a number) is a Glk stream for Glk error detection:
	decide on whether or not S is a member of the Glk class with iteration function selector 64 [glk_stream_iterate] for Glk error detection.

To decide whether (S - a number) is a window stream for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	let the window be zero;
	repeat until a break:
		write the function selector 32 [glk_window_iterate] to the current Glk invocation;
		write the argument count two to the current Glk invocation;
		write the window to argument number zero of the current Glk invocation;
		write zero to argument number one of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after Glk error detection;
		now the window is the result of the Glk invocation just delegated;
		if the window is zero:
			break;
		prepare a spontaneous Glk invocation;
		write the function selector 44 [glk_window_get_stream] to the current Glk invocation;
		write the argument count one to the current Glk invocation;
		write the window to argument number zero of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after Glk error detection;
		let the stream be the result of the Glk invocation just delegated;
		if S is the stream:
			prepare another Glk invocation from the pending invocation;
			delete the pending invocation;
			decide yes;
		prepare a spontaneous Glk invocation;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide no.

Section "Stream Position Lookups (and Adjustments)" - unindexed

To decide what number is the current position in the stream (S - a number) for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 70 [glk_stream_get_position] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write S to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the result of the Glk invocation just delegated;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the result.

To move the stream (S - a number) to (P - a number) for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 69 [glk_stream_set_position] to the current Glk invocation;
	write the argument count three to the current Glk invocation;
	write S to argument number zero of the current Glk invocation;
	write P to argument number one of the current Glk invocation;
	write the beginning-relative seekmode to argument number two of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation.

To move the stream (S - a number) to its end for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 69 [glk_stream_set_position] to the current Glk invocation;
	write the argument count three to the current Glk invocation;
	write S to argument number zero of the current Glk invocation;
	write zero to argument number one of the current Glk invocation;
	write the end-relative seekmode to argument number two of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation.

Section "Extra Stream State Lookups (and Related Lookups)" - unindexed

To decide what number is the stream of the window (W - a number) for Glk error detection after dispatch:
	let the pending outcome be a new copy of the current Glk outcome;
	prepare a spontaneous Glk invocation;
	write the function selector 44 [glk_window_get_stream] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the result of the Glk invocation just delegated;
	overwrite the current Glk outcome with the pending outcome;
	delete the pending outcome;
	decide on the result.

To decide what linked list vertex is the extra stream state vertex of the window (W - a number) for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 44 [glk_window_get_stream] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the first match for the key the result of the Glk invocation just delegated in the extra Glk stream state hash table;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the result.

To decide what linked list vertex is the extra stream state vertex of the window (W - a number) for Glk error detection after dispatch:
	let the pending outcome be a new copy of the current Glk outcome;
	prepare a spontaneous Glk invocation;
	write the function selector 44 [glk_window_get_stream] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the first match for the key the result of the Glk invocation just delegated in the extra Glk stream state hash table;
	overwrite the current Glk outcome with the pending outcome;
	delete the pending outcome;
	decide on the result.

To decide what extra Glk stream state is the extra stream state of the window (W - a number) for Glk error detection:
	let the linked list vertex be the extra stream state vertex of the window W for Glk error detection;
	if the linked list vertex is null:
		decide on the all-flags extra Glk stream state;
	decide on the extra Glk stream state value of the linked list vertex.

Section "Window Membership Lookups" - unindexed

To decide whether (W - a number) is a Glk window for Glk error detection:
	decide on whether or not W is a member of the Glk class with iteration function selector 32 [glk_window_iterate] for Glk error detection.

Section "Root Window Lookups" - unindexed

To decide what number is the root window for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 34 [glk_window_get_root] to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the result of the Glk invocation just delegated;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the result.

Section "Window Ancestry Lookups" - unindexed

To decide whether the window (A - a number) is a proper descendant of the window (B - a number):
	let the pending invocation be a new copy of the current Glk invocation;
	let the window be A;
	repeat until a break:
		write the function selector 41 [glk_window_get_parent] to the current Glk invocation;
		write the argument count one to the current Glk invocation;
		write the window to argument number zero of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after Glk error detection;
		now the window is the result of the Glk invocation just delegated;
		if the window is zero or the window is B:
			break;
		prepare a spontaneous Glk invocation;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on whether or not the window is B.

Section "Window Type Lookups" - unindexed

To decide what number is the type of the window (W - a number) for Glk error detection:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 40 [glk_window_get_type] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the result be the result of the Glk invocation just delegated;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the result.

Section "Key Window Type Lookups" - unindexed

Include (-
	Array vdl_keyWindow --> 1;
-).
To decide what number is the key window address for Glk error detection: (- vdl_keyWindow -).
To decide what number is the key window for Glk error detection: (- llo_getInt(vdl_keyWindow) -).

To decide whether the key window of (W - a number) is not a blank window:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 39 [glk_window_get_arrangement] to the current Glk invocation;
	write the argument count four to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	write zero to argument number one of the current Glk invocation;
	write zero to argument number two of the current Glk invocation;
	write the key window address for Glk error detection to argument number three of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	let the key window be the key window for Glk error detection;
	let the result be true;
	unless the key window is zero:
		prepare a spontaneous Glk invocation;
		write the function selector 40 [glk_window_get_type] to the current Glk invocation;
		write the argument count one to the current Glk invocation;
		write the key window to argument number zero of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after Glk error detection;
		now the result is whether or not the result of the Glk invocation just delegated is not the blank window type;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the result.

Section "File Reference Membership Lookups" - unindexed

To decide whether (R - a number) is a Glk file reference for Glk error detection:
	decide on whether or not R is a member of the Glk class with iteration function selector 100 [glk_fileref_iterate] for Glk error detection.

Section "Sound Channel Membership Lookups" - unindexed

To decide whether (C - a number) is a Glk sound channel for Glk error detection:
	decide on whether or not C is a member of the Glk class with iteration function selector 240 [glk_schannel_iterate] for Glk error detection.

To decide what linked list is a new linked list of Glk sound channels for Glk error detection:
	let the sound channel list be an empty linked list;
	let the pending invocation be a new copy of the current Glk invocation;
	let the sound channel be zero;
	repeat until a break:
		write the function selector 240 [glk_schannel_iterate] to the current Glk invocation;
		write the argument count two to the current Glk invocation;
		write the sound channel to argument number zero of the current Glk invocation;
		write zero to argument number one of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after Glk error detection;
		now the sound channel is the result of the Glk invocation just delegated;
		if the sound channel is zero:
			break;
		push the key the sound channel onto the sound channel list;
		prepare a spontaneous Glk invocation;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation;
	decide on the sound channel list.

Chapter "Types of Glk Errors" - unindexed

Section "Argument Count Violations" - unindexed

To check that the current Glk invocation has (N - a number) argument/arguments:
	if the argument count of the current Glk invocation is N:
		stop;
	signal the Glk error "Wrong number of arguments passed to Glk function".

Section "Glk Gestalt Violations" - unindexed

To check that images are supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 6 [the Glk graphics gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk graphics gestalt to check)".

To check that sound is supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 8 [the first Glk sound gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the first Glk sound gestalt to check)".

To check that hyperlinks are supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 11 [the Glk hyperlinks gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk hyperlinks gestalt to check)".

To check that Unicode is supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 15 [the Glk Unicode gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk Unicode gestalt to check)".

To check that Unicode normaliziation is supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 16 [the Glk Unicode normaliziation gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk Unicode normalization gestalt to check)".

To check that echo control is supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 17 [the Glk line input echo control gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk line input echo control gestalt to check)".

To check that terminator control is supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 18 [the Glk line terminators gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk line terminators gestalt to check)".

To check that timekeeping is supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 20 [the Glk date and time gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk date and time gestalt to check)".

To check that sound extensions are supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 21 [the second Glk sound gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the second Glk sound gestalt to check)".

To check that resource streams are supported:
	if the Glk error state is not empty:
		stop;
	if Glk gestalt 22 [the Glk resource stream gestalt] is supported:
		stop;
	signal the Glk error "Function is not available (use the Glk resource stream gestalt to check)".

Section "Nonnullness Violations" - unindexed

To check that (A - a number) is not null:
	if the Glk error state is not empty:
		stop;
	if A is not zero:
		stop;
	signal the Glk error "Argument is null but must be nonnull".

To check that (A - a number) is not null for legacy purposes:
	if the Glk error state is not empty:
		stop;
	if A is not zero:
		stop;
	signal the Glk error "Argument is null but must be nonnull on older interpreters".

To check that the current stream is not null:
	if the Glk error state is not empty:
		stop;
	if the current stream for Glk error detection is not zero:
		stop;
	signal the Glk error "The current stream is null when the function requires its nonnullness".

Section "Glk Memory Bounds Violations" - unindexed

To check that (A - a number) is either null or a writeable address:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is at least the size of read-only memory:
		stop;
	signal the Glk error "Return-by-reference argument is in read-only (or partially read-only) memory".

To check that (A - a number) is either null or a valid integer address:
	if the Glk error state is not empty:
		stop;
	if A is a valid integer address:
		stop;
	signal the Glk error "Argument is a reference to an integer past the end of memory".

To check that (A - a number) is either null or a valid structure address for (N - a number) fields:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is greater than zero and A plus (four times N) is at most the size of memory:
		stop;
	signal the Glk error "Argument is a reference to a structure past the end of memory".

To check that either (A - a number) is null or its (N - a number) byte elements are at valid addresses:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is greater than zero and A plus N is at most the size of memory:
		stop;
	signal the Glk error "Argument is an array past the end of memory".

To check that either (A - a number) is null or its (N - a number) elements are at valid addresses:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is greater than zero and A plus (four times N) is at most the size of memory:
		stop;
	signal the Glk error "Argument is an array past the end of memory".

Section "Glk Enumerated and Bounded Type Violations" - unindexed

To check that either (A - a number) is null or (B - a number) is a valid Glk window opening method:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	let the direction be the bitwise and of B and the current Glk direction mask;
	if the direction is at least the current Glk direction minimum and the direction is at most the current Glk direction maximum:
		let the division be the bitwise and of B and the current Glk division mask;
		if the division is at least the current Glk division minimum and the division is at most the current Glk division maximum:
			let the border be the bitwise and of B and the current Glk border mask;
			if the border is at least the current Glk border minimum and the border is at most the current Glk border maximum:
				if the bitwise or of (the bitwise or of the direction and the division) and the border is B:
					stop;
	signal the Glk error "Argument is an invalid window opening method".

To check that either (A - a number) is null or (B - a number) is a valid Glk window size for the window opening method given by (C - a number):
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if B is at least zero:
		if the bitwise and of C and the current Glk division mask is not proportional division or B is at most 100:
			stop;
	signal the Glk error "Argument is an invalid size for the corresponding window opening method".

To check that (A - a number) is a valid Glk window type:
	if the Glk error state is not empty:
		stop;
	if A is at least the current Glk creatable window type minimum and A is at most the current Glk creatable window type maximum:
		stop;
	signal the Glk error "Argument is an invalid window type".

To check that either (A - a number) is null or (B - a number) is not a fixed window opening method or (C - a number) is not the blank window type:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if the bitwise and of B and the current Glk division mask is not fixed division:
		stop;
	if C is not the blank window type:
		stop;
	signal the Glk error "Arguments request a fixed-size split in a blank window's (nonexistent) measurement system".

To check that either (A - a number) is not a fixed window opening method or (B - a number) is null and the key window of (C - a number) is not a blank window:
	if the Glk error state is not empty:
		stop;
	if the bitwise and of B and the current Glk division mask is not fixed division:
		stop;
	if B is zero and the key window of C is not a blank window:
		stop;
	signal the Glk error "Arguments request a fixed-size split in a blank window's (nonexistent) measurement system".

To check that (A - a number) is a valid value for the style hint given by (B - a number):
	if the Glk error state is not empty:
		stop;
	if B is:
		-- 2: [justification]
			if A is less than the current Glk justification minimum or A is greater than the current Glk justification maximum:
				signal the Glk error "Argument is an invalid justification type";
		-- 4: [weight]
			if A is less than -1 or A is greater than 1:
				signal the Glk error "Argument is an invalid weight";
		-- 5: [obliqueness]
			if A is not 0 and A is not 1:
				signal the Glk error "Argument is an invalid obliqueness flag";
		-- 6: [proportionality]
			if A is not 0 and A is not 1:
				signal the Glk error "Argument is an invalid proportionality flag";
		-- 7: [text color]
			check that A is a valid RGB color;
		-- 8: [background color]
			check that A is a valid RGB color;
		-- 9: [reverse color]
			if A is not 0 and A is not 1:
				signal the Glk error "Argument is an invalid reverse color flag".

To check that (A - a number) is a valid RGB color:
	if the Glk error state is not empty:
		stop;
	if the bitwise and of A and 16777215 is A:
		stop;
	signal the Glk error "Color argument has a non-RGB component (the most significant byte should be zero)".

To check that (A - a number) is a valid Glk file mode:
	if the Glk error state is not empty:
		stop;
	if A is the write operation or A is the read operation or A is the read-write operation or A is the write-append operation:
		stop;
	signal the Glk error "Argument is an invalid file mode".

To check that (A - a number) is a valid Glk file usage:
	if the Glk error state is not empty:
		stop;
	let the file encoding be the bitwise and of A and the current Glk file encoding mask;
	if the file encoding is at least the current Glk file encoding minimum and the file encoding is at most the current Glk file encoding maximum:
		let the file purpose be the bitwise and of A and the current Glk file purpose mask;
		if the file purpose is at least the current Glk file purpose minimum and the file purpose is at most the current Glk file purpose maximum:
			if the bitwise or of the file encoding and the file purpose is A:
				stop;
	signal the Glk error "Argument is an invalid file usage".

Section "Glk Window Type Violations" - unindexed

To check that (A - a number) is a valid Glk window:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is a Glk window for Glk error detection:
		stop;
	signal the Glk error "Argument is not a valid Glk window".

Section "Glk Window Subtype Violations" - unindexed

To check that (A - a number) is a pair window:
	if the Glk error state is not empty:
		stop;
	if the type of the window A for Glk error detection is the pair window type:
		stop;
	signal the Glk error "Argument is not a non-pair window".

To check that (A - a number) is not a pair window:
	if the Glk error state is not empty:
		stop;
	if the type of the window A for Glk error detection is not the pair window type:
		stop;
	signal the Glk error "Argument is not a non-pair window".

To check that (A - a number) is a text buffer or graphics window:
	if the Glk error state is not empty:
		stop;
	let the window type be the type of the window A for Glk error detection;
	if the window type is the text buffer window type:
		stop;
	if the window type is the graphics window type:
		stop;
	signal the Glk error "Argument is not a text buffer or graphics window".

Section "Glk Window Typestate Violations" - unindexed

To check that either (A - a number) is nonnull or there are no Glk windows:
	if the Glk error state is not empty:
		stop;
	unless A is zero:
		stop;
	if the root window for Glk error detection is zero:
		stop;
	signal the Glk error "Argument is null but must refer to an existing window when one exists".

To check that (A - a number) is either null or a proper descendant of (B - a number):
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if the window A is a proper descendant of the window B:
		stop;
	signal the Glk error "Key window argument is not a proper descendant of the window being arranged".

Section "Glk Stream Type Violations" - unindexed

To check that (A - a number) is a valid Glk stream:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is a Glk stream for Glk error detection:
		stop;
	signal the Glk error "Argument is not a valid Glk stream".

Section "Glk Stream Subtype Violations" - unindexed

To check that (A - a number) is not a window stream:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	unless A is a window stream for Glk error detection:
		stop;
	signal the Glk error "Argument is not a valid Glk window stream".

To check that (A - a number) is a valid input stream:
	if the Glk error state is not empty:
		stop;
	let the stream state be the first extra Glk stream state value matching the key A in the extra Glk stream state hash table or the all-flags extra Glk stream state if there are no matches;
	if the stream state describes an input stream:
		stop;
	signal the Glk error "Argument is not a valid Glk input stream".

To check that (A - a number) is a valid output stream:
	if the Glk error state is not empty:
		stop;
	let the stream state be the first extra Glk stream state value matching the key A in the extra Glk stream state hash table or the all-flags extra Glk stream state if there are no matches;
	if the stream state describes an output stream:
		stop;
	signal the Glk error "Argument is not a valid Glk output stream".

Section "Glk File Reference Type Violations" - unindexed

To check that (A - a number) is a valid Glk file reference:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is a Glk file reference for Glk error detection:
		stop;
	signal the Glk error "Argument is not a valid Glk file reference".

Section "Glk Sound Channel Type Violations" - unindexed

To check that (A - a number) is a valid Glk sound channel:
	if the Glk error state is not empty:
		stop;
	if A is zero:
		stop;
	if A is a Glk sound channel for Glk error detection:
		stop;
	signal the Glk error "Argument is not a valid Glk sound channel".

To check that the (N - a number) elements of (A - a number) are all valid nonnull Glk sound channels:
	if the Glk error state is not empty:
		stop;
	if N is zero:
		stop;
	let the sound channel list be a new linked list of Glk sound channels for Glk error detection;
	let the address be A;
	let the limit be A plus four times N;
	while the address is less than the limit:
		unless the sound channel list contains the key the integer at address the address:
			break;
		increase the address by four;
	if the address is the limit:
		stop;
	signal the Glk error "Argument contains an invalid Glk sound channel".

Section "Glk Window/Stream Typestate Violations" - unindexed

To check that (A - a number) has no character input pending:
	if the Glk error state is not empty:
		stop;
	unless the extra stream state of the window A for Glk error detection describes character input pending:
		stop;
	signal the Glk error "Argument is a window with character input pending".

To check that (A - a number) has no line input pending:
	if the Glk error state is not empty:
		stop;
	unless the extra stream state of the window A for Glk error detection describes line input pending:
		stop;
	signal the Glk error "Argument is a window with line input pending".

[Character input does not block output.]

To check that the stream given by (A - a number) is not blocked by line input:
	if the Glk error state is not empty:
		stop;
	let the stream state be the first extra Glk stream state value matching the key A in the extra Glk stream state hash table or the all-flags extra Glk stream state if there are no matches;
	unless the stream state describes line input pending:
		stop;
	signal the Glk error "The current stream is the output stream of a window with line input pending".

Section "Glk Miscellaneous Violations" - unindexed

To check that either the stream given by (A - a number) is a window stream or (B - a number) is a valid position under the seek mode given by (C - a number):
	if the Glk error state is not empty:
		stop;
	if A is a window stream for Glk error detection:
		stop;
	let the current position be the current position in the stream A for Glk error detection;
	move the stream A to its end for Glk error detection;
	let the end position be the current position in the stream A for Glk error detection;
	move the stream A to the current position for Glk error detection;
	let the target position be B;
	if C is the beginning-relative seekmode:
		do nothing;
	otherwise if C is the here-relative seekmode:
		increase the target position by the current position;
	otherwise if C is the end-relative seekmode:
		increase the target position by the end position;
	if the target position is at least zero and the target position is at most the end position:
		stop;
	signal the Glk error "Arguments give a position and seekmode combination that is invalid for the stream".

To check that either (A - a number) is a graphics window or it is a window where (B - a number) is a possible image alignment and (C - a number) is zero:
	if the Glk error state is not empty:
		stop;
	let the window type be the type of the window A for Glk error detection;
	if the window type is the graphics window type:
		stop;
	if B is at least the current image alignment minimum and B is at most the current image alignment maximum and C is zero:
		if B is the margin-left image alignment or B is the margin-right image alignment:
			unless the extra stream state of the window A for Glk error detection describes the possibility of a margin-aligned image:
				signal the Glk error "Margin-aligned image placement requested when the placement doesn't follow a blank line";
		otherwise:
			[Implements "Inline-aligned images count as "text" for the purpose of this rule (Glk Specification, Section 7.3)".  At some point it would be good to factor the hash table update out of the check phrase.]
			let the linked list vertex be the extra stream state vertex of the window A for Glk error detection;
			unless the linked list vertex is null:
				write the value the extra Glk stream state value of the linked list vertex with no margin-aligned image possible to the linked list vertex;
		stop;
	signal the Glk error "Image placement is invalid for the target window type".

Section "Glk Dispatch Contract Violations" - unindexed

To check that (A - a number) and (B - a number) are equal array lengths:
	if the Glk error state is not empty:
		stop;
	if A is B:
		stop;
	signal the Glk error "Associated array arguments differ in length".

To check that (A - a number) is nonnegative and less than (B - a number):
	if the Glk error state is not empty:
		stop;
	if A is at least zero and A is less than B:
		stop;
	signal the Glk error "Argument giving the used portion of the array argument is out of bounds".

Chapter "Extra Glk State" - unindexed

Section "Extra Glk Stream State" - unindexed

[Layout:
	26 bits padding (most significant)
	1 bit for the margin-aligned image possible flag
	1 bit for the line input pending flag
	1 bit for the character input pending flag
	1 bit for the text stream flag
	1 bit for the output stream flag
	1 bit for the input stream flag (least significant)]

An extra Glk stream state is a kind of value.  Extra Glk stream state 63 specifies an extra Glk stream state.
The specification of an extra Glk stream state is "Some parts of the Glk state, like whether a stream is for input, output, or both, are stored by the interpreter but inaccessible to the story, because no Glk call can read them.  Therefore, Verbose Diagnostics and Verbose Diagnostics Lite have to remember this state themselves.  For streams, everything is represented in the bits of an arithmetic kind, which is called 'extra Glk stream state'."

To decide what extra Glk stream state is the extra Glk stream state for a new binary input stream: (- 1 -).
To decide what extra Glk stream state is the extra Glk stream state for a new non-window binary output stream: (- 2 -).
To decide what extra Glk stream state is the extra Glk stream state for a new window output stream: (- 38 -).
To decide what extra Glk stream state is the extra Glk stream state for a new binary input-output stream: (- 3 -).
To decide what extra Glk stream state is the all-flags extra Glk stream state: (- 63 -).

To decide whether (E - an extra Glk stream state) describes an input stream: (- ({E}&1) -).
To decide whether (E - an extra Glk stream state) describes an output stream: (- ({E}&2) -).
To decide whether (E - an extra Glk stream state) describes a text stream: (- ({E}&4) -).
To decide whether (E - an extra Glk stream state) describes character input pending: (- ({E}&8) -).
To decide whether (E - an extra Glk stream state) describes line input pending: (- ({E}&16) -).
To decide whether (E - an extra Glk stream state) describes the possibility of a margin-aligned image: (- ({E}&32) -).

To decide what extra Glk stream state is (E - an extra Glk stream state) with text usage: (- ({E}|4) -).

To decide what extra Glk stream state is (E - an extra Glk stream state) with no character input pending: (- ({E}&~8) -).
To decide what extra Glk stream state is (E - an extra Glk stream state) with character input pending: (- ({E}|8) -).

To decide what extra Glk stream state is (E - an extra Glk stream state) with no line input pending: (- ({E}&~16) -).
To decide what extra Glk stream state is (E - an extra Glk stream state) with line input pending: (- ({E}|16) -).

To decide what extra Glk stream state is (E - an extra Glk stream state) with no margin-aligned image possible: (- ({E}&~32) -).
To decide what extra Glk stream state is (E - an extra Glk stream state) with a margin-aligned image possible: (- ({E}|32) -).

Section "Extra Glk File Reference State" - unindexed

[Layout:
	31 bits padding (most significant)
	1 bit for the text usage flag (least significant)]

An extra Glk file reference state is a kind of value.  Extra Glk file reference state 1 specifies an extra Glk file reference state.
The specification of an extra Glk file reference state is "Some parts of the Glk state, like whether a file reference is for binary data or text are stored by the interpreter but inaccessible to the story, because no Glk call can read them.  Therefore, Verbose Diagnostics and Verbose Diagnostics Lite have to remember this state themselves.  For file references, everything is represented in the bits of an arithmetic kind, which is called 'extra Glk file reference state'."

To decide what extra Glk file reference state is the extra Glk file reference state for a new binary file reference: (- 0 -).
To decide what extra Glk file reference state is the extra Glk file reference state for a new text file reference: (- 1 -).
To decide what extra Glk file reference state is the all-flags extra Glk file reference state: (- 1 -).

To decide whether (E - an extra Glk file reference state) describes a text file reference: (- ({E}&1) -).

Section "Extra Glk State Hash Tables" - unindexed

The extra Glk stream state hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for extra Glk stream state rule):
	now the extra Glk stream state hash table is a new hash table with the extra Glk stream state hash table size buckets.

The extra Glk file reference state hash table is a hash table that varies.

A GRIF setup rule (this is the allocate a hash table for extra Glk file reference state rule):
	now the extra Glk file reference state hash table is a new hash table with the extra Glk file reference state hash table size buckets.

Section "Extra Glk State Hash Table Mutators" - unindexed

To note a character input request for the window (W - a number):
	let the linked list vertex be the extra stream state vertex of the window W for Glk error detection;
	unless the linked list vertex is null:
		write the value the extra Glk stream state value of the linked list vertex with character input pending to the linked list vertex.

To note a finished character input request for the window (W - a number):
	let the linked list vertex be the extra stream state vertex of the window W for Glk error detection after dispatch;
	unless the linked list vertex is null:
		write the value the extra Glk stream state value of the linked list vertex with no character input pending to the linked list vertex.

To note a line input request for the window (W - a number):
	let the linked list vertex be the extra stream state vertex of the window W for Glk error detection;
	unless the linked list vertex is null:
		write the value the extra Glk stream state value of the linked list vertex with line input pending to the linked list vertex.

To note a finished line input request for the window (W - a number):
	let the linked list vertex be the extra stream state vertex of the window W for Glk error detection after dispatch;
	unless the linked list vertex is null:
		write the value the extra Glk stream state value of the linked list vertex with no line input pending to the linked list vertex.

To note a trailing newline for the stream (S - a number):
	let the linked list vertex be the first match for the key S in the extra Glk stream state hash table;
	unless the linked list vertex is null:
		write the value the extra Glk stream state value of the linked list vertex with a margin-aligned image possible to the linked list vertex.

To note no trailing newline for the stream (S - a number):
	let the linked list vertex be the first match for the key S in the extra Glk stream state hash table;
	unless the linked list vertex is null:
		write the value the extra Glk stream state value of the linked list vertex with no margin-aligned image possible to the linked list vertex.

To note the new window stream created:
	let the window be the result of the Glk invocation just delegated;
	let the stream be the stream of the window the window for Glk error detection after dispatch;
	insert the key the stream and the value the extra Glk stream state for a new window output stream into the extra Glk stream state hash table.

To note the new stream created with no file reference and filemode (M - a number):
	let the value be the extra Glk stream state for a new non-window binary output stream;
	if M is the read operation:
		now the value is the extra Glk stream state for a new binary input stream;
	otherwise if M is the read-write operation:
		now the value is the extra Glk stream state for a new binary input-output stream;
	insert the key the result of the Glk invocation just delegated and the value the value into the extra Glk stream state hash table.

To note the new stream created with file reference (R - a number) and filemode (M - a number):
	let the value be the extra Glk stream state for a new non-window binary output stream;
	if M is the read operation:
		now the value is the extra Glk stream state for a new binary input stream;
	otherwise if M is the read-write operation:
		now the value is the extra Glk stream state for a new binary input-output stream;
	let the file reference state be the first extra Glk file reference state value matching the key R in the extra Glk file reference state hash table or the all-flags extra Glk file reference state if there are no matches;
	if the file reference state describes a text file reference:
		now the value is the value with text usage;
	insert the key the result of the Glk invocation just delegated and the value the value into the extra Glk stream state hash table.

To note the new file reference created with usage (U - a number):
	let the value be the extra Glk file reference state for a new binary file reference;
	if the bitwise and of U and the current Glk file encoding mask is text encoding:
		now the value is the extra Glk file reference state for a new text file reference;
	insert the key the result of the Glk invocation just delegated and the value the value into the extra Glk file reference state hash table.

Section "Filename for Extra Glk State" - unindexed

The Glk state filename is some text that varies.

A GRIF setup rule (this is the choose a filename for the extra Glk state rule):
	[The integer at address 32 is the story checksum.]
	now the Glk state filename is a new permanent synthetic text copied from "vdl_[the integer at address 32]_[the story title]".

Section "Magic Number and Length Field for Extra Glk State" - unindexed

Include (-
	Constant VDL_ = 1986292831;
	Array vdl_glkStatePrefix --> VDL_ 0;
-) after "Definitions.i6t".

Section "Saving Extra Glk State" - unindexed

Include (-
	[ vdl_saveGlkState contents length
		reference stream;
		reference=glk_fileref_create_by_name(fileusage_Data|fileusage_BinaryMode,(+ the Glk state filename +),0);
		if(~~reference){
			rfalse;
		}
		stream=glk_stream_open_file(reference,filemode_Write,0);
		glk_fileref_destroy(reference);
		if(~~stream){
			rfalse;
		}
		vdl_glkStatePrefix-->0=VDL_;
		vdl_glkStatePrefix-->1=length;
		glk_put_buffer_stream(stream,vdl_glkStatePrefix,8);
		glk_put_buffer_stream(stream,contents,length);
		glk_stream_close(stream,0);
		rtrue;
	];
-).

To save the (N - a number) byte/bytes at address (A - a number) as Glk state: (- vdl_saveGlkState({A},{N}); -).

To save Glk state (this is saving Glk state):
	let the byte counter be eight;
	repeat with the linked list vertex running through the extra Glk stream state hash table:
		increase the byte counter by eight;
	repeat with the linked list vertex running through the extra Glk file reference state hash table:
		increase the byte counter by eight;
	let the encoded state address be a possibly zero-length memory allocation of the byte counter bytes;
	let the address be the encoded state address;
	repeat with the linked list vertex running through the extra Glk stream state hash table:
		write the integer the number key of the linked list vertex to address the address;
		increase the address by four;
		write the integer the number value of the linked list vertex to address the address;
		increase the address by four;
	write the integer zero to address the address;
	increase the address by four;
	write the integer zero to address the address;
	increase the address by four;
	repeat with the linked list vertex running through the extra Glk file reference state hash table:
		write the integer the number key of the linked list vertex to address the address;
		increase the address by four;
		write the integer the number value of the linked list vertex to address the address;
		increase the address by four;
	save the byte counter bytes at address the encoded state address as Glk state;
	free the possibly zero-length memory allocation at address the encoded state address.

A GRIF shielding rule (this is the shield saving Glk state against instrumentation rule):
	shield saving Glk state against instrumentation.

Section "Loading Extra Glk State" - unindexed

Include (-
	[ vdl_loadGlkState
		reference stream length result;
		vdl_glkStatePrefix-->1=0;
		reference=glk_fileref_create_by_name(fileusage_Data|fileusage_BinaryMode,(+ the Glk state filename +),0);
		if(~~reference){
			return llo_zeroLengthAllocationAddress;
		}
		stream=glk_stream_open_file(reference,filemode_Read,0);
		if(~~stream){
			glk_fileref_destroy(reference);
			return llo_zeroLengthAllocationAddress;
		}
		if((glk_get_buffer_stream(stream,vdl_glkStatePrefix,8)~=8)||
		   (vdl_glkStatePrefix-->0~=VDL_)||
		   (~~(vdl_glkStatePrefix-->1))){
			vdl_glkStatePrefix-->1=0;
			glk_stream_close(stream,0);
			glk_fileref_destroy(reference);
			return llo_zeroLengthAllocationAddress;
		}
		length=vdl_glkStatePrefix-->1;
		@malloc length result;
		if(glk_get_buffer_stream(stream,result,length)~=length){
			@mfree result;
			vdl_glkStatePrefix-->1=0;
			glk_stream_close(stream,0);
			glk_fileref_destroy(reference);
			return llo_zeroLengthAllocationAddress;
		}
		glk_stream_close(stream,0);
		glk_fileref_delete_file(reference);
		glk_fileref_destroy(reference);
		return result;
	];
-).

To decide what number is the address of a newly loaded Glk state: (- vdl_loadGlkState(); -).
To decide what number is the length of the newly loaded Glk state: (- (vdl_glkStatePrefix-->1) -).

To load Glk state (this is loading Glk state):
	let the encoded state address be the address of a newly loaded Glk state;
	clear the extra Glk stream state hash table;
	clear the extra Glk file reference state hash table;
	let the address be the encoded state address;
	let the entry count be the length of the newly loaded Glk state divided by eight;
	let the class index be zero;
	repeat with a counter running over the half-open interval from zero to the entry count:
		let the key be the integer at address the address;
		increase the address by four;
		let the value be the integer at address the address;
		increase the address by four;
		if the key is zero:
			increment the class index;
		otherwise:
			if the class index is:
				-- zero:
					insert the key the key and the value the value into the extra Glk stream state hash table;
				-- one:
					insert the key the key and the value the value into the extra Glk file reference state hash table;
	free the possibly zero-length memory allocation at address the encoded state address.

A GRIF shielding rule (this is the shield loading Glk state against instrumentation rule):
	shield loading Glk state against instrumentation.

A GRIF setup rule (this is the load Glk state on startup rule):
	load Glk state.

Section "Temporary Space for Extra Glk State" - unindexed

Include (-
	Array vdl_restoreResult --> 1;
-) after "Definitions.i6t".

To decide what number is where the result of a restore-like operation is temporarily saved for Glk state loading: (- vdl_restoreResult -).

Section "Instruction Vertices for Extra Glk State" - unindexed

[ @callf <invocation-phrase> 0; ]
To decide what instruction vertex is a new Glk state-saving instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the function address of saving Glk state with return mode the zero-or-discard addressing mode.

[ @copy vdl_restoreResult-->0 <P-in-mode-M>; ]
To decide what instruction vertex is a new restore-result-restoring instruction vertex for mode (M - an addressing mode) and parameter (P - a number) for Glk state loading:
	decide on a new artificial instruction vertex for a copy with source mode the zero-based-dereference addressing mode and source parameter where the result of a restore-like operation is temporarily saved for Glk state loading and destination mode M and destination parameter P.

[ @jne vdl_restoreResult-->0 -1 <constant>; ]
To decide what instruction vertex is a new restore-result-testing instruction vertex for Glk state loading:
	let the result be a new artificial instruction vertex;
	write the operation code op-jne to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the result of a restore-like operation is temporarily saved for Glk state loading to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write -1 to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

[ @callf <invocation-phrase> 0; ]
To decide what instruction vertex is a new Glk state-loading instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the function address of loading Glk state with return mode the zero-or-discard addressing mode.

Section "Instrumentation for Extra Glk State" - unindexed

To note restores by (V - an instruction vertex) for Glk state saving:
	let the Glk state-saving instruction vertex be a new Glk state-saving instruction vertex;
	insert the Glk state-saving instruction vertex before V.

A GRIF instrumentation rule (this is the note restores for Glk state saving rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of the operation code op-restart in the scratch space:
		note restores by the instruction vertex for Glk state saving;
	repeat with the instruction vertex running through occurrences of the operation code op-restore in the scratch space:
		note restores by the instruction vertex for Glk state saving;
	repeat with the instruction vertex running through occurrences of the operation code op-restoreundo in the scratch space:
		note restores by the instruction vertex for Glk state saving.

To note restores to (V - an instruction vertex) for Glk state loading:
	let the store index be the parameter limit of V;
	let the result mode be the addressing mode of parameter the store index of V;
	let the result parameter be parameter the store index of V;
	write the addressing mode zero-based-dereference addressing mode to parameter the store index of V;
	write where the result of a restore-like operation is temporarily saved for Glk state loading to parameter the store index of V;
	let the restore-result-restoring instruction vertex be a new restore-result-restoring instruction vertex for mode the result mode and parameter the result parameter for Glk state loading;
	insert the restore-result-restoring instruction vertex after V;
	let the restore-result-testing instruction vertex be a new restore-result-testing instruction vertex for Glk state loading;
	let the Glk state-loading instruction vertex be a new Glk state-loading instruction vertex;
	insert the restore-result-testing instruction vertex before the restore-result-restoring instruction vertex;
	insert the Glk state-loading instruction vertex before the restore-result-restoring instruction vertex;
	establish a jump link from the restore-result-testing instruction vertex to the restore-result-restoring instruction vertex.

A GRIF instrumentation rule (this is the note restores for Glk state loading rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of the operation code op-save in the scratch space:
		note restores to the instruction vertex for Glk state loading;
	repeat with the instruction vertex running through occurrences of the operation code op-saveundo in the scratch space:
		note restores to the instruction vertex for Glk state loading.

Chapter "Glk Error Detection Layer" - unindexed

The Glk layer after Glk error detection is a Glk layer that varies.

[Most of these tests were automatically extracted from gi_dispa.c.  The others were gleaned from the Glk specification.]
To detect Glk errors (this is Glk error detection):
	now the Glk error function selector is the function selector of the current Glk invocation;
	[Variables in which to remember arguments:]
	let the file reference be a number;
	let the filemode be a number;
	let the event structure address be a number;
	[Switch, dispatch, and switch again.]
	if the Glk error function selector is:
		-- 1: [glk_exit]
			check that the current Glk invocation has zero arguments;
		-- 3: [glk_tick]
			check that the current Glk invocation has zero arguments;
		-- 4: [glk_gestalt]
			check that the current Glk invocation has two arguments;
		-- 5: [glk_gestalt_ext]
			check that the current Glk invocation has four arguments;
			check that either argument number two of the current Glk invocation is null or its argument number three of the current Glk invocation elements are at valid addresses;
			check that argument number two of the current Glk invocation is either null or a writeable address;
		-- 32: [glk_window_iterate]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
		-- 33: [glk_window_get_rock]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 34: [glk_window_get_root]
			check that the current Glk invocation has zero arguments;
		-- 35: [glk_window_open]
			check that the current Glk invocation has five arguments;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that either argument number zero of the current Glk invocation is nonnull or there are no Glk windows;
			check that either argument number zero of the current Glk invocation is null or argument number one of the current Glk invocation is a valid Glk window opening method;
			check that either argument number zero of the current Glk invocation is null or argument number two of the current Glk invocation is a valid Glk window size for the window opening method given by argument number one of the current Glk invocation;
			check that argument number three of the current Glk invocation is a valid Glk window type;
			check that either argument number zero of the current Glk invocation is null or argument number one of the current Glk invocation is not a fixed window opening method or argument number three of the current Glk invocation is not the blank window type;
		-- 36: [glk_window_close]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is either null or a valid structure address for two fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
		-- 37: [glk_window_get_size]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number two of the current Glk invocation is either null or a valid integer address;
			check that argument number two of the current Glk invocation is either null or a writeable address;
		-- 38: [glk_window_set_arrangement]
			check that the current Glk invocation has four arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation is a pair window;
			check that either argument number zero of the current Glk invocation is null or argument number one of the current Glk invocation is a valid Glk window opening method;
			check that either argument number zero of the current Glk invocation is null or argument number two of the current Glk invocation is a valid Glk window size for the window opening method given by argument number one of the current Glk invocation;
			check that argument number three of the current Glk invocation is a valid Glk window;
			check that argument number three of the current Glk invocation is not a pair window;
			check that argument number three of the current Glk invocation is either null or a proper descendant of argument number zero of the current Glk invocation;
			check that either argument number one of the current Glk invocation is not a fixed window opening method or argument number three of the current Glk invocation is null and the key window of argument number zero of the current Glk invocation is not a blank window;
		-- 39: [glk_window_get_arrangement]
			check that the current Glk invocation has four arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number two of the current Glk invocation is either null or a valid integer address;
			check that argument number two of the current Glk invocation is either null or a writeable address;
			check that argument number three of the current Glk invocation is either null or a valid integer address;
			check that argument number three of the current Glk invocation is either null or a writeable address;
		-- 40: [glk_window_get_type]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 41: [glk_window_get_parent]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 42: [glk_window_clear]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation has no line input pending;
		-- 43: [glk_window_move_cursor]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 44: [glk_window_get_stream]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 45: [glk_window_set_echo_stream]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is a valid Glk stream;
		-- 46: [glk_window_get_echo_stream]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 47: [glk_set_window]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 48: [glk_window_get_sibling]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 64: [glk_stream_iterate]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
		-- 65: [glk_stream_get_rock]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
		-- 66: [glk_stream_open_file]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
			check that argument number one of the current Glk invocation is a valid Glk file mode;
			now the file reference is argument number zero of the current Glk invocation;
			now the filemode is argument number one of the current Glk invocation;
		-- 67: [glk_stream_open_memory]
			check that the current Glk invocation has four arguments;
			check that argument number zero of the current Glk invocation is not null for legacy purposes;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation byte elements are at valid addresses;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
			check that argument number two of the current Glk invocation is a valid Glk file mode;
			now the filemode is argument number two of the current Glk invocation;
		-- 68: [glk_stream_close]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is not a window stream;
			check that argument number one of the current Glk invocation is either null or a valid structure address for two fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			remove the first occurrence of the key argument number zero of the current Glk invocation from the extra Glk stream state hash table;
		-- 69: [glk_stream_set_position]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that either the stream given by argument number zero of the current Glk invocation is a window stream or argument number one of the current Glk invocation is a valid position under the seek mode given by argument number two of the current Glk invocation;
		-- 70: [glk_stream_get_position]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
		-- 71: [glk_stream_set_current]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 72: [glk_stream_get_current]
			check that the current Glk invocation has zero arguments;
		-- 96: [glk_fileref_create_temp]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is a valid Glk file usage;
			note the new file reference created with usage argument number zero of the current Glk invocation;
		-- 97: [glk_fileref_create_by_name]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is a valid Glk file usage;
			check that argument number one of the current Glk invocation is a valid Glk file mode;
			note the new file reference created with usage argument number zero of the current Glk invocation;
		-- 98: [glk_fileref_create_by_prompt]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is a valid Glk file usage;
			check that argument number one of the current Glk invocation is a valid Glk file mode;
			note the new file reference created with usage argument number zero of the current Glk invocation;
		-- 99: [glk_fileref_destroy]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
			remove the first occurrence of the key argument number zero of the current Glk invocation from the extra Glk file reference state hash table;
		-- 100: [glk_fileref_iterate]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
		-- 101: [glk_fileref_get_rock]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
		-- 102: [glk_fileref_delete_file]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
		-- 103: [glk_fileref_does_file_exist]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
		-- 104: [glk_fileref_create_from_fileref]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is a valid Glk file usage;
			check that argument number one of the current Glk invocation is not null;
			check that argument number one of the current Glk invocation is a valid Glk file reference;
			note the new file reference created with usage argument number zero of the current Glk invocation;
		-- 128: [glk_put_char]
			check that the current Glk invocation has one argument;
			check that the current stream is not null;
		-- 129: [glk_put_char_stream]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 130: [glk_put_string]
			check that the current Glk invocation has one argument;
			check that the current stream is not null;
		-- 131: [glk_put_string_stream]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 132: [glk_put_buffer]
			check that the current Glk invocation has two arguments;
			check that the current stream is not null;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation byte elements are at valid addresses;
			check that argument number zero of the current Glk invocation is not null;
		-- 133: [glk_put_buffer_stream]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation byte elements are at valid addresses;
			check that argument number one of the current Glk invocation is not null;
		-- 134: [glk_set_style]
			check that the current Glk invocation has one argument;
			check that the current stream is not null;
		-- 135: [glk_set_style_stream]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 144: [glk_get_char_stream]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid input stream;
		-- 145: [glk_get_line_stream]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid input stream;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation byte elements are at valid addresses;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 146: [glk_get_buffer_stream]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid input stream;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation byte elements are at valid addresses;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 160: [glk_char_to_lower]
			check that the current Glk invocation has one argument;
		-- 161: [glk_char_to_upper]
			check that the current Glk invocation has one argument;
		-- 176: [glk_stylehint_set]
			check that the current Glk invocation has four arguments;
			check that argument number three of the current Glk invocation is a valid value for the style hint given by argument number two of the current Glk invocation;
		-- 177: [glk_stylehint_clear]
			check that the current Glk invocation has three arguments;
		-- 178: [glk_style_distinguish]
			check that the current Glk invocation has three arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 179: [glk_style_measure]
			check that the current Glk invocation has four arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number three of the current Glk invocation is either null or a valid integer address;
			check that argument number three of the current Glk invocation is either null or a writeable address;
		-- 192: [glk_select]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for four fields;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
			now the event structure address is argument number zero of the current Glk invocation;
		-- 193: [glk_select_poll]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for four fields;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
		-- 208: [glk_request_line_event]
			check that the current Glk invocation has four arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation has no character input pending;
			check that argument number zero of the current Glk invocation has no line input pending;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation byte elements are at valid addresses;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
			note a line input request for the window argument number zero of the current Glk invocation;
		-- 209: [glk_cancel_line_event]
			check that the current Glk invocation has two arguments;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is either null or a valid structure address for four fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			note a finished line input request for the window argument number zero of the current Glk invocation;
		-- 210: [glk_request_char_event]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation has no character input pending;
			check that argument number zero of the current Glk invocation has no line input pending;
			note a character input request for the window argument number zero of the current Glk invocation;
		-- 211: [glk_cancel_char_event]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			note a finished character input request for the window argument number zero of the current Glk invocation;
		-- 212: [glk_request_mouse_event]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 213: [glk_cancel_mouse_event]
			check that the current Glk invocation has one argument;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 214: [glk_request_timer_events]
			check that the current Glk invocation has one argument;
		-- 224: [glk_image_get_info]
			check that the current Glk invocation has three arguments;
			check that images are supported;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number two of the current Glk invocation is either null or a valid integer address;
			check that argument number two of the current Glk invocation is either null or a writeable address;
		-- 225: [glk_image_draw]
			check that the current Glk invocation has four arguments;
			check that images are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation is a text buffer or graphics window;
			check that either argument number zero of the current Glk invocation is a graphics window or it is a window where argument number one of the current Glk invocation is a possible image alignment and argument number two of the current Glk invocation is zero;
		-- 226: [glk_image_draw_scaled]
			check that the current Glk invocation has six arguments;
			check that images are supported;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation is a text buffer or graphics window;
			check that either argument number zero of the current Glk invocation is a graphics window or it is a window where argument number one of the current Glk invocation is a possible image alignment and argument number two of the current Glk invocation is zero;
		-- 232: [glk_window_flow_break]
			check that the current Glk invocation has one argument;
			check that images are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 233: [glk_window_erase_rect]
			check that the current Glk invocation has five arguments;
			check that images are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 234: [glk_window_fill_rect]
			check that the current Glk invocation has six arguments;
			check that images are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 235: [glk_window_set_background_color]
			check that the current Glk invocation has two arguments;
			check that images are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number one of the current Glk invocation is a valid RGB color;
		-- 240: [glk_schannel_iterate]
			check that the current Glk invocation has two arguments;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
			check that argument number one of the current Glk invocation is either null or a valid integer address;
			check that argument number one of the current Glk invocation is either null or a writeable address;
		-- 241: [glk_schannel_get_rock]
			check that the current Glk invocation has one argument;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 242: [glk_schannel_create]
			check that the current Glk invocation has one argument;
			check that sound is supported;
		-- 243: [glk_schannel_destroy]
			check that the current Glk invocation has one argument;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 248: [glk_schannel_play]
			check that the current Glk invocation has two arguments;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 249: [glk_schannel_play_ext]
			check that the current Glk invocation has four arguments;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 250: [glk_schannel_stop]
			check that the current Glk invocation has one argument;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 251: [glk_schannel_set_volume]
			check that the current Glk invocation has two arguments;
			check that sound is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 252: [glk_sound_load_hint]
			check that the current Glk invocation has two arguments;
			check that sound is supported;
		-- 244: [glk_schannel_create_ext]
			check that the current Glk invocation has two arguments;
			check that sound extensions are supported;
		-- 247: [glk_schannel_play_multi]
			check that the current Glk invocation has five arguments;
			check that sound extensions are supported;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is not null;
			check that the argument number one of the current Glk invocation elements of argument number zero of the current Glk invocation are all valid nonnull Glk sound channels;
			check that either argument number two of the current Glk invocation is null or its argument number three of the current Glk invocation elements are at valid addresses;
			check that argument number two of the current Glk invocation is not null;
			check that argument number one of the current Glk invocation and argument number three of the current Glk invocation are equal array lengths;
		-- 253: [glk_schannel_set_volume_ext]
			check that the current Glk invocation has four arguments;
			check that sound extensions are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 254: [glk_schannel_pause]
			check that the current Glk invocation has one argument;
			check that sound extensions are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 255: [glk_schannel_unpause]
			check that the current Glk invocation has one argument;
			check that sound extensions are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk sound channel;
		-- 256: [glk_set_hyperlink]
			check that the current Glk invocation has one argument;
			check that hyperlinks are supported;
			check that the current stream is not null;
		-- 257: [glk_set_hyperlink_stream]
			check that the current Glk invocation has two arguments;
			check that hyperlinks are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 258: [glk_request_hyperlink_event]
			check that the current Glk invocation has one argument;
			check that hyperlinks are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 259: [glk_cancel_hyperlink_event]
			check that the current Glk invocation has one argument;
			check that hyperlinks are supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 288: [glk_buffer_to_lower_case_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode is supported;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number two of the current Glk invocation is nonnegative and less than argument number one of the current Glk invocation;
		-- 289: [glk_buffer_to_upper_case_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode is supported;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number two of the current Glk invocation is nonnegative and less than argument number one of the current Glk invocation;
		-- 290: [glk_buffer_to_title_case_uni]
			check that the current Glk invocation has four arguments;
			check that Unicode is supported;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number two of the current Glk invocation is nonnegative and less than argument number one of the current Glk invocation;
		-- 296: [glk_put_char_uni]
			check that the current Glk invocation has one argument;
			check that Unicode is supported;
			check that the current stream is not null;
		-- 297: [glk_put_string_uni]
			check that the current Glk invocation has one argument;
			check that Unicode is supported;
			check that the current stream is not null;
		-- 298: [glk_put_buffer_uni]
			check that the current Glk invocation has two arguments;
			check that Unicode is supported;
			check that the current stream is not null;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is not null;
		-- 299: [glk_put_char_stream_uni]
			check that the current Glk invocation has two arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 300: [glk_put_string_stream_uni]
			check that the current Glk invocation has two arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
		-- 301: [glk_put_buffer_stream_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid output stream;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation elements are at valid addresses;
			check that argument number one of the current Glk invocation is not null;
		-- 304: [glk_get_char_stream_uni]
			check that the current Glk invocation has one argument;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid input stream;
		-- 305: [glk_get_buffer_stream_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid input stream;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation elements are at valid addresses;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 306: [glk_get_line_stream_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk stream;
			check that argument number zero of the current Glk invocation is a valid input stream;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation elements are at valid addresses;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 312: [glk_stream_open_file_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk file reference;
			check that argument number one of the current Glk invocation is a valid Glk file mode;
			now the file reference is argument number zero of the current Glk invocation;
			now the filemode is argument number one of the current Glk invocation;
		-- 313: [glk_stream_open_memory_uni]
			check that the current Glk invocation has four arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null for legacy purposes;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number two of the current Glk invocation is a valid Glk file mode;
			now the filemode is argument number two of the current Glk invocation;
		-- 320: [glk_request_char_event_uni]
			check that the current Glk invocation has one argument;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation has no character input pending;
			check that argument number zero of the current Glk invocation has no line input pending;
			note a character input request for the window argument number zero of the current Glk invocation;
		-- 321: [glk_request_line_event_uni]
			check that the current Glk invocation has four arguments;
			check that Unicode is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that argument number zero of the current Glk invocation has no character input pending;
			check that argument number zero of the current Glk invocation has no line input pending;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation elements are at valid addresses;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
			note a line input request for the window argument number zero of the current Glk invocation;
		-- 291: [glk_buffer_canon_decompose_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode normaliziation is supported;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number two of the current Glk invocation is nonnegative and less than argument number one of the current Glk invocation;
		-- 292: [glk_buffer_canon_normalize_uni]
			check that the current Glk invocation has three arguments;
			check that Unicode normaliziation is supported;
			check that either argument number zero of the current Glk invocation is null or its argument number one of the current Glk invocation elements are at valid addresses;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number two of the current Glk invocation is nonnegative and less than argument number one of the current Glk invocation;
		-- 336: [glk_set_echo_line_event]
			check that the current Glk invocation has two arguments;
			check that echo control is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
		-- 337: [glk_set_terminators_line_event]
			check that the current Glk invocation has three arguments;
			check that terminator control is supported;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number zero of the current Glk invocation is a valid Glk window;
			check that either argument number one of the current Glk invocation is null or its argument number two of the current Glk invocation elements are at valid addresses;
		-- 352: [glk_current_time]
			check that the current Glk invocation has one argument;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for three fields;
			check that argument number zero of the current Glk invocation is either null or a writeable address;
			check that argument number zero of the current Glk invocation is not null;
		-- 353: [glk_current_simple_time]
			check that the current Glk invocation has one argument;
			check that timekeeping is supported;
		-- 360: [glk_time_to_date_utc]
			check that the current Glk invocation has two arguments;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for three fields;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number one of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 361: [glk_time_to_date_local]
			check that the current Glk invocation has two arguments;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for three fields;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number one of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 362: [glk_simple_time_to_date_utc]
			check that the current Glk invocation has three arguments;
			check that timekeeping is supported;
			check that argument number two of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number two of the current Glk invocation is either null or a writeable address;
			check that argument number two of the current Glk invocation is not null;
		-- 363: [glk_simple_time_to_date_local]
			check that the current Glk invocation has three arguments;
			check that timekeeping is supported;
			check that argument number two of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number two of the current Glk invocation is either null or a writeable address;
			check that argument number two of the current Glk invocation is not null;
		-- 364: [glk_date_to_time_utc]
			check that the current Glk invocation has two arguments;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number one of the current Glk invocation is either null or a valid structure address for three fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 365: [glk_date_to_time_local]
			check that the current Glk invocation has two arguments;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number zero of the current Glk invocation is not null;
			check that argument number one of the current Glk invocation is either null or a valid structure address for three fields;
			check that argument number one of the current Glk invocation is either null or a writeable address;
			check that argument number one of the current Glk invocation is not null;
		-- 366: [glk_date_to_simple_time_utc]
			check that the current Glk invocation has two arguments;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number zero of the current Glk invocation is not null;
		-- 367: [glk_date_to_simple_time_local]
			check that the current Glk invocation has two arguments;
			check that timekeeping is supported;
			check that argument number zero of the current Glk invocation is either null or a valid structure address for eight fields;
			check that argument number zero of the current Glk invocation is not null;
		-- 73: [glk_stream_open_resource]
			check that the current Glk invocation has two arguments;
			check that resource streams are supported;
		-- 314: [glk_stream_open_resource_uni]
			check that the current Glk invocation has two arguments;
			check that resource streams are supported;
	if the Glk error state is not empty:
		[In some very rare situations it will matter that we aren't inferring the number and type of stack results from the call.  For now, I don't think it's worth the effort.]
		delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		now the Glk error state is "";
		stop;
	delegate the current Glk invocation to the Glk layer after Glk error detection;
	if the Glk error function selector is:
		-- 192: [glk_select]
			let the event be the integer at address the event structure address;
			let the window be the integer at address (the event structure address plus four);
			if the event is the character input event type:
				note a finished character input request for the window the window;
			otherwise if the event is the line input event type:
				note a finished line input request for the window the window;
		-- 35: [glk_window_open]
			note the new window stream created;
		-- 66: [glk_stream_open_file]
			note the new stream created with file reference the file reference and filemode the filemode;
		-- 312: [glk_stream_open_file_uni]
			note the new stream created with file reference the file reference and filemode the filemode;
		-- 67: [glk_stream_open_memory]
			note the new stream created with no file reference and filemode the filemode;
		-- 313: [glk_stream_open_memory_uni]
			note the new stream created with no file reference and filemode the filemode;
		-- 73: [glk_stream_open_resource]
			note the new stream created with no file reference and filemode the read operation;
		-- 314: [glk_stream_open_resource_uni]
			note the new stream created with no file reference and filemode the read operation.

A Glk layering rule (this is the detect Glk errors rule):
		install Glk error detection as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after Glk error detection be the layer it should delegate to.

Chapter "Output Interception for Glk Error Detection" - unindexed

To decide whether (C - a number) is a forbidden control character:
	if C is at least 0 [null] and C is at most 9 [tab]:
		decide yes;
	if C is at least 11 [vertical tab] and C is at most 31 [unit separator]:
		decide yes;
	if C is at least 127 [delete; beginning of additionally reserved control characters] and C is at most 159 [end of additionally reserved control characters]:
		decide yes;
	decide no.

An output interception rule (this is the intercept output for Glk error detection rule):
	if the input-output system of the intercepted output is the Glk input-output system:
		now the Glk error function selector is zero;
		if the type of the intercepted output is:
			-- invalid textual output:
				signal the Glk error "Attempt to print invalid text";
			-- valid textual output:
				check that the stream given by the stream of the intercepted output is not blocked by line input;
				let the stream state be the first extra Glk stream state value matching the key the stream of the intercepted output in the extra Glk stream state hash table or the all-flags extra Glk stream state if there are no matches;
				if the stream state describes a text stream:
					let the address be the address of the intercepted output;
					repeat with a counter running over the half-open interval from zero to the length of the intercepted output:
						if the integer at address the address is a forbidden control character:
							signal the Glk error "Attempt to print control characters to a text stream";
							stop;
						increase the address by four;
				if the length of the intercepted output is greater than zero:
					let the linked list vertex be the first match for the key the stream of the intercepted output in the extra Glk stream state hash table;
					unless the linked list vertex is null:
						let the address of the last character be the address of the intercepted output plus (four times the length of the intercepted output) minus four;
						if the integer at address the address of the last character is 10: [newline]
							write the value the extra Glk stream state value of the linked list vertex with a margin-aligned image possible to the linked list vertex;
						otherwise:
							write the value the extra Glk stream state value of the linked list vertex with no margin-aligned image possible to the linked list vertex;
			-- save file output:
				let the stream state be the first extra Glk stream state value matching the key the stream of the intercepted output in the extra Glk stream state hash table or the all-flags extra Glk stream state if there are no matches;
				if the stream state describes a text stream:
					signal the Glk error "Attempt to print control characters to a text stream";
					stop;
			-- endless output:
				signal the Glk error "Attempt to print to an echo stream cycle";
			-- style change:
				do nothing;
			-- endless style change:
				signal the Glk error "Attempt to set the style of an echo stream cycle";
			-- cursor movement:
				check that the stream given by the stream of the intercepted output is not blocked by line input.

Book "Miscellaneous Errors" - unindexed

Responding to a miscellaneous error is a phrase nothing -> nothing that varies.

Chapter "Responding to a Miscellaneous Error" - unindexed (for use without Interactive Debugger by Brady Garvin)

[We use the word ``print'' to avoid an Inform bug in 6G60.]
To print the call stack for a miscellaneous error (this is saying the call stack for a miscellaneous error):
	say "[the call stack]".

Responding to a miscellaneous error is saying the call stack for a miscellaneous error.

Chapter "Responding to a Miscellaneous Error" - unindexed (for use with Interactive Debugger by Brady Garvin)

To force a breakpoint for a miscellaneous error (this is forcing a breakpoint for a miscellaneous error):
	force a breakpoint named "Miscellaneous error".

Responding to a miscellaneous error is forcing a breakpoint for a miscellaneous error.

Chapter "The Custom Miscellaneous Error Handler" - unindexed

Include (-
	[ vdl_MiscellaneousErrorHandler message;
		print (string)message,"^";
		(llo_getField((+ responding to a miscellaneous error +),1))();
	];
-).

Chapter "Miscellaneous Error Handler Addresses" - unindexed

To decide what number is the address of the custom miscellaneous error handler: (- vdl_MiscellaneousErrorHandler -).

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
[ @callfi vdl_MiscellaneousErrorHandler <moved-from-parameter-zero> 0; ]
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
	say "[low-level runtime failure in][the story title][with explanation]The story called a nonfunction as if it were a function.[line break][the call stack][terminating the story]".

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

When Verbose Diagnostics Lite is included, all of the known problem messages for
runtime trouble, at the I7 level, at the I6 level, and at the Glk level, are
accompanied by a call stack.  These call stacks are printed using phrases from
the extension Call Stack Tracking (which see), and we can customize them by
changing the truth states from Call Stack Tracking in a GRIF setup rule.  For
example,

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

Two Glk-related prohibitions are unduly expensive to enforce and therefore not
checked: that the story must not change the contents of a memory stream's buffer
while the stream is open and that it must not free a retained array.

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

Verbose Diagnostics Lite was prepared as part of the Glulx Runtime
Instrumentation Project (https://github.com/i7/i7grip).  For this first edition
of the project, special thanks go to these people, in chronological order:

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

Version 1 of Glk Interception (for Glulx only) by Brady Garvin begins here.

"Facilities for intercepting and altering Glk-based input and output.  Also, primitive support for cooperative multitasking."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Human-Friendly Function Names by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Glk Interception you will see a sentence like

	A Glk invocation is an invalid Glk invocation.

This bewildering statement actually sets up Glk invocations as a qualitative value with default value the Glk invocation at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on Glk invocations.]

Chapter "Use Options"

[At the time of writing, 1600 is roughly one turn of a sparsely implemented story.]
Use an inter-yield delay of at least 1600 translates as (- Constant GI_INTERYIELD_DELAY={N}; -).

To decide what number is the inter-yield delay: (- GI_INTERYIELD_DELAY -).

Chapter "Rulebooks"

The Glk layering rules are [rulebook is] a rulebook.

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at copying a Glk invocation after it has been delegated:
	say "[low-level runtime failure in]Glk Interception[with explanation]I was asked to copy a Glk invocation, but after it had already been delegated to another Glk layer and was therefore no longer in my possession.[terminating the story]".

To fail at overwriting a Glk invocation after it has been delegated:
	say "[low-level runtime failure in]Glk Interception[with explanation]I was asked to overwrite a Glk invocation, but after it had already been delegated to another Glk layer and was therefore no longer in my possession.[terminating the story]".

To fail at copying a Glk outcome before anything has been delegated:
	say "[low-level runtime failure in]Glk Interception[with explanation]I was asked to copy a Glk outcome, but before the current call had been delegated to another Glk layer to produce an outcome.[terminating the story]".

To fail at overwriting a Glk outcome before anything has been delegated:
	say "[low-level runtime failure in]Glk Interception[with explanation]I was asked to overwrite a Glk outcome, but before the current call had been delegated to another Glk layer to produce an outcome.[terminating the story]".

To fail at delegating a Glk invocation twice:
	say "[low-level runtime failure in]Glk Interception[with explanation]I was asked to delegate a Glk invocation twice, which probably indicates a bug in the Glk interception layers.  (If you did mean to delegate two invocations, you should use one of the 'prepare...' phrases to create the second one.)[terminating the story]".

To fail at finding a delegation successful:
	say "[low-level runtime failure in]Glk Interception[with explanation]I gave a Glk invocation to an interception layer, expecting the layer to produce a result, either by delegating invocations to yet another layer or by handing the invocations over to the interpreter.  But it shirked responsibility and did neither, a bug.[terminating the story]".

Book "Glk Invocations"

Chapter "The Current Glk Invocation"

Section "Storage for the Current Glk Invocation" - unindexed

Include (-
	Array gi_glkRequest --> 1;
	Array gi_glkArgumentCount --> 1;
	Array gi_glkArgumentPointer --> 1;
-) after "Definitions.i6t".

Section "Addresses for the Current Glk Invocation" - unindexed

To decide what number is where the intercepted Glk function selector is temporarily saved: (- gi_glkRequest -).

Section "Private Accessors and Mutators for the Current Glk Invocation" - unindexed

To decide what number is the argument array address of the current Glk invocation: (- llo_getInt(gi_glkArgumentPointer) -).
To write the argument array address (X - a number) to the current Glk invocation: (- llo_setInt(gi_glkArgumentPointer,{X}); -).

To write the argument count (X - a number) to the current Glk invocation without reallocation: (- llo_setInt(gi_glkArgumentCount,{X}); -).

Section "Public Accessors for the Current Glk Invocation"

To decide what number is the function selector of the current Glk invocation: (- llo_getInt(gi_glkRequest) -).
To decide what number is the argument count of the current Glk invocation: (- llo_getInt(gi_glkArgumentCount) -).
To decide what number is argument number (I - a number) of the current Glk invocation: (- llo_getField(llo_getInt(gi_glkArgumentPointer),{I}) -).

Section "Public Mutators for the Current Glk Invocation"

To write the function selector (X - a number) to the current Glk invocation: (- llo_setInt(gi_glkRequest,{X}); -).

To write the argument count (N - a number) to the current Glk invocation:
	if N is greater than the argument count of the current Glk invocation:
		let the old byte count be four times the argument count of the current Glk invocation;
		let the old argument array address be the argument array address of the current Glk invocation;
		let the new argument array address be a memory allocation of N times four bytes;
		copy the old byte count bytes from address old argument array address to address new argument array address;
		zero the (four times N) minus the old byte count bytes at address new argument array address plus the old byte count;
		free the possibly zero-length memory allocation at address old argument array address;
		write the argument array address new argument array address to the current Glk invocation;
	write the argument count N to the current Glk invocation without reallocation.

To ensure that the current Glk invocation has at least (N - a number) argument/arguments:
	if the argument count of the current Glk invocation is less than N:
		write the argument count N to the current Glk invocation.

To write (X - a value) to argument number (I - a number) of the current Glk invocation: (- llo_setField(llo_getInt(gi_glkArgumentPointer),{I},{X}); -).

Chapter "Stored Glk Invocations"

Section "The Glk Invocation Kind"

A Glk invocation is a kind of value.
A Glk invocation is an invalid Glk invocation.  [See the note in the book "Extension Information."]
The specification of a Glk invocation is "Stored Glk invocations represent a call to the Glk I/O system that a Glk interception layer has chosen to remember.  Glk invocations can be inspected, used to overwrite in-progress calls to Glk, or even replicated to be sent again."

Section "The Glk Invocation Structure" - unindexed

[Layout:
	4 bytes for the function selector
	4 bytes for the argument count
	4 bytes per argument for the arguments]

To decide what number is the size in memory of a Glk invocation with (N - a number) arguments: (- 8+(4*{N}) -).

Section "Glk Invocation Construction and Destruction"

To decide what Glk invocation is a new copy of the current Glk invocation:
	check that the Glk layers are in the pre-call state or else fail at copying a Glk invocation after it has been delegated;
	let the limit be the argument count of the current Glk invocation;
	let the result be a memory allocation of the size in memory of a Glk invocation with limit arguments bytes converted to a Glk invocation;
	write the function selector the function selector of the current Glk invocation to the result;
	write the argument count limit to the result;
	repeat with the index running over the half-open interval from zero to the limit:
		write argument number index of the current Glk invocation to argument number index of the result;
	decide on the result.

To delete (A - a Glk invocation):
	free the memory allocation at address A converted to a number.

Section "Private Glk Invocation Mutators" - unindexed

To write the function selector (X - a number) to (A - a Glk invocation): (- llo_setInt({A},{X}); -).

To write the argument count (X - a number) to (A - a Glk invocation): (- llo_setField({A},1,{X}); -).

To write (X - a value) to argument number (I - a number) of (A - a Glk invocation): (- llo_setField({A},2+{I},{X}); -).

Section "Public Glk Invocation Accessors"

To decide what number is the function selector of (A - a Glk invocation): (- llo_getInt({A}) -).

To decide what number is the argument count of (A - a Glk invocation): (- llo_getField({A},1) -).

To decide what number is argument number (I - a number) of (A - a Glk invocation): (- llo_getField({A},2+{I}) -).

Section "Glk Invocation Restoration"

To overwrite the current Glk invocation with (A - a Glk invocation):
	check that the Glk layers are in the pre-call state or else fail at overwriting a Glk invocation after it has been delegated;
	write the function selector the function selector of A to the current Glk invocation;
	let the limit be the argument count of A;
	write the argument count limit to the current Glk invocation;
	repeat with the index running over the half-open interval from zero to the limit:
		write argument number index of A to argument number index of the current Glk invocation.

Chapter "The Glk Invocation Just Delegated"

Section "Storage for the Glk Invocation Just Delegated" - unindexed

Include (-
	Array gi_glkStackResultCount --> 1;
	Array gi_glkStackResultPointer --> 1;
	Array gi_glkResult --> 1;
-) after "Definitions.i6t".

Section "Addresses for the Glk Invocation Just Delegated" - unindexed

To decide what number is where the number of intercepted Glk stack results is temporarily saved: (- gi_glkStackResultCount -).
To decide what number is where the intercepted Glk stack results pointer is temporarily saved: (- gi_glkStackResultPointer -).

Section "Private Accessors and Mutators for the Glk Invocation Just Delegated" - unindexed

To write the stack result count (X - a number) to the Glk invocation just delegated: (- llo_setInt(gi_glkStackResultCount,{X}); -).

To decide what number is the stack results array address of the Glk invocation just delegated: (- llo_getInt(gi_glkStackResultPointer) -).
To write the stack results array address (X - a number) to the Glk invocation just delegated: (- llo_setInt(gi_glkStackResultPointer,{X}); -).

Section "Public Accessors for the Glk Invocation Just Delegated"

To decide what number is the number of stack results from the Glk invocation just delegated: (- llo_getInt(gi_glkStackResultCount) -).
To decide what number is stack result number (I - a number) of the Glk invocation just delegated: (- llo_getField(llo_getInt(gi_glkStackResultPointer),{I}) -).
To decide what number is the result of the Glk invocation just delegated: (- llo_getInt(gi_glkResult) -).

Section "Public Mutators for the Glk Invocation Just Delegated"

To write (X - a value) to stack result number (I - a number) of the Glk invocation just delegated: (- llo_setField(llo_getInt(gi_glkStackResultPointer),{I},{X}); -).
To write the result (X - a value) to the Glk invocation just delegated: (- llo_setInt(gi_glkResult,{X}); -).

Chapter "Stored Glk Outcomes"

Section "The Glk Outcome Kind"

A Glk outcome is a kind of value.
A Glk outcome is an invalid Glk outcome.  [See the note in the book "Extension Information."]
The specification of a Glk outcome is "Stored Glk outcomes represent the results returned by a call to the Glk I/O system, wrapped in a structure because a Glk interception layer has chosen to remember them.  Glk outcomes can be inspected or used to overwrite the results of intervening calls to Glk."

Section "The Glk Outcome Structure" - unindexed

[Layout:
	4 bytes for the primary result
	4 bytes for the stack result count
	4 bytes per result for the stack result array]

To decide what number is the size in memory of a Glk outcome with (N - a number) stack results: (- 8+(4*{N}) -).

Section "Glk Outcome Construction and Destruction"

To decide what Glk outcome is a new copy of the current Glk outcome:
	check that the Glk layers are in the post-call state or else fail at copying a Glk outcome before anything has been delegated;
	let the limit be the number of stack results from the Glk invocation just delegated;
	let the outcome be a memory allocation of the size in memory of a Glk outcome with limit stack results bytes converted to a Glk outcome;
	write the result the result of the Glk invocation just delegated to the outcome;
	write the stack result count limit to the outcome;
	repeat with the index running over the half-open interval from zero to the limit:
		write stack result number index of the Glk invocation just delegated to stack result number index of the outcome;
	decide on the outcome.

To delete (A - a Glk outcome):
	free the memory allocation at address A converted to a number.

Section "Private Glk Outcome Mutators" - unindexed

To write the result (X - a value) to (A - a Glk outcome): (- llo_setInt({A},{X}); -).

To write the stack result count (X - a number) to (A - a Glk outcome): (- llo_setField({A},1,{X}); -).

To write (X - a value) to stack result number (I - a number) of (A - a Glk outcome): (- llo_setField({A},2+{I},{X}); -).

Section "Public Glk Outcome Accessors"

To decide what number is the result of (A - a Glk outcome): (- llo_getInt({A}) -).

To decide what number is the stack result count of (A - a Glk outcome): (- llo_getField({A},1) -).

To decide what number is stack result number (I - a number) of (A - a Glk outcome): (- llo_getField({A},2+{I}) -).

Section "Glk Outcome Restoration"

To overwrite the current Glk outcome with (A - a Glk outcome):
	check that the Glk layers are in the post-call state or else fail at overwriting a Glk outcome before anything has been delegated;
	write the result the result of A to the Glk invocation just delegated;
	let the limit be the stack result count of A;
	write the stack result count limit to the Glk invocation just delegated;
	free the possibly zero-length memory allocation at address the stack results array address of the Glk invocation just delegated;
	let the new stack results array address be a possibly zero-length memory allocation of limit times four bytes;
	write the stack results array address new stack results array address to the Glk invocation just delegated;
	repeat with the index running over the half-open interval from zero to the limit:
		write stack result number index of A to stack result number index of the Glk invocation just delegated.

Chapter "Typestate"

Section "Typestate Initialization"

A GRIF setup rule (this is the begin Glk layers in the post-call state rule):
	write the stack result count zero to the Glk invocation just delegated;
	write the stack results array address the address for a zero-length allocation to the Glk invocation just delegated.

Section "Typestate Transitions" - unindexed

To move the Glk layers to the pre-call state:
	free the possibly zero-length memory allocation at address the stack results array address of the Glk invocation just delegated;
	write the stack results array address zero to the Glk invocation just delegated;
	write the function selector zero to the current Glk invocation;
	write the argument count zero to the current Glk invocation without reallocation;
	write the argument array address the address for a zero-length allocation to the current Glk invocation.

To move the Glk layers to the post-call state with (N - a number) stack results:
	free the possibly zero-length memory allocation at address the argument array address of the current Glk invocation;
	write the argument array address zero to the current Glk invocation;
	let the new stack results array address be a possibly zero-length memory allocation of N times four bytes;
	write the stack result count N to the Glk invocation just delegated;
	write the stack results array address new stack results array address to the Glk invocation just delegated.

Section "Typestate Checks" - unindexed

To decide whether the Glk layers are in the pre-call state: (- (llo_getInt(gi_glkArgumentPointer)&&(~~llo_getInt(gi_glkStackResultPointer))) -).
To decide whether the Glk layers are in the post-call state: (- ((~~llo_getInt(gi_glkArgumentPointer))&&llo_getInt(gi_glkStackResultPointer)) -).

Book "The Glk Layer System"

Chapter "Glk Layers"

Section "The Glk Layer Kind"

[A Glk layer is really an opaque pointer to a Glulx function, typically one extracted from a Closure_* array.]

A Glk layer is a kind of value.
A Glk layer is an invalid Glk layer.  [See the note in the book "Extension Information."]
The specification of a Glk layer is "A Glk interception layer is responsible for carrying out Glk I/O operations.  Two layers are predefined, one which hands Glk invocations over to the interpreter, and another, initially unused, which ignores Glk calls.  Extensions that meddle with Glk I/O do so by adding further layers between the story and the VM.  These layers might modify Glk invocations, redirect them, or clone them, or tamper with their results."

Section "Accessors"

To decide what number is the function address of (L - a Glk layer): (- {L} -).  [This is so layers don't fall into the broader case of sayable values, as introduced by Low-Level Operations.]

Chapter "Glk Layer Notifications"

A Glk layer notification is a kind of value.
The Glk layer notifications are Glk recovery needed and story yielding.
The specification of a Glk layer notification is "Glk layer notifications are sent to keep Glk layers informed of the story's activity.  In particular, layers that allocate windows or streams of their own need to recover them after an undo or restore, and layers introduced by debuggers want periodic chances to interrupt if the story enters an infinite loop."

Chapter "Invocation of Glk Layers" - unindexed

To invoke (L - a Glk layer): (- ({L})(); -).

Chapter "Layer Management"

Section "The Layer List" - unindexed

[Keys are layers, which handle Glk calls; values are routines that handle notifications sent to that layer.]

The Glk layer linked list is a linked list that varies.
The Glk layer linked list tail is a linked list tail that varies.

A GRIF setup rule (this is the clear Glk layers rule):
	now the Glk layer linked list is an empty linked list;
	now the Glk layer linked list tail is an empty linked list's tail.

Section "The Outermost Layer" - unindexed

Include (-
	Global gi_outermost=gi_realGlkLayer;
-) after "Definitions.i6t".

The outermost Glk layer is a Glk layer that varies.
The outermost Glk layer variable translates into I6 as "gi_outermost".

Section "The Real Glk Layer" - unindexed

Include (-
	! After passing through all of the instrumentation layers, surviving Glk invocations are handled here.
	! Transfer the arguments from storage to Glk, clean up the argument storage, invoke @glk, and store the results.
	[ gi_realGlkLayer selector array i limit element result;
		array=llo_getInt(gi_glkArgumentPointer);
		limit=llo_getInt(gi_glkArgumentCount);
		if(limit){
			! assert array
			! assert array~=llo_zeroLengthAllocationAddress
			for(i=limit:i--:){
				element=llo_getField(array,i);
				@copy element sp;
			}
			llo_free(array);
		}else{
			! assert array==llo_zeroLengthAllocationAddress
		}
		llo_setInt(gi_glkArgumentPointer,0);
		selector=llo_getInt(gi_glkRequest);
		@glk selector limit result;
		@stkcount limit;
		llo_setInt(gi_glkStackResultCount,limit);
		if(limit){
			array=llo_malloc(4*limit);
			llo_setInt(gi_glkStackResultPointer,array);
			for(i=0;i<limit:i++){
				@copy sp element;
				llo_setField(array,i,element);
			}
		}else{
			llo_setInt(gi_glkStackResultPointer,llo_zeroLengthAllocationAddress);
		}
		llo_setInt(gi_glkResult,result);
	];
-).

To decide what Glk layer is the real Glk layer: (- gi_realGlkLayer -).

Section "Installing Layers"

To install (P - a phrase nothing -> nothing) as a Glk layer whose notifications are handled by (H - a phrase Glk layer notification -> nothing) and let (V - a Glk layer variable) be the layer it should delegate to: (-
	{V}=gi_outermost;
	(+ the Glk layer linked list tail +)=(llo_getField((+ enqueuing a key and value in a linked list +),1))((+ the Glk layer linked list tail +),llo_getField({P},1),llo_getField({H},1));
	if(~~(+ the Glk layer linked list +)){
		(+ the Glk layer linked list +)=(+ the Glk layer linked list tail +);
	}
	gi_outermost=llo_getField({P},1);
-).

Section "Glk Recovery" - unindexed

To recover Glk interception (this is recovering Glk interception):
	now the outermost Glk layer is the real Glk layer;
	repeat with the linked list vertex running through the Glk layer linked list:
		call the function at address the number value of the linked list vertex passing Glk recovery needed;
		now the outermost Glk layer is the Glk layer key of the linked list vertex.

Section "CocoaGlk Workaround" - unindexed

[See Inform bug 819.]

The Glk layer after correcting key windows is a Glk layer that varies.

To correct key windows (this is correcting key windows):
	if the function selector of the current Glk invocation is 35 [glk_window_open]:
		ensure that the current Glk invocation has at least three arguments;
		let the split method be argument number one of the current Glk invocation;
		let the split size be argument number two of the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after correcting key windows;
		let the key window be the result of the Glk invocation just delegated;
		unless the key window is zero:
			let the outcome copy be a new copy of the current Glk outcome;
			prepare a spontaneous Glk invocation;
			write the function selector 41 [glk_window_get_parent] to the current Glk invocation;
			write the argument count one to the current Glk invocation;
			write the key window to argument number zero of the current Glk invocation;
			delegate the current Glk invocation to the Glk layer after correcting key windows;
			let the parent window be the result of the Glk invocation just delegated;
			unless the parent window is zero:
				prepare a spontaneous Glk invocation;
				write the function selector 38 [glk_window_set_arrangement] to the current Glk invocation;
				write the argument count four to the current Glk invocation;
				write the parent window to argument number zero of the current Glk invocation;
				write the split method to argument number one of the current Glk invocation;
				write the split size to argument number two of the current Glk invocation;
				write the key window to argument number three of the current Glk invocation;
				delegate the current Glk invocation to the Glk layer after correcting key windows;
			overwrite the current Glk outcome with the outcome copy;
			delete the outcome copy;
		stop;
	delegate the current Glk invocation to the Glk layer after correcting key windows.

Section "The Glk Layering Stage Rule"

A GRIF instrumented post-hijacking rule (this is the Glk layering stage rule):
	[begin CocoaGlk workaround]
	install correcting key windows as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after correcting key windows be the layer it should delegate to;
	[end CocoaGlk workaround]
	traverse the Glk layering rulebook;
	recover Glk interception.

Chapter "Layer Behaviors"

Section "Delegation"

To delegate the current Glk invocation to a do-nothing layer returning (N - a number) stack results:
	check that the Glk layers are in the pre-call state or else fail at delegating a Glk invocation twice;
	move the Glk layers to the post-call state with N stack results;
	write the result zero to the Glk invocation just delegated;
	repeat with the index running over the half-open interval from zero to N:
		write zero to stack result number index of the Glk invocation just delegated.

To delegate the current Glk invocation to (L - a Glk layer):
	check that the Glk layers are in the pre-call state or else fail at delegating a Glk invocation twice;
	invoke L;
	check that the Glk layers are in the post-call state or else fail at finding a delegation successful.

Section "Forking"

To prepare another Glk invocation from (A - a Glk invocation):
	check that the Glk layers are in the post-call state or else fail at finding a delegation successful;
	move the Glk layers to the pre-call state;
	write the function selector the function selector of A to the current Glk invocation;
	let the limit be the argument count of A;
	write the argument count limit to the current Glk invocation;
	repeat with the index running over the half-open interval from zero to the limit:
		write argument number index of A to argument number index of the current Glk invocation.

Chapter "Invoking the Layer System"

Section "Invoking the Layer System from Instrumentation" - unindexed

Include (-
	! Each @glk opcode is replaced with a @copy to store the selector, a call to this function, and a loop to unpack stack results.
	! Clean up the old results, if any, store the arguments, invoke the layers, and return the results.
	[ gi_glk _vararg_count array i element;
		array=llo_getInt(gi_glkStackResultPointer);
		! assert array
		if(array~=llo_zeroLengthAllocationAddress){
			llo_free(array);
		}
		llo_setInt(gi_glkStackResultPointer,0);
		llo_setInt(gi_glkArgumentCount,_vararg_count);
		if(_vararg_count){
			array=llo_malloc(4*_vararg_count);
			llo_setInt(gi_glkArgumentPointer,array);
			for(i=0:i<_vararg_count:++i){
				@copy sp element;
				llo_setField(array,i,element);
			}
		}else{
			llo_setInt(gi_glkArgumentPointer,llo_zeroLengthAllocationAddress);
		}
		gi_outermost();
		return llo_getInt(gi_glkResult);
	];
-).

To decide what number is the address of the Glk interceptor: (- gi_glk -).

Section "Otherwise Invoking the Layer System"

To prepare a spontaneous Glk invocation:
	check that the Glk layers are in the post-call state or else fail at finding a delegation successful;
	move the Glk layers to the pre-call state.

Book "Yielding"

To handle a yield (this is handling a yield):
	now the outermost Glk layer is the real Glk layer;
	repeat with the linked list vertex running through the Glk layer linked list:
		call the function at address the number value of the linked list vertex passing story yielding;
		now the outermost Glk layer is the Glk layer key of the linked list vertex;
	write the inter-yield delay to the yield countdown.

Book "Instrumentation"

Chapter "Globals" - unindexed

Include (-
	Array gi_yieldCountdown --> 1;
-).

To decide what number is the address of the yield countdown: (- gi_yieldCountdown -).

To decide what number is the yield countdown: (- llo_getInt(gi_yieldCountdown) -).
To write (X - a number) to the yield countdown: (- llo_setInt(gi_yieldCountdown,{X}); -).

Section "Initialization of Globals" - unindexed

A GRIF setup rule (this is the effectively disable the yield countdown rule):
	write -1 to the yield countdown.

A GRIF instrumented post-hijacking rule (this is the initialize the yield countdown rule):
	write the inter-yield delay to the yield countdown.

The initialize the yield countdown rule is listed after the Glk layering stage rule in the GRIF instrumented post-hijacking rulebook.

Chapter "Temporary Space" - unindexed

Include (-
	Array gi_glkStackResultIndex --> 1;
	Array gi_glkRollSize --> 1;
	Array gi_restoreResult --> 1;
-) after "Definitions.i6t".

To decide what number is where the remaining number of intercepted Glk stack results is temporarily saved: (- gi_glkStackResultIndex -).
To decide what number is where the stack depth added by Glk results is temporarily saved: (- gi_glkRollSize -).
To decide what number is where the result of a restore-like operation is temporarily saved: (- gi_restoreResult -).

Chapter "Instruction Vertices" - unindexed

[ @copy <P-in-mode-M> gi_glkRequest-->0; ]
To decide what instruction vertex is a new Glk selector-noting instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	decide on a new artificial instruction vertex for a copy with source mode M and source parameter P and destination mode zero-based-dereference addressing mode and destination parameter where the intercepted Glk function selector is temporarily saved.

[ @copy gi_glkStackResultCount-->0 gi_glkStackResultIndex-->0; ]
To decide what instruction vertex is a new Glk stack result loop initialization instruction vertex:
	decide on a new artificial instruction vertex for a copy with source mode zero-based-dereference addressing mode and source parameter where the number of intercepted Glk stack results is temporarily saved and destination mode zero-based-dereference addressing mode and destination parameter where the remaining number of intercepted Glk stack results is temporarily saved.

[ @jz gi_glkStackResultIndex-->0 <constant>; ]
To decide what instruction vertex is a new Glk stack result loop guard instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-jz to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the remaining number of intercepted Glk stack results is temporarily saved to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

[ @sub gi_glkStackResultIndex-->0 1 gi_glkStackResultIndex-->0; ]
To decide what instruction vertex is a new Glk stack result loop decrement instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-sub to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the remaining number of intercepted Glk stack results is temporarily saved to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write one to parameter one of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter two of the result;
	write where the remaining number of intercepted Glk stack results is temporarily saved to parameter two of the result;
	decide on the result.

[ @aload gi_glkStackResultPointer-->0 gi_glkStackResultIndex-->0 <stack>; ]
To decide what instruction vertex is a new Glk stack result transfer instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-aload to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the intercepted Glk stack results pointer is temporarily saved to parameter zero of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter one of the result;
	write where the remaining number of intercepted Glk stack results is temporarily saved to parameter one of the result;
	write the addressing mode stack addressing mode to parameter two of the result;
	decide on the result.

[ @jumpabs <constant>; ]
To decide what instruction vertex is a new Glk stack result loop jump instruction vertex:
	decide on a new artificial instruction vertex for an absolute jump with constant destination.

[ @add gi_glkStackResultCount-->0 1 gi_glkRollSize-->0; ]
To decide what instruction vertex is a new Glk stack result pre-roll instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-add to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the number of intercepted Glk stack results is temporarily saved to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write one to parameter one of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter two of the result;
	write where the stack depth added by Glk results is temporarily saved to parameter two of the result;
	decide on the result.

[ @stkroll gi_glkRollSize-->0 -1; ]
To decide what instruction vertex is a new Glk stack result rolling instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-stkroll to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the stack depth added by Glk results is temporarily saved to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write -1 to parameter one of the result;
	decide on the result.

[ @jne gi_restoreResult-->0 -1 <constant>; ]
To decide what instruction vertex is a new restore-result-testing instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-jne to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the result of a restore-like operation is temporarily saved to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write -1 to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

[ @callf <invocation-phrase> 0; ]
To decide what instruction vertex is a new Glk object recovery instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the function address of recovering Glk interception with return mode the zero-or-discard addressing mode.

[ @copy gi_restoreResult-->0 <P-in-mode-M>; ]
To decide what instruction vertex is a new restore-result-restoring instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	decide on a new artificial instruction vertex for a copy with source mode the zero-based-dereference addressing mode and source parameter where the result of a restore-like operation is temporarily saved and destination mode M and destination parameter P.

[ @sub gi_yieldCountdown-->0 1 gi_yieldCountdown-->0; ]
To decide what instruction vertex is a new yield-countdown-decrementing instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-sub to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write the address of the yield countdown to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write one to parameter one of the result;
	write the addressing mode zero-based-dereference addressing mode to parameter two of the result;
	write the address of the yield countdown to parameter two of the result;
	decide on the result.

[ @jz gi_yieldCountdown-->0 <constant>; ]
To decide what instruction vertex is a new yield branch instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-jz to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write the address of the yield countdown to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

To decide whether (V - an instruction vertex) is a yield branch instruction vertex:
	unless parameter zero of V is the address of the yield countdown:
		decide no;
	unless the operation code of V is op-jz:
		decide no;
	unless the addressing mode of parameter zero of V is the zero-based-dereference addressing mode:
		decide no;
	unless the addressing mode of parameter one of V is the constant addressing mode:
		decide no;
	decide yes.

[ @callf ((+ handling a yield +)-->1) 0; ]
To decide what instruction vertex is a new yield instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the function address of handling a yield with return mode zero-or-discard addressing mode.

Chapter "Instrumentation Data Structures" - unindexed

The yield point linked list is a linked list that varies.

Section "Setup Rules"

A GRIF setup rule (this is the clear the yield point linked list rule):
	now the yield point linked list is an empty linked list.

Chapter "Emendation Rules"

A GRIF emendation rule (this is the detect yield points rule):
	delete the yield point linked list;
	now the yield point linked list is an empty linked list;
	repeat with the instruction vertex running through occurrences of jump without call in the scratch space:
		unless the instruction vertex is artificial:
			if the jump link of the instruction vertex is null:
				let the parameter limit be the parameter limit of the instruction vertex;
				let the plain chunk mode be the addressing mode of parameter parameter limit of the instruction vertex;
				[ignore returns encoded as jumps]
				unless the plain chunk mode is the zero-or-discard addressing mode or the plain chunk mode is the constant addressing mode:
					push the key the instruction vertex onto the yield point linked list;
			otherwise:
				[ignore forward jumps]
				unless the source address of the jump link of the instruction vertex is greater than the source address of the instruction vertex:
					push the key the instruction vertex onto the yield point linked list;
	repeat with the instruction vertex running through occurrences of function call in the scratch space:
		unless the instruction vertex is artificial:
			[ignore forward calls]
			unless the addressing mode of parameter zero of the instruction vertex is the constant addressing mode and parameter zero of the instruction vertex is greater than the address of the chunk being instrumented:
				push the key the instruction vertex onto the yield point linked list;
	repeat with the instruction vertex running through occurrences of exception throw in the scratch space:
		unless the instruction vertex is artificial:
			push the key the instruction vertex onto the yield point linked list.

Chapter "Instrumentation Rules"

A GRIF instrumentation rule (this is the replace Glk invocations rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of the operation code op-glk in the scratch space:
		let the identifier mode be the addressing mode of parameter zero of the instruction vertex;
		let the identifier parameter be parameter zero of the instruction vertex;
		write the operation code op-call to the instruction vertex;
		write the addressing mode constant addressing mode to parameter zero of the instruction vertex;
		write the address of the Glk interceptor to parameter zero of the instruction vertex;
		let the Glk selector-noting instruction vertex be a new Glk selector-noting instruction vertex for mode identifier mode and parameter identifier parameter;
		insert the Glk selector-noting instruction vertex before the instruction vertex;
		if the addressing mode of parameter two of the instruction vertex is the stack addressing mode:
			let the Glk stack result rolling instruction vertex be a new Glk stack result rolling instruction vertex;
			insert the Glk stack result rolling instruction vertex after the instruction vertex;
			let the Glk stack result pre-roll instruction vertex be a new Glk stack result pre-roll instruction vertex;
			insert the Glk stack result pre-roll instruction vertex before the Glk stack result rolling instruction vertex;
		let the Glk stack result loop jump instruction vertex be a new Glk stack result loop jump instruction vertex;
		insert the Glk stack result loop jump instruction vertex after the instruction vertex;
		let the Glk stack result loop initialization instruction vertex be a new Glk stack result loop initialization instruction vertex;
		insert the Glk stack result loop initialization instruction vertex before the Glk stack result loop jump instruction vertex;
		let the Glk stack result loop guard instruction vertex be a new Glk stack result loop guard instruction vertex;
		insert the Glk stack result loop guard instruction vertex before the Glk stack result loop jump instruction vertex;
		let the Glk stack result loop decrement instruction vertex be a new Glk stack result loop decrement instruction vertex;
		insert the Glk stack result loop decrement instruction vertex before the Glk stack result loop jump instruction vertex;
		let the Glk stack result transfer instruction vertex be a new Glk stack result transfer instruction vertex;
		insert the Glk stack result transfer instruction vertex before the Glk stack result loop jump instruction vertex;
		establish a jump link from the Glk stack result loop guard instruction vertex to the next link of the Glk stack result loop jump instruction vertex;
		establish a jump link from the Glk stack result loop jump instruction vertex to the Glk stack result loop guard instruction vertex.

To note restores to (V - an instruction vertex) for Glk interception:
	let the store index be the parameter limit of V;
	let the result mode be the addressing mode of parameter the store index of V;
	let the result parameter be parameter the store index of V;
	write the addressing mode zero-based-dereference addressing mode to parameter the store index of V;
	write where the result of a restore-like operation is temporarily saved to parameter the store index of V;
	let the restore-result-restoring instruction vertex be a new restore-result-restoring instruction vertex for mode the result mode and parameter the result parameter;
	insert the restore-result-restoring instruction vertex after V;
	let the restore-result-testing instruction vertex be a new restore-result-testing instruction vertex;
	let the Glk object recovery instruction vertex be a new Glk object recovery instruction vertex;
	insert the restore-result-testing instruction vertex before the restore-result-restoring instruction vertex;
	insert the Glk object recovery instruction vertex before the restore-result-restoring instruction vertex;
	establish a jump link from the restore-result-testing instruction vertex to the restore-result-restoring instruction vertex.

A GRIF instrumentation rule (this is the note restores for Glk interception rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of the operation code op-save in the scratch space:
		note restores to the instruction vertex for Glk interception;
	repeat with the instruction vertex running through occurrences of the operation code op-saveundo in the scratch space:
		note restores to the instruction vertex for Glk interception.

The replace Glk invocations rule is listed last in the GRIF instrumentation rulebook.

A GRIF instrumentation rule (this is the insert yields rule):
	start a new generation of artificial vertices;
	while the yield point linked list is not empty:
		let the yield point be an instruction vertex key popped off of the yield point linked list;
		let the yield-countdown-decrementing instruction vertex be a new yield-countdown-decrementing instruction vertex;
		let the yield branch instruction vertex be a new yield branch instruction vertex;
		let the yield instruction vertex be a new yield instruction vertex;
		let the post-yield instruction vertex be a new artificial instruction vertex for an absolute jump with constant destination;
		insert the yield-countdown-decrementing instruction vertex before the yield point;
		insert the yield branch instruction vertex before the yield point;
		insert the yield instruction vertex at the end of the arrangement;
		insert the post-yield instruction vertex at the end of the arrangement;
		establish a jump link from the yield branch instruction vertex to the yield instruction vertex;
		establish a jump link from the post-yield instruction vertex to the yield point.

Chapter "Shielding"

A GRIF shielding rule (this is the shield the Glk interceptor and real layer rule):
	shield the address of the Glk interceptor against instrumentation;
	shield the real Glk layer against instrumentation.

A GRIF shielding rule (this is the shield yield-handling against instrumentation rule):
	shield handling a yield against instrumentation.

Glk Interception ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Glk Interception is a low-level framework for meddling with a story's input and
output (I/O).  Most interpreters provide an I/O library that conforms to the Glk
specification, and the story will normally communicate with this library
directly.  But with the phrases in this extension we can give an alternative
implementation, and it can make use of the old library internally.

Details are in the following chapters.

Chapter: Usage

Section: Background

This extension documentation assumes familiarity with the Glk specification,
which can be found at http://eblong.com/zarf/glk/.  Authors who use this
extension directly will also want an up-to-date list of the Glk function
selectors, which is available at
http://eblong.com/zarf/glk/glk-spec-073_12.html#s.1.6.

One important concept is not covered in the Glk documentation because it is
specific to Glulx: for some Glk functions it is legal to pass -1 as a pointer
argument, in which case the data structure that would be written at that address
is pushed onto the stack as a sequence of integers instead.  We refer to these
integers as "stack results", and number them from zero (for the first result
pushed) on up.

Section: Overview

Glk Interception thinks of a running story in layers: on the top layer is the
code written by the story author, at the bottom are the interpreter's Glk
functions, and in the middle are interception phrases.  Each middle layer sees
the layer below it as an implementation of the Glk specification, and each
middle layer provides a slightly different implementation to the code above it.

When a story begins executing, the middle section is empty, but Glk
Interception invokes the rules in

	the Glk layering rulebook

shortly after.  These rules install new layers just below the story, so rules
that run early on create layers nearer to the interpreter, and layers from later
rules end up closer to the story.

As long as the masquerading done in each layer conforms to the specification,
the layered model means that several unrelated debugging tools can use Glk
Interception and still coexist peacefully.  However, the ordering of layers is
significant.  Take for instance the extension Interactive Debugger, which will
show the story and the debugging interface in separate windows when it can, and
Floyd Mode, which emulates a command-line interpreter.  If the layer from
Interactive Debugger is placed below, there is no problem, but if it appears
above, Floyd Mode will prevent even the debugger from using multiple windows.

Section: Building a layer

When we build a layer, we write at least three pieces of code: the layer itself,
a variable where it can keep track of the layer below it, and a layering rule to
place it between the story and the interpreter.  A typical setup looks like this
(using the word "after" instead of "below" to keep from confusing Inform):

	The Glk layer after transliterating I/O to and from Greek is a Glk layer that varies.
	
	To transliterate I/O to and from Greek (this is transliterating I/O to and from Greek):
		....
	
	A Glk layering rule (this is the transliterate I/O to and from Greek rule):
		install transliterating I/O to and from Greek as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after transliterating I/O to and from Greek be the layer it should delegate to.

Besides the three parts, we can already see the phrase that ties them together:

	install (P - a phrase nothing -> nothing) as a Glk layer whose notifications are handled by (H - a phrase Glk layer notification -> nothing) and let (V - a Glk layer variable) be the layer it should delegate to

As mentioned before, this puts P just below the story.  Whichever layer
previously occupied that position---the one moved underneath P---is saved in V
for the phrase's later use.  The phrase H is for layers that want to receive
notifications about the story's activity.  In particular, layers that allocate
windows or streams of their own need to recover them after an undo or restore,
and layers introduced by debuggers want periodic chances to interrupt if the
story enters an infinite loop.  Layers without these interests should use the
default value of phrase Glk layer notification -> nothing.

Section: Communication between layers

When one layer receives a Glk invocation from another, that invocation is passed
under the name

	the current Glk invocation

Similarly, after an invocation has been processed, and the upper layer receives a
response from the lower one, the invocation is called

	the Glk invocation just delegated

Only one of these two names can be valid at any given time, and only the
built-in layers can make the latter valid.  Consequently, for a non-built-in
layer to produce a result, it must delegate the current Glk invocation to
another layer.  The relevant phrase is

	delegate the current Glk invocation to (L - a Glk layer)

where L must be lower, and is usually the layer immediately below.

But sometimes we want to prevent a call from reaching the interpreter.  For this
purpose Glk Interception includes the concept of a "do-nothing" layer.
Do-nothing layers consume an invocation and return a response, but don't
actually perform I/O, and any results are set to zero.  Delegation to a
do-nothing layer looks like this:

	delegate the current Glk invocation to a do-nothing layer returning (N - a number) stack results

Glk Interception will not compute the number of stack results on its own because
the rules for this computation are bound to change as Glk functions are added
and removed.  A layer that uses this phrase, on the other hand, should at least
know about the Glk functions it is suppressing, even if it cannot know about all
of the other functions.

Another possibility is that we want to translate one invocation into several.
In that case we have the phrase

	prepare a spontaneous Glk invocation

This phrase throws away the Glk invocation just delegated (implying that it can
only be used when "the Glk invocation just delegated" exists) and makes a new
Glk invocation the current one.  That invocation is initially filled with junk
values; it is our responsibility to overwrite them with sensible data.

Alternatively, if we had requested

	a new copy of the current Glk invocation

earlier on and stowed it in a variable, then we could use the phrase

	prepare another Glk invocation from (A - a Glk invocation)

The effect is the same, but the current invocation will be filled with the old
values, not junk.  To throw away an invocation and prepare another one from a
copy, all in one phrase, we may write

	overwrite the current Glk invocation with (A - a Glk invocation)

If we do copy invocations, we should delete them when we they are no longer
needed:

	delete (A - a Glk invocation)

It is also possible to save the results of one invocation and then restore them
once other invocations have been delegated.  The syntax is similar.  We request

	a new copy of the current Glk outcome

and then later

	overwrite the current Glk outcome with (A - a Glk outcome)

remembering to use the phrase

	delete (A - a Glk outcome)

when we are done with an outcome.

Remember that the story itself is a layer.  It is perfectly legal for story
code, instead of using the @glk opcode, to prepare an invocation, delegate it to
a layer of choice, and then read off the results.  But it is not legal for a
middle layer to use the @glk opcode, even indirectly; the @glk opcode delegates
to the layer just below the story, which cannot possibly be lower than the layer
that is running.

Section: The current Glk invocation

The Glk function being called is identified by its function selector, which we
can access as

	the function selector of the current Glk invocation

and modify with

	write the function selector (X - a number) to the current Glk invocation

The arguments are counted by

	the argument count of the current Glk invocation

and we can change the number of arguments with

	write the argument count (N - a number) to the current Glk invocation

Also, the phrase

	ensure that the current Glk invocation has at least (N - a number) argument/arguments

is shorthand for checking the argument count and increasing it if it is less
than N.

The arguments themselves are requested as

	argument number (I - a number) of the current Glk invocation

where arguments are numbered from zero, so I must be less than the argument
count.  Similarly, arguments can be altered:

	write (X - a value) to argument number (I - a number) of the current Glk invocation

Note that Glk Interception does not know the kinds for arguments, and they are
treated as numbers.  If necessary, the extension Low-Level Operations has a
phrase for converting between kinds.

Section: The Glk invocation just delegated

The return value from a Glk invocation is available as

	the result of the Glk invocation just delegated

We can overwrite it with the phrase

	write the result (X - a value) to the Glk invocation just delegated

We can also count the number of stack results:

	the number of stack results from the Glk invocation just delegated

read them:

	stack result number (I - a number) of the Glk invocation just delegated

or overwrite them:

	write (X - a value) to stack result number (I - a number) of the Glk invocation just delegated

Ordinarily it is not sensible to change the number of stack results, so no such
phrase is provided.  If we really need this behavior, we can send a spontaneous
invocation to a do-nothing layer and then overwrite its results.

Section: Stored invocations

All of the phrases for extracting data from the current Glk invocation also
apply to stored invocations:

	the function selector of (A - a Glk invocation)

	the argument count of (A - a Glk invocation)

and

	argument number (I - a number) of (A - a Glk invocation)

Section: Stored outcomes

The phrases for reading data out of Glk outcomes are similar:

	the result of (A - a Glk outcome)

	the stack result count of (A - a Glk outcome)

and

	stack result number (I - a number) of (A - a Glk outcome)

Section: Notifications

Glk Interception delivers notifications about the story's activity to all
layers, starting with the layer at the bottom and proceeding to the layer at the
top.  The notifications have the kind

	A glk layer notification

which currently comprises two values.  The first,

	Glk recovery needed

is sent as soon as all layers have been installed, and also after successful
restore and undo operations, in case the story state and Glk state have become
inconsistent.  During the time that the notification handler is running, the
@glk opcode is mapped to the layer immediately below, so that the recovery
phrase can use normal Glk functions, in the style of Inform's GGRecoverObjects
routine.

Glk Interception also keeps a counter that roughly gauges the amount of
computation a story has completed, and every time this counter reaches a
threshold, the second notification value,

	story yielding

is sent, and the counter resets.  Layers that need to be responsive even if the
story isn't should treat such notifications as cues to check for I/O.  As with
recovery, the @glk opcode is mapped to the layer immediately below for the
duration of the handler call.

The default interval between story yields is 1600 ticks of the counter, which
corresponds to approximately one sparsely implemented turn.  It can be
lenghtened with a use option.  For instance, writing

	Use an inter-yield delay of at least 3200.

would double the interval.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Glk Interception is subject to the caveats for the Glulx Runtime Instrumentation
Framework; see the requirements chapter in its documentation for the technical
details.

The current version creates and installs one layer automatically, which works
around a bug in CocoaGlk (see http://inform7.com/mantis/view.php?id=819).
Consequently, the extension will break any code that depends on the buggy
behavior.

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

Glk Interception was prepared as part of the Glulx Runtime Instrumentation
Project (https://github.com/i7/i7grip).  For this first edition of the project,
special thanks go to these people, in chronological order:

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

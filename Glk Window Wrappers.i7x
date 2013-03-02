Version 1 of Glk Window Wrappers (for Glulx only) by Brady Garvin begins here.

"Facilities for adding Glk windows around story content regardless of the story's windowing code."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Glk Interception by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2012 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[Nothing to mention here in the present version.]

Chapter "Use Options"

Use a resource hash table size of at least 23 translates as (- Constant GWW_RESOURCE_HASH_SIZE={N}; -).

To decide what number is the resource hash table size: (- GWW_RESOURCE_HASH_SIZE -).

Use a wrapped window state preallocation of at least 32 translates as (- Constant GWW_WINDOW_STATE_PREALLOC={N}; -).
Use a wrapped stream state preallocation of at least 64 translates as (- Constant GWW_STREAM_STATE_PREALLOC={N}; -).

To decide what number is the wrapped window state preallocation: (- GWW_WINDOW_STATE_PREALLOC -).
To decide what number is the wrapped stream state preallocation: (- GWW_STREAM_STATE_PREALLOC -).

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at finding a window state for the window (W - a wrapped window):
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]I needed the state of the window [W converted to a number in hexadecimal], but I could not find it anywhere in my bookkeeping.[terminating the story]".

To fail at finding a stream state for the stream (S - a wrapped stream):
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]I needed the state of the stream [S converted to a number in hexadecimal], but I could not find it anywhere in my bookkeeping.[terminating the story]".

To fail at preserving the relationship invariants on window states:
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]I found an inconsistency in my bookkeeping where the parent entry under one window and a child entry under another plainly contradict each other.  Either the data is corrupted or I've lost track of something.[terminating the story]".

To fail at giving a parent window three children:
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]While recovering Glk window information I found three window that share a parent.  But Glk parent windows always have two children, so something in my bookkeeping has gone quite wrong.[terminating the story]".

To fail at opening a root window twice in a single-window environment:
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]The story asked me to open a two root windows.  That could either be a bug in the story or fallout from the story opening a root window with the rock 1735882496 (ASCII 'gww\0') in a single-window environment and then trying to recover it.  Either way, I'm not able to fulfill the request.[terminating the story]".

To fail at discovering multiple windows in a single-window environment:
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]My previous assessment, by trying to open multiple windows, was that the Glk layer below is running a single-window environment.  But now I find the story referring to multiple, distinct windows, so I must be confused.[terminating the story]".

To fail at opening any windows:
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]I was not able to open any windows.  Unfortunately, it's unlikely you cannot see this error message, but if you can, then that is evidence that something is doubly wrong.[terminating the story]".

To fail at filling in for the frame window when multiple windows are not supported and there is already a conflicting window:
	say "[low-level runtime failure in]Glk Window Wrappers[with explanation]I found that the Glk layer below only supports a single window, so I needed that single window to fill in for the frame window.  But there was already a single window allocated, and not one previously created for that purpose.[terminating the story]".

Book "Glk Structures and Opaque Objects"

Chapter "Wrapped Windows"

Section "The Wrapped Window Kind"

A wrapped window is a kind of value.
A wrapped window is an invalid wrapped window.  [See the note in the book "Extension Information."]
The specification of a wrapped window is "Wrapped windows represent Glk window handles specifically for the extension Glk Window Wrappers.  Most other code would want to interact with handles in some other way, for instance via Jon Ingold's extension Flexible Windows."

Section "Wrapped Window Constants"

To decide what wrapped window is a null wrapped window: (- 0 -).

Section "Wrapped Window Adjectives"

Definition: a wrapped window is null if it is a null wrapped window.

Chapter "Wrapped Streams"

Section "The Wrapped Stream Kind"

A wrapped stream is a kind of value.
A wrapped stream is an invalid wrapped stream.  [See the note in the book "Extension Information."]
The specification of a wrapped stream is "Wrapped streams represent Glk stream handles specifically for the extension Glk Window Wrappers.  Most other code would want to interact with handles in some other way."

Section "Wrapped Stream Constants"

To decide what wrapped stream is a null wrapped stream: (- 0 -).

Section "Wrapped Stream Adjectives"

Definition: a wrapped stream is null if it is a null wrapped stream.

Chapter "Event Types"

To decide what number is the null event type: (- evtype_None -).
To decide what number is the timer event type: (- evtype_Timer -).
To decide what number is the character input event type: (- evtype_CharInput -).
To decide what number is the line input event type: (- evtype_LineInput -).
To decide what number is the mouse input event type: (- evtype_MouseInput -).
To decide what number is the window arrangement event type: (- evtype_Arrange -).
To decide what number is the redraw event type: (- evtype_Redraw -).
To decide what number is the sound notification event type: (- evtype_SoundNotify -).
To decide what number is the hyperlink event type: (- evtype_Hyperlink -).

Chapter "Wrapped Events"

Section "The Wrapped Event Kind"

A wrapped event is a kind of value.
A wrapped event is an invalid wrapped event.  [See the note in the book "Extension Information."]
The specification of a wrapped event is "Wrapped events represent Glk event notifications specifically for the extension Glk Wrapped Windows.  Most other code would want to interact with the Glk library in some other way, for instance via Emily Short's extension Glulx Entry Points."

Section "Wrapped Event Constants"

To decide what wrapped event is an on-the-stack wrapped event: (- (-1) -).

Section "Wrapped Event Adjectives"

Definition: a wrapped event is on the stack if it is an on-the-stack wrapped event.
Definition: a wrapped event is internally-spawned if the event type of it is not the character input event type and the event type of it is not the line input event type and the event type of it is not the mouse input event type and the event type of it is not the hyperlink event type.

Section "The Wrapped Event Structure" - unindexed

[Layout:
	4 bytes for the event type
	4 bytes for the source window
	4 bytes for the first associated value
	4 bytes for the second associated value]

To decide what number is the size in memory of a wrapped event: (- 16 -).

Section "Wrapped Event Construction"

To decide what wrapped event is a new permanent wrapped event:
	decide on a permanent memory allocation of the size in memory of a wrapped event bytes converted to a wrapped event.

To decide what wrapped event is a new wrapped event:
	decide on a memory allocation of the size in memory of a wrapped event bytes converted to a wrapped event.

To delete (A - a wrapped event):
	free the memory allocation at address A converted to a number.

Section "Copying Wrapped Events"

To copy (A - a wrapped event) to (B - a wrapped event):
	copy the size in memory of a wrapped event bytes from address (A converted to a number) to address (B converted to a number).

To copy (A - a wrapped event) to the four stack results beginning with stack result number (I - a number) of the Glk invocation just delegated:
	write the event type of A to stack result number I of the Glk invocation just delegated;
	write (the source window of A converted to a number) to stack result number I plus one of the Glk invocation just delegated;
	write the first associated value of A to stack result number I plus two of the Glk invocation just delegated;
	write the second associated value of A to stack result number I plus three of the Glk invocation just delegated.

To copy the four stack results beginning with stack result number (I - a number) of the Glk invocation just delegated to (B - a wrapped event):
	write the event type stack result number I of the Glk invocation just delegated to B;
	write the source window (stack result number I plus one of the Glk invocation just delegated converted to a wrapped window) to B;
	write the first associated value stack result number I plus two of the Glk invocation just delegated to B;
	write the second associated value stack result number I plus three of the Glk invocation just delegated to B.

Section "Wrapped Event Accessors and Mutators"

To decide what number is the event type of (A - a wrapped event): (- llo_getInt({A}) -).
To write the event type (X - a number) to (A - a wrapped event): (- llo_setInt({A},{X}); -).

To decide what wrapped window is the source window of (A - a wrapped event): (- llo_getField({A},1) -).
To write the source window (X - a wrapped window) to (A - a wrapped event): (- llo_setField({A},1,{X}); -).

To decide what number is the first associated value of (A - a wrapped event): (- llo_getField({A},2) -).
To write the first associated value (X - a number) to (A - a wrapped event): (- llo_setField({A},2,{X}); -).

To decide what number is the second associated value of (A - a wrapped event): (- llo_getField({A},3) -).
To write the second associated value (X - a number) to (A - a wrapped event): (- llo_setField({A},3,{X}); -).

Book "State Data Structures"

Chapter "Wrapped Window States"

Section "The Wrapped Window State Kind" - unindexed

A wrapped window state is a kind of value.
A wrapped window state is an invalid wrapped window state.  [See the note in the book "Extension Information."]
The specification of a wrapped window state is "Wrapped window states represent the relationships between story windows.  The extension Glk Window Wrappers tracks these relationships to simplify its code."

Section "The Wrapped Window State Structure" - unindexed

[Layout:
	4 bytes for the window
	4 bytes for the parent
	4 bytes for the first child
	4 bytes for the second child
	4 bytes for the last-seen character input request (the glk function selector used to make the request, zero for none)
	4 bytes for the last-seen line input request (ditto)
	4 bytes for the last-seen line buffer address
	4 bytes for the last-seen line buffer length (in bytes, not characters)
	4 bytes for the last-seen initial line buffer content address
	4 bytes for the last-seen initial line buffer content length (in bytes, not characters)
	4 bytes for the last-seen mouse input request (the glk function selector used to make the request, zero for none)
	4 bytes for the last-seen hyperlink input request (ditto)
	4 bytes for the occupancy count]

To decide what number is the size in memory of a wrapped window state: (- 52 -).

Section "Wrapped Window State Construction and Destruction" - unindexed

The wrapped window state object pool is an object pool that varies.

A GRIF setup rule (this is the allocate an object pool for wrapped window states rule):
	now the wrapped window state object pool is a new permanent object pool with the wrapped window state preallocation objects of size the size in memory of a wrapped window state bytes.

To decide what wrapped window state is a new wrapped window state for (W - a wrapped window):
	let the result be a memory allocation from the wrapped window state object pool converted to a wrapped window state;
	zero the size in memory of a wrapped window state bytes at address result converted to a number;
	write the window W to the result;
	decide on the result.

To delete (A - a wrapped window state):
	let the initial line buffer content address be the last-seen initial line buffer content address of A;
	if the initial line buffer content address is not zero:
		free the possibly zero-length memory allocation at address initial line buffer content address;
	free the memory allocation at address (A converted to a number) to the wrapped window state object pool.

Section "Wrapped Window State Accessors and Mutators" - unindexed

To decide what wrapped window is the window of (A - a wrapped window state): (- llo_getInt({A}) -).
To write the window (X - a wrapped window) to (A - a wrapped window state): (- llo_setInt({A},{X}); -).

To decide what wrapped window is the parent of (A - a wrapped window state): (- llo_getField({A},1) -).
To write the parent (X - a wrapped window) to (A - a wrapped window state): (- llo_setField({A},1,{X}); -).

To decide what wrapped window is the first child of (A - a wrapped window state): (- llo_getField({A},2) -).
To write the first child (X - a wrapped window) to (A - a wrapped window state): (- llo_setField({A},2,{X}); -).

To decide what wrapped window is the second child of (A - a wrapped window state): (- llo_getField({A},3) -).
To write the second child (X - a wrapped window) to (A - a wrapped window state): (- llo_setField({A},3,{X}); -).

To decide what number is the last-seen character input request of (A - a wrapped window state): (- llo_getField({A},4) -).
To write the last-seen character input request (X - a number) to (A - a wrapped window state): (- llo_setField({A},4,{X}); -).

To decide what number is the last-seen line input request of (A - a wrapped window state): (- llo_getField({A},5) -).
To write the last-seen line input request (X - a number) to (A - a wrapped window state): (- llo_setField({A},5,{X}); -).

To decide what number is the last-seen line buffer address of (A - a wrapped window state): (- llo_getField({A},6) -).
To write the last-seen line buffer address (X - a number) to (A - a wrapped window state): (- llo_setField({A},6,{X}); -).

To decide what number is the last-seen line buffer length of (A - a wrapped window state): (- llo_getField({A},7) -).
To write the last-seen line buffer length (X - a number) to (A - a wrapped window state): (- llo_setField({A},7,{X}); -).

To decide what number is the last-seen initial line buffer content address of (A - a wrapped window state): (- llo_getField({A},8) -).
To write the last-seen initial line buffer content address (X - a number) to (A - a wrapped window state): (- llo_setField({A},8,{X}); -).

To decide what number is the last-seen initial line buffer content length of (A - a wrapped window state): (- llo_getField({A},9) -).
To write the last-seen initial line buffer content length (X - a number) to (A - a wrapped window state): (- llo_setField({A},9,{X}); -).

To decide what number is the last-seen mouse input request of (A - a wrapped window state): (- llo_getField({A},10) -).
To write the last-seen mouse input request (X - a number) to (A - a wrapped window state): (- llo_setField({A},10,{X}); -).

To decide what number is the last-seen hyperlink input request of (A - a wrapped window state): (- llo_getField({A},11) -).
To write the last-seen hyperlink input request (X - a number) to (A - a wrapped window state): (- llo_setField({A},11,{X}); -).

To decide whether (A - a wrapped window state) is occupied: (- llo_getField({A},12) -).
To occupy (A - a wrapped window state): (- llo_setField({A},12,llo_getField({A},12)+1); -).
To vacate (A - a wrapped window state): (- llo_setField({A},12,llo_getField({A},12)-1); -).

Chapter "Wrapped Stream States"

Section "The Wrapped Stream State Kind" - unindexed

A wrapped stream state is a kind of value.
A wrapped stream state is an invalid wrapped stream state.  [See the note in the book "Extension Information."]
The specification of a wrapped stream state is "Wrapped stream states represent the stream information that the extension Glk Stream Wrappers must track to prevent formatting anomalies."

Section "The Wrapped Stream State Structure" - unindexed

[Layout:
	4 bytes for the stream
	4 bytes for the echo stream
	4 bytes for the last-seen style
	4 bytes for the occupancy count]

To decide what number is the size in memory of a wrapped stream state: (- 16 -).

Section "Wrapped Stream State Construction and Destruction" - unindexed

The wrapped stream state object pool is an object pool that varies.

A GRIF setup rule (this is the allocate an object pool for wrapped stream states rule):
	now the wrapped stream state object pool is a new permanent object pool with the wrapped stream state preallocation objects of size the size in memory of a wrapped stream state bytes.

To decide what wrapped stream state is a new wrapped stream state for (S - a wrapped stream):
	let the result be a memory allocation from the wrapped stream state object pool converted to a wrapped stream state;
	zero the size in memory of a wrapped stream state bytes at address result converted to a number;
	write the stream S to the result;
	decide on the result.

To delete (A - a wrapped stream state):
	free the memory allocation at address (A converted to a number) to the wrapped stream state object pool.

Section "Wrapped Stream State Accessors and Mutators" - unindexed

To decide what wrapped stream is the stream of (A - a wrapped stream state): (- llo_getInt({A}) -).
To write the stream (X - a wrapped stream) to (A - a wrapped stream state): (- llo_setInt({A},{X}); -).

To decide what wrapped stream is the echo stream of (A - a wrapped stream state): (- llo_getField({A},1) -).
To write the echo stream (X - a wrapped stream) to (A - a wrapped stream state): (- llo_setField({A},1,{X}); -).

To decide what number is the last-seen style of (A - a wrapped stream state): (- llo_getField({A},2) -).
To write the last-seen style (X - a number) to (A - a wrapped stream state): (- llo_setField({A},2,{X}); -).

To decide whether (A - a wrapped stream state) is occupied: (- llo_getField({A},3) -).
To occupy (A - a wrapped stream state): (- llo_setField({A},3,llo_getField({A},3)+1); -).
To vacate (A - a wrapped stream state): (- llo_setField({A},3,llo_getField({A},3)-1); -).

Book "Wrapping Framework"

Chapter "Event Routing Decisions"

An event routing decision is a kind of value.
The event routing decisions are routing the event normally and routing the event no further.
The specification of an event routing decision is "Wrapping layers use the event routing decisions returned by their foreign event handlers to decide whether ambiguously destined events should be sent to the wrapped event handler or not.  At the time of writing only two kinds of events could be unclear about whether they were meant for the wrapping or the wrapped code: timer events and sound notification events."

Chapter "Wrapping Layers"

Section "The Wrapping Layer Kind"

A wrapping layer is a kind of value.
A wrapping layer is an invalid wrapping layer.  [See the note in the book "Extension Information."]
The specification of a wrapping layer is "Wrapping layers represent the Glk interception layers used by the extension Glk Window Wrappers, as well as their associated data.  Most other code would want to interact with Glk layers directly, via the extension Glk Interception."

Section "The Wrapping Layer Structure" - unindexed

[Layout:
	4 bytes for the layer after this one
	4 bytes for the window hash table
	4 bytes for the stream hash table
	4 bytes for the frame window
	4 bytes for the deferred event linked list
	4 bytes for the deferred event linked list tail
	4 bytes for the foreign event handler
	4 bytes for the multiple windows supported flag]

To decide what number is the size in memory of a wrapping layer: (- 32 -).

Section "Wrapping Layer Construction" - unindexed

To decide what wrapping layer is a new permanent wrapping layer followed by (L - a Glk layer) with foreign events handled by (H - a phrase wrapped event -> event routing decision) (this is constructing a permanent wrapping layer):
	let the result be a permanent memory allocation of the size in memory of a wrapping layer bytes converted to a wrapping layer;
	zero the size in memory of a wrapping layer bytes at address result converted to a number;
	write L as the Glk layer after the result;
	let the window hash table be a new hash table with the resource hash table size buckets;
	write the window hash table the window hash table to the result;
	let the stream hash table be a new hash table with the resource hash table size buckets;
	write the stream hash table the stream hash table to the result;
	write the foreign event handler H to the result;
	decide on the result.

Section "Private Wrapping Layer Accessors and Mutators" - unindexed

To write (X - a Glk layer) as the Glk layer after (A - a wrapping layer): (- llo_setInt({A},{X}); -).

To decide what hash table is the window hash table of (A - a wrapping layer): (- llo_getField({A},1) -).
To write the window hash table (X - a hash table) to (A - a wrapping layer): (- llo_setField({A},1,{X}); -).

To decide what hash table is the stream hash table of (A - a wrapping layer): (- llo_getField({A},2) -).
To write the stream hash table (X - a hash table) to (A - a wrapping layer): (- llo_setField({A},2,{X}); -).

To decide what linked list is the deferred event linked list of (A - a wrapping layer): (- ({A}-->4) -).
To write the deferred event linked list (X - a linked list) to (A - a wrapping layer): (- llo_setField({A},4,{X}); -).

To decide what linked list tail is the deferred event linked list tail of (A - a wrapping layer): (- ({A}-->5) -).
To write the deferred event linked list tail (X - a linked list tail) to (A - a wrapping layer): (- llo_setField({A},5,{X}); -).

To decide what phrase wrapped event -> event routing decision is the foreign event handler of (A - a wrapping layer): (- llo_getField({A},6) -).
To write the foreign event handler (X - a phrase wrapped event -> event routing decision) to (A - a wrapping layer): (- llo_setField({A},6,{X}); -).

To reset the multiple windows supported flag in (A - a wrapping layer): (- llo_setField({A},7,0); -).
To set the multiple windows supported flag in (A - a wrapping layer): (- llo_setField({A},7,1); -).

To decide what wrapped window state is the window state for (W - a wrapped window) in (A - a wrapping layer):
	decide on the first wrapped window state value matching the key W in the window hash table of A or an invalid wrapped window state if there are no matches.

To decide what wrapped stream state is the stream state for (S - a wrapped stream) in (A - a wrapping layer):
	decide on the first wrapped stream state value matching the key S in the stream hash table of A or an invalid wrapped stream state if there are no matches.

To decide what wrapped window state is the legal window state for (W - a wrapped window) in (A - a wrapping layer) (this is finding a legal window state according to a wrapping layer):
	let the result be the first wrapped window state value matching the key W in the window hash table of A or an invalid wrapped window state if there are no matches;
	always check that the result is not an invalid wrapped window state or else fail at finding a window state for the window W;
	decide on the result.

To decide what wrapped stream state is the legal stream state for (S - a wrapped stream) in (A - a wrapping layer) (this is finding a legal stream state according to a wrapping layer):
	let the result be the first wrapped stream state value matching the key S in the stream hash table of A or an invalid wrapped stream state if there are no matches;
	always check that the result is not an invalid wrapped stream state or else fail at finding a stream state for the stream S;
	decide on the result.

To delete (S - a wrapped stream) from (A - a wrapping layer):
	unless S is null:
		let the stream state be the legal stream state for S in A;
		remove the first occurrence of the key S from the stream hash table of A;
		delete the stream state.

Section "Public Wrapping Layer Accessors and Mutators"

To decide what Glk layer is the Glk layer after (A - a wrapping layer): (- llo_getInt({A}) -).

To decide whether the multiple windows supported flag is set in (A - a wrapping layer): (- llo_getField({A},7) -).

To decide what wrapped window is the parent of (W - a wrapped window) according to (A - a wrapping layer):
	let the window state be the window state for W in A;
	if the window state is an invalid wrapped window state:
		decide on a null wrapped window;
	decide on the parent of the window state.

To decide what wrapped window is the first child of (W - a wrapped window) according to (A - a wrapping layer):
	let the window state be the window state for W in A;
	if the window state is an invalid wrapped window state:
		decide on a null wrapped window;
	decide on the first child of the window state.

To decide what wrapped window is the second child of (W - a wrapped window) according to (A - a wrapping layer):
	let the window state be the window state for W in A;
	if the window state is an invalid wrapped window state:
		decide on a null wrapped window;
	decide on the second child of the window state.

To decide what wrapped window is the frame window of (A - a wrapping layer): (- llo_getField({A},3) -).
To write the frame window (X - an wrapped window) to (A - a wrapping layer): (- llo_setField({A},3,{X}); -).

To delete (W - a wrapped window) from (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	unless W is null:
		let the window hash table be the window hash table of A;
		let the window state be the legal window state for W in A;
		remove the first occurrence of the key W from the window hash table;
		delete the window state;
		let the stream be the window stream of W according to the next layer;
		delete the stream from A.

To enqueue (E - a wrapped event) as a deferred event for (A - a wrapping layer):
	let the deferred event be a new wrapped event;
	copy E to the deferred event;
	enqueue the key the deferred event in the deferred event linked list of A through the deferred event linked list tail of A.

Chapter "Dispatch Utilities" - unindexed

To decide what number is the result of Glk function number (F - a number) according to (L - a Glk layer):
	let the invocation copy be an invalid Glk invocation;
	let the outcome copy be an invalid Glk outcome;
	if the Glk layers are in the pre-call state:
		now the invocation copy is a new copy of the current Glk invocation;
	otherwise:
		now the outcome copy is a new copy of the current Glk outcome;
		prepare a spontaneous Glk invocation;
	write the function selector F to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to L;
	let the result be the result of the Glk invocation just delegated;
	if the invocation copy is not an invalid Glk invocation:
		prepare another Glk invocation from the invocation copy;
		delete the invocation copy;
	otherwise:
		overwrite the current Glk outcome with the outcome copy;
		delete the outcome copy;
	decide on the result.

To decide what number is the result of Glk function number (F - a number) applied to (V - a value) according to (L - a Glk layer):
	let the invocation copy be an invalid Glk invocation;
	let the outcome copy be an invalid Glk outcome;
	if the Glk layers are in the pre-call state:
		now the invocation copy is a new copy of the current Glk invocation;
	otherwise:
		now the outcome copy is a new copy of the current Glk outcome;
		prepare a spontaneous Glk invocation;
	write the function selector F to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write V to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L;
	let the result be the result of the Glk invocation just delegated;
	if the invocation copy is not an invalid Glk invocation:
		prepare another Glk invocation from the invocation copy;
		delete the invocation copy;
	otherwise:
		overwrite the current Glk outcome with the outcome copy;
		delete the outcome copy;
	decide on the result.

To decide what number is the result of Glk function number (F - a number) applied to (U - a value) and (V - a value) according to (L - a Glk layer):
	let the invocation copy be an invalid Glk invocation;
	let the outcome copy be an invalid Glk outcome;
	if the Glk layers are in the pre-call state:
		now the invocation copy is a new copy of the current Glk invocation;
	otherwise:
		now the outcome copy is a new copy of the current Glk outcome;
		prepare a spontaneous Glk invocation;
	write the function selector F to the current Glk invocation;
	write the argument count two to the current Glk invocation;
	write U to argument number zero of the current Glk invocation;
	write V to argument number one of the current Glk invocation;
	delegate the current Glk invocation to L;
	let the result be the result of the Glk invocation just delegated;
	if the invocation copy is not an invalid Glk invocation:
		prepare another Glk invocation from the invocation copy;
		delete the invocation copy;
	otherwise:
		overwrite the current Glk outcome with the outcome copy;
		delete the outcome copy;
	decide on the result.

Chapter "Window Management"

Section "Dispatch Utilities for Window Management" - unindexed

To decide what wrapped window is the root according to (L - a Glk layer):
	let the result be the result of Glk function number 34 [glk_window_get_root] according to L;
	decide on the result converted to a wrapped window.

To decide what wrapped window is the parent of (W - a wrapped window) according to (L - a Glk layer):
	let the result be the result of Glk function number 41 [glk_window_get_parent] applied to W according to L;
	decide on the result converted to a wrapped window.

To decide what wrapped stream is the window stream of (W - a wrapped window) according to (L - a Glk layer):
	let the result be the result of Glk function number 44 [glk_window_get_stream] applied to W according to L;
	decide on the result converted to a wrapped stream.

To decide what wrapped stream is the echo stream of the window (W - a wrapped window) according to (L - a Glk layer):
	let the result be the result of Glk function number 46 [glk_window_get_echo_stream] applied to W according to L;
	decide on the result converted to a wrapped stream.

To decide what number is the rock of the window (W - a wrapped window) according to (L - a Glk layer):
	decide on the result of Glk function number 33 [glk_window_get_rock] applied to W according to L.

To close the window (W - a wrapped window) via (L - a Glk layer):
	let the discarded value be the result of Glk function number 36 [glk_window_close] applied to W and zero according to L.

Section "Simulated Window Functions" - unindexed

To simulate glk_window_iterate to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least two arguments;
	let the invocation copy be a new copy of the current Glk invocation;
	delegate the current Glk invocation to the next layer;
	repeat until a break:
		let the result be the result of the Glk invocation just delegated;
		if the result is zero or the window hash table contains the key the result:
			break;
		prepare another Glk invocation from the invocation copy;
		write the result to argument number zero of the current Glk invocation;
		delegate the current Glk invocation to the next layer;
	delete the invocation copy.

To simulate glk_window_get_root to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	if the multiple windows supported flag is set in A:
		let the frame window be the frame window of A;
		if the frame window is null:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		otherwise:
			write the function selector 48 [glk_window_get_sibling] to the current Glk invocation;
			write the argument count one to the current Glk invocation;
			write the frame window to argument number zero of the current Glk invocation;
			delegate the current Glk invocation to the next layer;
	otherwise:
		delegate the current Glk invocation to the next layer;
		let the result be the result of the Glk invocation just delegated;
		unless the window hash table of A contains the key the result:
			write the result zero to the Glk invocation just delegated.

To decide what number is the window-opening method for a window in a frame window: (- (winmethod_Above+winmethod_Proportional) -).
To decide what number is the window-opening size for a window in a frame window: (- 100 -).

To simulate glk_window_open to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	let the stream hash table be the stream hash table of A;
	ensure that the current Glk invocation has at least five arguments;
	let the sibling be argument number zero of the current Glk invocation converted to a wrapped window;
	if the sibling is null:
		if the multiple windows supported flag is set in A:
			write the frame window of A to argument number zero of the current Glk invocation;
			write the window-opening method for a window in a frame window to argument number one of the current Glk invocation;
			write the window-opening size for a window in a frame window to argument number two of the current Glk invocation;
		otherwise:
			let the root be the root according to the next layer;
			let the rock be the rock of the window the root according to the next layer;
			always check that the rock is the rock for a window filling in for the frame window or else fail at opening a root window twice in a single-window environment;
			close the window the root via the next layer;
	delegate the current Glk invocation to the next layer;
	let the window be the result of the Glk invocation just delegated converted to a wrapped window;
	unless the window is null:
		let the state be a new wrapped window state for the window;
		insert the key the window and the value the state into the window hash table;
		let the stream be the window stream of the window according to the next layer;
		unless the stream is null:
			let the stream state be a new wrapped stream state for the stream;
			insert the key the stream and the value the stream state into the stream hash table;
		let the sibling state be the window state for the sibling in A;
		unless the sibling state is an invalid wrapped window state:
			let the parent be the parent of the window according to the next layer;
			let the parent state be a new wrapped window state for the parent;
			insert the key the parent and the value the parent state into the window hash table;
			let the grandparent be the parent of the sibling state;
			let the grandparent state be the window state for the grandparent in A;
			write the parent the parent to the state;
			write the parent the parent to the sibling state;
			write the parent the grandparent to the parent state;
			write the first child the sibling to the parent state;
			write the second child the window to the parent state;
			unless the grandparent state is an invalid wrapped window state:
				if the first child of the grandparent state is the sibling:
					write the first child the parent to the grandparent state;
				otherwise:
					always check that the second child of the grandparent state is the sibling or else fail at preserving the relationship invariants on window states;
					write the second child the parent to the grandparent state;
		write the result the window to the Glk invocation just delegated.

To decide what number is the text buffer window type: (- wintype_TextBuffer -).

To simulate glk_window_close to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	let the stream hash table be the stream hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the moribund window be argument number zero of the current Glk invocation converted to a wrapped window;
	let the parent be the parent of the moribund window according to A;
	unless the parent is null:
		let the sibling be the first child of the parent according to A;
		if the sibling is the moribund window:
			now the sibling is the second child of the parent according to A;
		let the sibling state be the window state for the sibling in A;
		let the grandparent be the parent of the parent according to A;
		let the grandparent state be the window state for the grandparent in A;
		unless the grandparent state is an invalid wrapped window state:
			if the first child of the grandparent state is the parent:
				write the first child the sibling to the grandparent state;
			otherwise:
				always check that the second child of the grandparent state is the parent or else fail at preserving the relationship invariants on window states;
				write the second child the sibling to the grandparent state;
		write the parent the grandparent to the sibling state;
		delete the parent from A;
	let the worklist be an empty linked list;
	let the worklist tail be an empty linked list's tail;
	let the detached stream list be an empty linked list;
	enqueue the key the moribund window in the worklist through the worklist tail;
	while the worklist is not empty:
		let the current window be a wrapped window key dequeued from the worklist through the worklist tail;
		let the child be the first child of the current window according to A;
		unless the child is null:
			enqueue the key the child in the worklist through the worklist tail;
		now the child is the second child of the current window according to A;
		unless the child is null:
			enqueue the key the child in the worklist through the worklist tail;
		let the stream be the window stream of the current window according to the next layer;
		unless the stream is null:
			push the key the stream onto the detached stream list;
		delete the current window from A; [deletes the stream automatically]
	repeat with the stream state running through the wrapped stream state values of the stream hash table:
		let the echo stream be the echo stream of the stream state;
		if the detached stream list contains the key the echo stream:
			write the echo stream a null wrapped stream to the stream state;
	delegate the current Glk invocation to the next layer;
	unless the multiple windows supported flag is set in A:
		always check that parent is null or else fail at discovering multiple windows in a single-window environment;
		let the outcome copy be a new copy of the current Glk outcome;
		prepare a spontaneous Glk invocation;
		write the function selector 35 [glk_window_open] to the current Glk invocation;
		write the argument count five to the current Glk invocation;
		write zero to argument number zero of the current Glk invocation;
		write zero to argument number one of the current Glk invocation;
		write zero to argument number two of the current Glk invocation;
		write the text buffer window type to argument number three of the current Glk invocation;
		write the rock for a window filling in for the frame window to argument number four of the current Glk invocation;
		delegate the current Glk invocation to the next layer;
		overwrite the current Glk outcome with the outcome copy;
		delete the outcome copy.

To simulate glk_window_get_relation to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	delegate the current Glk invocation to the next layer;
	unless the window hash table contains the key the result of the Glk invocation just delegated:
		write the result zero to the Glk invocation just delegated.

Chapter "Stream Management"

Section "Simulated Stream Functions" - unindexed

To simulate glk_stream_iterate to hide stream wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the stream hash table be the stream hash table of A;
	ensure that the current Glk invocation has at least two arguments;
	let the invocation copy be a new copy of the current Glk invocation;
	delegate the current Glk invocation to the next layer;
	repeat until a break:
		let the result be the result of the Glk invocation just delegated;
		if the result is zero or the stream hash table contains the key the result:
			break;
		prepare another Glk invocation from the invocation copy;
		write the result to argument number zero of the current Glk invocation;
		delegate the current Glk invocation to the next layer;
	delete the invocation copy.

To simulate glk_stream_open to hide stream wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the stream hash table be the stream hash table of A;
	delegate the current Glk invocation to the next layer;
	let the result be the result of the Glk invocation just delegated converted to a wrapped stream;
	unless the result is null:
		let the stream state be a new wrapped stream state for the result;
		insert the key the result and the value the stream state into the stream hash table.

To simulate glk_stream_close to hide stream wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	ensure that the current Glk invocation has at least one argument;
	let the moribund stream be argument number zero of the current Glk invocation converted to a wrapped stream;
	delete the moribund stream from A;
	delegate the current Glk invocation to the next layer.

To simulate glk_window_set_echo_stream to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	let the stream hash table be the stream hash table of A;
	ensure that the current Glk invocation has at least two arguments;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	let the window state be the legal window state for the window in A;
	let the stream be the window stream of the window according to the next layer;
	unless the stream is null:
		let the stream state be the legal stream state for the stream in A;
		let the echo stream be argument number one of the current Glk invocation converted to a wrapped stream;
		write the echo stream the echo stream to the stream state;
	delegate the current Glk invocation to the next layer.

To simulate glk_set_style to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	ensure that the current Glk invocation has at least one argument;
	let the style be argument number zero of the current Glk invocation;
	let the invocation copy be a new copy of the current Glk invocation;
	write the function selector 72 [glk_stream_get_current] to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to the next layer;
	let the stream be the result of the Glk invocation just delegated converted to a wrapped stream;
	unless the stream is null:
		let the stream state be the legal stream state for the stream in A;
		write the last-seen style the style to the stream state;
	prepare another Glk invocation from the invocation copy;
	delegate the current Glk invocation to the next layer;
	delete the invocation copy.

To simulate glk_set_style_stream to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the stream hash table be the stream hash table of A;
	ensure that the current Glk invocation has at least two arguments;
	let the stream be argument number zero of the current Glk invocation converted to a wrapped stream;
	let the style be argument number one of the current Glk invocation;
	unless the stream is null:
		let the stream state be the legal stream state for the stream in A;
		write the last-seen style the style to the stream state;
	delegate the current Glk invocation to the next layer.

Chapter "Event Management"

Section "Simulated Event Functions" - unindexed

To simulate glk_select to hide window wrapping with (A - a wrapping layer), polling only:
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the target event be argument number zero of the current Glk invocation converted to a wrapped event;
	if the deferred event linked list of A is empty:
		let the invocation copy be a new copy of the current Glk invocation;
		let responding on the stack be whether or not the target event is on the stack;
		if responding on the stack is true:
			now the target event is a new wrapped event;
		repeat until a break:
			delegate the current Glk invocation to the next layer;
			if responding on the stack is true:
				copy the four stack results beginning with stack result number zero of the Glk invocation just delegated to the target event;
			let the source window be the source window of the target event;
			let the source window state be the window state for the source window in A;
			let the break flag be true;
			let the applied flag be false;
			if the event type of the target event is:
				-- 1: [timer event]
					if (the foreign event handler of A applied to the target event) is routing the event no further:
						now the break flag is false;
					now the applied flag is true;
				-- 2: [character input]
					if the source window state is an invalid wrapped window state:
						now the break flag is false;
					otherwise:
						write the last-seen character input request zero to the source window state;
				-- 3: [line input]
					if the source window state is an invalid wrapped window state:
						now the break flag is false;
					otherwise:
						let the initial line buffer content address be the last-seen initial line buffer content address of the source window state;
						if the initial line buffer content address is not zero:
							free the possibly zero-length memory allocation at address initial line buffer content address;
						write the last-seen line input request zero to the source window state;
						write the last-seen line buffer address zero to the source window state;
						write the last-seen line buffer length zero to the source window state;
						write the last-seen initial line buffer content address zero to the source window state;
						write the last-seen initial line buffer content length zero to the source window state;
				-- 4: [mouse input]
					if the source window state is an invalid wrapped window state:
						now the break flag is false;
					otherwise:
						write the last-seen mouse input request zero to the source window state;
				-- 5: [window arrangement event]
					write the source window a null wrapped window to the target event;
					let the discarded value be the foreign event handler of A applied to the target event;
					now the applied flag is true;
				-- 6: [redraw event]
					write the source window a null wrapped window to the target event;
					let the discarded value be the foreign event handler of A applied to the target event;
					now the applied flag is true;
				-- 7: [sound notify event]
					if (the foreign event handler of A applied to the target event) is routing the event no further:
						now the break flag is false;
					now the applied flag is true;
				-- 8: [hyperlink input]
					if the source window state is an invalid wrapped window state:
						now the break flag is false;
					otherwise:
						write the last-seen hyperlink input request zero to the source window state;
			if the break flag is true:
				break;
			if the applied flag is false:
				let the discarded value be the foreign event handler of A applied to the target event;
			prepare another Glk invocation from the invocation copy;
		if responding on the stack is true:
			delete the target event;
		delete the invocation copy;
	otherwise:
		let the deferred event be an invalid wrapped event;
		if polling only:
			let the moribund linked list vertex be an invalid linked list vertex;
			repeat with the linked list vertex running through the deferred event linked list of A:
				if the wrapped event key of the linked list vertex is internally-spawned:
					now the moribund linked list vertex is the linked list vertex;
			if the moribund linked list vertex is an invalid linked list vertex:
				now the deferred event is a new wrapped event;
				write the event type the null event type to the deferred event;
			otherwise:
				now the deferred event is the wrapped event key of the moribund linked list vertex;
				write the deferred event linked list the deferred event linked list of A after removing the moribund linked list vertex to A;
				if the moribund linked list vertex is the deferred event linked list tail of A converted to a linked list vertex:
					write the deferred event linked list tail the tail of the deferred event linked list of A to A;
		otherwise:
			now the deferred event is a wrapped event key dequeued from the deferred event linked list of A through the deferred event linked list tail of A;
		if the target event is on the stack:
			delegate the current Glk invocation to a do-nothing layer returning four stack results;
			copy the deferred event to the four stack results beginning with stack result number zero of the Glk invocation just delegated;
		otherwise:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
			copy the deferred event to the target event;
		delete the deferred event.

To simulate glk_request_char_event_any to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		write the last-seen character input request the function selector of the current Glk invocation to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_cancel_char_event to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		write the last-seen character input request zero to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_request_line_event_any to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least four arguments;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		let the initial line buffer content address be the last-seen initial line buffer content address of the window state;
		if the initial line buffer content address is not zero:
			free the possibly zero-length memory allocation at address initial line buffer content address;
		let the buffer address be argument number one of the current Glk invocation;
		let the length be argument number two of the current Glk invocation;
		let the initial line buffer content length be argument number three of the current Glk invocation;
		now the initial line buffer content address is a possibly zero-length memory allocation of the initial line buffer content length bytes;
		copy the initial line buffer content length bytes from address the buffer address to address the initial line buffer content address;
		write the last-seen line input request the function selector of the current Glk invocation to the window state;
		write the last-seen line buffer address the buffer address to the window state;
		write the last-seen line buffer length the length to the window state;
		write the last-seen initial line buffer content address the initial line buffer content address to the window state;
		write the last-seen initial line buffer content length the initial line buffer content length to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_cancel_line_event to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		let the initial line buffer content address be the last-seen initial line buffer content address of the window state;
		if the initial line buffer content address is not zero:
			free the possibly zero-length memory allocation at address initial line buffer content address;
		write the last-seen line input request zero to the window state;
		write the last-seen line buffer address zero to the window state;
		write the last-seen line buffer length zero to the window state;
		write the last-seen initial line buffer content address zero to the window state;
		write the last-seen initial line buffer content length zero to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_request_mouse_event to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		write the last-seen mouse input request the function selector of the current Glk invocation to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_cancel_mouse_event to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		write the last-seen mouse input request zero to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_request_hyperlink_event to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		write the last-seen hyperlink input request the function selector of the current Glk invocation to the window state;
	delegate the current Glk invocation to the next layer.

To simulate glk_cancel_hyperlink_event to hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	ensure that the current Glk invocation has at least one argument;
	let the window be argument number zero of the current Glk invocation converted to a wrapped window;
	unless the window is null:
		let the window state be the legal window state for the window in A;
		write the last-seen hyperlink input request zero to the window state;
	delegate the current Glk invocation to the next layer.

Chapter "The Glk Layer"

To hide window wrapping with (A - a wrapping layer):
	let the next layer be the Glk layer after A;
	if the function selector of the current Glk invocation is:
		-- 32: [glk_window_iterate]
			simulate glk_window_iterate to hide window wrapping with A;
		-- 34: [glk_window_get_root]
			simulate glk_window_get_root to hide window wrapping with A;
		-- 35: [glk_window_open]
			simulate glk_window_open to hide window wrapping with A;
		-- 36: [glk_window_close]
			simulate glk_window_close to hide window wrapping with A;
		-- 41: [glk_window_get_parent]
			simulate glk_window_get_relation to hide window wrapping with A;
		-- 45: [glk_window_set_echo_stream]
			simulate glk_window_set_echo_stream to hide window wrapping with A;
		-- 48: [glk_window_get_sibling]
			simulate glk_window_get_relation to hide window wrapping with A;
		-- 64: [glk_stream_iterate]
			simulate glk_stream_iterate to hide stream wrapping with A;
		-- 66: [glk_stream_open_file]
			simulate glk_stream_open to hide stream wrapping with A;
		-- 67: [glk_stream_open_memory]
			simulate glk_stream_open to hide stream wrapping with A;
		-- 68: [glk_stream_close]
			simulate glk_stream_close to hide stream wrapping with A;
		-- 134: [glk_set_style]
			simulate glk_set_style to hide window wrapping with A;
		-- 135: [glk_set_style_stream]
			simulate glk_set_style_stream to hide window wrapping with A;
		-- 192: [glk_select]
			simulate glk_select to hide window wrapping with A;
		-- 193: [glk_select_poll]
			simulate glk_select to hide window wrapping with A, polling only;
		-- 208: [glk_request_line_event]
			simulate glk_request_line_event_any to hide window wrapping with A;
		-- 209: [glk_cancel_line_event]
			simulate glk_cancel_line_event to hide window wrapping with A;
		-- 210: [glk_request_char_event]
			simulate glk_request_char_event_any to hide window wrapping with A;
		-- 211: [glk_cancel_char_event]
			simulate glk_cancel_char_event to hide window wrapping with A;
		-- 212: [glk_request_mouse_event]
			simulate glk_request_mouse_event to hide window wrapping with A;
		-- 213: [glk_cancel_mouse_event]
			simulate glk_cancel_mouse_event to hide window wrapping with A;
		-- 258: [glk_request_hyperlink_event]
			simulate glk_request_hyperlink_event to hide window wrapping with A;
		-- 259: [glk_cancel_hyperlink_event]
			simulate glk_cancel_hyperlink_event to hide window wrapping with A;
		-- 312: [glk_stream_open_file_uni]
			simulate glk_stream_open to hide stream wrapping with A;
		-- 313: [glk_stream_open_memory_uni]
			simulate glk_stream_open to hide stream wrapping with A;
		-- 320: [glk_request_char_event_uni]
			simulate glk_request_char_event_any to hide window wrapping with A;
		-- 321: [glk_request_line_event_uni]
			simulate glk_request_line_event_any to hide window wrapping with A;
		-- otherwise:
			delegate the current Glk invocation to the next layer.

Chapter "Recovery for the Glk Layer"

Section "Private Recovery Utilities" - unindexed

To repeat with (I - a nonexisting wrapped stream variable) running through wrapped streams begin -- end: (-
	for({I}=glk_stream_iterate(0,0):{I}:{I}=glk_stream_iterate({I},0))
-).
To repeat with (I - a nonexisting wrapped window variable) running through wrapped windows begin -- end: (-
	for({I}=glk_window_iterate(0,0):{I}:{I}=glk_window_iterate({I},0))
-).

To decide what wrapped window is the parent of (W - a wrapped window): (- glk_window_get_parent({W}) -).

Include (-
	Array gww_keyWindow --> 1;
	[ glk_window_get_key window;
		glk_window_get_arrangement(window,0,0,gww_keyWindow);
		return llo_getInt(gww_keyWindow);
	];
-).

To decide what wrapped stream is the window stream of (W - a wrapped window): (- glk_window_get_stream({W}) -).
To decide what wrapped stream is the echo stream of (W - a wrapped window): (- glk_window_get_echo_stream({W}) -).

Section "Public Recovery Utilities"

To decide what wrapped window is the key of (W - a wrapped window): (- glk_window_get_key({W}) -).

Section "Utilities for Checking Multiple Window Support" - unindexed

Include (-
	Constant GWW_FILL_IN_ROCK = $67777700; ! ASCII 'gww\0'
-).

To decide what number is the rock for a window filling in for the frame window: (- GWW_FILL_IN_ROCK -).

[These must use TextBuffer; some libraries won't open anything else.]
To decide what wrapped window is a new root window for checking multiple window support or filling in for the frame window: (- glk_window_open(0,0,0,wintype_TextBuffer,GWW_FILL_IN_ROCK) -).
To decide what wrapped window is a new replacement root window for checking multiple window support with the type (T - a number) and rock (R - a number): (- glk_window_open(0,0,0,{T},{R}) -).
To decide what wrapped window is a new sibling window for checking multiple window support: (- glk_window_open(glk_window_get_root(),winmethod_Below+winmethod_Proportional,50,wintype_TextBuffer,0) -).
To close (W - a wrapped window) for checking multiple window support: (- glk_window_close({W},0); -).
To decide what wrapped window is the root window for checking multiple window support: (- glk_window_get_root() -).
To decide what number is the type of (W - a wrapped window) for checking multiple window support: (- glk_window_get_type({W}) -).
To decide what number is the rock of (W - a wrapped window) for checking multiple window support: (- glk_window_get_rock({W}) -).

Section "The Recovery Phrases"

To decide what wrapped window is the root wrapped window: (- glk_window_get_root() -).

To recover windows and streams for (A - a wrapping layer):
	let the window hash table be the window hash table of A;
	let the stream hash table be the stream hash table of A;
	clear the window hash table;
	clear the stream hash table;
	[Pass 1: recover streams]
	repeat with the current stream running through wrapped streams:
		let the stream state be a new wrapped stream state for the current stream;
		insert the key the current stream and the value the stream state into the stream hash table;
	[Pass 2: recover windows and stream relations]
	let the window count be zero;
	repeat with the current window running through wrapped windows:
		increment the window count;
		let the window stream be the window stream of the current window;
		let the echo stream be the echo stream of the current window;
		unless the echo stream is null:
			let the stream state be the legal stream state for the window stream in A;
			write the echo stream the echo stream to the stream state;
		let the window state be a new wrapped window state for the current window;
		insert the key the current window and the value the window state into the window hash table;
	[Pass 3: recover window relations]
	repeat with the current window running through wrapped windows:
		let the parent be the parent of the current window;
		unless the parent is null:
			let the parent state be the legal window state for the parent in A;
			if the first child of the parent state is null:
				write the first child the current window to the parent state;
			otherwise:
				always check that the second child of the parent state is null or else fail at giving a parent window three children;
				write the second child the current window to the parent state;
		let the state be the legal window state for the current window in A;
		write the parent the parent to the state;
	[Pass 4: recover the status of the multiple windows supported flag]
	if the window count is:
		-- zero:
			let the temporary root be a new root window for checking multiple window support or filling in for the frame window;
			always check that the temporary root is not null or else fail at opening any windows;
			let the temporary sibling be a new sibling window for checking multiple window support;
			if the temporary sibling is null:
				reset the multiple windows supported flag in A;
				[Do not close the temporary root; it is filling in for the frame window.]
			otherwise:
				set the multiple windows supported flag in A;
				close the temporary sibling for checking multiple window support;
				close the temporary root for checking multiple window support;
		-- one:
			if CocoaGlk is detected:
				[We know that the actual Glk is CocoaGlk, but that doesn't mean that multiple windows are supported by all the layers in between us and it.  Unfortunately, we can't apply the usual test without risking Inform bug 961.  So, as in Low-Level Operations, we go for a lesser evil: we destroy the lone window and then recreate it.]
				let the original root be the root window for checking multiple window support;
				let the original root's type be the type of the original root for checking multiple window support;
				let the original root's rock be the rock of the original root for checking multiple window support;
				close the original root for checking multiple window support;
				let the temporary root be a new root window for checking multiple window support or filling in for the frame window;
				always check that the temporary root is not null or else fail at opening any windows;
				let the temporary sibling be a new sibling window for checking multiple window support;
				if the temporary sibling is null:
					reset the multiple windows supported flag in A;
					[Do not close the temporary root; it is filling in for the frame window.  However, make sure it matches.]
					always check that the type of the original root for checking multiple window support is the original root's type or else fail at filling in for the frame window when multiple windows are not supported and there is already a conflicting window;
					always check that the rock of the original root for checking multiple window support is the original root's rock or else fail at filling in for the frame window when multiple windows are not supported and there is already a conflicting window;
				otherwise:
					set the multiple windows supported flag in A;
					close the temporary sibling for checking multiple window support;
					close the temporary root for checking multiple window support;
					now the original root is a new replacement root window for checking multiple window support with the type the original root's type and rock the original root's rock;
			otherwise:
				let the temporary sibling be a new sibling window for checking multiple window support;
				if the temporary sibling is null:
					reset the multiple windows supported flag in A;
					let the root be the root window for checking multiple window support;
					let the rock be the rock of the root for checking multiple window support;
					if the rock is the rock for a window filling in for the frame window:
						delete the root from A;
				otherwise:
					set the multiple windows supported flag in A;
					close the temporary sibling for checking multiple window support;
		-- otherwise:
			set the multiple windows supported flag in A.

Chapter "Installation"

To install (P - a phrase nothing -> nothing) as (A - a wrapping layer variable) whose Glk layer notifications are handled by (H - a phrase Glk layer notification -> nothing) and whose foreign events are handled by (E - a phrase wrapped event -> event routing decision): (-
	{A}=(llo_getField((+ constructing a permanent wrapping layer +),1))(gi_outermost,{E});
	(+ the Glk layer linked list tail +)=(llo_getField((+ enqueuing a key and value in a linked list +),1))((+ the Glk layer linked list tail +),llo_getField({P},1),llo_getField({H},1));
	if(~~(+ the Glk layer linked list +)){
		(+ the Glk layer linked list +)=(+ the Glk layer linked list tail +);
	}
	gi_outermost=llo_getField({P},1);
-).

Book "Input and Output in Wrapping Windows"

Chapter "Window Context Switching"

Section "The Sole Window"

To decide what wrapped window is the sole window according to (L - a Glk layer):
	let the invocation copy be an invalid Glk invocation;
	let the outcome copy be an invalid Glk outcome;
	if the Glk layers are in the pre-call state:
		now the invocation copy is a new copy of the current Glk invocation;
	otherwise:
		now the outcome copy is a new copy of the current Glk outcome;
		prepare a spontaneous Glk invocation;
	write the function selector 34 [glk_window_get_root] to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to L;
	let the result be the result of the Glk invocation just delegated converted to a wrapped window;
	if the invocation copy is not an invalid Glk invocation:
		prepare another Glk invocation from the invocation copy;
		delete the invocation copy;
	otherwise:
		overwrite the current Glk outcome with the outcome copy;
		delete the outcome copy;
	decide on the result.

Section "Dispatch Utilities for Window Context Switching" - unindexed

To select (W - a wrapped window) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 47 [glk_set_window] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

To select (S - a wrapped stream) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 71 [glk_stream_set_current] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write S to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

To decide what wrapped stream is the current stream according to (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 72 [glk_stream_get_current] to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to L;
	decide on the result of the Glk invocation just delegated converted to a wrapped stream.

To set the style (T - a number) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 134 [glk_set_style] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write T to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

To request non-line input in (W - a wrapped window) using the function selector (F - a number) with (L - a Glk layer) (this is requesting non-line input with a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector F to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

To request line input in (W - a wrapped window) using the buffer at address (B - a number) with length (N - a number) and initial length (I - a number) the function selector (F - a number) with (L - a Glk layer) (this is requesting line input with a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector F to the current Glk invocation;
	write the argument count four to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	write B to argument number one of the current Glk invocation;
	write N to argument number two of the current Glk invocation;
	write I to argument number three of the current Glk invocation;
	delegate the current Glk invocation to L.

To cancel any character input request in (W - a wrapped window) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 211 [glk_cancel_char_event] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

To cancel any line input request in (W - a wrapped window) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 209 [glk_cancel_line_event] to the current Glk invocation;
	write the argument count two to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	write zero to argument number one of the current Glk invocation;
	delegate the current Glk invocation to L.

To cancel any mouse input request in (W - a wrapped window) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 213 [glk_cancel_mouse_event] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

To cancel any hyperlink input request in (W - a wrapped window) with (L - a Glk layer):
	prepare a spontaneous Glk invocation;
	write the function selector 259 [glk_cancel_hyperlink_event] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	write W to argument number zero of the current Glk invocation;
	delegate the current Glk invocation to L.

Section "Shortening the Inline Context-Switching Phrase" - unindexed

Include (-
	Global gww_layerTransfer;
	Global gww_streamTransfer;
	Global gww_windowStateTransfer;
	Global gww_streamStateTransfer;
-) after "Definitions.i6t".

The Glk layer transfer is a Glk layer that varies.  The Glk layer transfer variable translates into I6 as "gww_layerTransfer".
The stream transfer is a wrapped stream that varies.  The stream transfer variable translates into I6 as "gww_streamTransfer".
The window state transfer is a wrapped window state that varies.  The window state transfer variable translates into I6 as "gww_windowStateTransfer".
The stream state transfer is a wrapped stream state that varies.  The stream state transfer variable translates into I6 as "gww_streamStateTransfer".

To set transfer variables for entry into (W - a wrapped window) via (A - a wrapping layer) (this is setting transfer variables for entry into a window):
	now the Glk layer transfer is the Glk layer after A;
	now the stream transfer is the current stream according to the Glk layer transfer;
	now the window state transfer is the window state for W in A;
	now the stream state transfer is the stream state for the stream transfer in A;
	unless the window state transfer is an invalid wrapped window state:
		unless the window state transfer is occupied:
			unless the last-seen character input request of the window state transfer is zero:
				cancel any character input request in W with the Glk layer transfer;
			unless the last-seen line input request of the window state transfer is zero:
				cancel any line input request in W with the Glk layer transfer;
			unless the last-seen mouse input request of the window state transfer is zero:
				cancel any mouse input request in W with the Glk layer transfer;
			unless the last-seen hyperlink input request of the window state transfer is zero:
				cancel any hyperlink input request in W with the Glk layer transfer;
		occupy the window state transfer;
	unless the stream state transfer is an invalid wrapped stream state:
		occupy the stream state transfer;
	select W with the Glk layer transfer;
	unless the stream state transfer is an invalid wrapped stream state:
		set the style zero with the Glk layer transfer.

To get transfer variables for exit from a wrapped window via a wrapping layer (this is getting transfer variables for exit from a window):
	unless the stream state transfer is an invalid wrapped stream state:
		vacate the stream state transfer;
		unless the stream state transfer is occupied:
			set the style the last-seen style of the stream state transfer with the Glk layer transfer;
	unless the window state transfer is an invalid wrapped window state:
		vacate the window state transfer;
	select the stream transfer with the Glk layer transfer.

Section "Window Context Switching Proper"

Include (-
	Global gww_iterator;
-) after "Definitions.i6t".

[One must not return from within such a ``loop.'']
To while within (W - a wrapped window) via (A - a wrapping layer) begin -- end: (-
	(llo_getField((+ setting transfer variables for entry into a window +),1))({W},{A});
	@push gww_layerTransfer;
	@push gww_streamTransfer;
	@push gww_windowStateTransfer;
	@push gww_streamStateTransfer;
	@push say__p;
	@push say__pc;
	say__p=0;
	say__pc=0;
	for(llo_advance=false::)
		if(llo_advance){
			@pull say__pc;
			@pull say__p;
			@pull gww_streamStateTransfer;
			@pull gww_windowStateTransfer;
			@pull gww_streamTransfer;
			@pull gww_layerTransfer;
			(llo_getField((+ getting transfer variables for exit from a window +),1))();
			break;
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true):)
-).

Include (-
	[ gww_within window;
		return glk_stream_get_current()==glk_window_get_stream(window);
	];
-).

To decide what number is testing whether we are within a window: (- gww_within -).

To decide whether we are within (W - a wrapped window): (- gww_within({W}) -).

A GRIF shielding rule (this is the shield testing whether we are within a window rule):
	shield testing whether we are within a window against instrumentation.

Chapter "Input in Wrapping Windows"

Section "Waiting for Events"

To wait for the next foreign event using (A - a wrapping layer) (this is waiting for a foreign event with a wrapping layer):
	let the next layer be the Glk layer after A;
	let the window hash table be the window hash table of A;
	prepare a spontaneous Glk invocation;
	write the function selector 192 [glk_select] to the current Glk invocation;
	write the argument count one to the current Glk invocation;
	let the event be a new wrapped event;
	write the event to argument number zero of the current Glk invocation;
	let the invocation copy be a new copy of the current Glk invocation;
	repeat until a break:
		delegate the current Glk invocation to the next layer;
		let the source window be the source window of the event;
		let the source window state be the window state for the source window in A;
		let the break flag be false;
		let the applied flag be false;
		if the event type of the event is:
			-- 1: [timer event]
				if (the foreign event handler of A applied to the event) is routing the event no further:
					now the break flag is true;
				now the applied flag is true;
			-- 2: [character input]
				if the source window state is an invalid wrapped window state or the source window state is occupied:
					now the break flag is true;
			-- 3: [line input]
				if the source window state is an invalid wrapped window state or the source window state is occupied:
					now the break flag is true;
			-- 4: [mouse input]
				if the source window state is an invalid wrapped window state or the source window state is occupied:
					now the break flag is true;
			-- 5: [window arrangement event]
				let the discarded value be the foreign event handler of A applied to the event;
			-- 6: [redraw event]
				let the discarded value be the foreign event handler of A applied to the event;
			-- 7: [sound notify event]
				if (the foreign event handler of A applied to the event) is routing the event no further:
					now the break flag is true;
				now the applied flag is true;
			-- 8: [hyperlink input]
				if the source window state is an invalid wrapped window state or the source window state is occupied:
					now the break flag is true;
		if the break flag is true:
			if the applied flag is false:
				let the discarded value be the foreign event handler of A applied to the event;
			break;
		enqueue the event as a deferred event for A;
		if the applied flag is true:
			break;
		prepare another Glk invocation from the invocation copy;
	delete the event;
	delete the invocation copy.

Glk Window Wrappers ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Glk Window Wrappers is a low-level framework for adding extra Glk windows
without these windows being detectable by ordinary means.  It's mostly used to
introduce a space for debugging input and output without requiring rework of a
story's source text or otherwise disturbing its behavior.  Other uses are
generally handled better by Jon Ingold's extension Flexible Windows.

Details are in the following chapters.

Chapter: Usage

Section: Background

This extension documentation assumes familiarity with the Glk specification,
which can be found at http://eblong.com/zarf/glk/, and the extension Glk
Interception.

Most of the code in the Glk specification is given in C, but the syntax is
nearly identical if we use Inform 6 inclusions.  There is, however, a smattering
of I7 syntax available, which is easier to present here, at once, than in bits
and pieces as it comes up.

First off, Glk Window Wrappers imports some types from glk.h, though with more
Inform-friendly names.  The type winid_t, for instance, is presented as the kind

	a wrapped window

(The word "wrapped" in the name is there for two reasons.  Nominally it's
because the window in question is usually one of those that the extra windows
wrapped around---or at least it was in the first draft of the extension.  More
pragmatically, it reduces the opportunities for name clashes.)

Likewise, we have strid_t as

	a wrapped stream

and event_struct as

	a wrapped event

All three kinds have a default value that is invalid and should never reach Glk:

	an invalid wrapped window

	an invalid wrapped stream

and

	an invalid wrapped event

and the first two have null values, which are the same as Glk's null:

	a null wrapped window

and

	a null wrapped stream

It's often useful to test for these values with the adjective "null", as in:

	if the wrapped stream is null:
		....

Wrapped events, on the other hand, are never null, but because of a quirk in the
Glulx specification, an event can be understood to exist at the top of the Glulx
stack and not at a particular memory address.  Therefore, we have the value

	an on-the-stack wrapped event

which can be detected with the I7 adjective "on the stack", as in

	if the wrapped event is on the stack:
		....

Being structs, events are something we want to be able to create and destroy.
The phrases to use are

	a new permanent wrapped event

for a new event that we never plan to destroy,

	a new wrapped event

for one that we do intend to dispose of, and

	delete (A - a wrapped event)

to carry out the disposal.

The struct fields are exposed through the phrases

	the event type of (A - a wrapped event)

	the source window of (A - a wrapped event)

	the first associated value of (A - a wrapped event)

and

	the second associated value of (A - a wrapped event)

when we want to read a value.  We have

	write the event type (X - a number) to (A - a wrapped event)

	write the source window (X - a wrapped window) to (A - a wrapped event)

	write the first associated value (X - a number) to (A - a wrapped event)

and

	write the second associated value (X - a number) to (A - a wrapped event)

when we want to write one.  Note that all of the fields besides the source
window are of kind number, and we may have to convert the two associated values
using the phrase from Low-Level Operations.  In contrast, the event types
usually do not need a conversion, seeing as the event type constants (at least
through Glk version 0.7.4) have been translated as I7 names for numbers:

	the null event type

	the timer event type

	the character input event type

	the line input event type

	the mouse input event type

	the window arrangement event type

	the redraw event type

	the sound notification event type

and

	the hyperlink event type

We also have the adjective "internally-spawned" that applies to wrapped events
if their event type could indicate an internally-spawned event (see Section 4 of
the Glk specification).

Lastly, because we occasionally need to copy the contents of one event into
another, we have three copying phrases:

	copy (A - a wrapped event) to (B - a wrapped event)

does the obvious;

	copy (A - a wrapped event) to the four stack results beginning with stack result number (I - a number) of the Glk invocation just delegated

writes the four fields of A to stack results I, I plus one, I plus two, and I
plus three of the Glk invocation just delegated, the idea being that an
on-the-stack event will eventually comprise these results; and

	copy the four stack results beginning with stack result number (I - a number) of the Glk invocation just delegated to (B - a wrapped event)

does the reverse.

Section: Overview

Glk Window Wrappers is a toolkit for building window-wrapping layers, which are
a special kind of Glk interception layers.  They simulate a Glk implementation
that hides all but a subtree of the actual window tree.  For instance, a
wrapping layer might create two windows, Y and Z, and pretend that they don't
exist to the layers above.  The actual window tree would start out as

	1. A pair window
	1.a. Window Y
	1.b. Window Z

but the higher layers would see nothing at all.  One of these extra windows, let
us say Y, would be the layer's frame window, meaning that it reserves space for
any windows not belonging to the wrapping layer.  If a higher layer attempts to
create a new root, that window would actually be split off of the frame window
as a 100% proportional split, yielding a tree like

	1. A pair window
	1.a. A pair window
	1.a.1. (Windows seen by layer above)
	1.a.2. Window Y (effectively invisible)
	1.b. Window Z

where windows created by higher layers divvy up the space allocated to Y, rather
than entire area provided by the interpreter.  As far as higher layers are
concerned, they are merely running with less screen real estate.  The wrapping
layer, in the meantime, has a separate place for its input and output.

On an interpreter that only supports a single window, the extension ensures the
existence of that window, and the tree appears thus:

	1. The sole window

It also makes it available to the wrapping layer, which conceals or reveals it
to layers above according to whether or not they have requested its creation.

To maintain such illusions, a window-wrapping layer must do three things:

	1. create or recover the extra windows (and their streams) as needed

	2. handle events that apply to the extra windows (we call such events "foreign" events)

	3. hide the existence of the extra windows (and their streams) from the layers above

Task 1 is usually the trickiest.  We have to deal with the special case for
single-window interpreters.  Also, and more seriously, a general recovery
routine can't depend on rocks to uniquely identify the extra windows---a layer
above might choose the same rock---so we have to make do with other telltales.
This is also where we run into trouble if we want to support
non-standards-conforming interpreters like Zoom or the Inform Mac IDE.

Task 2 is much simpler, and almost as simple as writing an ordinary Glk event
handler.  The only catch is that some events, like a timer going off, aren't
associated with a particular window.  Therefore, we have to write code to decide
whether the wrapping layer should also receive these events.

The last task, Task 3, is simpler yet.  All it involves is invoking an extension
phrase with the right argument.

Section: Building a window-wrapping layer

Window-wrapping layers are created much like ordinary interception layers,
except that there are more pieces to supply.  As usual, we declare a variable to
store the layer, though this time of a different kind:

	The example wrapping layer is a wrapping layer that varies.

After that are three named phrases, one for each task.  Task 1 uses a phrase
that applies to a Glk layer notification and responds when its argument is Glk
recovery needed (other notifications from Glk Interception can also be dealt
with here):

	To handle the Glk layer notification (N - a Glk layer notification) for the example wrapping layer (this is handling a Glk layer notification for the example wrapping layer):
		if N is:
			-- Glk recovery needed:
				....

whereas Task 2 should be accomplished by a phrase taking the event to handle and
deciding on a event routing decision:

	To decide what event routing decision is the event routing decision after handling (E - a wrapped event) for the example wrapping layer (this is handling a wrapped event for the example wrapping layer):
		....

Addressing Task 3 is, as promised, merely a matter of writing one phrase to
invoke another, passing the layer as that phrase's argument:

	To hide the example window wrapping (this is hiding the example window wrapping):
		hide window wrapping with the example wrapping layer.

Finally, we have a layering rule to put everything together:

	A Glk layering rule (this is the example window wrapper rule):
		install hiding the example window wrapping as the example wrapping layer whose notifications are handled by handling a Glk layer notification for the example wrapping layer and whose foreign events are handled by handling a wrapped event for the example wrapping layer.

Section: Creating and recovering wrapping windows

Before doing anything else for Task 1, we should invoke the phrase

	recover windows and streams for (A - a wrapping layer)

with the wrapping layer in question.  It handles all of the unexciting details
of Glk resource recovery, but does so assuming the nonexistence of extra
windows.  The remainder of the task is to make layer-specific corrections for
that faulty assumption.

Almost always we want to split those corrections into two cases: the usual case
where multiple windows are supported, and the special case where they are
disallowed.  The conditional

	if the multiple windows supported flag is set in (A - a wrapping layer):
		...;
	otherwise:
		....

makes this split.  Let us begin with the first case, which has at least two
subcases.

One possibility is that the story is running for the first time, and that there
are no Glk windows yet.  If so, we need to create the extras and mark one as the
frame window.  On the other hand, we might have just restarted the story or
restored from a save file, in which case the extra windows already exist and
only need to be identified.  And if we don't always use the same set of extra
windows, then there will be other cases where we need to change out one set for
another.

An easy way to distinguish at least the first situation is to check

	the root wrapped window

This phrase, only valid during recovery, decides on the root window of the
entire tree.  It will be null if and only if there are no windows in existence.

If it's not null, we can use it as an starting point for tree traversal, which
is accomplished by three phrases:

	the parent of (W - a wrapped window) according to (A - a wrapping layer)

	the first child of (W - a wrapped window) according to (A - a wrapping layer)

and

	the second child of (W - a wrapped window) according to (A - a wrapping layer)

These last two are especially useful because they have no analog in Glk.  But
note that we should not make assumptions about which of two windows will be the
first child and which will be the second child---the choice is consistent within
any one recovery, but not necessarily the same from one to the next.

Another phrase of similar use,

	the key of (W - a wrapped window)

is good for breaking that symmetry.  It determines the key window of a given
split, and judicious use will, in most scenarios, allow us to uniquely identify
a window without depending on a distinct rock.

Once we have created any missing windows (with the usual Glk routines) and
located the rest, we should apply the phrase

	delete (W - a wrapped window) from (A - a wrapping layer)

to each of the windows we did not just create.  This phrase undoes some of the
work done by

	recover windows and streams for (A - a wrapping layer)

so that W seems nonexistent to layers above A.  Be warned that the traversal
phrases cannot safely be applied to W or its descendants once it's been
forgotten.

Lastly, we must identify the frame window, via

	write the frame window (X - an wrapped window) to (A - a wrapping layer)

Returning to the second case, where multiple windows are not supported and
neither window creation nor recovery make sense, the correct thing to do is to
set the frame window to null, as in

	write the frame window a null wrapped window to (A - a wrapping layer)

We might also want to nullify any global variables that track the extra windows.

Section: Handling events

The event-handling phrase is written much like an ordinary Glk-event handler,
except that it only receives events owned by the extra windows or no window at
all.  Most of the relevant phrases were covered in the background section.  The
only thing different is that we must decide on one of two values, either

	routing the event normally

or

	routing the event no further

For events that belong to an extra window, the choice makes no difference, and
the event will be remain invisible to the layers above.  But we can choose
whether or not to pass timer events or sound notifications along.  Deciding on
the former value has them delivered to upper layer's handlers; picking the
latter will have the extension pretend that they never occurred.

Section: I/O in wrapping windows

To perform input and output in a wrapping window, we first need to locate it.
The easiest method is usually to store it in a global variable as part of the
recovery phrase.  If the test

	if the multiple windows supported flag is set in (A - a wrapping layer):
		....

succeeds, the global variable should hold a valid value, and we are ready for
I/O.  If not, we obtain the interception layer just below with the phrase

	the Glk layer after (A - a wrapping layer)

and give it to the phrase

	the sole window according to (L - a Glk layer)

to obtain the lone text window.

Once we have a window, we use the phrase

	while within (W - a wrapped window) via (A - a wrapping layer):
		....

for output.  An abuse of syntax, it isn't actually a loop.  Instead, entering
the ellipsis directs output to W, while exiting it points output back to its
former destination.  Therefore, unless we intervene, say phrases invoked from
within the ellipsis, even indirectly, will print to W.  Importantly, this phrase
only works in a wrapping layer phrase or an uninstrumented context (see the
documentation for the Glulx Runtime Instrumentation Framework).  The
corresponding conditional

	if we are within (W - a wrapped window):
		....

tests whether output is currently directed to W.

For input, we make a Glk event request as usual.  But in place of glk_select, we
write

	wait for the next foreign event using (A - a wrapping layer)

It works much like glk_select, except that events owned by the wrapped windows
aren't returned.  They remain in an event queue, waiting for an eligible layer
to call glk_select.  This phrase is also unsafe unless it appears in a wrapping
layer phrase or an uninstrumented context.

Section: Generating events for wrapped windows

In rare circumstances we want to add simulated events to a higher layer's event
queue.  We do so by writing

	enqueue (E - a wrapped event) as a deferred event for (A - a wrapping layer)

The event E is considered to have occurred at the moment that the phrase runs,
and is added to the end of the queue for the interception layer immediately
above A.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Glk Window Wrappers is subject to the caveats for the Glulx Runtime
Instrumentation Framework; see the requirements chapter in its documentation for
the technical details.

Glk Interception, which this extension includes, creates and installs a
workaround for a bug in CocoaGlk (see
http://inform7.com/mantis/view.php?id=819).  Consequently, this extension will
break any code that depends on the buggy behavior.

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

Glk Window Wrappers was prepared as part of the Glulx Runtime Instrumentation
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

Example: *** Window Jumping - Reading commands from a side window

Suppose, for the sake of example, that we want to give the player the option of
entering commands in a side window rather than at the prompt.  We'll implement
the command "jump" to print a prompt in a window that the story doesn't
otherwise know to exist, read a line there, and interpret that line as the
player's actual command.

Following the recipe from the section on building a wrapping layer, we begin by
declaring

	The example wrapping layer is a wrapping layer that varies.

And, since we'll need to remember the side window to conduct I/O there,

	The side window is a wrapped window that varies.

Task 1 asks us to write a recover phrase, which begins

	To handle the Glk layer notification (N - a Glk layer notification) for the example wrapping layer (this is handling a Glk layer notification for the example wrapping layer):
		if N is:
			-- Glk recovery needed:
				recover windows and streams for the example wrapping layer;
				...

Again going by the recipe, we identify two cases: one where multiple windows are
supported and one where the best we can do is take turns using the main window.
The latter is easy to handle:

				if the multiple windows supported flag is set in the example wrapping layer:
					...
				otherwise:
					now the side window is a null wrapped window;
					write the frame window a null wrapped window to the example wrapping layer.

We then subdivide the first case into two: if the root window is null we need to
create a side window and a frame window, whereas if not, we need to recover them:

					let the root be the root wrapped window;
					if the root is null:
						...
					otherwise:
						...

Window creation means turning to some I6 inclusions to access the Glk routines:

	To decide what wrapped window is a new textual root window: (- glk_window_open(0,0,0,wintype_TextBuffer,0) -).
	To decide what wrapped window is a new frame window split off of (W - a wrapped window): (- glk_window_open({W},winmethod_Left+winmethod_Proportional,50,wintype_Blank,0) -).

We use them by writing

						now the side window is a new textual root window;
						let the frame be a new frame window split off of the side window;
						write the frame window the frame to the example wrapping layer;

That leaves recovery, where we need to think carefully about which windows are
keys of which.  When we create the side window, there are no keys, but once we
split off the frame we have the tree

	1. A pair window
	1.a. The side window
	1.b. The frame window

where, to quote the Glk specification, "the new window is then called the 'key
window' of this split".  Further splits won't change that fact, so we can obtain
the frame by requesting the key of the root:

						let the frame be the key of the root;

The side window could be its sibling, as shown above, or its aunt, as in

	1. A pair window
	1.a. The side window
	1.b. A pair window
	1.b.1. The frame window
	1.b.2. (Windows seen by layer above)

We'll guess that the first child of the root is the frame, at least to begin
with:

						now the side window is the first child of the root according to the example wrapping layer;
						let the side window's sibling be the second child of the root according to the example wrapping layer;

and reverse our guess if things don't look right:

						unless the side window's sibling is the frame or the side window's sibling is the parent of the frame:
							let the swap variable be the side window's sibling;
							now the side window's sibling is the side window;
							now the side window is the swap variable;

We then delete the three or four extra windows, including the pair windows:

						delete the root from the example wrapping layer;
						delete the side window from the example wrapping layer;
						unless the side window's sibling is the frame:
							delete the side window's sibling from the example wrapping layer;
						delete the frame from the example wrapping layer;

and record the frame window:

						write the frame window the frame to the example wrapping layer;

Put together, the Task 1 phrase reads thus:

	To handle the Glk layer notification (N - a Glk layer notification) for the example wrapping layer (this is handling a Glk layer notification for the example wrapping layer):
		if N is:
			-- Glk recovery needed:
				recover windows and streams for the example wrapping layer;
				if the multiple windows supported flag is set in the example wrapping layer:
					let the root be the root wrapped window;
					if the root is null:
						now the side window is a new textual root window;
						let the frame be a new frame window split off of the side window;
						write the frame window the frame to the example wrapping layer;
					otherwise:
						let the frame be the key of the root;
						now the side window is the first child of the root according to the example wrapping layer;
						let the side window's sibling be the second child of the root according to the example wrapping layer;
						unless the side window's sibling is the frame or the side window's sibling is the parent of the frame:
							let the swap variable be the side window's sibling;
							now the side window's sibling is the side window;
							now the side window is the swap variable;
						delete the root from the example wrapping layer;
						delete the side window from the example wrapping layer;
						unless the side window's sibling is the frame:
							delete the side window's sibling from the example wrapping layer;
						delete the frame from the example wrapping layer;
						write the frame window the frame to the example wrapping layer;
				otherwise:
					now the side window is a null wrapped window;
					write the frame window a null wrapped window to the example wrapping layer.

Task 2 is best explained by beginning with the code for jumping into the side
window.  It must print a prompt, request line input, wait for that input to come
back, and acknowledge the command.  The prompt and acknowledgement are simply
say phrases, and we farm the event request out to another phrase.  To wait for
input, we repeatedly wait for a foreign event, and, because other events might
arrive, only stop when a global flag has been cleared:

	To execute a jump (this is executing a jump):
		while within the jump window via the example wrapping layer:
			say "Enter a command here.";
			say "> ";
			request a line event from the jump window to overwrite the command buffer using the example wrapping layer;
			now expecting a side command is true;
			while expecting a side command is true:
				wait for the next foreign event using the example wrapping layer;
			say "The command is now '[the player's command]'.[paragraph break]".

where the global flag is declared by

	Expecting a side command is a truth state that varies.  Expecting a side command is false.

Note that we wrote

	while within the jump window via the example wrapping layer:
		....

rather than

	while within the side window via the example wrapping layer:
		....

because, in a single-window interpreter, the side window might not exist.  We
write the following phrase to decide what window is the jump window:

	To decide what wrapped window is the jump window:
		if the multiple windows supported flag is set in the example wrapping layer:
			decide on the side window;
		decide on the sole window according to the Glk layer after the example wrapping layer.

As for the event request, we follow the usual pattern from Glk Interception:

	To request a line event from (W - a wrapped window) to overwrite the command buffer using (A - a wrapping layer) (this is requesting a line event with a wrapping layer):
		prepare a spontaneous Glk invocation;
		write the function selector 208 [glk_request_line_event] to the current Glk invocation;
		write the argument count four to the current Glk invocation;
		write W to argument number zero of the current Glk invocation;
		write the address of the command buffer to argument number one of the current Glk invocation;
		write the maximum length of the command buffer to argument number two of the current Glk invocation;
		write zero to argument number three of the current Glk invocation;
		fill the command buffer with spaces;
		delegate the current Glk invocation to the Glk layer after A.

relying on some more I6 inclusions and phases from Low-Level Operations to get
at Inform's built-in command buffer:

	To decide what number is the maximum length of the command buffer: (- 118 -).
	To decide what number is the address of the command buffer: (- (buffer+4) -).
	To fill the command buffer with spaces:
		repeat with the index running over the half-open interval from zero to the maximum length of the command buffer:
			let the character address be the address of the command buffer plus the index;
			write the byte 32 [space] to address the character address.

The remaining job in Task 2, then, is to detect and respond to line input
events.  We'll also print another line in the jump window, just to show that
everything is working:

	To decide what event routing decision is the event routing decision after handling (E - a wrapped event) for the example wrapping layer (this is handling a wrapped event for the example wrapping layer):
		if the event type of E is the line input event type:
			while within the jump window via the example wrapping layer:
				say "Command acknowledged.";
				now expecting a side command is false;
				write the first associated value of E as the command buffer's length;
				reparse the command buffer;
		decide on routing the event normally.

Again, we depend on some I6 inclusions to modify the otherwise hidden command
buffer:

	To write (N - a number) as the command buffer's length: (- (buffer-->0)={N}; -).
	To reparse the command buffer: (- VM_Tokenise(buffer,parse);players_command=100+WordCount(); -).

That brings us to Task 3, which is trivial:

	To hide the example window wrapping (this is hiding the example window wrapping):
		hide window wrapping with the example wrapping layer.

To wrap things up, we write the layering rule:

	A Glk layering rule (this is the example window wrapper rule):
		install hiding the example window wrapping as the example wrapping layer whose Glk layer notifications are handled by handling a Glk layer notification for the example wrapping layer and whose foreign events are handled by handling a wrapped event for the example wrapping layer.

a shielding rule, since executing a jump needs to run in an uninstrumented context:

	A GRIF shielding rule:
		shield executing a jump against instrumentation.

and a hook for the jumping behavior:

	After reading a command:
		if the player's command matches "jump":
			execute a jump.

A pastable version of the whole thing appears below:

	*: "Window Jumping" by Brady Garvin

	Use no deprecated features.
	Include Glk Window Wrappers by Brady Garvin.
	
	There is a room.
	
	To decide what wrapped window is a new textual root window: (- glk_window_open(0,0,0,wintype_TextBuffer,0) -).
	To decide what wrapped window is a new frame window split off of (W - a wrapped window): (- glk_window_open({W},winmethod_Left+winmethod_Proportional,50,wintype_Blank,0) -).
	
	To decide what number is the maximum length of the command buffer: (- 118 -).
	To decide what number is the address of the command buffer: (- (buffer+4) -).
	To fill the command buffer with spaces:
		repeat with the index running over the half-open interval from zero to the maximum length of the command buffer:
			let the character address be the address of the command buffer plus the index;
			write the byte 32 [space] to address the character address.
	
	To write (N - a number) as the command buffer's length: (- (buffer-->0)={N}; -).
	To reparse the command buffer: (- VM_Tokenise(buffer,parse);players_command=100+WordCount(); -).
	
	The example wrapping layer is a wrapping layer that varies.
	The side window is a wrapped window that varies.
	
	To decide what wrapped window is the jump window:
		if the multiple windows supported flag is set in the example wrapping layer:
			decide on the side window;
		decide on the sole window according to the Glk layer after the example wrapping layer.
	
	Expecting a side command is a truth state that varies.  Expecting a side command is false.
	
	To handle the Glk layer notification (N - a Glk layer notification) for the example wrapping layer (this is handling a Glk layer notification for the example wrapping layer):
		if N is:
			-- Glk recovery needed:
				recover windows and streams for the example wrapping layer;
				if the multiple windows supported flag is set in the example wrapping layer:
					let the root be the root wrapped window;
					if the root is null:
						now the side window is a new textual root window;
						let the frame be a new frame window split off of the side window;
						write the frame window the frame to the example wrapping layer;
					otherwise:
						let the frame be the key of the root;
						now the side window is the first child of the root according to the example wrapping layer;
						let the side window's sibling be the second child of the root according to the example wrapping layer;
						unless the side window's sibling is the frame or the side window's sibling is the parent of the frame:
							let the swap variable be the side window's sibling;
							now the side window's sibling is the side window;
							now the side window is the swap variable;
						delete the root from the example wrapping layer;
						delete the side window from the example wrapping layer;
						unless the side window's sibling is the frame:
							delete the side window's sibling from the example wrapping layer;
						delete the frame from the example wrapping layer;
						write the frame window the frame to the example wrapping layer;
				otherwise:
					now the side window is a null wrapped window;
					write the frame window a null wrapped window to the example wrapping layer.
	
	To decide what event routing decision is the event routing decision after handling (E - a wrapped event) for the example wrapping layer (this is handling a wrapped event for the example wrapping layer):
		if the event type of E is the line input event type:
			while within the jump window via the example wrapping layer:
				say "Command acknowledged.";
				now expecting a side command is false;
				write the first associated value of E as the command buffer's length;
				reparse the command buffer;
		decide on routing the event normally.
	
	To hide the example window wrapping (this is hiding the example window wrapping):
		hide window wrapping with the example wrapping layer.

	A Glk layering rule (this is the example window wrapper rule):
		install hiding the example window wrapping as the example wrapping layer whose Glk layer notifications are handled by handling a Glk layer notification for the example wrapping layer and whose foreign events are handled by handling a wrapped event for the example wrapping layer.
	
	To request a line event from (W - a wrapped window) to overwrite the command buffer using (A - a wrapping layer) (this is requesting a line event with a wrapping layer):
		prepare a spontaneous Glk invocation;
		write the function selector 208 [glk_request_line_event] to the current Glk invocation;
		write the argument count four to the current Glk invocation;
		write W to argument number zero of the current Glk invocation;
		write the address of the command buffer to argument number one of the current Glk invocation;
		write the maximum length of the command buffer to argument number two of the current Glk invocation;
		write zero to argument number three of the current Glk invocation;
		fill the command buffer with spaces;
		delegate the current Glk invocation to the Glk layer after A.
	
	To execute a jump (this is executing a jump):
		while within the jump window via the example wrapping layer:
			say "Enter a command here.";
			say "> ";
			request a line event from the jump window to overwrite the command buffer using the example wrapping layer;
			now expecting a side command is true;
			while expecting a side command is true:
				wait for the next foreign event using the example wrapping layer;
			say "The command is now '[the player's command]'.[paragraph break]".
	
	A GRIF shielding rule:
		shield executing a jump against instrumentation.
	
	After reading a command:
		if the player's command matches "jump":
			execute a jump.

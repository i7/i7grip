Version 1 of Interactive Debugger (for Glulx only) by Brady Garvin begins here.

"Commands to see what goes on inside an executing story."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Glk Window Wrappers by Brady Garvin.
Include Out-of-Band State Protection by Brady Garvin.
Include Output Interception by Brady Garvin.
Include Punctuated Word Parsing Engine by Brady Garvin.
Include Human-Friendly Function Names by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.
Include Debug File Parsing by Brady Garvin.
Include Call Stack Tracking by Brady Garvin.
Include Breakpoints by Brady Garvin.
Include Verbose Diagnostics by Brady Garvin.
Include Printing according to Kind Names by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Interactive Debugger you will see a sentence like

	A stream log is an invalid stream log.

This bewildering statement actually sets up stream logs as a qualitative value with default value the stream log at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on stream logs.]

Chapter "Use Options"

Use no more than one line input request at a time translates as (- Constant ID_SERIALIZE_LINE_REQUESTS; -).

Use an ideal emulated timer resolution of at least 50 translates as (- Constant ID_IDEAL_TIMER_RESOLUTION={N}; -).

To decide what number is the ideal emulated timer resolution: (- ID_IDEAL_TIMER_RESOLUTION -).

Use the right of the window for the debugger translates as (- Constant ID_RIGHT; -).
Use the left of the window for the debugger translates as (- Constant ID_LEFT; -).
Use the bottom of the window for the debugger translates as (- Constant ID_BOTTOM; -).
Use the top of the window for the debugger translates as (- Constant ID_TOP; -).

Use a debug command buffer size of at least 1024 translates as (- Constant ID_MAX_COMMAND_LENGTH={N}; -).

Use a minimum stream log capacity of at least 1024 translates as (- Constant ID_MIN_STREAM_LOG_CAPACITY={N}; -).

To decide what number is the minimum stream log capacity: (- ID_MIN_STREAM_LOG_CAPACITY -).

Use a user breakpoint hash table size of at least 23 translates as (- Constant ID_USER_BREAKPOINT_HASH_SIZE={N}; -).
Use a user breaktext hash table size of at least 23 translates as (- Constant ID_USER_BREAKTEXT_HASH_SIZE={N}; -).
Use a stream log hash table size of at least 23 translates as (- Constant ID_STREAM_LOG_HASH_SIZE={N}; -).
Use a debugger disambiguation hash table size of at least 11 translates as (- Constant ID_DISAMBIGUATION_HASH_SIZE={N}; -).
Use of debug command parse tree vertex hash table size of at least 23 translates as (- Constant ID_COMMAND_VERTEX_HASH_SIZE={N}; -).
Use of debug command parseme hash table size of at least 311 translates as (- Constant ID_COMMAND_PARSEME_HASH_SIZE={N}; -).

To decide what number is the user breakpoint hash table size: (- ID_USER_BREAKPOINT_HASH_SIZE -).
To decide what number is the user breaktext hash table size: (- ID_USER_BREAKTEXT_HASH_SIZE -).
To decide what number is the stream log hash table size: (- ID_STREAM_LOG_HASH_SIZE -).
To decide what number is the debugger disambiguation hash table size: (- ID_DISAMBIGUATION_HASH_SIZE -).
To decide what number is the debug command parse tree vertex hash table size: (- ID_COMMAND_VERTEX_HASH_SIZE -).
To decide what number is the debug command parseme hash table size: (- ID_COMMAND_PARSEME_HASH_SIZE -).

Use a disambiguation listing length of at least 4 translates as (- Constant ID_DISAMBIGUATION_LISTING_LENGTH={N}; -).
Use a listing window of at least 10 translates as (- Constant ID_LISTING_WINDOW={N}; -).
Use a threshold for lengthy listings of at least 32 translates as (- Constant ID_LENGTHY_LISTING={N}; -).

To decide what number is the disambiguation listing length: (- ID_DISAMBIGUATION_LISTING_LENGTH -).
To decide what number is the listing window radius: (- (ID_LISTING_WINDOW/2) -).
To decide what number is the threshold for lengthy listings: (- ID_LENGTHY_LISTING -).

Chapter "Forced Use Options"

Use universal breakpoint flags of at least 2. [Index zero for Inform internals, index one for everything else.]

Chapter "Constants" - unindexed

To decide what number is the effectively infinite listing limit: (- 134217727 -).

Chapter "Temporary Workarounds" - unindexed

To handle the debug command rooted at (V - a parse tree vertex) using a workaround for Inform bug 825:
	handle the debug command rooted at V.

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at requesting multiple debug commands:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I tried to request a debug command before the previous request had been fulfilled.[terminating the story]".

To fail at using debug command disambiguating for a non-question:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I was asked to ask a debug command disambiguation question with only one possible answer; the disambiguation machinery must have gone awry.[terminating the story]".

To fail at finding a routine record for a sequence point with a source line record:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I tried to find the debug information for a function, but couldn't, even though I have debug information for lines within that function.[terminating the story]".

To fail at finding I7 in a line shared by several routines:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I tried to find the routine containing a line of I7, but found either zero or several routines.[terminating the story]".

To fail at encountering a divider in the last-seen call stack:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]As the call stack was not empty when I last showed the debug prompt, I would have expected one of its frames to have been selected at that time too.  But my bookkeeping argues otherwise.[terminating the story]".

To fail at matching a divider when finish is ignoring an interruption:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]As the call stack was not enough of an argument to convince the debug command 'finish' to consider itself complete, I would have expected the frame that was selected when I last showed the debug prompt to still be around.  But my bookkeeping argues otherwise.[terminating the story]".

To fail at finding a routine record for a kernel:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I was able to find a routine kernel, but no routine record for that kernel, which is awfully strange.  Probably my bookkeeping has been corrupted.[terminating the story]".

To fail at finding a preamble for a routine shell:
	say "[runtime failure in]Interactive Debugger[with explanation]I was able to find a routine shell, but no I7 preamble for that shell.  Probably my bookkeeping has been corrupted.[continuing anyway]".

To fail at forcing a breakpoint from the debugger in an unknown coexecution state:
	say "[runtime failure in]Interactive Debugger[with explanation]I failed to consistently determine the execution state of the story, and am unable to report any caveats that might apply to this forced breakpoint, or even whether it will apply at all.[continuing anyway]".

To fail at being the first to run the story:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I tried to run the story for the first time, but my bookkeeping indicates that it is already running.  I must therefore be confused.[terminating the story]".

To fail at recovering the debugger windows:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I couldn't tell which of the existing windows are the ones belonging to the debugger, and am therefore unable to reclaim them.[terminating the story]".

To fail at iterating from a given sequence point:
	say "[runtime failure in]Interactive Debugger[with explanation]I failed to find the assembly instruction at what I believed to be a sequence point; either the code has changed while the story was running or I have become confused.[continuing anyway]".

To fail at understanding a debugging language:
	say "[runtime failure in]Interactive Debugger[with explanation]I failed to understand the given debugging language.  Probably my grammar has been updated to include it, but the code for translating it to a debug mode has not.[continuing anyway]".

To fail at finding the text for a breaktext:
	say "[runtime failure in]Interactive Debugger[with explanation]I failed to find (let alone understand) the given text when given a command to create a breaktext.  Probably my grammar and my text extraction code disagree on formatting details.[continuing anyway]".

To fail at checking retired characters in a stream log:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I attempted to check recent output for a breaktext, but the stream log was too short.  The code to rotate long output through short logs probably has a bug.[terminating the story]".

To fail at recognizing a debugger serialization format:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I attempted to deserialize the debugger state from a temporary file, but found that the file doesn't adhere to a format I recognize.[terminating the story]".

To fail at serializing the debugger's parse of a command:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I attempted to serialize a parse tree of one of your commands, but discovered in it unencodable inconsistencies.[terminating the story]".

To fail at deserializing the debugger's parse of a command:
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I attempted to deserialize a parse tree of one of your commands, but found it undecodable.[terminating the story]".

Book "Simulated Parallelism"

Part "Parallelism State" - unindexed

Chapter "Running and Continuing Flags" - unindexed

The debugger's story-restarted flag is a truth state that varies.  The debugger's story-restarted flag is false.
The debugger's story-has-run flag is a truth state that varies.  The debugger's story-has-run flag is false.
The debugger's story-running flag is a truth state that varies.  The debugger's story-running flag is false.
The debugger's story-continuing flag is a truth state that varies.  The debugger's story-continuing flag is false.

Chapter "Coexecution State" - unindexed

A debugger coexecution state is a kind of value.
The debugger coexecution states are story interrupted, story waiting for input, and story unpaused.

The current debugger coexecution state is a debugger coexecution state that varies.  The current debugger coexecution state is story unpaused.

The debugger input event flushing flag is a truth state that varies.  The debugger input event flushing flag is false.

The debugger prompting flag is a truth state that varies.  The debugger prompting flag is true.

Part "Separation of the VM and Story Startup"

Chapter "Initial Breakpoint"

A last GRIF instrumented post-hijacking rule (this is the initial breakpoint rule):
	force a breakpoint named "The initial breakpoint";
	now the debugger's story-running flag is true.

Part "Separation of the VM and Story Shutdown"

Chapter "Idle on Quit" - unindexed

Include (-
	Array id_ignoredEvent --> 4;
	[ id_idleOnQuit;
		(+ the debugger's story-running flag +)=false;
		for(::){
			glk_select(id_ignoredEvent);
		}
	];
-).

To decide what number is the address of the idle-on-quit routine: (- id_idleOnQuit -).

Chapter "Limiting Story Quits"

Section "Temporary Space for Limiting Story Quits" - unindexed

Include (-
	Array id_glkPops --> 8;
-).

To decide what number is where stack pops from Glk invocations are temporarily saved for limiting story quits: (- id_glkPops -).

Section "Instruction Vertices for Limiting Story Quits" - unindexed

[ @callf <idle-on-quit-function> 0; ]
To decide what instruction vertex is a new idle-on-quit instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the address of the idle-on-quit routine with return mode the zero-or-discard addressing mode.

[ @jeq <P-in-mode-M> 1 <constant>; ]
To decide what instruction vertex is a new conditional jump-to-idle-on-quit instruction vertex for mode (M - an addressing mode) and parameter (P - a number):
	let the result be a new artificial instruction vertex;
	write the operation code op-jeq to the result;
	write the addressing mode M to parameter zero of the result;
	write P to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write one to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

Section "Instrumentation Rule for Limiting Story Quits"

A GRIF instrumentation rule (this is the limit effects of story quits to the story rule):
	if the no more than one line input request at a time option is not active:
		repeat with the instruction vertex running through occurrences of the operation code op-quit in the scratch space:
			write the operation code op-callf to the instruction vertex;
			write the addressing mode constant addressing mode to parameter zero of the instruction vertex;
			write the address of the idle-on-quit routine to parameter zero of the instruction vertex;
			write the addressing mode zero-or-discard addressing mode to parameter one of the instruction vertex;
		repeat with the instruction vertex running through occurrences of the operation code op-glk in the scratch space:
			let the addressing mode be the addressing mode of parameter zero of the instruction vertex;
			if the addressing mode is the constant addressing mode:
				if parameter zero of the instruction vertex is one:
					write the operation code op-callf to the instruction vertex;
					write the addressing mode constant addressing mode to parameter zero of the instruction vertex;
					write the address of the idle-on-quit routine to parameter zero of the instruction vertex;
					write the addressing mode zero-or-discard addressing mode to parameter one of the instruction vertex;
 			otherwise if the addressing mode is not the zero-or-discard addressing mode:
				cleanse the instruction vertex of stack pops using the array at address where stack pops from Glk invocations are temporarily saved for limiting story quits;
				now the addressing mode is the addressing mode of parameter zero of the instruction vertex;
				let the parameter be parameter zero of the instruction vertex;
				let the jump-to-idle-on-quit instruction vertex be a new conditional jump-to-idle-on-quit instruction vertex for mode the addressing mode and parameter the parameter;
				let the idle-on-quit instruction vertex be a new idle-on-quit instruction vertex;
				insert the jump-to-idle-on-quit instruction vertex before the instruction vertex;
				insert the idle-on-quit instruction vertex at the end of the arrangement;
				establish a jump link from the jump-to-idle-on-quit instruction vertex to the idle-on-quit instruction vertex.

Chapter "Limiting Story Restarts"

Section "Restart from Debugger" - unindexed

To clear pending requests from the extra Glk state (this is clearing pending requests from the extra Glk state):
	repeat with the linked list vertex running through the extra Glk stream state hash table:
		write the value the extra Glk stream state value of the linked list vertex with no character input pending with no line input pending to the linked list vertex.

Include (-
	[ id_restart window;
		(llo_getField((+ canceling any request for a debug input line +),1))();
		for(window=0:window=glk_window_iterate(window,0):){
			switch (glk_window_get_type(window)) {
				wintype_Pair:
				wintype_Blank:
				wintype_TextBuffer:
					glk_cancel_char_event(window);
					glk_cancel_line_event(window,0);
					glk_cancel_hyperlink_event(window);
				wintype_TextGrid:
					glk_cancel_char_event(window);
					glk_cancel_line_event(window,0);
					glk_cancel_mouse_event(window);
					glk_cancel_hyperlink_event(window);
				wintype_Graphics:
					glk_cancel_mouse_event(window);
				default:
					glk_cancel_char_event(window);
					glk_cancel_line_event(window,0);
					glk_cancel_mouse_event(window);
					glk_cancel_hyperlink_event(window);
			}
		}
		(llo_getField((+ clearing pending requests from the extra Glk state +),1))();
		(llo_getField((+ serializing protected state +),1))();
		@restart;
	];
-).

To decide what number is restarting the story from the debugger: (- id_restart -).
To restart the story from the debugger: (- id_restart(); -).

Section "Shielding for Limiting Story Restarts"

A GRIF shielding rule (this is the shield restarting the story from the debugger rule):
	shield restarting the story from the debugger against instrumentation.

Section "Instrumentation Rule for Limiting Story Restarts"

A last GRIF instrumentation rule (this is the limit effects of story restarts to the story rule):
	repeat with the instruction vertex running through occurrences of the operation code op-restart in the scratch space:
		write the operation code op-callf to the instruction vertex;
		write the addressing mode constant addressing mode to parameter zero of the instruction vertex;
		write restarting the story from the debugger to parameter zero of the instruction vertex;
		write the addressing mode zero-or-discard addressing mode to parameter one of the instruction vertex.

Part "Transfer of Control"

Chapter "Forcing a Breakpoint as an Out-of-World Action"

Forcing a breakpoint is an action out of world applying to nothing.
Understand "force a breakpoint" as forcing a breakpoint.

Carry out forcing a breakpoint:
	force a breakpoint named "The out-of-world action 'forcing a breakpoint'".

Part "User Interface" - unindexed

Chapter "Window Wrapping" - unindexed

The debugger wrapping layer is a wrapping layer that varies.
The debugger side window is a wrapped window that varies.

Section "Window Constructors" - unindexed

Include (-
	#ifdef ID_RIGHT;
	Constant ID_METHOD_INDEX=0;
	#ifnot;
	#ifdef ID_LEFT;
	Constant ID_METHOD_INDEX=1;
	#ifnot;
	#ifdef ID_BOTTOM;
	Constant ID_METHOD_INDEX=2;
	#ifnot;
	#ifdef ID_TOP;
	Constant ID_METHOD_INDEX=3;
	#ifnot;
	Constant ID_METHOD_INDEX=0;
	#endif;
	#endif;
	#endif;
	#endif;
-) after "Definitions.i6t".

Include (-
	[ id_method;
		switch(ID_METHOD_INDEX){
			1:
				return winmethod_Right+winmethod_Proportional;
			2:
				return winmethod_Above+winmethod_Proportional;
			3:
				return winmethod_Below+winmethod_Proportional;
		}
		return winmethod_Left+winmethod_Proportional;
	];
-).

To decide what wrapped window is a new debugger root window: (- glk_window_open(0,0,0,wintype_TextBuffer,0) -).
To decide what wrapped window is a new frame window split off of the debugger root window: (- glk_window_open(glk_window_get_root(),id_method(),50,wintype_Blank,0) -).
To decide whether (W - a wrapped window) could be a frame window: (- (glk_window_get_type({W})==wintype_Blank) -).

Section "Window Accessors" - unindexed

To decide what wrapped window is the debugger window:
	if the multiple windows supported flag is set in the debugger wrapping layer:
		decide on the debugger side window;
	decide on the sole window according to the Glk layer after the debugger wrapping layer.

Section "Glk Layer" - unindexed

The debugger's emulated timer resolution is a number that varies.  The debugger's emulated timer resolution is zero.
The debugger's emulated timer interval is a number that varies.  The debugger's emulated timer interval is zero.
The debugger's emulated timer interval remaining is a number that varies.  The debugger's emulated timer interval remaining is zero.

To hide the debugger window wrapping (this is hiding the debugger window wrapping):
	if the multiple windows supported flag is set in the debugger wrapping layer and the no more than one line input request at a time option is not active:
		if the function selector of the current Glk invocation is:
			-- 214: [glk_request_timer_events]
				now the debugger's emulated timer interval is argument number zero of the current Glk invocation;
				now the debugger's emulated timer interval remaining is the debugger's emulated timer interval;
				if the debugger's emulated timer interval is less than the ideal emulated timer resolution:
					now the debugger's emulated timer resolution is the debugger's emulated timer interval;
				otherwise:
					now the debugger's emulated timer resolution is the ideal emulated timer resolution;
				write the debugger's emulated timer resolution to argument number zero of the current Glk invocation;
				if timestamps are supported:
					let the discarded value be the number of milliseconds elapsed since the last timestamp;
	hide window wrapping with the debugger wrapping layer.

Section "Glk Layer Notification Handler for the Glk Layer" - unindexed

To handle the Glk layer notification (N - a Glk layer notification) for the debugger wrapping layer (this is handling a Glk layer notification for the debugger wrapping layer):
	if N is:
		-- Glk recovery needed:
			recover windows and streams for the debugger wrapping layer;
			if the multiple windows supported flag is set in the debugger wrapping layer:
				let the root be the root wrapped window;
				if the root is null:
					now the debugger side window is a new debugger root window;
					let the frame be a new frame window split off of the debugger root window;
					write the frame window the frame to the debugger wrapping layer;
				otherwise:
					let the frame be the key of the root;
					now the debugger side window is the first child of the root according to the debugger wrapping layer;
					let the debugger side window's sibling be the second child of the root according to the debugger wrapping layer;
					if the first child of the debugger side window's sibling according to the debugger wrapping layer is null:
						if the first child of the debugger side window according to the debugger wrapping layer is null:
							if the debugger side window could be a frame window:
								let the swap variable be the debugger side window's sibling;
								now the debugger side window's sibling is the debugger side window;
								now the debugger side window is the swap variable;
							otherwise:
								always check that the debugger side window's sibling could be a frame window or else fail at recovering the debugger windows;
						otherwise:
							let the swap variable be the debugger side window's sibling;
							now the debugger side window's sibling is the debugger side window;
							now the debugger side window is the swap variable;
					delete the root from the debugger wrapping layer;
					delete the debugger side window from the debugger wrapping layer;
					unless the debugger side window's sibling is the frame:
						delete the debugger side window's sibling from the debugger wrapping layer;
					delete the frame from the debugger wrapping layer;
					write the frame window the frame to the debugger wrapping layer;
			otherwise:
				now the debugger side window is a null wrapped window;
				write the frame window a null wrapped window to the debugger wrapping layer;
			while within the debugger window via the debugger wrapping layer:
				say "[the debugger banner text]";
			cancel any request for a debug input line;
		-- story yielding:
			if the multiple windows supported flag is set in the debugger wrapping layer and the no more than one line input request at a time option is not active:
				prepare a spontaneous Glk invocation;
				write the function selector 214 [glk_request_timer_events] to the current Glk invocation;
				write the argument count one to the current Glk invocation;
				write one to argument number zero of the current Glk invocation;
				delegate the current Glk invocation to the Glk layer after the debugger wrapping layer;
				now the current debugger coexecution state is story unpaused;
				now the debugger input event flushing flag is true;
				wait for the next foreign event using the debugger wrapping layer;
				now the current debugger coexecution state is story waiting for input;
				now the debugger input event flushing flag is false;
				prepare a spontaneous Glk invocation;
				write the function selector 214 [glk_request_timer_events] to the current Glk invocation;
				write the argument count one to the current Glk invocation;
				write the debugger's emulated timer resolution to argument number zero of the current Glk invocation;
				delegate the current Glk invocation to the Glk layer after the debugger wrapping layer.

Section "Event Handler for the Glk Layer" - unindexed

Include (-
	Array id_command -> ID_MAX_COMMAND_LENGTH ;
-) after "Definitions.i6t".

To decide what number is the address of the debug command buffer: (- id_command -).
To decide what number is the maximum length of the debug command buffer: (- ID_MAX_COMMAND_LENGTH -).

The debugger's line input handler is a phrase text -> nothing that varies.

Include (-
#ifndef gestalt_DateTime;
	Constant gestalt_DateTime 20;
#endif;
#ifndef glk_current_time;
	[ glk_current_time _vararg_count ret;
	! glk_current_time (time)
	  ! And now the @glk call
	  @glk $160 _vararg_count ret;
	  return ret;
	];
#endif;
-) after "Definitions.i6t".

Include (-
	Array id_previousTimestamp --> 3;
	Array id_timestamp --> 3;
	[ id_timestampSupport;
		return glk_gestalt(gestalt_DateTime,0);
	];
	[ id_getMsTimestampDifference
		highDifference lowDifference microDifference test;
		llo_copy(12,id_timestamp,id_previousTimestamp);
		glk_current_time(id_timestamp);
		highDifference=(id_timestamp-->0)-(id_previousTimestamp-->0);
		lowDifference=(id_timestamp-->1)-(id_previousTimestamp-->1);
		microDifference=(id_timestamp-->2)-(id_previousTimestamp-->2);
		if(microDifference<0){
			microDifference=microDifference+1000000;
			lowDifference=lowDifference-1;
		}
		@jgtu lowDifference 2147482 ?overflow;
		if(((id_timestamp-->1)>0)&&((id_previousTimestamp-->1)<0)){
			highDifference=highDifference-1;
		}
		if(highDifference){
			.overflow;
			return 2147483647;
		}
		return lowDifference*1000+microDifference/1000;
	];
-).

To decide what number is the address of the timestamp-support-checking function: (- id_timestampSupport -).
To decide what number is the address of the timestamp differencing function: (- id_getMsTimestampDifference -).

A GRIF shielding rule (this is the shield timestamp functions for timer emulation rule):
	shield the address of the timestamp-support-checking function against instrumentation;
	shield the address of the timestamp differencing function against instrumentation.

To decide whether timestamps are supported: (- id_timestampSupport() -).
To decide what number is the number of milliseconds elapsed since the last timestamp: (- id_getMsTimestampDifference() -).

To decide what event routing decision is the event routing decision after handling (E - a wrapped event) for the debugger wrapping layer (this is handling a wrapped event for the debugger wrapping layer):
	if the event type of E is the timer event type and the multiple windows supported flag is set in the debugger wrapping layer and the no more than one line input request at a time option is not active:
		if the debugger input event flushing flag is false:
			if timestamps are supported:
				decrease the debugger's emulated timer interval remaining by the number of milliseconds elapsed since the last timestamp;
			otherwise:
				decrease the debugger's emulated timer interval remaining by the debugger's emulated timer resolution;
			if the debugger's emulated timer interval remaining is at most zero:
				now the debugger's emulated timer interval remaining is the debugger's emulated timer interval;
				decide on routing the event normally;
		decide on routing the event no further;
	if the event type of E is the line input event type:
		while within the debugger window via the debugger wrapping layer:
			let the remembered handler be the debugger's line input handler;
			now the debugger's line input handler is the default value of phrase text -> nothing;
			let the length be the first associated value of E;
			let the command be a new synthetic text extracted from the length bytes at address the address of the debug command buffer;
			apply the remembered handler to the command;
			delete the synthetic text the command;
	decide on routing the event normally.

Section "Input Requests" - unindexed

To cancel any request for a debug input line (this is canceling any request for a debug input line):
	if the debugger's line input handler is the default value of phrase text -> nothing:
		stop;
	prepare a spontaneous Glk invocation;
	write the function selector 209 [glk_cancel_line_event] to the current Glk invocation;
	write the argument count two to the current Glk invocation;
	write the debugger window to argument number zero of the current Glk invocation;
	write zero to argument number one of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after the debugger wrapping layer;
	now the debugger's line input handler is the default value of phrase text -> nothing;
	while within the debugger window via the debugger wrapping layer:
		say "(input interrupted)[line break]".

To request a debug input line to be handled by (H - a phrase text -> nothing):
	always check that the debugger's line input handler is the default value of phrase text -> nothing or else fail at requesting multiple debug commands;
	now the debugger's line input handler is H;
	prepare a spontaneous Glk invocation;
	write the function selector 208 [glk_request_line_event] to the current Glk invocation;
	write the argument count four to the current Glk invocation;
	write the debugger window to argument number zero of the current Glk invocation;
	write the address of the debug command buffer to argument number one of the current Glk invocation;
	write the maximum length of the debug command buffer to argument number two of the current Glk invocation;
	write zero to argument number three of the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after the debugger wrapping layer.

Section "The Layering Rule" - unindexed

A Glk layering rule (this is the debugger window wrapper rule):
	install hiding the debugger window wrapping as the debugger wrapping layer whose Glk layer notifications are handled by handling a Glk layer notification for the debugger wrapping layer and whose foreign events are handled by handling a wrapped event for the debugger wrapping layer.

Book "Debugger State"

Chapter "Debug Modes"

A debug mode is a kind of value.  The debug modes are debugging at the I7 level, debugging at the I6 level, and debugging at the Glulx assembly level.
The specification of a debug mode is "Debug modes represent a preferred language for debugging: I7, I6, or Glulx assembly."

Section "Preferred Debug Modes" - unindexed

The currently preferred debug mode is a debug mode that varies.  The currently preferred debug mode is debugging at the I7 level.

To decide what debug mode is the preferred debug mode for (R - a routine record):
	if R is an invalid routine record or the function at address the function address of R is a default veneer routine:
		decide on debugging at the Glulx assembly level;
	if the source version of R is less than seven:
		decide on debugging at the I6 level;
	decide on debugging at the I7 level.

Chapter "Preferences"

[GRIF defines:]
[The GRIF allows saves flag is a truth state that varies.]

[Call Stack Tracking defines:]
[The original arguments flag is a truth state that varies.
The temporary named values flag is a truth state that varies.
The catch tokens flag is a truth state that varies.
The call stack simplification flag is a truth state that varies.
The call frame numbering flag is a truth state that varies.
The call stack addresses flag is a truth state that varies.]

Section "Warnings"

The showme warnings flag is a truth state that varies.
The lengthly listing warnings flag is a truth state that varies.

Section "Default Preferences"

A GRIF setup rule (this is the default debugger preferences rule):
	now the original arguments flag is true;
	now the temporary named values flag is true;
	now the catch tokens flag is false;
	now the call stack simplification flag is true;
	now the call frame numbering flag is true;
	now the showme warnings flag is true;
	now the lengthly listing warnings flag is true;
	now the GRIF allows saves flag is false.

Chapter "Current Call Frame" - unindexed

The debugger's current call frame number is a number that varies.
The debugger's current call frame is a call frame that varies.

Section "Sequence Point to Highlight" - unindexed

To decide what number is the sequence point to highlight:
	decide on the last-seen sequence point of the debugger's current call frame or the last-seen sequence point before the last-seen breakpoint if it is innermost.

Chapter "Control Flow Manipulation" - unindexed

A debugger control flow state is a kind of value.  The debugger control flow states are responding after a continue, responding after a sequence point step, responding after a sequence point next, responding after a step, responding after a next, and responding after a finish.  The specification of a debugger control flow state is "Debugger control flow states are used by the debugger to remember what it was doing when it receives a breakpoint notification.  Generally they record the last command executed."

A debugger control flow attitude is a kind of value.  The debugger control flow attitude are responding after a cautious advance and responding after an assured advance.  The specification of a debugger control flow attitude is "Debugger control flow attitudes are used by the debugger to remember how it was proceeding when it receives a breakpoint notification.  Cautious advances, those that check on the story state at every opportunity, are used until the debugger is free from at least one previously seen breakpoint.  Assured advances are used thereafter, and pause only as needed for the command they carry out."

[This is the control flow state, as described above.]
The debugger's control flow state is a debugger control flow state that varies.

[This is the control flow attitude, as described above.]
The debugger's control flow attitude is a debugger control flow attitude that varies.

[We remember what the call stack looked like by keeping a copy here.  More specifically, we store the *outermost* call frame, since that makes life easier in the main debugger routine.  Be careful: not all call frame phrases work if we've changed the call stack in the meantime.]
The last-seen call stack root is a call frame that varies.

[We also keep track of the frame that was selected.]
The last-seen call stack divider is a call frame that varies.

[And on top of that, the sequence point last seen.]
The last-seen sequence point for the last-seen call stack is a number that varies.

[If we were stopped by one or more breakpoints last time we talked with the author we don't want to report those breakpoints again unless the set has changed.  So we keep the old set here.]
The last-seen compound breakpoint list is a linked list that varies.

Chapter "User Breakpoints" - unindexed

[Maps breakpoint numbers to compound breakpoints]
The user breakpoint hash table is a hash table that varies.

Chapter "Active Stream Logs" - unindexed

[Maps stream numbers to stream logs]
The stream log hash table is a hash table that varies.

Chapter "User Breaktexts" - unindexed

The length of the longest breaktext is a number that varies.  The length of the longest breaktext is zero.

To decide what number is the capacity corresponding to the longest breaktext:
	let the result be four [overestimation to reduce churn] times four [conversion to bytes] times the length of the longest breaktext;
	if the result is less than the minimum stream log capacity:
		decide on the minimum stream log capacity;
	decide on the result.

[Maps breaktext numbers to breaktexts]
The user breaktext hash table is a hash table that varies.

The breaktext encountered flag is a truth state that varies.  The breaktext encountered flag is false.

Chapter "Debugger Initialization" - unindexed

A GRIF setup rule (this is the initialize the debugger state rule):
	now the debugger's control flow state is responding after a continue;
	now the debugger's control flow attitude is responding after an assured advance;
	now the debugger's current call frame is a null call frame;
	now the last-seen call stack root is a null call frame;
	now the last-seen call stack divider is a null call frame;
	now the last-seen compound breakpoint list is an empty linked list;
	now the user breakpoint hash table is a new hash table with the user breakpoint hash table size buckets;
	now the stream log hash table is a new hash table with the stream log hash table size buckets;
	now the user breaktext hash table is a new hash table with the user breaktext hash table size buckets.

Chapter "Debugger State Serialization" - unindexed

To serialize (A - a punctuated word array):
	let the length be the word count of A;
	serialize the length;
	repeat with the index running over the half-open interval from zero to the length:
		serialize the synthetic text word index of A.

To serialize (V - parse tree vertex):
	let the vertex index hash table be a new hash table with the debug command parse tree vertex hash table size buckets;
	let the index be zero;
	let the vertex be V;
	while the vertex is not null:
		insert the key the vertex and the value the index into the vertex index hash table;
		increment the index;
		now the vertex is the parse tree vertex to visit after the vertex;
	serialize the index;
	let the parser be the owner of the parseme of V;
	let the parseme index hash table be a new hash table with the debug command parseme hash table size buckets;
	now the index is zero;
	repeat with the parseme running through the parseme keys of the parseme linked list of the parser:
		insert the key the parseme and the value the index into the parseme index hash table;
		increment the index;
	now the vertex is V;
	while the vertex is not null:
		let the parseme be the parseme of the vertex;
		serialize the first number value matching the key the parseme in the parseme index hash table or -1 if there are no matches;
		if the parseme is a nonterminal:
			let production serialized be false;
			let the vertex's production be the production of the vertex;
			now the index is zero;
			repeat with the indexed production running through the production keys of the production linked list of the parseme:
				if the vertex's production is the indexed production:
					serialize the index;
					now production serialized is true;
					break;
				increment the index;
			always check that production serialized is true or else fail at serializing the debugger's parse of a command;
		serialize the first number value matching the key the first child of the vertex in the vertex index hash table or -1 if there are no matches;
		serialize the first number value matching the key the last child of the vertex in the vertex index hash table or -1 if there are no matches;
		serialize the first number value matching the key the left sibling of the vertex in the vertex index hash table or -1 if there are no matches;
		serialize the first number value matching the key the right sibling of the vertex in the vertex index hash table or -1 if there are no matches;
		serialize the beginning lexeme index of the vertex;
		serialize the end lexeme index of the vertex;
		now the vertex is the parse tree vertex to visit after the vertex;
	delete the vertex index hash table;
	delete the parseme index hash table.

To serialize (C - a compound breakpoint):
	serialize the numeric identifier of C;
	serialize the synthetic text the human-friendly name of C; [////]
	let the simple breakpoint list be the simple breakpoint list of C;
	serialize the length of the simple breakpoint list;
	repeat with the simple breakpoint running through the simple breakpoint keys of the simple breakpoint list:
		serialize the sequence point of the simple breakpoint;
	serialize whether or not C is enabled.

To serialize (B - a breaktext):
	serialize the numeric identifier of B;
	serialize the synthetic text the human-friendly name of B; [////]
	let the codepoint count be the codepoint count of B;
	serialize the codepoint count;
	serialize the codepoint count times four bytes at address the codepoint array address of B;
	serialize whether or not B is enabled;
	serialize whether or not B is triggered.

To serialize (L - a stream log):
	serialize the log capacity of L;
	serialize the log length of L;
	serialize the log length of L times four bytes at address the log address of L.

Chapter "Debugger Deserialization" - unindexed

To decide what punctuated word array is a deserialized punctuated word array:
	let the word count be a deserialized number;
	let the size be the size in memory of a punctuated word array for the word count punctuated words;
	let the result be a memory allocation of size bytes converted to a punctuated word array;
	write the word count the word count to the result;
	repeat with the index running over the half-open interval from zero to the word count:
		write a deserialized synthetic text to word index of the result;
	decide on the result.

To decide what parse tree vertex is a deserialized parse tree vertex for (A - a context-free parser):
	let the parseme hash table be a new hash table with the debug command parseme hash table size buckets;
	let the index be zero;
	repeat with the parseme running through the parseme keys of the parseme linked list of A:
		insert the key the index and the value the parseme into the parseme hash table;
		increment the index;
	let the vertex count be a deserialized number;
	let the vertex hash table be a new hash table with the debug command parse tree vertex hash table size buckets;
	repeat with the second index running over the half-open interval from zero to the vertex count:
		let the vertex be a new parse tree root for an invalid parseme;
		insert the key the second index and the value the vertex into the vertex hash table;
	repeat with the second index running over the half-open interval from zero to the vertex count:
		let the vertex be the first parse tree vertex value matching the key the second index in the vertex hash table or an invalid parse tree vertex if there are no matches;
		always check that the vertex is not an invalid parse tree vertex or else fail at deserializing the debugger's parse of a command;
		let the parseme be the first parseme value matching the key a deserialized number in the parseme hash table or an invalid parseme if there are no matches;
		write the parseme the parseme to the vertex;
		if the parseme is a nonterminal:
			let the production index be a deserialized number;
			if the production index is at least zero:
				repeat with the production running through the production keys of the production linked list of the parseme:
					decrement the production index;
					if the production index is zero:
						write the production the production to the vertex;
		write the first child the first parse tree vertex value matching the key a deserialized number in the vertex hash table or a null parse tree vertex if there are no matches to the vertex;
		write the last child the first parse tree vertex value matching the key a deserialized number in the vertex hash table or a null parse tree vertex if there are no matches to the vertex;
		write the left sibling the first parse tree vertex value matching the key a deserialized number in the vertex hash table or a null parse tree vertex if there are no matches to the vertex;
		write the right sibling the first parse tree vertex value matching the key a deserialized number in the vertex hash table or a null parse tree vertex if there are no matches to the vertex;
		write the beginning lexeme index a deserialized number to the vertex;
		write the end lexeme index a deserialized number to the vertex;
	let the result be the first parse tree vertex value matching the key zero in the vertex hash table or an invalid parse tree vertex if there are no matches;
	always check that the result is not an invalid parse tree vertex or else fail at deserializing the debugger's parse of a command;
	decide on the result.

To decide what compound breakpoint is a deserialized compound breakpoint:
	let the saved breakpoint counter be the breakpoint counter;
	now the breakpoint counter is a deserialized number;
	let the human-friendly name be a deserialized synthetic text;
	let the result be a new compound breakpoint with human-friendly name the human-friendly name;
	now the breakpoint counter is the saved breakpoint counter;
	delete the synthetic text the human-friendly name;
	let the sequence point count be a deserialized number;
	repeat with a counter running from one to the sequence point count:
		let the sequence point be a deserialized number;
		attach the sequence point the sequence point to the result;
	if a deserialized truth state is true:
		enable the result;
	decide on the result.

To decide what breaktext is a deserialized breaktext:
	let the saved breakpoint counter be the breakpoint counter;
	now the breakpoint counter is a deserialized number;
	let the human-friendly name be a deserialized synthetic text;
	let the codepoint count be a deserialized number;
	let the codepoint array address be a possibly zero-length memory allocation of the codepoint count times four bytes;
	deserialize the codepoint count times four bytes to address the codepoint array address;
	let the result be a new breaktext for the codepoint count codepoints at address the codepoint array address named the human-friendly name;
	now the breakpoint counter is the saved breakpoint counter;
	delete the synthetic text the human-friendly name;
	if a deserialized truth state is true:
		enable the result;
	if a deserialized truth state is true:
		trigger the result;
	decide on the result.

To decide what stream log is a deserialized stream log:
	let the result be a new stream log with capacity of at least a deserialized number bytes;
	let the length be a deserialized number;
	write the log length the length to the result;
	deserialize the length bytes to address the log address of the result;
	decide on the result.

Chapter "Serialization/Deserialization Rule"

[////]
To decide what number is the debugger state magic number: (- 1765239140 -). [ASCII for "i7id"]

To decide what number is the debugger state file format version number: (- 0 -).

A protected state serialization/deserialization rule (this is the serializing and deserializing the debugger state rule):
	if serializing rather than deserializing:
		serialize the debugger state magic number;
		serialize the debugger state file format version number;
		serialize the call stack simplification flag;
		serialize the showme warnings flag;
		serialize the lengthly listing warnings flag;
		serialize the last-seen debug command punctuated words;
		serialize the last-seen debug command vertex;
		serialize the breakpoint counter;
		serialize the number of entries in the user breakpoint hash table;
		repeat with the compound breakpoint running through the compound breakpoint values of the user breakpoint hash table:
			serialize the compound breakpoint;
		serialize the number of entries in the user breaktext hash table;
		repeat with the breaktext running through the breaktext values of the user breaktext hash table:
			serialize the breaktext;
		serialize the number of entries in the stream log hash table;
		repeat with linked list vertex running through the stream log hash table:
			serialize the number key of the linked list vertex;
			serialize the stream log value of the linked list vertex;
	otherwise if there is data to deserialize:
		always check that a deserialized number is the debugger state magic number or else fail at recognizing a debugger serialization format;
		always check that a deserialized number is the debugger state file format version number or else fail at recognizing a debugger serialization format;
		now the call stack simplification flag is whether or not a deserialized truth state is true;
		now the showme warnings flag is whether or not a deserialized truth state is true;
		now the lengthly listing warnings flag is whether or not a deserialized truth state is true;
		now the last-seen debug command punctuated words are a deserialized punctuated word array;
		now the last-seen debug command vertex is a deserialized parse tree vertex for the debug command parser;
		now the breakpoint counter is a deserialized number;
		let the user breakpoint count be a deserialized number;
		repeat with a counter running from one to the user breakpoint count:
			let the compound breakpoint be a deserialized compound breakpoint;
			insert the key the numeric identifier of the compound breakpoint and the value the compound breakpoint into the user breakpoint hash table;
		let the user breaktext count be a deserialized number;
		repeat with a counter running from one to the user breaktext count:
			let the breaktext be a deserialized breaktext;
			insert the key the numeric identifier of the breaktext and the value the breaktext into the user breaktext hash table;
		let the stream log count be a deserialized number;
		repeat with a counter running from one to the stream log count:
			let the stream be a deserialized number;
			let the stream log be a deserialized stream log;
			insert the key the stream and the value the stream log into the stream log hash table;
		now the debugger's story-restarted flag is true;
		now the banner printed flag is true.

Book "Debugger Instrumentation" - unindexed

Chapter "Finish Detection in Follow-on Calls" - unindexed

Section "Frame-Local Flag for Tripwires" - unindexed

The follow-on call tripwire flag index is a number that varies.

A GRIF setup rule (this is the allocate the follow-on call tripwire flag rule):
	now the follow-on call tripwire flag index is the index of a newly reserved call frame field.

Section "Tripwire Insertion" - unindexed

[ @jz <frame-local-tripwire-flag> <constant>; ]
To decide what instruction vertex is a new tripwire instruction vertex:
	let the result be a new artificial instruction vertex;
	write the operation code op-jz to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write extra field address follow-on call tripwire flag index of call frames for the chunk being instrumented as seen by that chunk to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	decide on the result.

A GRIF instrumentation rule (this is the insert tripwires to detect follow-on calls when the debugger is executing its finish command rule):
	repeat with the instruction vertex running through occurrences of function call in the scratch space:
		unless the instruction vertex is artificial or the source address of the instruction vertex is a sequence point:
			let the pre-call tripwire instruction vertex be a new tripwire instruction vertex;
			let the pre-call breakpoint-enabling instruction vertex be a new artificial instruction vertex for a zero-argument call to the function at address the function address of enabling the universal breakpoint with return mode the zero-or-discard addressing mode;
			let the post-call tripwire instruction vertex be a new tripwire instruction vertex;
			let the post-call breakpoint-disabling instruction vertex be a new artificial instruction vertex for a zero-argument call to the function at address the function address of disabling the universal breakpoint with return mode the zero-or-discard addressing mode;
			insert the pre-call tripwire instruction vertex before the instruction vertex;
			insert the pre-call breakpoint-enabling instruction vertex before the instruction vertex;
			insert the post-call breakpoint-disabling instruction vertex after the instruction vertex;
			insert the post-call tripwire instruction vertex after the instruction vertex;
			establish a jump link from the pre-call tripwire instruction vertex to the instruction vertex;
			establish a jump link from the post-call tripwire instruction vertex to the next link of the post-call breakpoint-disabling instruction vertex.

Book "Output Interception"

Chapter "Stream Logs" - unindexed

Section "The Stream Log Kind" - unindexed

A stream log is a kind of value.
A stream log is an invalid stream log.  [See the note in the book "Extension Information."]
The specification of a stream log is "A stream log stores characters recently printed to a stream, which Interactive Debugger monitors for the appearance of breaktexts."

Section "The Stream Log Structure" - unindexed

[Layout:
	4 bytes for the log capacity (in bytes, which we call N)
	4 bytes for the log length (in bytes)
	N bytes for the log]

To decide what number is the size in memory of a stream log with capacity (N - a number) bytes: (- (8+{N}) -).

Section "Stream Log Construction and Destruction" - unindexed

To decide what stream log is a new stream log with capacity of at least (N - a number) bytes:
	let the capacity be N;
	if the capacity is less than the minimum stream log capacity:
		now the capacity is the minimum stream log capacity;
	let the size be the size in memory of a stream log with capacity the capacity bytes;
	let the result be a memory allocation of the size bytes converted to a stream log;
	write the log capacity the capacity to the result;
	write the log length zero to the result;
	decide on the result.

To delete (A - a stream log):
	free the memory allocation at address A converted to a number.

Section "Stream Log Accessors and Mutators" - unindexed

To decide what number is the log capacity of (A - a stream log): (- llo_getInt({A}) -).
To write the log capacity (X - a number) to (A - a stream log): (- llo_setInt({A},{X}); -).

To decide what number is the log length of (A - a stream log): (- llo_getField({A},1) -).
To write the log length (X - a number) to (A - a stream log): (- llo_setField({A},1,{X}); -).
To clear (A - a stream log): (- llo_setField({A},1,0); -).

To decide what number is the log address of (A - a stream log): (- ({A}+8) -).
To decide what number is the log end address of (A - a stream log): (- ({A}+8+llo_getField({A},1)) -).

Section "Stream Log Appending" - unindexed

To decide what number is the written byte count after appending up to (N - a number) bytes from address (B - a number) to (A - a stream log):
	let the length be the log length of A;
	let the appendable byte count be the log capacity of A minus the length;
	if N is less than the appendable byte count:
		now the appendable byte count is N;
	copy the appendable byte count bytes from address B to address the log end address of A;
	increase the length by the appendable byte count;
	write the log length the length to A;
	decide on the appendable byte count.

Section "Stream Log Scrolling" - unindexed

To scroll (A - a stream log) as far as possible without losing the last (N - a number) byte/bytes:
	let the scroll distance be the log length of A minus N;
	if the scroll distance is at most zero:
		stop;
	let the destination address be the log address of A;
	let the source address be the destination address plus the scroll distance;
	copy the N bytes from address the source address to address the destination address;
	write the log length N to A.

Section "Stream Log Searching" - unindexed

To decide whether (A - a stream log) contains the (N - a number) integer/integers at address (B - a number) overlapping with its last (M - a number) integer/integers:
	always check that the log length of A is at least M or else fail at checking retired characters in a stream log;
	let the relevant integer count be N plus M minus one;
	if the log length of A is less than the relevant integer count:
		now the relevant integer count is the log length of A;
	let the relevant integers' address be the log end address of A minus four times the relevant integer count;
	decide on whether or not the address of the N integers at address B in the relevant integer count integers at address the relevant integers' address is not zero.

Section "Stream Log Expanding" - unindexed

To decide what stream log is a new expansion of (A - a stream log) to have a capacity of at least (N - a number) byte/bytes:
	let the old size be the size in memory of a stream log with capacity the log capacity of A bytes;
	let the capacity be N;
	if the capacity is less than log capacity of A:
		now the capacity is the log capacity of A;
	if the capacity is less than the minimum stream log capacity:
		now the capacity is the minimum stream log capacity;
	let the size be the size in memory of a stream log with capacity the capacity bytes;
	let the result be a memory allocation of the size bytes converted to a stream log;
	copy the old size bytes from address (A converted to a number) to address (the result converted to a number);
	write the log capacity the capacity to the result;
	decide on the result.	

Chapter "Breaktexts" - unindexed

Section "The Breaktext Kind" - unindexed

A breaktext is a kind of value.
A breaktext is an invalid breaktext.  [See the note in the book "Extension Information."]
The specification of a breaktext is "A breaktext represents conditional interruption when a particular piece of text is printed by the story."

Section "The Breaktext Structure" - unindexed

[Layout:
	4 bytes for the numeric identifier
	4 bytes for the human-friendly name as synthetic text
	4 bytes for the codepoint count
	4 bytes for the address of the array of codepoints
	4 bytes for the enabled flag
	4 bytes for the triggered flag]
[Compound breakpoints manage the lifetime of their human-friendly names; those names will be deleted when the breakpoint is.]
[Similarly for their codepoint arrays.]

To decide what number is the size in memory of a breaktext: (- 24 -).

Section "Breaktext Construction and destruction" - unindexed

[T need not be synthetic; it will be copied.]
[The array at address A, on the other hand, will not be copied, and becomes owned by the breaktext.]
To decide what breaktext is a new breaktext for the (N - a number) codepoints at address (A - a number) named (T - some text):
	let the result be a memory allocation of the size in memory of a breaktext bytes converted to a breaktext;
	write the numeric identifier the breakpoint counter to the result;
	increment the breakpoint counter;
	let the human-friendly name be a new synthetic text copied from T;
	write the human-friendly name the human-friendly name to the result;
	write the codepoint count N to the result;
	write the codepoint array address A to the result;
	disable the result;
	untrigger the result;
	decide on the result.

To delete (A - a breaktext):
	delete the synthetic text the human-friendly name of A;
	free the possibly zero-length memory allocation at address the codepoint array address of A;
	free the memory allocation at address A converted to a number.

Section "Private Breaktext Mutators" - unindexed

To write the numeric identifier (X - a number) to (A - a breaktext): (- llo_setInt({A},{X}); -).

To write the human-friendly name (X - some text) to (A - a breaktext): (- llo_setField({A},1,{X}); -).

To write the codepoint count (X - a number) to (A - a breaktext): (- llo_setField({A},2,{X}); -).

To write the codepoint array address (X - a number) to (A - a breaktext): (- llo_setField({A},3,{X}); -).

Section "Public Breaktext Accessors" - unindexed

To decide what number is the numeric identifier of (A - a breaktext): (- llo_getInt({A}) -).

To decide what text is the human-friendly name of (A - a breaktext): (- llo_getField({A},1) -).

To decide what number is the codepoint count of (A - a breaktext): (- llo_getField({A},2) -).
To decide what number is the codepoint array address of (A - a breaktext): (- llo_getField({A},3) -).

To decide whether (A - a breaktext) is disabled: (- (~~llo_getField({A},4)) -).
To decide whether (A - a breaktext) is enabled: (- llo_getField({A},4) -).

To disable (A - a breaktext): (- llo_setField({A},4,0); -).
To enable (A - a breaktext): (- llo_setField({A},4,1); -).

To decide whether (A - a breaktext) is triggered: (- llo_getField({A},5) -).

To untrigger (A - a breaktext): (- llo_setField({A},5,0); -).
To trigger (A - a breaktext): (- llo_setField({A},5,1); -).

Chapter "Breaktext Detection Rule"

An output interception rule (this is the breaktext detection rule):
	if the input-output system of the intercepted output is the Glk input-output system and the stream of the intercepted output is a window stream according to output interception: [ignore cases that are irrelevant or errors]
		unless we are within the debugger window:
			let the stream log be the first stream log value matching the key the stream of the intercepted output in the stream log hash table or an invalid stream log if there are no matches;
			if the stream log is an invalid stream log:
				now the stream log is a new stream log with capacity of at least the capacity corresponding to the longest breaktext bytes;
				insert the key the stream of the intercepted output and the value the stream log into the stream log hash table;
			if the type of the intercepted output is:
				-- valid textual output:
					let the remaining byte count be the length of the intercepted output times four;
					let the remaining output address be the address of the intercepted output;
					repeat until a break:
						let the written byte count be the written byte count after appending up to the remaining byte count bytes from address the remaining output address to the stream log;
						let the written integer count be the written byte count divided by four;
						repeat with the breaktext running through the breaktext values of the user breaktext hash table:
							if the breaktext is enabled:
								let the codepoint count be the codepoint count of the breaktext;
								let the codepoint array address be the codepoint array address of the breaktext;
								if the stream log contains the codepoint count integers at address the codepoint array address overlapping with its last written integer count integers:
									trigger the breaktext;
									enable the universal breakpoint;
									now the breaktext encountered flag is true;
						decrease the remaining byte count by the written byte count;
						if the remaining byte count is zero:
							break;
						increase the remaining output address by the written byte count;
						scroll the stream log as far as possible without losing the last two bytes;
				-- cursor movement:
					clear the stream log.

Book "Main Debugger Routine" - unindexed

Chapter "Interruption Control" - unindexed

To decide what number is the universal breakpoint flag index for the sequence point (A - a number) according to the debugger (this is choosing the universal breakpoint flag index for a sequence point according to the debugger):
	let the routine record be the routine record owning the sequence point A;
	if the routine record is not an invalid routine record and the function at address the function address of the routine record is elided in the simplified call stack:
		decide on zero;
	decide on one.

The phrase that chooses the universal breakpoint flag index for a sequence point is choosing the universal breakpoint flag index for a sequence point according to the debugger.

[Roughly speaking, true unless all call frames and call sites in the current stack and the last-seen one match up.]
To decide whether the call frame changes warrant a distinction from the previous interruptions:
	let the previous call frame be the last-seen call stack root;
	let the current call frame be the root of the debugger's current call frame;
	if the current call frame is null or the previous call frame is null:
		decide on whether or not the current call frame is not the previous call frame;
	let the call site consistency flag be true;
	repeat until a break:
		if the current call frame is null or the previous call frame is null:
			decide on whether or not the current call frame is not the previous call frame;
		unless the call site consistency flag is true:
			decide yes;
		unless the uninstrumented function address of the current call frame is the uninstrumented function address of the previous call frame:
			decide yes;
		now the call site consistency flag is whether or not the most recent instruction address of the current call frame is the most recent instruction address of the previous call frame;
		now the current call frame is the inward link of the current call frame;
		now the previous call frame is the inward link of the previous call frame.

A debugger change direction is a kind of value.  The debugger change directions are a change inward from the reference frame, a change within the reference frame, and a change outward from the reference frame.  The specification of a debugger change direction is "When one of the internal breakpoints for commands like step and next is triggered, the debugger uses debugger change directions to decide whether the breakpoint was fired in the expected way or is merely a false alarm."

To decide whether this interruption should be ignored by the control flow command:
	[The continue command ignores every such thing.]
	if the debugger's control flow state is responding after a continue:
		decide yes;
	[While the sequence point step command never ignores anything.]
	if the debugger's control flow state is responding after a sequence point step:
		decide no;
	let the previous call frame be the last-seen call stack root;
	let the current call frame be the root of the debugger's current call frame;
	[We ought not obliterate the call stack, but, if we do, let us take notice.]
	if the previous call frame is null or the current call frame is null:
		decide no;
	let the change direction be a debugger change direction;
	let the function change flag be false;
	let the previous line comparison call frame be an invalid call frame;
	let the current line comparison call frame be an invalid call frame;
	[Find where the change is and what it is.]
	repeat until a break:
		unless the call stack simplification flag is true and the current call frame is elided in the simplified call stack:
			now the previous line comparison call frame is the previous call frame;
			now the current line comparison call frame is the current call frame;
		unless the uninstrumented function address of the current call frame is the uninstrumented function address of the previous call frame:
			now the change direction is a change outward from the reference frame;
			now the function change flag is true;
			break;
		if the inward link of the previous call frame is null:
			now the change direction is a change within the reference frame;
			break;
		if the inward link of the current call frame is null:
			if the previous call frame is the last-seen call stack divider:
				now the change direction is a change within the reference frame;
				break;
			now the change direction is a change outward from the reference frame;
			break;
		if the previous call frame is the last-seen call stack divider:
			if the most recent instruction address of the current call frame is the most recent instruction address of the previous call frame:
				now the change direction is a change inward from the reference frame;
				break;
			now the change direction is a change within the reference frame;
			break;
		unless the most recent instruction address of the current call frame is the most recent instruction address of the previous call frame:
			now the change direction is a change outward from the reference frame;
			break;
		now the current call frame is the inward link of the current call frame;
		now the previous call frame is the inward link of the previous call frame;
	if the function change flag is true:
		decide no;
	[Some commands ignore or acknowledge all changes in a given direction.]
	if the change direction is:
		-- a change inward from the reference frame:
			unless the debugger's control flow state is responding after a step:
				[As things currently stand, this shouldn't be possible.  But we want to be friendly to other extensions.]
				decide yes;
		-- a change within the reference frame:
			if the debugger's control flow state is responding after a finish:
				[As things currently stand, this shouldn't be possible.  But we want to be friendly to other extensions.]
				decide yes;
		-- a change outward from the reference frame:
			if the debugger's control flow state is responding after a finish:
				decide no;
	[In fact, sequence point next cannot ignore for any other reason.]
	if the debugger's control flow state is responding after a sequence point next:
		decide no;
	[But the other commands can ignore the breakpoint if the story hasn't moved off of the previously seen line.]
	[If we can already tell that it has, or that we don't know, then we don't ignore the breakpoint.]
	if the previous line comparison call frame is null or the current line comparison call frame is null:
		decide no;
	[When stepping, entering a non-elided frame is tantamount to moving off the previously seen line.]
	if the debugger's control flow state is responding after a step:
		let the inward call frame be the inward link of the current line comparison call frame;
		while the inward call frame is not null:
			unless the call stack simplification flag is true and the inward call frame is elided in the simplified call stack:
				decide no;
			now the inward call frame is the inward link of the inward call frame;
	[Otherwise, we do the line comparison.]
	let the previous sequence point be the last-seen sequence point of the previous line comparison call frame or the last-seen sequence point for the last-seen call stack if it is innermost;
	let the current sequence point be the last-seen sequence point of the current line comparison call frame or the last-seen sequence point before the last-seen breakpoint if it is innermost;
	let the routine record be the routine record owning the sequence point the previous sequence point;
	if the currently preferred debug mode is debugging at the I7 level and the preferred debug mode for the routine record is debugging at the I7 level:
		let the previous line number be the I7 line number for the sequence point the previous sequence point in the routine record the routine record;
		let the current line number be the I7 line number for the sequence point the current sequence point in the routine record the routine record;
		decide on whether or not the previous line number is the current line number;
	otherwise if the preferred debug mode for the routine record is not debugging at the Glulx assembly level:
		let the previous line number be the I6 line number for the sequence point the previous sequence point;
		let the current line number be the I6 line number for the sequence point the current sequence point;
		decide on whether or not the previous line number is the current line number;
	decide yes.

[Roughly speaking, true when the old selected frame is gone.]
To decide whether the call frame changes allow an assured advance:
	let the previous call frame be the last-seen call stack root;
	let the current call frame be the root of the debugger's current call frame;
	repeat until a break:
		if the current call frame is null:
			decide yes;
		always check that the previous call frame is not null or else fail at encountering a divider in the last-seen call stack;
		if the previous call frame is the last-seen call stack divider:
			decide no;
		unless the uninstrumented function address of the current call frame is the uninstrumented function address of the previous call frame:
			decide yes;
		unless the most recent instruction address of the current call frame is the most recent instruction address of the previous call frame:
			decide yes;
		now the current call frame is the inward link of the current call frame;
		now the previous call frame is the inward link of the previous call frame.

To begin advancing assuredly:
	now the debugger's control flow attitude is responding after an assured advance;
	if the debugger's control flow state is:
		-- responding after a sequence point next:
			let the current call frame be the leaf of the debugger's current call frame;
			disable frame-local breakpoints in the current call frame and outward, considering only elided frames;
		-- responding after a next:
			let the current call frame be the leaf of the debugger's current call frame;
			disable frame-local breakpoints in the current call frame and outward, considering only elided frames;
		-- responding after a finish:
			let the current call frame be the leaf of the debugger's current call frame;
			disable frame-local breakpoints in the current call frame and outward, considering only elided frames;
			let the previous call frame be the last-seen call stack root;
			let the current call frame be the root of the debugger's current call frame;
			while the previous call frame is not the last-seen call stack divider:
				always check that the current call frame is not null or else fail at matching a divider when finish is ignoring an interruption;
				always check that the previous call frame is not null or else fail at encountering a divider in the last-seen call stack;
				now the current call frame is the inward link of the current call frame;
				now the previous call frame is the inward link of the previous call frame;
			always check that the current call frame is not null or else fail at matching a divider when finish is ignoring an interruption;
			disable the frame-local breakpoint in the current call frame;
		-- otherwise:
			disable all frame-local breakpoints.

To decide whether we should ignore the current interruption at (B - a simple breakpoint):
	[Five cases to worry about:]
	[I. a breakpoint was forced or a breaktext was encountered, meaning that we must stop]
	if the breakpoint was forced or the breaktext encountered flag is true:
		now the currently preferred debug mode is debugging at the I7 level;
		decide no;
	[II. a new breakpoint was encountered, meaning that we must stop]
	unless B is an invalid simple breakpoint:
		repeat with the encountered compound breakpoint running through the compound breakpoint keys of the compound breakpoint list of B:
			if the encountered compound breakpoint is enabled:
				unless the last-seen compound breakpoint list contains the key the encountered compound breakpoint:
					now the currently preferred debug mode is debugging at the I7 level;
					decide no;
	[III. an old breakpoint was encountered, but in a different frame, meaning that we must stop]
	unless B is an invalid simple breakpoint:
		repeat with the encountered compound breakpoint running through the compound breakpoint keys of the compound breakpoint list of B:
			if the encountered compound breakpoint is enabled:
				if the call frame changes warrant a distinction from the previous interruptions:
					now the currently preferred debug mode is debugging at the I7 level;
					decide no;
				break;
	[IV. we have reached a point where the control flow command is complete, meaning that we must stop]
	unless this interruption should be ignored by the control flow command:
		decide no;
	[V. we have no reason to stop, but we need to prune the old breakpoints, and we might have reason to advance with assurance]
	let the previous linked list vertex be a null linked list vertex;
	let the current linked list vertex be the last-seen compound breakpoint list converted to a linked list vertex;
	while the current linked list vertex is not null:
		let the surviving compound breakpoint be the compound breakpoint key of the current linked list vertex;
		if B is not an invalid simple breakpoint and the compound breakpoint list of B contains the key the surviving compound breakpoint:
			now the previous linked list vertex is the current linked list vertex;
			now the current linked list vertex is the link of the current linked list vertex;
		otherwise:
			let the next linked list vertex be the link of the current linked list vertex;
			if the previous linked list vertex is null:
				now the last-seen compound breakpoint list is the next linked list vertex converted to a linked list;
			otherwise:
				write the link the next linked list vertex to the previous linked list vertex;
			delete the current linked list vertex;
			now the current linked list vertex is the next linked list vertex;
	if the last-seen compound breakpoint list is empty or the call frame changes allow an assured advance:
		begin advancing assuredly;
	decide yes.

Chapter "Responding to a Break" - unindexed

To announce breakpoints at (B - a simple breakpoint):
	let the breakpoints announced flag be false;
	if the breakpoint was forced and the debugger's story-running flag is true:
		say "[line break][bold type]Breakpoint triggered by source text:[roman type] [the name of the forced breakpoint][line break]";
		now the breakpoints announced flag is true;
	unless B is an invalid simple breakpoint:
		repeat with the encountered compound breakpoint running through the compound breakpoint keys of the compound breakpoint list of the B:
			if the encountered compound breakpoint is enabled:
				say "[if the breakpoints announced flag is false][line break][end if][bold type]Breakpoint [the numeric identifier of the encountered compound breakpoint]:[roman type] [the human-friendly name of the encountered compound breakpoint][line break]";
				now the breakpoints announced flag is true;
	repeat with the breaktext running through the breaktext values of the user breaktext hash table:
		if the breaktext is triggered:
			say "[if the breakpoints announced flag is false][line break][end if][bold type]Breaktext [the numeric identifier of the breaktext]:[roman type] [the human-friendly name of the breaktext][line break]";
			now the breakpoints announced flag is true;
	if the breakpoints announced flag is true:
		say "[line break]".

To adjust the debugger's current call frame:
	if the call stack simplification flag is true:
		let the current call frame be the debugger's current call frame;
		while the current call frame is not null and the current call frame is elided in the simplified call stack:
			now the current call frame is the outward link of the current call frame;
		if the current call frame is null:
			now the call stack simplification flag is false;
			say "(disabling simplification because it would elide all of the present call frames)[line break]";
		otherwise:
			now the debugger's current call frame is the current call frame;
	now the debugger's current call frame number is zero.

Handling a breakpoint (this is the interactive debugger breakpoint response rule):
	[The initial breakpoint doesn't count when we restart, except as a hook for bringing up the debug command prompt.]
	if the debugger's story-running flag is false and the debugger's story-restarted flag is true:
		now the debugger's control flow state is responding after a continue;
		now the debugger's story-has-run flag is true;
		handle a debug command for continuing execution;
		now the debugger's control flow attitude is responding after an assured advance;
		now the current debugger coexecution state is story unpaused;
		now the debugger prompting flag is true;
		request a debug command;
		stop;
	now the debugger's current call frame is the innermost call frame of a reconstructed call stack;
	let the encountered simple breakpoint be the simple breakpoint representing the sequence point the last-seen sequence point before the last-seen breakpoint;
	unless we should ignore the current interruption at the encountered simple breakpoint:
		cancel any request for a debug input line;
		now the current debugger coexecution state is story interrupted;
		now the debugger prompting flag is true;
		while within the debugger window via the debugger wrapping layer:
			disable the universal breakpoint;
			disable all frame-local breakpoints;
			disable all frame-local tripwires;
			announce breakpoints at the encountered simple breakpoint;
			now the debugger's story-continuing flag is false;
			adjust the debugger's current call frame;
			unless the last-seen call stack root is null:
				let the moribund call frame be the leaf of the last-seen call stack root;
				delete the moribund call frame and its ancestors;
				now the last-seen call stack root is a null call frame;
			now the last-seen call stack divider is a null call frame;
			delete the last-seen compound breakpoint list;
			now the last-seen compound breakpoint list is an empty linked list;
			if the debugger's story-running flag is true:
				say "[the debug location synopsis]";
			request a debug command;
			while the debugger's story-continuing flag is false:
				wait for the next foreign event using the debugger wrapping layer;
			now the debugger's control flow attitude is responding after an assured advance;
			if the encountered simple breakpoint is not an invalid simple breakpoint:
				repeat with the encountered compound breakpoint running through the compound breakpoint keys of the compound breakpoint list of the encountered simple breakpoint:
					if the encountered compound breakpoint is enabled:
						push the key the encountered compound breakpoint onto the last-seen compound breakpoint list;
						now the debugger's control flow attitude is responding after a cautious advance;
			repeat with the breaktext running through the breaktext values of the user breaktext hash table:
				untrigger the breaktext;
			now the breaktext encountered flag is false;
			if the debugger's control flow attitude is responding after a cautious advance:
				enable frame-local breakpoints in the debugger's current call frame and outward;
			now the last-seen call stack root is the root of the debugger's current call frame;
			now the last-seen call stack divider is the debugger's current call frame;
			now the last-seen sequence point for the last-seen call stack is the last-seen sequence point before the last-seen breakpoint;
		now the current debugger coexecution state is story unpaused.

The breakpoint handler is the interactive debugger breakpoint response rule.

A GRIF shielding rule (this is the shield the interactive debugger breakpoint response rule rule):
	shield the interactive debugger breakpoint response rule against instrumentation.

Book "Parsers" - unindexed

Part "Terminal Parsing" - unindexed

Chapter "Decimal Numbers" - unindexed

To decide whether the synthetic text (T - some text) is a decimal number, with an overflow check or with an overflow check for a negated number:
	if the length of the synthetic text T is zero:
		decide no;
	let the accumulator be zero;
	repeat with the character code running through the character codes in the synthetic text T:
		if the character code is less than 48 [digit zero] or the character code is greater than 57 [digit nine]:
			decide no;
		if with an overflow check or with an overflow check for a negated number:
			if the accumulator is greater than 214748364:
				decide no;
		now the accumulator is the accumulator times ten;
		increase the accumulator by the character code minus 48 [digit zero];
		if with an overflow check or with an overflow check for a negated number:
			if the accumulator is unsigned greater than 2147483647:
				if with an overflow check or the accumulator is not -2147483648:
					decide no;
	decide yes.

To decide what number is the synthetic text (T - some text) as a decimal number:
	let the accumulator be zero;
	repeat with the character code running through the character codes in the synthetic text T:
		now the accumulator is the accumulator times ten;
		increase the accumulator by the character code minus 48 [digit zero];
	decide on the accumulator.

To decide what number is the decimal number named by (V - a parse tree vertex):
	let the decimal be a new synthetic text representing the words matched by V;
	let the result be the synthetic text the decimal as a decimal number;
	delete the synthetic text the decimal;
	decide on the result.

To parse for (S - a parseme) beginning at lexeme index (I - a number) by parsing a decimal number (this is parsing a decimal number):
	let the array content be the punctuated word array content of the owner of S;
	if I is less than the word count of the array content and the synthetic text word I of the array content is a decimal number:
		match S from lexeme index I to lexeme index I plus one.

Chapter "Hexadecimal Numbers" - unindexed

To decide whether the synthetic text (T - some text) is a hexadecimal number, with an overflow check or with an overflow check for a negated number:
	let the prefix counter be zero;
	let the accumulator be zero;
	repeat with the character code running through the character codes in the synthetic text T:
		if the prefix counter is:
			-- zero:
				unless the character code is 48 [digit zero]:
					decide no;
				increment the prefix counter;
			-- one:
				unless the character code is 88 [uppercase letter x] or the character code is 120 [lowercase letter x]:
					decide no;
				increment the prefix counter;
			-- two:
				let the value be zero;
				if the character code is at least 48 [digit zero] and the character code is at most 57 [digit nine]:
					now the value is the character code minus 48 [digit zero];
				otherwise if the character code is at least 65 [uppercase letter a] and the character code is at most 70 [uppercase letter f]:
					now the value is the character code minus 55 [uppercase letter a less ten];
				otherwise if the character code is at least 97 [uppercase letter a] and the character code is at most 102 [uppercase letter f]:
					now the value is the character code minus 87 [lowercase letter a less ten];
				otherwise:
					decide no;
				let the new accumulator be the accumulator shifted four bits left;
				increase the new accumulator by the value;
				if with an overflow check or with an overflow check for a negated number:
					if the accumulator is greater than the effectively infinite listing limit:
						decide no;
					if the new accumulator is less than zero:
						unless with an overflow check for a negated number and zero minus the new accumulator is the new accumulator:
							decide no;
				now the accumulator is the new accumulator;
	decide on whether or not the prefix counter is two.

To decide what number is the synthetic text (T - some text) as a hexadecimal number:
	let the prefix counter be zero;
	let the accumulator be zero;
	repeat with the character code running through the character codes in the synthetic text T:
		if the prefix counter is at least two:
			now the accumulator is the accumulator shifted four bits left;
			if the character code is at least 48 [digit zero] and the character code is at most 57 [digit nine]:
				increase the accumulator by the character code minus 48 [digit zero];
			otherwise if the character code is at least 65 [uppercase letter a] and the character code is at most 70 [uppercase letter f]:
				increase the accumulator by the character code minus 55 [uppercase letter a less ten];
			otherwise:
				increase the accumulator by the character code minus 87 [lowercase letter a less ten];
		increment the prefix counter;
	decide on the accumulator.

To decide what number is the hexadecimal number named by (V - a parse tree vertex):
	let the hexadecimal be a new synthetic text representing the words matched by V;
	let the result be the synthetic text the hexadecimal as a hexadecimal number;
	delete the synthetic text the hexadecimal;
	decide on the result.

To parse for (S - a parseme) beginning at lexeme index (I - a number) by parsing a hexadecimal number (this is parsing a hexadecimal number):
	let the array content be the punctuated word array content of the owner of S;
	if I is less than the word count of the array content and the synthetic text word I of the array content is a hexadecimal number:
		match S from lexeme index I to lexeme index I plus one.

Chapter "Arbitrary Words" - unindexed

To parse for (S - a parseme) beginning at lexeme index (I - a number) by parsing arbitrary words (this is parsing arbitrary words):
	let the array content be the punctuated word array content of the owner of S;
	let the word count be the word count of the array content;
	repeat with the end lexeme index running from I plus one to the word count:
		match S from lexeme index I to lexeme index the end lexeme index.

Chapter "Arbitrary Words without Double Quotes" - unindexed

The debug command string delimiter is some text that varies.

A GRIF setup rule (this is the allocate synthetic text for the debug command string delimiter rule):
	now the debug command string delimiter is a new permanent synthetic text copied from "'".

To parse for (S - a parseme) beginning at lexeme index (I - a number) by parsing arbitrary words without double quotes (this is parsing arbitrary words without double quotes):
	let the array content be the punctuated word array content of the owner of S;
	let the word count be the word count of the array content;
	repeat with the index running over the half-open interval from I to the word count:
		if the synthetic text word index of the array content is identical to the synthetic text the debug command string delimiter:
			break;
		match S from lexeme index I to lexeme index the index plus one.

Chapter "Function Names" - unindexed

To decide whether the synthetic text (T - some text) is a function name:
	ensure that all routines have names;
	let the list be the list of addresses matching the function name T;
	let the result be whether or not the list is not empty;
	delete the list;
	decide on the result.

Chapter "Function Addresses" - unindexed

To decide what number is the function address named by (V - a parse tree vertex):
	let the function address vertex be the first match for a decimal number for the debugger among the children of V;
	if the function address vertex is an invalid parse tree vertex:
		now the function address vertex is the first match for a hexadecimal number for the debugger among the children of V;
		decide on the hexadecimal number named by the function address vertex;
	decide on the decimal number named by the function address vertex.

Chapter "Global Names" - unindexed

To decide whether the synthetic text (T - some text) is a global name:
	let the downcased name be a new synthetic text copied from T;
	downcase the synthetic text the downcased name;
	let the list be a new list of global records matching the global name the downcased name;
	delete the synthetic text the downcased name;
	let the result be whether or not the list is not empty;
	delete the list;
	decide on the result.

Chapter "Memory Stack Variable Names" - unindexed

To decide whether the synthetic text (T - some text) is a memory stack variable name:
	let the downcased name be a new synthetic text copied from T;
	downcase the synthetic text the downcased name;
	let the list be a new list of memory stack variable records matching the memory stack variable name the downcased name;
	delete the synthetic text the downcased name;
	let the result be whether or not the list is not empty;
	delete the list;
	decide on the result.

Chapter "Local Names" - unindexed

To decide what number is the index of the local with I7 name (T - some text) in the selected frame:
	let the function address be the uninstrumented function address of the debugger's current call frame;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the routine record be the routine record for the actual function address;
	let the sequence point be the sequence point to highlight;
	unless the routine record owning the sequence point the sequence point is the routine record:
		decide on -1;
	let the line number be the I7 line number for the sequence point the sequence point in the routine record the routine record;
	let the source line record be the source line record for line number the line number;
	if the source line record is an invalid source line record:
		decide on -1;
	let the downcased name be a new synthetic text copied from T;
	downcase the synthetic text the downcased name;
	repeat with the local index running over the half-open interval from zero to 16:
		let the local name be I7 local name number local index of the source line record;
		if the local name is the name for invalid local number local index:
			next;
		let the character index be the index of the synthetic text the local name in the synthetic text the downcased name;
		if the character index is one:
			if the length of the synthetic text the downcased name is the length of the synthetic text the local name:
				delete the synthetic text the downcased name;
				decide on the local index;
		if the character index is one plus the length of the synthetic text the source text definite article:
			if the length of the synthetic text the downcased name is the length of the synthetic text the local name plus the length of the synthetic text the source text definite article:
				if the synthetic text the downcased name begins with the synthetic text the source text definite article:
					delete the synthetic text the downcased name;
					decide on the local index;
		if the character index is zero and the length of the synthetic text the local name is the length of the synthetic text the downcased name plus the length of the synthetic text the source text definite article:
			let the character index be the index of the synthetic text the downcased name in the synthetic text the local name;
			if the character index is one plus the length of the synthetic text the source text definite article and the synthetic text the local name begins with the synthetic text the source text definite article:
				delete the synthetic text the downcased name;
				decide on the local index;
	delete the synthetic text the downcased name;
	decide on -1.

To decide what number is the index of the local with I6 name (T - some text) in the selected frame:
	let the function address be the uninstrumented function address of the debugger's current call frame;
	let the actual function address be the address of the function substituted for the function at address function address;
	let the routine record be the routine record for the actual function address;
	let the downcased name be a new synthetic text copied from T;
	downcase the synthetic text the downcased name;
	repeat with the local index running over the half-open interval from zero to 16:
		let the local name be I6 local name number local index of the routine record;
		if the synthetic text the downcased name is identical to the local name:
			delete the synthetic text the downcased name;
			decide on the local index;
	delete the synthetic text the downcased name;
	decide on -1.

To decide whether the synthetic text (T - some text) is a local name:
	[(No downcasing is necessary.)]
	let the result be the index of the local with I7 name T in the selected frame;
	if the result is at least zero:
		decide yes;
	now the result is the index of the local with I6 name T in the selected frame;
	decide on whether or not the result is at least zero.

Chapter "Kind Names" - unindexed

To decide whether the synthetic text (T - some text) is a kind name:
	decide on whether or not there is a kind named T.

Chapter "Object Names" - unindexed

To decide whether the synthetic text (T - some text) is an object name:
	let the downcased name be a new synthetic text copied from T;
	downcase the synthetic text the downcased name;
	let the list be a new list of object addresses matching the object name the downcased name;
	delete the synthetic text the downcased name;
	let the result be whether or not the list is not empty;
	delete the list;
	decide on the result.

Part "Authorial Consent Parser" - unindexed

Chapter "Authorial Consent Parser Components" - unindexed

Section "Authorial Consent Parser Proper" - unindexed

The authorial consent parser is a context-free parser that varies.

Section "Authorial Consent Parsemes" - unindexed

An authorial assent and
	a permanent authorial assent are parsemes that vary.

Section "Authorial Consent Parser Setup and Grammar" - unindexed

A GRIF setup rule (this is the set up the authorial consent parser rule):
	now the authorial consent parser is a new context-free parser;
	now an authorial assent is a new nonterminal in the authorial consent parser named "the answer 'yes'";
	now a permanent authorial assent is a new nonterminal in the authorial consent parser named "the answer 'YES', uppercase to indicate that the debugger should assume assent from here on out";
	understand "y" or "yes" as an authorial assent regardless of case;
	understand "Y" or "Yes" or "YES" as a permanent authorial assent;
	put the authorial consent parser into normal form.

Chapter "Authorial Consent Input" - unindexed

Section "Authorial Consent Handler" - unindexed

The authorial consent result is a truth state that varies.  The authorial consent result is false.
The authorial consent permanence is a truth state that varies.  The authorial consent permanence is false.

To dispatch the authorial consent (T - some text) (this is dispatching authorial consent):
	now the authorial consent result is false;
	now the authorial consent permanence is false;
	write the punctuated words of T to the authorial consent parser;
	repeat with the root running through matches for authorial assent:
		now the authorial consent result is true;
	repeat with the root running through matches for permanent authorial assent:
		now the authorial consent permanence is true;
	delete the punctuated words from the authorial consent parser.

Section "Authorial Consent Requests" - unindexed

To decide whether the author consents:
	while within the debugger window via the debugger wrapping layer:
		request a debug input line to be handled by dispatching authorial consent;
		while the debugger's line input handler is dispatching authorial consent:
			wait for the next foreign event using the debugger wrapping layer;
	decide on the authorial consent result.

To decide whether the consent was permanent:
	decide on the authorial consent permanence.

Part "Disambiguation Parser" - unindexed

Chapter "Disambiguation Parser Components" - unindexed

Section "Disambiguation Parser Proper" - unindexed

The debug disambiguation parser is a context-free parser that varies.

Section "Disambiguation Parsemes" - unindexed

A decimal number for the debugger's disambiguator is a parseme that varies.
A disambiguation number is a parseme that varies.

Section "Disambiguation Parser Setup and Grammar" - unindexed

A GRIF setup rule (this is the set up the debug disambiguation parser rule):
	now the debug disambiguation parser is a new context-free parser;
	now a decimal number for the debugger's disambiguator is a new terminal in the debug disambiguation parser named "a decimal number" and parsed by parsing a decimal number;
	now a disambiguation number is a new nonterminal in the debug disambiguation parser named "a disambiguation choice";
	understand "[a decimal number for the debugger's disambiguator]" as a disambiguation number;
	understand "[a decimal number for the debugger's disambiguator].[no line break]" as a disambiguation number;
	put the debug disambiguation parser into normal form.

Chapter "Disambiguation Input" - unindexed

Section "Disambiguation Handler" - unindexed

The chosen disambiguation number is a number that varies.  The chosen disambiguation number is -1.

To dispatch the debug command disambiguation (T - some text) (this is dispatching a debug command disambiguation):
	write the punctuated words of T to the debug disambiguation parser;
	repeat with the root running through matches for a disambiguation number:
		let the response index be the beginning lexeme index of the first child of the root;
		let the array content be the punctuated word array content of the debug disambiguation parser;
		let the response be word response index of the array content;
		if the synthetic text the response is a decimal number, with an overflow check:
			now the chosen disambiguation number is the synthetic text the response as a decimal number;
		otherwise:
			now the chosen disambiguation number is -1;
	delete the punctuated words from the debug disambiguation parser.

Section "Disambiguation Requests" - unindexed

To decide what number is the disambiguation choice among (N - a number) options:
	say "0. Nevermind; ignore this command and let me enter a different one[paragraph break]";
	while within the debugger window via the debugger wrapping layer:
		now the chosen disambiguation number is -1;
		while the chosen disambiguation number is less than zero or (the chosen disambiguation number is greater than N):
			say "Enter the number of your selection: ";
			request a debug input line to be handled by dispatching a debug command disambiguation;
			while the debugger's line input handler is dispatching a debug command disambiguation:
				wait for the next foreign event using the debugger wrapping layer;
			if the chosen disambiguation number is less than zero or the chosen disambiguation number is greater than N:
				say "Please enter a number from 0 to [N converted to a number].  Be sure to use digits, not words.[paragraph break]";
	say "[line break]";
	decide on the chosen disambiguation number.

Part "Debug Command Parser" - unindexed

Chapter "Debug Command Parser Components" - unindexed

Section "Debug Command Parser Proper" - unindexed

The debug command parser is a context-free parser that varies.

Section "Debug Command Parsemes" - unindexed

A decimal number for the debugger and
	a hexadecimal number for the debugger and
	a function name for the debugger and
	a global name for the debugger and
	a memory stack variable name for the debugger and
	a local name for the debugger and
	a kind name for the debugger and
	an object name for the debugger and
	a simple text for the debugger are parsemes that vary.

A debug command and
	--/a/an/the and
	--/any/every and
	--/at/on and
	--/my and
	--/the and
	a breakpoint number and
	a debugging language and
	a function address for the debugger and
	a line number and
	annotated and
	b/bre/break/stop and
	call/calls and
	call stack simplification and
	examine and
	l/list and
	limitations on saving and
	showme and
	stack/call-stack/backtrace/bt and
	the I6 language and
	the I7 language and
	the debugger's about command and
	the debugger's again command and
	the debugger's backtrace command and
	the debugger's break-by-address command and
	the debugger's break-by-function command and
	the debugger's break-by-line-number command and
	the debugger's break-by-inference command and
	the debugger's break-by-output command and
	the debugger's break-by-text command and
	the debugger's continue command and
	the debugger's delete all command and
	the debugger's delete command and
	the debugger's disable all command and
	the debugger's disable command and
	the debugger's enable all command and
	the debugger's enable command and
	the debugger's examine command and
	the debugger's examine-as command and
	the debugger's finish command and
	the debugger's force a breakpoint command and
	the debugger's help command and
	the debugger's breakpoint information command and
	the debugger's breaktext information command and
	the debugger's information command and
	the debugger's inward command and
	the debugger's inward-by-distance command and
	the debugger's list-by-address command and
	the debugger's list-by-function command and
	the debugger's list-by-line-number command and
	the debugger's list-by-line-numbers command and
	the debugger's list-by-instruction-address command and
	the debugger's list-by-instruction-addresses command and
	the debugger's list-by-inference command and
	the debugger's list-instrumentation command and
	the debugger's next command and
	the debugger's next sequence point command and
	the debugger's outward command and
	the debugger's outward-by-distance command and
	the debugger's prefer command and
	the debugger's preferences command and
	the debugger's quit command and
	the debugger's restart command and
	the debugger's run command and
	the debugger's select command and
	the debugger's showme command and
	the debugger's step command and
	the debugger's step sequence point command and
	the debugger's summary command and
	the debugger's version command and
	the debugger's xyzzy command and
	the debugger's plugh command and
	the Glulx language and
	the word no and
	through are parsemes that vary.

A help topic for the debugger and
	printing the story's location and
	advancing the story and
	placing breakpoints and
	managing breakpoints and
	navigating the call stack and
	listing source text and
	inspecting values and
	managing preferences and
	getting information about the debugger and
	miscellaneous commands are parsemes that vary.

Section "Debug Command Parser Setup and Grammar" - unindexed

A GRIF setup rule (this is the set up the debug command parser rule):
	now the debug command parser is a new context-free parser;
	now a decimal number for the debugger is a new terminal in the debug command parser named "a decimal number" and parsed by parsing a decimal number;
	now a hexadecimal number for the debugger is a new terminal in the debug command parser named "a hexadecimal number" and parsed by parsing a hexadecimal number;
	now a function name for the debugger is a new terminal in the debug command parser named "a function (a rule, phrase, or routine) name" and parsed by parsing arbitrary words;
	now a global name for the debugger is a new terminal in the debug command parser named "a non-temporary named value (which is a kind of variable name)" and parsed by parsing arbitrary words;
	now a memory stack variable name for the debugger is a new terminal in the debug command parser named "a rulebook or action variable" and parsed by parsing arbitrary words;
	now a local name for the debugger is a new terminal in the debug command parser named "a temporary named value (which is a kind of variable name)" and parsed by parsing arbitrary words;
	now a kind name for the debugger is a new terminal in the debug command parser named "a name of a kind" and parsed by parsing arbitrary words;
	now an object name for the debugger is a new terminal in the debug command parser named "a name of an object" and parsed by parsing arbitrary words;
	now a simple text for the debugger is a new terminal in the debug command parser named "a text with only simple substitutions" and parsed by parsing arbitrary words without double quotes;
	now a debug command is a new nonterminal in the debug command parser named "a debug command";
	now --/a/an/the is a new nonterminal in the debug command parser named "an optional occurrence of an article like 'a' or 'the'";
	now --/any/every is a new nonterminal in the debug command parser named "an optional occurrence of the word 'any' or the word 'every'";
	now --/at/on is a new nonterminal in the debug command parser named "an optional occurrence of the word 'at' or the word 'on'";
	now --/my is a new nonterminal in the debug command parser named "an optional occurrence of the word 'my'";
	now --/the is a new nonterminal in the debug command parser named "an optional occurrence of the word 'the'";
	now a breakpoint number is a new nonterminal in the debug command parser named "a breakpoint number";
	now a debugging language is a new nonterminal in the debug command parser named "a language";
	now a function address for the debugger is a new nonterminal in the debug command parser named "a function address";
	now a line number is a new nonterminal in the debug command parser named "a line number";
	now annotated is a new nonterminal in the debug command parser named "annotated";
	now b/bre/break/stop is a new nonterminal in the debug command parser named "the word 'break' or the word 'stop'";
	now call/calls is a new nonterminal in the debug command parser named "the word 'call' or the word 'calls'";
	now call stack simplification is a new nonterminal in the debug command parser named "call stack simplification";
	now examine is a new nonterminal in the debug command parser named "examine";
	now l/list is a new nonterminal in the debug command parser named "list";
	now limitations on saving is a new nonterminal in the debug command parser named "limitations on saving";
	now showme is a new nonterminal in the debug command parser named "showme";
	now stack/call-stack/backtrace/bt is a new nonterminal in the debug command parser named "the words 'call stack' or the word 'backtrace'";
	now the I6 language is a new nonterminal in the debug command parser named "the I6 language";
	now the I7 language is a new nonterminal in the debug command parser named "the I7 language";
	now the debugger's about command is a new nonterminal in the debug command parser named "the 'about' command";
	now the debugger's again command is a new nonterminal in the debug command parser named "the 'again' command";
	now the debugger's backtrace command is a new nonterminal in the debug command parser named "the 'backtrace' command";
	now the debugger's break-by-address command is a new nonterminal in the debug command parser named "the 'break' command for a function given by its address";
	now the debugger's break-by-function command is a new nonterminal in the debug command parser named "the 'break' command for a function";
	now the debugger's break-by-line-number command is a new nonterminal in the debug command parser named "the 'break' command for a line number";
	now the debugger's break-by-inference command is a new nonterminal in the debug command parser named "the 'break here' command";
	now the debugger's break-by-output command is a new nonterminal in the debug command parser named "the 'break on output' command";
	now the debugger's break-by-text command is a new nonterminal in the debug command parser named "the 'break' command for a text";
	now the debugger's continue command is a new nonterminal in the debug command parser named "the 'continue' command";
	now the debugger's delete all command is a new nonterminal in the debug command parser named "the 'delete all breakpoints' command";
	now the debugger's delete command is a new nonterminal in the debug command parser named "the 'delete a breakpoint' command";
	now the debugger's disable all command is a new nonterminal in the debug command parser named "the 'disable all breakpoints' command";
	now the debugger's disable command is a new nonterminal in the debug command parser named "the 'disable a breakpoint' command";
	now the debugger's enable all command is a new nonterminal in the debug command parser named "the 'enable all breakpoints' command";
	now the debugger's enable command is a new nonterminal in the debug command parser named "the 'enable a breakpoint' command";
	now the debugger's examine command is a new nonterminal in the debug command parser named "the 'examine' command";
	now the debugger's examine-as command is a new nonterminal in the debug command parser named "the 'examine as' command";
	now the debugger's finish command is a new nonterminal in the debug command parser named "the 'finish' command";
	now the debugger's force a breakpoint command is a new nonterminal in the debug command parser named "the 'force a breakpoint' command";
	now the debugger's help command is a new nonterminal in the debug command parser named "the 'help' command";
	now the debugger's breakpoint information command is a new nonterminal in the debug command parser named "the 'breakpoint information' command";
	now the debugger's breaktext information command is a new nonterminal in the debug command parser named "the 'breaktext information' command";
	now the debugger's information command is a new nonterminal in the debug command parser named "the 'information' command";
	now the debugger's inward command is a new nonterminal in the debug command parser named "the 'move in one call frame' command";
	now the debugger's inward-by-distance command is a new nonterminal in the debug command parser named "the 'move in several call frames' command";
	now the debugger's list-by-address command is a new nonterminal in the debug command parser named "the 'list' command for a function given by its address";
	now the debugger's list-by-function command is a new nonterminal in the debug command parser named "the 'list' command for a function";
	now the debugger's list-by-line-number command is a new nonterminal in the debug command parser named "the 'list' command for a line number";
	now the debugger's list-by-line-numbers command is a new nonterminal in the debug command parser named "the 'list' command for a range of line numbers";
	now the debugger's list-by-instruction-address command is a new nonterminal in the debug command parser named "the 'list' command for an instruction given by its address";
	now the debugger's list-by-instruction-addresses command is a new nonterminal in the debug command parser named "the 'list' command for instructions given by their addresses";
	now the debugger's list-by-inference command is a new nonterminal in the debug command parser named "the 'list the current function' command";
	now the debugger's list-instrumentation command is a new nonterminal in the debug command parser named "the 'list instrumentation' command";
	now the debugger's next command is a new nonterminal in the debug command parser named "the 'next' command";
	now the debugger's next sequence point command is a new nonterminal in the debug command parser named "the 'next sequence point' command";
	now the debugger's outward command is a new nonterminal in the debug command parser named "the 'move out one call frame' command";
	now the debugger's outward-by-distance command is a new nonterminal in the debug command parser named "the 'move out several call frames' command";
	now the debugger's prefer command is a new nonterminal in the debug command parser named "the 'prefer' command";
	now the debugger's preferences command is a new nonterminal in the debug command parser named "the 'preferences' command";
	now the debugger's quit command is a new nonterminal in the debug command parser named "the 'quit' command";
	now the debugger's restart command is a new nonterminal in the debug command parser named "the 'restart' command";
	now the debugger's run command is a new nonterminal in the debug command parser named "the 'run' command";
	now the debugger's select command is a new nonterminal in the debug command parser named "the 'select a call frame by number' command";
	now the debugger's showme command is a new nonterminal in the debug command parser named "the 'showme' command";
	now the debugger's step command is a new nonterminal in the debug command parser named "the 'step' command";
	now the debugger's step sequence point command is a new nonterminal in the debug command parser named "the 'step one sequence point' command";
	now the debugger's summary command is a new nonterminal in the debug command parser named "the 'summary' command";
	now the debugger's version command is a new nonterminal in the debug command parser named "the 'version' command";
	now the debugger's xyzzy command is a new nonterminal in the debug command parser named "the 'xyzzy' command";
	now the debugger's plugh command is a new nonterminal in the debug command parser named "the 'plugh' command";
	now the Glulx language is a new nonterminal in the debug command parser named "the Glulx assembly language";
	now the word no is a new nonterminal in the debug command parser named "the word 'no'";
	now through is a new nonterminal in the debug command parser named "the word 'through'";
	now a help topic for the debugger is a new nonterminal in the debug command parser named "a help topic for the debugger";
	now printing the story's location is a new nonterminal in the debug command parser named "printing the story's location (a help topic)";
	now advancing the story is a new nonterminal in the debug command parser named "advancing the story (a help topic)";
	now placing breakpoints is a new nonterminal in the debug command parser named "placing breakpoints (a help topic)";
	now managing breakpoints is a new nonterminal in the debug command parser named "managing breakpoints (a help topic)";
	now navigating the call stack is a new nonterminal in the debug command parser named "navigating the call stack (a help topic)";
	now listing source text is a new nonterminal in the debug command parser named "listing source text (a help topic)";
	now inspecting values is a new nonterminal in the debug command parser named "inspecting values (a help topic)";
	now managing preferences is a new nonterminal in the debug command parser named "managing preferences (a help topic)";
	now getting information about the debugger is a new nonterminal in the debug command parser named "getting information about the debugger (a help topic)";
	now miscellaneous commands is a new nonterminal in the debug command parser named "miscellaneous commands (a help topic)";
	[//]
	understand "[the debugger's about command]" as a debug command;
	understand "[the debugger's again command]" as a debug command;
	understand "[the debugger's backtrace command]" as a debug command;
	understand "[the debugger's break-by-address command]" as a debug command;
	understand "[the debugger's break-by-function command]" as a debug command;
	understand "[the debugger's break-by-line-number command]" as a debug command;
	understand "[the debugger's break-by-inference command]" as a debug command;
	understand "[the debugger's break-by-output command]" as a debug command;
	understand "[the debugger's break-by-text command]" as a debug command;
	understand "[the debugger's continue command]" as a debug command;
	understand "[the debugger's delete all command]" as a debug command;
	understand "[the debugger's delete command]" as a debug command;
	understand "[the debugger's disable all command]" as a debug command;
	understand "[the debugger's disable command]" as a debug command;
	understand "[the debugger's enable all command]" as a debug command;
	understand "[the debugger's enable command]" as a debug command;
	understand "[the debugger's examine command]" as a debug command;
	understand "[the debugger's examine-as command]" as a debug command;
	understand "[the debugger's finish command]" as a debug command;
	understand "[the debugger's force a breakpoint command]" as a debug command;
	understand "[the debugger's help command]" as a debug command;
	understand "[the debugger's breakpoint information command]" as a debug command;
	understand "[the debugger's breaktext information command]" as a debug command;
	understand "[the debugger's information command]" as a debug command;
	understand "[the debugger's inward command]" as a debug command;
	understand "[the debugger's inward-by-distance command]" as a debug command;
	understand "[the debugger's list-by-address command]" as a debug command;
	understand "[the debugger's list-by-function command]" as a debug command;
	understand "[the debugger's list-by-line-number command]" as a debug command;
	understand "[the debugger's list-by-line-numbers command]" as a debug command;
	understand "[the debugger's list-by-instruction-address command]" as a debug command;
	understand "[the debugger's list-by-instruction-addresses command]" as a debug command;
	understand "[the debugger's list-by-inference command]" as a debug command;
	understand "[the debugger's list-instrumentation command]" as a debug command;
	understand "[the debugger's next command]" as a debug command;
	understand "[the debugger's next sequence point command]" as a debug command;
	understand "[the debugger's outward command]" as a debug command;
	understand "[the debugger's outward-by-distance command]" as a debug command;
	understand "[the debugger's prefer command]" as a debug command;
	understand "[the debugger's preferences command]" as a debug command;
	understand "[the debugger's restart command]" as a debug command;
	understand "[the debugger's run command]" as a debug command;
	understand "[the debugger's quit command]" as a debug command;
	understand "[the debugger's select command]" as a debug command;
	understand "[the debugger's showme command]" as a debug command;
	understand "[the debugger's step command]" as a debug command;
	understand "[the debugger's step sequence point command]" as a debug command;
	understand "[the debugger's summary command]" as a debug command;
	understand "[the debugger's version command]" as a debug command;
	understand "[the debugger's xyzzy command]" as a debug command;
	understand "[the debugger's plugh command]" as a debug command;
	[//]
	understand "about" as the debugger's about command regardless of case;
	understand "again" and "g" and "" as the debugger's again command regardless of case;
	understand "version" as the debugger's version command regardless of case;
	understand "help" as the debugger's help command regardless of case;
	understand "help [a help topic for the debugger]" as the debugger's help command regardless of case;
	[//]
	understand "quit" and "exit" and "bye" as the debugger's quit command regardless of case;
	[//]
	understand "force a breakpoint" and "force breakpoint" and "force" as the debugger's force a breakpoint command regardless of case;
	[//]
	understand "prefer [call stack simplification]" or "prefer [the word no] [call stack simplification]" or "[call stack simplification]" or "[the word no] [call stack simplification]" as the debugger's prefer command regardless of case;
	understand "prefer [limitations on saving]" or "prefer [the word no] [limitations on saving]" or "[limitations on saving]" or "[the word no] [limitations on saving]" as the debugger's prefer command regardless of case;
	understand "call stack simplification" or "simplification" as call stack simplification;
	understand "limitations on saving" or "limitations" or "limitation on saving" or "limitation" as limitations on saving;
	understand "[examine] [--/my] preferences" or "[showme] [--/my] preferences" or "list [--/my] preferences" or "[--/my] preferences" as the debugger's preferences command regardless of case;
	[//]
	understand "next sequence point anywhere" or "step sequence point" or "si" as the debugger's step sequence point command regardless of case;
	understand "next sequence point" or "ni" as the debugger's next sequence point command regardless of case;
	understand "next line anywhere" or "step" or "s" as the debugger's step command regardless of case;
	understand "next [a debugging language] line anywhere" or "step [a debugging language]" or "s [a debugging language]" as the debugger's step command regardless of case;
	understand "next line" or "next" or "n" as the debugger's next command regardless of case;
	understand "next [a debugging language] line" or "next [a debugging language]" or "n [a debugging language]" as the debugger's next command regardless of case;
	understand "finish this call" or "finish" or "fin" or "f" as the debugger's finish command regardless of case;
	understand "go" or "continue" or "c" as the debugger's continue command regardless of case;
	understand "run" or "r" as the debugger's run command regardless of case;
	understand "restart" as the debugger's restart command regardless of case;
	[//]
	understand "breakpoint information" or "breakpoint info" or "breakpoints" as the debugger's breakpoint information command regardless of case;
	understand "breaktext information" or "breaktext info" or "breaktexts" as the debugger's breaktext information command regardless of case;
	understand "information" or "info" or "i b" or "i" as the debugger's information command regardless of case;
	understand "[b/bre/break/stop] [--/at/on] [a function name for the debugger]" as the debugger's break-by-function command regardless of case;
	understand "[b/bre/break/stop] [--/at/on] [a function address for the debugger]" as the debugger's break-by-address command regardless of case;
	understand "[b/bre/break/stop] [--/at/on] [a line number]" as the debugger's break-by-line-number command regardless of case;
	understand "[b/bre/break/stop] here" or "[b/bre/break/stop]" as the debugger's break-by-inference command regardless of case;
	understand "[b/bre/break/stop] [--/at/on] [--/any/every] output" as the debugger's break-by-output command regardless of case;
	understand "[b/bre/break/stop] [--/at/on] '[a simple text for the debugger]'" as the debugger's break-by-text command regardless of case;
	understand "enable [a breakpoint number]" or "ena [a breakpoint number]" as the debugger's enable command regardless of case;
	understand "disable [a breakpoint number]" or "dis [a breakpoint number]" as the debugger's disable command regardless of case;
	understand "delete [a breakpoint number]" or "del [a breakpoint number]" or "d [a breakpoint number]" as the debugger's delete command regardless of case;
	understand "enable all breakpoints" or "enable all" or "enable" or "ena" or "ena b" as the debugger's enable all command regardless of case;
	understand "disable all breakpoints" or "disable all" or "disable" or "dis" or "dis b" as the debugger's disable all command regardless of case;
	understand "delete all breakpoints" or "delete all" or "delete" or "del" or "d b" as the debugger's delete all command regardless of case;
	[//]
	understand "summary" or "[a debugging language] summary" as the debugger's summary command regardless of case;
	understand "[examine] [--/the] [stack/call-stack/backtrace/bt]" or "[examine] [--/the] [annotated] [stack/call-stack/backtrace/bt]" as the debugger's backtrace command regardless of case;
	understand "[showme] [--/the] [stack/call-stack/backtrace/bt]" or "[showme] [--/the] [annotated] [stack/call-stack/backtrace/bt]" as the debugger's backtrace command regardless of case;
	understand "[stack/call-stack/backtrace/bt]" or "[annotated] [stack/call-stack/backtrace/bt]" or "[annotated]" as the debugger's backtrace command regardless of case;
	understand "where" or "[annotated] where" as the debugger's backtrace command regardless of case;
	[//]
	understand "select [a decimal number for the debugger]" or "sel [a decimal number for the debugger]" as the debugger's select command regardless of case;
	understand "in" as the debugger's inward command regardless of case;
	understand "out" as the debugger's outward command regardless of case;
	understand "in [a decimal number for the debugger] [call/calls]" or "in [a decimal number for the debugger]" as the debugger's inward-by-distance command regardless of case;
	understand "out [a decimal number for the debugger] [call/calls]" or "out [a decimal number for the debugger]" as the debugger's outward-by-distance command regardless of case;
	[//]
	understand "[l/list]" or "list [a debugging language]" or "list as [a debugging language]" as the debugger's list-by-inference command regardless of case;
	understand "[l/list] [a line number]" or "[l/list] [a line number] as [a debugging language]" as the debugger's list-by-line-number command regardless of case;
	understand "[l/list] [a line number] [through] [a line number]" or "[l/list] [a line number] [through] [a line number] as [a debugging language]" as the debugger's list-by-line-numbers command regardless of case;
	understand "[l/list] [a hexadecimal number for the debugger]" as the debugger's list-by-instruction-address command regardless of case;
	understand "[l/list] [a hexadecimal number for the debugger] [through] [a hexadecimal number for the debugger]" as the debugger's list-by-instruction-addresses command regardless of case;
	understand "[l/list] [a function name for the debugger]" or "[l/list] [a function name for the debugger] as [a debugging language]" as the debugger's list-by-function command regardless of case;
	understand "[l/list] [a function address for the debugger]" or "[l/list] [a function address for the debugger] as [a debugging language]" as the debugger's list-by-address command regardless of case;
	understand "list instrumentation" or "li" as the debugger's list-instrumentation command regardless of case;
	understand "[the Glulx language]" or "[the I6 language]" or "[the I7 language]" as a debugging language;
	understand "Glulx" or "assembly" or "Glulx assembly" as the Glulx language regardless of case;
	understand "6" or "I6" or "Inform 6" as the I6 language regardless of case;
	understand "7" or "I7" or "Inform 7" as the I7 language regardless of case;
	[//]
	understand "[examine] [a global name for the debugger]" as the debugger's examine command;
	understand "[examine] [a memory stack variable name for the debugger]" as the debugger's examine command;
	understand "[examine] [a local name for the debugger]" as the debugger's examine command;
	understand "[examine] [a function name for the debugger]" as the debugger's examine command regardless of case;
	understand "[examine] [a decimal number for the debugger]" as the debugger's examine command; [for consistency]
	understand "[examine] [a hexadecimal number for the debugger]" as the debugger's examine command; [for consistency]
	understand "[examine] [--/a/an/the] [an object name for the debugger]" as the debugger's examine command;
	understand "[examine] [a global name for the debugger] as [a kind name for the debugger]" and "[examine] [a global name for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command;
	understand "[examine] [a memory stack variable name for the debugger] as [a kind name for the debugger]" and "[examine] [a memory stack variable name for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command;
	understand "[examine] [a local name for the debugger] as [a kind name for the debugger]" and "[examine] [a local name for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command;
	understand "[examine] [a function name for the debugger] as [a kind name for the debugger]" or "[examine] [a function name for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command regardless of case;
	understand "[examine] [a decimal number for the debugger] as [a kind name for the debugger]" and "[examine] [a decimal number for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command;
	understand "[examine] [a hexadecimal number for the debugger] as [a kind name for the debugger]" and "[examine] [a hexadecimal number for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command;
	understand "[examine] [--/a/an/the] [an object name for the debugger] as [a kind name for the debugger]" and "[examine] [--/a/an/the] [an object name for the debugger] converted to [a kind name for the debugger]" as the debugger's examine-as command;
	[//]
	understand "[showme] [--/a/an/the] [an object name for the debugger]" as the debugger's showme command;
	understand "[showme] [a global name for the debugger]" as the debugger's showme command;
	understand "[showme] [a memory stack variable name for the debugger]" as the debugger's showme command;
	understand "[showme] [a local name for the debugger]" as the debugger's showme command;
	understand "[showme] [a decimal number for the debugger]" as the debugger's showme command; [for consistency]
	understand "[showme] [a hexadecimal number for the debugger]" as the debugger's showme command; [for consistency]
	[//]
	understand "breakpoint number [a decimal number for the debugger]" or "breakpoint [a decimal number for the debugger]" or "[a decimal number for the debugger]" as a breakpoint number regardless of case;
	understand "line number [a decimal number for the debugger]" or "line [a decimal number for the debugger]" or "[a decimal number for the debugger]" as a line number regardless of case;
	understand "[--/the] function at address [a decimal number for the debugger]" or "[a decimal number for the debugger]" or "[--/the] function at address [a hexadecimal number for the debugger]" or "[a hexadecimal number for the debugger]" as a function address for the debugger regardless of case;
	[//]
	understand "xyzzy" as the debugger's xyzzy command regardless of case;
	understand "plugh" as the debugger's plugh command regardless of case;
	[//]
	understand "[printing the story's location]" as a help topic for the debugger;
	understand "[advancing the story]" as a help topic for the debugger;
	understand "[placing breakpoints]" as a help topic for the debugger;
	understand "[managing breakpoints]" as a help topic for the debugger;
	understand "[navigating the call stack]" as a help topic for the debugger;
	understand "[listing source text]" as a help topic for the debugger;
	understand "[inspecting values]" as a help topic for the debugger;
	understand "[managing preferences]" as a help topic for the debugger;
	understand "[getting information about the debugger]" as a help topic for the debugger;
	understand "[miscellaneous commands]" as a help topic for the debugger;
	[//]
	understand "printing the story's location" or "printing" as printing the story's location regardless of case;
	understand "advancing the story" or "advancing" as advancing the story regardless of case;
	understand "placing breakpoints" or "placing" as placing breakpoints regardless of case;
	understand "managing breakpoints" or "managing" as managing breakpoints regardless of case;
	understand "navigating the call stack" or "navigating" as navigating the call stack regardless of case;
	understand "listing source text" or "listing" as listing source text regardless of case;
	understand "inspecting values" or "inspecting" as inspecting values regardless of case;
	understand "managing preferences" or "managing" as managing preferences regardless of case;
	understand "getting information about the debugger" or "getting" as getting information about the debugger regardless of case;
	understand "miscellaneous commands" or "miscellaneous" or "misc" as miscellaneous commands regardless of case;
	[//]
	understand "list" or "l" as l/list regardless of case;
	understand "annotated" or "abt" or "a" as annotated regardless of case;
	understand "stack" or "call stack" or "backtrace" or "bt" as stack/call-stack/backtrace/bt regardless of case;
	understand "call" or "calls" as call/calls regardless of case;
	understand "print" or "p" or "examine" or "x" as examine regardless of case;
	understand "show" or "showme" or "show me" as showme regardless of case;
	understand "no" as the word no regardless of case;
	understand "through" or "to" or "-" or "--" as through regardless of case;
	understand "b" or "bre" or "break" or "stop" as b/bre/break/stop regardless of case;
	[//]
	understand "" or "a" or "an" or "the" as --/a/an/the regardless of case;
	understand "" or "any" or "every" as --/any/every regardless of case;
	understand "" or "at" or "on" as --/at/on regardless of case;
	understand "" or "the" as --/the regardless of case;
	understand "" or "my" as --/my regardless of case;
	[//]
	put the debug command parser into normal form.

Chapter "Debug Command Canonicalization" - unindexed

The debug command canonicalization rules are [rulebook is] a rulebook.

Chapter "Debug Command Scoring" - unindexed

The debug command scoring rules are [rulebook is] a rulebook.

Chapter "Debug Command Primary Filtration" - unindexed

The primary debug command filtration rules are [rulebook is] a rulebook.

To decide whether (V - a parse tree vertex) is a name error in a debug command:
	decide no.

To decide whether (V - a parse tree vertex that has the parseme a function name for the debugger) is a name error in a debug command:
	let the function name be a new synthetic text representing the words matched by V;
	let the correctness flag be whether or not the synthetic text the function name is a function name;
	delete the synthetic text the function name;
	decide on whether or not the correctness flag is false.

To decide whether (V - a parse tree vertex that has the parseme a function address for the debugger) is a name error in a debug command:
	let the function address be the function address named by V;
	let the routine record be the routine record for the function address;
	decide on whether or not the routine record is an invalid routine record.

To decide whether (V - a parse tree vertex that has the parseme a global name for the debugger) is a name error in a debug command:
	let the global name be a new synthetic text representing the words matched by V;
	let the correctness flag be whether or not the synthetic text the global name is a global name;
	delete the synthetic text the global name;
	decide on whether or not the correctness flag is false.

To decide whether (V - a parse tree vertex that has the parseme a memory stack variable name for the debugger) is a name error in a debug command:
	let the memory stack variable name be a new synthetic text representing the words matched by V;
	let the correctness flag be whether or not the synthetic text the memory stack variable name is a memory stack variable name;
	delete the synthetic text the memory stack variable name;
	decide on whether or not the correctness flag is false.

To decide whether (V - a parse tree vertex that has the parseme a local name for the debugger) is a name error in a debug command:
	let the local name be a new synthetic text representing the words matched by V;
	let the correctness flag be whether or not the synthetic text the local name is a local name;
	delete the synthetic text the local name;
	decide on whether or not the correctness flag is false.

To decide whether (V - a parse tree vertex that has the parseme a kind name for the debugger) is a name error in a debug command:
	let the kind name be a new synthetic text representing the words matched by V;
	let the correctness flag be whether or not the synthetic text the kind name is a kind name;
	delete the synthetic text the kind name;
	decide on whether or not the correctness flag is false.

To decide whether (V - a parse tree vertex that has the parseme an object name for the debugger) is a name error in a debug command:
	let the object name be a new synthetic text representing the words matched by V;
	let the correctness flag be whether or not the synthetic text the object name is an object name;
	delete the synthetic text the object name;
	decide on whether or not the correctness flag is false.

To decide whether a debug command name error appears under (V - a parse tree vertex):
	if V is a name error in a debug command:
		decide yes;
	repeat with the child running through the children of V:
		if a debug command name error appears under the child:
			decide yes;
	decide no.

A primary debug command filtration rule (this is the eschew name mismatches in debug commands rule):
	if a debug command name error appears under the root of the parse tree to filter:
		filter out the parse tree.

Chapter "Debug Command Secondary Filtration" - unindexed

The secondary debug command filtration rules are [rulebook is] a rulebook.

Chapter "Debug Command Disambiguation" - unindexed

To say (F - a disambiguation feature) as a disambiguation choice for (A - a context-free parser):
	let the array content be the punctuated word array content of A;
	say "'";
	repeat with the lexeme index running over the half-open interval from the beginning lexeme index of F to the end lexeme index of F:
		say "[if the lexeme index is not the beginning lexeme index of F] [end if][word lexeme index of the array content]";
	say "' as [the human-friendly name of the parseme of F]".

To decide what disambiguation feature is the debug command disambiguation choice for (A - a context-free parser) from (L - a linked list) with a none-of-the-above flag (N - a truth state) (this is disambiguating a debug command):
	now the debug command disambiguation attempted flag is true;
	if L is unit:
		always check that N is true or else fail at using debug command disambiguating for a non-question;
		let the disambiguation feature be L converted to a disambiguation feature;
		say "Do you mean [the disambiguation feature as a disambiguation choice for A]? ";
		if the author consents:
			decide on the disambiguation feature;
		decide on none of the offered disambiguation features;
	otherwise:
		say "Which do you mean?[line break]";
		let the option counter be zero;
		repeat with the linked list vertex running through L:
			let the disambiguation feature be the linked list vertex converted to a disambiguation feature;
			increment the option counter;
			say "[the option counter]. [the disambiguation feature as a disambiguation choice for A][line break]";
		if N is true:
			increment the option counter;
			say "[the option counter]. None of the above[line break]";
		let the choice be the disambiguation choice among the option counter options;
		if the choice is zero:
			decide on aborting disambiguation;
		repeat with the linked list vertex running through L:
			decrement the choice;
			if the choice is zero:
				decide on the linked list vertex converted to a disambiguation feature;
		decide on none of the offered disambiguation features.

Chapter "Debug Command Input" - unindexed

Section "Debug Command Input Handler" - unindexed

The last-seen debug command punctuated words are a punctuated word array that varies.
The last-seen debug command vertex is a parse tree vertex that varies.

The debug command disambiguation attempted flag is a truth state that varies.

The raw debug command is some text that varies.

To dispatch the debug command (T - some text) (this is dispatching a debug command):
	unless the current debugger coexecution state is story interrupted:
		now the debugger's current call frame is the innermost call frame of a reconstructed call stack;
		adjust the debugger's current call frame;
	while within the debugger window via the debugger wrapping layer:
		say "[line break]";
		write the punctuated words of T to the debug command parser;
		now the debug command disambiguation attempted flag is false;		
		let the root be the root of the match for a debug command canonicalized by the debug command canonicalization rulebook and disambiguated by scores from the debug command scoring rulebook and primary filtration from the primary debug command filtration rulebook and secondary filtration from the secondary debug command filtration rulebook and disambiguating choices from disambiguating a debug command;
		if the root is null:
			if the debug command disambiguation attempted flag is false:
				say "I didn't understand that command.  Check for misspellings or type 'help' to see the commands I do know.[paragraph break]";
		otherwise:
			let the command vertex be the first child of the root;
			now the raw debug command is T;
			if the command vertex has the parseme the debugger's again command:
				handle the debug command rooted at the command vertex using a workaround for Inform bug 825;
				delete the root and its descendants;
			otherwise:
				unless the last-seen debug command vertex is an invalid parse tree vertex:
					delete the last-seen debug command punctuated words;
					delete the last-seen debug command vertex and its descendants;
				now the last-seen debug command punctuated words are the punctuated word array content of the debug command parser;
				now the last-seen debug command vertex is the command vertex;
				handle the debug command rooted at the command vertex using a workaround for Inform bug 825;
	unless the current debugger coexecution state is story interrupted:
		let the moribund call frame be the leaf of the debugger's current call frame;
		delete the moribund call frame and its ancestors;
	if the debugger prompting flag is true:
		request a debug command.

Section "Debug Input Requests" - unindexed

To request a debug command:
	cancel any request for a debug input line;
	while within the debugger window via the debugger wrapping layer:
		say "Debug command? ";
	request a debug input line to be handled by dispatching a debug command.

Chapter "Debug Command Demand-Driven Disambiguation" - unindexed

Section "Function Name Disambiguation" - unindexed

To decide what number is the address of the function whose name is named by (V - a parse tree vertex):
	let the function name be a new synthetic text representing the words matched by V;
	ensure that all routines have names;
	let the function list be the list of addresses matching the function name the function name;
	repeat with the linked list vertex running through the function list:
		let the key be the number key of the linked list vertex;
		let the moribund vertex be the first match for the key the key after the linked list vertex;
		while the moribund vertex is not null:
			let the discarded value be the linked list vertex converted to a linked list after removing the moribund vertex;
			now the moribund vertex is the first match for the key the key after the linked list vertex;
	if the function list is empty:
		say "I couldn't find any such function.  Check for misspellings.[paragraph break]";
		delete the synthetic text the function name;
		decide on zero;
	if the function list is unit:
		delete the synthetic text the function name;
		decide on a number key popped off of the function list;
	let the sequence point be the sequence point to highlight;
	say "Which do you mean?[line break]";
	let the option counter be zero;
	repeat with the function address running through the number keys of the function list:
		increment the option counter;
		say "[the option counter]. '[the function name]' as '[the human-friendly name for the function at address the function address], which begins like this:[line break][fixed letter spacing]";
		let the routine record be the routine record for the function address;
		let the debug mode be the preferred debug mode for the routine record;
		if the debug mode is:
			-- debugging at the Glulx assembly level:
				parse the function at address the function address;
				let the end instruction vertex be the disambiguation listing length plus one instruction vertices after the scratch space beginning vertex or else the end of the function;
				say "[the Glulx assembly from the scratch space beginning vertex to the end instruction vertex with the sequence point zero selected]";
			-- debugging at the I6 level:
				let the beginning line number be the beginning line number of the routine record;
				let the end line number be the disambiguation listing length plus one lines after I6 line number the beginning line number or else the end of the function;
				say "[the I6 from line number the beginning line number to the end line number with line number zero selected]";
				unless the end line number is the end line number of the routine record:
					say "  ...[line break]";
			-- debugging at the I7 level:
				guess the routine kernel for the function address;
				let the routine kernel address be the routine kernel address of the function at address the function address;
				unless the routine kernel address is zero:
					now the routine record is the routine record for the routine kernel address;
					always check that the routine record is not an invalid routine record or else fail at finding a routine record for a kernel;
				let the beginning line number be the beginning line number of the routine record;
				let the end line number be the disambiguation listing length plus one lines after I7 line number the beginning line number or else the end of the function;
				say "[the I7 from line number the beginning line number to the end line number with line number zero selected]";
				if there is an I7 line in the half-open interval from line number the end line number to the end line number of the routine record:
					say "  ...[line break]";
		say "[variable letter spacing]";
	delete the synthetic text the function name;
	let the choice be the disambiguation choice among the option counter options;
	repeat with the function address running through the number keys of the function list:
		decrement the choice;
		if the choice is zero:
			delete the function list;
			decide on the function address;
	delete the function list;
	decide on zero.

Section "Global Name Disambiguation" - unindexed

To decide what global record is the global record named by (V - a parse tree vertex):
	let the global name be a new synthetic text representing the words matched by V;
	downcase the synthetic text the global name;
	let the global record list be a new list of global records matching the global name the global name;
	repeat with the linked list vertex running through the global record list:
		let the key be the global record key of the linked list vertex;
		let the address be the address of the key;
		let the remaining list be the link of the linked list vertex converted to a linked list;
		if the source version of the key is six:
			repeat with the potentially moribund vertex running through the remaining list:
				let the potentially moribund key be the global record key of the potentially moribund vertex;
				if the address of the potentially moribund key is the address and the source version of the potentially moribund key is seven:
					now the key is the potentially moribund key;
					write the key the key to the linked list vertex;
					let the discarded value be the linked list vertex converted to a linked list after removing the potentially moribund vertex;
					now the remaining list is the link of the linked list vertex converted to a linked list;
					break;
		if the source version of the key is seven:
			repeat with the potentially moribund vertex running through the remaining list:
				let the potentially moribund key be the global record key of the potentially moribund vertex;
				if the address of the potentially moribund key is the address and the source version of the potentially moribund key is six:
					let the discarded value be the linked list vertex converted to a linked list after removing the potentially moribund vertex;
	if the global record list is empty:
		say "I couldn't find any such non-temporary named value.  Check for misspellings.[paragraph break]";
		delete the synthetic text the global name;
		decide on an invalid global record;
	if the global record list is unit:
		delete the synthetic text the global name;
		decide on a global record key popped off of the global record list;
	say "Which do you mean?[line break]";
	let the option counter be zero;
	repeat with the global record running through the global record keys of the global record list:
		increment the option counter;
		say "[the option counter]. '[the global name]' as '[the human-friendly name of the global record]', an I[the source version of the global record] non-temporary named value[line break]";
	delete the synthetic text the global name;
	let the choice be the disambiguation choice among the option counter options;
	repeat with the global record running through the global record keys of the global record list:
		decrement the choice;
		if the choice is zero:
			delete the global record list;
			decide on the global record;
	delete the global record list;
	decide on an invalid global record.

Section "Memory Stack Variable Name Disambiguation" - unindexed

[Inform should guarantee either zero or one matches, so we really don't disambiguate.]
To decide what memory stack variable record is the memory stack variable record named by (V - a parse tree vertex):
	let the memory stack variable name be a new synthetic text representing the words matched by V;
	downcase the synthetic text the memory stack variable name;
	let the memory stack variable record list be a new list of memory stack variable records matching the memory stack variable name the memory stack variable name;
	if the memory stack variable record list is empty:
		say "I couldn't find any such rulebook or action variable.  Check for misspellings.[paragraph break]";
		delete the synthetic text the memory stack variable name;
		decide on an invalid memory stack variable record;
	let the result be a memory stack variable record key popped off of the memory stack variable record list;
	delete the synthetic text the memory stack variable name;
	delete the memory stack variable record list;
	decide on the result.

Section "Local Name Disambiguation" - unindexed

To decide what number is the local index named by (V - a parse tree vertex):
	let the local name be a new synthetic text representing the words matched by V;
	[(No downcasing is necessary.)]
	let the I7 result be the index of the local with I7 name the local name in the selected frame;
	let the I6 result be the index of the local with I6 name the local name in the selected frame;
	if the I7 result is at least zero:
		if the I6 result is at least zero:
			say "Which do you mean?[line break]";
			say "1. '[the local name]' as '[the local name]', an I6 temporary named value[line break]";
			say "2. '[the local name]' as '[the local name]', an I7 temporary named value[line break]";
			delete the synthetic text the local name;
			let the choice be the disambiguation choice among the two options;
			if the choice is:
				-- 1:
					decide on the I6 result;
				-- 2:
					decide on the I7 result;
				-- otherwise:
					decide on -1;
		otherwise:
			delete the synthetic text the local name;
			decide on the I7 result;
	otherwise if the I6 result is at least zero:
		delete the synthetic text the local name;
		decide on the I6 result;
	otherwise:
		say "I couldn't find any such temporary named value in the selected call frame.  Check for misspellings or use the command 'backtrace' to see which call frame is selected.[paragraph break]";
		delete the synthetic text the local name;
		decide on -1.

Section "Object Name Disambiguation" - unindexed

[Inform should guarantee either zero or one matches, so we really don't disambiguate.]
To decide what number is the object value named by (V - a parse tree vertex):
	let the object name be a new synthetic text representing the words matched by V;
	downcase the synthetic text the object name;
	let the object address list be a new list of object addresses matching the object name the object name;
	if the object address list is empty:
		say "I couldn't find any such object.  Note that I only understand object by their full source text names, as printed in the world index.[paragraph break]";
		delete the synthetic text the object name;
		decide on -1;
	let the result be a number key popped off of the object address list;
	delete the synthetic text the object name;
	delete the object address list;
	decide on the result.

Book "Commands" - unindexed

Chapter "Default Handler for Unimplemented Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex):
	say "[runtime failure in]Interactive Debugger[with explanation]That command, [the human-friendly name of the parseme of V], is not yet implemented.[continuing anyway][line break]".

Chapter "The Quit Command" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's quit command):
	say "Are you sure you want to quit both the debugger and the story (y or n)? ";
	if the author consents:
		terminate the story;
	say "[line break]".

Chapter "The Again Command" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's again command):
	if the last-seen debug command vertex is not an invalid parse tree vertex:
		if the last-seen debug command vertex has the parseme the debugger's again command:
			say "[low-level runtime failure in]Interactive Debugger[with explanation]Attempting an infinite loop of 'again's.[continuing anyway]";
		otherwise:
			delete the punctuated words from the debug command parser;
			write the content the last-seen debug command punctuated words and the lexeme count the word count of the last-seen debug command punctuated words to the debug command parser;
			handle the debug command rooted at the last-seen debug command vertex using a workaround for Inform bug 825.

Chapter "Extension Information Commands" - unindexed

To say the debugger version:
	say "Version 2 (1 May 2013)".
To say the debugger copyright:
	say "Copyright 2013 Brady J. Garvin".

The banner printed flag is a truth state that varies.  The banner printed flag is false.
To say the debugger banner text:
	if banner printed flag is false:
		say "[bold type]An Interactive Debugger for Inform 7[roman type][line break]";
		say "[bold type][the debugger version][roman type][paragraph break]";
		say "There may be a slight delay whenever something happens for the first time---the first time a rulebook is used, the first time a story command is parsed, or the first time the action machinery runs, for instance.[no line break][unless the interpreter is git]  It may help to switch to the git interpreter.[no line break][end if][paragraph break]";
		say "Enter the command 'help' at the debug prompt for help.[paragraph break]";
		now banner printed flag is true.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's about command):
	say "Interactive Debugger.i7x, [the debugger version][line break]";
	say "[the debugger copyright][line break]";
	say "Part of the Glulx Runtime Instrumentation Project (https://github.com/i7/i7grip)[paragraph break]";
	say "See the extension documentation or the documentation at GitHub for more information.[paragraph break]"

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's version command):
	say "[the debugger version][paragraph break]".

Chapter "Help Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's help command):
	let the topic vertex be the first match for a help topic for the debugger among the children of V;
	if the topic vertex is an invalid parse tree vertex:
		say "Available help topics:[line break]";
		say "    Printing the Story's Location[line break]";
		say "    Advancing the Story[line break]";
		say "    Placing Breakpoints[line break]";
		say "    Managing Breakpoints[line break]";
		say "    Navigating the Call Stack[line break]";
		say "    Listing Source Text[line break]";
		say "    Inspecting Values[line break]";
		say "    Managing Preferences[line break]";
		say "    Getting Information about the Debugger[line break]";
		say "    Miscellaneous Commands[paragraph break]";
		say "Type 'help' followed by a topic for help on that topic.[paragraph break]";
	otherwise:
		handle the help topic the parseme of the first child of the topic vertex.

To handle the help topic (S - a parseme):
	say "I'm afraid that I couldn't find any entry for that help topic.[paragraph break]".

To handle the help topic (S - a parseme that is printing the story's location):
	say "I know the following commands for printing the story's location.[paragraph break]";
	say "summary[line break]";
	say "    show where execution is paused from the perspective of the selected call frame.[paragraph break]".

To handle the help topic (S - a parseme that is advancing the story):
	say "I know the following commands for advancing the story.[paragraph break]";
	say "go[italic type] -or-[roman type][line break]continue[italic type] -or-[roman type][line break]c[line break]";
	say "    resume execution until the next breakpoint.[paragraph break]";
	say "step[italic type] -or-[roman type][line break]s[italic type] -or-[roman type][line break]next line anywhere[line break]";
	say "    resume execution until any task in the story reaches another line, unless interrupted by a breakpoint.[paragraph break]";
	say "next[italic type] -or-[roman type][line break]n[italic type] -or-[roman type][line break]next line[line break]";
	say "    resume execution until the selected task reaches another line (or terminates), unless interrupted by a breakpoint.[paragraph break]";
	say "finish[italic type] -or-[roman type][line break]fin[italic type] -or-[roman type][line break]f[italic type] -or-[roman type][line break]finish this call[line break]";
	say "    resume execution until the selected task completes, unless interrupted by a breakpoint.[paragraph break]";
	say "step sequence point[italic type] -or-[roman type][line break]si[italic type] -or-[roman type][line break]next sequence point anywhere[line break]";
	say "    resume execution until any task in the story reaches another sequence point.[paragraph break]";
	say "next sequence point[italic type] -or-[roman type][line break]ni[line break]";
	say "    resume execution until the selected task reaches another sequence point (or terminates), unless interrupted by a breakpoint.[paragraph break]".

To handle the help topic (S - a parseme that is placing breakpoints):
	say "I know the following commands for placing breakpoints.[paragraph break]";
	say "break[italic type] -or-[roman type][line break]bre[italic type] -or-[roman type][line break]b[italic type] -or-[roman type][line break]stop[line break]";
	say "    place a breakpoint wherever the selected task is paused.[paragraph break]";
	say "break [bracket]a source text location[close bracket][italic type] -or-[roman type][line break]bre [bracket]a source text location[close bracket][italic type] -or-[roman type][line break]b [bracket]a source text location[close bracket][italic type] -or-[roman type][line break]stop [bracket]a source text location[close bracket][line break]";
	say "    place a breakpoint at the given location in the source text.  It can be written as a rule name, a phrase name, the preamble of an unnamed rule, an I6 routine name, a function address in decimal or hexadecimal, an I7 line number, or an I6 line number, any of which can be prefixed by the word 'at' or the word 'on'.[paragraph break]".

To handle the help topic (S - a parseme that is managing breakpoints):
	say "I know the following commands for managing breakpoints.[paragraph break]";
	say "breakpoint information[italic type] -or-[roman type][line break]information[italic type] -or-[roman type][line break]info[italic type] -or-[roman type][line break]i b[italic type] -or-[roman type][line break]i[line break]";
	say "    list all breakpoints with short descriptions, indicating whether they are enabled or disabled.[paragraph break]";
	say "enable [bracket]a breakpoint number[close bracket][italic type] -or-[roman type][line break]ena [bracket]a breakpoint number[close bracket][line break]";
	say "    enable the breakpoint with the given number.[paragraph break]";
	say "enable all breakpoints[italic type] -or-[roman type][line break]ena all breakpoints[italic type] -or-[roman type][line break]ena[line break]";
	say "    enable every breakpoint.[paragraph break]";
	say "disable [bracket]a breakpoint number[close bracket][italic type] -or-[roman type][line break]dis [bracket]a breakpoint number[close bracket][line break]";
	say "    disable the breakpoint with the given number.[paragraph break]";
	say "disable all breakpoints[italic type] -or-[roman type][line break]dis all breakpoints[italic type] -or-[roman type][line break]dis[line break]";
	say "    disable every breakpoint.[paragraph break]";
	say "delete [bracket]a breakpoint number[close bracket][italic type] -or-[roman type][line break]del [bracket]a breakpoint number[close bracket][line break]";
	say "    delete the breakpoint with the given number.[paragraph break]";
	say "delete all breakpoints[italic type] -or-[roman type][line break]del all breakpoints[italic type] -or-[roman type][line break]del[italic type] -or-[roman type][line break]d b[line break]";
	say "    delete every breakpoint.[paragraph break]".

To handle the help topic (S - a parseme that is navigating the call stack):
	say "I know the following commands for navigating the call stack.[paragraph break]";
	say "examine the call stack[italic type] -or-[roman type][line break]x stack[italic type] -or-[roman type][line break]stack[italic type] -or-[roman type][line break]backtrace[italic type] -or-[roman type][line break]bt[italic type] -or-[roman type][line break]where[line break]";
	say "    display the call stack, noting the selected call frame.[paragraph break]";
	say "select [bracket]a call frame number[close bracket][italic type] -or-[roman type][line break]sel [bracket]a call frame number[close bracket][line break]";
	say "    change the selected call frame to the one indicated.[paragraph break]";
	say "in[line break]";
	say "    select the call frame one call inward from the current selection.[paragraph break]";
	say "in [bracket]a call frame count[close bracket][line break]";
	say "    select the call frame the given number of calls inward from the current selection.[paragraph break]";
	say "out[line break]";
	say "    select the call frame one call outward from the current selection.[paragraph break]";
	say "out [bracket]a call frame count[close bracket][line break]";
	say "    select the call frame the given number of calls outward from the current selection.[paragraph break]".

To handle the help topic (S - a parseme that is listing source text):
	say "I know the following commands for listing source text.[paragraph break]";
	say "list[italic type] -or-[roman type][line break]l[line break]";
	say "    list the source text corresponding to the selected call frame.[paragraph break]";
	say "list [bracket]a source text location[close bracket][italic type] -or-[roman type][line break]l [bracket]a source text location[close bracket][line break]";
	say "    list the source text at the given location.  It can be written as a rule name, a phrase name, the preamble of an unnamed rule, an I6 routine name, a function address in decimal or hexadecimal, an I7 line number, a range of I7 line numbers, an I6 line number, or a range of I6 line numbers.[paragraph break]".

To handle the help topic (S - a parseme that is inspecting values):
	say "I know the following commands for inspecting values.[paragraph break]";
	say "examine [bracket]a variable name[close bracket][italic type] -or-[roman type][line break]x [bracket]a variable name[close bracket][italic type] -or-[roman type][line break]print [bracket]a variable name[close bracket][italic type] -or-[roman type][line break]p [bracket]a variable name[close bracket][line break]";
	say "    show the value of the named variable.  If the variable is a temporary named value, give the value in the selected call frame.[paragraph break]";
	say "examine [bracket]an object name[close bracket][italic type] -or-[roman type][line break]x [bracket]an object name[close bracket][italic type] -or-[roman type][line break]print [bracket]an object name[close bracket][italic type] -or-[roman type][line break]p [bracket]an object name[close bracket][line break]";
	say "    show the named object.[paragraph break]";
	say "examine [bracket]a function name[close bracket][italic type] -or-[roman type][line break]x [bracket]a function name[close bracket][italic type] -or-[roman type][line break]print [bracket]a function name[close bracket][italic type] -or-[roman type][line break]p [bracket]a function name[close bracket][line break]";
	say "    show the named rule, phrase, or I6 routine.[paragraph break]";
	say "showme [bracket]a variable name[close bracket][line break]";
	say "    convert the value of the named variable to an object and display it and all of its properties.  If the variable is a temporary named value, use the value in the selected call frame.[paragraph break]";
	say "showme [bracket]an object name[close bracket][line break]";
	say "    display the named object and all of its properties.[paragraph break]";
	say "showme [bracket]a number[close bracket][line break]";
	say "    convert the number to an object and display it and all of its properties.  The number can be given in decimal or hexadecimal.[paragraph break]";
	say "examine [bracket]a variable name[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]x [bracket]a variable name[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]print [bracket]a variable name[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]p [bracket]a variable name[close bracket] as [bracket]a kind name[close bracket][line break]";
	say "    show the value of the named variable after converting it to the named kind.  If the variable is a temporary named value, give the value in the selected call frame.[paragraph break]";
	say "examine [bracket]an object name[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]x [bracket]an object name[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]print [bracket]an object name[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]p [bracket]an object name[close bracket] as [bracket]a kind name[close bracket][line break]";
	say "    show the named object after converting it to the named kind.[paragraph break]";
	say "examine [bracket]a number[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]x [bracket]a number[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]print [bracket]a number[close bracket] as [bracket]a kind name[close bracket][italic type] -or-[roman type][line break]p [bracket]a number[close bracket] as [bracket]a kind name[close bracket][line break]";
	say "    show the given number after converting it to the named kind.  It can be given in decimal or hexadecimal.[paragraph break]".

To handle the help topic (S - a parseme that is managing preferences):
	say "I know the following commands for managing preferences.  More are listed in parts two, three, and four.[paragraph break]";
	say "examine my preferences[italic type] -or-[roman type][line break]x preferences[italic type] -or-[roman type][line break]preferences[line break]";
	say "    Show all of the current preferences.[paragraph break]";
	say "prefer call stack simplification[italic type] -or-[roman type][line break]prefer simplification[line break]";
	say "    request that call frames for Inform internals be hidden when the call stack is examined.  This command renumbers the call frames and may change which one is selected.[paragraph break]";
	say "prefer no call stack simplification[italic type] -or-[roman type][line break]prefer no simplification[line break]";
	say "    request that call frames for Inform internals not be hidden when the call stack is examined.  This command renumbers the call frames.[paragraph break]";
	say "prefer limitations on saving[line break]";
	say "    request that attempts to save the story always fail, which is useful in interpreters that cannot save the debugger's state quickly.[paragraph break]";
	say "prefer no limitations on saving[line break]";
	say "    request that attempts to save the story proceed normally, even if the interpreter cannot save the debugger's state quickly.[paragraph break]".

To handle the help topic (S - a parseme that is getting information about the debugger):
	say "I know the following commands for getting information about the debugger.[paragraph break]";
	say "about[line break]";
	say "    display the version number, release date, and website URL.[paragraph break]";
	say "version[line break]";
	say "    display just the version number, which is useful when reporting bugs.[paragraph break]".

To handle the help topic (S - a parseme that is miscellaneous commands):
	say "I know the following miscellaneous commands.[paragraph break]";
	say "again[italic type] -or-[roman type][line break]g[italic type] -or-[roman type][line break][bracket]an empty line[close bracket][line break]";
	say "    repeat the previous command.[paragraph break]";
	say "quit[line break]";
	say "    force both the story and the debugger to stop running.[paragraph break]".

Chapter "Preference Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's prefer command):
	let the simplification vertex be the first match for call stack simplification among the children of V;
	unless the simplification vertex is an invalid parse tree vertex:
		if the word no appears among the children of V:
			now the call stack simplification flag is false;
			now the debugger's current call frame number is zero;
			let the current call frame be the inward link of the debugger's current call frame;
			while the current call frame is not null:
				increment the debugger's current call frame number;
				now the current call frame is the inward link of the current call frame;
			say "The debugger will now show entire call stacks, without eliding internal Inform routines.  'Step' and 'next' will stop on lines in these routines, and 'finish' will stop as soon as any routine on the call stack completes its execution.  When the story pauses, the location where it paused will always be selected.[paragraph break]";
		otherwise:
			now the call stack simplification flag is true;
			if the debugger's current call frame is elided in the simplified call stack:
				let the current call frame be the leaf of the debugger's current call frame;
				while the current call frame is not null and the current call frame is elided in the simplified call stack:
					now the current call frame is the outward link of the current call frame;
				if the current call frame is null:
					now the call stack simplification flag is false;
					say "Simplification would elide all of the present call frames, so it cannot be enabled.[paragraph break]";
					stop;
				now the debugger's current call frame is the current call frame;
				say "(first resetting the selected call frame because the previous selection will be elided)[line break]";
			now the debugger's current call frame number is zero;
			let the current call frame be the inward link of the debugger's current call frame;
			while the current call frame is not null:
				unless the current call frame is elided in the simplified call stack:
					increment the debugger's current call frame number;
				now the current call frame is the inward link of the current call frame;
			say "The debugger will now show simplified call stacks, eliding internal Inform routines.  'Step' and 'next' will skip lines in these routines, and 'finish' will not stop until a non-internal function completes its execution.  When the story pauses, the nearest location in the simplified call stack will be selected, which may not be the point where the story actually paused.[paragraph break]";
		stop;
	let the limitations on saving vertex be the first match for limitations on saving among the children of V;
	unless the limitations on saving vertex is an invalid parse tree vertex:
		if the word no appears among the children of V:
			now the GRIF allows saves flag is true;
			say "The debugger will now allow the story to be saved, even though saving could be slow given the amount of information in the debugger's memory.[paragraph break]";
		otherwise:
			now the GRIF allows saves flag is false;
			say "The debugger will now cause attempts to save the story to fail, on the grounds that saving could be slow given the amount of information in the debugger's memory.[paragraph break]";
		stop;
	say "[low-level runtime failure in]Interactive Debugger[with explanation]I can parse that 'prefer' command, but I cannot find any corresponding semantics.[continuing anyway]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's preferences command):
	say "The debugger is set to [if the call stack simplification flag is true]simplify call stacks, eliding internal Inform routines.  'Step' and 'next' will skip lines in these routines, and 'finish' will not stop until a non-internal function completes its execution.  When the story pauses, the nearest location in the simplified call stack will be selected, which may not be the point where the story actually paused[otherwise]show entire call stacks, without eliding internal Inform routines.  'Step' and 'next' will stop on lines in these routines, and 'finish' will stop as soon as any routine on the call stack completes its execution.  When the story pauses, the location where it paused will always be selected[end if].";
	say "The debugger is set to [if the GRIF allows saves flag is false]cause attempts to save the story to fail, on the grounds that saving could be slow given the amount of information in the debugger's memory[otherwise]allow the story to be saved, even though saving could be slow given the amount of information in the debugger's memory[end if].";
	say "[line break]".

Chapter "Backtrace Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's summary command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	now the currently preferred debug mode is debugging at the I7 level;
	let the language vertex be the first match for a debugging language among the children of V;
	unless the language vertex is an invalid parse tree vertex:
		if the Glulx language appears among the children of the language vertex:
			now the currently preferred debug mode is debugging at the Glulx assembly level;
		otherwise if the I6 language appears among the children of the language vertex:
			now the currently preferred debug mode is debugging at the I6 level;
	say "[if the current debugger coexecution state is story interrupted]Execution paused[otherwise]Executing [bold type](not paused)[roman type][end if] [the location synopsis for the sequence point the sequence point to highlight in the call frame the debugger's current call frame][line break]".

The backtrace flag is a truth state that varies.  The backtrace flag is false.
Definition: a number is selected-by-the-backtrace if the backtrace flag is true and it is the debugger's current call frame number.

To say custom annotations for (A - a call frame) with frame number (I - a selected-by-the-backtrace number):
	say " (currently selected)".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's backtrace command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	say "[if the current debugger coexecution state is story interrupted]Execution paused[otherwise]Executing [bold type](not paused)[roman type][end if][line break]";
	if the call stack simplification flag is true and the leaf of the debugger's current call frame is elided in the simplified call stack:
		say "within one or more elided call frames (use the command 'prefer no simplification' to make them visible)[line break]";
	now the backtrace flag is true;
	let the old call frame numbering flag be the call frame numbering flag;
	let the old original arguments flag be the original arguments flag;
	let the old temporary named values flag be the temporary named values flag;
	now the call frame numbering flag is true;
	if annotated appears among the children of V:
		now the original arguments flag is true;
		now the temporary named values flag is true;
	otherwise:
		now the original arguments flag is false;
		now the temporary named values flag is false;
	say "[the call stack]";
	now the call frame numbering flag is the old call frame numbering flag;
	let the original arguments flag be the old original arguments flag;
	let the temporary named values flag be the old temporary named values flag;
	now the backtrace flag is false.

To move in (N - a number) call frame/frames:
	let the counter be N;
	let the current call frame be the debugger's current call frame;
	while the inward link of the current call frame is not null and the counter is greater than zero:
		now the current call frame is the inward link of the current call frame;
		unless the call stack simplification flag is true and the current call frame is elided in the simplified call stack:
			decrement the counter;
	if the counter is zero:
		now the debugger's current call frame is the current call frame;
		decrease the debugger's current call frame number by N;
		say "The selected frame is now[line break]  [the location of the debugger's current call frame with frame number the debugger's current call frame number].[paragraph break]";
	otherwise:
		say "There is no call frame [N in words] layer[unless N is one]s[end if] inward from the current selection.  You can see the placement of the current selection with the command 'backtrace'.[paragraph break]".

To move out (N - a number) call frame/frames:
	let the counter be N;
	let the current call frame be the debugger's current call frame;
	while the outward link of the current call frame is not null and the counter is greater than zero:
		now the current call frame is the outward link of the current call frame;
		unless the call stack simplification flag is true and the current call frame is elided in the simplified call stack:
			decrement the counter;
	if the counter is zero:
		now the debugger's current call frame is the current call frame;
		increase the debugger's current call frame number by N;
		say "The selected frame is now[line break]  [the location of the debugger's current call frame with frame number the debugger's current call frame number].[paragraph break]";
	otherwise:
		say "There is no call frame [N in words] layer[unless N is one]s[end if] outward from the current selection.  You can see the placement of the current selection with the command 'backtrace'.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's select command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is currently running, so any call frame selection would be lost immediately.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of V;
	let the target be the decimal number named by the decimal vertex;
	if the target is less than the debugger's current call frame number:
		let the count be the debugger's current call frame number minus the target;
		move in count call frames;
	otherwise if the target is greater than the debugger's current call frame number:
		let the count be the target minus the debugger's current call frame number;
		move out count call frames;
	otherwise:
		say "The selected frame is unchanged,[line break]  [the location of the debugger's current call frame with frame number the debugger's current call frame number].[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's inward command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is currently running, so any call frame selection would be lost immediately.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	move in one call frame.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's inward-by-distance command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is currently running, so any call frame selection would be lost immediately.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of V;
	let the count be the decimal number named by the decimal vertex;
	move in count call frames.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's outward command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is currently running, so any call frame selection would be lost immediately.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	move out one call frame.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's outward-by-distance command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is currently running, so any call frame selection would be lost immediately.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of V;
	let the count be the decimal number named by the decimal vertex;
	move out count call frames.

Chapter "Listing Commands" - unindexed

Section "Counting Lines" - unindexed

To decide what number is the Glulx assembly count in the half-open interval from (B - an instruction vertex) to (E - an instruction vertex):
	let the result be zero;
	let the instruction vertex be B;
	while the instruction vertex is not null and the instruction vertex is not E:
		increment the result;
		now the instruction vertex is the next link of the instruction vertex;
	decide on the result.

To decide what number is the I6 line count in the half-open interval from line number (B - a number) to (E - a number):
	if E is less than B:
		decide on zero;
	decide on the E minus B.

To decide what number is the I7 line count in the half-open interval from line number (B - a number) to (E - a number):
	let the result be zero;
	repeat with the line number running over the half-open interval from B to E:
		let the source line record be the source line record for line number the line number;
		if the source line record is an invalid source line record:
			decide on the result;
		if the I7 of the source line record is not empty:
			increment the result;
	decide on the result.

To decide whether there is an I7 line in the half-open interval from line number (B - a number) to (E - a number):
	repeat with the line number running over the half-open interval from B to E:
		let the source line record be the source line record for line number the line number;
		if the source line record is an invalid source line record:
			decide no;
		if the I7 of the source line record is not empty:
			decide yes;
	decide no.

Section "Moving by Sequence Point Boundaries" - unindexed

To decide what instruction vertex is the next sequence point instruction vertex after (V - an instruction vertex) or else a null instruction vertex:
	let the result be the next link of V;
	while the result is not null:
		if the source address of the result is a sequence point:
			decide on the result;
		now the result is the next link of the result;
	decide on the result.

Section "Moving by Line Counts" - unindexed

To decide what instruction vertex is (N - a number) instruction vertex/vertices before (V - an instruction vertex) or else the beginning of the function:
	let the result be V;
	repeat with a counter running from one to N:
		let the previous link be the previous link of the result;
		if the previous link is null:
			decide on the result;
		now the result is the previous link;
	decide on the result.

To decide what instruction vertex is (N - a number) instruction vertex/vertices after (V - an instruction vertex) or else the end of the function:
	let the result be V;
	repeat with a counter running from one to N:
		let the next link be the next link of the result;
		if the next link is null:
			decide on the result;
		now the result is the next link;
	decide on the result.

To decide what number is (N - a number) line/lines before I6 line number (L - a number) or else the beginning of the function:
	if N is at most zero:
		decide on L;
	let the source line record be the source line record for line number L;
	if the source line record is an invalid source line record:
		decide on L;
	let the routine record be the sole routine record of the source line record;
	if the routine record is an invalid routine record:
		decide on L minus N;
	let the beginning line number be the beginning line number of the routine record;
	if L minus N is greater than the beginning line number:
		decide on L minus N;
	decide on the beginning line number.

To decide what number is (N - a number) line/lines after I6 line number (L - a number) or else the end of the function:
	if N is at most zero:
		decide on L;
	let the source line record be the source line record for line number L;
	if the source line record is an invalid source line record:
		decide on L;
	let the routine record be the sole routine record of the source line record;
	if the routine record is an invalid routine record:
		decide on L plus N;
	let the end line number be the end line number of the routine record;
	if L plus N is less than the end line number:
		decide on L plus N;
	decide on the end line number.

To decide what number is (N - a number) line/lines before I7 line number (L - a number) or else the beginning of the function:
	if N is at most zero:
		decide on L;
	let the source line record be the source line record for line number L;
	if the source line record is an invalid source line record:
		decide on L;
	let the routine record be the sole routine record of the source line record;
	if the routine record is an invalid routine record:
		decide on L;
	let the beginning line number be the beginning line number of the routine record;
	let the line number be L;
	let the remaining decrements be N;
	while the line number minus the remaining decrements is at least the beginning line number:
		decrement the line number;
		now the source line record is the source line record for line number the line number;
		if the I7 of the source line record is not empty:
			decrement the remaining decrements;
			if the remaining decrements are zero:
				decide on the line number;
	repeat with the earliest line number running from the beginning line number to L:
		now the source line record is the source line record for line number the earliest line number;
		if the I7 of the source line record is not empty:
			decide on the earliest line number;
	decide on L.

To decide what number is (N - a number) line/lines after I7 line number (L - a number) or else the end of the function:
	if N is at most zero:
		decide on L;
	let the source line record be the source line record for line number L;
	if the source line record is an invalid source line record:
		decide on L;
	let the routine record be the sole routine record of the source line record;
	if the routine record is an invalid routine record:
		decide on L;
	let the end line number be the end line number of the routine record;
	let the line number be L;
	let the remaining increments be N;
	while the line number plus the remaining increments is at most the end line number:
		increment the line number;
		now the source line record is the source line record for line number the line number;
		if the I7 of the source line record is not empty:
			decrement the remaining increments;
			if the remaining increments are zero:
				decide on the line number;
	decide on the end line number.

Section "Lowest Level Listing Say Phrases" - unindexed

To say the nonnegative number (N - a number) as at least six digits:
	say "[if N is less than 100000]0[end if][if N is less than 10000]0[end if][if N is less than 1000]0[end if][if N is less than 100]0[end if][if N is less than 10]0[end if][N converted to a number]".

To say (N - a number) tab/tabs:
	repeat with a counter running from one to N:
		say "    ".

To say (T - some text) with tabs rendered as spaces:
	let the synthetic text be a new synthetic text copied from T;
	repeat with the character code running through the character codes in the synthetic text the synthetic text:
		if the character code is nine [tab]:
			say "    ";
		otherwise:
			say "[the character code converted to a Unicode character]";
	delete the synthetic text the synthetic text.

Section "Unnumbered Listing" - unindexed

[These phrases do not change letter spacing.]
[These phrases do not print trailing blank lines.]
[These phrases do not print error messages in place of empty listings.]

To say the unnumbered Glulx assembly for (V - an instruction vertex):
	say "[the label of V]> [if the source address of V is a sequence point]<*>[otherwise]   [end if] [the I6-like assembly of V using labels if possible][line break]".

To say the unnumbered I6 for line number (N - a number):
	let the source line record be the source line record for line number N;
	if the source line record is not an invalid source line record:
		let the I6 be the I6 of the source line record;
		say "> [the I6 with tabs rendered as spaces][line break]".

To say the unnumbered I7 for line number (N - a number):
	let the source line record be the source line record for line number N;
	if the source line record is not an invalid source line record:
		let the indentation be the I7 indentation of the source line record;
		let the I7 be the I7 of the source line record;
		unless the I7 is empty:
			say "> [the indentation tabs][the I7 with tabs rendered as spaces][line break]".

Section "Numbered Single-Line Listing" - unindexed

[These phrases do not change letter spacing.]
[These phrases do not print trailing blank lines.]
[These phrases do not print error messages in place of empty listings.]

To say the Glulx assembly for (V - an instruction vertex) with the sequence point (S - a number) selected:
	say "[the label of V][if the source address of V is S]>[otherwise] [end if] [if the source address of V is a sequence point]<*>[otherwise]   [end if] [the source address of V in hexadecimal] [the I6-like assembly of V using labels if possible][line break]".

To say the I6 for line number (N - a number) with line number (S - a number) selected:
	let the source line record be the source line record for line number N;
	if the source line record is not an invalid source line record:
		let the I6 be the I6 of the source line record;
		say "[if N is S]>[otherwise] [end if] [the nonnegative number N as at least six digits] [the I6 with tabs rendered as spaces][line break]".

To say the I7 for line number (N - a number) with line number (S - a number) selected:
	let the source line record be the source line record for line number N;
	if the source line record is not an invalid source line record:
		let the indentation be the I7 indentation of the source line record;
		let the I7 be the I7 of the source line record;
		unless the I7 is empty:
			say "[if N is S]>[otherwise] [end if] [the nonnegative number N as at least six digits] [the indentation tabs][the I7 with tabs rendered as spaces][line break]".

Section "Numbered Single-Line Listing with Errors" - unindexed

[These phrases do change letter spacing.]
[These phrases do print trailing blank lines.]
[These phrases do print error messages in place of empty listings.]

To say only the I6 for line number (N - a number) with line number (S - a number) selected:
	let the source line record be the source line record for line number N;
	if the source line record is not an invalid source line record:
		let the I6 be the I6 of the source line record;
		say "[fixed letter spacing][if N is S]>[otherwise] [end if] [the nonnegative number N as at least six digits] [the I6 with tabs rendered as spaces][variable letter spacing][paragraph break]";
	otherwise:
		say "There is no line [N].[paragraph break]".

To say only the I7 for line number (N - a number) with line number (S - a number) selected:
	let the source line record be the source line record for line number N;
	if the source line record is not an invalid source line record:
		let the indentation be the I7 indentation of the source line record;
		let the I7 be the I7 of the source line record;
		if the I7 is empty:
			say "There is no matching I7 line.[paragraph break]";
		otherwise:
			say "[fixed letter spacing][if N is S]>[otherwise] [end if] [the nonnegative number N as at least six digits] [the indentation tabs][the I7 with tabs rendered as spaces][variable letter spacing][paragraph break]";
	otherwise:
		say "There is no line [N].[paragraph break]".

Section "Numbered Multiple-Line Listing" - unindexed

[These phrases do not change letter spacing.]
[These phrases do not print trailing blank lines.]
[These phrases do not print error messages in place of empty listings.]

To say the Glulx assembly from (B - an instruction vertex) to (E - an instruction vertex) with the sequence point (S - a number) selected:
	initialize the disassembly label hash table;
	let the instruction vertex be B;
	while the instruction vertex is not null and the instruction vertex is not E:
		say "[the Glulx assembly for the instruction vertex with the sequence point S selected]";
		now the instruction vertex is the next link of the instruction vertex;
	tear down the disassembly label hash table.

To say the I6 from line number (B - a number) to (E - a number) with line number (S - a number) selected:
	repeat with the line number running over the half-open interval from B to E:
		say "[the I6 for line number the line number with line number S selected]".

To say the I7 from line number (B - a number) to (E - a number) with line number (S - a number) selected:
	repeat with the line number running over the half-open interval from B to E:
		say "[the I7 for line number the line number with line number S selected]".

Section "Numbered Multiple-Line Listing with Errors" - unindexed

[These phrases do change letter spacing.]
[These phrases do print trailing blank lines.]
[These phrases do print error messages in place of empty listings.]

To say only the I6 from line number (B - a number) to (E - a number) with the sequence point (S - a number) selected:
	let the line count be the I6 line count in the half-open interval from line number B to E;
	if the line count is zero:
		say "There are no matching I6 lines.[paragraph break]";
		stop;
	if the author consents to a listing as lengthy as the line count:
		let the current line number be the I6 line number for the sequence point S;
		say "[fixed letter spacing][the I6 from line number B to E with line number the current line number selected][variable letter spacing][line break]".

To say only the I7 from line number (B - a number) to (E - a number) with the sequence point (S - a number) selected:
	let the line count be the I7 line count in the half-open interval from line number B to E;
	if the line count is zero:
		say "There are no matching I7 lines.[paragraph break]";
		stop;
	if the author consents to a listing as lengthy as the line count:
		let the current line number be the I7 line number for the sequence point S;
		say "[fixed letter spacing][the I7 from line number B to E with line number the current line number selected][variable letter spacing][line break]".

Section "Lising a Sequence Point" - unindexed

[This phrase does not change letter spacing.]
[This phrase does not print trailing blank lines.]
[This phrase does print an error message in place of an empty listing.]

To say the Glulx for the sequence point (S - a number):
	if S is not a sequence point:
		fail at iterating from a given sequence point;
		stop;
	let the routine record be the routine record owning the sequence point S;
	if the routine record is an invalid routine record:
		say "No disassembly is available because the function has no debug information.[line break]";
		stop;
	let the function address be the function address of the routine record;
	parse the function at address the function address;
	let the instruction vertex be the instruction vertex corresponding to source address S;
	if the instruction vertex is an invalid instruction vertex:
		fail at iterating from a given sequence point;
		stop;
	let the terminator be the next sequence point instruction vertex after the instruction vertex or else a null instruction vertex;
	say "[the Glulx assembly from the instruction vertex to the terminator with the sequence point S selected]".

Section "Listing by Window" - unindexed

[These phrases do change letter spacing.]
[These phrases do print trailing blank lines.]
[These phrases do print error messages in place of empty listings.]

To say the nearby Glulx assembly with the sequence point (S - a number) selected:
	let the routine record be the routine record owning the sequence point S;
	if the routine record is an invalid routine record:
		say "No disassembly is available because the function has no debug information.[paragraph break]";
		stop;
	let the function address be the function address of the routine record;
	parse the function at address the function address;
	let the instruction vertex be the instruction vertex corresponding to source address S;
	if the instruction vertex is an invalid instruction vertex:
		fail at iterating from a given sequence point;
		stop;
	let the beginning instruction vertex be the listing window radius instruction vertices before the instruction vertex or else the beginning of the function;
	let the end instruction vertex be the listing window radius instruction vertices after the instruction vertex or else the end of the function;
	say "[fixed letter spacing]";
	unless the beginning instruction vertex is the scratch space beginning vertex:
		say "  ...[line break]";
	say "[the Glulx assembly from the beginning instruction vertex to the end instruction vertex with the sequence point S selected]";
	unless the beginning instruction vertex is the scratch space end vertex:
		say "  ...[line break]";
	say "[variable letter spacing][line break]".

To say the nearby I6 with the sequence point (S - a number) selected:
	let the current line number be the I6 line number for the sequence point S;
	let the source line record be the source line record for line number the current line number;
	if the source line record is an invalid source line record:
		say "No I6 listing is available.[paragraph break]";
		stop;
	let the beginning line number be the listing window radius lines before I6 line number the current line number or else the beginning of the function;
	let the end line number be the listing window radius lines after I6 line number the current line number or else the end of the function;
	say "[fixed letter spacing]";
	let the routine record be the routine record owning the sequence point S;
	unless the routine record is an invalid routine record:
		let the preamble line number be the preamble line number of the routine record;
		unless the preamble line number is zero:
			say "[the I6 for line number the preamble line number with line number the current line number selected]";
		unless the beginning line number is the beginning line number of the routine record:
			say "  ...[line break]";
	say "[the I6 from line number the beginning line number to the end line number with line number the current line number selected]";
	unless the routine record is an invalid routine record or the end line number is the end line number of the routine record:
		say "  ...[line break]";
	say "[variable letter spacing][line break]".

To say the nearby I7 with the sequence point (S - a number) selected:
	let the current line number be the I7 line number for the sequence point S;
	let the source line record be the source line record for line number the current line number;
	if the source line record is an invalid source line record:
		say "No I7 listing is available.[paragraph break]";
		stop;
	say "[fixed letter spacing]";
	let the beginning line number be zero;
	let the end line number be zero;
	let the routine record be the routine record owning the sequence point S;
	unless the routine record is an invalid routine record:
		let the preamble line number be the preamble line number of the routine record;
		unless the preamble line number is zero:
			let the function address be the function address of the routine record;
			guess the routine kernel for the function address;
			let the routine kernel address be the routine kernel address of the function at address the function address;
			unless the routine kernel address is zero:
				say "[the I7 for line number the preamble line number with line number the current line number selected]";
				say "         [one tab](invoke [the human-friendly name for the function at address the routine kernel address])[variable letter spacing][paragraph break]";
				stop;
	now the beginning line number is the listing window radius lines before I7 line number the current line number or else the beginning of the function;
	now the end line number is the listing window radius lines after I7 line number the current line number or else the end of the function;
	unless the routine record is an invalid routine record:
		if there is an I7 line in the half-open interval from line number the beginning line number of the routine record to the beginning line number:
			say "  ...[line break]";
	say "[the I7 from line number the beginning line number to the end line number with line number the current line number selected]";
	unless the routine record is an invalid routine record:
		if there is an I7 line in the half-open interval from line number the end line number to the end line number of the routine record:
			say "  ...[line break]";
	say "[variable letter spacing][line break]".

Section "Lengthy Listings" - unindexed

To decide whether the author consents to a listing as lengthy as (N - a number):
	if the lengthly listing warnings flag is false or N is at most the threshold for lengthy listings:
		decide yes;
	say "This listing is [N] line[unless N is one]s[end if] long.  Are you sure you want to list [if N is one]it[otherwise]all of them[end if] (y, n, or Y)? ";
	let the result be whether or not the author consents;
	now the lengthly listing warnings flag is whether or not (whether or not the consent was permanent) is false;
	say "[line break]";
	decide on the result.

Section "Listing by Function" - unindexed

[These phrases do change letter spacing.]
[These phrases do print trailing blank lines.]
[These phrases do print error messages in place of empty listings.]

To say the Glulx assembly for (R - a routine record) and the sequence point (S - a number):
	if R is an invalid routine record:
		say "No disassembly is available because the function has no debug information.[line break]";
		stop;
	let the function address be the function address of R;
	parse the function at address the function address;
	if the author consents to a listing as lengthy as the Glulx assembly count in the half-open interval from the scratch space beginning vertex to a null instruction vertex:
		say "[fixed letter spacing][the Glulx assembly from the scratch space beginning vertex to a null instruction vertex with the sequence point S selected][variable letter spacing][line break]".

To say the I6 for (R - a routine record) and the sequence point (S - a number):
	if R is an invalid routine record:
		say "No I6 listing is available because the function has no debug information.[paragraph break]";
		stop;
	let the preamble line number be the preamble line number of R;
	let the beginning line number be the beginning line number of R;
	let the end line number be the end line number of R;
	if the beginning line number is zero:
		say "No I6 listing is available.[paragraph break]";
		stop;
	let the line count be the I6 line count in the half-open interval from line number the beginning line number to the end line number;
	if the line count is zero:
		say "No I6 listing is available.[paragraph break]";
		stop;
	if the author consents to a listing as lengthy as the line count:
		let the current line number be the I6 line number for the sequence point S;
		say "[fixed letter spacing]";
		unless the preamble line number is zero:
			say "[the I6 for line number the preamble line number with line number the current line number selected]";
		say "[the I6 from line number the beginning line number to the end line number with line number the current line number selected][variable letter spacing][line break]".

To say the I7 for (R - a routine record) and the sequence point (S - a number):
	if R is an invalid routine record:
		say "No I7 listing available because the function has no debug information.[paragraph break]";
		stop;
	let the function address be the function address of R;
	let the preamble line number be the preamble line number of R;
	guess the routine kernel for the function address;
	let the routine kernel address be the routine kernel address of the function at address the function address;
	unless the routine kernel address is zero:
		let the current line number be the I7 line number for the sequence point S in the routine record R;
		always check that the preamble line number is not zero or else fail at finding a preamble for a routine shell;
		say "[fixed letter spacing][the I7 for line number the preamble line number with line number the current line number selected]";
		say "         [one tab](invoke [the human-friendly name for the function at address the routine kernel address])[variable letter spacing][paragraph break](automatically listing the kernel)[paragraph break]";
		say "[the I7 for the routine record for the routine kernel address and the sequence point S]";
		stop;
	let the beginning line number be the beginning line number of R;
	let the end line number be the end line number of R;
	if the beginning line number is zero:
		say "No I7 listing is available.[paragraph break]";
		stop;
	let the line count be the I7 line count in the half-open interval from line number the beginning line number to the end line number;
	if the author consents to a listing as lengthy as the line count:
		let the current line number be the I7 line number for the sequence point S in the routine record R;
		if the preamble line number is zero:
			if the line count is zero:
				say "There are no matching I7 lines.[paragraph break]";
				stop;
			say "[fixed letter spacing]";
		otherwise:
			say "[fixed letter spacing][the I7 for line number the preamble line number with line number the current line number selected]";
		say "[the I7 from line number the beginning line number to the end line number with line number the current line number selected][variable letter spacing][line break]".

Section "Preferred Debug Mode or Override" - unindexed

To decide what debug mode is the preferred debug mode for the half-open interval from line number (B - a number) to (E - a number) or the override among the children of (V - a parse tree vertex):
	let the language vertex be the first match for a debugging language among the children of V;
	if the language vertex is an invalid parse tree vertex:
		if there is an I7 line in the half-open interval from line number B to E:
			decide on debugging at the I7 level;
		decide on debugging at the I6 level;
	if the Glulx language appears among the children of the language vertex:
		decide on debugging at the Glulx assembly level;
	if the I6 language appears among the children of the language vertex:
		decide on debugging at the I6 level;
	if the I7 language appears among the children of the language vertex:
		decide on debugging at the I7 level;
	fail at understanding a debugging language;
	if there is an I7 line in the half-open interval from line number B to E:
		decide on debugging at the I7 level;
	decide on debugging at the I6 level.

To decide what debug mode is the preferred debug mode for (R - a routine record) or the override among the children of (V - a parse tree vertex):
	let the language vertex be the first match for a debugging language among the children of V;
	if the language vertex is an invalid parse tree vertex:
		decide on the preferred debug mode for R;
	if the Glulx language appears among the children of the language vertex:
		decide on debugging at the Glulx assembly level;
	if the I6 language appears among the children of the language vertex:
		decide on debugging at the I6 level;
	if the I7 language appears among the children of the language vertex:
		decide on debugging at the I7 level;
	fail at understanding a debugging language;
	decide on the preferred debug mode for R.

Section "Listing by Inference" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-inference command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	let the sequence point be the sequence point to highlight;
	if the sequence point is zero:
		say "No listing available.[paragraph break]";
		stop;
	let the routine record be the routine record owning the sequence point the sequence point;
	if the preferred debug mode for the routine record or the override among the children of V is:
		-- debugging at the Glulx assembly level:
			say "[the nearby Glulx assembly with the sequence point the sequence point selected]";
		-- debugging at the I6 level:
			say "[the nearby I6 with the sequence point the sequence point selected]";
		-- debugging at the I7 level:
			say "[the nearby I7 with the sequence point the sequence point selected]".

Section "Listing by Function or Address" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-function command):
	let the sequence point be the sequence point to highlight;
	let the function name vertex be the first match for a function name for the debugger among the children of V;
	let the function address be the address of the function whose name is named by the function name vertex;
	if the function address is zero:
		stop;
	let the routine record be the routine record for the function address;
	if the preferred debug mode for the routine record or the override among the children of V is:
		-- debugging at the Glulx assembly level:
			say "[the Glulx assembly for the routine record and the sequence point the sequence point]";
		-- debugging at the I6 level:
			say "[the I6 for the routine record and the sequence point the sequence point]";
		-- debugging at the I7 level:
			say "[the I7 for the routine record and the sequence point the sequence point]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-address command):
	let the sequence point be the sequence point to highlight;
	let the function address vertex be the first match for a function address for the debugger among the children of V;
	let the function address be the function address named by the function address vertex;
	let the routine record be the routine record for the function address;
	if the preferred debug mode for the routine record or the override among the children of V is:
		-- debugging at the Glulx assembly level:
			say "[the Glulx assembly for the routine record and the sequence point the sequence point]";
		-- debugging at the I6 level:
			say "[the I6 for the routine record and the sequence point the sequence point]";
		-- debugging at the I7 level:
			say "[the I7 for the routine record and the sequence point the sequence point]".

Section "Listing by Line Number" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-line-number command):
	let the sequence point be the sequence point to highlight;
	let the line number vertex be the first match for a line number among the children of V;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of the line number vertex;
	let the line number be the decimal number named by the decimal vertex;
	let the language vertex be the first match for a debugging language among the children of V;
	if the preferred debug mode for the half-open interval from line number the line number to the line number plus one or the override among the children of V is:
		-- debugging at the I6 level:
			let the current line number be the I6 line number for the sequence point the sequence point;
			say "[only the I6 for line number the line number with line number the current line number selected]";
		-- debugging at the I7 level:
			let the current line number be the I7 line number for the sequence point the sequence point;
			say "[only the I7 for line number the line number with line number the current line number selected]";
		-- otherwise:
			say "I can only list a line in I6 or I7.[paragraph break]".		

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-line-numbers command):
	let the sequence point be the sequence point to highlight;
	let the line number vertex be the first match for a line number among the children of V;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of the line number vertex;
	let the beginning line number be the decimal number named by the decimal vertex;
	now the line number vertex is the next match for a line number after the child the line number vertex;
	now the decimal vertex is the first match for a decimal number for the debugger among the children of the line number vertex;
	let the end line number be the decimal number named by the decimal vertex plus one;
	let the language vertex be the first match for a debugging language among the children of V;
	if the preferred debug mode for the half-open interval from line number the beginning line number to the end line number or the override among the children of V is:
		-- debugging at the I6 level:
			say "[only the I6 from line number the beginning line number to the end line number with the sequence point the sequence point selected]";
		-- debugging at the I7 level:
			say "[only the I7 from line number the beginning line number to the end line number with the sequence point the sequence point selected]";
		-- otherwise:
			say "I can only list a range of lines in I6 or I7.[paragraph break]".		

Section "Listing by Instruction Address"

To decide what number is the function address for the instruction address (A - a number):
	if A is unsigned at least the size of read-only memory:
		decide on zero;
	let the candidate be A;
	while the candidate is not zero:
		if the candidate is a sequence point:
			decide on the function address of the routine record owning the sequence point the candidate;
		let the routine record be the routine record for the candidate;
		unless the routine record is an invalid routine record:
			decide on the function address of the routine record;
		decrement the candidate;
	decide on zero.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-instruction-address command):
	let the sequence point be the sequence point to highlight;
	let the hexadecimal vertex be the first match for a hexadecimal number for the debugger among the children of V;
	let the instruction address be the hexadecimal number named by the hexadecimal vertex;
	let the function address be the function address for the instruction address the instruction address;
	if the function address is zero:
		say "There is no such instruction (at least according to the debug information file).[paragraph break]";
		stop;
	parse the function at address the function address;
	let the instruction vertex be the instruction vertex corresponding to source address the instruction address;
	if the instruction vertex is an invalid instruction vertex:
		say "There is no such instruction (at least according to the debug information file).[paragraph break]";
		stop;
	let the next instruction vertex be one instruction vertex after the instruction vertex or else the end of the function;
	say "[fixed letter spacing][the Glulx assembly from the instruction vertex to the next instruction vertex with the sequence point the sequence point selected][variable letter spacing][line break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-by-instruction-addresses command):
	let the sequence point be the sequence point to highlight;
	let the beginning hexadecimal vertex be the first match for a hexadecimal number for the debugger among the children of V;
	let the beginning instruction address be the hexadecimal number named by the beginning hexadecimal vertex;
	let the function address be the function address for the instruction address the beginning instruction address;
	if the function address is zero:
		say "There is no instruction at address [the beginning instruction address in hexadecimal] (at least according to the debug information file).[paragraph break]";
		stop;
	let the end hexadecimal vertex be the next match for a hexadecimal number for the debugger after the child the beginning hexadecimal vertex;
	let the end instruction address be the hexadecimal number named by the end hexadecimal vertex;
	let the corroborating function address be the function address for the instruction address the end instruction address;
	if the corroborating function address is zero:
		say "There is no instruction at address [the end instruction address in hexadecimal] (at least according to the debug information file).[paragraph break]";
		stop;
	if the function address is not the corroborating function address:
		say "At present, I can only list instruction address ranges that do not cross function boundaries.[paragraph break]";
		stop;
	parse the function at address the function address;
	let the beginning instruction vertex be the instruction vertex corresponding to source address the beginning instruction address;
	if the beginning instruction vertex is an invalid instruction vertex:
		say "There is no instruction at address [the beginning instruction address in hexadecimal] (at least according to the debug information file).[paragraph break]";
		stop;
	let the end instruction vertex be the instruction vertex corresponding to source address the end instruction address;
	if the end instruction vertex is an invalid instruction vertex:
		say "There is no instruction at address [the end instruction address in hexadecimal] (at least according to the debug information file).[paragraph break]";
		stop;
	let the next instruction vertex be one instruction vertex after the end instruction vertex or else the end of the function;
	say "[fixed letter spacing][the Glulx assembly from the beginning instruction vertex to the next instruction vertex with the sequence point the sequence point selected][variable letter spacing][line break]".

Section "Listing Instrumentation" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's list-instrumentation command):
	let the uninstrumented function address be the uninstrumented function address of the debugger's current call frame;
	let the function address be the address of the instrumented version of the function at address the uninstrumented function address;
	parse the function at address the function address;
	if the author consents to a listing as lengthy as the Glulx assembly count in the half-open interval from the scratch space beginning vertex to a null instruction vertex:
		say "[fixed letter spacing][the glulx assembly from the scratch space beginning vertex to a null instruction vertex with the sequence point zero selected][variable letter spacing][line break]".

Section "Location Synopses" - unindexed

To say the location synopsis for the sequence point (S - a number) in the call frame (F - a call frame):
	let the current line number be the I6 line number for the sequence point S;
	if the current line number is zero:
		say "on an unnumbered line.";
	otherwise:
		let the routine record be the routine record owning the sequence point S;
		always check that the routine record is not invalid routine record or else fail at finding a routine record for a sequence point with a source line record;
		let the function address be the function address of the routine record;
		ensure that all routines have names;
		say "within [the human-friendly name for the function at address the function address]";
		if the uninstrumented function address of F is not the function address:
			say " on behalf of [the human-friendly name for the function at address the uninstrumented function address of F]";
		say ":[line break][fixed letter spacing]";
		if the currently preferred debug mode is debugging at the I7 level and the source version of the routine record is seven:
			let the current I7 line number be the I7 line number for the sequence point S in the routine record the routine record;
			say "[the I7 for line number the current I7 line number with line number the current I7 line number selected]";
		otherwise if the currently preferred debug mode is not debugging at the Glulx assembly level:
			say "[the I6 for line number the current line number with line number the current line number selected]";
		otherwise:
			say "[the Glulx for the sequence point S]";
		say "[variable letter spacing]".

To say the debug location synopsis:
	say "Execution paused [the location synopsis for the sequence point the last-seen sequence point before the last-seen breakpoint in the call frame the leaf of the debugger's current call frame]";
	let the sequence point be the sequence point to highlight;
	if the last-seen sequence point before the last-seen breakpoint is not the sequence point:
		say "[line break]Selecting the nearest location in the simplified call stack, which is [the location synopsis for the sequence point the sequence point in the call frame the debugger's current call frame][line break]";
		say "(Use the command 'prefer no simplification' to always select the point where execution is paused.)[line break]";
	say "[line break]".

Chapter "Breakpoint Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's breakpoint information command):
	let the informed flag be false;
	repeat with the breakpoint index running over the half-open interval from zero to the breakpoint counter:
		let the compound breakpoint be the first compound breakpoint value matching the key the breakpoint index in the user breakpoint hash table or an invalid compound breakpoint if there are no matches;
		unless the compound breakpoint is an invalid compound breakpoint:
			say "Breakpoint [the numeric identifier of the compound breakpoint] ([if the compound breakpoint is enabled]enabled[otherwise]disabled[end if]): [the human-friendly name of the compound breakpoint][line break]";
			now the informed flag is true;
	if the informed flag is false:
		say "There are no breakpoints.[line break]";
	say "[line break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's breaktext information command):
	let the informed flag be false;
	repeat with the breakpoint index running over the half-open interval from zero to the breakpoint counter:
		let the breaktext be the first breaktext value matching the key the breakpoint index in the user breaktext hash table or an invalid breaktext if there are no matches;
		unless the breaktext is an invalid breaktext:
			say "Breaktext [the numeric identifier of the breaktext] ([if the breaktext is enabled]enabled[otherwise]disabled[end if]): [the human-friendly name of the breaktext][line break]";
			now the informed flag is true;
	if the informed flag is false:
		say "There are no breaktexts.[line break]";
	say "[line break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's information command):
	let the informed flag be false;
	repeat with the breakpoint index running over the half-open interval from zero to the breakpoint counter:
		let the compound breakpoint be the first compound breakpoint value matching the key the breakpoint index in the user breakpoint hash table or an invalid compound breakpoint if there are no matches;
		unless the compound breakpoint is an invalid compound breakpoint:
			say "Breakpoint [the numeric identifier of the compound breakpoint] ([if the compound breakpoint is enabled]enabled[otherwise]disabled[end if]): [the human-friendly name of the compound breakpoint][line break]";
			now the informed flag is true;
		let the breaktext be the first breaktext value matching the key the breakpoint index in the user breaktext hash table or an invalid breaktext if there are no matches;
		unless the breaktext is an invalid breaktext:
			say "Breaktext [the numeric identifier of the breaktext] ([if the breaktext is enabled]enabled[otherwise]disabled[end if]): [the human-friendly name of the breaktext][line break]";
			now the informed flag is true;
	if the informed flag is false:
		say "There are no breakpoints or breaktexts.[line break]";
	say "[line break]".

The function address for naming compound breakpoints is a number that varies.
The line number for naming compound breakpoints is a number that varies.
The instruction address for naming compound breakpoints is a number that varies.

To enable and hash and announce (C - a compound breakpoint):
	enable C;
	insert the key the numeric identifier of C and the value C into the user breakpoint hash table;
	say "Breakpoint [the numeric identifier of C] (enabled): [the human-friendly name of C][paragraph break]".

To decide what compound breakpoint is a breakpoint placed on the sequence point (S - a number) with the human-friendly name (T - some text):
	let the compound breakpoint be a new compound breakpoint with human-friendly name T;
	attach the sequence point S to the compound breakpoint;
	enable and hash and announce the compound breakpoint;
	decide on the compound breakpoint.

To decide what compound breakpoint is a breakpoint placed on I6 line number (N - a number) with the human-friendly name (T - some text):
	let the compound breakpoint be a new compound breakpoint with human-friendly name T;
	let the source line record be the source line record for line number N;
	let the sequence point linked list be the sequence point linked list of the source line record;
	repeat with the sequence point running through the sequence point keys of the sequence point linked list:
		attach the sequence point the sequence point to the compound breakpoint;
	enable and hash and announce the compound breakpoint;
	decide on the compound breakpoint.

To decide what compound breakpoint is a breakpoint placed on I7 line number (N - a number) in (R - a routine record) with the human-friendly name (T - some text):
	let the compound breakpoint be a new compound breakpoint with human-friendly name T;
	let the end line number be the end line number of R;
	repeat with the subsequent line number running over the half-open interval from N plus one to the end line number:
		let the source line record be the source line record for line number the subsequent line number;
		unless the source line record is an invalid source line record:
			if the I7 coda flag is set in the source line record:
				break;
			let the I7 be the I7 of the source line record;
			unless the I7 is empty:
				break;
			let the sequence point linked list be the sequence point linked list of the source line record;
			repeat with the sequence point running through the sequence point keys of the sequence point linked list:
				attach the sequence point the sequence point to the compound breakpoint;
	enable and hash and announce the compound breakpoint;
	decide on the compound breakpoint.

To decide whether we warn that shielding or substitutions interfere with breakpoints in the function at address (A - a number):
	let the instrumented address be the first number value matching the key A in the instrumented chunks hash table or zero if there are no matches;
	if the instrumented address is A:
		say "Warning: [the human-friendly name for the function at address A] has GRIF shielding, so, under normal circumstances, breakpoints placed inside will never trigger.  Place one anyway? ";
		decide yes;
	let the substituted address be the address of the function substituted for the function at address A;
	if the substituted address is not A:
		let the substitution name be the human-friendly name for the function at address the substituted address;
		if the substitution name is "an unnamed rule or phrase":
			say "Warning: [the human-friendly name for the function at address A] has an unnamed GRIF substitution, so, under normal circumstances, breakpoints placed inside will never trigger.  Place one anyway? ";
		otherwise:
			say "Warning: [the human-friendly name for the function at address A] has a GRIF substitution, [the substitution name], so, under normal circumstances, breakpoints placed inside will never trigger.  Place one anyway? ";
		decide yes;
	guess the routine shell for A;
	let the routine shell address be the routine shell address of the function at address the function address of A;
	unless the routine shell address is zero:
		decide on whether or not we warn that shielding or substitutions interfere with breakpoints in the function at address the routine shell address;
	decide no.

The rule-announcing infix is some text that varies.
A GRIF setup rule (this is the allocate permanent synthetic text for the rule-announcing infix rule):
	now the rule-announcing infix is a new permanent synthetic text copied from "DB_Rule".

To decide what number is the I6 line number after the applicability test in (R - a routine record):
	if the source version of R is less than seven or the name for the rule at address the function address of R is empty:
		decide on zero;
	let the function address be the function address of R;
	guess the routine kernel for the function address;
	let the routine kernel address be the routine kernel address of the function at address the function address of R;
	let the routine record be R;
	unless the routine kernel address is zero:
		now the routine record is the routine record for the routine kernel address;
	let the linked list vertex be the sequence point linked list of the routine record converted to a linked list vertex;
	if the linked list vertex is null:
		decide on zero;
	let the sequence point be the sequence point key of the linked list vertex;
	let the matched line number be the I7 line number for the sequence point the sequence point in the routine record the routine record;
	if the matched line number is zero:
		decide on zero;
	unless the matched line number is the preamble line number of the routine record: [which is to say that there is an applicability test]
		decide on zero;
	let the beginning line number be the beginning line number of the routine record;
	let the end line number be the end line number of the routine record;
	repeat with the line number running over the half-open interval from the beginning line number to the end line number:
		let the source line record be the source line record for line number the line number;
		unless the index of the synthetic text the rule-announcing infix in the synthetic text the I6 of the source line record is zero:
			decide on the line number;
	decide on zero.

To break the function at address (A - a number):
	let the routine record be the routine record for A;
	if the routine record is an invalid routine record:
		say "There is no debug information for that function, [the human-friendly name for the function at address A].[paragraph break]";
		stop;
	let the sequence point linked list be the sequence point linked list of the routine record;
	if the sequence point linked list is empty:
		say "There are no sequence points in [the human-friendly name for the function at address A].[paragraph break]";
		stop;
	if we warn that shielding or substitutions interfere with breakpoints in the function at address the function address of the routine record:
		unless the author consents:
			say "[line break]";
			stop;
	let the first I6 line number be the I6 line number after the applicability test in the routine record;
	unless the first I6 line number is zero:
		say "Would you like to place the breakpoint after the rule's applicability check, so that it only pauses the story when the rule applies (y or n)? ";
		if the author consents:
			say "[line break]";
			now the function address for naming compound breakpoints is A;
			let the discarded value be a breakpoint placed on I6 line number the first I6 line number with the human-friendly name "Pause when [the human-friendly name for the function at address the function address for naming compound breakpoints] applies";
			stop;
		say "[line break]";
	guess the routine kernel for A;
	let the routine kernel address be the routine kernel address of the function at address A;
	let the function address be A;
	unless the routine kernel address is zero:
		say "Would you like to place the breakpoint on the routine kernel, so that you can skip over the block value management code (y or n)? ";
		if the author consents:
			now the function address is the routine kernel address;
			now the routine record is the routine record for the routine kernel address;
			always check that the routine record is not an invalid routine record or else fail at finding a routine record for a kernel;
			now the sequence point linked list is the sequence point linked list of the routine record;
			if the sequence point linked list is empty:
				say "[line break]There are no sequence points in [the human-friendly name for the function at address the function address].[paragraph break]";
				stop;
		say "[line break]";
	let the sequence point be the sequence point key of the sequence point linked list converted to a linked list vertex;
	now the function address for naming compound breakpoints is the function address;
	let the discarded value be a breakpoint placed on the sequence point the sequence point with the human-friendly name "Pause when entering [the human-friendly name for the function at address the function address for naming compound breakpoints]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's break-by-function command):
	let the function name vertex be the first match for a function name for the debugger among the children of V;
	let the function address be the address of the function whose name is named by the function name vertex;
	if the function address is zero:
		stop;
	break the function at address the function address.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's break-by-address command):
	let the function address vertex be the first match for a function address for the debugger among the children of V;
	let the function address be the function address named by the function address vertex;
	break the function at address the function address.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's break-by-line-number command):
	let the line number vertex be the first match for a line number among the children of V;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of the line number vertex;
	let the line number be the decimal number named by the decimal vertex;
	let the source line record be the source line record for line number the line number;
	if the source line record is an invalid source line record:
		say "There is no such line.[paragraph break]";
		stop;
	let the I7 be the I7 of the source line record;
	unless the I7 is empty:
		let the routine record be the sole routine record of the source line record;
		always check that the routine record is not an invalid routine record or else fail at finding I7 in a line shared by several routines;
		let the end line number be the end line number of the routine record;
		let the empty flag be true;
		repeat with the subsequent line number running over the half-open interval from the line number plus one to the end line number:
			now the source line record is the source line record for line number the subsequent line number;
			unless the source line record is an invalid source line record:
				if the I7 coda flag is set in the source line record:
					break;
				let the I7 be the I7 of the source line record;
				unless the I7 is empty:
					break;
				let the sequence point linked list be the sequence point linked list of the source line record;
				unless the sequence point linked list is empty:
					now the empty flag is false;
					break;
		if the empty flag is true:
			say "There are no sequence points on that line.[paragraph break]";
			stop;
		if we warn that shielding or substitutions interfere with breakpoints in the function at address the function address of the routine record:
			unless the author consents:
				say "[line break]";
				stop;
		now the line number for naming compound breakpoints is the line number;
		let the discarded value be a breakpoint placed on I7 line number the line number in the routine record with the human-friendly name "Pause on I7 line [the nonnegative number the line number for naming compound breakpoints as at least six digits]";
		stop;
	let the sequence point linked list be the sequence point linked list of the source line record;
	if the sequence point linked list is empty:
		say "There are no sequence points on that line.[paragraph break]";
		stop;
	now the line number for naming compound breakpoints is the line number;
	let the discarded value be a breakpoint placed on I6 line number the line number with the human-friendly name "Pause on I6 line [the nonnegative number the line number for naming compound breakpoints as at least six digits]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's break-by-inference command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "(Assuming that you meant to force a breakpoint.)[line break]";
		force a breakpoint from the debugger after checking the coexecution state;
		stop;
	let the sequence point be the sequence point to highlight;
	let the routine record be the routine record owning the sequence point the sequence point;
	let the new compound breakpoint be an invalid compound breakpoint;
	if the preferred debug mode for the routine record is:
		-- debugging at the Glulx assembly level:
			now the instruction address for naming compound breakpoints is the sequence point;
			now the new compound breakpoint is a breakpoint placed on the sequence point the sequence point with the human-friendly name "Pause at address [the instruction address for naming compound breakpoints]";
		-- debugging at the I6 level:
			now the line number for naming compound breakpoints is the I6 line number for the sequence point the sequence point;
			now the new compound breakpoint is a breakpoint placed on I6 line number the line number for naming compound breakpoints with the human-friendly name "Pause on I6 line [the nonnegative number the line number for naming compound breakpoints as at least six digits]";
		-- debugging at the I7 level:
			now the line number for naming compound breakpoints is the I7 line number for the sequence point the sequence point in the routine record the routine record;
			now the new compound breakpoint is a breakpoint placed on I7 line number the line number for naming compound breakpoints in the routine record with the human-friendly name "Pause on I7 line [the nonnegative number the line number for naming compound breakpoints as at least six digits]";
	unless the new compound breakpoint is an invalid compound breakpoint:
		push the key the new compound breakpoint onto the last-seen compound breakpoint list.

The simple text substitution for a line break is some text that varies.
The simple text substitution for a single quote is some text that varies.
The simple text substitution for a left square bracket is some text that varies.
The simple text substitution for a right square bracket is some text that varies.
A GRIF setup rule (this is the allocate permanent synthetic text for recognizing simple text substitutions rule):
	now the simple text substitution for a line break is a new permanent synthetic text copied from "[bracket]line break[close bracket]";
	now the simple text substitution for a single quote is a new permanent synthetic text copied from "[bracket]['][close bracket]";
	now the simple text substitution for a left square bracket is a new permanent synthetic text copied from "[bracket]bracket[close bracket]";
	now the simple text substitution for a right square bracket is a new permanent synthetic text copied from "[bracket]close bracket[close bracket]".

The text for naming a breaktext is some text that varies.

To enable and hash and announce (B - a breaktext):
	enable B;
	insert the key the numeric identifier of B and the value B into the user breaktext hash table;
	say "Breaktext [the numeric identifier of B] (enabled): [the human-friendly name of B][paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's break-by-output command):
	enable and hash and announce a new breaktext for the zero codepoints at address the address for a zero-length allocation named "break when any text is printed".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's break-by-text command):
	let the text be a new synthetic text extracted from the synthetic text the raw debug command between the synthetic prefix the debug command string delimiter and the synthetic suffix the debug command string delimiter or the interned empty string if there is no match;
	if the text is empty:
		fail at finding the text for a breaktext;
		stop;
	let the remaining length be the length of the synthetic text the text;
	let the source be the character array address of the synthetic text the text;
	let the codepoint array address be a possibly zero-length memory allocation of the remaining length times four bytes;
	let the target be the codepoint array address;
	while the remaining length is greater than zero:
		let the character code be the byte at address the source;
		if the character code is:
			-- 39: [single quote]
				write the integer 34 [double quote] to address the target;
				increment the source;
				decrement the remaining length;
			-- 91: [left square bracket]
				let the substring be a new synthetic text extracted from the remaining length bytes at address the source;
				if the synthetic text the substring begins with the synthetic text the simple text substitution for a line break:
					write the integer 10 [newline] to address the target;
					increase the source by the length of the synthetic text the simple text substitution for a line break;
					decrease the remaining length by the length of the synthetic text the simple text substitution for a line break;
				otherwise if the synthetic text the substring begins with the synthetic text the simple text substitution for a single quote:
					write the integer 39 [single quote] to address the target;
					increase the source by the length of the synthetic text the simple text substitution for a single quote;
					decrease the remaining length by the length of the synthetic text the simple text substitution for a single quote;
				otherwise if the synthetic text the substring begins with the synthetic text the simple text substitution for a left square bracket:
					write the integer 91 [left square bracket] to address the target;
					increase the source by the length of the synthetic text the simple text substitution for a left square bracket;
					decrease the remaining length by the length of the synthetic text the simple text substitution for a left square bracket;
				otherwise if the synthetic text the substring begins with the synthetic text the simple text substitution for a right square bracket:
					write the integer 93 [right square bracket] to address the target;
					increase the source by the length of the synthetic text the simple text substitution for a right square bracket;
					decrease the remaining length by the length of the synthetic text the simple text substitution for a right square bracket;
				otherwise:
					say "Unrecognized or malformed text substitution: ...[the substring][paragraph break](Recognized substitutions are [the simple text substitution for a line break], [the simple text substitution for a single quote], [the simple text substitution for a left square bracket], and [the simple text substitution for a right square bracket], where spacing is important.)[paragraph break]";
					delete the synthetic text the substring;
					delete the synthetic text the text;
					stop;
				delete the synthetic text the substring;
			-- otherwise:
				write the integer the character code to address the target;
				increment the source;
				decrement the remaining length;
		increase the target by four;
	delete the synthetic text the text;
	let the length be the target minus the codepoint array address;
	now the length is the length divided by four;
	if the length is greater than the length of the longest breaktext:
		let the old capacity be the capacity corresponding to the longest breaktext;
		now the length of the longest breaktext is the length;
		let the new capacity be the capacity corresponding to the longest breaktext;
		repeat with the linked list vertex running through the stream log hash table:
			let the stream log be the stream log value of the linked list vertex;
			let the expansion be a new expansion of the stream log to have a capacity of at least the new capacity bytes;
			delete the stream log;
			write the value the expansion to the linked list vertex;
		if four times the length of the longest breaktext is greater than the old capacity:
			say "Warning: Because this breaktext is longer than the amount of output history I've been keeping, I might not detect occurrences that have already been mostly printed.  The same caveat will apply if you add other long breaktexts before the output history fills the now expanded buffer.[paragraph break]";
	now the text for naming a breaktext is the text;
	enable and hash and announce a new breaktext for the length codepoints at address the codepoint array address named "break when '[the text for naming a breaktext]' is printed".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's delete all command):
	say "Really delete all breakpoints and breaktexts (y or n)? ";
	unless the author consents:
		say "[line break]";
		stop;
	say "[line break]";
	repeat with the compound breakpoint running through the compound breakpoint values of the user breakpoint hash table:
		delete the compound breakpoint;
	clear the user breakpoint hash table;
	repeat with the breaktext running through the breaktext values of the user breaktext hash table:
		delete the breaktext;
	clear the user breaktext hash table;
	say "All breakpoints and breaktexts deleted.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's disable all command):
	repeat with the compound breakpoint running through the compound breakpoint values of the user breakpoint hash table:
		disable the compound breakpoint;
	repeat with the breaktext running through the breaktext values of the user breaktext hash table:
		disable the breaktext;
	say "All breakpoints and breaktexts disabled.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's enable all command):
	repeat with the compound breakpoint running through the compound breakpoint values of the user breakpoint hash table:
		enable the compound breakpoint;
	repeat with the breaktext running through the breaktext values of the user breaktext hash table:
		enable the breaktext;
	say "All breakpoints and breaktexts enabled.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's delete command):
	let the breakpoint number vertex be the first match for a breakpoint number among the children of V;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of the breakpoint number vertex;
	let the breakpoint index be the decimal number named by the decimal vertex;
	let the compound breakpoint be the first compound breakpoint value matching the key the breakpoint index in the user breakpoint hash table or an invalid compound breakpoint if there are no matches;
	unless the compound breakpoint is an invalid compound breakpoint:
		delete the compound breakpoint;
		remove the first occurrence of the key the breakpoint index from the user breakpoint hash table;
		say "Breakpoint deleted.[paragraph break]";
		stop;
	let the breaktext be the first breaktext value matching the key the breakpoint index in the user breaktext hash table or an invalid breaktext if there are no matches;
	unless the breaktext is an invalid breaktext:
		delete the breaktext;
		remove the first occurrence of the key the breakpoint index from the user breaktext hash table;
		say "Breaktext deleted.[paragraph break]";
		stop;
	say "No such breakpoint or breaktext exists.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's disable command):
	let the breakpoint number vertex be the first match for a breakpoint number among the children of V;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of the breakpoint number vertex;
	let the breakpoint index be the decimal number named by the decimal vertex;
	let the compound breakpoint be the first compound breakpoint value matching the key the breakpoint index in the user breakpoint hash table or an invalid compound breakpoint if there are no matches;
	unless the compound breakpoint is an invalid compound breakpoint:
		disable the compound breakpoint;
		say "Breakpoint disabled.[paragraph break]";
		stop;
	let the breaktext be the first breaktext value matching the key the breakpoint index in the user breaktext hash table or an invalid breaktext if there are no matches;
	unless the breaktext is an invalid breaktext:
		disable the breaktext;
		say "Breaktext disabled.[paragraph break]";
		stop;
	say "No such breakpoint or breaktext exists.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's enable command):
	let the breakpoint number vertex be the first match for a breakpoint number among the children of V;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of the breakpoint number vertex;
	let the breakpoint index be the decimal number named by the decimal vertex;
	let the compound breakpoint be the first compound breakpoint value matching the key the breakpoint index in the user breakpoint hash table or an invalid compound breakpoint if there are no matches;
	unless the compound breakpoint is an invalid compound breakpoint:
		enable the compound breakpoint;
		say "Breakpoint enabled.[paragraph break]";
		stop;
	let the breaktext be the first breaktext value matching the key the breakpoint index in the user breaktext hash table or an invalid breaktext if there are no matches;
	unless the breaktext is an invalid breaktext:
		enable the breaktext;
		say "Breaktext enabled.[paragraph break]";
		stop;
	say "No such breakpoint or breaktext exists.[paragraph break]".

Chapter "Control Flow Commands" - unindexed

To enable frame-local breakpoints in (F - a call frame) and outward, considering only visible frames:
	let the current call frame be F;
	while the current call frame is not null:
		unless considering only visible frames and the call stack simplification flag is true and the current call frame is elided in the simplified call stack:
			enable the frame-local breakpoint in the current call frame;
		now the current call frame is the outward link of the current call frame.

To disable frame-local breakpoints in (F - a call frame) and outward, considering only elided frames:
	if considering only elided frames and the call stack simplification flag is false:
		stop;
	let the current call frame be F;
	while the current call frame is not null:
		unless considering only elided frames and the current call frame is not elided in the simplified call stack:
			disable the frame-local breakpoint in the current call frame;
		now the current call frame is the outward link of the current call frame.

To disable all frame-local breakpoints:
	let the current call frame be the leaf of the debugger's current call frame;
	while the current call frame is not null:
		disable the frame-local breakpoint in the current call frame;
		now the current call frame is the outward link of the current call frame.

To enable frame-local tripwires in (F - a call frame):
	write true to extra field follow-on call tripwire flag index of F.

To disable frame-local tripwires in (F - a call frame):
	write false to extra field follow-on call tripwire flag index of F.

To enable frame-local tripwires in (F - a call frame) and outward:
	let the current call frame be F;
	while the current call frame is not null:
		enable frame-local tripwires in the current call frame;
		now the current call frame is the outward link of the current call frame.

To disable all frame-local tripwires:
	let the current call frame be the leaf of the debugger's current call frame;
	while the current call frame is not null:
		disable frame-local tripwires in the current call frame;
		now the current call frame is the outward link of the current call frame.

To handle a debug command for continuing execution:
	if the debugger's control flow state is:
		-- responding after a sequence point step:
			if the call stack simplification flag is true:
				enable the universal breakpoint in flag one;
			otherwise:
				enable the universal breakpoint;
		-- responding after a step:
			if the call stack simplification flag is true:
				enable the universal breakpoint in flag one;
			otherwise:
				enable the universal breakpoint;
		-- responding after a sequence point next:
			enable frame-local breakpoints in the debugger's current call frame and outward, considering only visible frames;
		-- responding after a next:
			enable frame-local breakpoints in the debugger's current call frame and outward, considering only visible frames;
		-- responding after a finish:
			unless the debugger's current call frame is null:
				enable frame-local breakpoints in the outward link of the debugger's current call frame and outward, considering only visible frames;
				enable frame-local tripwires in the outward link of the debugger's current call frame and outward;
	now the debugger's story-continuing flag is true;
	unless the multiple windows supported flag is set in the debugger wrapping layer and the no more than one line input request at a time option is not active:
		now the debugger prompting flag is false.

To force a breakpoint from the debugger:
	now the debugger's control flow state is responding after a sequence point step;
	now the currently preferred debug mode is debugging at the I7 level;
	handle a debug command for continuing execution;
	now the debugger prompting flag is false.	

To force a breakpoint from the debugger after checking the coexecution state:
	if the current debugger coexecution state is:
		-- story interrupted:
			say "The story's execution is already interrupted.[paragraph break]";
		-- story waiting for input:
			say "The story is waiting for input.  Consequently, a forced breakpoint won't apply until the next Glk event arrives, and the story reaches the next sequence point.  (You may have meant to execute the out-of-world action 'forcing a breakpoint' in the story, rather than the debug command of the same name in the debugger.)  Force a breakpoint anyway (y or n)? ";
			if the author consents:
				force a breakpoint from the debugger;
				say "[line break]The debug prompt will return as soon as the story arrives at the next sequence point.[paragraph break]";
			otherwise:
				say "[line break]";
		-- story unpaused:
			force a breakpoint from the debugger;
		-- otherwise:
			fail at forcing a breakpoint from the debugger in an unknown coexecution state;
			force a breakpoint from the debugger.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's force a breakpoint command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	force a breakpoint from the debugger after checking the coexecution state.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's restart command):
	if the debugger's story-has-run flag is false:
		say "The story hasn't been run yet.[paragraph break]";
		stop;
	if the debugger's story-running flag is true:
		say "Really restart the story (y or n)? ";
		unless the author consents:
			say "[line break]";
			stop;
	restart the story from the debugger.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's run command):
	if the debugger's story-running flag is true:
		say "The story is currently running.  Restart it (y or n)? ";
		unless the author consents:
			say "[line break]";
			stop;
	if the debugger's story-running flag is true or the debugger's story-has-run flag is true:
		restart the story from the debugger;
	always check that the current debugger coexecution state is story interrupted or else fail at being the first to run the story;
	now the debugger's control flow state is responding after a continue;
	now the currently preferred debug mode is debugging at the I7 level;
	now the debugger's story-has-run flag is true;
	handle a debug command for continuing execution.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's continue command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is already running.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	now the debugger's control flow state is responding after a continue;
	now the currently preferred debug mode is debugging at the I7 level;
	handle a debug command for continuing execution.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's step sequence point command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is already running.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	now the debugger's control flow state is responding after a sequence point step;
	now the currently preferred debug mode is debugging at the Glulx assembly level;
	handle a debug command for continuing execution.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's next sequence point command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is already running.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	now the debugger's control flow state is responding after a sequence point next;
	now the currently preferred debug mode is debugging at the Glulx assembly level;
	handle a debug command for continuing execution.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's step command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is already running.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	now the debugger's control flow state is responding after a step;
	now the currently preferred debug mode is debugging at the I7 level;
	handle a debug command for continuing execution.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's next command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is already running.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	now the debugger's control flow state is responding after a next;
	let the language vertex be the first match for a debugging language among the children of V;
	if the language vertex is an invalid parse tree vertex:
		let the sequence point be the sequence point to highlight;
		let the routine record be the routine record owning the sequence point the sequence point;
		now the currently preferred debug mode is the preferred debug mode for the routine record;
	otherwise if the Glulx language appears among the children of the language vertex:
		now the currently preferred debug mode is debugging at the Glulx assembly level;
	otherwise if the I6 language appears among the children of the language vertex:
		now the currently preferred debug mode is debugging at the I6 level;
	otherwise if the I7 language appears among the children of the language vertex:
		now the currently preferred debug mode is debugging at the I7 level;
	handle a debug command for continuing execution.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's finish command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	if the current debugger coexecution state is not story interrupted:
		say "The story is already running.  To pause the story, [if the current debugger coexecution state is story waiting for input]give the command 'force a breakpoint' in the story window[otherwise]use the debug command 'force a breakpoint'[end if].[paragraph break]";
		stop;
	now the debugger's control flow state is responding after a finish;
	now the currently preferred debug mode is debugging at the I7 level;
	handle a debug command for continuing execution.

Chapter "Variable Inspection Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's examine command):
	let the global name vertex be the first match for a global name for the debugger among the children of V;
	unless the global name vertex is an invalid parse tree vertex:
		let the global record be the global record named by the global name vertex;
		if the global record is an invalid global record:
			stop;
		let the address be the address of the global record;
		if the address is zero:
			say "I am not able to find the storage for that non-temporary named value.[paragraph break]";
		otherwise if the address is a valid integer address:
			parse the kind name the kind name of the global record for the integer at address address with disambiguation by disambiguating a debug command;
			if the most recently parsed kind name was understood:
				say "[the human-friendly name of the global record] = [the most recently parsed kind name]: [the integer at address address according to the most recently parsed kind name][paragraph break]";
		otherwise:
			say "The storage for that non-temporary named value is outside of memory.[paragraph break]";
		stop;
	let the memory stack variable name vertex be the first match for a memory stack variable name for the debugger among the children of V;
	unless the memory stack variable name vertex is an invalid parse tree vertex:
		let the memory stack variable record be the memory stack variable record named by the memory stack variable name vertex;
		if the memory stack variable record is an invalid memory stack variable record:
			stop;
		let the address be the current address of the memory stack variable record;
		if the address is zero:
			say "That variable doesn't exist right now.[paragraph break]";
		otherwise if the address is a valid integer address:
			parse the kind name the kind name of the memory stack variable record for the integer at address address with disambiguation by disambiguating a debug command;
			if the most recently parsed kind name was understood:
				say "[the human-friendly name of the memory stack variable record] = [the most recently parsed kind name]: [the integer at address address according to the most recently parsed kind name][paragraph break]";
		otherwise:
			say "The storage for that variable is outside of memory.[paragraph break]";
		stop;
	let the local name vertex be the first match for a local name for the debugger among the children of V;
	unless the local name vertex is an invalid parse tree vertex:
		let the local index be the local index named by the local name vertex;
		if the local index is less than zero:
			stop;
		let the function address be the uninstrumented function address of the debugger's current call frame;
		let the actual function address be the address of the function substituted for the function at address function address;
		let the routine record be the routine record for the actual function address;
		let the kind name be some text;
		if the routine record is an invalid routine record:
			now the kind name is "<unknown kind>";
		otherwise:
			now the kind name is I7 local kind name number local index of the routine record;
		parse the kind name the kind name for temporary named value local index of the debugger's current call frame with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[temporary name local index of the debugger's current call frame] = [the most recently parsed kind name]: [temporary named value local index of the debugger's current call frame according to the most recently parsed kind name][paragraph break]";
		stop;
	let the function name vertex be the first match for a function name for the debugger among the children of V;
	unless the function name vertex is an invalid parse tree vertex:
		let the function address be the address of the function whose name is named by the function name vertex;
		if the function address is zero:
			stop;
		let the input name be a new synthetic text representing the words matched by the function name vertex;
		let the kind name be "routine";
		parse the kind name the kind name for the function address with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the input name] = [the most recently parsed kind name]: [the function address according to the most recently parsed kind name][paragraph break]";
		stop;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of V;
	unless the decimal vertex is an invalid parse tree vertex:
		let the value be the decimal number named by the decimal vertex;
		let the kind name be "number";
		parse the kind name the kind name for the value with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the value] = [the most recently parsed kind name]: [the value according to the most recently parsed kind name][paragraph break]";
		stop;
	let the hexadecimal vertex be the first match for a hexadecimal number for the debugger among the children of V;
	unless the hexadecimal vertex is an invalid parse tree vertex:
		let the value be the hexadecimal number named by the hexadecimal vertex;
		let the kind name be "number";
		parse the kind name the kind name for the value with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the value in hexadecimal] = [the most recently parsed kind name]: [the value according to the most recently parsed kind name][paragraph break]";
		stop;
	let the object vertex be the first match for a object name for the debugger among the children of V;
	unless the object vertex is an invalid parse tree vertex:
		let the value be the object value named by the object vertex;
		if the value is -1:
			stop;
		let the input name be a new synthetic text representing the words matched by the object vertex;
		let the kind name be "object";
		parse the kind name the kind name for the value with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the input name] = [the most recently parsed kind name]: [the value according to the most recently parsed kind name][paragraph break]";
		delete the synthetic text the input name;
		stop.

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's examine-as command):
	let the kind name vertex be the first match for a kind name for the debugger among the children of V;
	let the kind name be a new synthetic text representing the words matched by the kind name vertex;
	let the global name vertex be the first match for a global name for the debugger among the children of V;
	unless the global name vertex is an invalid parse tree vertex:
		let the global record be the global record named by the global name vertex;
		if the global record is an invalid global record:
			delete the synthetic text the kind name;
			stop;
		let the address be the address of the global record;
		if the address is zero:
			say "I am not able to find the storage for that non-temporary named value.[paragraph break]";
		otherwise if the address is a valid integer address:
			parse the kind name the kind name for the integer at address address with disambiguation by disambiguating a debug command;
			if the most recently parsed kind name was understood:
				say "[the human-friendly name of the global record] as [the kind name] = [the most recently parsed kind name]: [the integer at address address according to the most recently parsed kind name][paragraph break]";
		otherwise:
			say "The storage for that non-temporary named value is outside of memory.[paragraph break]";
		delete the synthetic text the kind name;
		stop;
	let the memory stack variable name vertex be the first match for a memory stack variable name for the debugger among the children of V;
	unless the memory stack variable name vertex is an invalid parse tree vertex:
		let the memory stack variable record be the memory stack variable record named by the memory stack variable name vertex;
		if the memory stack variable record is an invalid memory stack variable record:
			delete the synthetic text the kind name;
			stop;
		let the address be the current address of the memory stack variable record;
		if the address is zero:
			say "That variable doesn't exist right now.[paragraph break]";
		otherwise if the address is a valid integer address:
			parse the kind name the kind name for the integer at address address with disambiguation by disambiguating a debug command;
			if the most recently parsed kind name was understood:
				say "[the human-friendly name of the memory stack variable record] = [the most recently parsed kind name]: [the integer at address address according to the most recently parsed kind name][paragraph break]";
		otherwise:
			say "The storage for that variable is outside of memory.[paragraph break]";
		delete the synthetic text the kind name;
		stop;
	let the local name vertex be the first match for a local name for the debugger among the children of V;
	unless the local name vertex is an invalid parse tree vertex:
		let the local index be the local index named by the local name vertex;
		if the local index is less than zero:
			delete the synthetic text the kind name;
			stop;
		parse the kind name the kind name for temporary named value local index of the debugger's current call frame with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[temporary name local index of the debugger's current call frame] as [the kind name] = [the most recently parsed kind name]: [temporary named value local index of the debugger's current call frame according to the most recently parsed kind name][paragraph break]";
		delete the synthetic text the kind name;
		stop;
	let the function name vertex be the first match for a function name for the debugger among the children of V;
	unless the function name vertex is an invalid parse tree vertex:
		let the function address be the address of the function whose name is named by the function name vertex;
		if the function address is zero:
			delete the synthetic text the kind name;
			stop;
		let the input name be a new synthetic text representing the words matched by the function name vertex;
		parse the kind name the kind name for the function address with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the input name] as [the kind name] = [the most recently parsed kind name]: [the function address according to the most recently parsed kind name][paragraph break]";
		delete the synthetic text the kind name;
		stop;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of V;
	unless the decimal vertex is an invalid parse tree vertex:
		let the value be the decimal number named by the decimal vertex;
		parse the kind name the kind name for the value with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the value] as [the kind name] = [the most recently parsed kind name]: [the value according to the most recently parsed kind name][paragraph break]";
		delete the synthetic text the kind name;
		stop;
	let the hexadecimal vertex be the first match for a hexadecimal number for the debugger among the children of V;
	unless the hexadecimal vertex is an invalid parse tree vertex:
		let the value be the hexadecimal number named by the hexadecimal vertex;
		parse the kind name the kind name for the value with disambiguation by disambiguating a debug command;
		if the most recently parsed kind name was understood:
			say "[the value in hexadecimal] as [the kind name] = [the most recently parsed kind name]: [the value according to the most recently parsed kind name][paragraph break]";
		delete the synthetic text the kind name;
		stop;
	let the object vertex be the first match for a object name for the debugger among the children of V;
	unless the object vertex is an invalid parse tree vertex:
		let the value be the object value named by the object vertex;
		unless the value is -1:
			let the input name be a new synthetic text representing the words matched by the object vertex;
			parse the kind name the kind name for the value with disambiguation by disambiguating a debug command;
			if the most recently parsed kind name was understood:
				say "[the input name] as [the kind name] = [the most recently parsed kind name]: [the value according to the most recently parsed kind name][paragraph break]";
			delete the synthetic text the input name;
		delete the synthetic text the kind name;
		stop.

Include (-
	#ifndef DEBUG;
	[ ShowMeSub;
		print "The ~showme~ command is only available in debug builds.^";
	];
	#endif;
-).

To invoke the showme subroutine on (V - a number): (- @push noun;noun={V};CreatePropertyOffsets();ShowMeSub();@pull noun; -).

To apply the debugger's showme to (V - a number):
	if the showme warnings flag is true:
		say "The 'showme' command works by running some story code, which is liable to crash the debugger if the story is in the middle of rearranging its data structures.  It could also disturb the state of the story, for instance if a printed name has a text substitution with side-effects.  Are you sure you want to continue (y, n, or Y)? ";
		if the author consents:
			if the consent was permanent:
				now the showme warnings flag is false;
			say "[line break]";
			invoke the showme subroutine on the V;
	otherwise:
		invoke the showme subroutine on the V;
	say "[line break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's showme command):
	if the debugger's story-running flag is false:
		say "The story is not running.  Use the command 'run' to run it.[paragraph break]";
		stop;
	let the object vertex be the first match for a object name for the debugger among the children of V;
	unless the object vertex is an invalid parse tree vertex:
		let the value be the object value named by the object vertex;
		unless the value is -1:
			apply the debugger's showme to the value;
		stop;
	let the global name vertex be the first match for a global name for the debugger among the children of V;
	unless the global name vertex is an invalid parse tree vertex:
		let the global record be the global record named by the global name vertex;
		if the global record is an invalid global record:
			stop;
		let the address be the address of the global record;
		if the address is zero:
			say "I am not able to find the storage for that non-temporary named value.[paragraph break]";
		otherwise if the address is a valid integer address:
			let the value be the integer at address address;
			if the validation error for the object value the value is empty:
				apply the debugger's showme to the value;
			otherwise:
				say "That's not a valid object, even if I apply a conversion.  Perhaps you meant the 'examine' command?[paragraph break]";
		otherwise:
			say "The storage for that non-temporary named value is outside of memory.[paragraph break]";
		stop;
	let the memory stack variable name vertex be the first match for a memory stack variable name for the debugger among the children of V;
	unless the memory stack variable name vertex is an invalid parse tree vertex:
		let the memory stack variable record be the memory stack variable record named by the memory stack variable name vertex;
		if the memory stack variable record is an invalid memory stack variable record:
			stop;
		let the address be the current address of the memory stack variable record;
		if the address is zero:
			say "That variable doesn't exist right now.[paragraph break]";
		otherwise if the address is a valid integer address:
			let the value be the integer at address address;
			if the validation error for the object value the value is empty:
				apply the debugger's showme to the value;
			otherwise:
				say "That's not a valid object, even if I apply a conversion.  Perhaps you meant the 'examine' command?[paragraph break]";
		otherwise:
			say "The storage for that variable is outside of memory.[paragraph break]";
		stop;
	let the local name vertex be the first match for a local name for the debugger among the children of V;
	unless the local name vertex is an invalid parse tree vertex:
		let the local index be the local index named by the local name vertex;
		if the local index is less than zero:
			stop;
		let the function address be the uninstrumented function address of the debugger's current call frame;
		let the actual function address be the address of the function substituted for the function at address function address;
		let the routine record be the routine record for the actual function address;
		let the value be temporary named value local index of the debugger's current call frame;
		if the validation error for the object value the value is empty:
			apply the debugger's showme to the value;
		otherwise:
			say "That's not a valid object, even if I apply a conversion.  Perhaps you meant the 'examine' command?[paragraph break]";
		stop;
	let the decimal vertex be the first match for a decimal number for the debugger among the children of V;
	unless the decimal vertex is an invalid parse tree vertex:
		let the value be the decimal number named by the decimal vertex;
		if the validation error for the object value the value is empty:
			apply the debugger's showme to the value;
		otherwise:
			say "That's not a valid object, even if I apply a conversion.  Perhaps you meant the 'examine' command?[paragraph break]";
		stop;
	let the hexadecimal vertex be the first match for a hexadecimal number for the debugger among the children of V;
	unless the hexadecimal vertex is an invalid parse tree vertex:
		let the value be the hexadecimal number named by the hexadecimal vertex;
		if the validation error for the object value the value is empty:
			apply the debugger's showme to the value;
		otherwise:
			say "That's not a valid object, even if I apply a conversion.  Perhaps you meant the 'examine' command?[paragraph break]";
		stop.

Chapter "Maintenance Commands" - unindexed

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's xyzzy command):
	say "Nothing happens.[paragraph break]".

To handle the debug command rooted at (V - a parse tree vertex that has the parseme the debugger's plugh command):
	say "Twice as much happens.[paragraph break]".

Book "Extra Global Names"

The verb is an action name that varies.  The verb variable translates into I6 as "action".
The requester is an object that varies.  The requester variable translates into I6 as "act_requester".

Interactive Debugger ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Interactive Debugger shows us what is happening ``inside'' of an Inform 7 story,
making it easier for us figure out why the latter behaves the way it does.  With
the extension we can (1) pause execution when certain conditions hold, resuming
it later, and (2) inspect the state of the story while it is paused.  Its
interface should be familiar to authors who have experience using gdb.

Details are in the README that accompanies the distribution of the extension
(and is also available for download from https://github.com/i7/i7grip).

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Interactive Debugger is subject to the caveats for the Glulx Runtime
Instrumentation Framework; see the requirements chapter in its documentation for
the technical details.

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

Interactive Debugger was prepared as part of the Glulx Runtime Instrumentation
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

Example: * Tournament - The First Tutorial Story

The README, which should have come with the extension, contains two debugger
tutorials.  The following source text is the story used in the first one.

	*: "Tournament" by Brady Garvin.
	
	Include Interactive Debugger by Brady Garvin.
	The name of the symbolic link to the debug information file is "...".
	The name of the symbolic link to the intermediate I6 file is "...".
	The name of the symbolic link to the debugging log file is "...".
	
	The Lists are a Room.
	A mark is a kind of thing.
	Here is a mark called a target; here is a mark called a willow wand.
	The player is a man called Locksley.
	An arrow is a kind of thing.
	The player carries a longbow and three arrows.
	
	Understand the command "shoot" as "attack".
	
	Check attacking (this is the check archery rule):
		if the noun is not a mark:
			abide by the block attacking rule;
		if the player does not carry the longbow:
			say "You lack a bow.";
			stop the action;
		if the player does not carry an arrow:
			say "You lack an arrow.";
			stop the action.
	
	The check archery rule is listed instead of the block attacking rule in the check attacking rulebook.
	
	To hit (T - a mark) with (A - an arrow):
		if an arrow (called the previous shot) is part of T:
			now A is part of the previous shot;
		otherwise:
			now A is part of T.
	
	To hit (T - the willow wand) with (A - an arrow):
		remove the willow wand from play;
		move A to the location of T.
	
	Carry out attacking:
		if the player carries an arrow (called the missile):
			hit the noun with the missile.
	
	Report attacking:
		say "Your arrow buries itself in [the noun]."
	
	Report attacking the willow wand:
		say "Your arrow splits the rod.";
		stop.

Example: ** Monochrome - The Second Tutorial Story

The README, which should have come with the extension, contains two debugger
tutorials.  The following source text is the story used in the second one.

	*: "Monochrome" by Brady Garvin.
	
	Include Interactive Debugger by Brady Garvin.
	The name of the symbolic link to the debug information file is "...".
	The name of the symbolic link to the intermediate I6 file is "...".
	The name of the symbolic link to the debugging log file is "...".
	
	Monochromatic is a truth state that varies.  Monochromatic is false.
	
	Drawing Room is a room.
	The table is a supporter in the drawing room.  The description is "A low coffee table, mahogany, to guess from the [if monochromatic is true]dark gray[otherwise]reddish-brown[end if] color."
	The bowl is a container on the table.  The description is "Ceramic[if monochromatic is true] and glaringly white[otherwise], in a stunning lemon yellow[end if]."
	The fruit is an edible thing in the bowl.  The indefinite article is "some".  The description is "[if monochromatic is true]Three silvery apples[otherwise]Two red apples, a green one,[end if] and a [if monochromatic is true]charcoal [end if]pear."
	
	The player carries a whiteboard.  The whiteboard has some indexed text called the image.  The image of the whiteboard is "".  The description of the whiteboard is "[if the image of the whiteboard is empty]It's blank.[otherwise]It shows [the image of the whiteboard][end if]".
	
	Drawing is an action applying to one thing.
	Understand "draw [something]" as drawing.
	Carry out drawing:
		now the image of the whiteboard is the description of the noun in lower case.
	Report drawing:
		say "You capture the essence of [the noun] perfectly."
	
	Xyzzying is an action applying to nothing.
	Understand "xyzzy" as xyzzying.
	Carry out xyzzying:
		now monochromatic is whether or not monochromatic is false.
	Report xyzzying:
		say "Something has changed."

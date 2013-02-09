Version 1 of Output Interception (for Glulx only) by Brady Garvin begins here.

"Facilities for detecting and recording output."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Glulx Text Decoding by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.
Include Glk Interception by Brady Garvin.

Use authorial modesty.

Book "Extension Information"

[Nothing to mention here in the present version.]

Chapter "Rulebooks"

The output interception rules are [rulebook is] a rulebook.

Book "Output Interception"

Chapter "Handler Variables"

Section "Output Interception Types"

An output interception type is a kind of value.  The output interception types are invalid textual output, valid textual output, and save file output.  The specification of an output interception type is "The output interception types represent the various kinds of output that Output Interception can detect.  'Invalid textual output' signifies that the story is about to write an invalid string to a stream, 'valid textual output' that it is about to write a valid string (available at 'the address of the intercepted output', a Unicode array whose length is 'the length of the intercepted output'), and 'save file output' that it is about to write a save file."

Section "Mutable Handler Variables" - unindexed

The variable holding the type of the intercepted output is an output interception type that varies.
The variable holding the input-output system of the intercepted output is a number that varies.
The variable holding the stream of the intercepted output is a number that varies.

The variable holding the address of the intercepted output is a number that varies.
The variable holding the length of the intercepted output is a number that varies.

Section "Other Private Storage" - unindexed

Include (-
	Array oi_loneCharacter --> 1;
-).

To decide what number is the address for storing an intercepted lone character: (- oi_loneCharacter -).

Section "Convenience Handler Variable Mutators" - unindexed

To set the intercepted output to the lone Latin-1 character (C - a number):
	let the character be C;
	if the character is greater than 255:
		now the character is 63 [question mark];
	set the intercepted output to the lone Unicode character the character.

To set the intercepted output to the lone Unicode character (C - a number):
	write the integer C to address the address for storing an intercepted lone character;
	now the variable holding the address of the intercepted output is the address for storing an intercepted lone character;
	now the variable holding the length of the intercepted output is one.

To set the intercepted output to the C-style Latin-1 string at address (A - a number):
	now the variable holding the address of the intercepted output is A;
	let the search extent be the size of memory minus A;
	now the variable holding the length of the intercepted output is the index of the byte zero in the search extent bytes at address A.

To set the intercepted output to the C-style Unicode string at address (A - a number):
	now the variable holding the address of the intercepted output is A;
	let the search extent be the size of memory minus A;
	now the variable holding the length of the intercepted output is the index of the integer zero in the search extent divided by four integers at address A.

Section "Immutable Handler Variables"

To decide what output interception type is the type of the intercepted output: (- (+ the variable holding the type of the intercepted output +) -).
To decide what number is the input-output system of the intercepted output: (- (+ the variable holding the input-output system of the intercepted output +) -).
To decide what number is the stream of the intercepted output: (- (+ the variable holding the stream of the intercepted output +) -).

To decide what number is the address of the intercepted output: (- (+ the variable holding the address of the intercepted output +) -).
To decide what number is the length of the intercepted output: (- (+ the variable holding the length of the intercepted output +) -).

Chapter "Latin-1-to-Unicode Expansion" - unindexed

To decide what number is the address of a new Latin-1-to-Unicode expansion of the (N - a number) bytes at address (A - a number):
	let the result be a possibly zero-length memory allocation of N times four bytes;
	let the target be the result;
	repeat with the index running over the half-open interval from zero to N:
		let the character be the byte at address A plus the index;
		write the integer the character to address the target;
		increase the target by four;
	decide on the result.

Chapter "Interception Dispatch" - unindexed

To intercept the output (this is intercepting the output):
	traverse the output interception rulebook.

A GRIF shielding rule (this is the shield intercepting the output against instrumentation rule):
	shield intercepting the output against instrumentation.

Chapter "Indirect Output" - unindexed

Section "Temporary Space" - unindexed

Include (-
	Array oi_streamPops --> 8;
-).

To decide what number is where stack pops from streaming instructions are temporarily saved for output interception: (- oi_streamPops -).

Section "Convenience Phrases for Indirect Output" - unindexed

Include (-
	[ oi_getIOSystem;
		@getiosys sp 0;
		@return sp;
	];
-).

To decide what number is the current input-output system: (- oi_getIOSystem() -).
To decide what number is the null input-output system: (- 0 -).
To decide what number is the filter input-output system: (- 1 -).
To decide what number is the Glk input-output system: (- 2 -).

To set the stream of the intercepted output to the current stream during indirect output:
	if the current input-output system is the Glk input-output system:
		prepare a spontaneous Glk invocation;
		write the function selector 72 [glk_stream_get_current] to the current Glk invocation;
		write the argument count zero to the current Glk invocation;
		delegate the current Glk invocation to the Glk layer after output interception;
		now the variable holding the stream of the intercepted output is the result of the Glk invocation just delegated;
	otherwise:
		now the variable holding the stream of the intercepted output is zero.

Section "Instrumentation Callbacks" - unindexed

To intercept the output of a streamchar with argument (C - a number) (this is intercepting the output of a streamchar):
	now the variable holding the type of the intercepted output is valid textual output;
	now the variable holding the input-output system of the intercepted output is the current input-output system;
	set the stream of the intercepted output to the current stream during indirect output;
	set the intercepted output to the lone Latin-1 character the bitwise and of C and 255;
	intercept the output.

To intercept the output of a streamunichar with argument (C - a number) (this is intercepting the output of a streamunichar):
	now the variable holding the type of the intercepted output is valid textual output;
	now the variable holding the input-output system of the intercepted output is the current input-output system;
	set the stream of the intercepted output to the current stream during indirect output;
	set the intercepted output to the lone Unicode character C;
	intercept the output.

The streamnum argument to intercept is a number that varies.

To intercept the output of a streamnum with argument (N - a number) (this is intercepting the output of a streamnum):
	now the variable holding the type of the intercepted output is valid textual output;
	now the variable holding the input-output system of the intercepted output is the current input-output system;
	set the stream of the intercepted output to the current stream during indirect output;
	now the streamnum argument to intercept is N;
	let the digits be a new synthetic text copied from "[the streamnum argument to intercept]";
	now the variable holding the address of the intercepted output is the address of a new Latin-1-to-Unicode expansion of the length of the digits bytes at address the character array address of the synthetic text the digits;
	now the variable holding the length of the intercepted output is the length of the digits;
	delete the synthetic text the digits;
	intercept the output;
	free the possibly zero-length memory allocation at address the address of the intercepted output.

To begin capturing Unicode in the (N - a number) integers at address (A - a number): (-
	@getiosys sp sp; ! save the input-output system
	@setiosys 2 0;   ! switch to Glk
	@glk 72 0 sp;    ! save the current stream
	glk_stream_set_current(glk_stream_open_memory_uni({A},{N},filemode_Write,0));
-).
To end capturing Unicode in integers at an address: (-
	glk_stream_close(glk_stream_get_current(),0);
	@glk 71 1 0;     ! restore the current stream
	@stkswap;        ! restore the input-output system
	@setiosys sp sp; ! restore the input-output system
-).

To intercept the output of a streamstr with argument (A - a number) (this is intercepting the output of a streamstr):
	now the variable holding the input-output system of the intercepted output is the current input-output system;
	set the stream of the intercepted output to the current stream during indirect output;
	now the variable holding the length of the intercepted output is the character length of the substitution-free A converted to some text;
	if the length of the intercepted output is -1:
		now the variable holding the type of the intercepted output is invalid textual output;
		intercept the output;
	otherwise:
		now the variable holding the type of the intercepted output is valid textual output;
		let the indicator be the byte at address A;
		if the indicator is:
			-- 224: [null-terminated Latin-1]
				now the variable holding the address of the intercepted output is the address of a new Latin-1-to-Unicode expansion of the length of the intercepted output bytes at address A plus one;
				intercept the output;
				free the possibly zero-length memory allocation at address the address of the intercepted output;
			-- 225: [compressed]
				now the variable holding the address of the intercepted output is a possibly zero-length memory allocation of the length of the intercepted output times four bytes;
				begin capturing Unicode in the length of the intercepted output integers at address the address of the intercepted output;
				repeat with the decoding vertex running with paranoia through the compressed A converted to some text:
					say "[the decoding vertex]";
				end capturing Unicode in integers at an address;
				intercept the output;
				free the possibly zero-length memory allocation at address the address of the intercepted output;
			-- 226: [null-terminated Unicode]
				now the variable holding the address of the intercepted output is A plus one;
				intercept the output.

To intercept the output of a save with argument (S - a number) (this is intercepting the output of a save):
	now the variable holding the type of the intercepted output is save file output;
	now the variable holding the input-output system of the intercepted output is the current input-output system;
	now the variable holding the stream of the intercepted output is S;
	intercept the output.

Section "Instrumentation Callback Shielding"

A GRIF shielding rule (this is the shield output interception calls against instrumentation rule):
	shield intercepting the output of a streamchar against instrumentation;
	shield intercepting the output of a streamunichar against instrumentation;
	shield intercepting the output of a streamnum against instrumentation;
	shield intercepting the output of a streamstr against instrumentation;
	shield intercepting the output of a save against instrumentation.

Section "Instrumentation"

A GRIF instrumentation rule (this is the intercept the output of streamchar instructions rule):
	repeat with the instruction vertex running through occurrences of the operation code op-streamchar in the scratch space:
		cleanse the instruction vertex of stack pops using the array at address where stack pops from streaming instructions are temporarily saved for output interception;
		let the addressing mode be the addressing mode of parameter zero of the instruction vertex;
		let the parameter be parameter zero of the instruction vertex;
		let the interception instruction vertex be a new artificial instruction vertex for a one-argument call to the function at address the function address of intercepting the output of a streamchar with mode the addressing mode and parameter the parameter and return mode the zero-or-discard addressing mode;
		insert the interception instruction vertex before the instruction vertex.

A GRIF instrumentation rule (this is the intercept the output of streamunichar instructions rule):
	repeat with the instruction vertex running through occurrences of the operation code op-streamunichar in the scratch space:
		cleanse the instruction vertex of stack pops using the array at address where stack pops from streaming instructions are temporarily saved for output interception;
		let the addressing mode be the addressing mode of parameter zero of the instruction vertex;
		let the parameter be parameter zero of the instruction vertex;
		let the interception instruction vertex be a new artificial instruction vertex for a one-argument call to the function at address the function address of intercepting the output of a streamunichar with mode the addressing mode and parameter the parameter and return mode the zero-or-discard addressing mode;
		insert the interception instruction vertex before the instruction vertex.

A GRIF instrumentation rule (this is the intercept the output of streamnum instructions rule):
	repeat with the instruction vertex running through occurrences of the operation code op-streamnum in the scratch space:
		cleanse the instruction vertex of stack pops using the array at address where stack pops from streaming instructions are temporarily saved for output interception;
		let the addressing mode be the addressing mode of parameter zero of the instruction vertex;
		let the parameter be parameter zero of the instruction vertex;
		let the interception instruction vertex be a new artificial instruction vertex for a one-argument call to the function at address the function address of intercepting the output of a streamnum with mode the addressing mode and parameter the parameter and return mode the zero-or-discard addressing mode;
		insert the interception instruction vertex before the instruction vertex.

A GRIF instrumentation rule (this is the intercept the output of streamstr instructions rule):
	repeat with the instruction vertex running through occurrences of the operation code op-streamstr in the scratch space:
		cleanse the instruction vertex of stack pops using the array at address where stack pops from streaming instructions are temporarily saved for output interception;
		let the addressing mode be the addressing mode of parameter zero of the instruction vertex;
		let the parameter be parameter zero of the instruction vertex;
		let the interception instruction vertex be a new artificial instruction vertex for a one-argument call to the function at address the function address of intercepting the output of a streamstr with mode the addressing mode and parameter the parameter and return mode the zero-or-discard addressing mode;
		insert the interception instruction vertex before the instruction vertex.

A GRIF instrumentation rule (this is the intercept the output of save instructions rule):
	repeat with the instruction vertex running through occurrences of the operation code op-save in the scratch space:
		cleanse the instruction vertex of stack pops using the array at address where stack pops from streaming instructions are temporarily saved for output interception;
		let the addressing mode be the addressing mode of parameter zero of the instruction vertex;
		let the parameter be parameter zero of the instruction vertex;
		let the interception instruction vertex be a new artificial instruction vertex for a one-argument call to the function at address the function address of intercepting the output of a save with mode the addressing mode and parameter the parameter and return mode the zero-or-discard addressing mode;
		insert the interception instruction vertex before the instruction vertex.

Chapter "Direct Output" - unindexed

Section "Convenience Phrases for Direct Output" - unindexed

To set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length:
	if the length of the intercepted output is -1:
		now the variable holding the type of the intercepted output is invalid textual output;
	otherwise:
		now the variable holding the type of the intercepted output is valid textual output;
	now the variable holding the input-output system of the intercepted output is the Glk input-output system.

To set the stream of the intercepted output to the current stream during direct output:
	let the pending invocation be a new copy of the current Glk invocation;
	write the function selector 72 [glk_stream_get_current] to the current Glk invocation;
	write the argument count zero to the current Glk invocation;
	delegate the current Glk invocation to the Glk layer after output interception;
	now the variable holding the stream of the intercepted output is the result of the Glk invocation just delegated;
	prepare another Glk invocation from the pending invocation;
	delete the pending invocation.

Section "Glk Interception Layer" - unindexed

The Glk layer after output interception is a Glk layer that varies.

To intercept output via direct Glk calls (this is intercepting output via direct Glk calls):
	if the function selector of the current Glk invocation is:
		-- 128: [glk_put_char]
			ensure that the current Glk invocation has at least one argument;
			set the stream of the intercepted output to the current stream during direct output;
			set the intercepted output to the lone Latin-1 character argument number zero of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 296: [glk_put_char_uni]
			ensure that the current Glk invocation has at least one argument;
			set the stream of the intercepted output to the current stream during direct output;
			set the intercepted output to the lone Unicode character argument number zero of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 129: [glk_put_char_stream]
			ensure that the current Glk invocation has at least two arguments;
			now the variable holding the stream of the intercepted output is argument number zero of the current Glk invocation;
			set the intercepted output to the lone Latin-1 character argument number one of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 299: [glk_put_char_stream_uni]
			ensure that the current Glk invocation has at least two arguments;
			now the variable holding the stream of the intercepted output is argument number zero of the current Glk invocation;
			set the intercepted output to the lone Unicode character argument number one of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 130: [glk_put_string]
			ensure that the current Glk invocation has at least one argument;
			set the stream of the intercepted output to the current stream during direct output;
			set the intercepted output to the C-style Latin-1 string at address argument number zero of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 297: [glk_put_string_uni]
			ensure that the current Glk invocation has at least one argument;
			set the stream of the intercepted output to the current stream during direct output;
			set the intercepted output to the C-style Unicode string at address argument number zero of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 131: [glk_put_string_stream]
			ensure that the current Glk invocation has at least two arguments;
			now the variable holding the stream of the intercepted output is argument number zero of the current Glk invocation;
			set the intercepted output to the C-style Latin-1 string at address argument number one of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 300: [glk_put_string_stream_uni]
			ensure that the current Glk invocation has at least two arguments;
			now the variable holding the stream of the intercepted output is argument number zero of the current Glk invocation;
			set the intercepted output to the C-style Unicode string at address argument number one of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 132: [glk_put_buffer]
			ensure that the current Glk invocation has at least two arguments;
			set the stream of the intercepted output to the current stream during direct output;
			now the variable holding the address of the intercepted output is the address of a new Latin-1-to-Unicode expansion of the argument number one of the current Glk invocation bytes at address argument number zero of the current Glk invocation;
			now the variable holding the length of the intercepted output is argument number one of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
			free the possibly zero-length memory allocation at address the address of the intercepted output;
		-- 298: [glk_put_buffer_uni]
			ensure that the current Glk invocation has at least two arguments;
			set the stream of the intercepted output to the current stream during direct output;
			now the variable holding the address of the intercepted output is argument number zero of the current Glk invocation;
			now the variable holding the length of the intercepted output is argument number one of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
		-- 133: [glk_put_buffer_stream]
			ensure that the current Glk invocation has at least three arguments;
			now the variable holding the stream of the intercepted output is argument number zero of the current Glk invocation;
			now the variable holding the address of the intercepted output is the address of a new Latin-1-to-Unicode expansion of the argument number two of the current Glk invocation bytes at address argument number one of the current Glk invocation;
			now the variable holding the length of the intercepted output is argument number two of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
			free the possibly zero-length memory allocation at address the address of the intercepted output;
		-- 301: [glk_put_buffer_stream_uni]
			ensure that the current Glk invocation has at least two arguments;
			now the variable holding the stream of the intercepted output is argument number zero of the current Glk invocation;
			now the variable holding the address of the intercepted output is argument number one of the current Glk invocation;
			now the variable holding the length of the intercepted output is argument number two of the current Glk invocation;
			set the type and input-output system of the intercepted output to textual output under Glk with validity determined by the output length;
			intercept the output;
	delegate the current Glk invocation to the Glk layer after output interception.

Section "Glk Interception Layering Rule"

A last Glk layering rule (this is the intercept output via direct Glk calls rule):
	install intercepting output via direct Glk calls as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after output interception be the layer it should delegate to.

Output Interception ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Output Interception is a support extension for debugging extensions that need to
unintrusively observe a story's textual output.

Details are in the following chapters.

Chapter: Usage

Every time the story is about to print any output, even to memory or a file,
Output Interception traverses

	the output interception rulebook

so that rules in that rulebook can preview the data and respond if necessary.

Output interception rules should always consult

	the type of the intercepted output

first; this is a phrase deciding on a value of the kind

	an output interception type

At the moment there are three possibilities:

	invalid textual output

means that the story is about to print invalid text.  Unless the interpreter is
particularly forgiving, the story will probably crash.

	valid textual output

on the other hand, means that the story is about the print valid text.  It's
stored as a sequence of Unicode code points at

	the address of the intercepted output

and the code point count is given by

	the length of the intercepted output

A rule can inspect the code points using the memory-accessing phrases from
Low-Level Operations.  It must not attempt to change them.

The third possibility,

	save file output

means that the story is emitting a save file.  The contents of the save file are
not available for inspection because the save hasn't occurred yet, and any
actions taken by the interception rules will alter them.

After determining the interception type, an output interception rule may also be
interested in

	the input-output system of the intercepted output

The input-output systems that can be referred to by name are

	the null input-output system

	the filter input-output system

and

	the Glk input-output system

See the Glulx specification for more details.  Most stories use Glk exclusively,
but some interpreters, such as FyreVM, support additional I/O systems, which the
story may test for.

And finally, if output was written through the Glk I/O system,

	the stream of the intercepted output

will be the opaque reference to the stream where the output was written.  We can
compare these values between calls to determine whether two pieces of output
were sent to the same place.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

I/O is written as input-output in the code since Inform sometimes treats the
slash as semantic.

The null I/O system, filter I/O, and Glk are the only I/O system currently
recognized.  FyreVM support may be added in the future if there is enough
interest.

The Glulx specification allows the string decoding table to contain calls to
Glulx functions (see Section 1.6.1.4 of the Glulx specification).  The validity
of these calls will not checked, nor will their output be captured correctly.
As best I can tell, this limitation only affects authors who store routine
addresses in I6 printing variables, and code of this sort will break on the
Z-machine, so it's not a good idea anyway.

Output by way of echo streams is not detected. [////]

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

Output Interception was prepared as part of the Glulx Runtime Instrumentation
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

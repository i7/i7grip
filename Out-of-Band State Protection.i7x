Version 1 of Out-of-Band State Protection (for Glulx only) by Brady Garvin begins here.

"A framework for simulating @protect-like behavior with instrumentation hooks and external files."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Glulx Runtime Instrumentation Framework by Brady Garvin.
Include Glk Interception by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[Nothing to mention here in the present version.]

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at finding (N - a number) byte/bytes during deserialization:
	say "[low-level runtime failure in]Out-of-Band State Protection[with explanation]I tried to read [N converted to a number] byte[s] from a temporary file, but didn't find that many, which either indicates a bug in the serialization/deserialization code or some external interference, perhaps by another program.[terminating the story]".

Book "Serialization and Deserialization"

Chapter "Filename for Protected State" - unindexed

The protected state filename is some text that varies.

A GRIF setup rule (this is the choose a filename for out-of-band state protection rule):
	[The integer at address 32 is the story checksum.]
	[2147483647 is a 32-bit mask omitting only the sign bit.]
	now the protected state filename is a new permanent synthetic text copied from "obsp_[the bitwise and of 2147483647 and the integer at address 32]_[the story title]".

Chapter "Serializing Protected State" - unindexed

Include (-
	! Note that serialization is not reentrant (it should never need to be).
	Global obsp_serializationShadowedStream;
	[ obsp_beginSerialization
		fileReference stream;
		obsp_serializationShadowedStream = glk_stream_get_current();
		fileReference = glk_fileref_create_by_name(fileusage_Data | fileusage_BinaryMode, (+ the protected state filename +), 0);
		stream = glk_stream_open_file(fileReference, filemode_Write, 0);
		glk_fileref_destroy(fileReference);
		glk_stream_set_current(stream);
	];
	[ obsp_endSerialization;
		if (glk_stream_get_current()) glk_stream_close(glk_stream_get_current(), 0);
		glk_stream_set_current(obsp_serializationShadowedStream);
	];
-).

To begin serializing protected state: (- obsp_beginSerialization(); -).
To end serializing protected state: (- obsp_endSerialization(); -).

Section "Serializing Truth States"

To serialize (T - a truth state): (- glk_put_char({T}); -).

Section "Serializing Numbers"

To serialize (N - a number): (- 
	glk_put_char(llo_logicalRightShift({N}, 24));
	glk_put_char(llo_logicalRightShift({N}, 16) & 255);
	glk_put_char(llo_logicalRightShift({N}, 8) & 255);
	glk_put_char(({N}) & 255);
-).

Section "Serializing Arrays"

To serialize (N - a number) bytes at address (A - a number): (- glk_put_buffer({A}, {N}); -).

Section "Serializing Synthetic Text"

To serialize the synthetic text (T - some text):
	let the length be the length of the synthetic text T;
	serialize the length;
	serialize the length bytes at address the character array address of the synthetic text T.

Chapter "Deserializing Protected State" - unindexed

Include (-
	Global obsp_deserializationAddress = llo_zeroLengthAllocationAddress;
	Global obsp_deserializationMarker = llo_zeroLengthAllocationAddress;
	Global obsp_deserializationLength = 0;
-) after "Definitions.i6t".

Include (-
	! Note that deserialization is not reentrant (it should never need to be).
	[ obsp_beginDeserialization
		fileReference stream;
		fileReference = glk_fileref_create_by_name(fileusage_Data | fileusage_BinaryMode, (+ the protected state filename +), 0);
		stream = glk_stream_open_file(fileReference, filemode_Read, 0);
		if (~~stream) {
			glk_fileref_destroy(fileReference);
			obsp_deserializationAddress = llo_zeroLengthAllocationAddress;
			obsp_deserializationMarker = obsp_deserializationAddress;
			obsp_deserializationLength = 0;
			return;
		}
		glk_stream_set_position(stream, 0, seekmode_End);
		obsp_deserializationLength = glk_stream_get_position(stream);
		if (obsp_deserializationLength) {
			glk_stream_set_position(stream, 0, seekmode_Start);
			@malloc obsp_deserializationLength obsp_deserializationAddress;
			glk_get_buffer_stream(stream, obsp_deserializationAddress, obsp_deserializationLength);
		} else {
			obsp_deserializationAddress = llo_zeroLengthAllocationAddress;
		}
		obsp_deserializationMarker = obsp_deserializationAddress;
		glk_stream_close(stream, 0);
		glk_fileref_delete_file(fileReference);
		glk_fileref_destroy(fileReference);
	];
	[ obsp_endDeserialization;
		if (obsp_deserializationAddress ~= llo_zeroLengthAllocationAddress) {
			@mfree obsp_deserializationAddress;
			obsp_deserializationAddress = llo_zeroLengthAllocationAddress;
			obsp_deserializationMarker = llo_zeroLengthAllocationAddress;
			obsp_deserializationLength = 0;
		}
	];
-).

To begin deserializing protected state: (- obsp_beginDeserialization(); -).
To end deserializing protected state: (- obsp_endDeserialization(); -).

To decide whether there is data to deserialize: (- obsp_deserializationLength -).

Section "Bounds Checks"

To decide whether (N - a number) byte/bytes is/are available for deserialization: (- ((obsp_deserializationMarker + {N}) <= (obsp_deserializationAddress + obsp_deserializationLength)) -).

Section "Deserializing Truth States"

To decide whether a deserialized truth state is true without bounds checks: (- llo_getByte(obsp_deserializationMarker++) -).

To decide whether a deserialized truth state is true:
	always check that one byte is available for deserialization or else fail at finding one byte during deserialization;
	decide on whether or not a deserialized truth state is true without bounds checks.

Section "Deserializing Numbers"

To decide what number is a deserialized number without bounds checks: (- llo_getInt((obsp_deserializationMarker = obsp_deserializationMarker + 4) - 4) -).

To decide what number is a deserialized number:
	always check that four bytes are available for deserialization or else fail at finding four bytes during deserialization;
	decide on a deserialized number without bounds checks.

Section "Deserializing Arrays"

To deserialize (N - a number) bytes to address (A - a number) without bounds checks: (- llo_copy({N}, (obsp_deserializationMarker = obsp_deserializationMarker + {N}) - {N}, {A}); -).

To deserialize (N - a number) bytes to address (A - a number):
	always check that N bytes are available for deserialization or else fail at finding N bytes during deserialization;
	deserialize N bytes to address A without bounds checks.

Section "Deserializing Synthetic Text"

To decide what text is a deserialized synthetic text:
	let the length be a deserialized number;
	let the result be a new uninitialized synthetic text with length the length characters;
	deserialize the length bytes to address the character array address of the synthetic text the result;
	decide on the result.

Chapter "Rulebooks"

The protected state serialization/deserialization rules are [rulebook is] a rulebook.

Section "Variables for Rulebooks"

Serializing rather than deserializing is a truth state that varies.
To decide whether serializing rather than deserializing: (- (+ serializing rather than deserializing +) -).

Chapter "Phrases"

To serialize the protected state (this is serializing protected state):
	begin serializing protected state;
	now serializing rather than deserializing is true;
	traverse the protected state serialization/deserialization rulebook;
	end serializing protected state.

To deserialize the protected state (this is deserializing protected state):
	begin deserializing protected state;
	now serializing rather than deserializing is false;
	traverse the protected state serialization/deserialization rulebook;
	end deserializing protected state.

Section "Shielding"

A GRIF shielding rule (this is the shield protected state serialization and deserialization against instrumentation rule):
	shield serializing protected state against instrumentation;
	shield deserializing protected state against instrumentation.

Chapter "Instrumentation" - unindexed

Section "Temporary Space" - unindexed

Include (-
	Array obsp_restoreResult --> 1;
-) after "Definitions.i6t".

To decide what number is where the result of a restore-like operation is temporarily saved for state protection: (- obsp_restoreResult -).

Section "Instruction Vertices" - unindexed

[ @jne obsp_restoreResult-->0 -1 <constant>; ]
To decide what instruction vertex is a new restore-result-testing instruction vertex for state protection:
	let the result be a new artificial instruction vertex;
	write the operation code op-jne to the result;
	write the addressing mode zero-based-dereference addressing mode to parameter zero of the result;
	write where the result of a restore-like operation is temporarily saved for state protection to parameter zero of the result;
	write the addressing mode constant addressing mode to parameter one of the result;
	write -1 to parameter one of the result;
	write the addressing mode constant addressing mode to parameter two of the result;
	decide on the result.

[ @copy obsp_restoreResult-->0 <P-in-mode-M>; ]
To decide what instruction vertex is a new restore-result-restoring instruction vertex for mode (M - an addressing mode) and parameter (P - a number) for state protection:
	decide on a new artificial instruction vertex for a copy with source mode the zero-based-dereference addressing mode and source parameter where the result of a restore-like operation is temporarily saved for state protection and destination mode M and destination parameter P.

[ @callf <invocation-phrase> 0; ]
To decide what instruction vertex is a new protected state serialization instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the function address of serializing protected state with return mode the zero-or-discard addressing mode.

[ @callf <invocation-phrase> 0; ]
To decide what instruction vertex is a new protected state deserialization instruction vertex:
	decide on a new artificial instruction vertex for a zero-argument call to the function at address the function address of deserializing protected state with return mode the zero-or-discard addressing mode.

Section "Helper Phrase for Instrumentation" - unindexed

To note restores to (V - an instruction vertex) for state protection:
	let the store index be the parameter limit of V;
	let the result mode be the addressing mode of parameter the store index of V;
	let the result parameter be parameter the store index of V;
	write the addressing mode zero-based-dereference addressing mode to parameter the store index of V;
	write where the result of a restore-like operation is temporarily saved for state protection to parameter the store index of V;
	let the restore-result-restoring instruction vertex be a new restore-result-restoring instruction vertex for mode the result mode and parameter the result parameter for state protection;
	insert the restore-result-restoring instruction vertex after V;
	let the restore-result-testing instruction vertex be a new restore-result-testing instruction vertex for state protection;
	let the protected state deserialization instruction vertex be a new protected state deserialization instruction vertex;
	insert the restore-result-testing instruction vertex before the restore-result-restoring instruction vertex;
	insert the protected state deserialization instruction vertex before the restore-result-restoring instruction vertex;
	establish a jump link from the restore-result-testing instruction vertex to the restore-result-restoring instruction vertex.

Section "Instrumentation"

A GRIF instrumentation rule (this is the note undos and restores for state protection rule):
	start a new generation of artificial vertices;
	repeat with the instruction vertex running through occurrences of the operation code op-restore in the scratch space:
		let the protected state serialization instruction vertex be a new protected state serialization instruction vertex;
		insert the protected state serialization instruction vertex before the instruction vertex;
	repeat with the instruction vertex running through occurrences of the operation code op-restoreundo in the scratch space:
		let the protected state serialization instruction vertex be a new protected state serialization instruction vertex;
		insert the protected state serialization instruction vertex before the instruction vertex;
	repeat with the instruction vertex running through occurrences of the operation code op-restart in the scratch space:
		let the protected state serialization instruction vertex be a new protected state serialization instruction vertex;
		insert the protected state serialization instruction vertex before the instruction vertex;
	repeat with the instruction vertex running through occurrences of the operation code op-save in the scratch space:
		note restores to the instruction vertex for state protection;
	repeat with the instruction vertex running through occurrences of the operation code op-saveundo in the scratch space:
		note restores to the instruction vertex for state protection.
	[This missing third case, for deserializing after a restart, is handled by the startup hook below.]

Section "Startup Hook"

A first GRIF post-hijacking rule (this is the deserialize the protected state on startup rule):
	deserialize the protected state.

Out-of-Band State Protection ends here.

---- DOCUMENTATION ----

	the protected state serialization/deserialization rulebook

	if serializing rather than deserializing:
		...
	otherwise:
		....

	if there is data to deserialize:
		....

	serialize (T - a truth state)

	serialize (N - a number)

	serialize (N - a number) bytes at address (A - a number)

	serialize the synthetic text (T - some text)

	if (N - a number) byte/bytes is/are available for deserialization:
		....

	if a deserialized truth state is true:
		....

	a deserialized number

	deserialize (N - a number) bytes to address (A - a number)

	a deserialized synthetic text

	serialize the protected state

	deserialize the protected state

	serializing protected state

	deserializing protected state

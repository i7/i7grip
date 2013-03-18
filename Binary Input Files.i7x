Version 1 of Binary Input Files (for Glulx only) by Brady Garvin begins here.

"A support extension for Debug File Parsing: phrases for reading structured binary data from a persisting stream."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.

Include version 9 of Glulx Entry Points by Emily Short.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Binary Input Files you will see a sentence like

	A binary input file stream is an invalid binary input file stream.

This bewildering statement actually sets up binary input file streams as a qualitative value with default value the binary input file stream at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on binary input file streams.]

Chapter "Use Options" - unindexed

Use a binary input file stream buffer length of at least 65536 translates as (- Constant BIF_BUFFER_LENGTH={N}; -).

To decide what number is the binary input file stream buffer length: (- BIF_BUFFER_LENGTH -).

Book "Runtime Checks"

Chapter "Runtime Checks"

An environment check rule (this is the check for dynamic memory allocation to support Binary Input Files rule):
	always check that memory allocation is supported or else say "[low-level runtime failure in]Binary Input Files[with explanation]This story uses persistent binary input files, which in turn depend on dynamic memory allocation.  But this interpreter doesn't allow dynamic memory allocation, so the story cannot run.[terminating the story]".

Chapter "Messages" - unindexed

To fail at finding an allocated rock for a binary input file:
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to allocated a rock to a binary input file, but they were all in use.  Try defining the I6 constant BIF_ROCK_COUNT as a larger value.  (Currently it is [the maximum number of rocks available for binary input files]).[terminating the story]".

To fail at opening an invalid binary input file stream for a file named (F - some text):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I was asked to use an invalid stream to open the file named '[F converted to some text]' (without the surrounding quotes).[terminating the story]".

To fail at opening an invalid binary input file stream for blorb resource (R - a number):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I was asked to use an invalid stream to open the resource numbered '[R converted to a number]'.[terminating the story]".

To fail at opening a binary input file stream for a file named (F - some text):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to use a stream to open the file named '[F converted to some text]' (without the surrounding quotes), but Glk rejected that file name.  It might be invalid, or I might not have permission to read the file, or the file name might refer to a broken symbolic link, or there might be no such file at all.[terminating the story]".

To fail at opening a binary input file stream for blorb resource (R - a number):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to use a stream to open the resource numbered '[R converted to a number]', but Glk rejected that resource number.[terminating the story]".

To fail at clearing position information in a closed binary input file stream:
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to clear position information in a binary input file stream that was closed.  But that doesn't make sense, because I should only make such an attempt after I've successfully opened a stream.[terminating the story]".

To fail at opening a binary input file stream for a second file named (F - some text):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to use a stream to open the file '[F converted to some text]', but it was already open for reading another file or resource.[terminating the story]".

To fail at opening a binary input file stream for a second resource numbered (R - a number):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to use a stream to open the resource numbered '[R converted to a number]', but it was already open for reading another file or resource.[terminating the story]".

To fail at reopening a binary input file stream that isn't open:
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to decide whether I needed to reopen a file after a restore or an undo, but part of my bookkeeping says yes while the other part says no.  Something must have gone wrong before the save or the undo checkpoint.[terminating the story]".

To fail at using a null binary input file reference for the file named (F - some text):
	say "[low-level runtime failure in]Binary Input Files[with explanation]I asked Glk for a file reference to the file '[F converted to some text]', but it returned null.[terminating the story]".

To fail at scrolling a closed binary input file stream:
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to scroll a binary input file stream, but it was closed.[terminating the story]".

To fail at reading (N - a number) bytes when the available bytes are insufficient:
	if N is greater than the binary input file stream buffer length:
		let the thousands count be N divided by 1000;
		increment the thousands count;
		say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to read [N converted to a number] bytes from a binary input file stream, but there weren't that many available.  The buffer size is [the binary input file stream buffer length] bytes, and I can only read that many at once.  If you need a larger buffer, try adding a line like[line break][line break][fixed letter spacing]    Use a binary input file stream buffer length of at least [the thousands count times 1000].[variable letter spacing][warning type][line break][line break]to the source text.[terminating the story]";
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to read [N converted to a number] bytes from a binary input file stream, but there weren't that many available.  The end of the file appeared first.[terminating the story]".
 
To fail at reading up through character code (C - a number) when the available bytes are insufficient:
	let the thousands count be the binary input file stream buffer length divided by 1000;
	increment the thousands count;
	say "[low-level runtime failure in]Binary Input Files[with explanation]I tried to read up through character code [C converted to a number] from a binary input file stream, but there weren't enough bytes available for me to find that code within the span of one buffer.  It may help to know that the buffer size is [the binary input file stream buffer length] bytes.  You can increase it by adding a line like[line break][line break][fixed letter spacing]    Use a binary input file stream buffer length of at least [the thousands count times 1000].[variable letter spacing][warning type][line break][line break]to the source text.[terminating the story]".

Book "Early Adoption" - unindexed

Include (-
#ifndef glk_stream_open_resource;
	[ glk_stream_open_resource _vararg_count ret;
	! glk_stream_open_resource (filenum rock)
	  ! And now the @glk call
	  @glk $49 _vararg_count ret;
	  return ret;
	];
#endif;
-) after "Definitions.i6t".

Book "Rocks"

Chapter "Rock Range"

Include (-
	Constant BIF_MINIMUM_ROCK = -100;
	Constant BIF_ROCK_COUNT = 16;
-) after "Definitions.i6t".

Chapter "Rock Bookkeeping" - unindexed

Include (-
	Global bif_rocksAvailable = -1; ! -1 means unknown, since they haven't been allocated yet
	Array bif_rockStack --> BIF_ROCK_COUNT;
	! Because the previous declarations might appear after their uses in I7, we make accessors and mutators:
	[ bif_getMinimumRock;
		return BIF_MINIMUM_ROCK;
	];
	[ bif_getRockCount;
		return BIF_ROCK_COUNT;
	];
	[ bif_getRocksAvailable;
		return bif_rocksAvailable;
	];
	[ bif_setRocksAvailable value;
		bif_rocksAvailable=value;
	];
	[ bif_getRockStack;
		return bif_rockStack;
	];
-).

To decide what number is the minimum rock available for binary input files: (- bif_getMinimumRock() -).
To decide what number is the maximum number of rocks available for binary input files: (- bif_getRockCount() -).
To decide whether the rock (R - a number) is for a binary input file: (- llo_unsignedLessThan({R}-bif_getMinimumRock(),bif_getRockCount()) -)

To decide what number is the number of rocks available for binary input files: (- bif_getRocksAvailable() -).
To set the number of rocks available for binary input files to (N - a number): (- bif_setRocksAvailable({N}); -).
To decide what number is the address of the rock stack for binary input files: (- bif_getRockStack() -).

Chapter "Allocation" - unindexed

To allocate rocks for binary input files:
	if the number of rocks available for binary input files is -1:
		let the limit be the maximum number of rocks available for binary input files;
		repeat with the index running over the half-open interval from zero to the limit:
			let the rock address be four times the index;
			increase the rock address by the address of the rock stack for binary input files;
			let the rock be the minimum rock available for binary input files plus the index;
			write the integer rock to address rock address;
		set the number of rocks available for binary input files to the maximum number of rocks available for binary input files.

Chapter "Popping and Returning Rocks" - unindexed

To decide what number is a binary input file rock popped from the rock stack:
	allocate rocks for binary input files;
	let the index be the number of rocks available for binary input files;
	always check that the index is greater than zero or else fail at finding an allocated rock for a binary input file;
	decrement the index;
	set the number of rocks available for binary input files to the index;
	let the offset be the index times four;
	decide on the integer at address address of the rock stack for binary input files plus the offset.

To return the binary input file rock (R - a number) to the rock stack:
	let the index be the number of rocks available for binary input files;
	let the offset be the index times four;
	write the integer R to address address of the rock stack for binary input files plus the offset;
	increment the index;
	set the number of rocks available for binary input files to the index.

Book "Binary Input File References" - unindexed

[Now that we support text mode, the extension title is a misnomer.  Oh well.]

To decide what number is a new binary input file reference for the synthetic file name (F - some text): (- glk_fileref_create_by_name(fileusage_Data|fileusage_BinaryMode,{F},0) -).
To decide what number is a new binary input file reference for the synthetic file name (F - some text) in text mode: (- glk_fileref_create_by_name(fileusage_Data,{F},0) -).

To decide what number is a new binary input file reference for the file name (F - some text):
	let the synthetic file name be a new synthetic text copied from F;
	let the result be a new binary input file reference for the synthetic file name synthetic file name;
	delete the synthetic text synthetic file name;
	decide on the result.

To decide what number is a new binary input file reference for the file name (F - some text) in text mode:
	let the synthetic file name be a new synthetic text copied from F;
	let the result be a new binary input file reference for the synthetic file name synthetic file name in text mode;
	delete the synthetic text synthetic file name;
	decide on the result.

To delete the binary input file reference (R - a number): (- glk_fileref_destroy({R}); -).

Book "Binary Input File Stream IDs" - unindexed

To decide what number is a new binary input file stream id for the binary input file reference (R - a number) and rock (RR - a number): (- glk_stream_open_file({R},filemode_Read,{RR}) -).
To decide what number is a new binary input file stream id for blorb resource (R - a number) and rock (RR - a number): (- glk_stream_open_resource({R},{RR}) -).
To close the binary input file stream with id (I - a number): (- glk_stream_close({I},0); -).

To decide what number is the current position in the binary input file stream with id (I - a number): (- glk_stream_get_position({I}) -).
To move the binary input file stream with id (I - a number) to its beginning position: (- glk_stream_set_position({I},0,seekmode_Start); -).
To move the binary input file stream with id (I - a number) to position (P - a number): (- glk_stream_set_position({I},{P},seekmode_Start); -).
To move the binary input file stream with id (I - a number) to its end position: (- glk_stream_set_position({I},0,seekmode_End); -).

To decide what number is the number of bytes filled after filling the standard buffer at address (B - a number) from the binary input file stream with id (I - a number): (- glk_get_buffer_stream({I},{B},BIF_BUFFER_LENGTH) -).

Book "Binary Input File Streams"

Chapter "The Binary Input File Stream Kind"

A binary input file stream is a kind of value.
A binary input file stream is an invalid binary input file stream.  [See the note in the book "Extension Information."]
The specification of a binary input file stream is "A binary input file stream is a data structure that represents the binary contents of a file.  The streams provided by this extension are specifically for use by Debug File Parsing.  As such, they treat files a little differently than Inform normally does: we have control over when a stream has a file open, and in particular we can keep a file open across multiple turns or even a save and restore. The sole use case also means that some operations traditionally supported by binary input streams are not present.  These streams are good for jumping to a known offset and reading data sequentially; they are a poor choice for random access operations, and they do not support writing at all."

Chapter "The Binary Input File Stream Structure" - unindexed

[Layout:
	4 bytes for the file name (for reopening, "<blorb-resource>" if the stream corresponds to a resource rather than a file)
	4 bytes for the resource number (for reopening, undefined if the stream corresponds to a file)
	4 bytes for the text mode flag (for reopening, undefined if the stream corresponds to a resource)
	4 bytes for the rock (for reopening)
	4 bytes for the stream id
	4 bytes for the stream position
	4 bytes for the end-of-stream position
	4 bytes for the next buffer offset to read
	4 bytes for the first invalid buffer offset
	BIF_BUFFER_LENGTH bytes for the buffer]
[As it may not be obvious what code is affected by this layout, the affected lines are tagged [BIF LAYOUT SENSITIVE].]

To decide what number is the size in memory of a binary input file stream: (- (36+BIF_BUFFER_LENGTH) -). [BIF LAYOUT SENSITIVE]

Chapter "Binary Input File Stream Construction and Destruction"

To decide what binary input file stream is a new binary input file stream (this is creating a new binary input file stream):
	let the result be a memory allocation of the size in memory of a binary input file stream bytes;
	zero 36 bytes at address result; [BIF LAYOUT SENSITIVE]
	decide on the result converted to a binary input file stream.

To decide what binary input file stream is a new binary input file stream in text mode (this is creating a new binary input file stream in text mode):
	let the result be a new binary input file stream;
	set the text mode flag in the result;
	decide on the result.

To delete (A - a binary input file stream) (this is deleting a binary input file stream):
	close A;
	free the memory allocation at address A converted to a number.

Chapter "Private Binary Input File Stream Accessors and Mutators" - unindexed

To write the file name (X - some text) to (A - a binary input file stream): (- llo_setInt({A},{X}); -). [BIF LAYOUT SENSITIVE]

To write the resource number (X - a number) to (A - a binary input file stream): (- llo_setField({A},1,{X}); -). [BIF LAYOUT SENSITIVE]

To reset the text mode flag in (A - a binary input file stream): (- llo_setField({A},2,0); -). [BIF LAYOUT SENSITIVE]
To set the text mode flag in (A - a binary input file stream): (- llo_setField({A},2,1); -). [BIF LAYOUT SENSITIVE]

To decide what number is the rock of (A - a binary input file stream): (- llo_getField({A},3) -). [BIF LAYOUT SENSITIVE]
To write the rock (X - a number) to (A - a binary input file stream): (- llo_setField({A},3,{X}); -). [BIF LAYOUT SENSITIVE]

To decide what number is the stream id of (A - a binary input file stream): (- llo_getField({A},4) -). [BIF LAYOUT SENSITIVE]
To write the stream id (X - a number) to (A - a binary input file stream): (- llo_setField({A},4,{X}); -). [BIF LAYOUT SENSITIVE]

To write the stream position (X - a number) to (A - a binary input file stream): (- llo_setField({A},5,{X}); -). [BIF LAYOUT SENSITIVE]

To write the end-of-stream position (X - a number) to (A - a binary input file stream): (- llo_setField({A},6,{X}); -). [BIF LAYOUT SENSITIVE]

To decide what number is the next buffer offset of (A - a binary input file stream): (- llo_getField({A},7) -). [BIF LAYOUT SENSITIVE]
To write the next buffer offset (X - a number) to (A - a binary input file stream): (- llo_setField({A},7,{X}); -). [BIF LAYOUT SENSITIVE]

To decide what number is the first invalid buffer offset of (A - a binary input file stream): (- llo_getField({A},8) -). [BIF LAYOUT SENSITIVE]
To write the first invalid buffer offset (X - a number) to (A - a binary input file stream): (- llo_setField({A},8,{X}); -). [BIF LAYOUT SENSITIVE]

To decide what number is the buffer address of (A - a binary input file stream): (- ({A}+36) -). [BIF LAYOUT SENSITIVE]

To clear position information in (A - a binary input file stream) (this is clearing stream position information):
	always check that A is open or else fail at clearing position information in a closed binary input file stream;
	let the binary input file stream id be the stream id of A;
	zero 16 bytes at address A converted to a number plus 20; [BIF LAYOUT SENSITIVE]
	move the binary input file stream with id binary input file stream id to its end position;
	write the end-of-stream position the current position in the binary input file stream with id binary input file stream id to A;
	move the binary input file stream with id binary input file stream id to its beginning position.

Include (-
	Global bif_transfer;
-) after "Definitions.i6t".

[This procedure is hot, so it gets hand optimization.  Note that A must not be a computed value.]
To advance the stream position and offset by (N - a number) in (A - a binary input file stream): (-
	@aload {A} 5 bif_transfer; ! stream position [BIF LAYOUT SENSITIVE]
	bif_transfer=bif_transfer+{N};
	@astore {A} 5 bif_transfer; ! stream position [BIF LAYOUT SENSITIVE]
	@aload {A} 7 bif_transfer; ! next buffer offset [BIF LAYOUT SENSITIVE]
	bif_transfer=bif_transfer+{N};
	@astore {A} 7 bif_transfer; ! next buffer offset [BIF LAYOUT SENSITIVE]
-).

Chapter "Public Binary Input File Stream Accessors and Mutators"

To decide what text is the file name of (A - a binary input file stream): (- llo_getInt({A}) -). [BIF LAYOUT SENSITIVE]

To decide what number is the resource number of (A - a binary input file stream): (- llo_getField({A},1) -). [BIF LAYOUT SENSITIVE]

To decide whether the text mode flag is set in (A - a binary input file stream): (- llo_getField({A},2) -). [BIF LAYOUT SENSITIVE]

Definition: a binary input file stream is open rather than closed if I6 condition "llo_getField((*1),4)" says so (it has a non-null stream id). [BIF LAYOUT SENSITIVE]

To decide what number is the stream position of (A - a binary input file stream): (- llo_getField({A},5) -). [BIF LAYOUT SENSITIVE]

To decide what number is the end-of-stream position of (A - a binary input file stream): (- llo_getField({A},6) -). [BIF LAYOUT SENSITIVE]

Chapter "Opening and Closing Binary Input File Streams"

Section "The Open Binary Input File Stream Linked List" - unindexed

The open binary input file stream linked list is a linked list that varies.

Section "Opening Binary Input File Streams"

To open (A - a binary input file stream) for the binary input file name (F - some text) (this is opening a binary input file stream):
	always check that A is not an invalid binary input file stream or else fail at opening an invalid binary input file stream for a file named F;
	always check that A is closed or else fail at opening a binary input file stream for a second file named F;
	let the binary input file reference be a number;
	if the text mode flag is set in A:
		now the binary input file reference is a new binary input file reference for the file name F;
	otherwise:
		now the binary input file reference is a new binary input file reference for the file name F in text mode;
	always check that the binary input file reference is not zero or else fail at using a null binary input file reference for the file named F;
	let the rock be a binary input file rock popped from the rock stack;
	let the binary input file stream id be a new binary input file stream id for the binary input file reference binary input file reference and rock rock;
	always check that the binary input file stream id is not zero or else fail at opening a binary input file stream for a file named F;
	write the file name F to A;
	write the rock rock to A;
	write the stream id binary input file stream id to A;
	clear position information in A;
	if the open binary input file stream linked list is an invalid linked list:
		now the open binary input file stream linked list is an empty linked list;
	push the key A onto the open binary input file stream linked list;
	delete the binary input file reference binary input file reference.

To open (A - a binary input file stream) for blorb resource (R - a number) (this is opening a binary input file stream for a blorb resource):
	always check that A is not an invalid binary input file stream or else fail at opening an invalid binary input file stream for blorb resource R;
	always check that A is closed or else fail at opening a binary input file stream for a second resource numbered R;
	let the rock be a binary input file rock popped from the rock stack;
	let the binary input file stream id be a new binary input file stream id for blorb resource R and rock rock;
	always check that the binary input file stream id is not zero or else fail at opening a binary input file stream for blorb resource R;
	write the file name "<blorb-resource>" to A;
	write the rock rock to A;
	write the stream id binary input file stream id to A;
	clear position information in A;
	if the open binary input file stream linked list is an invalid linked list:
		now the open binary input file stream linked list is an empty linked list;
	push the key A onto the open binary input file stream linked list.

Section "Reopening Binary Input File Streams" - unindexed

To reopen (A - a binary input file stream) (this is reopening a binary input file stream):
	always check that A is open or else fail at reopening a binary input file stream that isn't open;
	let the binary input file stream id be a number;
	if the file name of A is "<blorb-resource>":
		now the binary input file stream id is a new binary input file stream id for blorb resource the resource number of A and rock the rock of A;
	otherwise:
		let the binary input file reference be a number;
		if the text mode flag is set in A:
			now the binary input file reference is a new binary input file reference for the file name the file name of A;
		otherwise:
			now the binary input file reference is a new binary input file reference for the file name the file name of A in text mode;
		always check that the binary input file reference is not zero or else fail at using a null binary input file reference for the file named the file name of A;
		now the binary input file stream id is a new binary input file stream id for the binary input file reference binary input file reference and rock the rock of A;
		delete the binary input file reference binary input file reference;
	always check that the binary input file stream id is not zero or else fail at opening a binary input file stream for a file named the file name of A;
	write the stream id binary input file stream id to A;
	clear position information in A.

Section "Closing Binary Input File Streams"
	
To close (A - a binary input file stream) (this is closing a binary input file stream):
	if A is open:
		let the binary input file stream id be the stream id of A;
		close the binary input file stream with id binary input file stream id;
		return the binary input file rock the rock of A to the rock stack;
		write the stream id zero to A;
		remove the first occurrence of the key A from the open binary input file stream linked list.

Chapter "Stream Recovery"

Section "Stream Recovery Data Structures" - unindexed

The moribund stream id linked list is a linked list that varies.

Section "Stream Recovery Handlers"

[We can't actually do anything useful until the iteration is done; we must wait until the ``tie up loose ends'' phrase.  Here we would note the ids that have been invalidated, but we're going to conservatively invalidate all of them anyway; do nothing.]
[A Glulx zeroing-reference rule (this is the invalidate binary input file ids rule):
	do nothing.]

[Same here in that we can only note what to do, not do it.  Since we plan on invalidating and reopening for every stream, the streams left over from the last run all need to be closed.]
A Glulx resetting-streams rule (this is the associating a binary input file stream id with a stream given a rock rule):
	if the moribund stream id linked list is an invalid linked list:
		now the moribund stream id linked list is an empty linked list;
	if the rock current Glulx rock is for a binary input file:
		push the key the current Glulx rock-ref onto the moribund stream id linked list.

[Finally, we can act.  Two steps: close all of the old streams, and reopen the ones the story thinks should be open.]
A Glulx object-updating rule (this is the tying up loose ends after associating binary input file ids rule):
	if the moribund stream id linked list is an invalid linked list:
		now the moribund stream id linked list is an empty linked list;
	if the open binary input file stream linked list is an invalid linked list:
		now the open binary input file stream linked list is an empty linked list;
	while the moribund stream id linked list is not empty:
		let the stream id be a number key popped off of the moribund stream id linked list; [this line and the next must be separate because of Inform bug 770]
		close the binary input file stream with id stream id;
	repeat with the open binary input file stream running through the binary input file stream keys of the open binary input file stream linked list:
		reopen the open binary input file stream.

Section "Recovery Shielding" (for use with Glulx Runtime Instrumentation Framework by Brady Garvin)

[If we don't shield IdentifyGlkObject against instrumentation, it or one of its eventual callees might be called for the first time in an instrumented context.  Then GRIF would need to instrument the callee, possibly while the input streams that an instrumentation extension needs for debug information are still invalid or closed.]

To decide what number is the function address of the Glk object identifier: (- IdentifyGlkObject -).

A GRIF shielding rule (this is the shield the Glk object identifier against instrumentation to prevent debug information outages rule):
	shield the function address of the Glk object identifier against instrumentation.

Chapter "Scrolling"

[Scroll so that the next byte to be read is the first byte in the buffer.]
To scroll (A - a binary input file stream) (this is scrolling a binary input file stream):
	always check that A is open or else fail at scrolling a closed binary input file stream;
	let the binary input file stream id be the stream id of A;
	let the stream position be the stream position of A;
	move the binary input file stream with id binary input file stream id to position stream position;
	write the next buffer offset zero to A;
	let the buffer address be the buffer address of A;
	let the first invalid buffer offset be the number of bytes filled after filling the standard buffer at address buffer address from the binary input file stream with id binary input file stream id;
	write the first invalid buffer offset first invalid buffer offset to A.

[Scroll so that the given byte is the first byte in the buffer.]
To move (A - a binary input file stream) to stream position (P - a number) (this is moving a binary input file stream to a different position):
	write the stream position P to A;
	scroll A.

To move (A - a binary input file stream) to stream position (P - a number) expecting to read only (N - a number) byte/bytes (this is moving a binary input file stream to a different position with an expected read length):
	let the distance be P minus the stream position of A;
	advance the stream position and offset by the distance in A;
	expect A to read N bytes.

To expect (A - a binary input file stream) to read (N - a number) byte/bytes (this is expecting the number of bytes a binary input file stream will read):
	let the next buffer offset be the next buffer offset of A;
	let the limit be the first invalid buffer offset of A;
	decrease the limit by N;
	if the next buffer offset is less than zero or the next buffer offset is at least the limit:
		scroll A.

To decide what number is the address where the next (N - a number) byte/bytes is/are available in (A - a binary input file stream) (this is making bytes available from a binary input file stream):
	let the next buffer offset be the next buffer offset of A;
	let the first invalid buffer offset be the first invalid buffer offset of A;
	if the next buffer offset plus N is greater than the first invalid buffer offset:
		scroll A;
		now the next buffer offset is the next buffer offset of A;
		now the first invalid buffer offset is the first invalid buffer offset of A;
		always check that the next buffer offset plus N is at most the first invalid buffer offset or else fail at reading N bytes when the available bytes are insufficient;
	decide on the next buffer offset plus the buffer address of A.

To skip (N - a number) byte/bytes in (A - a binary input file stream) (this is skipping bytes in a binary input file stream):
	advance the stream position and offset by N in A;
	let the next buffer offset be the next buffer offset of A;
	let the first invalid buffer offset be the first invalid buffer offset of A;
	if the next buffer offset is at least the first invalid buffer offset:
		scroll A.

Chapter "Reading Numbers"

To decide what number is the next byte in (A - a binary input file stream) (this is reading a byte from a binary input file stream):
	let the result address be the address where the next one byte is available in A;
	advance the stream position and offset by one in A;
	decide on the byte at address result address.

To decide what number is the next short in (A - a binary input file stream) (this is reading a short from a binary input file stream):
	let the result address be the address where the next two bytes are available in A;
	advance the stream position and offset by two in A;
	decide on the short at address result address.

To decide what number is the next triple in (A - a binary input file stream) (this is reading a triple from a binary input file stream):
	let the result address be the address where the next three bytes are available in A;
	let the offset result address be the result address plus two;
	advance the stream position and offset by three in A;
	let the result be the short at address result address;
	now the result is the result shifted eight bits left;
	decide on the result plus the byte at address offset result address.

To decide what number is the next integer in (A - a binary input file stream) (this is reading an integer from a binary input file stream):
	let the result address be the address where the next four bytes are available in A;
	advance the stream position and offset by four in A;
	decide on the integer at address result address.

Chapter "Reading and Skipping Text"

Section "Measuring Distance to a Character Code"

Include (-
	[ bif_countBytesToCharacter binaryInputFileStream characterCode nextOffset arrayStart arraySize result;
		nextOffset=llo_getField(binaryInputFileStream,7); ! next buffer offset [BIF LAYOUT SENSITIVE]
		arrayStart=binaryInputFileStream+36+nextOffset; ! the buffer address + nextOffset [BIF LAYOUT SENSITIVE]
		arraySize=llo_getField(binaryInputFileStream,8)-nextOffset; ! first invalid buffer offset - nextOffset [BIF LAYOUT SENSITIVE]
		@linearsearch
			characterCode ! search for characterCode
			1             ! size of key in bytes
			arrayStart    ! search in this array
			1             ! size of structures in bytes
			arraySize     ! number of structures to search
			0             ! offset from the structure address to the key address
			4             ! flags (4 means return index)
			result;
		return result;
	];
-).

To decide what number is the number of bytes until character code (C - a number) in the buffer of (A - a binary input file stream): (- bif_countBytesToCharacter({A},{C}) -).

To decide what number is the number of bytes until character code (C - a number) in (A - a binary input file stream) (this is reading from a binary input file stream until a given character code):
	let the result be the number of bytes until character code C in the buffer of A;
	if the result is -1:
		scroll A;
		now the result is the number of bytes until character code C in the buffer of A;
		always check that the result is not -1 or else fail at reading up through character code C when the available bytes are insufficient;
	decide on the result.

Section "Skipping Text"

To skip the text in (A - a binary input file stream) up through character code (C - a number) (this is skipping bytes from a binary input file stream up through a given character code):
	let the byte count be the number of bytes until character code C in A;
	skip byte count plus one bytes in A.

To skip the text in (A - a binary input file stream) up through the next null terminator (this is skipping a null-terminated text in a binary input file stream):
	skip the text in A up through character code zero.

To skip the text in (A - a binary input file stream) up through the next newline (this is skipping a line in a binary input file stream):
	skip the text in A up through character code ten.

Section "Reading Text"

To decide what text is a new synthetic text extracted from (A - a binary input file stream) until character code (C - a number) (this is extracting text until a given character code from a binary input file stream):
	let the byte count be the number of bytes until character code C in A;
	let the next buffer offset be the next buffer offset of A;
	let the result address be the next buffer offset plus the buffer address of A;
	advance the stream position and offset by one plus the byte count in A;
	decide on a new synthetic text extracted from the byte count bytes at address result address.

To decide what text is a new permanent synthetic text extracted from (A - a binary input file stream) until character code (C - a number) (this is extracting permanent text until a given character code from a binary input file stream):
	let the byte count be the number of bytes until character code C in A;
	let the next buffer offset be the next buffer offset of A;
	let the result address be the next buffer offset plus the buffer address of A;
	advance the stream position and offset by one plus the byte count in A;
	decide on a new permanent synthetic text extracted from the byte count bytes at address result address.

To decide what text is a new synthetic text extracted from (A - a binary input file stream) until a null terminator (this is extracting null-terminated text from a binary input file stream):
	decide on a new synthetic text extracted from A until character code zero.

To decide what text is a new permanent synthetic text extracted from (A - a binary input file stream) until a null terminator (this is extracting permanent null-terminated text from a binary input file stream):
	decide on a new permanent synthetic text extracted from A until character code zero.

To decide what text is a new synthetic text extracted from (A - a binary input file stream) until a newline (this is extracting a line from a binary input file stream):
	let the result be a new synthetic text extracted from A until character code ten;
	let the end index be the length of the synthetic text the result;
	if the end index is not zero and the character code at index end index of the synthetic text the result is 13 [carriage return]:
		remove one character from the end of the synthetic text the result;
	decide on the result.

To decide what text is a new permanent synthetic text extracted from (A - a binary input file stream) until a newline (this is extracting a permanent line from a binary input file stream):
	let the result be a new permanent synthetic text extracted from A until character code ten;
	let the end index be the length of the synthetic text the result;
	if the end index is not zero and the character code at index end index of the synthetic text the result is 13 [carriage return]:
		remove one character from the end of the synthetic text the result;
	decide on the result.

Binary Input Files ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Binary Input Files is a support extension for Debug File Parsing.  (So, apart
from the notes in the Requirements, Limitations, and Bugs chapter, most authors
can safely ignore this documentation.)  It provides low-level access to buffered
Glk streams and allows these streams to remain open over several turns, properly
reopening them in case of a save/restore.

Details are in the following chapters.

Chapter: Usage

Section: Overview

A binary input file stream is a data structure that represents the binary
contents of a file.  The streams provided by this extension are specifically for
use by Debug File Parsing.  As such, they treat files a little differently than
Inform normally does: we have control over when a stream has a file open, and in
particular we can keep a file open across multiple turns or even a save and
restore.

The sole use case also means that some operations traditionally supported by
binary input streams are not present.  These streams are good for jumping to a
known offset and reading data sequentially; they are a poor choice for random
access operations, and they do not support writing at all.

Section: Creating and opening streams

To request a new, unopened stream, we ask for

	a new binary input file stream

Once we have an unopened stream, we can open it for a file with the phrase

	open (S - a binary input file stream) for the binary input file name (F - some text)

The file name must not contain substitutions or non-Latin-1 characters.  As
always, the interpreter has leave to mangle it and add a file extension if it
sees fit.  And for security reasons the interpreter controls the directory where
we look for the file.

If the file cannot be opened, Binary Input Files will terminate the story with
an error message.  Otherwise, the stream's position will be set to the beginning
of the file, ready for reading.

Section: Inspecting streams

We are always able to check whether a stream is open or closed by testing

	if (S - a binary input file stream) is open:
		....

or

	if (S - a binary input file stream) is closed:
		....

For open streams only we can ask for the file name:

	the file name of (S - a binary input file stream)

the current position within that file (the number of bytes between the beginning
position and the next byte that we will read):

	the stream position of (S - a binary input file stream)

and the size of the file, which is to say the first unreadable position (again in bytes):

	the end-of-stream position of (S - a binary input file stream)

Section: Moving within streams

We may move to an absolute position within a stream by writing

	move (S - a binary input file stream) to stream position (P - a number)

and if we know how much data we are going to read, we can give the extension a
hint to improve performance:

	move (S - a binary input file stream) to stream position (P - a number) expecting to read only (N - a number) byte/bytes

Hints can also be given on their own, either as

	expect (S - a binary input file stream) to read (N - a number) bytes

or as

	scroll (S - a binary input file stream)

where the latter means, more or less, "prepare to read a lot of data".

Relative movement is also an option, so long as it is in the forward direction.
The appropriate phrase is

	skip (N - a number) byte/bytes in (S - a binary input file stream)

where N must be nonnegative.

And in one way we can predicate our movement on the file contents, skipping
bytes until we have passed over a particular value (usually a Latin-1 character
code):

	skip the text in (S - a binary input file stream) up through character code (C - a number)

For character codes 0 (a null terminator) and 10 (a newline), we also have more
legible versions of the previous phrase:

	skip the text in (S - a binary input file stream) up through the next null terminator

	skip the text in (S - a binary input file stream) up through the next newline

Section: Reading raw data

To read binary data directly, we ask for

	the address where the next (N - a number) byte/bytes is/are available in (S - a binary input file stream)

So long as the stream remains untouched, its upcoming N bytes can be found at
that address and inspected with the phrases from Low-Level Operations.  But as
soon the stream moves those memory contents are subject to change.

Section: Reading numbers

To read a number, we can use one of four phrases, depending on the number of
bytes that we would like to read:

	the next byte in (S - a binary input file stream)

	the next short in (S - a binary input file stream)

	the next triple in (S - a binary input file stream)

	the next integer in (S - a binary input file stream)

These correspond to one, two, three, and four bytes respectively.  Multi-byte
words are read in big-endian order.  Reading advances the stream position past
the data that was read.

Section: Reading text

For Latin-1 data, we can allocate new text values whose contents are copied from
the file (see the extension Low-Level Text for details on synthetic text).  We
normally do so by reading characters until a particular one is encountered:

	a new synthetic text extracted from (S - a binary input file stream) until character code (C - a number)

The stream position passes over the character C, but it is not included in the
synthetic text.  As in skipping, the are slightly more legible phrases for
reading until a null terminator or newline:

	a new synthetic text extracted from (S - a binary input file stream) until a null terminator

and

	a new synthetic text extracted from (S - a binary input file stream) until a newline

(The latter also trims any trailing carriage return, which is useful
when the file uses Windows or mixed newlines.)

Permanent text is also supported; we need only insert the word "permanent" in
the phrase.  For instance,

	a new permanent synthetic text extracted from (S - a binary input file stream) until a newline

Section: Closing and destroying streams

Streams should be closed as soon as we are finished with a file, to ensure that
the pool of Glk rocks isn't depleted.  The phrase to use is

	close (S - a binary input file stream)

We can then reopen the stream with another file, or, if we do not need it
anymore, we should delete it to free up memory:

	delete (S - a binary input file stream)

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Binary Input Files is willing to keep files open across several turns, whereas
Inform will normally never do so.  This behavior adds complications to the
save/restore process: If Binary Input Files has a file open during a save, it
must be able to reopen that same file, unchanged, when the story is restored.
In most cases where it cannot, it will complain and terminate the story, but its
checks are not fool-proof, and you should not rely on this behavior.

In particular, you should not include Binary Input Files in a publicly released
story because you cannot prevent a player from changing a file between a save
and a restore.  Binary Input Files is only meant to be used in development
tools, such as the debugging extensions supported by Debug File Parsing.

Section: Compatibility with other extensions

Binary Input Files uses Glk rocks to keep track of the streams that it owns
across save/restore boundaries.  Unfortunately, there is no convention (that I
know of) for how extensions choose the rocks that they own.  Binary Input Files
will normally use rocks from -100 up through -85, a range that seems unclaimed
at the time of writing, but we can select a different range if there is a
conflict.  The chapter replacement

	*: Chapter "Modified Rock Range" (in place of Chapter "Rock Range" in Binary Input Files by Brady Garvin)
	
	Include (-
		Constant BIF_MINIMUM_ROCK = 400;
		Constant BIF_ROCK_COUNT = 50;
	-) after "Definitions.i6t".

for instance, will assign Binary Input Files the rocks 400 through 449 instead.
(If you are using an older version of Inform, 6G60 or earlier, the snippet above
might not display or paste correctly.  Instead, you should open the extension,
search for "Modified Rock Range", and copy and paste from there.)

Binary Input Files also replaces the I6 stub IdentifyGlkObject with a routine of
its own.  If other extensions try to do the same, you will receive error
messages from the I6 compiler.  Consult your local I6 guru (or the gurus on a
forum like http://www.intfiction.org/forum/) for a fix; the correction to make
depends on what the other extension is trying to do.  You can also send a bug
report as explained in the next chapter.

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

Binary Input Files was prepared as part of the Glulx Runtime Instrumentation
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

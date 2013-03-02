Version 1 of Debug File Parsing (for Glulx only) by Brady Garvin begins here.

"Loads debug information produced by the Inform compilers."

Include Compiler Version Checks by Brady Garvin.
Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include I6 Routine Names by Brady Garvin.
Include Punctuated Word Parsing Engine by Brady Garvin.
Include Human-Friendly Function Names by Brady Garvin.
Include Binary Input Files by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2012 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[We assume a single I6 source file.]
[We ignore column numbers, mostly because the client extensions don't need them, and also because the code here becomes simpler (and a tad faster starting up) when they aren't stored.  Also, accounting for their overflow is tricky business.]
[We use one-based line numbers throughout, even though zero-based would be a little more convenient.  Most text editors use a one-based numbering, so one-based is what we want to show to authors, and there are just too many opportunities for silly mistakes if we have to convert back and forth.]
[As a consequence, line number zero usually means ``no line at all.'']

[For each of the kinds defined by Glk Interception you will see a sentence like

	A routine record is an invalid routine record.

This bewildering statement actually sets up routine records as a qualitative value with default value the routine record at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on routine records.]

Chapter "Forced Use Options"

Include action creations in the debugging log.
Include assertions in the debugging log.
Include constructed plurals in the debugging log.
Include kind creations in the debugging log.
Include object creations in the debugging log.
Include rulebook compilation in the debugging log.
Include variable creations in the debugging log.

Chapter "Use Options"

Use a routine record hash table size of at least 2311 translates as (- Constant DFP_ROUTINE_HASH_SIZE={N}; -).
Use a source line record hash table size of at least 11213 translates as (- Constant DFP_SOURCE_LINE_HASH_SIZE={N}; -).
Use a sequence point hash table size of at least 11213 translates as (- Constant DFP_SEQUENCE_POINT_HASH_SIZE={N}; -).
Use a global record hash table size of at least 311 translates as (- Constant DFP_GLOBAL_HASH_SIZE={N}; -).
Use a memory stack variable record hash table size of at least 311 translates as (- Constant DFP_MSV_HASH_SIZE={N}; -).
Use a memory stack frame hash table size of at least 31 translates as (- Constant DFP_MEMORY_STACK_FRAME_HASH_SIZE={N}; -).
Use a debug plural hash table size of at least 1123 translates as (- Constant DFP_PLURAL_HASH_SIZE={N}; -).
Use a kind hash table size of at least 131 translates as (- Constant DFP_KIND_HASH_SIZE={N}; -).
Use a source line position hash table size of at least 11213 translates as (- Constant DFP_LINE_POSITION_HASH_SIZE={N}; -).
Use an object hash table size of at least 1123 translates as (- Constant DFP_OBJECT_HASH_SIZE={N}; -).

To decide what number is the routine record hash table size: (- DFP_ROUTINE_HASH_SIZE -).
To decide what number is the source line record hash table size: (- DFP_SOURCE_LINE_HASH_SIZE -).
To decide what number is the sequence point hash table size: (- DFP_SEQUENCE_POINT_HASH_SIZE -).
To decide what number is the global record hash table size: (- DFP_GLOBAL_HASH_SIZE -).
To decide what number is the memory stack variable hash table size: (- DFP_MSV_HASH_SIZE -).
To decide what number is the memory stack frame hash table size: (- DFP_MEMORY_STACK_FRAME_HASH_SIZE -).
To decide what number is the debug plural hash table size: (- DFP_PLURAL_HASH_SIZE -).
To decide what number is the kind hash table size: (- DFP_KIND_HASH_SIZE -).
To decide what number is the source line position hash table size: (- DFP_LINE_POSITION_HASH_SIZE -).
To decide what number is the object hash table size: (- DFP_OBJECT_HASH_SIZE -).

Use blorb resources in lieu of external debug files translates as (- Constant DFP_USE_BLORB; -).

Chapter "Other Options"

[These are not use options, but we treat them almost as if they were.]
The name of the symbolic link to the intermediate I6 file is some text that varies.
The name of the symbolic link to the debug information file is some text that varies.
The name of the symbolic link to the debugging log file is some text that varies.

Chapter "Rulebooks"

The debug file setup rules are [rulebook is] a rulebook.

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at loading debug files twice:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I was asked to load debug files a second time, but they can only be loaded once.[terminating the story]".

To fail at opening an unnamed debug information file:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I wasn't given the name of a symbolic link to the debug information file ([fixed letter spacing]gameinfo.dbg[variable letter spacing][warning type]).  Add a line like[line break][line break][fixed letter spacing]    The name of the symbolic link to the debug information file is 'debuginfo'.[variable letter spacing][warning type][line break][line break]to the source text.  (The i7grip download contains a JAR file that does this automatically.)[terminating the story]".

To fail at matching the header of the debug information file:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I need the debug information file to match the story, but the headers are different, so they can't possibly go together.[terminating the story]".

To fail at recognizing the debug information file's format:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]The debug information file appears to have the wrong format; the first magic number doesn't match my expectations.[terminating the story]".

To fail at recognizing the debug information file's version:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]The debug information file has a version number that is newer than any of the versions that I know about.[terminating the story]".

To fail at recognizing the record type (Y - a number):
	say "[low-level runtime failure in]Debug File Parsing[with explanation]The debug information file contains a record of type [Y converted to a number], but that isn't a valid record type for the version of the file format the file claims to use.[terminating the story]".

To fail at opening an unnamed intermediate I6 file:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I wasn't given the name of a symbolic link to the intermediate I6 file ([fixed letter spacing]gameinfo.dbg[variable letter spacing][warning type]).  Add a line like[line break][line break][fixed letter spacing]    The name of the symbolic link to the intermediate I6 file is 'debugI6'.[variable letter spacing][warning type][line break][line break]to the source text.  (The i7grip download contains a JAR file that does this automatically.)[terminating the story]".

To fail at handling a second I6 source file named (F - some text):
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I assume that every project is reduced to a single I6 source file before the final compilation.  But the debug information file mentions at least one other source of I6 code, '[F converted to some text]', and I'm not prepared to handle it.[terminating the story]".

To fail at finding a cached line position for the I6 line number (L - a number):
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I should have a cached stream position for the I6 line number [L converted to a number], but I can't find it.  Maybe the I6 source file doesn't match this story?[terminating the story]".

To fail at keeping routine records in order:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I expected that at most the last routine on a line could extend beyond that line, but my bookkeeping says otherwise.[terminating the story]".

To fail at opening an unnamed debugging log file:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I wasn't given the name of a symbolic link to the debugging log file ([fixed letter spacing]Debug log.txt[variable letter spacing][warning type]).  Add a line like[line break][line break][fixed letter spacing]    The name of the symbolic link to the debugging log file is 'debuglog'.[variable letter spacing][warning type][line break][line break]to the source text.  (The i7grip download contains a JAR file that does this automatically.)[terminating the story]".

To fail at finding a reference point for finding the declaration of I7 globals:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I tried to find the declaration of the I6 array [fixed letter spacing]Global_Vars[variable letter spacing], which stores I7 global variables.  To do so, I normally work my way backwards from the kind information for table columns, but because I couldn't find the latter, I had no way to locate the former.[terminating the story]".

To fail at finding the base address for I6 globals:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I tried to find the location of I6 globals in memory, a location that should exist for all story files, but the debug information files never told me where it is.[terminating the story]".

To fail at associating I7 object names with object numbers:
	say "[low-level runtime failure in]Debug File Parsing[with explanation]I tried to associate I7 object names with object numbers, but found more object names than there are objects in the object tree.  My parsing of the debug information must be wrong.[terminating the story]".

Book "Data Structures"

Chapter "Routine Records"

Section "The Routine Record Kind"

A routine record is a kind of value.
A routine record is an invalid routine record.  [See the note in the book "Extension Information."]
The specification of a routine record is "A routine record represents everything that Debug File Parsing knows about a routine."

Section "The Routine Record Structure" - unindexed

[Layout:
	4 bytes for the function address
	4 bytes for the local count [-1 if the local count and names have not been loaded]
	64 bytes for the I6 local names [null if the local count and names have not been loaded, "<invalid-local-#>" for nonexistent locals]
	64 bytes for the sample I7 local names [null if the local count and names have not been loaded, "<invalid-local-#>" for nonexistent or non-I7 locals]
	64 bytes for the I7 local kind names [null if the I7 locals have not been loaded, "<no kind>" for nonexistent locals and locals without kinds]
	4 bytes for the source version [zero if the source language has not been determined, six for I6, seven for I7]
	4 bytes for the beginning stream position
	4 bytes for the sequence point stream position
	4 bytes for the end stream position
	4 bytes for the preamble line number [a line number for the I6 source, zero if the source version has not been set to seven]
	4 bytes for the beginning line number [a line number for the I6 source, zero if there are no lines]
	4 bytes for the end line number [likewise; note that the beginning and end line numbers are adjusted so that the beginning is inclusive, but the end is exclusive]
	4 bytes for the sequence point linked list [an invalid linked list if the sequence points have not been loaded]
	4 bytes for the sequence point linked list tail [an invalid linked list tail if the sequence points have not been loaded]]

[All stream positions are in the debug information file, not the I6 source.]

To decide what number is the assumed maximum local count: (- 16 -).
To decide what number is the size of a routine record: (- 236 -).

Section "Routine Record Construction" - unindexed

To decide what routine record is a new routine record with function address (A - a number) and beginning line number (N - a number) and beginning stream position (P - a number):
	let the result be a permanent memory allocation of the size of a routine record bytes converted to a routine record;
	zero the size of a routine record bytes at address result converted to a number;
	write the function address A to the result;
	write the local count -1 to the result;
	write the beginning stream position P to the result;
	write the beginning line number N to the result;
	write the sequence point linked list an invalid permanent linked list to the result;
	write the sequence point linked list tail an invalid permanent linked list tail to the result;
	decide on the result.

Section "Private Routine Record Accessors and Mutators" - unindexed

To write the function address (X - a number) to (A - a routine record): (- llo_setInt({A},{X}); -).

To decide what number is the possibly invalid local count of (A - a routine record): (- llo_getField({A},1) -).
To write the local count (X - a number) to (A - a routine record): (- llo_setField({A},1,{X}); -).

To decide what text is the possibly invalid I6 local name number (I - a number) of (A - a routine record): (- llo_getField({A},2+{I}) -).
To write (X - some text) to I6 local name number (I - a number) of (A - a routine record): (- llo_setField({A},2+{I},{X}); -).

To decide what text is the possibly invalid sample I7 local name number (I - a number) of (A - a routine record): (- llo_getField({A},18+{I}) -).
To write (X - some text) to sample I7 local name number (I - a number) of (A - a routine record): (- llo_setField({A},18+{I},{X}); -).

To decide what text is the possibly invalid I7 local kind name number (I - a number) of (A - a routine record): (- llo_getField({A},34+{I}) -).
To write (X - some text) to I7 local kind name number (I - a number) of (A - a routine record): (- llo_setField({A},34+{I},{X}); -).

To decide what number is the possibly invalid source version of (A - a routine record): (- llo_getField({A},50) -).
To write the source version (X - a number) to (A - a routine record): (- llo_setField({A},50,{X}); -).

To decide what number is the beginning stream position of (A - a routine record): (- llo_getField({A},51) -).
To write the beginning stream position (X - a number) to (A - a routine record): (- llo_setField({A},51,{X}); -).

To decide what number is the sequence point stream position of (A - a routine record): (- llo_getField({A},52) -).
To write the sequence point stream position (X - a number) to (A - a routine record): (- llo_setField({A},52,{X}); -).

To decide what number is the end stream position of (A - a routine record): (- llo_getField({A},53) -).
To write the end stream position (X - a number) to (A - a routine record): (- llo_setField({A},53,{X}); -).

To decide what number is the possibly invalid preamble line number of (A - a routine record): (- llo_getField({A},54) -).
To write the preamble line number (X - a number) to (A - a routine record): (- llo_setField({A},54,{X}); -).

To write the beginning line number (X - a number) to (A - a routine record): (- llo_setField({A},55,{X}); -).

To write the end line number (X - a number) to (A - a routine record): (- llo_setField({A},56,{X}); -).

To decide what permanent linked list is the possibly invalid sequence point linked list of (A - a routine record): (- ({A}-->57) -).
To write the sequence point linked list (X - a permanent linked list) to (A - a routine record): (- llo_setField({A},57,{X}); -).

To decide what permanent linked list tail is the possibly invalid sequence point linked list tail of (A - a routine record): (- ({A}-->58) -).
To write the sequence point linked list tail (X - a permanent linked list tail) to (A - a routine record): (- llo_setField({A},58,{X}); -).

Section "Direct Public Routine Record Accessors"

To decide what number is the function address of (A - a routine record): (- llo_getInt({A}) -).

To decide what number is the beginning line number of (A - a routine record): (- llo_getField({A},55) -).

To decide what number is the end line number of (A - a routine record): (- llo_getField({A},56) -).

Section "Lazy Public Routine Record Accessors"

To decide what number is the local count of (A - a routine record):
	let the result be the possibly invalid local count of A;
	if the result is not -1:
		decide on the result;
	load I6 locals into A;
	decide on the possibly invalid local count of A.

To decide what text is I6 local name number (I - a number) of (A - a routine record):
	let the result be the possibly invalid I6 local name number I of A;
	if the result is not zero converted to a text:
		decide on the result;
	load I6 locals into A;
	decide on the possibly invalid I6 local name number I of A.

To decide what text is sample I7 local name number (I - a number) of (A - a routine record):
	let the result be the possibly invalid sample I7 local name number I of A;
	if the result is not zero converted to a text:
		decide on the result;
	load I7 locals into A;
	decide on the possibly invalid sample I7 local name number I of A.

To decide what text is I7 local kind name number (I - a number) of (A - a routine record):
	let the result be the possibly invalid I7 local kind name number I of A;
	if the result is not zero converted to a text:
		decide on the result;
	load I7 kinds into A;
	decide on the possibly invalid I7 local kind name number I of A.

To decide what number is the source version of (A - a routine record):
	let the result be the possibly invalid source version of A;
	if the result is not zero:
		decide on the result;
	load the source version and preamble line number into A;
	decide on the possibly invalid source version of A.

To decide what number is the preamble line number of (A - a routine record):
	let the discarded value be the source version of A;
	decide on the possibly invalid preamble line number of A.

[We intentionally return an r-value, not an l-value.]
To decide what permanent linked list is the sequence point linked list of (A - a routine record):
	let the result be the possibly invalid sequence point linked list of A;
	if the result is not an invalid permanent linked list:
		decide on the result;
	load the sequence point list into A;
	decide on the possibly invalid sequence point linked list of A.

Chapter "Source Line Records"

Section "The Source Line Record Kind"

A source line record is a kind of value.
A source line record is an invalid source line record.  [See the note in the book "Extension Information."]
The specification of a source line record is "A source line record represents everything that Debug File Parsing knows about a single line in the intermediate I6 file auto.inf."

Section "The Source Line Record Structure" - unindexed

[Layout:
	4 bytes for the line number
	4 bytes for the I6
	4 bytes for the I7 [null if the I7 has not yet been determined, the empty string if we have determined that there is no I7 on this line]
	4 bytes for the I7 indentation [zero if the I7 has not yet been determined, but possibly zero anyway]
	4 bytes for the I7 coda flag [false if the I7 has not yet been determined, but usually false anyway (the coda flag is true when we are still in a routine but past the end of the last I7 line's translation)]
	4 bytes for the routine record linked list
	4 bytes for the sequence point linked list [an invalid permanent linked list if the sequence points have not yet been determined]
	64 bytes for the I7 local names [null if the I7 has not yet been determined, "<invalid-local-#>" for nonexistent locals and locals out of scope]]

To decide what number is the size of a source line record: (- 92 -).

Section "Source Line Record Construction" - unindexed

To decide what source line record is a new source line record for line number (N - a number) and the I6 (T - some text) and the routine record list (R - a permanent linked list):
	let the result be a permanent memory allocation of the size of a source line record bytes converted to a source line record;
	zero the size of a source line record bytes at address result converted to a number;
	write the line number N to the result;
	write the I6 T to the result;
	write the routine record list R to the result;
	write the sequence point linked list an invalid permanent linked list to the result;
	decide on the result.

Section "Private Source Line Record Accessors and Mutators" - unindexed

To write the line number (X - a number) to (A - a source line record): (- llo_setInt({A},{X}); -).

To write the I6 (X - some text) to (A - a source line record): (- llo_setField({A},1,{X}); -).

To decide what text is the possibly invalid I7 of (A - a source line record): (- llo_getField({A},2) -).
To write the I7 (X - some text) to (A - a source line record): (- llo_setField({A},2,{X}); -).

To decide what number is the possibly invalid I7 indentation of (A - a source line record): (- llo_getField({A},3) -).
To write the I7 indentation (X - a number) to (A - a source line record): (- llo_setField({A},3,{X}); -).

To decide whether the possibly invalid I7 coda flag is set in (A - a source line record): (- llo_getField({A},4) -).
To set the I7 coda flag in (A - a source line record): (- llo_setField({A},4,1); -).

To write the routine record list (X - a permanent linked list) to (A - a source line record): (- llo_setField({A},5,{X}); -).

To decide what permanent linked list is the possibly invalid sequence point linked list of (A - a source line record): (- ({A}-->6) -).
To write the sequence point linked list (X - a permanent linked list) to (A - a source line record): (- llo_setField({A},6,{X}); -).

To decide what text is the possibly invalid I7 local name number (I - a number) of (A - a source line record): (- llo_getField({A},7+{I}) -).
To write (X - some text) to I7 local name number (I - a number) of (A - a source line record): (- llo_setField({A},7+{I},{X}); -).

Section "Direct Public Source Line Record Accessors"

To decide what number is the line number of (A - a source line record): (- llo_getInt({A}) -).

To decide what text is the I6 of (A - a source line record): (- llo_getField({A},1) -).

To decide what permanent linked list is the routine record list of (A - a source line record): (- ({A}-->5) -).

To decide what routine record is the sole routine record of (A - a source line record):
	let the routine record list be the routine record list of A;
	if the routine record list is unit:
		decide on the routine record key of the routine record list converted to a permanent linked list vertex;
	decide on an invalid routine record.

Section "Lazy Public Source Line Record Accessors"

To decide what text is the I7 of (A - a source line record):
	let the result be the possibly invalid I7 of A;
	if the result is not zero converted to a text:
		decide on the result;
	load I7 into A;
	decide on the possibly invalid I7 of A.

To decide what number is the I7 indentation of (A - a source line record):
	let the discarded value be the I7 of A;
	decide on the possibly invalid I7 indentation of A.

To decide whether the I7 coda flag is set in (A - a source line record):
	let the discarded value be the I7 of A;
	decide on whether or not the possibly invalid I7 coda flag is set in A.

To decide what permanent linked list is the sequence point linked list of (A - a source line record):
	let the result be the possibly invalid sequence point linked list of A;
	if the result is not an invalid permanent linked list:
		decide on the result;
	load sequence points into A;
	decide on the possibly invalid sequence point linked list of A.

To decide what text is I7 local name number (I - a number) of (A - a source line record):
	let the result be the possibly invalid I7 local name number I of A;
	if the result is not zero converted to a text:
		decide on the result;
	load I7 locals into A;
	decide on the possibly invalid I7 local name number I of A.

Chapter "Global Records"

Section "The Global Record Kind"

A global record is a kind of value.
A global record is an invalid global record.  [See the note in the book "Extension Information."]
The specification of a global record is "A global record represents everything that Debug File Parsing knows about a global variable---either a 'true' I6 global or an I7 global stored in the Global_Vars array."

Section "The Global Record Structure" - unindexed

[Layout:
	4 bytes for the global index [either an I6 index (into the globals space) or an I7 index (into the Global_Vars array)]
	4 bytes for the address [-2 for an I6 global (in which case scale and shift the (I6) global index), -1 if the address has not yet been determined, zero if an address cannot be found]
	4 bytes for the human-friendly name
	4 bytes for the kind name]

To decide what number is the size of a global record: (- 16 -).

Section "Global Record Construction" - unindexed

To decide what global record is a new I7 global record with index (I - a number) and human-friendly name (T - some text) and kind name (K - some text):
	let the result be a permanent memory allocation of the size of a global record bytes converted to a global record;
	write the global index I to the result;
	write the address -1 to the result;
	write the human-friendly name T to the result;
	write the kind name K to the result;
	decide on the result.

To decide what global record is a new I6 global record with index (I - a number) and human-friendly name (T - some text):
	let the result be a permanent memory allocation of the size of a global record bytes converted to a global record;
	write the global index I to the result;
	write the address -2 to the result;
	write the human-friendly name T to the result;
	write the kind name "<no kind>" to the result;
	decide on the result.

Section "Private Global Record Accessors and Mutators"

To write the global index (X - a number) to (A - a global record): (- llo_setInt({A},{X}); -).

To decide what number is the possibly invalid address of (A - a global record): (- llo_getField({A},1) -).
To write the address (X - a number) to (A - a global record): (- llo_setField({A},1,{X}); -).

To write the human-friendly name (X - some text) to (A - a global record): (- llo_setField({A},2,{X}); -).

To write the kind name (X - some text) to (A - a global record): (- llo_setField({A},3,{X}); -).

Section "Direct Public Global Record Accessors"

To decide what number is the global index of (A - a global record): (- llo_getInt({A}) -).

To decide what text is the human-friendly name of (A - a global record): (- llo_getField({A},2) -).

To decide what text is the kind name of (A - a global record): (- llo_getField({A},3) -).

To decide what number is the source version of (A - a global record):
	if the possibly invalid address of A is -2:
		decide on six;
	decide on seven.

Section "Uninstrumented Global Record Address Accessor" (for use without Glulx Runtime Instrumentation Framework by Brady Garvin)

To decide what number is the address of (A - a global record):
	let the result be the possibly invalid address of A;
	if the result is:
		-- -1:
			load addresses into the global records;
			decide on the possibly invalid address of A;
		-- -2:
			always check that the base address for I6 globals is not zero or else fail at finding the base address for I6 globals;
			decide on four times the global index of A plus the base address for I6 globals;
		-- otherwise:
			decide on the result.

Section "Instrumented Global Record Address Accessor" (for use with Glulx Runtime Instrumentation Framework by Brady Garvin)

To decide what number is the address of (A - a global record):
	let the result be the possibly invalid address of A;
	if the result is:
		-- -1:
			load addresses into the global records;
			decide on the possibly invalid address of A;
		-- -2:
			always check that the base address for I6 globals is not zero or else fail at finding the base address for I6 globals;
			let the index be the global index of A;
			if the index is less than the variable count of the temporary space:
				decide on four times the index plus the address of the alternative temporary space;
			decide on four times the index plus the base address for I6 globals;
		-- otherwise:
			decide on the result.

Chapter "Memory Stack Variable Records"

Section "The Memory Stack Variable Record Kind"

A memory stack variable record is a kind of value.
A memory stack variable record is an invalid memory stack variable record.  [See the note in the book "Extension Information."]
The specification of a memory stack variable record is "A memory stack variable record represents everything that Debug File Parsing knows about a rulebook, activity, or action variable."

Section "The Memory Stack Variable Record Structure" - unindexed

[Layout:
	4 bytes for the memory stack identifier [defined by Inform as a rulebook number for rulebook variables, 10000 plus the activity number (that is, the zero-based index in creation order) for activity variables, or 20000 plus the action number (again, the zero-based index in creation order) for action variables; we use -1 for unresolved rulebook variables, -10001, -20001 for unresolved action variables]
	4 bytes for the memory stack offset [the zero-based index of the variable among all variables sharing the same identifier]
	4 bytes for the owner name [the name of the owning rulebook, activity, or action]
	4 bytes for the human-friendly name
	4 bytes for the kind name]

To decide what number is the size of a memory stack variable record: (- 20 -).

Section "Memory Stack Variable Record Construction" - unindexed

To decide what memory stack variable record is a new rulebook variable record for variable (I - a number) owned by (O - some text) with human-friendly name (T - some text) and kind name (K - some text):
	let the result be a permanent memory allocation of the size of a memory stack variable record bytes converted to a memory stack variable record;
	write the memory stack identifier -1 to the result;
	write the memory stack offset I to the result;
	write the owner name O to the result;
	write the human-friendly name T to the result;
	write the kind name K to the result;
	decide on the result.

To decide what memory stack variable record is a new activity variable record for variable (I - a number) owned by (O - some text) with human-friendly name (T - some text) and kind name (K - some text):
	let the result be a permanent memory allocation of the size of a memory stack variable record bytes converted to a memory stack variable record;
	write the memory stack identifier -10001 to the result;
	write the memory stack offset I to the result;
	write the owner name O to the result;
	write the human-friendly name T to the result;
	write the kind name K to the result;
	decide on the result.

To decide what memory stack variable record is a new action variable record for variable (I - a number) owned by (O - some text) with human-friendly name (T - some text) and kind name (K - some text):
	let the result be a permanent memory allocation of the size of a memory stack variable record bytes converted to a memory stack variable record;
	write the memory stack identifier -20001 to the result;
	write the memory stack offset I to the result;
	write the owner name O to the result;
	write the human-friendly name T to the result;
	write the kind name K to the result;
	decide on the result.

Section "Private Memory Stack Variable Record Accessors and Mutators"

To decide what number is the possibly invalid memory stack identifier of (A - a memory stack variable record): (- llo_getInt({A}) -).
To write the memory stack identifier (X - a number) to (A - a memory stack variable record): (- llo_setInt({A},{X}); -).

To write the memory stack offset (X - a number) to (A - a memory stack variable record): (- llo_setField({A},1,{X}); -).

To write the owner name (X - some text) to (A - a memory stack variable record): (- llo_setField({A},2,{X}); -).

To write the human-friendly name (X - some text) to (A - a memory stack variable record): (- llo_setField({A},3,{X}); -).

To write the kind name (X - some text) to (A - a memory stack variable record): (- llo_setField({A},4,{X}); -).

Section "Direct Public Memory Stack Variable Record Accessors"

To decide what number is the memory stack offset of (A - a memory stack variable record): (- llo_getField({A},1) -).

To decide what text is the owner name of (A - a memory stack variable record): (- llo_getField({A},2) -).

To decide what text is the human-friendly name of (A - a memory stack variable record): (- llo_getField({A},3) -).

To decide what text is the kind name of (A - a memory stack variable record): (- llo_getField({A},4) -).

Section "Inline Definitions for Lazy Public Memory Stack Variable Record Accessors" - unindexed

To decide what number is the memory stack top address: (- (MStack+(4*MStack_Top)) -).
To decide what number is the memory stack bottom address: (- MStack -).

Section "Lazy Public Memory Stack Variable Record Accessors"

To decide what number is the memory stack identifier of (A - a memory stack variable record):
	let the result be the possibly invalid memory stack identifier of A;
	if the result is:
		-- -1:
			now the result is the first number value matching the synthetic textual key the owner name of A in the rulebook creation hash table or -1 if there are no matches;
			write the memory stack identifier the result to A;
		-- -10001:
			now the result is 10000 plus the first number value matching the synthetic textual key the owner name of A in the activity creation hash table or -20001 if there are no matches;
			write the memory stack identifier the result to A;
		-- -20001:
			now the result is 20000 plus the first number value matching the synthetic textual key the owner name of A in the action creation hash table or -40001 if there are no matches;
			write the memory stack identifier the result to A;
	decide on the result.

To decide what number is the current address of (A - a memory stack variable record):
	let the stack address be the memory stack top address;
	let the previous stack address be the stack address;
	let the seen hash table be a new hash table with the memory stack frame hash table size buckets;
	insert the key the stack address into the seen hash table;
	if the stack address is a invalid integer address or the stack address is less than the memory stack bottom address:
		delete the seen hash table;
		decide on zero;
	repeat until a break:
		let the delta be the integer at address the stack address;
		if the delta is zero:
			delete the seen hash table;
			decide on zero;
		now the previous stack address is the stack address;
		increase the stack address by four times the delta;
		if the seen hash table contains the key the stack address:
			delete the seen hash table;
			decide on zero;
		insert the key the stack address into the seen hash table;
		let the check address be the stack address plus four;
		if the check address is a invalid integer address or the stack address is less than the memory stack bottom address:
			delete the seen hash table;
			decide on zero;
		if the integer at address check address is the memory stack identifier of A:
			delete the seen hash table;
			let the result be the stack address plus eight plus four times the memory stack offset of A;
			if the result is at least the previous stack address:
				decide on zero;
			decide on the result.

Chapter "Permanent Hash Tables and Other Singletons" - unindexed

[Maps function addresses to routine records]
The routine record hash table is a permanent hash table that varies.

[A list of the above key-value pairs, sorted by stream position for the benefit of Glk libraries slower at file I/O.]
The routine record list is a permanent linked list that varies.
The routine record list tail is a permanent linked list tail that varies.

[Maps one-based I6 line numbers to routine records whose routines begin on those lines]
The routine beginning hash table is a permanent hash table that varies.

[Maps one-based I6 line numbers to source line records]
The source line record hash table is a permanent hash table that varies.

[Maps instruction addresses (only for instructions that begin at a sequence point) to routine records]
The sequence point routine record hash table is a permanent hash table that varies.

[Maps instruction addresses (only for instructions that begin at a sequence point) to one-based I6 line numbers (which are negated when we have made sure that any relocation has taken place)]
The sequence point line number hash table is a permanent hash table that varies.

[The base address for I6 globals]
The base address for I6 globals is a number that varies.

[The number of entries in the following hash table]
The I7 global count is a number that varies.

[Maps I7 global indices to global records]
The I7 global record hash table is a permanent hash table that varies.

[Maps canonical global names to global records]
The global record lookup hash table is a permanent hash table that varies.

[Counts the total number of entries in the next two hash tables]
The excess kind counter is a number that varies.  The excess kind counter is zero.

[Maps kind-of-value names to a base kind code (the values are wrong until will finish processing the debugging log)]
The kind-of-value hash table is a permanent hash table that varies.

[Maps kind-of-object names to a base kind code (the values are wrong until will finish processing the debugging log)]
The kind-of-object hash table is a permanent hash table that varies.

[Maps singular source text names to plural source text names]
The debug plural hash table is a permanent hash table that varies.

[Maps rulebook names to their next available memory stack variable offsets]
The rulebook variable offset hash table is a permanent hash table that varies.

[Maps activity names to their next available memory stack variable offsets]
The activity variable offset hash table is a permanent hash table that varies.

[Maps action names to their next available memory stack variable offsets]
The action variable offset hash table is a permanent hash table that varies.

[Counts the total number of entries in the next hash table]
The rulebook counter is a number that varies.  The rulebook counter is zero.

[Maps rulebook names to their creation indices]
The rulebook creation hash table is a permanent hash table that varies.

[Counts the total number of entries in the next hash table]
The activity counter is a number that varies.  The activity counter is zero.

[Maps activity names to their creation indices]
The activity creation hash table is a permanent hash table that varies.

[Counts the total number of entries in the next hash table]
The action counter is a number that varies.  The action counter is zero.

[Maps action names to their creation indices]
The action creation hash table is a permanent hash table that varies.

[Maps canonical memory stack variable names to memory stack variable records]
The memory stack variable record lookup hash table is a permanent hash table that varies.

[Counts the total number of entries that *could be* in the next hash table (anonymous objects aren't inserted, but they are counted)]
The object counter is a number that varies.  The object counter is zero.

[Maps source text names for objects to object numbers (based on a traversal of the pristine tree)]
The object number lookup hash table is a permanent hash table that varies.

[Maps authorial object numbers to object addresses]
The object address lookup hash table is a permanent hash table that varies.

A first debug file setup rule (this is the allocate permanent hash tables for storing debug information rule):
	now the routine record hash table is a new permanent hash table with the routine record hash table size buckets;
	now the routine record list is an empty permanent linked list;
	now the routine record list tail is an empty permanent linked list's tail;
	now the routine beginning hash table is a new permanent hash table with the routine record hash table size buckets;
	now the source line record hash table is a new permanent hash table with the source line record hash table size buckets;
	now the sequence point routine record hash table is a new permanent hash table with the sequence point hash table size buckets;
	now the sequence point line number hash table is a new permanent hash table with the sequence point hash table size buckets;
	now the I7 global record hash table is a new permanent hash table with the global record hash table size buckets;
	now the global record lookup hash table is a new permanent hash table with the global record hash table size buckets;
	now the kind-of-value hash table is a new permanent hash table with the kind hash table size buckets;
	now the kind-of-object hash table is a new permanent hash table with the kind hash table size buckets;
	now the debug plural hash table is a new permanent hash table with the debug plural hash table size buckets;
	now the rulebook variable offset hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the activity variable offset hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the action variable offset hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the rulebook creation hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the activity creation hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the action creation hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the memory stack variable record lookup hash table is a new permanent hash table with the memory stack variable hash table size buckets;
	now the object number lookup hash table is a new permanent hash table with the object hash table size buckets;
	now the object address lookup hash table is a new permanent hash table with the object hash table size buckets.

Section "Lazy Singleton Accessors"

To decide what routine record is the routine record for (F - a sayable value):
	decide on the first routine record value matching the key the function address of F in the routine record hash table or an invalid routine record if there are no matches.

To decide what linked list is a new list of routine records for beginning line number (N - a number):
	let the result be an empty linked list;
	repeat with the routine record running through the routine record values matching the key N in the routine beginning hash table:
		push the key the routine record onto the result;
	decide on the result.

To decide what source line record is the source line record for line number (N - a number):
	let the result be the first source line record value matching the key N in the source line record hash table or an invalid source line record if there are no matches;
	if the result is not an invalid source line record or N is zero:
		decide on the result;
	load I6 line number N;
	decide on the first source line record value matching the key N in the source line record hash table or an invalid source line record if there are no matches.

Definition: a number (called A) is a sequence point if the sequence point routine record hash table contains the key A.

To decide what routine record is the routine record owning the sequence point (S - a number):
	decide on the first routine record value matching the key S in the sequence point routine record hash table or an invalid routine record if there are no matches.

To decide what number is the I6 line number for the sequence point (S - a number):
	let the linked list vertex be the first match for the key S in the sequence point line number hash table;
	if the linked list vertex is null:
		decide on zero;
	let the result be the number value of the linked list vertex;
	if the result is less than zero:
		decide on zero minus the result;
	now the result is the relocation of the sequence point S from the line number the result;
	write the value zero minus the result to the linked list vertex;
	decide on the result.

To decide what number is the I6 line number for the sequence point (S - a number) in column number (C - a number):
	let the linked list vertex be the first match for the key S in the sequence point line number hash table;
	if the linked list vertex is null:
		decide on zero;
	let the result be the number value of the linked list vertex;
	if the result is less than zero:
		decide on zero minus the result;
	now the result is the relocation of the sequence point S from the line number the result and the column number C;
	write the value zero minus the result to the linked list vertex;
	decide on the result.

To decide what number is the I7 line number for the sequence point (S - a number) in the routine record (R - a routine record):
	let the beginning line number be the beginning line number of R;
	let the end line number be the end line number of R;
	let the result be the I6 line number for the sequence point S;
	if the result is less than the beginning line number or the result is at least the end line number:
		decide on zero;
	let the source line record be the source line record for line number the result;
	unless the I7 coda flag is set in the source line record:
		while the result is at least the beginning line number:
			now the source line record is the source line record for line number the result;
			unless the I7 of the source line record is empty:
				decide on the result;
			decrement the result;
	decide on the preamble line number of R.

[We don't ever use this internally.  But other extension authors might want it.]
To decide what number is the I7 line number for the sequence point (S - a number):
	let the routine record be the routine record owning the sequence point S;
	if the routine record is an invalid routine record:
		decide on zero;
	decide on the I7 line number for the sequence point S in the routine record the routine record.

To decide what global record is the global record for I7 global index (I - a number):
	decide on the first global record value matching the key I in the I7 global record hash table or an invalid global record if there are no matches.

To decide what linked list is a new list of global records matching the global name (T - some text):
	let the result be an empty linked list;
	repeat with the global record running through the global record values matching the textual key T in the global record lookup hash table:
		push the key the global record onto the result;
	decide on the result.

To decide what linked list is a new list of memory stack variable records matching the memory stack variable name (T - some text):
	let the result be an empty linked list;
	repeat with the memory stack variable record running through the memory stack variable record values matching the textual key T in the memory stack variable record lookup hash table:
		push the key the memory stack variable record onto the result;
	decide on the result.

To decide what linked list is a new list of object addresses matching the object name (T - some text):
	let the result be an empty linked list;
	repeat with the object number running through the number values matching the textual key T in the object number lookup hash table:
		let the object address be the first number value matching the key the object number in the object address lookup hash table or zero if there are no matches;
		push the key the object address onto the result;
	decide on the result.

To decide what text is the debug plural of (T - some text):
	decide on the first text value matching the textual key T in the debug plural hash table or "" if there are no matches.

Book "Naming Helper Functions"

Chapter "Private Data Identifier Canonicalization Phrases" - unindexed

To say (A - a punctuated word array) as if it were a match made by a punctuated word parsing engine:
	let the first time flag be true;
	repeat with the word running through A:
		if the first time flag is true:
			now the first time flag is false;
		otherwise:
			say " ";
		say "[the word]".

To say the canonicalization of the data identifier (T - some text):
	let the downcased identifier be a new synthetic text copied from T;
	downcase the synthetic text the downcased identifier;
	let the punctuated word array be a new punctuated word array for the synthetic text the downcased identifier;
	delete the synthetic text the downcased identifier;
	say the punctuated word array as if it were a match made by a punctuated word parsing engine;
	delete the punctuated word array.

Chapter "Public Data Identifier Canonicalization Phrases" - unindexed

The identifier for canonicalizing identifiers is some text that varies.

To decide what text is a new canonicalization of the data identifier (T - some text):
	now the identifier for canonicalizing identifiers is T;
	decide on a new synthetic text copied from "[the canonicalization of the data identifier the identifier for canonicalizing identifiers]".

To decide what text is a new permanent canonicalization of the data identifier (T - some text):
	now the identifier for canonicalizing identifiers is T;
	decide on a new permanent synthetic text copied from "[the canonicalization of the data identifier the identifier for canonicalizing identifiers]".

Book "The Infix Debug Stream" - unindexed

The Infix debug stream is a binary input file stream that varies.

Chapter "Infix Record Preprocessing" - unindexed

Section "Infix Record Preprocessor Array" - unindexed

Include (-
	Constant DFP_INFIX_RECORD_COUNT=15;
	Array dfp_infixRecordPreprocessors --> DFP_INFIX_RECORD_COUNT;
-) after "Definitions.i6t".

To decide what number is the number of Infix record types: (- DFP_INFIX_RECORD_COUNT -).
To preprocess type (I - a number) Infix records by (P - a phrase nothing -> nothing): (- llo_setField(dfp_infixRecordPreprocessors,{I},llo_getField({P},1)); -).
To preprocess a type (I - a number) Infix record: (- (llo_getField(dfp_infixRecordPreprocessors,{I}))(); -).

Section "Infix Record Types" - unindexed

To register the Infix record preprocessors:
	preprocess type 1 Infix records by preprocessing an Infix file record;
	preprocess type 2 Infix records by preprocessing an Infix class record;
	preprocess type 3 Infix records by preprocessing an Infix object record;
	preprocess type 4 Infix records by preprocessing an Infix global record;
	preprocess type 5 Infix records by preprocessing a common Infix [attribute] record;
	preprocess type 6 Infix records by preprocessing a common Infix [property] record;
	preprocess type 7 Infix records by preprocessing a common Infix [fake action] record;
	preprocess type 8 Infix records by preprocessing a common Infix [action] record;
	preprocess type 9 Infix records by preprocessing an Infix header record;
	preprocess type 10 Infix records by preprocessing an Infix sequence point set record;
	preprocess type 11 Infix records by preprocessing an Infix routine-beginning record;
	preprocess type 12 Infix records by preprocessing a common Infix [array] record;
	preprocess type 13 Infix records by preprocessing an Infix map record;
	preprocess type 14 Infix records by preprocessing an Infix routine-ending record.

Section "Preprocessing File Debug Records" - unindexed

To preprocess an Infix file record (this is preprocessing an Infix file record):
	let the file number be the next byte in the Infix debug stream;
	if the file number is one:
		skip the text in the Infix debug stream up through the next null terminator;
		skip the text in the Infix debug stream up through the next null terminator;
	otherwise:
		skip the text in the Infix debug stream up through the next null terminator;
		let the source file name be a new synthetic text extracted from the Infix debug stream until a null terminator;
		fail at handling a second I6 source file named the source file name.

Section "Preprocessing Class Debug Records" - unindexed

To preprocess an Infix class record (this is preprocessing an Infix class record):
	skip the text in the Infix debug stream up through the next null terminator;
	skip eight bytes in the Infix debug stream.

Section "Preprocessing Object Debug Records" - unindexed

To preprocess an Infix object record (this is preprocessing an Infix object record):
	skip two bytes in the Infix debug stream;
	skip the text in the Infix debug stream up through the next null terminator;
	skip eight bytes in the Infix debug stream.

Section "Preprocessing Global Debug Records" - unindexed

The minimum expected I6 global index for working around I6 global index overflow is a number that varies.  The minimum expected I6 global index for working around I6 global index overflow is zero.
To decide what number is (N - a number) adjusted for I6 global index overflow:
	let the result be N;
	while the result is less than the minimum expected I6 global index for working around I6 global index overflow:
		increase the result by 256;
	now the minimum expected I6 global index for working around I6 global index overflow is the result;
	decide on the result.

To preprocess an Infix global record (this is preprocessing an Infix global record):
	let the global index be the next byte in the Infix debug stream adjusted for I6 global index overflow;
	let the global variable name be a new permanent synthetic text extracted from the Infix debug stream until a null terminator;
	let the global record be a new I6 global record with index the global index and human-friendly name the global variable name;
	let the downcased global variable name be a new permanent synthetic text copied from the global variable name;
	downcase the synthetic text the downcased global variable name;
	insert the textual key the downcased global variable name and the value the global record into the global record lookup hash table.

Section "Preprocessing Common Debug Records" - unindexed

To preprocess a common Infix record (this is preprocessing a common Infix record):
	skip two bytes in the Infix debug stream;
	skip the text in the Infix debug stream up through the next null terminator.

Section "Preprocessing Header Debug Records" - unindexed

[At the time of writing, the Inform 6 compiler doesn't actually emit these for Glulx, which can be unfortunate for us.]

To preprocess an Infix header record (this is preprocessing an Infix header record):
	repeat with the index running from zero to 15:
		let the integer address be the index times four;
		let the expected integer be the integer at address integer address;
		let the actual integer be the next integer in the Infix debug stream;
		always check that the actual integer is the expected integer or else fail at matching the header of the debug information file.

Section "Adjusting for Line Number Overflow" - unindexed

[Line numbers occasionally decrease; we try to separate normal decreases from overflows by thresholding.]
To decide what number is the maximum line number backtrack: (- 2048 -).

The minimum expected line number for working around line number overflow is a number that varies.  The minimum expected line number for working around line number overflow is zero.
To decide what number is (N - a number) adjusted for line number overflow:
	let the result be N;
	while the result is less than the minimum expected line number for working around line number overflow:
		increase the result by 65536;
	now the minimum expected line number for working around line number overflow is the result minus the maximum line number backtrack;
	decide on the result.

To decide what number is (N - a number) adjusted for line number overflow with minimum (M - a number):
	let the result be N;
	while the result is less than M:
		increase the result by 65536;
	decide on the result.

Adjusting for line number overflow is a truth state that varies.  Adjusting for line number overflow is true.

Section "Preprocessing Routine Debug Records" - unindexed

To decide what number is the base address for code: (- 60 -).

[Some routines have no valid line numbers; we can detect them by thresholding.]
To decide what number is the minimum line number: (- 2 -).

The last-seen routine record is a routine record that varies.

To preprocess an Infix routine-beginning record (this is preprocessing an Infix routine-beginning record):
	let the stream position be the stream position of the Infix debug stream;
	skip three bytes in the Infix debug stream;
	let the beginning line number be the next short in the Infix debug stream;
	skip one byte in the Infix debug stream;
	let the function address be the base address for code plus the next triple in the Infix debug stream;
	if adjusting for line number overflow is true:
		if the function address is the address of I6_Print__PName or the beginning line number is less than the minimum line number and the function at address the function address is a veneer routine:
			now the beginning line number is zero;
			now adjusting for line number overflow is false;
		otherwise:
			now the beginning line number is the beginning line number adjusted for line number overflow;
	otherwise:
		now the beginning line number is zero;
	skip the text in the Infix debug stream up through the next null terminator;
	while the next byte in the Infix debug stream is not zero:
		skip the text in the Infix debug stream up through the next null terminator;
	now the last-seen routine record is a new routine record with function address function address and beginning line number beginning line number and beginning stream position stream position;
	insert the key the function address and the value the last-seen routine record into the routine record hash table;
	enqueue the key the function address and the value the last-seen routine record in the routine record list through the routine record list tail;
	if the beginning line number is not zero:
		insert the key the beginning line number and the value last-seen routine record into the routine beginning hash table.

To preprocess an Infix routine-ending record (this is preprocessing an Infix routine-ending record):
	let the stream position be the stream position of the Infix debug stream;
	skip three bytes in the Infix debug stream;
	let the end line number be the next short in the Infix debug stream;
	if adjusting for line number overflow is true:
		now the end line number is the end line number adjusted for line number overflow;
	otherwise:
		now the end line number is zero;
	if the end line number is less than the beginning line number of the last-seen routine record:
		now the end line number is the beginning line number of the last-seen routine record;
	skip four bytes in the Infix debug stream;
	write the end line number end line number plus one to the last-seen routine record; [plus one to convert from a closed interval to a half-open interval]
	write the end stream position stream position to the last-seen routine record.

Section "Preprocessing Sequence Point Set Debug Records" - unindexed

To preprocess an Infix sequence point set record (this is preprocessing an Infix sequence point set record):
	let the stream position be the stream position of the Infix debug stream;
	skip two bytes in the Infix debug stream;
	let the sequence point count be the next short in the Infix debug stream;
	write the sequence point stream position stream position to the last-seen routine record;
	let the base address be the function address of the last-seen routine record;
	repeat with the sequence point index running from one to the sequence point count:
		skip one byte in the Infix debug stream;
		let the line number be the next short in the Infix debug stream;
		if adjusting for line number overflow is true:
			now the line number is the line number adjusted for line number overflow;
		otherwise:
			now the line number is zero;
		skip one byte in the Infix debug stream;		
		let the instruction address be the base address plus the next short in the Infix debug stream;
		insert the key the instruction address and the value the the last-seen routine record into the sequence point routine record hash table;
		insert the key the instruction address and the value the line number into the sequence point line number hash table.

Section "Preprocessing Map Debug Records" - unindexed

The global variables map key is a text that varies.

A debug file setup rule (this is the allocate synthetic text for the global variables map key rule):
	now the global variables map key is a new permanent synthetic text copied from "global variables".

To preprocess an Infix map record (this is preprocessing an Infix map record):
	repeat until a break:
		let the key name be a new synthetic text extracted from the Infix debug stream until a null terminator;
		if the length of the synthetic text the key name is zero:
			delete the synthetic text the key name;
			break;
		if the synthetic text the key name is identical to the synthetic text the global variables map key:
			now the base address for I6 globals is the size of read-only memory plus the next triple in the Infix debug stream;
		otherwise:
			skip three bytes in the Infix debug stream;
		delete the synthetic text the key name.

Section "Preprocessing Setup Rule" - unindexed

A debug file setup rule (this is the load debug information from the Infix binary input file rule):
	register the Infix record preprocessors;
	always check that the name of the symbolic link to the debug information file is not empty or else fail at opening an unnamed debug information file;
	now the Infix debug stream is a new binary input file stream;
	if the blorb resources in lieu of external debug files option is active:
		open the Infix debug stream for blorb resource 9999;
	otherwise:
		open the Infix debug stream for the binary input file name the name of the symbolic link to the debug information file;
	let the next short be the next short in the Infix debug stream; [for the magic number]
	always check that next short is 57023 or else fail at recognizing the debug information file's format;
	now the next short is the next short in the Infix debug stream; [for the Infix file format]
	always check that the next short is 0 or else fail at recognizing the debug information file's version;
	skip two bytes in the Infix debug stream; [for the compiler version]
	repeat until a break:
		let the record type be the next byte in the Infix debug stream;
		if the record type is zero:
			break;
		if the record type is greater than the number of Infix record types:
			fail at recognizing the record type record type;
		preprocess a type record type Infix record;
	let the self global record be a new I6 global record with index four and human-friendly name "self";
	let the downcased self global variable name be a new permanent synthetic text copied from "self";
	insert the textual key the downcased self global variable name and the value the self global record into the global record lookup hash table.

Section "Shielding" (for use with Glulx Runtime Instrumentation Framework by Brady Garvin)

A GRIF shielding rule (this is the shield debug information loading rule):
	shield the load debug information from the Infix binary input file rule against instrumentation.

Chapter "Lazy Loading" - unindexed

Section "Invalid Local Names"

To decide what text is the name for invalid local number (I - a number):
	if I is:
		-- 0:
			decide on "<invalid-local-0>";
		-- 1:
			decide on "<invalid-local-1>";
		-- 2:
			decide on "<invalid-local-2>";
		-- 3:
			decide on "<invalid-local-3>";
		-- 4:
			decide on "<invalid-local-4>";
		-- 5:
			decide on "<invalid-local-5>";
		-- 6:
			decide on "<invalid-local-6>";
		-- 7:
			decide on "<invalid-local-7>";
		-- 8:
			decide on "<invalid-local-8>";
		-- 9:
			decide on "<invalid-local-9>";
		-- 10:
			decide on "<invalid-local-10>";
		-- 11:
			decide on "<invalid-local-11>";
		-- 12:
			decide on "<invalid-local-12>";
		-- 13:
			decide on "<invalid-local-13>";
		-- 14:
			decide on "<invalid-local-14>";
		-- 15:
			decide on "<invalid-local-15>";
		-- otherwise:
			decide on "<invalid-local-at-invalid-index>".

Section "Loading I6 Locals" - unindexed

To load I6 locals into (A - a routine record):
	move the Infix debug stream to stream position nine plus the beginning stream position of A expecting to read only 562 bytes;
	skip the text in the Infix debug stream up through the next null terminator;
	let the local count be zero;
	repeat until a break:
		let the local name be a new permanent synthetic text extracted from the Infix debug stream until a null terminator;
		if the length of the synthetic text local name is zero:
			break;
		downcase the synthetic text the local name;
		write the local name to I6 local name number local count of A;
		increment the local count;
	repeat with the index running over the half-open interval from the local count to the assumed maximum local count:
		write the name for invalid local number index to I6 local name number index of A;
	write the local count local count to A.

Section "Loading Sequence Points" - unindexed

To load the sequence point list into (A - a routine record):
	write the sequence point linked list an empty permanent linked list to A;
	write the sequence point linked list tail an empty permanent linked list's tail to A;
	let the base address be the function address of A;
	move the Infix debug stream to stream position two plus the sequence point stream position of A expecting to read only two bytes;
	let the sequence point count be the next short in the Infix debug stream;
	let the expected length be six times the sequence point count;
	expect the Infix debug stream to read expected length bytes;
	repeat with a counter running from one to the sequence point count:
		skip four bytes in the Infix debug stream;
		let the instruction address be the base address plus the next short in the Infix debug stream;
		enqueue the key the instruction address in the possibly invalid sequence point linked list of A through the possibly invalid sequence point linked list tail of A.

To load sequence points into (A - a source line record):
	[Strange arrangement of I6 could cause some equally strange clobbering here.  But I doubt that it will matter in practice.]
	let the routine record list be the routine record list of A;
	if the routine record list is empty:
		write the sequence point linked list an empty permanent linked list to A;
		stop;
	repeat with the routine record running through the routine record keys of the routine record list:
		let the preamble line number be the preamble line number of the routine record;
		let the beginning line number be the beginning line number of the routine record;
		let the end line number be the end line number of the routine record;
		if the preamble line number is not zero:
			write the sequence point linked list an empty permanent linked list to the source line record for line number preamble line number;
		repeat with the line number running over the half-open interval from the beginning line number to the end line number:
			let the source line record be the source line record for line number line number;
			if the possibly invalid sequence point linked list of the source line record is an invalid permanent linked list:
				write the sequence point linked list an empty permanent linked list to the source line record;
		[Note that the previous loop would load I6, so the Infix debug stream shouldn't be disturbed from here on out.]
		move the Infix debug stream to stream position two plus the sequence point stream position of the routine record expecting to read only two bytes;
		let the sequence point count be the next short in the Infix debug stream;
		let the expected length be six times the sequence point count;
		expect the Infix debug stream to read expected length bytes;
		repeat with a counter running from one to the sequence point count:
			skip three bytes in the Infix debug stream;
			let the column number be the next byte in the Infix debug stream;
			let the instruction address be the function address of the routine record;
			increase the instruction address by the next short in the Infix debug stream;
			[And note here that we don't trust the line number from the stream, but instead use the accessor that relocates sequence points on end-of-line labels.]
			let the line number be the I6 line number for the sequence point the instruction address in column number the column number;
			unless the line number is zero:
				let the source line record be the source line record for line number line number;
				unless the possibly invalid sequence point linked list of the source line record contains the key the instruction address:
					push the key the instruction address onto the possibly invalid sequence point linked list of the source line record.

Section "Relocating Sequence Points" - unindexed

[C need only be the byte from the Infix debug stream; we try to deal with overflow here.]
To decide what number is the relocation of the sequence point (S - a number) from the line number (N - a number) and the column number (C - a number):
	let the source line record be the source line record for line number N;
	let the I6 be the I6 of the source line record;
	let the length be the length of the synthetic text the I6;
	let the column number be C;
	while the column number is less than the length:
		increase the column number by 256;
	decrease the column number by 256;
	unless the character code at index the column number of the synthetic text the I6 is 46 [full stop, which begins labels]:
		decide on N;
	let the routine record be the routine record owning the sequence point S;
	let the end line number be the end line number of the routine record;
	let the mid-label flag be true;
	repeat with the character code index running from the column number plus one to the length:
		let the character code be the character code at index the character code index of the synthetic text the I6;
		if the character code is at most 32 [whitespace]:
			next;
		if the character code is 33 [exclamation point]:
			break;
		if the character code is:
			-- 46 [full stop]:
				now the mid-label flag is true;
			-- 59 [semicolon]:
				now the mid-label flag is false;
			-- otherwise:
				if the mid-label flag is false:
					decide on N;
	repeat with the line number running over the half-open interval from N plus one to the end line number:
		now the source line record is the source line record for line number line number;
		now the I6 is the I6 of the source line record;
		repeat with the character code running through the character codes in the synthetic text the I6:
			if the character code is at most 32 [whitespace]:
				next;
			if the character code is 33 [exclamation point]:
				break;
			if the character code is:
				-- 46 [full stop]:
					now the mid-label flag is true;
				-- 59 [semicolon]:
					now the mid-label flag is false;
				-- otherwise:
					if the mid-label flag is false:
						decide on the line number;
	decide on N.

To decide what number is the relocation of the sequence point (S - a number) from the line number (N - a number):
	let the routine record be the routine record owning the sequence point S;
	move the Infix debug stream to stream position two plus the sequence point stream position of the routine record expecting to read only two bytes;
	let the sequence point count be the next short in the Infix debug stream;
	let the expected length be six times the sequence point count;
	expect the Infix debug stream to read expected length bytes;
	let the expected entry be S minus the function address of the routine record;
	repeat with a counter running from one to the sequence point count:
		skip three bytes in the Infix debug stream;
		let the column number be the next byte in the Infix debug stream;
		if the next short in the Infix debug stream is the expected entry:
			decide on the relocation of the sequence point S from the line number N and the column number the column number;
	decide on N.

Book "The I6 Source Stream" - unindexed

The I6 source stream is a binary input file stream that varies.

Chapter "Preprocessing Setup Rule" - unindexed

A debug file setup rule (this is the open the I6 source binary input file rule):
	always check that the name of the symbolic link to the intermediate I6 file is not empty or else fail at opening an unnamed intermediate I6 file;
	now the I6 source stream is a new binary input file stream [in text mode];
	if the blorb resources in lieu of external debug files option is active:
		open the I6 source stream for blorb resource 9998;
	otherwise:
		open the I6 source stream for the binary input file name the name of the symbolic link to the intermediate I6 file.

Chapter "Lazy Loading" - unindexed

Section "Finding Routines by Line" - unindexed

To decide what linked list is a new list of routine records containing line number (N - a number):
	let the result be a new list of routine records for beginning line number N;
	let the supplement be an empty linked list;
	let the line number be N minus one;
	while the supplement is empty and the line number is greater than zero:
		now the supplement is a new list of routine records for beginning line number line number;
		decrement the line number;
	if the supplement is empty:
		decide on the result;
	while the supplement is not unit:
		let the spurious routine record be a routine record key popped off of the supplement;
		always check that the end line number of the spurious routine record is at most N or else fail at keeping routine records in order;
	let the sole supplement be a routine record key popped off of the supplement;
	if the end line number of the sole supplement is greater than N:
		push the key the sole supplement onto the result;
	decide on the result.

To decide what routine record is the routine record beginning before line number (N - a number):
	let the results be an empty linked list;
	let the line number be N minus one;
	while the results are empty and the line number is greater than zero:
		now the results is a new list of routine records for beginning line number line number;
		decrement the line number;
	if the results are empty:
		decide on an invalid routine record;
	while the results is not unit:
		let the spurious routine record be a routine record key popped off of the results;
	decide on a routine record key popped off of the results.
	
Section "Loading Sampled Source Line Positions" - unindexed

The source line position hash table is a permanent hash table that varies.
To decide what number is the sampled line number at or before line number (L - a number): (- ((({L}-1)&$FFFFFF00)+1) -).

To sample the source line positions:
	now the source line position hash table is a new permanent hash table with the source line position hash table size buckets;
	let the line number be one;
	move the I6 source stream to stream position zero;
	insert the key one and the value zero into the source line position hash table;
	let the end-of-stream position be the end-of-stream position of the I6 source stream;
	while the stream position of the I6 source stream is not the end-of-stream position:
		skip the text in the I6 source stream up through the next newline;
		increment the line number;
		if the line number is the sampled line number at or before line number line number:
			let the stream position be the stream position of the I6 source stream;
			insert the key the line number and the value the stream position into the source line position hash table.

Section "Loading I6 Lines" - unindexed

To load I6 line number (N - a number):
	if the source line position hash table is an invalid permanent hash table:
		sample the source line positions;
	let the sampled line number be sampled line number at or before line number N;
	let the stream position be the first number value matching the key sampled line number in the source line position hash table or -1 if there are no matches;
	if the stream position is -1:
		stop;
	let the beginning line number be zero;
	let the end line number be zero;
	let the routine record list be a new list of routine records containing line number N;
	let the beginning routine record list be an empty permanent linked list;
	let the interior routine record list be an empty permanent linked list;
	let the end routine record list be an empty permanent linked list;
	let the candidate preamble routine record be an invalid routine record;
	if the routine record list is empty:
		now the beginning line number is N;
		now the end line number is N plus one;
		[Check if N happens to be a preamble.]
		let the routine record list be a new list of routine records for beginning line number N plus one;
		if the routine record list is unit:
			now the candidate preamble routine record is a routine record key popped off of the routine record list;
			let the function address be the function address of the candidate preamble routine record;
			guess the routine kernel for the function address;
			let the kernel address be the routine kernel address of the function at address the function address;
			if the kernel address is not zero:
				now the candidate preamble routine record is the routine record for the kernel address;
		delete the routine record list;
		now the routine record list is an empty linked list;
	otherwise:
		let the head routine record be a routine record key popped off of the routine record list;
		push the key the head routine record onto the end routine record list;
		now the beginning line number is the beginning line number of the head routine record;
		now the end line number is the end line number of the head routine record;
		if the end line number minus one is greater than N:
			now the routine record list is a new list of routine records containing line number the end line number minus one;
			now the head routine record is a routine record key popped off of the routine record list;
		unless the routine record list is empty:
			while the routine record list is not empty:
				let the end routine record be a routine record key popped off of the routine record list;
				push the key the end routine record onto the end routine record list;
		let the extent be the end line number minus the beginning line number;
		if the extent is greater than one:
			now the routine record list is a new list of routine records containing line number the beginning line number;
			while the routine record list is not empty:
				let the routine record be a routine record key popped off of the routine record list;
				push the key the routine record onto the beginning routine record list;
			if the extent is greater than two:
				push the key the head routine record onto the interior routine record list;
	now the sampled line number is the sampled line number at or before line number the beginning line number;
	now the stream position is the first number value matching the key sampled line number in the source line position hash table or -1 if there are no matches;
	always check that the stream position is not -1 or else fail at finding a cached line position for the I6 line number sampled line number;
	move the I6 source stream to stream position stream position;
	repeat with a counter running over the half-open interval from the sampled line number to the beginning line number:
		skip the text in the I6 source stream up through the next newline;
	repeat with the line number running over the half-open interval from the beginning line number to the end line number:
		let the I6 be a new permanent synthetic text extracted from the I6 source stream until a newline;
		let the local routine record list be the interior routine record list;
		if the line number is the beginning line number:
			now the local routine record list is the beginning routine record list;
		[Note the absence of an ``otherwise'' in the following line.  It is intentional.]
		if the line number is the end line number minus one:
			now the local routine record list is the end routine record list;
		[This next conditional should trigger at most once.]
		if the candidate preamble routine record is not an invalid routine record and the synthetic text the I6 could be a routine preamble:
			push the key the candidate preamble routine record onto the local routine record list;
		let the result be a new source line record for line number line number and the I6 I6 and the routine record list the local routine record list;
		insert the key the line number and the value the result into the source line record hash table.

Section "Guessing Routine Shells with GRIF" - unindexed (for use with Glulx Runtime Instrumentation Framework by Brady Garvin)

To guess the routine shell for (A - a sayable value):
	let the routine kernel record be the routine record for A;
	if the routine kernel record is an invalid routine record:
		stop;
	let the beginning line number be the beginning line number of the routine kernel record;
	let the candidate routine shell record be the routine record beginning before line number the beginning line number;
	if the candidate routine shell record is an invalid routine record or the end line number of the candidate routine shell record is not the beginning line number:
		stop;
	guess the routine kernel for the function address of the candidate routine shell record.

Section "Guessing Routine Shells and Kernels without GRIF" - unindexed (for use without Glulx Runtime Instrumentation Framework by Brady Garvin)

The routine kernel name prefix is some text that varies.
A debug file setup rule (this is the allocate permanent synthetic text for the routine kernel name prefix rule):
	now the routine kernel name prefix is a new permanent synthetic text copied from "R_SHELL_".

To guess the routine shell for (A - a sayable value):
	let the routine kernel record be the routine record for A;
	if the routine kernel record is an invalid routine record:
		stop;
	let the beginning line number be the beginning line number of the routine kernel record;
	let the candidate routine shell record be the routine record beginning before line number the beginning line number;
	if the candidate routine shell record is an invalid routine record or the end line number of the candidate routine shell record is not the beginning line number:
		stop;
	move the Infix debug stream to stream position nine plus the beginning stream position of the routine kernel record expecting to read only 562 bytes;
	let the I6 name be a new synthetic text extracted from the Infix debug stream until a null terminator;
	if the synthetic text I6 name begins with the synthetic text the routine kernel name prefix:
		associate the routine shell at address the function address of the candidate routine shell record with the routine kernel at address the function address of the routine kernel record;
	delete the synthetic text the I6 name.

To guess the routine kernel for (A - a sayable value):
	let the routine shell record be the routine record for A;
	if the routine shell record is an invalid routine record:
		stop;
	let the end line number be the end line number of the routine shell record;
	let the candidate list be a new list of routine records containing line number the end line number;
	if the candidate list is empty:
		stop;
	unless the candidate list is unit:
		delete the candidate list;
		stop;
	let the candidate routine kernel record be a routine record key popped off of the candidate list;
	move the Infix debug stream to stream position nine plus the beginning stream position of the candidate routine kernel record expecting to read only 562 bytes;
	let the I6 name be a new synthetic text extracted from the Infix debug stream until a null terminator;
	if the synthetic text I6 name begins with the synthetic text the routine kernel name prefix:
		associate the routine shell at address the function address of the routine shell record with the routine kernel at address the function address of the candidate routine kernel record;
	delete the synthetic text the I6 name.

Section "Preamble Recognition" - unindexed

The routine preamble comment prefix is a text that varies.
The routine preamble comment suffix is a text that varies.
A debug file setup rule (this is the allocate permanent synthetic text for the routine preamble comment prefix and suffix rule):
	now the routine preamble comment prefix is a new permanent synthetic text copied from "! ";
	now the routine preamble comment suffix is a new permanent synthetic text copied from ":".

[We can afford to have an inexact test; we just need to be sure that we aren't claiming a line from another routine.  Since we require the line to be entirely a comment, this is safe.]
To decide whether the synthetic text (T - some text) could be a routine preamble:
	decide on whether or not the synthetic text T begins with the synthetic text the routine preamble comment prefix and the synthetic text T ends with the synthetic text the routine preamble comment suffix.

To decide whether line number (N - a number) could be a routine preamble:
	if N is zero or N is -1:
		decide no;
	let the source line record be the source line record for line number N;
	let the I6 be the I6 of the source line record;
	decide on whether or not the synthetic text the I6 could be a routine preamble.

Section "Loading Source Versions and Preamble Line Numbers" - unindexed

To load the source version and preamble line number into (A - a routine record):
	let the preamble line number be the beginning line number of A minus one;
	guess the routine shell for A;
	let the routine shell address be the routine shell address of the function at address the function address of A;
	if the routine shell address is not zero:
		let the routine shell record be the routine record for the routine shell address;
		if the routine shell record is not an invalid routine record:
			now the preamble line number is the beginning line number of the routine shell record minus one;
	if line number preamble line number could be a routine preamble:
		write the source version seven to A;
		write the preamble line number preamble line number to A;
	otherwise:
		write the source version six to A.

Section "I7 Preamble Extraction" - unindexed

To say the preamble I7 extracted from address (A - a number) to address (B - a number):
	repeat with the source running over the half-open interval from A to B:
		let the character code be the byte at address source;
		if the character code is 126: [tilde]
			say "'"; [Both tildes and double quotes appear as tildes in the I6 comment.  It is much more likely that the author wrote a double quote.]
		otherwise:
			say "[the character code converted to a Unicode character]".

To decide what text is the preamble I7 extracted from address (A - a number) to address (B - a number):
	let the result be a new uninitialized permanent synthetic text with length B minus A characters;
	overwrite the synthetic text result with the text printed when we say "[the preamble I7 extracted from address A to address B]";
	decide on the result.

To load an I7 preamble into (A - a source line record):
	let the I6 be the I6 of A;
	let the beginning address be the character array address of the synthetic text I6 plus two;
	let the end address be the beginning address plus the length of the synthetic text I6 minus two;
	let the I7 be the preamble I7 extracted from address beginning address to address end address;
	write the I7 I7 to A;
	write the I7 indentation zero to A.

Section "I7 Body Extraction" - unindexed

An I6-to-I7 state is a kind of value.
The I6-to-I7 states are
	transitioning within normal I6,
	transitioning within single-quoted I6,
	transitioning within double-quoted I6,
	transitioning one character into a candidate I7 comment,
	transitioning two characters into a candidate I7 comment,
	transitioning three characters into a candidate I7 comment,
	transitioning within a candidate I7 phrase number,
	transitioning one character before candidate I7,
	transitioning within candidate I7,
	transitioning after an at sign,
	transitioning within a mnemonic escape,
	transitioning to the first digit of a decimal escape,
	transitioning to the second digit of a decimal escape,
	transitioning to the third digit of a decimal escape,
	transitioning within a hexadecimal escape,
	transitioning to the end of an I7 comment,
	and transitioning within an non-I7 comment.
The specification of an I6-to-I7 state is "I6-to-I7 states are used, along with I6-to-I7 quoted states, to classify between-character positions when Debug File Parsing detects and extracts I7 from comments in I6."

An I6-to-I7 quoted state is a kind of value.
The I6-to-I7 quoted states are
	transitioning outside of I7 quotes
	and transitioning within I7 quotes.
The specification of an I6-to-I7 state is "I6-to-I7 quoted states are used, along with I6-to-I7 states, to classify between-character positions when Debug File Parsing detects and extracts I7 from comments in I6."

The indentation level is a number that varies.
The minimum indentation level is a number that varies.

To decide what I6-to-I7 state is the I6-to-I7 state reached by beginning at (S - an I6-to-I7 state) and saying the transduction of the synthetic text (T - some text) and adjusting the indentation levels:
	let the current state be S;
	let the current quoted state be transitioning outside of I7 quotes;
	let the pending character code be 63; [question mark, just in case]
	repeat with the character code running through the character codes in the synthetic text T:
		if the current state is:
			-- transitioning within normal I6:
				if the character code is:
					-- 33: [exclamation point]
						now the current state is transitioning one character into a candidate I7 comment;
					-- 34: [double quote]
						now the current state is transitioning within double-quoted I6;
					-- 39: [single quote]
						now the current state is transitioning within single-quoted I6;
					-- 123: [open curly brace]
						increment the indentation level;
					-- 125: [close curly brace]
						decrement the indentation level;
						if the indentation level is less than the minimum indentation level:
							now the minimum indentation level is the indentation level;
			-- transitioning within single-quoted I6:
				if the character code is 39: [single quote]
					now the current state is transitioning within normal I6;
			-- transitioning within double-quoted I6:
				if the character code is 34: [double quote]
					now the current state is transitioning within normal I6;
			-- transitioning one character into a candidate I7 comment:
				if the character code is 32: [space]
					now the current state is transitioning two characters into a candidate I7 comment;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning two characters into a candidate I7 comment:
				if the character code is 91: [open square bracket]
					now the current state is transitioning three characters into a candidate I7 comment;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning three characters into a candidate I7 comment:
				if the character code is at least 48 [digit zero] and the character code is at most 57 [digit nine]:
					now the current state is transitioning within a candidate I7 phrase number;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning within a candidate I7 phrase number:
				if the character code is 58: [colon]
					now the current state is transitioning one character before candidate I7;
				otherwise if the character code is less than 48 [digit zero] or the character code is greater than 57 [digit nine]:
					decide on transitioning within an non-I7 comment;
			-- transitioning one character before candidate I7:
				if the character code is 32: [space]
					now the current state is transitioning within candidate I7;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning within candidate I7:
				if the character code is:
					-- 64: [at sign]
						now the current state is transitioning after an at sign;
					-- 93: [close square bracket]
						if the current quoted state is transitioning outside of I7 quotes:
							now the current state is transitioning to the end of an I7 comment;
						otherwise:
							say "[the character code converted to a Unicode character]";
					-- 126: [tilde]
						if the current quoted state is transitioning outside of I7 quotes:
							now the current quoted state is transitioning within I7 quotes;
						otherwise:
							now the current quoted state is transitioning outside of I7 quotes;
						say "'";
					-- otherwise:
						say "[the character code converted to a Unicode character]";
			-- transitioning after an at sign:
				if the character code is:
					-- 64: [at sign]
						[The pending character code will be overwritten in the next state, so we needn't zero it.]
						now the current state is transitioning to the first digit of a decimal escape;
					-- 123: [open curly brace]
						now the pending character code is zero;
						now the current state is transitioning within a hexadecimal escape;
					-- otherwise:
						now the current state is transitioning within a mnemonic escape;
			-- transitioning within a mnemonic escape:
				say "?[no line break]";
				now the current state is transitioning within candidate I7;
			-- transitioning to the first digit of a decimal escape:
				if the character code is at least 48 [digit zero] and the character code is at most 57 [digit nine]:
					now the pending character code is the character code minus 48 [digit zero];
					now the current state is transitioning to the second digit of a decimal escape;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning to the second digit of a decimal escape:
				if the character code is at least 48 [digit zero] and the character code is at most 57 [digit nine]:
					now the pending character code is the pending character code times ten;
					increase the pending character code by the character code minus 48 [digit zero];
					if the pending character code is 12 [tilde divided by ten]:
						now the current state is transitioning to the third digit of a decimal escape;
					otherwise:
						say "[the pending character code converted to a Unicode character]";
						now the current state is transitioning within candidate I7;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning to the third digit of a decimal escape:
				if the character code is 54 [six]:
					say "~";
					now the current state is transitioning within candidate I7;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning within a hexadecimal escape:
				if the character code is at least 48 [digit zero] and the character code is at most 57 [digit nine]:
					now the pending character code is the pending character code shifted four bits left;
					increase the pending character code by the character code minus 48 [digit zero];
				otherwise if the character code is at least 65 [uppercase letter A] and the character code is at most 70 [uppercase letter F]:
					now the pending character code is the pending character code shifted four bits left;
					increase the pending character code by the character code minus 55 [uppercase letter A less ten];
				otherwise if the character code is at least 97 [lowercase letter A] and the character code is at most 102 [lowercase letter F]:
					now the pending character code is the pending character code shifted four bits left;
					increase the pending character code by the character code minus 87 [lowercase letter A less ten];
				otherwise if the character code is 125 [close curly brace]:
					if the pending character code is unsigned less than 256:
						say "[the pending character code converted to a Unicode character]";
					otherwise:
						say "?[no line break]";
					now the current state is transitioning within candidate I7;
				otherwise:
					decide on transitioning within an non-I7 comment;
			-- transitioning to the end of an I7 comment:
				decide on transitioning within an non-I7 comment;
	decide on the current state.

To load an I7 body into the source line records for line number (L - a number) until (M - a number):
	now the indentation level is one;
	now the minimum indentation level is one;
	[We might have to subtract indentation from all but the last line if ni has introduced extra curly braces around the phrase translation (e.g. for ifs that test rule conditions).  We subtract the indentation from our running counter when we find the first I7 line, effectively unindenting everything, and we remember the amount subtracted here so that we can add it back when we get to the last line.]
	let the indentation adjustment be zero;
	[The following initial value is so that when we see the first real I7 line, ``everything since the last I7 line'' will mean ``everything since the routine began.'']
	let the last I7 line number be L minus one;
	let the last I7 line be "";
	repeat with the line number running over the half-open interval from L to M:
		let the source line record be the source line record for line number line number;
		let the I6 be the I6 of the source line record;
		let the length be the length of the synthetic text I6;
		let the candidate I7 be a new uninitialized synthetic text with length length characters;
		overwrite the synthetic text candidate I7 with the text printed when we let the end state be the I6-to-I7 state reached by beginning at transitioning within normal I6 and saying the transduction of the synthetic text I6 and adjusting the indentation levels;
		if the end state is transitioning to the end of an I7 comment:
			if the last I7 line number is at least L [there is a last line]:
				now the length is the length of the synthetic text the last I7 line plus one;
				let the I7 be a new uninitialized permanent synthetic text with length length characters;
				overwrite the synthetic text I7 with the text printed when we say "[the last I7 line];";
				delete the synthetic text the last I7 line;
				let the last source line record be the source line record for line number last I7 line number;
				write the I7 I7 to the last source line record;
				write the I7 indentation minimum indentation level to the last source line record;
			otherwise [there is no last line]:
				now the indentation adjustment is the indentation level minus one;
				now the indentation level is one;
			repeat with the intervening line number running over the half-open interval from the last I7 line number plus one to the line number:
				let the intervening source line record be the source line record for line number intervening line number;
				write the I7 "" to the intervening source line record;
				write the I7 indentation minimum indentation level to the intervening source line record;
			now the last I7 line number is the line number;
			now the last I7 line is the candidate I7;
			now the minimum indentation level is the indentation level;
		otherwise:
			delete the synthetic text the candidate I7;
			if the minimum indentation level is at most zero:
				set the I7 coda flag in the source line record;
	if the last I7 line number is at least L [there is a last line]:
		let the length be the length of the synthetic text the last I7 line plus one;
		let the I7 be a new uninitialized permanent synthetic text with length length characters;
		overwrite the synthetic text I7 with the text printed when we say "[the last I7 line].";
		delete the synthetic text the last I7 line;
		let the last source line record be the source line record for line number last I7 line number;
		write the I7 I7 to the last source line record;
		increase the minimum indentation level by the indentation adjustment;
		write the I7 indentation minimum indentation level to the last source line record;
	repeat with the intervening line number running over the half-open interval from the last I7 line number plus one to M:
		let the intervening source line record be the source line record for line number intervening line number;
		write the I7 "" to the intervening source line record;
		write the I7 indentation minimum indentation level to the intervening source line record.

Section "Loading I7" - unindexed

To load I7 into (A - a source line record):
	let the routine record list be the routine record list of A;
	if the routine record list is empty:
		[We are going to load I7 for the routine(s) on the next line (if any), hoping that this line might be a preamble.  But if it's not, we need to have set its I7 to nothing because nothing else will write I7 to A.]
		write the I7 "" to A;
		write the I7 indentation zero to A;
		let the next line number be the line number of A plus one;
		let the next source line record be the source line record for line number next line number;
		if the next source line record is an invalid source line record:
			stop;
		now the routine record list is the routine record list of the next source line record;
		if the routine record list is empty:
			stop;
	[Strange arrangement of I6 could cause some equally strange clobbering here.  But I doubt that it will matter in practice.]
	repeat with the routine record running through the routine record keys of the routine record list:
		if the source version of the routine record is not seven:
			write the I7 "" to A;
			write the I7 indentation zero to A;
		otherwise:
			let the preamble line number be the preamble line number of the routine record;
			if the preamble line number is not zero:
				load an I7 preamble into the source line record for line number preamble line number;
			let the beginning line number be the beginning line number of the routine record;
			let the end line number be the end line number of the routine record;
			load an I7 body into the source line records for line number beginning line number until end line number.

Section "Loading I7 Locals" - unindexed

[We use I6 macros to include single quotes without causing ni to emit a text routine.]
To decide what text is the nonsynthetic call parameter comment prefix: (- " ! Call parameter '" -).
To decide what text is the nonsynthetic local variable comment prefix: (- " ! Local variable e.g. '" -).
To decide what text is the nonsynthetic local comment infix: (- "' = " -).

The call parameter comment prefix is a text that varies.
The local variable comment prefix is a text that varies.
The local comment infix is a text that varies.
The I7 let prefix is a text that varies.
The I7 let infix is a text that varies.
The solving comment prefix is a text that varies.
The let comment infix is a text that varies.
The I7 repeat prefix is a text that varies.
The I7 repeat infix is a text that varies.
The list repeat comment infix is a text that varies.
The non-list repeat comment infix is a text that varies.
The I7 calling prefix is a text that varies.
The I7 non-calling infix is a text that varies.
The I7 calling suffix is a text that varies.
The calling prefix is a text that varies.
The calling infix is a text that varies.
The calling suffix is a text that varies.

A debug file setup rule (this is the allocate synthetic text for the substrings used to identify and split declarations rule):
	now the call parameter comment prefix is a new permanent synthetic text copied from the nonsynthetic call parameter comment prefix;
	now the local variable comment prefix is a new permanent synthetic text copied from the nonsynthetic local variable comment prefix;
	now the local comment infix is a new permanent synthetic text copied from the nonsynthetic local comment infix;
	now the I7 let prefix is a new permanent synthetic text copied from "let ";
	now the I7 let infix is a new permanent synthetic text copied from " be ";
	now the solving comment prefix is a new permanent synthetic text copied from "! Solving";
	now the let comment infix is a new permanent synthetic text copied from "=";
	now the I7 repeat prefix is a new permanent synthetic text copied from "repeat with ";
	now the I7 repeat infix is a new permanent synthetic text copied from " running ";
	now the list repeat comment infix is a new permanent synthetic text copied from "=LIST_OF_TY_GetItem(";
	now the non-list repeat comment infix is a new permanent synthetic text copied from "=";
	now the I7 calling prefix is a new permanent synthetic text copied from "( called ";
	now the I7 non-calling infix is a new permanent synthetic text copied from " - ";
	now the I7 calling suffix is a new permanent synthetic text copied from " )";
	now the calling prefix is a new permanent synthetic text copied from "(";
	now the calling infix is a new permanent synthetic text copied from "=";
	now the calling suffix is a new permanent synthetic text copied from ", true)".

[Decides on a negative number if no local names match.]
To decide what number is the index of the I6 local name from (A - a routine record) almost just before the synthetic suffix (S - some text) in the synthetic text (T - some text):
	let the result be -1;
	let the reference index be the index of the synthetic text S in the synthetic text T;
	if the reference index is not zero:
		let the best character index be zero;
		let the limit be the local count of A;
		repeat with the local index running over the half-open interval from zero to the limit:
			let the local name be I6 local name number local index of A;
			let the character index be the index of the synthetic text local name in the synthetic text T starting after index best character index;
			if the character index is not zero and the character index is less than the reference index:
				now the best character index is the character index;
				now the result is the local index;
	decide on the result.

[Decides on a negative number if no local names match.]
To decide what number is the index of the I6 local name from (A - a routine record) immediately before character index (I - a number) in the synthetic text (T - some text):
	let the limit be the local count of A;
	repeat with the local index running over the half-open interval from zero to the limit:
		let the local name be I6 local name number local index of A;
		let the expected index be I minus the length of the local name;
		let the starting index be the expected index minus one;
		if the starting index is at least zero:
			let the character index be the index of the synthetic text the local name in the synthetic text T starting after index the starting index;
			if the character index is the expected index:
				decide on the local index;
	decide on -1.

An I7-local-extraction state is a kind of value.
The I7-local-extraction states are
	expecting a local prompt,
	expecting a let translation,
	expecting an equation-solving let translation,
	and expecting a repeat translation.
The specification of an I7-local-extraction state is "I7-local-extraction states are used to classify between-line positions when Debug File Parsing detects and extracts I7 locals from commented I6."

To note the I7 local name (T - some text) for local number (I - a number) on line number (N - a number), where the declaration is outdented:
	let the source line record be the source line record for line number N;
	let the old name be the possibly invalid I7 local name number I of the source line record;
	if the old name is not the name for invalid local number I:
		stop; [This can happen in a legal source because some folks use ``let'' in place of ``now.'']
	let the routine record be the sole routine record of the source line record;
	let the canonicalized name be a new permanent canonicalization of the data identifier T;
	write the canonicalized name to sample I7 local name number I of the routine record;
	let the line number be N;
	let outdented be false;
	let the minimum indentation be the I7 indentation of the source line record;
	if where the declaration is outdented:
		now outdented is true;
		increment the minimum indentation;
	while the source line record is not an invalid source line record and the sole routine record of the source line record is the routine record:
		if outdented is true:
			if the I7 indentation of the source line record is at least the minimum indentation:
				now outdented is false;
		otherwise:
			if the I7 indentation of the source line record is less than the minimum indentation:
				stop;
		write the canonicalized name to I7 local name number I of the source line record;
		increment N;
		now the source line record is the source line record for line number N.

To note the I7 kind name in (T - some text) for local number (I - a number) of (R - a routine record):
	let the kind name address be the character array address of the synthetic text T;
	let the kind name offset be the index of the synthetic text the local comment infix in the synthetic text T;
	if the kind name offset is zero:
		stop;
	increase the kind name offset by the length of the synthetic text the local comment infix;
	decrement the kind name offset;
	increase the kind name address by the kind name offset;
	let the length be the length of the synthetic text T minus the kind name offset;
	let the kind name be a new permanent synthetic text extracted from the length bytes at address the kind name address;
	write the kind name to I7 local kind name number I of R.

To decide what linked list is the linked list of pending I7 local names introduced by callings in (T - some text):
	let the result be an empty linked list;
	let the result tail be an empty linked list's tail;
	let the calling index be the index of the synthetic text the I7 calling prefix in the synthetic text T;
	while the calling index is not zero:
		increase the calling index by the length of the synthetic text the I7 calling prefix minus one;
		let the calling end index be the index of the synthetic text the I7 calling suffix in the synthetic text T starting after index the calling index;
		if the calling end index is zero:
			break;
		let the non-calling index be the index of the synthetic text the I7 non-calling infix in the synthetic text T starting after index the calling index;
		if the non-calling index is less than the calling end index:
			let the length be the calling end index minus the calling index;
			decrement the length;
			let the array address be the character array address of the synthetic text T plus the calling index;
			let the pending I7 local name be a new synthetic text extracted from the length bytes at address array address;
			enqueue the key the pending I7 local name in the result through the result tail;
		now the calling index is the index of the synthetic text the I7 calling prefix in the synthetic text T starting after index the calling index;
	decide on the result.

To decide whether we successfully pair the pending I7 local names in (L - a linked list) with the calling assignments in (T - some text) on line number (I - a number) to locals from (R - a routine record):
	if L is empty:
		decide no;
	let the current linked list vertex be L converted to a linked list vertex;
	let the infix index be the index of the synthetic text the calling infix in the synthetic text T;
	while the infix index is not zero and the current linked list vertex is not null:
		let the next infix index be the index of the synthetic text the calling infix in the synthetic text T starting after index the infix index;
		if the next infix index is one plus the infix index:
			now the next infix index is the index of the synthetic text the calling infix in the synthetic text T starting after index the next infix index;
		otherwise:
			let the local index be the index of the I6 local name from R immediately before character index infix index in the synthetic text T;
			if the local index is at least zero:
				note the I7 local name the text key of the current linked list vertex for local number the local index on line number I;
		now the infix index is the next infix index;
	decide on whether or not the current linked list vertex is null.

To load I7 locals into (A - a routine record):
	repeat with the index running over the half-open interval from zero to the assumed maximum local count:
		write "<no kind>" to I7 local kind name number index of A;
		write the name for invalid local number index to sample I7 local name number index of A;
	let the preamble line number be the preamble line number of A;
	let the beginning line number be the beginning line number of A;
	let the end line number be the end line number of A;
	if the preamble line number is not zero:
		let the preamble source line record be the source line record for line number preamble line number;
		repeat with the index running over the half-open interval from zero to the assumed maximum local count:
			write the name for invalid local number index to I7 local name number index of the preamble source line record;
	repeat with the line number running over the half-open interval from the beginning line number to the end line number:
		let the source line record be the source line record for line number line number;
		repeat with the index running over the half-open interval from zero to the assumed maximum local count:
			write the name for invalid local number index to I7 local name number index of the source line record;
	let the current state be expecting a local prompt;
	let the calling name linked list be an empty linked list;
	if the preamble line number is not zero:
		let the source line record be the source line record for line number the preamble line number;
		let the I7 be the I7 of the source line record;
		now the calling name linked list is the linked list of pending I7 local names introduced by callings in the I7;
	let the pending I7 local name be "";
	repeat with the line number running over the half-open interval from the beginning line number to the end line number:
		let the source line record be the source line record for line number line number;
		let the I6 be the I6 of the source line record;
		let the I7 be the I7 of the source line record;
		if the current state is:
			-- expecting a local prompt:
				now the pending I7 local name is a new synthetic text extracted from the synthetic text I6 between the synthetic prefix call parameter comment prefix and the synthetic suffix local comment infix or the interned empty string if there is no match;
				if the pending I7 local name is not empty:
					let the local index be the index of the I6 local name from A almost just before the synthetic suffix call parameter comment prefix in the synthetic text I6;
					if the local index is at least zero:
						note the I7 local name the pending I7 local name for local number local index on line number line number;
						note the I7 kind name in the I6 for local number local index of A;
						delete the synthetic text the pending I7 local name;
						now the pending I7 local name is "";
				otherwise:
					unless the index of the synthetic text the local variable comment prefix in the synthetic text the I6 is zero:
						let the local index be the index of the I6 local name from A almost just before the synthetic suffix local variable comment prefix in the synthetic text I6;
						if the local index is at least zero:
							note the I7 kind name in the I6 for local number local index of A;
					otherwise if the I7 is empty:
						if we successfully pair the pending I7 local names in the calling name linked list with the calling assignments in the I6 on line number line number to locals from A:
							repeat with the moribund name running through the text keys of the calling name linked list:
								delete the synthetic text the moribund name;
							delete the calling name linked list;
							now the calling name linked list is an empty linked list;
					otherwise:
						now the pending I7 local name is a new synthetic text extracted from the synthetic text I7 between the synthetic prefix I7 let prefix and the synthetic suffix I7 let infix or the interned empty string if there is no match;
						if the pending I7 local name is not empty:
							now the current state is expecting a let translation;
						otherwise:
							now the pending I7 local name is a new synthetic text extracted from the synthetic text I7 between the synthetic prefix I7 repeat prefix and the synthetic suffix I7 repeat infix or the interned empty string if there is no match;
							if the pending I7 local name is not empty:
								now the current state is expecting a repeat translation;
						repeat with the moribund name running through the text keys of the calling name linked list:
							delete the synthetic text the moribund name;
						delete the calling name linked list;
						now the calling name linked list is the linked list of pending I7 local names introduced by callings in the I7;
			-- expecting a let translation:
				let the solving comment index be the index of the synthetic text solving comment prefix in the synthetic text I6;
				if the solving comment index is zero:
					let the local index be the index of the I6 local name from A almost just before the synthetic suffix let comment infix in the synthetic text I6;
					if the local index is at least zero:
						note the I7 local name the pending I7 local name for local number the local index on line number line number minus one;
						delete the synthetic text the pending I7 local name;
						now the pending I7 local name is "";
					now the current state is expecting a local prompt;
					if we successfully pair the pending I7 local names in the calling name linked list with the calling assignments in the I6 on line number line number to locals from A:
						repeat with the moribund name running through the text keys of the calling name linked list:
							delete the synthetic text the moribund name;
						delete the calling name linked list;
						now the calling name linked list is an empty linked list;
				otherwise:
					let the current state be expecting an equation-solving let translation;
			-- expecting an equation-solving let translation:
				let the local index be the index of the I6 local name from A almost just before the synthetic suffix let comment infix in the synthetic text I6;
				if the local index is at least zero:
					note the I7 local name the pending I7 local name for local number the local index on line number line number minus two;
					delete the synthetic text the pending I7 local name;
					now the pending I7 local name is "";
				if we successfully pair the pending I7 local names in the calling name linked list with the calling assignments in the I6 on line number line number to locals from A:
					repeat with the moribund name running through the text keys of the calling name linked list:
						delete the synthetic text the moribund name;
					delete the calling name linked list;
					now the calling name linked list is an empty linked list;
				now the current state is expecting a local prompt;
			-- expecting a repeat translation:
				let the local index be the index of the I6 local name from A almost just before the synthetic suffix list repeat comment infix in the synthetic text I6;
				if the local index is less than zero:
					now the local index is the index of the I6 local name from A almost just before the synthetic suffix non-list repeat comment infix in the synthetic text I6;
				if the local index is at least zero:
					note the I7 local name the pending I7 local name for local number the local index on line number line number minus one, where the declaration is outdented;
					delete the synthetic text the pending I7 local name;
					now the pending I7 local name is "";
				if we successfully pair the pending I7 local names in the calling name linked list with the calling assignments in the I6 on line number line number to locals from A:
					repeat with the moribund name running through the text keys of the calling name linked list:
						delete the synthetic text the moribund name;
					delete the calling name linked list;
					now the calling name linked list is an empty linked list;
				now the current state is expecting a local prompt;
	repeat with the moribund name running through the text keys of the calling name linked list:
		delete the synthetic text the moribund name;
	delete the calling name linked list.

To load I7 locals into (A - a source line record):
	let the routine record be the sole routine record of A;
	if the routine record is an invalid routine record:
		repeat with the index running over the half-open interval from zero to the assumed maximum local count:
			write the name for invalid local number index to I7 local name number index of A;
	otherwise:
		load I7 locals into the routine record.

To load I7 kinds into (R - a routine record):
	let the source line record be the source line record for line number the beginning line number of R;
	unless the source line record is an invalid source line record:
		load I7 locals into the source line record.

Section "Loading Global Addresses" - unindexed

To decide what number is the base address for global variables: (- Global_Vars -).

To load addresses into the global records:
	let the routine record be the routine record for the address of I6_TC_KOV;
	always check that the routine record is not an invalid routine record or else fail at finding a reference point for finding the declaration of I7 globals;
	let the line number be the beginning line number of the routine record minus one;
	while the line number is greater than zero:
		let the source line record be the source line record for line number line number;
		let the I6 be the I6 of the source line record;
		if the synthetic text the I6 is identical to the synthetic text the global variable declaration prefix:
			increment the line number;
			let the global address be the base address for global variables;
			let the next possible global index be zero;
			repeat until a break:
				let the source line record be the source line record for line number line number;
				let the I6 be the I6 of the source line record;
				let the character index be the index of the synthetic text the global variable declaration infix in the synthetic text the I6;
				if the character index is zero:
					break;
				increase the character index by the length of the synthetic text the global variable declaration infix;
				let the global index be zero;
				let the limit be the length of the synthetic text the I6;
				while the character index is at most the limit:
					now the global index is the global index times ten;
					increase the global index by the character code at index character index of the synthetic text the I6;
					decrease the global index by 48 [digit zero];
					increment the character index;
				repeat with the intermediate global index running over the half-open interval from the next possible global index to the global index:
					let the global record be the global record for I7 global index intermediate global index;
					unless the global record is an invalid global record or the possibly invalid address of the global record is not -1:
						write the address zero to the global record;
				let the global record be the global record for I7 global index global index;
				unless the global record is an invalid global record:
					write the address the global address to the global record;
				increment the line number;
				increase the global address by four;
			repeat with the intermediate global index running over the half-open interval from the next possible global index to the I7 global count:
				let the global record be the global record for I7 global index intermediate global index;
				unless the global record is an invalid global record or the possibly invalid address of the global record is not -1:
					write the address zero to the global record;
			stop;
		decrement the line number.

Book "The Debugging Log Stream" - unindexed

The debugging log stream is a binary input file stream that varies.

Chapter "Debugging Log Delimiters" - unindexed

[We use I6 macros to include single quotes and square brackets without causing ni to emit a text routine.]

To decide what text is the nonsynthetic global variable prefix: (- "Created non-library variable: '" -).
To decide what text is the nonsynthetic global variable infix: (- "'(var)[" -).
To decide what text is the nonsynthetic global variable suffix: (- "]" -).
To decide what text is the nonsynthetic global variable translation prefix: (- "Translated variable: '" -).
To decide what text is the nonsynthetic global variable translation infix: (- "] as " -).

To decide what text is the nonsynthetic memory stack variable prefix: (- "    Created non-library variable: '" -).
To decide what text is the nonsynthetic memory stack variable infix: (- "'(var)[" -).
To decide what text is the nonsynthetic memory stack variable suffix: (- "]" -).

To decide what text is the nonsynthetic rulebook variable precursor prefix: (- "    [" -).
To decide what text is the nonsynthetic rulebook variable precursor suffix: (- " rulebook/PROPER_NOUN_NT] =25 [/ALLOWED_NT]" -).
To decide what text is the nonsynthetic activity variable precursor prefix: (- "    [" -).
To decide what text is the nonsynthetic activity variable precursor suffix: (- " activity/PROPER_NOUN_NT] =25 [/ALLOWED_NT]" -).
To decide what text is the nonsynthetic action variable precursor prefix: (- "    [" -).
To decide what text is the nonsynthetic action variable precursor suffix: (- " action/PROPER_NOUN_NT] =25 [/ALLOWED_NT]" -).

To decide what text is the nonsynthetic kind prefix: (- "    [" -).
To decide what text is the nonsynthetic kind infix: (- "/COMMON_NOUN_NT] =8 [kind of" -).
To decide what text is the nonsynthetic kind suffix: (- "=8 [kind of value/KIND_NT]" -).

To decide what text is the nonsynthetic named object prefix: (- "'" -).
To decide what text is the nonsynthetic named object suffix: (- "' (kind object)" -).

The rulebook prefix is a text that varies.
The rulebook suffix is a text that varies.
The activity prefix is a text that varies.
The action prefix is a text that varies.

The global variable prefix is a text that varies.
The global variable infix is a text that varies.
The global variable suffix is a text that varies.
The global variable translation prefix is a text that varies.
The global variable translation infix is a text that varies.
The global variable declaration prefix is a text that varies.
The global variable declaration infix is a text that varies.

The rulebook variable precursor prefix is a text that varies.
The rulebook variable precursor suffix is a text that varies.
The activity variable precursor prefix is a text that varies.
The activity variable precursor suffix is a text that varies.
The action variable precursor prefix is a text that varies.
The action variable precursor suffix is a text that varies.
The memory stack variable prefix is a text that varies.
The memory stack variable infix is a text that varies.
The memory stack variable suffix is a text that varies.

The kind prefix is a text that varies.
The kind infix is a text that varies.
The kind suffix is a text that varies.

The plural prefix is a text that varies.
The plural infix is a text that varies.
The plural suffix is a text that varies.

The object prefix is a text that varies.
The object suffix is a text that varies.
The named object prefix is a text that varies.
The named object suffix is a text that varies.

A debug file setup rule (this is the allocate synthetic text for the substrings used to identify and split debugging log lines rule):
	now the rulebook prefix is a new permanent synthetic text copied from "Compiling rulebook: ";
	now the rulebook suffix is a new permanent synthetic text copied from " = B";
	now the activity prefix is a new permanent synthetic text copied from "Created activity: ";
	now the action prefix is a new permanent synthetic text copied from "Created action: ";
	now the global variable prefix is a new permanent synthetic text copied from the nonsynthetic global variable prefix;
	now the global variable infix is a new permanent synthetic text copied from the nonsynthetic global variable infix;
	now the global variable suffix is a new permanent synthetic text copied from the nonsynthetic global variable suffix;
	now the global variable translation prefix is a new permanent synthetic text copied from the nonsynthetic global variable translation prefix;
	now the global variable translation infix is a new permanent synthetic text copied from the nonsynthetic global variable translation infix;
	now the global variable declaration prefix is a new permanent synthetic text copied from "Array Global_Vars -->";
	now the global variable declaration infix is a new permanent synthetic text copied from " ! ";
	now the rulebook variable precursor prefix is a new permanent synthetic text copied from the nonsynthetic rulebook variable precursor prefix;
	now the rulebook variable precursor suffix is a new permanent synthetic text copied from the nonsynthetic rulebook variable precursor suffix;
	now the activity variable precursor prefix is a new permanent synthetic text copied from the nonsynthetic activity variable precursor prefix;
	now the activity variable precursor suffix is a new permanent synthetic text copied from the nonsynthetic activity variable precursor suffix;
	now the action variable precursor prefix is a new permanent synthetic text copied from the nonsynthetic action variable precursor prefix;
	now the action variable precursor suffix is a new permanent synthetic text copied from the nonsynthetic action variable precursor suffix;
	now the memory stack variable prefix is a new permanent synthetic text copied from the nonsynthetic memory stack variable prefix;
	now the memory stack variable infix is a new permanent synthetic text copied from the nonsynthetic memory stack variable infix;
	now the memory stack variable suffix is a new permanent synthetic text copied from the nonsynthetic memory stack variable suffix;
	now the kind prefix is a new permanent synthetic text copied from the nonsynthetic kind prefix;
	now the kind infix is a new permanent synthetic text copied from the nonsynthetic kind infix;
	now the kind suffix is a new permanent synthetic text copied from the nonsynthetic kind suffix;
	now the plural prefix is a new permanent synthetic text copied from "(1) Setting plural of <";
	now the plural infix is a new permanent synthetic text copied from "> as <";
	now the plural suffix is a new permanent synthetic text copied from ">";
	now the object prefix is a new permanent synthetic text copied from "Created instance: ";
	now the object suffix is a new permanent synthetic text copied from "(kind object)";
	now the named object prefix is a new permanent synthetic text copied from the nonsynthetic named object prefix;
	now the named object suffix is a new permanent synthetic text copied from the nonsynthetic named object suffix.

Chapter "Extracting Rulebook Names" - unindexed

To decide whether a rulebook name can be extracted from the synthetic text (T - some text):
	let the rulebook name be a new permanent synthetic text extracted from the synthetic text T between the synthetic prefix the rulebook prefix and the synthetic suffix the rulebook suffix or the interned empty string if there is no match;
	if the rulebook name is empty:
		decide no;
	insert the textual key the rulebook name and the value the rulebook counter into the rulebook creation hash table;
	increment the rulebook counter;
	decide yes.

Chapter "Extracting Activity Names" - unindexed

To decide whether an activity name can be extracted from the synthetic text (T - some text):
	unless the synthetic text T begins with the synthetic text the activity prefix:
		decide no;
	let the prefix length be the length of the synthetic text the activity prefix;
	let the length be the length of the synthetic text T minus the prefix length;
	let the activity name be a new permanent synthetic text extracted from the length bytes at address the prefix length plus the character array address of the synthetic text T;
	insert the textual key the activity name and the value the activity counter into the activity creation hash table;
	increment the activity counter;
	decide yes.

Chapter "Extracting Action Names" - unindexed

To decide whether an action name can be extracted from the synthetic text (T - some text):
	unless the synthetic text T begins with the synthetic text the action prefix:
		decide no;
	let the prefix length be the length of the synthetic text the action prefix;
	let the length be the length of the synthetic text T minus the prefix length;
	let the action name be a new permanent synthetic text extracted from the length bytes at address the prefix length plus the character array address of the synthetic text T;
	insert the textual key the action name and the value the action counter into the action creation hash table;
	increment the action counter;
	decide yes.

Chapter "Extracting I7 Global Names and Aliases" - unindexed

To decide whether a I7 global variable name can be extracted from the synthetic text (T - some text):
	let the global variable name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the global variable prefix and the synthetic suffix the global variable infix or the interned empty string if there is no match;
	if the global variable name is empty:
		decide no;
	let the global variable kind name be a new permanent synthetic text extracted from the synthetic text T between the synthetic prefix the global variable infix and the synthetic suffix the global variable suffix or the interned empty string if there is no match;
	if the global variable kind name is empty:
		decide no;
	let the canonicalized name without an article be a new permanent canonicalization of the data identifier the global variable name;
	delete the synthetic text the global variable name;
	let the length be the length of the synthetic text the canonicalized name without an article;
	increase the length by the length of the synthetic text the source text definite article;
	let the canonicalized name with an article be a new uninitialized permanent synthetic text with length length characters;
	overwrite the synthetic text (the canonicalized name with an article) with the text printed when we say "[the source text definite article][the canonicalized name without an article]";
	let the global record be a new I7 global record with index the I7 global count and human-friendly name the canonicalized name with an article and kind name the global variable kind name;
	insert the key the I7 global count and the value the global record into the I7 global record hash table;
	downcase the synthetic text the global variable name;
	insert the textual key the canonicalized name without an article and the value the global record into the global record lookup hash table;
	insert the textual key the canonicalized name with an article and the value the global record into the global record lookup hash table;
	increment the I7 global count;
	decide yes.

To decide whether a global variable alias can be extracted from the synthetic text (T - some text):
	let the global variable name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the global variable translation prefix and the synthetic suffix the global variable infix or the interned empty string if there is no match;
	if the global variable name is empty:
		decide no;
	let the beginning index be the index of the synthetic text the global variable translation infix in the synthetic text T;
	if the beginning index is zero:
		delete the synthetic text the global variable name;
		decide no;
	increase the beginning index by the length of the synthetic text the global variable translation infix;
	decrement the beginning index;
	let the length be the length of the synthetic text T minus the beginning index;
	let the character array address be the character array address of the synthetic text T;
	let the global variable alias be a new synthetic text extracted from the length bytes at address the character array address plus the beginning index;
	let the canonicalized name be a new canonicalization of the data identifier the global variable name;
	let the canonicalized alias be a new canonicalization of the data identifier the global variable alias;
	let the global record list be a new list of global records matching the global name the canonicalized name;
	let the alias list be a new list of global records matching the global name the canonicalized alias;
	repeat with the unresolved global record running through the global record keys of the global record list:
		if the source version of the unresolved global record is seven:
			repeat with the alias running through the global record keys of the alias list:
				if the source version of the alias is six:
					write the address the address of the alias to the unresolved global record;
					write the kind name the kind name of the unresolved global record to the alias;
	delete the global record list;
	delete the alias list;
	delete the synthetic text the canonicalized alias;
	delete the synthetic text the canonicalized name;
	delete the synthetic text the global variable alias;
	delete the synthetic text the global variable name;
	decide yes.

Chapter "Extracting Memory Stack Variable Names" - unindexed

The memory stack variable precursor is some text that varies.

A memory stack variable class is a kind of value.  The memory stack variable classes are the rulebook variable class, the activity variable class, and the action variable class.  The specification of a memory stack variable classes is "A memory stack variable class represents one of the three classes of memory stack variables: rulebook variables, activity variables, and action variables.  The kind is used internally by Debug File Parsing to distinguish the three."

The memory stack variable precursor class is a memory stack variable class that varies.

To invalidate any memory stack variable precursor:
	unless the memory stack variable precursor is empty:
		delete the synthetic text the memory stack variable precursor;
		now the memory stack variable precursor is "".

To decide whether a rulebook variable precursor can be extracted from the synthetic text (T - some text):
	let the rulebook name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the rulebook variable precursor prefix and the synthetic suffix the rulebook variable precursor suffix or the interned empty string if there is no match;
	if the rulebook name is empty:
		decide no;
	invalidate any memory stack variable precursor;
	now the memory stack variable precursor is the rulebook name;
	now the memory stack variable precursor class is the rulebook variable class;
	decide yes.

To decide whether an activity variable precursor can be extracted from the synthetic text (T - some text):
	let the activity name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the activity variable precursor prefix and the synthetic suffix the activity variable precursor suffix or the interned empty string if there is no match;
	if the activity name is empty:
		decide no;
	invalidate any memory stack variable precursor;
	now the memory stack variable precursor is the activity name;
	now the memory stack variable precursor class is the activity variable class;
	decide yes.

To decide whether an action variable precursor can be extracted from the synthetic text (T - some text):
	let the action name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the action variable precursor prefix and the synthetic suffix the action variable precursor suffix or the interned empty string if there is no match;
	if the action name is empty:
		decide no;
	invalidate any memory stack variable precursor;
	now the memory stack variable precursor is the action name;
	now the memory stack variable precursor class is the action variable class;
	decide yes.

To decide whether a memory stack variable can be extracted from the synthetic text (T - some text):
	if the memory stack variable precursor is empty:
		decide no;
	let the memory stack variable name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the memory stack variable prefix and the synthetic suffix the memory stack variable infix or the interned empty string if there is no match;
	if the memory stack variable name is empty:
		decide no;
	let the memory stack variable kind name be a new permanent synthetic text extracted from the synthetic text T between the synthetic prefix the memory stack variable infix and the synthetic suffix the memory stack variable suffix or the interned empty string if there is no match;
	if the memory stack variable kind name is empty:
		decide no;
	let the canonicalized name without an article be a new permanent canonicalization of the data identifier the memory stack variable name;
	delete the synthetic text the memory stack variable name;
	let the length be the length of the synthetic text the canonicalized name without an article;
	increase the length by the length of the synthetic text the source text definite article;
	let the canonicalized name with an article be a new uninitialized permanent synthetic text with length length characters;
	overwrite the synthetic text (the canonicalized name with an article) with the text printed when we say "[the source text definite article][the canonicalized name without an article]";
	let the memory stack variable record be an invalid memory stack variable record;
	if the memory stack variable precursor class is:
		-- the rulebook variable class:
			let the owner name be a new permanent synthetic text copied from the memory stack variable precursor;
			let the index be zero;
			let the linked list vertex be the first match for the synthetic textual key the owner name in the rulebook variable offset hash table;
			if the linked list vertex is null:
				insert the textual key the owner name and the value one into the rulebook variable offset hash table;
			otherwise:
				now the index is the number value of the linked list vertex;
				write the value the index plus one to the linked list vertex;
			now the memory stack variable record is a new rulebook variable record for variable index owned by the owner name with human-friendly name the canonicalized name with an article and kind name the memory stack variable kind name;
		-- the activity variable class:
			let the owner name be a new permanent synthetic text copied from the memory stack variable precursor;
			let the index be zero;
			let the linked list vertex be the first match for the synthetic textual key the owner name in the activity variable offset hash table;
			if the linked list vertex is null:
				insert the textual key the owner name and the value one into the activity variable offset hash table;
			otherwise:
				now the index is the number value of the linked list vertex;
				write the value the index plus one to the linked list vertex;
			now the memory stack variable record is a new activity variable record for variable index owned by the owner name with human-friendly name the canonicalized name with an article and kind name the memory stack variable kind name;
		-- the action variable class:
			let the owner name be a new permanent synthetic text copied from the memory stack variable precursor;
			let the index be zero;
			let the linked list vertex be the first match for the synthetic textual key the owner name in the action variable offset hash table;
			if the linked list vertex is null:
				insert the textual key the owner name and the value one into the action variable offset hash table;
			otherwise:
				now the index is the number value of the linked list vertex;
				write the value the index plus one to the linked list vertex;
			now the memory stack variable record is a new action variable record for variable index owned by the owner name with human-friendly name the canonicalized name with an article and kind name the memory stack variable kind name;
	insert the textual key the canonicalized name without an article and the value the memory stack variable record into the memory stack variable record lookup hash table;
	insert the textual key the canonicalized name with an article and the value the memory stack variable record into the memory stack variable record lookup hash table;
	decide yes.

Chapter "Extracting Kind Names" - unindexed

To decide whether a kind name can be extracted from the synthetic text (T - some text):
	let the kind name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the kind prefix and the synthetic suffix the kind infix or the interned empty string if there is no match;
	if the kind name is empty:
		decide no;
	let the canonicalized name be a new permanent canonicalization of the data identifier the kind name;
	delete the synthetic text the kind name;
	let the kind-of-value index be the index of the synthetic text the kind suffix in the synthetic text T;
	if the kind-of-value index is zero:
		unless the kind-of-object hash table contains the textual key the canonicalized name:
			insert the textual key the canonicalized name and the value the excess kind counter into the kind-of-object hash table;
			increment the excess kind counter;
	otherwise:
		unless the kind-of-value hash table contains the textual key the canonicalized name:
			insert the textual key the canonicalized name and the value the excess kind counter into the kind-of-value hash table;
			increment the excess kind counter;
	decide yes.

To decide what number is the base kind high water mark: (- BASE_KIND_HWM -).

To adjust the base kind codes:
	let the adjustment be the base kind high water mark minus the excess kind counter;
	repeat with the linked list vertex running through the kind-of-object hash table:
		let the adjusted value be the adjustment plus the number value of the linked list vertex;
		write the value the adjusted value to the linked list vertex;
	repeat with the linked list vertex running through the kind-of-value hash table:
		let the adjusted value be the adjustment plus the number value of the linked list vertex;
		write the value the adjusted value to the linked list vertex.

Chapter "Extracting Plurals" - unindexed

To decide whether a plural can be extracted from the synthetic text (T - some text):
	let the singular be a new synthetic text extracted from the synthetic text T between the synthetic prefix the plural prefix and the synthetic suffix the plural infix or the interned empty string if there is no match;
	if the singular is empty:
		decide no;
	let the plural be a new synthetic text extracted from the synthetic text T between the synthetic prefix the plural infix and the synthetic suffix the plural suffix or the interned empty string if there is no match;
	if the plural is empty:
		delete the synthetic text the singular;
		decide no;
	let the canonicalized singular be a new permanent canonicalization of the data identifier the singular;
	delete the synthetic text the singular;
	let the canonicalized plural be a new permanent canonicalization of the data identifier the plural;
	delete the synthetic text the plural;	
	insert the textual key the canonicalized singular and the value the canonicalized plural into the debug plural hash table;
	decide yes.

Chapter "Extracting Object Names" - unindexed

To decide whether an object name can be extracted from the synthetic text (T - some text):
	if the index of the synthetic text the object prefix in the synthetic text T is zero or the index of the synthetic text the object suffix in the synthetic text T is zero:
		decide no;
	let the object name be a new synthetic text extracted from the synthetic text T between the synthetic prefix the named object prefix and the synthetic suffix the named object suffix or the interned empty string if there is no match;
	unless the object name is empty:
		let the canonicalized name be a new permanent canonicalization of the data identifier the object name;
		delete the synthetic text the object name;
		insert the textual key the canonicalized name and the value the object counter into the object number lookup hash table;
	increment the object counter;
	decide yes.

To decide what number is the address of the I6 class Class: (- Class -).
To decide what number is the offset to an object link: (- 8 -).

To adjust the object numbers and associate addresses:
	let the iterator be the address of the I6 class Class;
	let the parallel counter be zero;
	while the iterator plus the offset to an object link is a valid integer address:
		if the iterator is zero:
			break;
		insert the key the parallel counter and the value the iterator into the object address lookup hash table;
		increment the parallel counter;
		increase the iterator by the offset to an object link;
		now the iterator is the integer at address iterator;
	let the adjustment be the parallel counter minus the object counter;
	always check that the adjustment is greater than zero or else fail at associating I7 object names with object numbers;
	repeat with the linked list vertex running through the object number lookup hash table:
		let the adjusted value be the adjustment plus the number value of the linked list vertex;
		write the value the adjusted value to the linked list vertex;
	let the nothing name be a new permanent synthetic text copied from "nothing";
	insert the textual key the nothing name and the value the object counter into the object number lookup hash table;
	insert the key the object counter and the value zero into the object address lookup hash table.

Chapter "Log Parsing Setup Rule" - unindexed

A debug file setup rule (this is the open the debugging log binary input file rule):
	always check that the name of the symbolic link to the debugging log file is not empty or else fail at opening an unnamed debugging log file;
	now the debugging log stream is a new binary input file stream [in text mode];
	if the blorb resources in lieu of external debug files option is active:
		open the debugging log stream for blorb resource 9997;
	otherwise:
		open the debugging log stream for the binary input file name the name of the symbolic link to the debugging log file;
	now the I7 global count is zero;
	let the end-of-stream position be the end-of-stream position of the debugging log stream;
	while the stream position of the debugging log stream is not the end-of-stream position:
		let the line be a new synthetic text extracted from the debugging log stream until a newline;
		unless the length of the synthetic text the line is zero:
			if the character code at index one of the synthetic text the line is:
				-- 32: [space]
					if a rulebook variable precursor can be extracted from the synthetic text the line:
						break;
					if an activity variable precursor can be extracted from the synthetic text the line:
						break;
					if an action variable precursor can be extracted from the synthetic text the line:
						break;
					if a kind name can be extracted from the synthetic text the line:
						break;
					if a memory stack variable can be extracted from the synthetic text the line:
						break;
					if an object name can be extracted from the synthetic text the line:
						break;
				-- 40: [open parenthesis]
					if a plural can be extracted from the synthetic text the line:
						break;
				-- 67: [uppercase letter C]
					if a I7 global variable name can be extracted from the synthetic text the line:
						break;
					if a rulebook name can be extracted from the synthetic text the line:
						break;
					if an activity name can be extracted from the synthetic text the line:
						break;
					if an action name can be extracted from the synthetic text the line:
						break;
					if an object name can be extracted from the synthetic text the line:
						break;
				-- 84: [uppercase letter T]
					if a global variable alias can be extracted from the synthetic text the line:
						break;
		delete the synthetic text the line;
	invalidate any memory stack variable precursor;
	adjust the base kind codes;
	adjust the object numbers and associate addresses;
	delete the debugging log stream;
	now the debugging log stream is an invalid binary input file stream.

[So that aliasing works...]
The open the debugging log binary input file rule is listed after the load debug information from the Infix binary input file rule in the debug file setup rulebook.

Book "Debug File Parsing Setup"

Chapter "Debug File Parsing Setup State" - unindexed

Debug files already loaded is a truth state that varies.  Debug files already loaded is false.

Chapter "Debug File Parsing Setup Phrase"

To load the debug files:
	always check that debug files already loaded is false or else fail at loading debug files twice;
	now debug files already loaded is true;
	traverse the debug file setup rulebook.

Chapter "GRIF Hooks" (for use with Glulx Runtime Instrumentation Framework by Brady Garvin)

A GRIF setup rule (this is the set up debug files as part of the GRIF setup rule):
	load the debug files.

Book "Backup Function Naming"

Chapter "Backup Function Naming State" - unindexed

All routine names initialized is a truth state that varies.  All routine names initialized is false.

Chapter "Backup Function Naming Phrase"

Section "Identifying I6 Names for Phrases" - unindexed

The phrase routine name prefix is a text that varies.

A debug file setup rule (this is the allocate synthetic text for the substring used to identify routines that might be phrases rule):
	now the phrase routine name prefix is a new permanent synthetic text copied from "PHR_".

Section "Adding I6 Names and Preambles for Unnamed Phrases"

To ensure that all routines have names:
	if all routine names initialized is false:
		now all routine names initialized is true;
		repeat with the linked list vertex running through the routine record list:
			let the function address be the number key of the linked list vertex;
			let the routine record be the routine record value of the linked list vertex;
			move the Infix debug stream to stream position nine plus the beginning stream position of the routine record expecting to read only 562 bytes;
			let the I6 name be a new permanent synthetic text extracted from the Infix debug stream until a null terminator;
			give the routine at address the function address the routine name the I6 name;
			if the name for the phrase function at address the function address is empty and the synthetic text the I6 name begins with the synthetic text the phrase routine name prefix:
				let the preamble line number be the preamble line number of the routine record;
				if the preamble line number is not zero:
					let the I6 be the I6 of the source line record for line number the preamble line number;
					let the beginning address be the character array address of the synthetic text I6 plus two;
					let the end address be the beginning address plus the length of the synthetic text I6 minus three; [two plus one to omit the colon]
					let the I7 be the preamble I7 extracted from address beginning address to address end address;
					give the phrase function at address the function address the phrase name the I7.

Debug File Parsing ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Debug File Parsing gathers debugging information about source text, routines,
variables, sequence points, and objects from the files the Inform compiler
creates and makes the data available to the running story.

Details are in the following chapters.

Chapter: Usage

Section: Set up

Debug File Parsing needs access to three of the debugging files produced by
Inform 7: the intermediate I6, the file gameinfo.dbg, and the debugging log.
The usual way to grant access is to create symbolic links to these files and
then write

	The name of the symbolic link to the intermediate I6 file is "...".
	The name of the symbolic link to the debug information file is "...".
	The name of the symbolic link to the debugging log file is "...".

so that the extension knows the names of these links.  The README that
accompanies the distribution of the extension (and is also available from
https://sourceforge.net/projects/i7grip/) describes in detail how to do this.

These files take a little bit of time to load, so that only happens when we
invoke the phrase

	load the debug files

It is an error to use the extension's other phrases before then or to load the
debug files more than once.  Authors who include the Glulx Runtime
Instrumentation Framework should be aware of

	the set up debug files as part of the GRIF setup rule

which executes this phrase during the GRIF setup process.

Section: Source text and associated data

Debug File Parsing thinks of a story's source text in terms of its I6
translation, which collects lines from both the main source text and any
extensions into one file.  The data for each of these lines is kept in a
structure having the kind

	a source line record

where the special value

	an invalid source line record

is used for nonexistent lines.  Only valid source line records should be given
to the extension's phrases.  We usually obtain them by asking for

	the source line record for line number (N - a number)

where N is an in-bounds (one-based) line number.  We can later recover N by
writing

	the line number of (A - a source line record)

The source text itself is available as I6:

	the I6 of (A - a source line record)

and sometimes as I7---routines translated from I7 typically read something like
the following (line numbers have been added in parentheses):

	...
	! phrase 1 (line 017924)
	! (1: if the actor is wearing the noun begin) (line 017925)
	if(((actor == WearerOf(noun)))){ (line 017926)
		! phrase 2 (line 017927)
		...

and for lines like 017925 that contain part of the original I7 source, the
phrase

	the I7 of (A - a source line record)

will return that I7 as synthetic text.  For any other lines, it just decides on
the ordinary text "", to which the adjective "empty" applies, as in:

	let the I7 be the I7 of the source line record;
	unless the I7 is empty:
		....

Indentation is reported separately, as a number of tabs given by

	the I7 indentation of (A - a source line record)

a phrase that assumes the standard Pythonesque indentation style.

We also have phrases to help us relate source text lines.  Returning to the
example code snippet, note that the I7 in line 017925 is implemented on line
017926.  The general pattern for a routine is

	I7 preamble
	I6 implementing part of the preamble
	I7 phrase 1
	I6 implementing phrase 1
	I7 phrase 2
	I6 implementing phrase 2
	...
	I7 phrase n
	I6 implementing phrase n
	I6 implementing the rest of the preamble (the coda)

So we can mostly associate I6 with I7 simply by splitting a routine on its I7
lines.  The only exception is the coda, for which reason we have the test

	if the I7 coda flag is set in (A - a source line record):
		....

In case we don't already know the routine that encloses a line, the phrase

	the sole routine record of (A - a source line record)

will tell us by deciding on a routine record (see the section titled "Routines
and associated data" below).  However, it assumes that there is a unique owner
and will complain if not.  The more general phrase

	the routine record list of (A - a source line record)

decides on an unmodifiable permanent linked list (see the extension Low-Level
Linked Lists) whose keys are records for the routines sharing ownership.

A similar phrase,

	the sequence point linked list of (A - a source line record)

works in much the same way, except that the list keys are the sequence points
appearing on the line indicated.

Lastly, to deal with the complication that I7 temporary named values (also
called "locals") can change name from line to line, we have

	I7 local name number (I - a number) of (A - a source line record)

where I is the index of the local we're interested in.  The first local declared
by a routine's I6 has index zero, the second has index one, and so on, possibly
up to index 15.

Section: Routines and associated data

Like source text lines, we store data for routines in values of a specialized
kind:

	a routine record

and the value for a nonexistent routine is

	an invalid routine record

Valid routine records can be gotten in two ways.  Usually we write

	the routine record for (F - a sayable value)

where F is a rule, phrase, or function address.  Alternatively, if we have a
sequence point, we can compute

	the routine record owning the sequence point (S - a number)

Once we have a valid routine record, many data are available.  First off,

	the function address of (A - a routine record)

locates the routine in memory.  The address can also be used to find a
human-friendly name for the routine, via

	the human-friendly name for the function at address (A - a number)

It's often a good idea to preface such lookups with

	ensure that all routines have names

a phrase particular to Debug File Parsing.  It knows not to duplicate effort if
we've already used it; we don't have to add these checks ourselves.

For addresses of instructions within the function, we turn to

	the sequence point linked list of (A - a routine record)

That phrase decides on a linked list whose keys are routine's sequence points.

Next we have

	the source version of (A - a routine record)

which at the moment can be 6 if the routine was originally written as I6 or 7 if
it was translated from I7.

Line numbers are retrieved by

	the preamble line number of (A - a routine record)

which is the line number of the I7 preamble or zero if there is none, as well as

	the beginning line number of (A - a routine record)

and

	the end line number of (A - a routine record)

which delimit the body of the routine from the beginning, inclusive, to the end,
exclusive.

And last, we can learn about locals.

	the local count of (A - a routine record)

tells us their number, which in turn given the valid range of local indices:
zero to the local count minus one.  I6 names are provided by

	I6 local name number (I - a number) of (A - a routine record)

but we cannot access I7 names from a routine record---they might change from
line to line, so we have to consult a source line record.

Kinds, on the other hand, are assumed to be the same for an entire routine;
hence the phrase

	I7 local kind name number (I - a number) of (A - a routine record)

where, recall, the phrase

	the debug plural of (T - some text)

will properly pluralize these kind names.

Section: Global variables and associated data

Continuing the theme, we have a kind that stores information about global variables:

	a global record

and a value of that kind that represents no global at all, and should not be
given to extension phrases:

	an invalid global record

Valid global records are retrieved by examining the keys of

	a new list of global records matching the global name (T - some text)

where T can be an I6 or I7 name.  Note that we are responsible for deleting the
list once we are done with it.

Once we have a global record, we can ask for

	the source version of (A - a global record)

which will be 6 if it was declared at the I6 level (and possibly given I7
aliases), 7 if it was declared by the I7 source text.  Along with

	the global index of (A - a global record)

which is zero for the first global declared, one for the second, etc., among all
globals having the same source version, we have enough data to uniquely identify
a global.  However, we are usually more interested in

	the address of (A - a global record)

which the location in memory where that global is stored.  (If the Glulx Runtime
Instrumentation Framework is included, this is the location for instrumented
code; uninstrumented code has separate copies of some globals.)  Besides
uniquely identifying a global, the address allows us to inspect and change its
contents, via phrases from Low-Level Operations:

	the integer at address (J - a number)

and

	write the integer (I - a number) to address (J - a number)

We will usually want to convert the contents to the appropriate kind, which is
determined by

	the kind name of (A - a global record)

The phrase will decide on

	"<no kind>"

if the global has no associated kind.  As always, kinds can be pluralized with
the phrase

	the debug plural of (T - some text)

Finally, the preferred name for a global is recoverable via the phrase

	the human-friendly name of (A - a global record)

Section: Memory stack variables and associated data

Memory stack variables are variables that belong to a rulebook, activity, or
action, and only exist while it is running.  Like global variables, memory stack
variables have a record kind:

	a memory stack variable record

with a default value representing nonexistent variables:

	an invalid memory stack variable record

a phrase that builds a new list of these records when given a variable name:

	a new list of memory stack variable records matching the memory stack variable name (T - some text)

phrases to elicit their human-friendly names:

	the human-friendly name of (A - a memory stack variable record)

and kind names:

	the kind name of (A - a memory stack variable record)

and a phrase to locate them in memory:

	the current address of (A - a memory stack variable record)

The last, however, is a little different from its global variable counterpart.
Memory stack variables move around in memory, sometimes falling out of existence
and sometimes existing as several separate copies, as when an activity begins
itself.  The phrase returns zero whenever the variable has no address and the
address most recently occupied otherwise.  The latter is the one that Inform
uses when the variable is referenced in the source text.

Additionally, we may request

	the owner name of (A - a memory stack variable record)

a synthetic text naming the rulebook, activity, or action to which the variable
belongs.

Section: Sequence points and associated data

Sequence points, unlike everything seen thus far, do not have a special kind
that records information about them.  Because they are just memory addresses, we
simply store them as numbers.

Ordinarily we enumerate sequence points by traversing either

	the sequence point linked list of (A - a source line record)

for some source line record A, or

	the sequence point linked list of (A - a routine record)

for a routine record.  But it is also handy to test whether an instruction
address we already have---for instance, in an instrumentation rule---is a
sequence point.  For this we have the conditional

	if (S - a number) is a sequence point:
		....

To get back to a routine record from a sequence point, we use the phrase

	the routine record owning the sequence point (S - a number)

and to get back to a source line record, we go by way of finding a line number.
Either

	the I6 line number for the sequence point (S - a number)

or

	the I7 line number for the sequence point (S - a number)

is available, depending on whether we want an I6 line or an I7 line.

Section: Objects and associated data

Finally, we have the ability to look up objects by their source text name.  The
phrase to use is

	a new list of object addresses matching the object name (T - some text)

which allocates a new linked list whose keys are the objects with a source text
name exactly matching T.  We are responsible for deleting it.

The phrase

	the debug plural of (T - some text)

which has made repeated appearances before, returns one last time as the proper
way to pluralize these source text names.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

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

Debug File Parsing was prepared as part of the Glulx Runtime Instrumentation
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

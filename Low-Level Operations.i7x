Version 1 of Low-Level Operations (for Glulx only) by Brady Garvin begins here.

"Phrases for low-level Glulx operations."

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

Chapter "Use Options" - unindexed

[For hunting down bugs involving CocoaGlk with a modded version of the Inform IDE; full Glk logging gets noisy fast if we swap streams in string-to-array conversions, so we forgo stream safety in favor of legibility.]
Use quiet string printing under Cocoa Glk translates as (- Constant COCOA_QUIET; -).

Book "Transfer Registers" - unindexed

[We have some phrases that need to use their arguments as assembly operands.  For this to work, however, we need a place to store the argument between evaluation and the 
assembly or between the assembly and assignment to an l-value.  We call such a place a transfer register; one is defined below.]

Include (-
	Global llo_transfer;
-) after "Definitions.i6t".

The low-level operations transfer register is a number that varies.
The low-level operations transfer register variable translates into I6 as "llo_transfer".

Book "Numbers"

Chapter "Bitwise Operations"

Include (-
	[ llo_xor value otherValue;
		@bitxor value otherValue sp;
		@return sp;
	];
-).

To decide what number is the bitwise not of (I - a number): (- (~{I}) -).
To decide what number is the bitwise and of (I - a number) and (J - a number): (- ({I}&{J}) -).
To decide what number is the bitwise or of (I - a number) and (J - a number): (- ({I}|{J}) -).
To decide what number is the bitwise xor of (I - a number) and (J - a number): (- llo_xor({I},{J}) -).

Chapter "Shift Operations"

Include (-
	[ llo_leftShift value distance;
		@shiftl value distance sp;
		@return sp;
	];
	[ llo_logicalRightShift value distance;
		@ushiftr value distance sp;
		@return sp;
	];
	[ llo_arithmeticRightShift value distance;
		@sshiftr value distance sp;
		@return sp;
	];
-).

To decide what number is (I - a number) shifted (D - a number) bit/bits left: (- llo_leftShift({I},{D}) -).
To decide what number is (I - a number) logically shifted (D - a number) bit/bits right: (- llo_logicalRightShift({I},{D}) -).
To decide what number is (I - a number) arithmetically shifted (D - a number) bit/bits right: (- llo_arithmeticRightShift({I},{D}) -).

Chapter "Sign Extension"

Include (-
	[ llo_extendByte value;
		@sexb value sp;
		@return sp;
	];
	[ llo_extendShort value;
		@sexs value sp;
		@return sp;
	];
-).

To decide what number is (I - a number) sign extended from a byte: (- llo_extendByte({I}) -).
To decide what number is (I - a number) sign extended from a short: (- llo_extendShort({I}) -).

Chapter "Unsigned Numbers"

Section "Unsigned Comparisons"

Include (-
	[ llo_unsignedLessThan value otherValue;
		@"3:42" value otherValue 1; !jltu
		@return 0;
	];
	[ llo_unsignedLessThanOrEqual value otherValue;
		@"3:45" value otherValue 1; !jleu
		@return 0;
	];
	[ llo_unsignedGreaterThanOrEqual value otherValue;
		@"3:43" value otherValue 1; !jgeu
		@return 0;
	];
	[ llo_unsignedGreaterThan value otherValue;
		@"3:44" value otherValue 1; !jgtu
		@return 0;
	];
-).

To decide whether (I - a number) is/are unsigned less than (J - a number): (- llo_unsignedLessThan({I},{J}) -).
To decide whether (I - a number) is/are unsigned fewer than (J - a number): (- llo_unsignedLessThan({I},{J}) -).
To decide whether (I - a number) is/are unsigned at most (J - a number): (- llo_unsignedLessThanOrEqual({I},{J}) -).
To decide whether (I - a number) is/are unsigned at least (J - a number): (- llo_unsignedGreaterThanOrEqual({I},{J}) -).
To decide whether (I - a number) is/are unsigned greater than (J - a number): (- llo_unsignedGreaterThan({I},{J}) -).
To decide whether (I - a number) is/are unsigned more than (J - a number): (- llo_unsignedGreaterThan({I},{J}) -).

Section "Saying Unsigned Numbers"

To say (I - a number) as unsigned (this is saying an unsigned number):
	let the leading digit be zero;
	let the trailing digits be I;
	[loop runs at most four iterations]
	while the trailing digits are unsigned at least 1000000000:
		increment the leading digit;
		decrease the trailing digits by 1000000000;
	say "[the leading digit][the trailing digits]".

Chapter "Other Bases"

Section "Digits and Masks" - unindexed

Include (-
	Array LLO_DIGITS --> "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F";
-).

To decide what text is digit (D - a number): (- (LLO_DIGITS-->{D}) -).

To decide what number is the upper bit mask: (- $80000000 -).
To decide what number is the upper nybble mask: (- $F0000000 -).

Section "Binary"

To say (N - a number) in unprefixed binary (this is saying a number in unprefixed binary):
	if N is zero:
		say "[the digit zero]";
	otherwise:
		let the bit shift be zero;
		let the unprinted bits be N;
		while the bitwise and of the unprinted bits and the upper bit mask is zero:
			increment the bit shift;
			now the unprinted bits are the unprinted bits shifted one bit left;
		while the bit shift is less than 32:
			let the masked value be the bitwise and of the unprinted bits and the upper bit mask;
			let the bit be the masked value logically shifted 31 bits right;
			say "[the digit bit]";
			increment the bit shift;
			now the unprinted bits are the unprinted bits shifted one bit left.

To say (N - a number) in binary (this is saying a number in prefixed binary):
	say "0b[N in unprefixed binary]".

Section "Hexadecimal"

To say (N - a number) in unprefixed hexadecimal (this is saying a number in unprefixed hexadecimal):
	if N is zero:
		say "[the digit zero]";
	otherwise:
		let the nybble shift be zero;
		let the unprinted nybbles be N;
		while the bitwise and of the unprinted nybbles and the upper nybble mask is zero:
			increment the nybble shift;
			now the unprinted nybbles are the unprinted nybbles shifted four bits left;
		while the nybble shift is less than 8:
			let the masked value be the bitwise and of the unprinted nybbles and the upper nybble mask;
			let the nybble be the masked value logically shifted 28 bits right;
			say "[the digit nybble]";
			increment the nybble shift;
			now the unprinted nybbles are the unprinted nybbles shifted four bits left.

To say (N - a number) in hexadecimal (this is saying a number in prefixed hexadecimal):
	say "0x[N in unprefixed hexadecimal]".

Book "Memory"

Chapter "Measuring Memory"

Include (-
	[ llo_getMemorySize;
		@getmemsize sp;
		@return sp;
	];
	[ llo_validByteAddress value;
		@getmemsize sp;
		@"3:42" value sp 1; !jltu
		@return 0;
	];
	[ llo_validShortAddress value;
		@getmemsize sp;
		@sub sp 1 sp;
		@"3:42" value sp 1; !jltu
		@return 0;
	];
	[ llo_validIntAddress value;
		@getmemsize sp;
		@sub sp 3 sp;
		@"3:42" value sp 1; !jltu
		@return 0;
	];
-).

To decide what number is the size of memory: (- llo_getMemorySize() -).
To decide what number is the size of read-only memory: (- llo_getInt(8) -).

Definition: a number is a valid byte address rather than an invalid byte address if I6 routine "llo_validByteAddress" says so (it is less than the size of memory, using an unsigned comparison).
Definition: a number is a valid short address rather than an invalid short address if I6 routine "llo_validShortAddress" says so (it is less than the size of memory minus one, using an unsigned comparison).
Definition: a number is a valid integer address rather than an invalid integer address if I6 routine "llo_validIntAddress" says so (it is less than the size of memory minus three, using an unsigned comparison).

Chapter "Reading Memory"

Include (-
	[ llo_getBit address bitOffset;
		@aloadbit address bitOffset sp;
		@return sp;
	];
	! if the high parameter is nonzero, get the high nybble (bits 4--7); otherwise get the low nybble (bits 0--3)
	[ llo_getNybble address high;
		if(high){
			return llo_logicalRightShift(llo_getByte(address),4)&$F;
		}
		return llo_getByte(address)&$F;
	];
	[ llo_getByte address;
		@aloadb address 0 sp;
		@return sp;
	];
	[ llo_getShort address;
		@aloads address 0 sp;
		@return sp;
	];
	[ llo_getInt address;
		@aload address 0 sp;
		@return sp;
	];
	[ llo_getField base index;
		@aload base index sp;
		@return sp;
	];
-).

To decide whether the bit at address (A - a number) and secondary address (B - a number) is set: (- llo_getBit({A},{B}) -).
To decide what number is the nybble at address (A - a number) and secondary address (B - a number): (- llo_getNybble({A},{B}) -).
To decide what number is the byte at address (A - a number): (- llo_getByte({A}) -).
To decide what number is the short at address (A - a number): (- llo_getShort({A}) -).
To decide what number is the integer at address (A - a number): (- llo_getInt({A}) -).

Chapter "Writing Memory"

Include (-
	[ llo_setBit address bitOffset value;
		@astorebit address bitOffset value;
	];
	! if the high parameter is nonzero, set the high nybble (bits 4--7); otherwise set the low nybble (bits 0--3)
	[ llo_setNybble address high value;
		if(high){
			return llo_setByte(address,(llo_getByte(address)&$F)|llo_leftShift(value&$F,4));
		}
		return llo_setByte(address,(llo_getByte(address)&-$10)|(value&$F));
	];
	[ llo_setByte address value;
		@astoreb address 0 value;
	];
	[ llo_setShort address value;
		@astores address 0 value;
	];
	[ llo_setInt address value;
		@astore address 0 value;
	];
	[ llo_setField base index value;
		@astore base index value;
	];
	[llo_zero size address;
		@mzero size address;
	];
-).

To write the bit (I - a truth state) to address (A - a number) and secondary address (B - a number): (- llo_setBit({A},{B}); -).
To write the nybble (I - a number) to address (A - a number) and secondary address (B - a number): (- llo_setNybble({A},{B},{I}); -).
To write the byte (I - a number) to address (A - a number): (- llo_setByte({A},{I}); -).
To write the short (I - a number) to address (A - a number): (- llo_setShort({A},{I}); -).
To write the integer (I - a number) to address (A - a number): (- llo_setInt({A},{I}); -).
To zero (N - a number) bytes at address (A - a number): (- llo_zero({N},{A}); -).

Chapter "Copying Memory"

[Two possible implementations; late bind according to the Glulx gestalt.]
Include (-
	Global llo_copy=llo_copyResolve;
-) after "Definitions.i6t".

Include (-
	[ llo_copyInVM size source destination;
		@mcopy size source destination;
	];
	[ llo_copyByLoop size source destination i;
		if(destination<source){
			for(i=0:i<size:++i){
				llo_setByte(destination+i,llo_getByte(source+i));
			}
		}else{
			for(i=size:(i-- )>0:){
				llo_setByte(destination+i,llo_getByte(source+i));
			}
		}
	];
	[ llo_copyResolve size source destination;
		if(llo_checkGestalt(6,0)){
			llo_copy=llo_copyInVM;
		}else{
			llo_copy=llo_copyByLoop;
		}
		return llo_copy(size,source,destination);
	];
-).

To copy (N - a number) byte/bytes from address (A - a number) to address (B - a number): (- llo_copy({N},{A},{B}); -).

Chapter "Managing Dynamic Memory"

[There isn't much special about the number four; we just want something that isn't null and also can't be a valid malloc.]
Include (-
	Constant llo_zeroLengthAllocationAddress = 4;
-) after "Definitions.i6t".

To decide what number is the address for a zero-length allocation: (- llo_zeroLengthAllocationAddress -).

Include (-
	Global llo_permanentMallocPool=0;
	Global llo_permanentMallocPoolEnd=0;
	[ llo_permanentMalloc size result growth;
		result=llo_permanentMallocPool;
		llo_permanentMallocPool=llo_permanentMallocPool+size;
		if(llo_permanentMallocPool>llo_permanentMallocPoolEnd){
			if(size<4194304){
				growth=4194304;
			}else{
				growth=size;
			}
			@malloc growth llo_permanentMallocPool;
			llo_permanentMallocPoolEnd=llo_permanentMallocPool+growth;
			@copy llo_permanentMallocPool result;
			llo_permanentMallocPool=llo_permanentMallocPool+size;
		}
		return result;
	];
	[ llo_malloc size;
		@malloc size sp;
		@return sp;
	];
	[ llo_free address;
		@mfree address;
	];
-).

To decide what number is a permanent memory allocation of (N - a number) byte/bytes: (- llo_permanentMalloc({N}) -).
To decide what number is a possibly zero-length permanent memory allocation of (N - a number) byte/bytes:
	if N is zero:
		decide on the address for a zero-length allocation;
	decide on a permanent memory allocation of N bytes.

To decide what number is a memory allocation of (N - a number) byte/bytes: (- llo_malloc({N}) -).
To decide what number is a possibly zero-length memory allocation of (N - a number) byte/bytes:
	if N is zero:
		decide on the address for a zero-length allocation;
	decide on a memory allocation of N bytes.

To free the memory allocation at address (A - a number): (- llo_free({A}); -).
To free the possibly zero-length memory allocation at address (A - a number):
	if A is not the address for a zero-length allocation:
		free the memory allocation at address A.

Book "Text"

Chapter "Printing Characters even without Unicode Support"

[Note that glk_put_char_uni has been replaced by a function using @streamchar and @streamunichar, so that the phrase works with other I/O systems.]

Include (-
	[ llo_printUnicode character unicodeSupported;
		@gestalt 5 0 unicodeSupported;
		if(unicodeSupported){
			@streamunichar character;
		}else if(character<=128){
			@streamchar character;
		}else{
			print "?";
		}
	];
-).

To say (ch - unicode character) -- running on (documented at phs_unicode): (- llo_printUnicode({ch}); -).

Chapter "Filter I/O"

To say invoking (F - a phrase number -> nothing) once for each character code -- beginning say_invoking: (- @getiosys sp sp; @aload {F} 1 sp; @setiosys 1 sp; -).
To say end invoking -- ending say_invoking: (- @stkswap; @setiosys sp sp; -).

Chapter "Latin-1 Arrays"

Include (-
	Global llo_cocoaTargetAddress;
	Global llo_cocoaSpaceRemaining;
	Global llo_cocoaGlkDetected;
	Global llo_stringToArrayChoice;
-) after "Definitions.i6t".

Include (-
	[ llo_stringToArray text array length metrics oldStream stream i;
		oldStream=glk_stream_get_current();
		stream=glk_stream_open_memory(array,length,filemode_Write,0);
		if(~~stream){
			rfalse;
		}
		@push say__p;
		@push say__pc;
		glk_stream_set_current(stream);
		if(llo_getByte(text)==224 or 225 or 226){
			print (string)text;
		}else{
			text();
		}
		glk_stream_set_current(oldStream);
		glk_stream_close(stream,metrics);
		@pull say__pc;
		@pull say__p;
	];

	! Using the above implementation, CocoaGlk spends too much time flushing streams, and as a result some ordinarily split-second operations in Debug File Parsing take half a minute or so.  If we detect CocoaGlk, we want the option of the filter I/O system available.

	[ llo_cocoaPrint character;
		if(llo_cocoaSpaceRemaining>0){
			@astoreb llo_cocoaTargetAddress 0 character;
			llo_cocoaTargetAddress++;
		}
		llo_cocoaSpaceRemaining--;
	];

	[ llo_stringToArrayCocoa text array length metrics oldStream original i;
	#ifndef COCOA_QUIET;
		oldStream=glk_stream_get_current();
		glk_stream_set_current(0); ! to error out on attempts to set a style
	#endif;
		@push say__p;
		@push say__pc;
		@getiosys sp sp;
		@setiosys 1 llo_cocoaPrint;
		@push llo_cocoaTargetAddress;
		@push llo_cocoaSpaceRemaining;
		llo_cocoaTargetAddress=array;
		llo_cocoaSpaceRemaining=length;
		if(llo_getByte(text)==224 or 225 or 226){
			print (string)text;
		}else{
			text();
		}
		length=length-llo_cocoaSpaceRemaining;
		@astore metrics 0 0;
		@astore metrics 1 length;
		@pull llo_cocoaSpaceRemaining;
		@pull llo_cocoaTargetAddress;
		@stkswap;
		@setiosys sp sp;
		@pull say__pc;
		@pull say__p;
	#ifndef COCOA_QUIET;
		glk_stream_set_current(oldStream);
	#endif;
	];

	Array llo_cocoaKeyWindowCheck --> 1;
	[ llo_stringToArrayChoosingRule root nonroot recreateRoot rootType rootRock firstWindow secondWindow;
		@getiosys sp sp;
		@setiosys 2 0;
		! Detect CocoaGlk via Inform bug 819, without falling afoul of Inform bug 961.
		llo_cocoaGlkDetected=false;
		root=glk_window_get_root();
		recreateRoot=false;
		if(root){
			for(nonroot=0:nonroot=glk_window_iterate(nonroot,0):){
				if(nonroot~=root){
					break;
				}
			}
			if(nonroot){
				firstWindow=glk_window_open(nonroot,winmethod_Below+winmethod_Proportional,50,wintype_TextBuffer,0);
				if(~~firstWindow){
					jump L0;
				}
				secondWindow=glk_window_open(firstWindow,winmethod_Below+winmethod_Proportional,50,wintype_TextBuffer,0);
				if(~~secondWindow){
					jump L1;
				}
			}else{
				! We're in a catch-22: we don't know if we're running under CocoaGlk, but if we check, we might trip a CocoaGlk bug (961) that will make the whole story invisible.  At the moment we duck out of the dilemma by destroying the lone window and then recreating it.  That leads to some side-effects: lost text, forgotten style hints, etc., not to mention possible invalidation of references, but they all seem less severe than the risk of a permanently blank gray screen.
				recreateRoot=true;
				rootType=glk_window_get_type(root);
				rootRock=glk_window_get_rock(root);
				glk_window_close(root);
				firstWindow=glk_window_open(0,0,0,wintype_TextBuffer,0);
				if(~~firstWindow){
					jump L0;
				}
				secondWindow=glk_window_open(firstWindow,winmethod_Below+winmethod_Proportional,50,wintype_TextBuffer,0);
				if(~~secondWindow){
					jump L1;
				}
			}
		}else{
			firstWindow=glk_window_open(0,0,0,wintype_TextBuffer,0);
			if(~~firstWindow){
				jump L0;
			}
			secondWindow=glk_window_open(firstWindow,winmethod_Below+winmethod_Proportional,50,wintype_TextBuffer,0);
			if(~~secondWindow){
				jump L1;
			}
		}
		glk_window_get_arrangement(glk_window_get_parent(firstWindow),0,0,llo_cocoaKeyWindowCheck);
		llo_cocoaGlkDetected=(llo_cocoaKeyWindowCheck-->0)==firstWindow;
		glk_window_close(secondWindow,0);
	.L1;
		glk_window_close(firstWindow,0);
	.L0;
		if(recreateRoot){
			glk_window_open(0,0,0,rootType,rootRock);
		}
		@stkswap;
		@setiosys sp sp;
		if(llo_cocoaGlkDetected){
			llo_stringToArrayChoice=llo_stringToArrayCocoa;
		}else{
			llo_stringToArrayChoice=llo_stringToArray;
		}
		rfalse;
	];
-).

To print the text (T - some text) to the Latin-1 array at address (A - a number) with length (L - a number) and metrics structure at address (M - a number): (- llo_stringToArrayChoice({T},{A},{L},{M}); -).

The string-to-array implementation choosing rule translates into I6 as "llo_stringToArrayChoosingRule".

Section "CocoaGlk Detection Flag" - unindexed

[Other low-level extensions might want to reuse our work sniffing the Glk implementation.]
To decide whether CocoaGlk is detected: (- llo_cocoaGlkDetected -).

Section "CocoaGlk Sniffing" (for use without Glulx Runtime Instrumentation Framework by Brady Garvin)

The string-to-array implementation choosing rule is listed before the initialise memory rule in the startup rulebook.

Chapter "Length of Text Printed by a Phrase"

Include (-
	Array llo_streamToStringMetrics --> 0 0;
	Array llo_stringPrefix --> 8;
	Global llo_oldStream;
	Global llo_stream;
-) after "Definitions.i6t".

[This phrase is not used often enough for it's own CocoaGlk performance workaround.]
To record the number of characters printed when we (P - a phrase): (-
	@push say__p;
	@push say__pc;
	llo_oldStream=glk_stream_get_current();
	! To workaround a bug in some Glk implementations, use 1, not 0, as the array argument
	llo_stream=glk_stream_open_memory(1,0,filemode_Write,llo_streamToStringMetrics);
	if(llo_stream){
		glk_stream_set_current(llo_stream);
		if(true) {P}
		glk_stream_set_current(llo_oldStream);
		glk_stream_close(llo_stream,llo_streamToStringMetrics);
	}
	@pull say__pc;
	@pull say__p;
-).

To decide what number is the number of characters recorded: (- llo_getField(llo_streamToStringMetrics,1) -).

Chapter "Text Length"

Include (-
	[ llo_stringLength text length;
		! To workaround a bug in some interpreters' Glk safety checks, use 1, not 0, as the array argument
		if(llo_stringToArrayChoice(text,1,0,llo_streamToStringMetrics)){
			return llo_getField(llo_streamToStringMetrics,1);
		}
		return 0;
	];
-).

To decide what number is the length of (T - some text): (- llo_stringLength({T}) -).

Chapter "Text Hashing"

Section "Normal Hashing of Text"

Include (-
	[ llo_stringHash32 text;
		llo_zero(32,llo_stringPrefix);
		if(llo_stringToArrayChoice(text,llo_stringPrefix,32,llo_streamToStringMetrics)){
			return
				llo_getInt(llo_stringPrefix)+
				llo_getField(llo_stringPrefix,1)+
				llo_getField(llo_stringPrefix,2)+
				llo_getField(llo_stringPrefix,3)+
				llo_getField(llo_stringPrefix,4)+
				llo_getField(llo_stringPrefix,5)+
				llo_getField(llo_stringPrefix,6)+
				llo_getField(llo_stringPrefix,7);
		}
		return 0;
	];
-).

To decide what number is the normal hash of (T - some text): (- llo_stringHash32({T}) -).

Book "Type Unsafety"

Chapter "Type Conversion"

To decide what K is (V - a value) converted to --/a/an/some (D - a description of values of kind K): (- {V} -).

Chapter "Type Identification"

Definition: a number is a function type indicator if it is 192 or it is 193.
Definition: a number is a string type indicator if it is 224 or it is 225 or it is 226.
Definition: a number is a object type indicator if it is at least 112 and it is at most 127.

To decide whether address (A - a number) could contain a function:
	if A is an invalid byte address:
		decide no;
	decide on whether or not the byte at address A is a function type indicator.

To decide whether address (A - a number) could not contain a function:
	if A is not an invalid byte address:
		decide no;
	decide on whether or not the byte at address A is a function type indicator.

To decide whether address (A - a number) could contain a string:
	if A is an invalid byte address:
		decide no;
	decide on whether or not the byte at address A is a string type indicator.

To decide whether address (A - a number) could not contain a string:
	if A is not an invalid byte address:
		decide no;
	decide on whether or not the byte at address A is a string type indicator.

To decide whether address (A - a number) could contain an object:
	if A is an invalid byte address:
		decide no;
	decide on whether or not the byte at address A is an object type indicator.

To decide whether address (A - a number) could not contain an object:
	if A is not an invalid byte address:
		decide no;
	decide on whether or not the byte at address A is an object type indicator.

Chapter "Workarounds for Inform Bug 473"

To decide whether (P - a phrase nothing -> nothing) applied (documented at ph_applied0): (- {-function-application} -).

To decide whether (P - a phrase value of kind K -> nothing) applied to (X - a K) (documented at ph_applied1): (- {-function-application} -).

To decide whether (P - a phrase (value of kind K, value of kind L) -> nothing) applied to (X - a K) and (Y - an L) (documented at ph_applied2): (- {-function-application} -).

To decide whether (P - a phrase (value of kind K, value of kind L, value of kind M) -> nothing) applied to (X - a K) and (Y - an L) and (Z - an M) (documented at ph_applied3): (- {-function-application} -).

Book "Loops"

Chapter "Loops without Built-in End Conditions"

To repeat until a break begin -- end: (- for(::) -).

Chapter "Loops over Half-Open Intervals"

To repeat with (I - a nonexisting K variable) running over the half-open interval from (J - an arithmetic value of kind K) to (K - a K) begin -- end: (- for({I}={J}:{I}<{K}:{I}++) -).

Chapter "Implicit Loops"

Section "Linear Searches"

Include (-
	[ llo_byteIndex needle haystack haystackLength result;
		if(haystackLength<=0){
			return -1;
		}
		@linearsearch needle 1 haystack 1 haystackLength 0 4 result;
		return result;
	];
	[ llo_shortIndex needle haystack haystackLength result;
		! haystackLength is measured in shorts, not bytes
		if(haystackLength<=0){
			return -1;
		}
		@linearsearch needle 2 haystack 2 haystackLength 0 4 result;
		return result;
	];
	[ llo_intIndex needle haystack haystackLength result;
		! haystackLength is measured in ints, not bytes
		if(haystackLength<=0){
			return -1;
		}
		@linearsearch needle 4 haystack 4 haystackLength 0 4 result;
		return result;
	];
	[ llo_byteSubsequenceIndex needle needleLength haystack haystackLength possibilities result;
		if(needleLength>haystackLength){
			return -1;
		}
		possibilities=1+haystackLength-needleLength;
		@linearsearch needle needleLength haystack 1 possibilities 0 5 result;
		return result;
	];
	[ llo_shortSubsequenceIndex needle needleLength haystack haystackLength possibilities result;
		if(needleLength>haystackLength){
			return 0;
		}
		possibilities=1+haystackLength-needleLength;
		needleLength=needleLength*2;
		@linearsearch needle needleLength haystack 4 possibilities 0 5 result;
		return result;
	];
	[ llo_intSubsequenceIndex needle needleLength haystack haystackLength possibilities result;
		if(needleLength>haystackLength){
			return 0;
		}
		possibilities=1+haystackLength-needleLength;
		needleLength=needleLength*4;
		@linearsearch needle needleLength haystack 4 possibilities 0 5 result;
		return result;
	];
	[ llo_byteAddress needle haystack haystackLength result;
		if(haystackLength<=0){
			return 0;
		}
		@linearsearch needle 1 haystack 1 haystackLength 0 0 result;
		return result;
	];
	[ llo_shortAddress needle haystack haystackLength result;
		! haystackLength is measured in shorts, not bytes
		if(haystackLength<=0){
			return 0;
		}
		@linearsearch needle 2 haystack 2 haystackLength 0 0 result;
		return result;
	];
	[ llo_intAddress needle haystack haystackLength result;
		! haystackLength is measured in ints, not bytes
		if(haystackLength<=0){
			return 0;
		}
		@linearsearch needle 4 haystack 4 haystackLength 0 0 result;
		return result;
	];
	[ llo_byteSubsequenceAddress needle needleLength haystack haystackLength possibilities result;
		if(needleLength>haystackLength){
			return 0;
		}
		possibilities=1+haystackLength-needleLength;
		@linearsearch needle needleLength haystack 1 possibilities 0 1 result;
		return result;
	];
	[ llo_shortSubsequenceAddress needle needleLength haystack haystackLength possibilities result;
		if(needleLength>haystackLength){
			return 0;
		}
		possibilities=1+haystackLength-needleLength;
		needleLength=needleLength*2;
		@linearsearch needle needleLength haystack 4 possibilities 0 1 result;
		return result;
	];
	[ llo_intSubsequenceAddress needle needleLength haystack haystackLength possibilities result;
		if(needleLength>haystackLength){
			return 0;
		}
		possibilities=1+haystackLength-needleLength;
		needleLength=needleLength*4;
		@linearsearch needle needleLength haystack 4 possibilities 0 1 result;
		return result;
	];
-).

To decide what number is the index of the byte (B - a number) in the (N - a number) bytes at address (A - a number): (- llo_byteIndex({B},{A},{N}) -).
To decide what number is the index of the short (S - a number) in the (N - a number) shorts at address (A - a number): (- llo_shortIndex({S},{A},{N}) -).
To decide what number is the index of the integer (I - a number) in the (N - a number) integers at address (A - a number): (- llo_intIndex({I},{A},{N}) -).
To decide what number is the index of the (N - a number) bytes at address (A - a number) in the (M - a number) bytes at address (B - a number): (- llo_byteSubsequenceIndex({A},{N},{B},{M}) -).
To decide what number is the index of the (N - a number) shorts at address (A - a number) in the (M - a number) shorts at address (B - a number): (- llo_shortSubsequenceIndex({A},{N},{B},{M}) -).
To decide what number is the index of the (N - a number) integers at address (A - a number) in the (M - a number) integers at address (B - a number): (- llo_intSubsequenceIndex({A},{N},{B},{M}) -).

To decide what number is the address of the byte (B - a number) in the (N - a number) bytes at address (A - a number): (- llo_byteAddress({B},{A},{N}) -).
To decide what number is the address of the short (S - a number) in the (N - a number) shorts at address (A - a number): (- llo_shortAddress({S},{A},{N}) -).
To decide what number is the address of the integer (I - a number) in the (N - a number) integers at address (A - a number): (- llo_intAddress({I},{A},{N}) -).
To decide what number is the address of the (N - a number) bytes at address (A - a number) in the (M - a number) bytes at address (B - a number): (- llo_byteSubsequenceAddress({A},{N},{B},{M}) -).
To decide what number is the address of the (N - a number) shorts at address (A - a number) in the (M - a number) shorts at address (B - a number): (- llo_shortSubsequenceAddress({A},{N},{B},{M}) -).
To decide what number is the address of the (N - a number) integers at address (A - a number) in the (M - a number) integers at address (B - a number): (- llo_intSubsequenceAddress({A},{N},{B},{M}) -).

Chapter "Ingredients for Complicated Loops"

Include (-
	Global llo_oneTime=false;
	Global llo_broken=true;
	Global llo_advance=true;
-) after "Definitions.i6t".

Book "Function Pointers"

Chapter "Obtaining Function Addresses"

To decide what number is the function address of (N - a number): (- {N} -).  [This is so taking the function address is idempotent.]
To decide what number is the function address of (R - a rule): (- {R} -).  [This is so rules don't fall into the broader case of sayable values.]
To decide what number is the function address of (P - sayable value): (- llo_getField({P},1) -).  [This is so we catch all kinds of phrases with just one phrase.]

Chapter "Calling Functions by Address"

To call the function at address (A - a number): (- (({A})()); -).
To call the function at address (A - a number) passing (V - a value): (- (({A})({V})); -).

Chapter "Rulebook Traversal"

Include (-
	[ llo_traverseRulebook rulebook i j k;
		! We would like to think of the rulebook argument in terms of an array of rules, rather than as an index for rulebooks_array.
		rulebook=llo_getField(rulebooks_array,rulebook);
		! Inform has two formats for rulebooks, one of which is cued by an initial -2.
		j=llo_getInt(rulebook);
		if(j==-2){
			! Rules are divided into blocks with headers that say when they apply and how large they are.
			! We ignore the conditions, but we need to be sure that we don't dereference them as rules.
			for(i=3:j~=NULL:i=i+2){                      ! An outer loop where i points to the beginning of a block's rules; the header size is two entries.
				k=llo_getField(rulebook,i-1);        ! The block length is usually in the previous entry; let k be it
				if(k<1||k>31){                       ! If k is not in fact a block length,
					k=1;                         ! the block length is one
					i--;                         ! and elided
				}
				for(j=llo_getField(rulebook,i),      ! i has moved each time we enter this inner loop, so we need to recompute j.
				    k=i+k:                           ! Now let k be the index where the next block starts.
				    i<k:                             ! Run the inner loop until the end of the block.
				    ++i,j=llo_getField(rulebook,i)){ ! Increment in the same way as in the simple case.
					j();
				}
			}
		}else{
			! Everything in the array is a rule address; life is simple.
			for(i=0:j~=NULL:++i,j=llo_getField(rulebook,i)){
				j();
			}
		}
	];

	[ llo_shortCircuitTraverseRulebook rulebook i j k;
		! We would like to think of the rulebook argument in terms of an array of rules, rather than as an index for rulebooks_array.
		rulebook=llo_getField(rulebooks_array,rulebook);
		! Inform has two formats for rulebooks, one of which is cued by an initial -2.
		j=llo_getInt(rulebook);
		if(j==-2){
			! Rules are divided into blocks with headers that say when they apply and how large they are.
			! We ignore the conditions, but we need to be sure that we don't dereference them as rules.
			for(i=3:j~=NULL:i=i+2){                      ! An outer loop where i points to the beginning of a block's rules; the header size is two entries.
				k=llo_getField(rulebook,i-1);        ! The block length is usually in the previous entry; let k be it
				if(k<1||k>31){                       ! If k is not in fact a block length,
					k=1;                         ! the block length is one
					i--;                         ! and elided
				}
				for(j=llo_getField(rulebook,i),      ! i has moved each time we enter this inner loop, so we need to recompute j.
				    k=i+k:                           ! Now let k be the index where the next block starts.
				    i<k:                             ! Run the inner loop until the end of the block.
				    ++i,j=llo_getField(rulebook,i)){ ! Increment in the same way as in the simple case.
					if(j()){
						rtrue;
					}
				}
			}
		}else{
			! Everything in the array is a rule address; life is simple.
			for(i=0:j~=NULL:++i,j=llo_getField(rulebook,i)){
				if(j()){
					rtrue;
				}
			}
		}
	];
-).

To traverse (R - a rulebook): (- llo_traverseRulebook({R}); -).

To traverse (R - a rulebook) with short-circuiting: (- llo_shortCircuitTraverseRulebook({R}); -).

To rule short-circuits rulebook traversal: (- rtrue; -).

Book "Checking Gestalts"

Include (-
	[ llo_checkGestalt primary secondary;
		@gestalt primary secondary sp;
		@return sp;
	];
	[ llo_getStaticMemorySize result;
		result=llo_checkGestalt(8,0);
		if(result){
			return result;
		}
		return llo_getMemorySize();
	];
-).

To decide what number is the encoded Glulx version: (- llo_checkGestalt(0,0) -).
To decide what number is the encoded interpreter version: (- llo_checkGestalt(1,0) -).
To decide what number is the size of statically allocated memory: (- llo_getStaticMemorySize() -).

To decide whether memory map resizes are supported: (- llo_checkGestalt(2,0) -).
To decide whether undo is supported: (- llo_checkGestalt(3,0) -).
To decide whether Glk is supported: (- llo_checkGestalt(4,2) -).
To decide whether Unicode is supported: (- llo_checkGestalt(5,0) -).
To decide whether block memory copies are supported: (- llo_checkGestalt(6,0) -).
To decide whether memory allocation is supported: (- llo_checkGestalt(7,0) -).
To decide whether there are outstanding memory allocations: (- llo_checkGestalt(8,0) -).
To decide whether function acceleration is supported: (- llo_checkGestalt(9,0) -).

Book "Pushing and Popping"

To push (X - a value of kind K): (- llo_transfer={X};@push llo_transfer; -).
To pop/pull (X - a value of kind K variable): (- @pull llo_transfer;{X}=llo_transfer; -).

Low-Level Operations ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Low-Level Operations makes other extensions easier to write by wrapping common
uses of I6 and Glulx assembly code in human-friendly I7 phrases.  Bit-level
arithmetic, access to memory by address, and unsafe conversions between kinds
are all included, as well as a few more obscure features, like unsigned numbers
and the ability to check Glulx gestalts.

Details are in the following chapters.

Chapter: Usage

Section: Checking interpreter support

One of the features available through Low-Level Operations, dynamic memory,
won't function under older interpreters, and may in fact crash the story.  But
we can check in advance:

	unless memory allocation is supported:
		....

The same system also lets us test other interpreter capabilities:

	if memory map resizes are supported:
		....

	if undo is supported:
		....

	if Glk is supported:
		....

	if Unicode is supported:
		....

	if block memory copies are supported:
		....

	if function acceleration is supported:
		....

and access version numbers as the constant values

	the encoded Glulx version

and

	the encoded interpreter version

Section: Bit-level operations

Under Glulx, Inform's numbers are represented in 32-bit, two's complement form.
We can perform bitwise operations on these representations with four phrases:

	the bitwise and of (I - a number) and (J - a number)

	the bitwise or of (I - a number) and (J - a number)

	the bitwise xor of (I - a number) and (J - a number)

	the bitwise not of (I - a number)

Similarly, we can also shift a representation's bits to the left or right.  In
the former case, the least significant bits are filled with zeros, so

	(I - a number) shifted (J - a number) bits left

is 484 if I is 121 and J is 2.  But in the latter case, the most significant
bits can be filled either with zeros or the original sign bit, depending on
whether we want to treat the number as unsigned:

	(I - a number) logically shifted (J - a number) bit right

or signed:

	(I - a number) arithmetically shifted (J - a number) bit right

Thus, the logical shift produces the value 2,147,483,587 when I is -121 and J is
one, but the arithmetic shift gives -61 for the same inputs.

Sign extension is also provided for cases where we need to deal with varying
word size.  We use the term "byte" to mean an 8-bit word, "short" for a 16-bit
word, and "integer" for a 32-bit word.  Sign extension from an integer is
pointless on a 32-bit virtual machine, but we do have phrases for the other word
sizes:

	(I - a number) sign extended from a byte

	(I - a number) sign extended from a short

Note that bits beyond the given word size are ignored, so that

	385 sign extended from a byte

is the same as extending 129; the excess 256 makes no difference.

Section: Unsigned numbers

We have four phrases available for the unsigned comparison of numbers.  In each
of these examples, the phrases treat negative numbers as larger by
4,294,967,296:

	if (I - a number) is unsigned less than (J - a number):
		....

	if (I - a number) is unsigned at most (J - a number):
		....

	if (I - a number) is unsigned at least (J - a number):
		....

	if (I - a number) is unsigned more than (J - a number):
		....

"Fewer than" and "greater than" are recognized as synonyms of "less than" and
"more than," respectively.

Though we cannot write large unsigned numbers in the source text, the story file
can say them by way of

	say (I - a number) as unsigned

To illustrate, here is the largest unsigned value that can be represented in one
Glulx word:

	say "[-1 as unsigned]";

Section: Saying numbers in other bases

When we are working near to the virtual machine, it's often handy to think of
numbers in binary or hexadecimal.  Accordingly we can ask the story to say values
in either of those bases:

	say (I - a number) in binary

or

	say (I - a number) in hexadecimal

If I is 92, the former prints "0b1011100," and the latter "0x5C."  If we wish,
we can omit the "0b" and the "0x", as in

	say (I - a number) in unprefixed binary

and

	say (I - a number) in unprefixed hexadecimal

which produce "1011100" and "5C", respectively, for the same value of I.

Section: Conversions

In some circumstances we want to think of one value as having several
incompatible kinds.  We can convert such a value to another kind with this
phrase:

	(V - a value) converted to --/a/an/some (K - a kind)

Conversions of this sort are inherently unsafe, and should only be used as
described in the following sections or grounded in a solid understanding of
Inform's internals.

Some very light safety checks are included with Low-Level operations.  The
phrase

	if address (A - a number) could contain a function:
		....

for instance, will verify that the byte at address A is one of the Glulx
function type indicators; the phrase

	if address (A - a number) could not contain a function:
		....

will do the opposite.  "Function" can be replaced with "string" to check for any
of the Glulx string types or "object" to check for an Inform object.  A matching
type indicator byte is not a guarantee about what sort of data occupies an
address, but a mismatched type indicator is at least probable if we attempt an
impossible conversion.

Section: Measuring memory

Under Glulx, Inform's memory is arranged as a single logical address space.
Lower addresses are read-only, higher addresses are read-write---the upper part
of which holds dynamic allocations---and even higher addresses are off-limits.
We can identify these boundaries with three phrases:

	the size of read-only memory

will report the number of bytes that are read-only; addresses zero up to this
number minus one are addresses pointing to read-only bytes.  Similarly,

	the size of statically allocated memory

will give the number of bytes that are statically allocated, both read-only and
read-write.  Finally,

	the size of memory

measures the number of bytes that can be legally accessed.

One caveat: all of these boundaries are reported as unsigned numbers, and they
could appear negative if we treat them as signed.

The most common use of the memory-measuring phrases is to distinguish valid and
invalid addresses, so Low-Level Operations provides suitable adjectives:

	if (I - a number) is a valid byte address:
		....

or, on the other hand,

	if (I - a number) is an invalid byte address:
		....

where in both cases we can substitute "short" or "integer" for "byte" to control
the amount of valid space we require after the address.

Section: Accessing memory

If we have a valid memory address, then we can inspect the contents of memory
with phrases like

	the byte at address (I - a number)

for one byte,

	the short at address (I - a number)

for two bytes, in big-endian order, and

	the integer at address (I - a number)

for four bytes, also in big-endian order.

Besides these three, we can also address memory at the nybble and bit levels.
(Nybble-level access is mostly for the benefit of the Glulx Runtime
Instrumentation Framework, because Glulx bytecode packs addressing modes two to
a byte.)

	the nybble at address (I - a number) and secondary address (J - a number)

refers to the low nybble when J is zero, the higher four bits when J is one.
The phrase's behavior when J is some other value is undefined.

	whether or not the bit at address (I - a number) and secondary address (J - a number) is set

is true if the Jth bit is on, and false otherwise.  In this case, J may extend
outside of the range 0--7.

Likewise, given a valid read-write address, we can modify the contents of
memory:

	write the bit (I - a truth state) to address (J - a number) and secondary address (K - a number)

modifies a single bit,

	write the nybble (I - a number) to address (J - a number) and secondary address (K - a number)

overwrites a nybble,

	write the byte (I - a number) to address (J - a number)

changes one byte,

	write the short (I - a number) to address (J - a number)

alters two bytes, in big-endian order, and

	write the integer (I - a number) to address (J - a number)

replaces an entire four-byte word.

In the case that we are clearing or copying memory, we also have the option to
work on even larger swaths:

	zero (I - a number) bytes at address (J - a number)

which will zero out byte number J up to, but not including byte number I+J, or

	copy (I - a number) bytes from address (J - a number) to address (K - a number)

which will overwrite the I bytes beginning at address K with the I bytes
beginning at address J, taking care not to lose data when the source and
destination ranges overlap.  (This phrase does not require the interpreter to
support block memory copies, but it will run faster if such support is present.)

Values can also be saved to and restored from the call stack in non-addressable
memory.  The phrase

	push (X - a value of kind K)

places a copy of X on the top of the stack.  The corresponding phrase

	pop/pull (X - a value of kind K variable)

sets X to a value taken off of the top of stack, converting it if necessary (see
the section on conversions).

Section: Obtaining addresses

Inform has some kinds, called block values, that are internally represented as
the address of a structure.  We can obtain these addresses by borrowing a phrase
from the Conversions section:

	(V - a value) converted to a number

(But we should not expect non-block values to convert to valid addresses.
Non-block values will convert in a kind-dependent way, and the only guarantee is
that a number converted to a number will be itself.)

We can also obtain addresses by requesting the allocation of new memory.  The
phrase

	a memory allocation of (N - a number) bytes

will decide on the address of a fresh block of N bytes, if the interpreter
supports memory allocation (thus, we should check before using this phrase).

When we are done with the block, we should inform the interpreter so that the
memory can be reclaimed:

	free the memory allocation at address (A - a number)

If there is a chance that we might request zero bytes, we should add the words
"possibly zero-length" to avoid Glulx errors:

	a possibly zero-length memory allocation of (N - a number) bytes

and

	free the possibly zero-length memory allocation at address (A - a number)

All zero-length allocations share the same address, which is the constant

	address for a zero-length allocation

Memory allocations that we never intend to free should be designated with the
adjective "permanent"; on some interpreters this can result in a significant
speedup:

	a permanent memory allocation of (N - a number) bytes

or

	a possibly zero-length permanent memory allocation of (N - a number) bytes

Lastly, we can check whether all of the story's non-permanent non-zero-length
allocations have been freed:

	if there are outstanding memory allocations:
		....

Note that the outstanding memory allocations could also include allocations
requested by Inform's heap management system.

Section: Functions

We are not restricted to treating the contents of memory as data---we can also
treat them as code.  First, we have an overloaded phrase for locating Glulx
functions from rules or phrases:

	the function address of (V - a sayable value)

For instance, we might write:

	the function address of the block thinking rule

or, given

	To say the player's name (this is saying the player's name):
		say "[the player]".

we could compute

	the function address of saying the player's name

"Sayable value", of course, can describe things other than rules and phrases.
We must be careful not to take the function address of something that is
neither.  The value that we would get back would probably be meaningless, and in
rare cases we might even crash the story.

Once we have the address of a function, we can call it with no arguments using
this phrase:

	call the function at address (A - a number)

Again we must take care.  If we provide the address of a phrase taking values,
those values will be set to whatever their kind's equivalent of zero is.  For
some kinds, like truth states, times, and objects, the zero equivalent makes
sense, meaning false, or midnight, or nothing.  But for other kinds, zero could
spell disaster.  Passing zero as a phrase, for example, will cause the story to
interpret the version of Glulx it was compiled for as a code address, almost
certainly crashing the story.  The same precautions apply to invoking rules with
a basis.

Regarding rulebooks, besides "consider," "abide by," "anonymously abide by," and
"follow" as forms of consultation, Low-Level Operations adds one more,

	traverse (R - a rulebook)

Its job is to ignore the procedural rules (in older versions of Inform where the
procedural rules still exist) and give every rule in the rulebook a chance to
run.  For example, if we write

	The buy time rulebook is a rulebook.
	A buy time rule:
		say "Er..."
	A buy time rule:
		say "Um..."
	A procedural rule:
		ignore the first rule.

Then

	traverse the buy time rulebook;

will say both "Er..." and "Um...," even though the code tried to leave out the
first rule.

Rulebook traversal must be used with care: it does not have the infrastructure
to handle rulebook outcomes, not even simple ones like

	rule succeeds.

Such outcomes might leak back to other rulebooks or even cause an eventual story
crash.

However, we can still give rules the power to halt a rulebook traversal if we
write

	traverse (R - a rulebook) with short-circuiting

instead and then use the phrase

	rule short-circuits rulebook traversal

in the rule itself.

Section: Characters

A segmented substitution beginning with

	invoking (F - a phrase number -> nothing) once for each character code

and ending with

	end invoking

will cause F to be invoked on the Unicode codepoint of every character inside,
the characters being read from left to right.  For example, if we have

	To foo (C - a number) (this is fooing):
		....

then writing

	say "[invoking fooing once for each character code][twelve][end invoking]";

will cause the fooing phrase to be called twice, once with C set to 49 (the
codepoint for the digit 1), and another time with C set to 50 (the codepoint for
the digit 2).

The conversion phrase

	(V - a number) converted to a unicode character

changes a Unicode codepoint into the corresponding character.

	let the character be 8212 converted to a unicode character;

for instance, assigns an em dash to the variable.

Section: Text

If interested in the length of some text, we can use the phrase

	the length of (T - some text)

Note that taking the length of text with substitutions will mean executing those
substitutions, which could have side-effects.

Equivalently, if we want the length of the text printed by running some code, we
can employ the phrase

	record the number of characters printed when we (P - a phrase)

as in

	record the number of characters printed when we follow the block thinking rule;

and then use the companion phrase

	the number of characters recorded

to determine how much text was printed but hidden.

Neither of these length-measuring mechanisms are reentrant, which is to say that
we cannot safely compute the length of some text if we are already in the middle
of computing a text length.  If we absolutely need this capability, we must turn
to the lower-level phrase

	print the text (T - some text) to the Latin-1 array at address (A - a number) with length (N - a number) and metrics structure at address (M - a number)

The first N characters of T will then be printed to the byte array at address A
(with non-Latin-1 characters most likely converted to question marks), the
integer at address M will be cleared, and the integer at address M plus four
will hold the length of T (even if it exceeds N).  The N bytes at address A and
the eight bytes at address M should not be used at any point while T is being
printed.  Also, because of a story-crashing bug in older interpreters, you
should avoid using zero for A, even if N is zero.

(At present, T must not include formatting like "[roman type]"---doing so will
crash the story under CocoaGlk with an error about an "invalid strid".  To be
clear, the crash is not a CocoaGlk bug.  Rather, it is a consequence of a
workaround I applied to keep CocoaGlk from slowing the story down by frequently
flushing its buffers.)

Besides length, we occasionally also need a numeric summary of the contents of
some text, for instance to decide on a hash table bucket (the extension
Low-Level Hash Tables does this).  One such conversion is accomplished by the
phrase

	the normal hash of (T - some text)

This phrase is fairly fast, but be warned that it only considers the first 32
characters.

Section: Miscellaneous

We can also write loops that terminate only on a break statement:

	repeat until a break:
		....

or that include their first bound but not their second:

	repeat with (I - a name not used so far) running over the half-open interval from (J - an arithmetic value of kind K) to (K - a K):
		....

And we can search through an array for the first occurrence of a particular byte:

	the index of the byte (I - a number) in the (J - a number) bytes at address (K - a number)

or sequence of bytes:

	the index of the (I - a number) bytes at address (J - a number) in the (K - a number) bytes at address (L - a number)

If no match is found, these phrases decide on -1.

Similar phrases are available for arrays of shorts:

	the index of the short (I - a number) in the (J - a number) shorts at address (K - a number)

	the index of the (I - a number) shorts at address (J - a number) in the (K - a number) shorts at address (L - a number)

and integers:

	the index of the integer (I - a number) in the (J - a number) integers at address (K - a number)

	the index of the (I - a number) integers at address (J - a number) in the (K - a number) integers at address (L - a number)

For addresses instead of indices, we substitute the word "address" for "index".
For example,

	the address of the byte (I - a number) in the (J - a number) bytes at address (K - a number)

In no match is found, these variations decide on zero.

Section: Ingredients for constructing other low-level phrases

Building repeat phrases using I6 substitutions can be tricky business.  We may
need to have several iterators under the hood, even though the author sees only
one, but we can't declare these iterators with globals (nested loops would
clobber each other's memory) or with invocation labels, counters, and storage (a
loop containing a recursive call would clobber its own memory).  To avoid
reinvented wheels, Low-Level Operations suggests the following standard strategy:

First, we use Glulx assembly to maintain the side iterators on the VM stack.
That way, if function stops or decides on a value or throws an exception in the
middle of the repeat, the iterators will be cleaned up automatically.  @push,
@pull, and @stkpeek are, unfortunately, not allowed inside of the parentheses of
an I6 "for", but let us ignore that problem for a moment.

For example, suppose that we want a loop to repeat through the function values
from f(0) to f(9).  In pseudo-Inform, it looks like this.  (If you are reading
this in HTML format, the inline I6 might be compressed to one line.  And in
Inform versions 6G60 and earlier, some of the code might not be visible.  View
the extension source text for a more legible version.)

	To repeat with (I - a nonexisting number variable) running over the ten function values begin -- end: (-
		for({hidden-iterator}=0:{hidden-iterator}<10:{hidden-iterator}={hidden-iterator}+1){
			{I}=f({hidden-iterator});
			{loop-body};
		}
	-).

Placing the hidden iterator on the VM stack during the invocation of f and
during the loop body, we obtain this pseudo-Inform:

	Include (-
		Global transferValue;
	-) after "Definitions.i6t".
	To repeat with (I - a nonexisting number variable) running over the ten function values begin -- end: (-
		for(transferValue=0:@push transferValue;transferValue<10:@pull transferValue;transferValue=transferValue+1){
			{I}=f(transferValue);
			{loop-body};
		}
		@pull transferValue;
	-).

(Note that the first pull into transferValue cannot happen below the loop body
because then a continue would skip over it.  Likewise, the second pull needs to
be where it is in case of a break.)

Now both f and the loop body could clobber the contents of the global variable,
transferValue, without disrupting the loop.  But we still have to make this
definition into legal Inform.  To do so, we match it against this template:

	To repeat ... begin -- end: (-
		for(A:B:C){
			D;
			{loop-body};
		}
		E;
	-).

where the letters A through E indicate arbitrary code.  So A is

	transferValue=0;

B is

	@push transferValue;
	transferValue<10

and so on.  Then we substitute these letters into this template:

	To repeat ... begin -- end: (-
		A;
		jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
		for(::)
			if(llo_advance){
				if(llo_broken){
					E;
					break;
				}
				C;
			.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
				llo_advance=llo_broken=~~B;
				if(~~llo_broken){
					D;
				}
			}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
	-).

which in our example produces

	Include (-
		Global transferValue;
	-) after "Definitions.i6t".
	To repeat with (I - a nonexisting number variable) running over the ten function values begin -- end: (-
		transferValue=0;
		jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
		for(::)
			if(llo_advance){
				if(llo_broken){
					@pull transferValue;
					break;
				}
				@pull transferValue;
				transferValue=transferValue+1;
			.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
				@push transferValue;
				llo_advance=llo_broken=(transferValue>=10);
				if(~~llo_broken){
					{I}=f(transferValue);
				}
			}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
	-).

The three variables beginning with llo_ are provided by Low-Level Operations.
Like transferValue, they are only used in ways that cannot clobber the state of
other ongoing loops.  (Unless, of course, we modify them in one of the A--E
blocks.)

Although a tad convoluted, this new version has exactly the same semantics as
the previous one, it handles breaks, continues, exception throws,
etc. correctly, and, most importantly, it is legal Inform.

Chapter: Requirements, Limitations and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Dynamic memory allocation, one of the features exposed by Low-Level Operations,
is not supported by all interpreters.  See the section "Checking Interpreter
Support" below.

Section: Obscure limitations, which should affect almost nobody

A few other actions, like throwing an exception or calling glk_set_stream, ought
not to take place inside text routines used with these phrases, for reasons that
are hopefully obvious.  Inform will never pull such shenanigans on its own.

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

Low-Level Operations was prepared as part of the Glulx Runtime Instrumentation
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

Example: *** Machine Code - Writing a function on the fly

Glulx functions, like all computer data, are merely sequences of numbers in
memory.  If we're careful, we can take advantage of this fact to create new
story code on the fly.

For this example, our objective is to create a rule printing "Hello World", run
the rule, and then destroy it.  Consulting Section 1.6.2 of the Glulx
specification, we find that we can write a function taking no arguments by
beginning with the bytes

	0xC1 0x00 0x00

Then, proceeding to the dictionary of operation codes in Section 2, we find
several alternatives for printing text.  The simplest looks to be printing
character by character with @streamchar, which has operation code 0x70.
Following the explanation in Section 1.5 for formatting instructions, we choose
addressing mode 0x01 to accommodate a constant Latin-1 character code.  Thus,
for 'H', which is 0x48 in Latin-1, we have these three bytes:

	0x70 0x01 0x48

Repeating with the remaining characters, we get:

	0x70 0x01 0x65
	0x70 0x01 0x6C
	0x70 0x01 0x6C
	0x70 0x01 0x6F
	0x70 0x01 0x20
	0x70 0x01 0x57
	0x70 0x01 0x6F
	0x70 0x01 0x72
	0x70 0x01 0x6C
	0x70 0x01 0x64

Finally, we need a return instruction to finish the function.  Again, looking at
the operation code dictionary, we find that we need

	0x31 0x00

to return zero.

Packing these bytes four to an integer in big-endian order gives us

	0xC1000070
	0x01487001
	0x6570016C
	0x70016C70
	0x016F7001
	0x20700157
	0x70016F70
	0x01727001
	0x6C700164
	0x3100 (two bytes only)

which in signed decimal is

	-1056964496
	21524481
	1701839212
	1879141488
	24080385
	544211287
	1879142256
	24276993
	1819279716
	12544 (two bytes only)

Now all we need to do is allocate some memory, write these values, and invoke
our newly written function:

	let the just-in-time compilation address be a memory allocation of 38 bytes;
	write the integer -1056964496 to address just-in-time compilation address;
	write the integer 21524481 to address just-in-time compilation address plus four;
	write the integer 1701839212 to address just-in-time compilation address plus eight;
	write the integer 1879141488 to address just-in-time compilation address plus twelve;
	write the integer 24080385 to address just-in-time compilation address plus 16;
	write the integer 544211287 to address just-in-time compilation address plus 20;
	write the integer 1879142256 to address just-in-time compilation address plus 24;
	write the integer 24276993 to address just-in-time compilation address plus 28;
	write the integer 1819279716 to address just-in-time compilation address plus 32;
	write the short 12544 to address just-in-time compilation address plus 36;
	call the function at address just-in-time compilation address;

We'll also clean up after ourselves and check that we didn't leak memory.

	free the memory allocation at address just-in-time compilation address;
	if there are outstanding memory allocations:
		....

(The check for leaks assumes that nothing else, in particular neither the
standard rules nor the template layer, has allocated memory.)

Putting it all in some context, we have a very short story:

	*: "Machine Code" by Brady Garvin
	
	Use no deprecated features.
	Include Low-Level Operations by Brady Garvin.
	
	The Lonely Computer Lab is a room.  "The computer purrs in greeting.  It knows that you've brought a program."
	
	A thing called the computer is scenery in the lonely computer lab.  "It whirrs happily."
	Instead of listening to the computer:
		try examining the computer.
	
	A thing called some punch cards is carried by the player.  The description of the punch cards is "A mere 38 bytes of machine code."
	
	Instead of inserting the punch cards into the computer:
		say "Here goes...[paragraph break]    [fixed letter spacing]";
		let the just-in-time compilation address be a memory allocation of 38 bytes;
		write the integer -1056964496 to address just-in-time compilation address;
		write the integer 21524481 to address just-in-time compilation address plus four;
		write the integer 1701839212 to address just-in-time compilation address plus eight;
		write the integer 1879141488 to address just-in-time compilation address plus twelve;
		write the integer 24080385 to address just-in-time compilation address plus 16;
		write the integer 544211287 to address just-in-time compilation address plus 20;
		write the integer 1879142256 to address just-in-time compilation address plus 24;
		write the integer 24276993 to address just-in-time compilation address plus 28;
		write the integer 1819279716 to address just-in-time compilation address plus 32;
		write the short 12544 to address just-in-time compilation address plus 36;
		call the function at address just-in-time compilation address;
		free the memory allocation at address just-in-time compilation address;
		if there are outstanding memory allocations:
			say "[variable letter spacing][paragraph break]Well, the output is correct, but that whiny hum means that you forgot to free memory somewhere.[no line break]";
			end the story saying "Huh?";
		otherwise:
			say "[variable letter spacing][paragraph break]Well, what do you know?[no line break]";
			end the story finally saying "It works!"
	
	Test me with "x computer / i / x cards / put cards in computer".

Of course, writing rules from scratch this way isn't very practical.  A more
useful technique is to automate the rewriting.  See the Glulx Runtime
Instrumentation Framework for an example.

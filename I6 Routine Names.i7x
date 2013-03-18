Version 1 of I6 Routine Names (for Glulx only) by Brady Garvin begins here.

"Associations between standard I6 routine names and their addresses."

[Future versions of this extension may need to distinguish versions of Inform.]
Include Compiler Version Checks by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[Nothing to mention here in the present version.]

Book "Compatibility"

Chapter "Extended Versions of Apply"

To apply (function - a phrase (value of kind K, value of kind L, value of kind M, value of kind N) -> nothing) to (input - K) and (second input - L) and (third input - M) and (fourth input - N): (- {-function-application}; -).

Book "Veneer Routines"

Chapter "Forced References to Veneer Routines" - unindexed

[RT__ChPR (checking the legality of reading from a property) is defined by the Glulx veneer, but, if I'm reading the compiler source rightly, there is no way for an I6 source text to cause it to be included.  Being dead code, we don't bother to give it a name.]

[We force the veneer routines to be included, if possible (RT__Ch* routines also require strict mode), by referencing them in dead code.]
Include (-
	[ isixrn_veneerReferences junk;
		if(true) rtrue;         ! Make sure the rest of the code is unreachable.
		! Routines are invoked on the left and noted on the right.
		! A parenthetical ``implicit'' means that routine is implicitly called elsewhere, and therefore referenced.
		box "";                 ! Box__Routine
		<Look>;                 ! R_Process
		print (the)0;           ! DefArt
		print (a)0;             ! InDefArt
		print (The)0;           ! CDefArt
		print (A)0;             ! CInDefArt
		print (name)0;          ! PrintShortName
		print (number)0;        ! EnglishNumber
		print (property)0;      ! Print__PName
		0.name=0;               ! WV__Pr
		junk=0.junk;            ! RV__Pr
		++(0.name);             ! IB__Pr
		(0.name)++;             ! IA__Pr
		--(0.name);             ! DB__Pr
		(0.name)--;             ! DA__Pr
		junk=0.&name;           ! RA__Pr
		junk=0.#name;           ! RL__Pr
		0.Class::create();      ! RA__Sc
		(0 provides name);      ! OP__Pr
		(0 ofclass Class);      ! OC__Cl
		Class.copy(0,0);        ! Copy__Primitive
		                        ! RT__Err (implicit)
		                        ! Z__Region (implicit)
		UnsignedCompare(0,0);   ! Unsigned__Compare
		metaclass(0);           ! Meta__class
		                        ! CP__Tab (implicit)
		                        ! Cl__Ms (implicit)
		move 0 to 0;            ! RT__ChT
		remove 0;               ! RT__ChR
		give 0 0;               ! RT__ChG
		give 0 ~0;              ! RT__ChGt
		                        ! RT__ChPS (implicit)
		                        ! RT__TrPS (implicit)
		junk=0->0;              ! RT__ChLDB
		junk=0-->0;             ! RT__ChLDW
		0->0=0;                 ! RT__ChSTB
		0-->0=0;                ! RT__ChSTW
		print (char)0;          ! RT__ChPrintC
		print (address)0;       ! RT__ChPrintA
		print (string)0;        ! RT__ChPrintS
		print (object)0;        ! RT__ChPrintO
		                        ! OB__Move (implicit)
		                        ! OB__Remove (implicit)
		                        ! Print__Addr (implicit)
		                        ! Glk__Wrap (implicit)
		string 0 0;             ! Dynam__String
	];
-).

Chapter "Override Indicators for Veneer Routines" - unindexed

Include (-
	#ifdef Box__Routine; Constant override_Box__Routine=1; #ifnot; Constant override_Box__Routine=0; #endif;
	#ifdef R_Process; Constant override_R_Process=1; #ifnot; Constant override_R_Process=0; #endif;
	#ifdef DefArt; Constant override_DefArt=1; #ifnot; Constant override_DefArt=0; #endif;
	#ifdef InDefArt; Constant override_InDefArt=1; #ifnot; Constant override_InDefArt=0; #endif;
	#ifdef CDefArt; Constant override_CDefArt=1; #ifnot; Constant override_CDefArt=0; #endif;
	#ifdef CInDefArt; Constant override_CInDefArt=1; #ifnot; Constant override_CInDefArt=0; #endif;
	#ifdef PrintShortName; Constant override_PrintShortName=1; #ifnot; Constant override_PrintShortName=0; #endif;
	#ifdef EnglishNumber; Constant override_EnglishNumber=1; #ifnot; Constant override_EnglishNumber=0; #endif;
	#ifdef Print__PName; Constant override_Print__PName=1; #ifnot; Constant override_Print__PName=0; #endif;
	#ifdef WV__Pr; Constant override_WV__Pr=1; #ifnot; Constant override_WV__Pr=0; #endif;
	#ifdef RV__Pr; Constant override_RV__Pr=1; #ifnot; Constant override_RV__Pr=0; #endif;
	#ifdef CA__Pr; Constant override_CA__Pr=1; #ifnot; Constant override_CA__Pr=0; #endif;
	#ifdef IB__Pr; Constant override_IB__Pr=1; #ifnot; Constant override_IB__Pr=0; #endif;
	#ifdef IA__Pr; Constant override_IA__Pr=1; #ifnot; Constant override_IA__Pr=0; #endif;
	#ifdef DB__Pr; Constant override_DB__Pr=1; #ifnot; Constant override_DB__Pr=0; #endif;
	#ifdef DA__Pr; Constant override_DA__Pr=1; #ifnot; Constant override_DA__Pr=0; #endif;
	#ifdef RA__Pr; Constant override_RA__Pr=1; #ifnot; Constant override_RA__Pr=0; #endif;
	#ifdef RL__Pr; Constant override_RL__Pr=1; #ifnot; Constant override_RL__Pr=0; #endif;
	#ifdef RA__Sc; Constant override_RA__Sc=1; #ifnot; Constant override_RA__Sc=0; #endif;
	#ifdef OP__Pr; Constant override_OP__Pr=1; #ifnot; Constant override_OP__Pr=0; #endif;
	#ifdef OC__Cl; Constant override_OC__Cl=1; #ifnot; Constant override_OC__Cl=0; #endif;
	#ifdef Copy__Primitive; Constant override_Copy__Primitive=1; #ifnot; Constant override_Copy__Primitive=0; #endif;
	#ifdef RT__Err; Constant override_RT__Err=1; #ifnot; Constant override_RT__Err=0; #endif;
	#ifdef Z__Region; Constant override_Z__Region=1; #ifnot; Constant override_Z__Region=0; #endif;
	#ifdef Unsigned__Compare; Constant override_Unsigned__Compare=1; #ifnot; Constant override_Unsigned__Compare=0; #endif;
	#ifdef Meta__class; Constant override_Meta__class=1; #ifnot; Constant override_Meta__class=0; #endif;
	#ifdef CP__Tab; Constant override_CP__Tab=1; #ifnot; Constant override_CP__Tab=0; #endif;
	#ifdef Cl__Ms; Constant override_Cl__Ms=1; #ifnot; Constant override_Cl__Ms=0; #endif;
	#ifdef RT__ChT; Constant override_RT__ChT=1; #ifnot; Constant override_RT__ChT=0; #endif;
	#ifdef RT__ChR; Constant override_RT__ChR=1; #ifnot; Constant override_RT__ChR=0; #endif;
	#ifdef RT__ChG; Constant override_RT__ChG=1; #ifnot; Constant override_RT__ChG=0; #endif;
	#ifdef RT__ChGt; Constant override_RT__ChGt=1; #ifnot; Constant override_RT__ChGt=0; #endif;
	#ifdef RT__ChPS; Constant override_RT__ChPS=1; #ifnot; Constant override_RT__ChPS=0; #endif;
	#ifdef RT__TrPS; Constant override_RT__TrPS=1; #ifnot; Constant override_RT__TrPS=0; #endif;
	#ifdef RT__ChLDB; Constant override_RT__ChLDB=1; #ifnot; Constant override_RT__ChLDB=0; #endif;
	#ifdef RT__ChLDW; Constant override_RT__ChLDW=1; #ifnot; Constant override_RT__ChLDW=0; #endif;
	#ifdef RT__ChSTB; Constant override_RT__ChSTB=1; #ifnot; Constant override_RT__ChSTB=0; #endif;
	#ifdef RT__ChSTW; Constant override_RT__ChSTW=1; #ifnot; Constant override_RT__ChSTW=0; #endif;
	#ifdef RT__ChPrintC; Constant override_RT__ChPrintC=1; #ifnot; Constant override_RT__ChPrintC=0; #endif;
	#ifdef RT__ChPrintA; Constant override_RT__ChPrintA=1; #ifnot; Constant override_RT__ChPrintA=0; #endif;
	#ifdef RT__ChPrintS; Constant override_RT__ChPrintS=1; #ifnot; Constant override_RT__ChPrintS=0; #endif;
	#ifdef RT__ChPrintO; Constant override_RT__ChPrintO=1; #ifnot; Constant override_RT__ChPrintO=0; #endif;
	#ifdef OB__Move; Constant override_OB__Move=1; #ifnot; Constant override_OB__Move=0; #endif;
	#ifdef OB__Remove; Constant override_OB__Remove=1; #ifnot; Constant override_OB__Remove=0; #endif;
	#ifdef Print__Addr; Constant override_Print__Addr=1; #ifnot; Constant override_Print__Addr=0; #endif;
	#ifdef Glk__Wrap; Constant override_Glk__Wrap=1; #ifnot; Constant override_Glk__Wrap=0; #endif;
	#ifdef Dynam__String; Constant override_Dynam__String=1; #ifnot; Constant override_Dynam__String=0; #endif;
-) after "RelationKind.i6t".

Chapter "Inlined Phrases for Veneer Routines"

To decide what number is the address of I6_Box__Routine: (- Box__Routine -).
To decide what number is the address of I6_R_Process: (- R_Process -).
To decide what number is the address of I6_DefArt: (- DefArt -).
To decide what number is the address of I6_InDefArt: (- InDefArt -).
To decide what number is the address of I6_CDefArt: (- CDefArt -).
To decide what number is the address of I6_CInDefArt: (- CInDefArt -).
To decide what number is the address of I6_PrintShortName: (- PrintShortName -).
To decide what number is the address of I6_EnglishNumber: (- EnglishNumber -).
To decide what number is the address of I6_Print__PName: (- Print__PName -).
To decide what number is the address of I6_WV__Pr: (- WV__Pr -).
To decide what number is the address of I6_RV__Pr: (- RV__Pr -).
To decide what number is the address of I6_CA__Pr: (- CA__Pr -).
To decide what number is the address of I6_IB__Pr: (- IB__Pr -).
To decide what number is the address of I6_IA__Pr: (- IA__Pr -).
To decide what number is the address of I6_DB__Pr: (- DB__Pr -).
To decide what number is the address of I6_DA__Pr: (- DA__Pr -).
To decide what number is the address of I6_RA__Pr: (- RA__Pr -).
To decide what number is the address of I6_RL__Pr: (- RL__Pr -).
To decide what number is the address of I6_RA__Sc: (- RA__Sc -).
To decide what number is the address of I6_OP__Pr: (- OP__Pr -).
To decide what number is the address of I6_OC__Cl: (- OC__Cl -).
To decide what number is the address of I6_Copy__Primitive: (- Copy__Primitive -).
To decide what number is the address of I6_RT__Err: (- RT__Err -).
To decide what number is the address of I6_Z__Region: (- Z__Region -).
To decide what number is the address of I6_Unsigned__Compare: (- Unsigned__Compare -).
To decide what number is the address of I6_Meta__class: (- Meta__class -).
To decide what number is the address of I6_CP__Tab: (- CP__Tab -).
To decide what number is the address of I6_Cl__Ms: (- Cl__Ms -).
To decide what number is the address of I6_RT__ChT: (- 0 -).
To decide what number is the address of I6_RT__ChR: (- 0 -).
To decide what number is the address of I6_RT__ChG: (- 0 -).
To decide what number is the address of I6_RT__ChGt: (- 0 -).
To decide what number is the address of I6_RT__ChPS: (- 0 -).
To decide what number is the address of I6_RT__TrPS: (- RT__TrPS -).
To decide what number is the address of I6_RT__ChLDB: (- 0 -).
To decide what number is the address of I6_RT__ChLDW: (- 0 -).
To decide what number is the address of I6_RT__ChSTB: (- 0 -).
To decide what number is the address of I6_RT__ChSTW: (- 0 -).
To decide what number is the address of I6_RT__ChPrintC: (- 0 -).
To decide what number is the address of I6_RT__ChPrintA: (- 0 -).
To decide what number is the address of I6_RT__ChPrintS: (- 0 -).
To decide what number is the address of I6_RT__ChPrintO: (- 0 -).
To decide what number is the address of I6_OB__Move: (- OB__Move -).
To decide what number is the address of I6_OB__Remove: (- OB__Remove -).
To decide what number is the address of I6_Print__Addr: (- Print__Addr -).
To decide what number is the address of I6_Glk__Wrap: (- Glk__Wrap -).
To decide what number is the address of I6_Dynam__String: (- Dynam__String -).

To decide whether I6_Box__Routine is overridden: (- override_Box__Routine -).
To decide whether I6_R_Process is overridden: (- override_R_Process -).
To decide whether I6_DefArt is overridden: (- override_DefArt -).
To decide whether I6_InDefArt is overridden: (- override_InDefArt -).
To decide whether I6_CDefArt is overridden: (- override_CDefArt -).
To decide whether I6_CInDefArt is overridden: (- override_CInDefArt -).
To decide whether I6_PrintShortName is overridden: (- override_PrintShortName -).
To decide whether I6_EnglishNumber is overridden: (- override_EnglishNumber -).
To decide whether I6_Print__PName is overridden: (- override_Print__PName -).
To decide whether I6_WV__Pr is overridden: (- override_WV__Pr -).
To decide whether I6_RV__Pr is overridden: (- override_RV__Pr -).
To decide whether I6_CA__Pr is overridden: (- override_CA__Pr -).
To decide whether I6_IB__Pr is overridden: (- override_IB__Pr -).
To decide whether I6_IA__Pr is overridden: (- override_IA__Pr -).
To decide whether I6_DB__Pr is overridden: (- override_DB__Pr -).
To decide whether I6_DA__Pr is overridden: (- override_DA__Pr -).
To decide whether I6_RA__Pr is overridden: (- override_RA__Pr -).
To decide whether I6_RL__Pr is overridden: (- override_RL__Pr -).
To decide whether I6_RA__Sc is overridden: (- override_RA__Sc -).
To decide whether I6_OP__Pr is overridden: (- override_OP__Pr -).
To decide whether I6_OC__Cl is overridden: (- override_OC__Cl -).
To decide whether I6_Copy__Primitive is overridden: (- override_Copy__Primitive -).
To decide whether I6_RT__Err is overridden: (- override_RT__Err -).
To decide whether I6_Z__Region is overridden: (- override_Z__Region -).
To decide whether I6_Unsigned__Compare is overridden: (- override_Unsigned__Compare -).
To decide whether I6_Meta__class is overridden: (- override_Meta__class -).
To decide whether I6_CP__Tab is overridden: (- override_CP__Tab -).
To decide whether I6_Cl__Ms is overridden: (- override_Cl__Ms -).
To decide whether I6_RT__ChT is overridden: (- override_RT__ChT -).
To decide whether I6_RT__ChR is overridden: (- override_RT__ChR -).
To decide whether I6_RT__ChG is overridden: (- override_RT__ChG -).
To decide whether I6_RT__ChGt is overridden: (- override_RT__ChGt -).
To decide whether I6_RT__ChPS is overridden: (- override_RT__ChPS -).
To decide whether I6_RT__TrPS is overridden: (- override_RT__TrPS -).
To decide whether I6_RT__ChLDB is overridden: (- override_RT__ChLDB -).
To decide whether I6_RT__ChLDW is overridden: (- override_RT__ChLDW -).
To decide whether I6_RT__ChSTB is overridden: (- override_RT__ChSTB -).
To decide whether I6_RT__ChSTW is overridden: (- override_RT__ChSTW -).
To decide whether I6_RT__ChPrintC is overridden: (- override_RT__ChPrintC -).
To decide whether I6_RT__ChPrintA is overridden: (- override_RT__ChPrintA -).
To decide whether I6_RT__ChPrintS is overridden: (- override_RT__ChPrintS -).
To decide whether I6_RT__ChPrintO is overridden: (- override_RT__ChPrintO -).
To decide whether I6_OB__Move is overridden: (- override_OB__Move -).
To decide whether I6_OB__Remove is overridden: (- override_OB__Remove -).
To decide whether I6_Print__Addr is overridden: (- override_Print__Addr -).
To decide whether I6_Glk__Wrap is overridden: (- override_Glk__Wrap -).
To decide whether I6_Dynam__String is overridden: (- override_Dynam__String -).

Section "Inlined Phrases for Check Routines in Strict Mode" - not for release

To decide what number is the address of I6_RT__ChT: (- RT__ChT -).
To decide what number is the address of I6_RT__ChR: (- RT__ChR -).
To decide what number is the address of I6_RT__ChG: (- RT__ChG -).
To decide what number is the address of I6_RT__ChGt: (- RT__ChGt -).
To decide what number is the address of I6_RT__ChPS: (- RT__ChPS -).
To decide what number is the address of I6_RT__ChLDB: (- RT__ChLDB -).
To decide what number is the address of I6_RT__ChLDW: (- RT__ChLDW -).
To decide what number is the address of I6_RT__ChSTB: (- RT__ChSTB -).
To decide what number is the address of I6_RT__ChSTW: (- RT__ChSTW -).
To decide what number is the address of I6_RT__ChPrintC: (- RT__ChPrintC -).
To decide what number is the address of I6_RT__ChPrintA: (- RT__ChPrintA -).
To decide what number is the address of I6_RT__ChPrintS: (- RT__ChPrintS -).
To decide what number is the address of I6_RT__ChPrintO: (- RT__ChPrintO -).

Chapter "Traversal over Veneer Routines"

To traverse the veneer routines with the visitor (V - a phrase (number, truth state, text, text) -> nothing):
	apply V to the address of I6_Box__Routine and whether or not I6_Box__Routine is overridden and "Box__Routine" and "displaying a box quote";
	apply V to the address of I6_R_Process and whether or not I6_R_Process is overridden and "R_Process" and "triggering an action";
	apply V to the address of I6_DefArt and whether or not I6_DefArt is overridden and "DefArt" and "saying a lowercase definite article";
	apply V to the address of I6_InDefArt and whether or not I6_InDefArt is overridden and "InDefArt" and "saying a lowercase indefinite article";
	apply V to the address of I6_CDefArt and whether or not I6_CDefArt is overridden and "CDefArt" and "saying an uppercase definite article";
	apply V to the address of I6_CInDefArt and whether or not I6_CInDefArt is overridden and "CInDefArt" and "saying an uppercase indefinite article";
	apply V to the address of I6_PrintShortName and whether or not I6_PrintShortName is overridden and "PrintShortName" and "saying the short name of an I6 value";
	apply V to the address of I6_EnglishNumber and whether or not I6_EnglishNumber is overridden and "EnglishNumber" and "saying a number in words";
	apply V to the address of I6_Print__PName and whether or not I6_Print__PName is overridden and "Print__PName" and "saying a property name";
	apply V to the address of I6_WV__Pr and whether or not I6_WV__Pr is overridden and "WV__Pr" and "writing a value to a property";
	apply V to the address of I6_RV__Pr and whether or not I6_RV__Pr is overridden and "RV__Pr" and "reading a value from a property";
	apply V to the address of I6_CA__Pr and whether or not I6_CA__Pr is overridden and "CA__Pr" and "calling a property value";
	apply V to the address of I6_IB__Pr and whether or not I6_IB__Pr is overridden and "IB__Pr" and "preincrementing a property value";
	apply V to the address of I6_IA__Pr and whether or not I6_IA__Pr is overridden and "IA__Pr" and "postincrementing a property value";
	apply V to the address of I6_DB__Pr and whether or not I6_DB__Pr is overridden and "DB__Pr" and "predecrementing a property value";
	apply V to the address of I6_DA__Pr and whether or not I6_DA__Pr is overridden and "DA__Pr" and "postdecrementing a property value";
	apply V to the address of I6_RA__Pr and whether or not I6_RA__Pr is overridden and "RA__Pr" and "reading the address of a property value";
	apply V to the address of I6_RL__Pr and whether or not I6_RL__Pr is overridden and "RL__Pr" and "reading the length of a property value";
	apply V to the address of I6_RA__Sc and whether or not I6_RA__Sc is overridden and "RA__Sc" and "finding a superclass";
	apply V to the address of I6_OP__Pr and whether or not I6_OP__Pr is overridden and "OP__Pr" and "testing for an individual property";
	apply V to the address of I6_OC__Cl and whether or not I6_OC__Cl is overridden and "OC__Cl" and "testing an object's class";
	apply V to the address of I6_Copy__Primitive and whether or not I6_Copy__Primitive is overridden and "Copy__Primitive" and "deep copying an object";
	apply V to the address of I6_RT__Err and whether or not I6_RT__Err is overridden and "RT__Err" and "reporting a programming error";
	apply V to the address of I6_Z__Region and whether or not I6_Z__Region is overridden and "Z__Region" and "determining a metaclass code";
	apply V to the address of I6_Unsigned__Compare and whether or not I6_Unsigned__Compare is overridden and "Unsigned__Compare" and "comparing unsigned numbers";
	apply V to the address of I6_Meta__class and whether or not I6_Meta__class is overridden and "Meta__class" and "determining a metaclass";
	apply V to the address of I6_CP__Tab and whether or not I6_CP__Tab is overridden and "CP__Tab" and "searching a common property table";
	apply V to the address of I6_Cl__Ms and whether or not I6_Cl__Ms is overridden and "Cl__Ms" and "receiving a message for a class";
	apply V to the address of I6_RT__ChT and whether or not I6_RT__ChT is overridden and "RT__ChT" and "moving an object";
	apply V to the address of I6_RT__ChR and whether or not I6_RT__ChR is overridden and "RT__ChR" and "removing an object";
	apply V to the address of I6_RT__ChG and whether or not I6_RT__ChG is overridden and "RT__ChG" and "giving an attribute";
	apply V to the address of I6_RT__ChGt and whether or not I6_RT__ChGt is overridden and "RT__ChGt" and "giving a negated attribute";
	apply V to the address of I6_RT__ChPS and whether or not I6_RT__ChPS is overridden and "RT__ChPS" and "checking the legality of writing to a property";
	apply V to the address of I6_RT__TrPS and whether or not I6_RT__TrPS is overridden and "RT__TrPS" and "tracing property writes";
	apply V to the address of I6_RT__ChLDB and whether or not I6_RT__ChLDB is overridden and "RT__ChLDB" and "reading a byte, with bounds checks";
	apply V to the address of I6_RT__ChLDW and whether or not I6_RT__ChLDW is overridden and "RT__ChLDW" and "reading a word, with bounds checks";
	apply V to the address of I6_RT__ChSTB and whether or not I6_RT__ChSTB is overridden and "RT__ChSTB" and "writing a byte, with bounds checks";
	apply V to the address of I6_RT__ChSTW and whether or not I6_RT__ChSTW is overridden and "RT__ChSTW" and "writing a word, with bounds checks";
	apply V to the address of I6_RT__ChPrintC and whether or not I6_RT__ChPrintC is overridden and "RT__ChPrintC" and "saying a character";
	apply V to the address of I6_RT__ChPrintA and whether or not I6_RT__ChPrintA is overridden and "RT__ChPrintA" and "saying an address";
	apply V to the address of I6_RT__ChPrintS and whether or not I6_RT__ChPrintS is overridden and "RT__ChPrintS" and "saying a string";
	apply V to the address of I6_RT__ChPrintO and whether or not I6_RT__ChPrintO is overridden and "RT__ChPrintO" and "saying an object";
	apply V to the address of I6_OB__Move and whether or not I6_OB__Move is overridden and "OB__Move" and "moving an object within the object tree";
	apply V to the address of I6_OB__Remove and whether or not I6_OB__Remove is overridden and "OB__Remove" and "removing an object from the object tree";
	apply V to the address of I6_Print__Addr and whether or not I6_Print__Addr is overridden and "Print__Addr" and "saying the text of a dictionary word";
	apply V to the address of I6_Glk__Wrap and whether or not I6_Glk__Wrap is overridden and "Glk__Wrap" and "forwarding arguments to the @glk operation code";
	apply V to the address of I6_Dynam__String and whether or not I6_Dynam__String is overridden and "Dynam__String" and "changing an I6 printing variable".

Book "Standard Template"

Chapter "Standard Template Function Constants" - unindexed

Include (-
	#ifdef AGL__M; Constant isix_AGL__M=AGL__M; #ifnot; Constant isix_AGL__M=0; #endif;
	#ifdef AbandonActivity; Constant isix_AbandonActivity=AbandonActivity; #ifnot; Constant isix_AbandonActivity=0; #endif;
	#ifdef AbbreviatedRoomDescription; Constant isix_AbbreviatedRoomDescription=AbbreviatedRoomDescription; #ifnot; Constant isix_AbbreviatedRoomDescription=0; #endif;
	#ifdef ActRulebookFails; Constant isix_ActRulebookFails=ActRulebookFails; #ifnot; Constant isix_ActRulebookFails=0; #endif;
	#ifdef ActRulebookSucceeds; Constant isix_ActRulebookSucceeds=ActRulebookSucceeds; #ifnot; Constant isix_ActRulebookSucceeds=0; #endif;
	#ifdef ActionNumberIndexed; Constant isix_ActionNumberIndexed=ActionNumberIndexed; #ifnot; Constant isix_ActionNumberIndexed=0; #endif;
	#ifdef ActionPrimitive; Constant isix_ActionPrimitive=ActionPrimitive; #ifnot; Constant isix_ActionPrimitive=0; #endif;
	#ifdef ActionVariablesNotTypeSafe; Constant isix_ActionVariablesNotTypeSafe=ActionVariablesNotTypeSafe; #ifnot; Constant isix_ActionVariablesNotTypeSafe=0; #endif;
	#ifdef ActionsOffSub; Constant isix_ActionsOffSub=ActionsOffSub; #ifnot; Constant isix_ActionsOffSub=0; #endif;
	#ifdef ActionsOnSub; Constant isix_ActionsOnSub=ActionsOnSub; #ifnot; Constant isix_ActionsOnSub=0; #endif;
	#ifdef ActivityEmpty; Constant isix_ActivityEmpty=ActivityEmpty; #ifnot; Constant isix_ActivityEmpty=0; #endif;
	#ifdef AddToScope; Constant isix_AddToScope=AddToScope; #ifnot; Constant isix_AddToScope=0; #endif;
	#ifdef Adjudicate; Constant isix_Adjudicate=Adjudicate; #ifnot; Constant isix_Adjudicate=0; #endif;
	#ifdef AllowInShowme; Constant isix_AllowInShowme=AllowInShowme; #ifnot; Constant isix_AllowInShowme=0; #endif;
	#ifdef AnalyseToken; Constant isix_AnalyseToken=AnalyseToken; #ifnot; Constant isix_AnalyseToken=0; #endif;
	#ifdef ArgumentTypeFailed; Constant isix_ArgumentTypeFailed=ArgumentTypeFailed; #ifnot; Constant isix_ArgumentTypeFailed=0; #endif;
	#ifdef ArticleDescriptors; Constant isix_ArticleDescriptors=ArticleDescriptors; #ifnot; Constant isix_ArticleDescriptors=0; #endif;
	#ifdef AssertMapConnection; Constant isix_AssertMapConnection=AssertMapConnection; #ifnot; Constant isix_AssertMapConnection=0; #endif;
	#ifdef AssertMapUnconnection; Constant isix_AssertMapUnconnection=AssertMapUnconnection; #ifnot; Constant isix_AssertMapUnconnection=0; #endif;
	#ifdef BackSideOfDoor; Constant isix_BackSideOfDoor=BackSideOfDoor; #ifnot; Constant isix_BackSideOfDoor=0; #endif;
	#ifdef Banner; Constant isix_Banner=Banner; #ifnot; Constant isix_Banner=0; #endif;
	#ifdef BeginAction; Constant isix_BeginAction=BeginAction; #ifnot; Constant isix_BeginAction=0; #endif;
	#ifdef BeginActivity; Constant isix_BeginActivity=BeginActivity; #ifnot; Constant isix_BeginActivity=0; #endif;
	#ifdef BeginFollowRulebook; Constant isix_BeginFollowRulebook=BeginFollowRulebook; #ifnot; Constant isix_BeginFollowRulebook=0; #endif;
	#ifdef BestGuess; Constant isix_BestGuess=BestGuess; #ifnot; Constant isix_BestGuess=0; #endif;
	#ifdef BlkAllocate; Constant isix_BlkAllocate=BlkAllocate; #ifnot; Constant isix_BlkAllocate=0; #endif;
	#ifdef BlkAllocationError; Constant isix_BlkAllocationError=BlkAllocationError; #ifnot; Constant isix_BlkAllocationError=0; #endif;
	#ifdef BlkDebug; Constant isix_BlkDebug=BlkDebug; #ifnot; Constant isix_BlkDebug=0; #endif;
	#ifdef BlkDebugDecomposition; Constant isix_BlkDebugDecomposition=BlkDebugDecomposition; #ifnot; Constant isix_BlkDebugDecomposition=0; #endif;
	#ifdef BlkFree; Constant isix_BlkFree=BlkFree; #ifnot; Constant isix_BlkFree=0; #endif;
	#ifdef BlkFreeSingleBlock; Constant isix_BlkFreeSingleBlock=BlkFreeSingleBlock; #ifnot; Constant isix_BlkFreeSingleBlock=0; #endif;
	#ifdef BlkMerge; Constant isix_BlkMerge=BlkMerge; #ifnot; Constant isix_BlkMerge=0; #endif;
	#ifdef BlkRecut; Constant isix_BlkRecut=BlkRecut; #ifnot; Constant isix_BlkRecut=0; #endif;
	#ifdef BlkResize; Constant isix_BlkResize=BlkResize; #ifnot; Constant isix_BlkResize=0; #endif;
	#ifdef BlkSize; Constant isix_BlkSize=BlkSize; #ifnot; Constant isix_BlkSize=0; #endif;
	#ifdef BlkTotalSize; Constant isix_BlkTotalSize=BlkTotalSize; #ifnot; Constant isix_BlkTotalSize=0; #endif;
	#ifdef BlkType; Constant isix_BlkType=BlkType; #ifnot; Constant isix_BlkType=0; #endif;
	#ifdef BlkValueCast; Constant isix_BlkValueCast=BlkValueCast; #ifnot; Constant isix_BlkValueCast=0; #endif;
	#ifdef BlkValueCompare; Constant isix_BlkValueCompare=BlkValueCompare; #ifnot; Constant isix_BlkValueCompare=0; #endif;
	#ifdef BlkValueCopy; Constant isix_BlkValueCopy=BlkValueCopy; #ifnot; Constant isix_BlkValueCopy=0; #endif;
	#ifdef BlkValueCreate; Constant isix_BlkValueCreate=BlkValueCreate; #ifnot; Constant isix_BlkValueCreate=0; #endif;
	#ifdef BlkValueDestroy; Constant isix_BlkValueDestroy=BlkValueDestroy; #ifnot; Constant isix_BlkValueDestroy=0; #endif;
	#ifdef BlkValueExtent; Constant isix_BlkValueExtent=BlkValueExtent; #ifnot; Constant isix_BlkValueExtent=0; #endif;
	#ifdef BlkValueHash; Constant isix_BlkValueHash=BlkValueHash; #ifnot; Constant isix_BlkValueHash=0; #endif;
	#ifdef BlkValueInitialCopy; Constant isix_BlkValueInitialCopy=BlkValueInitialCopy; #ifnot; Constant isix_BlkValueInitialCopy=0; #endif;
	#ifdef BlkValueRead; Constant isix_BlkValueRead=BlkValueRead; #ifnot; Constant isix_BlkValueRead=0; #endif;
	#ifdef BlkValueReadFromFile; Constant isix_BlkValueReadFromFile=BlkValueReadFromFile; #ifnot; Constant isix_BlkValueReadFromFile=0; #endif;
	#ifdef BlkValueSetExtent; Constant isix_BlkValueSetExtent=BlkValueSetExtent; #ifnot; Constant isix_BlkValueSetExtent=0; #endif;
	#ifdef BlkValueWrite; Constant isix_BlkValueWrite=BlkValueWrite; #ifnot; Constant isix_BlkValueWrite=0; #endif;
	#ifdef BlkValueWriteToFile; Constant isix_BlkValueWriteToFile=BlkValueWriteToFile; #ifnot; Constant isix_BlkValueWriteToFile=0; #endif;
	#ifdef COBJ__Copy; Constant isix_COBJ__Copy=COBJ__Copy; #ifnot; Constant isix_COBJ__Copy=0; #endif;
	#ifdef COBJ__SwapMatches; Constant isix_COBJ__SwapMatches=COBJ__SwapMatches; #ifnot; Constant isix_COBJ__SwapMatches=0; #endif;
	#ifdef COMBINATION_TY_Compare; Constant isix_COMBINATION_TY_Compare=COMBINATION_TY_Compare; #ifnot; Constant isix_COMBINATION_TY_Compare=0; #endif;
	#ifdef COMBINATION_TY_Copy; Constant isix_COMBINATION_TY_Copy=COMBINATION_TY_Copy; #ifnot; Constant isix_COMBINATION_TY_Copy=0; #endif;
	#ifdef COMBINATION_TY_CopyRawArray; Constant isix_COMBINATION_TY_CopyRawArray=COMBINATION_TY_CopyRawArray; #ifnot; Constant isix_COMBINATION_TY_CopyRawArray=0; #endif;
	#ifdef COMBINATION_TY_Create; Constant isix_COMBINATION_TY_Create=COMBINATION_TY_Create; #ifnot; Constant isix_COMBINATION_TY_Create=0; #endif;
	#ifdef COMBINATION_TY_Destroy; Constant isix_COMBINATION_TY_Destroy=COMBINATION_TY_Destroy; #ifnot; Constant isix_COMBINATION_TY_Destroy=0; #endif;
	#ifdef COMBINATION_TY_Distinguish; Constant isix_COMBINATION_TY_Distinguish=COMBINATION_TY_Distinguish; #ifnot; Constant isix_COMBINATION_TY_Distinguish=0; #endif;
	#ifdef COMBINATION_TY_Hash; Constant isix_COMBINATION_TY_Hash=COMBINATION_TY_Hash; #ifnot; Constant isix_COMBINATION_TY_Hash=0; #endif;
	#ifdef COMBINATION_TY_PreCopy; Constant isix_COMBINATION_TY_PreCopy=COMBINATION_TY_PreCopy; #ifnot; Constant isix_COMBINATION_TY_PreCopy=0; #endif;
	#ifdef COMBINATION_TY_Say; Constant isix_COMBINATION_TY_Say=COMBINATION_TY_Say; #ifnot; Constant isix_COMBINATION_TY_Say=0; #endif;
	#ifdef COMBINATION_TY_Support; Constant isix_COMBINATION_TY_Support=COMBINATION_TY_Support; #ifnot; Constant isix_COMBINATION_TY_Support=0; #endif;
	#ifdef CPrintOrRun; Constant isix_CPrintOrRun=CPrintOrRun; #ifnot; Constant isix_CPrintOrRun=0; #endif;
	#ifdef CThatorThose; Constant isix_CThatorThose=CThatorThose; #ifnot; Constant isix_CThatorThose=0; #endif;
	#ifdef CTheyreorThats; Constant isix_CTheyreorThats=CTheyreorThats; #ifnot; Constant isix_CTheyreorThats=0; #endif;
	#ifdef CantSee; Constant isix_CantSee=CantSee; #ifnot; Constant isix_CantSee=0; #endif;
	#ifdef Cap; Constant isix_Cap=Cap; #ifnot; Constant isix_Cap=0; #endif;
	#ifdef CarrierOf; Constant isix_CarrierOf=CarrierOf; #ifnot; Constant isix_CarrierOf=0; #endif;
	#ifdef CarryOutActivity; Constant isix_CarryOutActivity=CarryOutActivity; #ifnot; Constant isix_CarryOutActivity=0; #endif;
	#ifdef ChangePlayer; Constant isix_ChangePlayer=ChangePlayer; #ifnot; Constant isix_ChangePlayer=0; #endif;
	#ifdef CharIsOfCase; Constant isix_CharIsOfCase=CharIsOfCase; #ifnot; Constant isix_CharIsOfCase=0; #endif;
	#ifdef CharTestCases; Constant isix_CharTestCases=CharTestCases; #ifnot; Constant isix_CharTestCases=0; #endif;
	#ifdef CharToCase; Constant isix_CharToCase=CharToCase; #ifnot; Constant isix_CharToCase=0; #endif;
	#ifdef CheckKindReturned; Constant isix_CheckKindReturned=CheckKindReturned; #ifnot; Constant isix_CheckKindReturned=0; #endif;
	#ifdef CheckTableEntryIsBlank; Constant isix_CheckTableEntryIsBlank=CheckTableEntryIsBlank; #ifnot; Constant isix_CheckTableEntryIsBlank=0; #endif;
	#ifdef ChooseObjects; Constant isix_ChooseObjects=ChooseObjects; #ifnot; Constant isix_ChooseObjects=0; #endif;
	#ifdef ChooseRelationHandler; Constant isix_ChooseRelationHandler=ChooseRelationHandler; #ifnot; Constant isix_ChooseRelationHandler=0; #endif;
	#ifdef ChronologyPoint; Constant isix_ChronologyPoint=ChronologyPoint; #ifnot; Constant isix_ChronologyPoint=0; #endif;
	#ifdef ClearBoxedText; Constant isix_ClearBoxedText=ClearBoxedText; #ifnot; Constant isix_ClearBoxedText=0; #endif;
	#ifdef ClearParagraphing; Constant isix_ClearParagraphing=ClearParagraphing; #ifnot; Constant isix_ClearParagraphing=0; #endif;
	#ifdef CommandClarificationBreak; Constant isix_CommandClarificationBreak=CommandClarificationBreak; #ifnot; Constant isix_CommandClarificationBreak=0; #endif;
	#ifdef CommonAncestor; Constant isix_CommonAncestor=CommonAncestor; #ifnot; Constant isix_CommonAncestor=0; #endif;
	#ifdef CompareFields; Constant isix_CompareFields=CompareFields; #ifnot; Constant isix_CompareFields=0; #endif;
	#ifdef ComponentHasLight; Constant isix_ComponentHasLight=ComponentHasLight; #ifnot; Constant isix_ComponentHasLight=0; #endif;
	#ifdef ComputeFWMatrix; Constant isix_ComputeFWMatrix=ComputeFWMatrix; #ifnot; Constant isix_ComputeFWMatrix=0; #endif;
	#ifdef ConsultNounFilterToken; Constant isix_ConsultNounFilterToken=ConsultNounFilterToken; #ifnot; Constant isix_ConsultNounFilterToken=0; #endif;
	#ifdef ContainerOf; Constant isix_ContainerOf=ContainerOf; #ifnot; Constant isix_ContainerOf=0; #endif;
	#ifdef ConvertToGoingWithPush; Constant isix_ConvertToGoingWithPush=ConvertToGoingWithPush; #ifnot; Constant isix_ConvertToGoingWithPush=0; #endif;
	#ifdef CoreOf; Constant isix_CoreOf=CoreOf; #ifnot; Constant isix_CoreOf=0; #endif;
	#ifdef CoreOfParentOfCoreOf; Constant isix_CoreOfParentOfCoreOf=CoreOfParentOfCoreOf; #ifnot; Constant isix_CoreOfParentOfCoreOf=0; #endif;
	#ifdef CreateBlockConstants; Constant isix_CreateBlockConstants=CreateBlockConstants; #ifnot; Constant isix_CreateBlockConstants=0; #endif;
	#ifdef CreateDynamicRelations; Constant isix_CreateDynamicRelations=CreateDynamicRelations; #ifnot; Constant isix_CreateDynamicRelations=0; #endif;
	#ifdef CreatePropertyOffsets; Constant isix_CreatePropertyOffsets=CreatePropertyOffsets; #ifnot; Constant isix_CreatePropertyOffsets=0; #endif;
	#ifdef CreatureTest; Constant isix_CreatureTest=CreatureTest; #ifnot; Constant isix_CreatureTest=0; #endif;
	#ifdef CubeRoot; Constant isix_CubeRoot=CubeRoot; #ifnot; Constant isix_CubeRoot=0; #endif;
	#ifdef DA_Name; Constant isix_DA_Name=DA_Name; #ifnot; Constant isix_DA_Name=0; #endif;
	#ifdef DA_Number; Constant isix_DA_Number=DA_Number; #ifnot; Constant isix_DA_Number=0; #endif;
	#ifdef DA_Topic; Constant isix_DA_Topic=DA_Topic; #ifnot; Constant isix_DA_Topic=0; #endif;
	#ifdef DA_TruthState; Constant isix_DA_TruthState=DA_TruthState; #ifnot; Constant isix_DA_TruthState=0; #endif;
	#ifdef DB_Action; Constant isix_DB_Action=DB_Action; #ifnot; Constant isix_DB_Action=0; #endif;
	#ifdef DB_Action_Details; Constant isix_DB_Action_Details=DB_Action_Details; #ifnot; Constant isix_DB_Action_Details=0; #endif;
	#ifdef DB_Rule; Constant isix_DB_Rule=DB_Rule; #ifnot; Constant isix_DB_Rule=0; #endif;
	#ifdef DECIMAL_TOKEN; Constant isix_DECIMAL_TOKEN=DECIMAL_TOKEN; #ifnot; Constant isix_DECIMAL_TOKEN=0; #endif;
	#ifdef DebugAction; Constant isix_DebugAction=DebugAction; #ifnot; Constant isix_DebugAction=0; #endif;
	#ifdef DebugAttribute; Constant isix_DebugAttribute=DebugAttribute; #ifnot; Constant isix_DebugAttribute=0; #endif;
	#ifdef DebugGrammarLine; Constant isix_DebugGrammarLine=DebugGrammarLine; #ifnot; Constant isix_DebugGrammarLine=0; #endif;
	#ifdef DebugHeap; Constant isix_DebugHeap=DebugHeap; #ifnot; Constant isix_DebugHeap=0; #endif;
	#ifdef DebugPartition; Constant isix_DebugPartition=DebugPartition; #ifnot; Constant isix_DebugPartition=0; #endif;
	#ifdef DebugRulebooks; Constant isix_DebugRulebooks=DebugRulebooks; #ifnot; Constant isix_DebugRulebooks=0; #endif;
	#ifdef DebugToken; Constant isix_DebugToken=DebugToken; #ifnot; Constant isix_DebugToken=0; #endif;
	#ifdef DecimalNumber; Constant isix_DecimalNumber=DecimalNumber; #ifnot; Constant isix_DecimalNumber=0; #endif;
	#ifdef DefaultTopic; Constant isix_DefaultTopic=DefaultTopic; #ifnot; Constant isix_DefaultTopic=0; #endif;
	#ifdef DefaultValueFinder; Constant isix_DefaultValueFinder=DefaultValueFinder; #ifnot; Constant isix_DefaultValueFinder=0; #endif;
	#ifdef DefaultValueOfKOV; Constant isix_DefaultValueOfKOV=DefaultValueOfKOV; #ifnot; Constant isix_DefaultValueOfKOV=0; #endif;
	#ifdef Descriptors; Constant isix_Descriptors=Descriptors; #ifnot; Constant isix_Descriptors=0; #endif;
	#ifdef DetachPart; Constant isix_DetachPart=DetachPart; #ifnot; Constant isix_DetachPart=0; #endif;
	#ifdef DetectPluralWord; Constant isix_DetectPluralWord=DetectPluralWord; #ifnot; Constant isix_DetectPluralWord=0; #endif;
	#ifdef DetectSceneChange; Constant isix_DetectSceneChange=DetectSceneChange; #ifnot; Constant isix_DetectSceneChange=0; #endif;
	#ifdef DiagnoseSortList; Constant isix_DiagnoseSortList=DiagnoseSortList; #ifnot; Constant isix_DiagnoseSortList=0; #endif;
	#ifdef DictionaryWordToVerbNum; Constant isix_DictionaryWordToVerbNum=DictionaryWordToVerbNum; #ifnot; Constant isix_DictionaryWordToVerbNum=0; #endif;
	#ifdef DigitToValue; Constant isix_DigitToValue=DigitToValue; #ifnot; Constant isix_DigitToValue=0; #endif;
	#ifdef DirectionDoorLeadsIn; Constant isix_DirectionDoorLeadsIn=DirectionDoorLeadsIn; #ifnot; Constant isix_DirectionDoorLeadsIn=0; #endif;
	#ifdef DisplayBoxedQuotation; Constant isix_DisplayBoxedQuotation=DisplayBoxedQuotation; #ifnot; Constant isix_DisplayBoxedQuotation=0; #endif;
	#ifdef DisplayFigure; Constant isix_DisplayFigure=DisplayFigure; #ifnot; Constant isix_DisplayFigure=0; #endif;
	#ifdef DistributeBlockConstants; Constant isix_DistributeBlockConstants=DistributeBlockConstants; #ifnot; Constant isix_DistributeBlockConstants=0; #endif;
	#ifdef DivideParagraphPoint; Constant isix_DivideParagraphPoint=DivideParagraphPoint; #ifnot; Constant isix_DivideParagraphPoint=0; #endif;
	#ifdef DoScopeAction; Constant isix_DoScopeAction=DoScopeAction; #ifnot; Constant isix_DoScopeAction=0; #endif;
	#ifdef DoScopeActionAndRecurse; Constant isix_DoScopeActionAndRecurse=DoScopeActionAndRecurse; #ifnot; Constant isix_DoScopeActionAndRecurse=0; #endif;
	#ifdef DonotuseRule; Constant isix_DonotuseRule=DonotuseRule; #ifnot; Constant isix_DonotuseRule=0; #endif;
	#ifdef DoorFrom; Constant isix_DoorFrom=DoorFrom; #ifnot; Constant isix_DoorFrom=0; #endif;
	#ifdef DoubleHashSetCheckResize; Constant isix_DoubleHashSetCheckResize=DoubleHashSetCheckResize; #ifnot; Constant isix_DoubleHashSetCheckResize=0; #endif;
	#ifdef DoubleHashSetEntryMatches; Constant isix_DoubleHashSetEntryMatches=DoubleHashSetEntryMatches; #ifnot; Constant isix_DoubleHashSetEntryMatches=0; #endif;
	#ifdef DoubleHashSetLookUp; Constant isix_DoubleHashSetLookUp=DoubleHashSetLookUp; #ifnot; Constant isix_DoubleHashSetLookUp=0; #endif;
	#ifdef DoubleHashSetRelationHandler; Constant isix_DoubleHashSetRelationHandle=DoubleHashSetRelationHandler; #ifnot; Constant isix_DoubleHashSetRelationHandle=0; #endif;
	#ifdef DrawStatusLine; Constant isix_DrawStatusLine=DrawStatusLine; #ifnot; Constant isix_DrawStatusLine=0; #endif;
	#ifdef DuringSceneMatching; Constant isix_DuringSceneMatching=DuringSceneMatching; #ifnot; Constant isix_DuringSceneMatching=0; #endif;
	#ifdef EmptyRelationHandler; Constant isix_EmptyRelationHandler=EmptyRelationHandler; #ifnot; Constant isix_EmptyRelationHandler=0; #endif;
	#ifdef EndActivity; Constant isix_EndActivity=EndActivity; #ifnot; Constant isix_EndActivity=0; #endif;
	#ifdef EndFollowRulebook; Constant isix_EndFollowRulebook=EndFollowRulebook; #ifnot; Constant isix_EndFollowRulebook=0; #endif;
	#ifdef EnsureBreakBeforePrompt; Constant isix_EnsureBreakBeforePrompt=EnsureBreakBeforePrompt; #ifnot; Constant isix_EnsureBreakBeforePrompt=0; #endif;
	#ifdef EquivHashTableRelationHandler; Constant isix_EquivHashTableRelationHandl=EquivHashTableRelationHandler; #ifnot; Constant isix_EquivHashTableRelationHandl=0; #endif;
	#ifdef ExchangeFields; Constant isix_ExchangeFields=ExchangeFields; #ifnot; Constant isix_ExchangeFields=0; #endif;
	#ifdef ExistsTableLookUpCorr; Constant isix_ExistsTableLookUpCorr=ExistsTableLookUpCorr; #ifnot; Constant isix_ExistsTableLookUpCorr=0; #endif;
	#ifdef ExistsTableLookUpEntry; Constant isix_ExistsTableLookUpEntry=ExistsTableLookUpEntry; #ifnot; Constant isix_ExistsTableLookUpEntry=0; #endif;
	#ifdef ExistsTableRowCorr; Constant isix_ExistsTableRowCorr=ExistsTableRowCorr; #ifnot; Constant isix_ExistsTableRowCorr=0; #endif;
	#ifdef FastCountRouteTo; Constant isix_FastCountRouteTo=FastCountRouteTo; #ifnot; Constant isix_FastCountRouteTo=0; #endif;
	#ifdef FastRouteTo; Constant isix_FastRouteTo=FastRouteTo; #ifnot; Constant isix_FastRouteTo=0; #endif;
	#ifdef FastVtoVRelRouteTo; Constant isix_FastVtoVRelRouteTo=FastVtoVRelRouteTo; #ifnot; Constant isix_FastVtoVRelRouteTo=0; #endif;
	#ifdef FileIO_Close; Constant isix_FileIO_Close=FileIO_Close; #ifnot; Constant isix_FileIO_Close=0; #endif;
	#ifdef FileIO_Error; Constant isix_FileIO_Error=FileIO_Error; #ifnot; Constant isix_FileIO_Error=0; #endif;
	#ifdef FileIO_Exists; Constant isix_FileIO_Exists=FileIO_Exists; #ifnot; Constant isix_FileIO_Exists=0; #endif;
	#ifdef FileIO_GetC; Constant isix_FileIO_GetC=FileIO_GetC; #ifnot; Constant isix_FileIO_GetC=0; #endif;
	#ifdef FileIO_GetTable; Constant isix_FileIO_GetTable=FileIO_GetTable; #ifnot; Constant isix_FileIO_GetTable=0; #endif;
	#ifdef FileIO_MarkReady; Constant isix_FileIO_MarkReady=FileIO_MarkReady; #ifnot; Constant isix_FileIO_MarkReady=0; #endif;
	#ifdef FileIO_Open; Constant isix_FileIO_Open=FileIO_Open; #ifnot; Constant isix_FileIO_Open=0; #endif;
	#ifdef FileIO_PrintContents; Constant isix_FileIO_PrintContents=FileIO_PrintContents; #ifnot; Constant isix_FileIO_PrintContents=0; #endif;
	#ifdef FileIO_PrintLine; Constant isix_FileIO_PrintLine=FileIO_PrintLine; #ifnot; Constant isix_FileIO_PrintLine=0; #endif;
	#ifdef FileIO_PutC; Constant isix_FileIO_PutC=FileIO_PutC; #ifnot; Constant isix_FileIO_PutC=0; #endif;
	#ifdef FileIO_PutContents; Constant isix_FileIO_PutContents=FileIO_PutContents; #ifnot; Constant isix_FileIO_PutContents=0; #endif;
	#ifdef FileIO_PutTable; Constant isix_FileIO_PutTable=FileIO_PutTable; #ifnot; Constant isix_FileIO_PutTable=0; #endif;
	#ifdef FileIO_Ready; Constant isix_FileIO_Ready=FileIO_Ready; #ifnot; Constant isix_FileIO_Ready=0; #endif;
	#ifdef FindAction; Constant isix_FindAction=FindAction; #ifnot; Constant isix_FindAction=0; #endif;
	#ifdef FindVisibilityLevels; Constant isix_FindVisibilityLevels=FindVisibilityLevels; #ifnot; Constant isix_FindVisibilityLevels=0; #endif;
	#ifdef FixInhibitFlag; Constant isix_FixInhibitFlag=FixInhibitFlag; #ifnot; Constant isix_FixInhibitFlag=0; #endif;
	#ifdef FollowRulebook; Constant isix_FollowRulebook=FollowRulebook; #ifnot; Constant isix_FollowRulebook=0; #endif;
	#ifdef ForActivity; Constant isix_ForActivity=ForActivity; #ifnot; Constant isix_ForActivity=0; #endif;
	#ifdef ForceTableEntryBlank; Constant isix_ForceTableEntryBlank=ForceTableEntryBlank; #ifnot; Constant isix_ForceTableEntryBlank=0; #endif;
	#ifdef ForceTableEntryNonBlank; Constant isix_ForceTableEntryNonBlank=ForceTableEntryNonBlank; #ifnot; Constant isix_ForceTableEntryNonBlank=0; #endif;
	#ifdef FoundEverywhere; Constant isix_FoundEverywhere=FoundEverywhere; #ifnot; Constant isix_FoundEverywhere=0; #endif;
	#ifdef FreeStack; Constant isix_FreeStack=FreeStack; #ifnot; Constant isix_FreeStack=0; #endif;
	#ifdef FrontSideOfDoor; Constant isix_FrontSideOfDoor=FrontSideOfDoor; #ifnot; Constant isix_FrontSideOfDoor=0; #endif;
	#ifdef GGRecoverObjects; Constant isix_GGRecoverObjects=GGRecoverObjects; #ifnot; Constant isix_GGRecoverObjects=0; #endif;
	#ifdef GGWordCompare; Constant isix_GGWordCompare=GGWordCompare; #ifnot; Constant isix_GGWordCompare=0; #endif;
	#ifdef GL__M; Constant isix_GL__M=GL__M; #ifnot; Constant isix_GL__M=0; #endif;
	#ifdef GProperty; Constant isix_GProperty=GProperty; #ifnot; Constant isix_GProperty=0; #endif;
	#ifdef GVS_Convert; Constant isix_GVS_Convert=GVS_Convert; #ifnot; Constant isix_GVS_Convert=0; #endif;
	#ifdef GenerateMultipleActions; Constant isix_GenerateMultipleActions=GenerateMultipleActions; #ifnot; Constant isix_GenerateMultipleActions=0; #endif;
	#ifdef GenerateRandomNumber; Constant isix_GenerateRandomNumber=GenerateRandomNumber; #ifnot; Constant isix_GenerateRandomNumber=0; #endif;
	#ifdef GenericVerbSub; Constant isix_GenericVerbSub=GenericVerbSub; #ifnot; Constant isix_GenericVerbSub=0; #endif;
	#ifdef GetEitherOrProperty; Constant isix_GetEitherOrProperty=GetEitherOrProperty; #ifnot; Constant isix_GetEitherOrProperty=0; #endif;
	#ifdef GetGNAOfObject; Constant isix_GetGNAOfObject=GetGNAOfObject; #ifnot; Constant isix_GetGNAOfObject=0; #endif;
	#ifdef GetGender; Constant isix_GetGender=GetGender; #ifnot; Constant isix_GetGender=0; #endif;
	#ifdef GlkListSub; Constant isix_GlkListSub=GlkListSub; #ifnot; Constant isix_GlkListSub=0; #endif;
	#ifdef Glulx_ChangeAnyToCString; Constant isix_Glulx_ChangeAnyToCString=Glulx_ChangeAnyToCString; #ifnot; Constant isix_Glulx_ChangeAnyToCString=0; #endif;
	#ifdef Glulx_PrintAnyToArray; Constant isix_Glulx_PrintAnyToArray=Glulx_PrintAnyToArray; #ifnot; Constant isix_Glulx_PrintAnyToArray=0; #endif;
	#ifdef Glulx_PrintAnything; Constant isix_Glulx_PrintAnything=Glulx_PrintAnything; #ifnot; Constant isix_Glulx_PrintAnything=0; #endif;
	#ifdef GoingLookBreak; Constant isix_GoingLookBreak=GoingLookBreak; #ifnot; Constant isix_GoingLookBreak=0; #endif;
	#ifdef GonearSub; Constant isix_GonearSub=GonearSub; #ifnot; Constant isix_GonearSub=0; #endif;
	#ifdef GroupChildren; Constant isix_GroupChildren=GroupChildren; #ifnot; Constant isix_GroupChildren=0; #endif;
	#ifdef HasLightSource; Constant isix_HasLightSource=HasLightSource; #ifnot; Constant isix_HasLightSource=0; #endif;
	#ifdef HashCoreCheckResize; Constant isix_HashCoreCheckResize=HashCoreCheckResize; #ifnot; Constant isix_HashCoreCheckResize=0; #endif;
	#ifdef HashCoreEntryMatches; Constant isix_HashCoreEntryMatches=HashCoreEntryMatches; #ifnot; Constant isix_HashCoreEntryMatches=0; #endif;
	#ifdef HashCoreLookUp; Constant isix_HashCoreLookUp=HashCoreLookUp; #ifnot; Constant isix_HashCoreLookUp=0; #endif;
	#ifdef HashCoreRelationHandler; Constant isix_HashCoreRelationHandler=HashCoreRelationHandler; #ifnot; Constant isix_HashCoreRelationHandler=0; #endif;
	#ifdef HashListRelationHandler; Constant isix_HashListRelationHandler=HashListRelationHandler; #ifnot; Constant isix_HashListRelationHandler=0; #endif;
	#ifdef HashTableRelationHandler; Constant isix_HashTableRelationHandler=HashTableRelationHandler; #ifnot; Constant isix_HashTableRelationHandler=0; #endif;
	#ifdef HasorHave; Constant isix_HasorHave=HasorHave; #ifnot; Constant isix_HasorHave=0; #endif;
	#ifdef HeapInitialise; Constant isix_HeapInitialise=HeapInitialise; #ifnot; Constant isix_HeapInitialise=0; #endif;
	#ifdef HeapLargestFreeBlock; Constant isix_HeapLargestFreeBlock=HeapLargestFreeBlock; #ifnot; Constant isix_HeapLargestFreeBlock=0; #endif;
	#ifdef HeapMakeSpace; Constant isix_HeapMakeSpace=HeapMakeSpace; #ifnot; Constant isix_HeapMakeSpace=0; #endif;
	#ifdef HeapNetFreeSpace; Constant isix_HeapNetFreeSpace=HeapNetFreeSpace; #ifnot; Constant isix_HeapNetFreeSpace=0; #endif;
	#ifdef HidesLightSource; Constant isix_HidesLightSource=HidesLightSource; #ifnot; Constant isix_HidesLightSource=0; #endif;
	#ifdef HimHerItself; Constant isix_HimHerItself=HimHerItself; #ifnot; Constant isix_HimHerItself=0; #endif;
	#ifdef HisHerTheir; Constant isix_HisHerTheir=HisHerTheir; #ifnot; Constant isix_HisHerTheir=0; #endif;
	#ifdef HolderOf; Constant isix_HolderOf=HolderOf; #ifnot; Constant isix_HolderOf=0; #endif;
	#ifdef HoursMinsWordToTime; Constant isix_HoursMinsWordToTime=HoursMinsWordToTime; #ifnot; Constant isix_HoursMinsWordToTime=0; #endif;
	#ifdef I7_ExtendedTryNumber; Constant isix_I7_ExtendedTryNumber=I7_ExtendedTryNumber; #ifnot; Constant isix_I7_ExtendedTryNumber=0; #endif;
	#ifdef I7_Kind_Name; Constant isix_I7_Kind_Name=I7_Kind_Name; #ifnot; Constant isix_I7_Kind_Name=0; #endif;
	#ifdef I7_SOO_CYC; Constant isix_I7_SOO_CYC=I7_SOO_CYC; #ifnot; Constant isix_I7_SOO_CYC=0; #endif;
	#ifdef I7_SOO_PAR; Constant isix_I7_SOO_PAR=I7_SOO_PAR; #ifnot; Constant isix_I7_SOO_PAR=0; #endif;
	#ifdef I7_SOO_RAN; Constant isix_I7_SOO_RAN=I7_SOO_RAN; #ifnot; Constant isix_I7_SOO_RAN=0; #endif;
	#ifdef I7_SOO_SHU; Constant isix_I7_SOO_SHU=I7_SOO_SHU; #ifnot; Constant isix_I7_SOO_SHU=0; #endif;
	#ifdef I7_SOO_STI; Constant isix_I7_SOO_STI=I7_SOO_STI; #ifnot; Constant isix_I7_SOO_STI=0; #endif;
	#ifdef I7_SOO_STOP; Constant isix_I7_SOO_STOP=I7_SOO_STOP; #ifnot; Constant isix_I7_SOO_STOP=0; #endif;
	#ifdef I7_SOO_TAP; Constant isix_I7_SOO_TAP=I7_SOO_TAP; #ifnot; Constant isix_I7_SOO_TAP=0; #endif;
	#ifdef I7_SOO_TPAR; Constant isix_I7_SOO_TPAR=I7_SOO_TPAR; #ifnot; Constant isix_I7_SOO_TPAR=0; #endif;
	#ifdef I7_SOO_TRAN; Constant isix_I7_SOO_TRAN=I7_SOO_TRAN; #ifnot; Constant isix_I7_SOO_TRAN=0; #endif;
	#ifdef I7_String; Constant isix_I7_String=I7_String; #ifnot; Constant isix_I7_String=0; #endif;
	#ifdef INDEXED_TEXT_TY_Cast; Constant isix_INDEXED_TEXT_TY_Cast=INDEXED_TEXT_TY_Cast; #ifnot; Constant isix_INDEXED_TEXT_TY_Cast=0; #endif;
	#ifdef INDEXED_TEXT_TY_Compare; Constant isix_INDEXED_TEXT_TY_Compare=INDEXED_TEXT_TY_Compare; #ifnot; Constant isix_INDEXED_TEXT_TY_Compare=0; #endif;
	#ifdef INDEXED_TEXT_TY_Create; Constant isix_INDEXED_TEXT_TY_Create=INDEXED_TEXT_TY_Create; #ifnot; Constant isix_INDEXED_TEXT_TY_Create=0; #endif;
	#ifdef INDEXED_TEXT_TY_Distinguish; Constant isix_INDEXED_TEXT_TY_Distinguish=INDEXED_TEXT_TY_Distinguish; #ifnot; Constant isix_INDEXED_TEXT_TY_Distinguish=0; #endif;
	#ifdef INDEXED_TEXT_TY_Empty; Constant isix_INDEXED_TEXT_TY_Empty=INDEXED_TEXT_TY_Empty; #ifnot; Constant isix_INDEXED_TEXT_TY_Empty=0; #endif;
	#ifdef INDEXED_TEXT_TY_Hash; Constant isix_INDEXED_TEXT_TY_Hash=INDEXED_TEXT_TY_Hash; #ifnot; Constant isix_INDEXED_TEXT_TY_Hash=0; #endif;
	#ifdef INDEXED_TEXT_TY_ROGPR; Constant isix_INDEXED_TEXT_TY_ROGPR=INDEXED_TEXT_TY_ROGPR; #ifnot; Constant isix_INDEXED_TEXT_TY_ROGPR=0; #endif;
	#ifdef INDEXED_TEXT_TY_ReadFile; Constant isix_INDEXED_TEXT_TY_ReadFile=INDEXED_TEXT_TY_ReadFile; #ifnot; Constant isix_INDEXED_TEXT_TY_ReadFile=0; #endif;
	#ifdef INDEXED_TEXT_TY_Say; Constant isix_INDEXED_TEXT_TY_Say=INDEXED_TEXT_TY_Say; #ifnot; Constant isix_INDEXED_TEXT_TY_Say=0; #endif;
	#ifdef INDEXED_TEXT_TY_Support; Constant isix_INDEXED_TEXT_TY_Support=INDEXED_TEXT_TY_Support; #ifnot; Constant isix_INDEXED_TEXT_TY_Support=0; #endif;
	#ifdef INDEXED_TEXT_TY_WriteFile; Constant isix_INDEXED_TEXT_TY_WriteFile=INDEXED_TEXT_TY_WriteFile; #ifnot; Constant isix_INDEXED_TEXT_TY_WriteFile=0; #endif;
	#ifdef IPMS_Lower; Constant isix_IPMS_Lower=IPMS_Lower; #ifnot; Constant isix_IPMS_Lower=0; #endif;
	#ifdef IPMS_Merge; Constant isix_IPMS_Merge=IPMS_Merge; #ifnot; Constant isix_IPMS_Merge=0; #endif;
	#ifdef IPMS_Reverse; Constant isix_IPMS_Reverse=IPMS_Reverse; #ifnot; Constant isix_IPMS_Reverse=0; #endif;
	#ifdef IPMS_Rotate; Constant isix_IPMS_Rotate=IPMS_Rotate; #ifnot; Constant isix_IPMS_Rotate=0; #endif;
	#ifdef IPMS_Upper; Constant isix_IPMS_Upper=IPMS_Upper; #ifnot; Constant isix_IPMS_Upper=0; #endif;
	#ifdef IT_BlobAccess; Constant isix_IT_BlobAccess=IT_BlobAccess; #ifnot; Constant isix_IT_BlobAccess=0; #endif;
	#ifdef IT_CHR_CompileTree; Constant isix_IT_CHR_CompileTree=IT_CHR_CompileTree; #ifnot; Constant isix_IT_CHR_CompileTree=0; #endif;
	#ifdef IT_CharacterLength; Constant isix_IT_CharacterLength=IT_CharacterLength; #ifnot; Constant isix_IT_CharacterLength=0; #endif;
	#ifdef IT_CharactersOfCase; Constant isix_IT_CharactersOfCase=IT_CharactersOfCase; #ifnot; Constant isix_IT_CharactersOfCase=0; #endif;
	#ifdef IT_CharactersToCase; Constant isix_IT_CharactersToCase=IT_CharactersToCase; #ifnot; Constant isix_IT_CharactersToCase=0; #endif;
	#ifdef IT_Concatenate; Constant isix_IT_Concatenate=IT_Concatenate; #ifnot; Constant isix_IT_Concatenate=0; #endif;
	#ifdef IT_GetBlob; Constant isix_IT_GetBlob=IT_GetBlob; #ifnot; Constant isix_IT_GetBlob=0; #endif;
	#ifdef IT_GetCharacter; Constant isix_IT_GetCharacter=IT_GetCharacter; #ifnot; Constant isix_IT_GetCharacter=0; #endif;
	#ifdef IT_MV_End; Constant isix_IT_MV_End=IT_MV_End; #ifnot; Constant isix_IT_MV_End=0; #endif;
	#ifdef IT_RE_CheckTree; Constant isix_IT_RE_CheckTree=IT_RE_CheckTree; #ifnot; Constant isix_IT_RE_CheckTree=0; #endif;
	#ifdef IT_RE_Clear_Markers; Constant isix_IT_RE_Clear_Markers=IT_RE_Clear_Markers; #ifnot; Constant isix_IT_RE_Clear_Markers=0; #endif;
	#ifdef IT_RE_CompileTree; Constant isix_IT_RE_CompileTree=IT_RE_CompileTree; #ifnot; Constant isix_IT_RE_CompileTree=0; #endif;
	#ifdef IT_RE_Concatenate; Constant isix_IT_RE_Concatenate=IT_RE_Concatenate; #ifnot; Constant isix_IT_RE_Concatenate=0; #endif;
	#ifdef IT_RE_CreateMatchVars; Constant isix_IT_RE_CreateMatchVars=IT_RE_CreateMatchVars; #ifnot; Constant isix_IT_RE_CreateMatchVars=0; #endif;
	#ifdef IT_RE_DebugMatchVars; Constant isix_IT_RE_DebugMatchVars=IT_RE_DebugMatchVars; #ifnot; Constant isix_IT_RE_DebugMatchVars=0; #endif;
	#ifdef IT_RE_DebugNode; Constant isix_IT_RE_DebugNode=IT_RE_DebugNode; #ifnot; Constant isix_IT_RE_DebugNode=0; #endif;
	#ifdef IT_RE_DebugSubtree; Constant isix_IT_RE_DebugSubtree=IT_RE_DebugSubtree; #ifnot; Constant isix_IT_RE_DebugSubtree=0; #endif;
	#ifdef IT_RE_DebugTree; Constant isix_IT_RE_DebugTree=IT_RE_DebugTree; #ifnot; Constant isix_IT_RE_DebugTree=0; #endif;
	#ifdef IT_RE_EmptyMatchVars; Constant isix_IT_RE_EmptyMatchVars=IT_RE_EmptyMatchVars; #ifnot; Constant isix_IT_RE_EmptyMatchVars=0; #endif;
	#ifdef IT_RE_EraseConstraints; Constant isix_IT_RE_EraseConstraints=IT_RE_EraseConstraints; #ifnot; Constant isix_IT_RE_EraseConstraints=0; #endif;
	#ifdef IT_RE_ExpandChoices; Constant isix_IT_RE_ExpandChoices=IT_RE_ExpandChoices; #ifnot; Constant isix_IT_RE_ExpandChoices=0; #endif;
	#ifdef IT_RE_FailSubexpressions; Constant isix_IT_RE_FailSubexpressions=IT_RE_FailSubexpressions; #ifnot; Constant isix_IT_RE_FailSubexpressions=0; #endif;
	#ifdef IT_RE_GetMatchVar; Constant isix_IT_RE_GetMatchVar=IT_RE_GetMatchVar; #ifnot; Constant isix_IT_RE_GetMatchVar=0; #endif;
	#ifdef IT_RE_MatchSubstring; Constant isix_IT_RE_MatchSubstring=IT_RE_MatchSubstring; #ifnot; Constant isix_IT_RE_MatchSubstring=0; #endif;
	#ifdef IT_RE_Node; Constant isix_IT_RE_Node=IT_RE_Node; #ifnot; Constant isix_IT_RE_Node=0; #endif;
	#ifdef IT_RE_NodeAddress; Constant isix_IT_RE_NodeAddress=IT_RE_NodeAddress; #ifnot; Constant isix_IT_RE_NodeAddress=0; #endif;
	#ifdef IT_RE_Parse; Constant isix_IT_RE_Parse=IT_RE_Parse; #ifnot; Constant isix_IT_RE_Parse=0; #endif;
	#ifdef IT_RE_ParseAtPosition; Constant isix_IT_RE_ParseAtPosition=IT_RE_ParseAtPosition; #ifnot; Constant isix_IT_RE_ParseAtPosition=0; #endif;
	#ifdef IT_RE_PrintNoRewinds; Constant isix_IT_RE_PrintNoRewinds=IT_RE_PrintNoRewinds; #ifnot; Constant isix_IT_RE_PrintNoRewinds=0; #endif;
	#ifdef IT_RE_Range; Constant isix_IT_RE_Range=IT_RE_Range; #ifnot; Constant isix_IT_RE_Range=0; #endif;
	#ifdef IT_RE_RangeSyntaxCorrect; Constant isix_IT_RE_RangeSyntaxCorrect=IT_RE_RangeSyntaxCorrect; #ifnot; Constant isix_IT_RE_RangeSyntaxCorrect=0; #endif;
	#ifdef IT_RE_SeekBacktrack; Constant isix_IT_RE_SeekBacktrack=IT_RE_SeekBacktrack; #ifnot; Constant isix_IT_RE_SeekBacktrack=0; #endif;
	#ifdef IT_RE_SetTrace; Constant isix_IT_RE_SetTrace=IT_RE_SetTrace; #ifnot; Constant isix_IT_RE_SetTrace=0; #endif;
	#ifdef IT_RE_Width; Constant isix_IT_RE_Width=IT_RE_Width; #ifnot; Constant isix_IT_RE_Width=0; #endif;
	#ifdef IT_ReplaceBlob; Constant isix_IT_ReplaceBlob=IT_ReplaceBlob; #ifnot; Constant isix_IT_ReplaceBlob=0; #endif;
	#ifdef IT_ReplaceText; Constant isix_IT_ReplaceText=IT_ReplaceText; #ifnot; Constant isix_IT_ReplaceText=0; #endif;
	#ifdef IT_Replace_RE; Constant isix_IT_Replace_RE=IT_Replace_RE; #ifnot; Constant isix_IT_Replace_RE=0; #endif;
	#ifdef IT_RevCase; Constant isix_IT_RevCase=IT_RevCase; #ifnot; Constant isix_IT_RevCase=0; #endif;
	#ifdef Identical; Constant isix_Identical=Identical; #ifnot; Constant isix_Identical=0; #endif;
	#ifdef ImplicitTake; Constant isix_ImplicitTake=ImplicitTake; #ifnot; Constant isix_ImplicitTake=0; #endif;
	#ifdef InPlaceMergeSortAlgorithm; Constant isix_InPlaceMergeSortAlgorithm=InPlaceMergeSortAlgorithm; #ifnot; Constant isix_InPlaceMergeSortAlgorithm=0; #endif;
	#ifdef IndirectlyContains; Constant isix_IndirectlyContains=IndirectlyContains; #ifnot; Constant isix_IndirectlyContains=0; #endif;
	#ifdef InitialHeapAllocation; Constant isix_InitialHeapAllocation=InitialHeapAllocation; #ifnot; Constant isix_InitialHeapAllocation=0; #endif;
	#ifdef InsertionSortAlgorithm; Constant isix_InsertionSortAlgorithm=InsertionSortAlgorithm; #ifnot; Constant isix_InsertionSortAlgorithm=0; #endif;
	#ifdef IntegerDivide; Constant isix_IntegerDivide=IntegerDivide; #ifnot; Constant isix_IntegerDivide=0; #endif;
	#ifdef IntegerRemainder; Constant isix_IntegerRemainder=IntegerRemainder; #ifnot; Constant isix_IntegerRemainder=0; #endif;
	#ifdef InternalTestCases; Constant isix_InternalTestCases=InternalTestCases; #ifnot; Constant isix_InternalTestCases=0; #endif;
	#ifdef IsSeeThrough; Constant isix_IsSeeThrough=IsSeeThrough; #ifnot; Constant isix_IsSeeThrough=0; #endif;
	#ifdef IsorAre; Constant isix_IsorAre=IsorAre; #ifnot; Constant isix_IsorAre=0; #endif;
	#ifdef IterateRelations; Constant isix_IterateRelations=IterateRelations; #ifnot; Constant isix_IterateRelations=0; #endif;
	#ifdef ItorThem; Constant isix_ItorThem=ItorThem; #ifnot; Constant isix_ItorThem=0; #endif;
	#ifdef KOVComparisonFunction; Constant isix_KOVComparisonFunction=KOVComparisonFunction; #ifnot; Constant isix_KOVComparisonFunction=0; #endif;
	#ifdef KOVDomainSize; Constant isix_KOVDomainSize=KOVDomainSize; #ifnot; Constant isix_KOVDomainSize=0; #endif;
	#ifdef KOVHashValue; Constant isix_KOVHashValue=KOVHashValue; #ifnot; Constant isix_KOVHashValue=0; #endif;
	#ifdef KOVIsBlockValue; Constant isix_KOVIsBlockValue=KOVIsBlockValue; #ifnot; Constant isix_KOVIsBlockValue=0; #endif;
	#ifdef KOVSupportFunction; Constant isix_KOVSupportFunction=KOVSupportFunction; #ifnot; Constant isix_KOVSupportFunction=0; #endif;
	#ifdef Keyboard; Constant isix_Keyboard=Keyboard; #ifnot; Constant isix_Keyboard=0; #endif;
	#ifdef KeyboardPrimitive; Constant isix_KeyboardPrimitive=KeyboardPrimitive; #ifnot; Constant isix_KeyboardPrimitive=0; #endif;
	#ifdef KindAtomic; Constant isix_KindAtomic=KindAtomic; #ifnot; Constant isix_KindAtomic=0; #endif;
	#ifdef KindBaseArity; Constant isix_KindBaseArity=KindBaseArity; #ifnot; Constant isix_KindBaseArity=0; #endif;
	#ifdef KindBaseTerm; Constant isix_KindBaseTerm=KindBaseTerm; #ifnot; Constant isix_KindBaseTerm=0; #endif;
	#ifdef LIST_OF_TY_AppendList; Constant isix_LIST_OF_TY_AppendList=LIST_OF_TY_AppendList; #ifnot; Constant isix_LIST_OF_TY_AppendList=0; #endif;
	#ifdef LIST_OF_TY_Compare; Constant isix_LIST_OF_TY_Compare=LIST_OF_TY_Compare; #ifnot; Constant isix_LIST_OF_TY_Compare=0; #endif;
	#ifdef LIST_OF_TY_ComparisonFn; Constant isix_LIST_OF_TY_ComparisonFn=LIST_OF_TY_ComparisonFn; #ifnot; Constant isix_LIST_OF_TY_ComparisonFn=0; #endif;
	#ifdef LIST_OF_TY_Copy; Constant isix_LIST_OF_TY_Copy=LIST_OF_TY_Copy; #ifnot; Constant isix_LIST_OF_TY_Copy=0; #endif;
	#ifdef LIST_OF_TY_CopyRawArray; Constant isix_LIST_OF_TY_CopyRawArray=LIST_OF_TY_CopyRawArray; #ifnot; Constant isix_LIST_OF_TY_CopyRawArray=0; #endif;
	#ifdef LIST_OF_TY_Create; Constant isix_LIST_OF_TY_Create=LIST_OF_TY_Create; #ifnot; Constant isix_LIST_OF_TY_Create=0; #endif;
	#ifdef LIST_OF_TY_Desc; Constant isix_LIST_OF_TY_Desc=LIST_OF_TY_Desc; #ifnot; Constant isix_LIST_OF_TY_Desc=0; #endif;
	#ifdef LIST_OF_TY_Destroy; Constant isix_LIST_OF_TY_Destroy=LIST_OF_TY_Destroy; #ifnot; Constant isix_LIST_OF_TY_Destroy=0; #endif;
	#ifdef LIST_OF_TY_Distinguish; Constant isix_LIST_OF_TY_Distinguish=LIST_OF_TY_Distinguish; #ifnot; Constant isix_LIST_OF_TY_Distinguish=0; #endif;
	#ifdef LIST_OF_TY_Empty; Constant isix_LIST_OF_TY_Empty=LIST_OF_TY_Empty; #ifnot; Constant isix_LIST_OF_TY_Empty=0; #endif;
	#ifdef LIST_OF_TY_FindItem; Constant isix_LIST_OF_TY_FindItem=LIST_OF_TY_FindItem; #ifnot; Constant isix_LIST_OF_TY_FindItem=0; #endif;
	#ifdef LIST_OF_TY_GetItem; Constant isix_LIST_OF_TY_GetItem=LIST_OF_TY_GetItem; #ifnot; Constant isix_LIST_OF_TY_GetItem=0; #endif;
	#ifdef LIST_OF_TY_GetLength; Constant isix_LIST_OF_TY_GetLength=LIST_OF_TY_GetLength; #ifnot; Constant isix_LIST_OF_TY_GetLength=0; #endif;
	#ifdef LIST_OF_TY_Hash; Constant isix_LIST_OF_TY_Hash=LIST_OF_TY_Hash; #ifnot; Constant isix_LIST_OF_TY_Hash=0; #endif;
	#ifdef LIST_OF_TY_InsertItem; Constant isix_LIST_OF_TY_InsertItem=LIST_OF_TY_InsertItem; #ifnot; Constant isix_LIST_OF_TY_InsertItem=0; #endif;
	#ifdef LIST_OF_TY_Mol; Constant isix_LIST_OF_TY_Mol=LIST_OF_TY_Mol; #ifnot; Constant isix_LIST_OF_TY_Mol=0; #endif;
	#ifdef LIST_OF_TY_PreCopy; Constant isix_LIST_OF_TY_PreCopy=LIST_OF_TY_PreCopy; #ifnot; Constant isix_LIST_OF_TY_PreCopy=0; #endif;
	#ifdef LIST_OF_TY_PutItem; Constant isix_LIST_OF_TY_PutItem=LIST_OF_TY_PutItem; #ifnot; Constant isix_LIST_OF_TY_PutItem=0; #endif;
	#ifdef LIST_OF_TY_RemoveItemRange; Constant isix_LIST_OF_TY_RemoveItemRange=LIST_OF_TY_RemoveItemRange; #ifnot; Constant isix_LIST_OF_TY_RemoveItemRange=0; #endif;
	#ifdef LIST_OF_TY_RemoveValue; Constant isix_LIST_OF_TY_RemoveValue=LIST_OF_TY_RemoveValue; #ifnot; Constant isix_LIST_OF_TY_RemoveValue=0; #endif;
	#ifdef LIST_OF_TY_Remove_List; Constant isix_LIST_OF_TY_Remove_List=LIST_OF_TY_Remove_List; #ifnot; Constant isix_LIST_OF_TY_Remove_List=0; #endif;
	#ifdef LIST_OF_TY_Reverse; Constant isix_LIST_OF_TY_Reverse=LIST_OF_TY_Reverse; #ifnot; Constant isix_LIST_OF_TY_Reverse=0; #endif;
	#ifdef LIST_OF_TY_Rotate; Constant isix_LIST_OF_TY_Rotate=LIST_OF_TY_Rotate; #ifnot; Constant isix_LIST_OF_TY_Rotate=0; #endif;
	#ifdef LIST_OF_TY_Say; Constant isix_LIST_OF_TY_Say=LIST_OF_TY_Say; #ifnot; Constant isix_LIST_OF_TY_Say=0; #endif;
	#ifdef LIST_OF_TY_SetLength; Constant isix_LIST_OF_TY_SetLength=LIST_OF_TY_SetLength; #ifnot; Constant isix_LIST_OF_TY_SetLength=0; #endif;
	#ifdef LIST_OF_TY_Set_Mol; Constant isix_LIST_OF_TY_Set_Mol=LIST_OF_TY_Set_Mol; #ifnot; Constant isix_LIST_OF_TY_Set_Mol=0; #endif;
	#ifdef LIST_OF_TY_Sort; Constant isix_LIST_OF_TY_Sort=LIST_OF_TY_Sort; #ifnot; Constant isix_LIST_OF_TY_Sort=0; #endif;
	#ifdef LIST_OF_TY_Support; Constant isix_LIST_OF_TY_Support=LIST_OF_TY_Support; #ifnot; Constant isix_LIST_OF_TY_Support=0; #endif;
	#ifdef LTI_Insert; Constant isix_LTI_Insert=LTI_Insert; #ifnot; Constant isix_LTI_Insert=0; #endif;
	#ifdef L__M; Constant isix_L__M=L__M; #ifnot; Constant isix_L__M=0; #endif;
	#ifdef LanguageContraction; Constant isix_LanguageContraction=LanguageContraction; #ifnot; Constant isix_LanguageContraction=0; #endif;
	#ifdef LanguageDirection; Constant isix_LanguageDirection=LanguageDirection; #ifnot; Constant isix_LanguageDirection=0; #endif;
	#ifdef LanguageLM; Constant isix_LanguageLM=LanguageLM; #ifnot; Constant isix_LanguageLM=0; #endif;
	#ifdef LanguageNumber; Constant isix_LanguageNumber=LanguageNumber; #ifnot; Constant isix_LanguageNumber=0; #endif;
	#ifdef LanguageTimeOfDay; Constant isix_LanguageTimeOfDay=LanguageTimeOfDay; #ifnot; Constant isix_LanguageTimeOfDay=0; #endif;
	#ifdef LanguageToInformese; Constant isix_LanguageToInformese=LanguageToInformese; #ifnot; Constant isix_LanguageToInformese=0; #endif;
	#ifdef LanguageVerb; Constant isix_LanguageVerb=LanguageVerb; #ifnot; Constant isix_LanguageVerb=0; #endif;
	#ifdef LanguageVerbLikesAdverb; Constant isix_LanguageVerbLikesAdverb=LanguageVerbLikesAdverb; #ifnot; Constant isix_LanguageVerbLikesAdverb=0; #endif;
	#ifdef LanguageVerbMayBeName; Constant isix_LanguageVerbMayBeName=LanguageVerbMayBeName; #ifnot; Constant isix_LanguageVerbMayBeName=0; #endif;
	#ifdef ListCompareEntries; Constant isix_ListCompareEntries=ListCompareEntries; #ifnot; Constant isix_ListCompareEntries=0; #endif;
	#ifdef ListEqual; Constant isix_ListEqual=ListEqual; #ifnot; Constant isix_ListEqual=0; #endif;
	#ifdef ListSwapEntries; Constant isix_ListSwapEntries=ListSwapEntries; #ifnot; Constant isix_ListSwapEntries=0; #endif;
	#ifdef LocationOf; Constant isix_LocationOf=LocationOf; #ifnot; Constant isix_LocationOf=0; #endif;
	#ifdef LookAfterGoing; Constant isix_LookAfterGoing=LookAfterGoing; #ifnot; Constant isix_LookAfterGoing=0; #endif;
	#ifdef LookSub; Constant isix_LookSub=LookSub; #ifnot; Constant isix_LookSub=0; #endif;
	#ifdef LoopOverScope; Constant isix_LoopOverScope=LoopOverScope; #ifnot; Constant isix_LoopOverScope=0; #endif;
	#ifdef MStack_CreateAVVars; Constant isix_MStack_CreateAVVars=MStack_CreateAVVars; #ifnot; Constant isix_MStack_CreateAVVars=0; #endif;
	#ifdef MStack_CreateRBVars; Constant isix_MStack_CreateRBVars=MStack_CreateRBVars; #ifnot; Constant isix_MStack_CreateRBVars=0; #endif;
	#ifdef MStack_DestroyAVVars; Constant isix_MStack_DestroyAVVars=MStack_DestroyAVVars; #ifnot; Constant isix_MStack_DestroyAVVars=0; #endif;
	#ifdef MStack_DestroyRBVars; Constant isix_MStack_DestroyRBVars=MStack_DestroyRBVars; #ifnot; Constant isix_MStack_DestroyRBVars=0; #endif;
	#ifdef Main; Constant isix_Main=Main; #ifnot; Constant isix_Main=0; #endif;
	#ifdef MakeColourWord; Constant isix_MakeColourWord=MakeColourWord; #ifnot; Constant isix_MakeColourWord=0; #endif;
	#ifdef MakeMatch; Constant isix_MakeMatch=MakeMatch; #ifnot; Constant isix_MakeMatch=0; #endif;
	#ifdef MakePart; Constant isix_MakePart=MakePart; #ifnot; Constant isix_MakePart=0; #endif;
	#ifdef MapConnection; Constant isix_MapConnection=MapConnection; #ifnot; Constant isix_MapConnection=0; #endif;
	#ifdef MapRouteTo; Constant isix_MapRouteTo=MapRouteTo; #ifnot; Constant isix_MapRouteTo=0; #endif;
	#ifdef MarkedListCoalesce; Constant isix_MarkedListCoalesce=MarkedListCoalesce; #ifnot; Constant isix_MarkedListCoalesce=0; #endif;
	#ifdef MarkedListIterator; Constant isix_MarkedListIterator=MarkedListIterator; #ifnot; Constant isix_MarkedListIterator=0; #endif;
	#ifdef MatchTextAgainstObject; Constant isix_MatchTextAgainstObject=MatchTextAgainstObject; #ifnot; Constant isix_MatchTextAgainstObject=0; #endif;
	#ifdef MistakeActionSub; Constant isix_MistakeActionSub=MistakeActionSub; #ifnot; Constant isix_MistakeActionSub=0; #endif;
	#ifdef MoveBackdrop; Constant isix_MoveBackdrop=MoveBackdrop; #ifnot; Constant isix_MoveBackdrop=0; #endif;
	#ifdef MoveDuringGoing; Constant isix_MoveDuringGoing=MoveDuringGoing; #ifnot; Constant isix_MoveDuringGoing=0; #endif;
	#ifdef MoveFloatingObjects; Constant isix_MoveFloatingObjects=MoveFloatingObjects; #ifnot; Constant isix_MoveFloatingObjects=0; #endif;
	#ifdef MoveObject; Constant isix_MoveObject=MoveObject; #ifnot; Constant isix_MoveObject=0; #endif;
	#ifdef MoveRuleAfter; Constant isix_MoveRuleAfter=MoveRuleAfter; #ifnot; Constant isix_MoveRuleAfter=0; #endif;
	#ifdef MoveRuleBefore; Constant isix_MoveRuleBefore=MoveRuleBefore; #ifnot; Constant isix_MoveRuleBefore=0; #endif;
	#ifdef MoveWord; Constant isix_MoveWord=MoveWord; #ifnot; Constant isix_MoveWord=0; #endif;
	#ifdef MstVO; Constant isix_MstVO=MstVO; #ifnot; Constant isix_MstVO=0; #endif;
	#ifdef MstVON; Constant isix_MstVON=MstVON; #ifnot; Constant isix_MstVON=0; #endif;
	#ifdef Mstack_Backtrace; Constant isix_Mstack_Backtrace=Mstack_Backtrace; #ifnot; Constant isix_Mstack_Backtrace=0; #endif;
	#ifdef Mstack_Create_Frame; Constant isix_Mstack_Create_Frame=Mstack_Create_Frame; #ifnot; Constant isix_Mstack_Create_Frame=0; #endif;
	#ifdef Mstack_Destroy_Frame; Constant isix_Mstack_Destroy_Frame=Mstack_Destroy_Frame; #ifnot; Constant isix_Mstack_Destroy_Frame=0; #endif;
	#ifdef Mstack_Seek_Frame; Constant isix_Mstack_Seek_Frame=Mstack_Seek_Frame; #ifnot; Constant isix_Mstack_Seek_Frame=0; #endif;
	#ifdef MultiAdd; Constant isix_MultiAdd=MultiAdd; #ifnot; Constant isix_MultiAdd=0; #endif;
	#ifdef MultiFilter; Constant isix_MultiFilter=MultiFilter; #ifnot; Constant isix_MultiFilter=0; #endif;
	#ifdef MultiSub; Constant isix_MultiSub=MultiSub; #ifnot; Constant isix_MultiSub=0; #endif;
	#ifdef NeedLightForAction; Constant isix_NeedLightForAction=NeedLightForAction; #ifnot; Constant isix_NeedLightForAction=0; #endif;
	#ifdef NeedToCarryNoun; Constant isix_NeedToCarryNoun=NeedToCarryNoun; #ifnot; Constant isix_NeedToCarryNoun=0; #endif;
	#ifdef NeedToCarrySecondNoun; Constant isix_NeedToCarrySecondNoun=NeedToCarrySecondNoun; #ifnot; Constant isix_NeedToCarrySecondNoun=0; #endif;
	#ifdef NeedToTouchNoun; Constant isix_NeedToTouchNoun=NeedToTouchNoun; #ifnot; Constant isix_NeedToTouchNoun=0; #endif;
	#ifdef NeedToTouchSecondNoun; Constant isix_NeedToTouchSecondNoun=NeedToTouchSecondNoun; #ifnot; Constant isix_NeedToTouchSecondNoun=0; #endif;
	#ifdef NextWord; Constant isix_NextWord=NextWord; #ifnot; Constant isix_NextWord=0; #endif;
	#ifdef NextWordStopped; Constant isix_NextWordStopped=NextWordStopped; #ifnot; Constant isix_NextWordStopped=0; #endif;
	#ifdef NotifyTheScore; Constant isix_NotifyTheScore=NotifyTheScore; #ifnot; Constant isix_NotifyTheScore=0; #endif;
	#ifdef NounDomain; Constant isix_NounDomain=NounDomain; #ifnot; Constant isix_NounDomain=0; #endif;
	#ifdef NounWord; Constant isix_NounWord=NounWord; #ifnot; Constant isix_NounWord=0; #endif;
	#ifdef NumberOfGroupsInList; Constant isix_NumberOfGroupsInList=NumberOfGroupsInList; #ifnot; Constant isix_NumberOfGroupsInList=0; #endif;
	#ifdef NumberWord; Constant isix_NumberWord=NumberWord; #ifnot; Constant isix_NumberWord=0; #endif;
	#ifdef ObjectIsUntouchable; Constant isix_ObjectIsUntouchable=ObjectIsUntouchable; #ifnot; Constant isix_ObjectIsUntouchable=0; #endif;
	#ifdef ObjectTreeCoalesce; Constant isix_ObjectTreeCoalesce=ObjectTreeCoalesce; #ifnot; Constant isix_ObjectTreeCoalesce=0; #endif;
	#ifdef ObjectTreeIterator; Constant isix_ObjectTreeIterator=ObjectTreeIterator; #ifnot; Constant isix_ObjectTreeIterator=0; #endif;
	#ifdef OffersLight; Constant isix_OffersLight=OffersLight; #ifnot; Constant isix_OffersLight=0; #endif;
	#ifdef OhLookItsReal; Constant isix_OhLookItsReal=OhLookItsReal; #ifnot; Constant isix_OhLookItsReal=0; #endif;
	#ifdef OhLookItsRoom; Constant isix_OhLookItsRoom=OhLookItsRoom; #ifnot; Constant isix_OhLookItsRoom=0; #endif;
	#ifdef OhLookItsThing; Constant isix_OhLookItsThing=OhLookItsThing; #ifnot; Constant isix_OhLookItsThing=0; #endif;
	#ifdef OldSortAlgorithm; Constant isix_OldSortAlgorithm=OldSortAlgorithm; #ifnot; Constant isix_OldSortAlgorithm=0; #endif;
	#ifdef OnStage; Constant isix_OnStage=OnStage; #ifnot; Constant isix_OnStage=0; #endif;
	#ifdef OtherSideOfDoor; Constant isix_OtherSideOfDoor=OtherSideOfDoor; #ifnot; Constant isix_OtherSideOfDoor=0; #endif;
	#ifdef OtoVRelRouteTo; Constant isix_OtoVRelRouteTo=OtoVRelRouteTo; #ifnot; Constant isix_OtoVRelRouteTo=0; #endif;
	#ifdef OwnerOf; Constant isix_OwnerOf=OwnerOf; #ifnot; Constant isix_OwnerOf=0; #endif;
	#ifdef PROPERTY_TY_Say; Constant isix_PROPERTY_TY_Say=PROPERTY_TY_Say; #ifnot; Constant isix_PROPERTY_TY_Say=0; #endif;
	#ifdef PSN__; Constant isix_PSN__=PSN__; #ifnot; Constant isix_PSN__=0; #endif;
	#ifdef ParaContent; Constant isix_ParaContent=ParaContent; #ifnot; Constant isix_ParaContent=0; #endif;
	#ifdef ParentOf; Constant isix_ParentOf=ParentOf; #ifnot; Constant isix_ParentOf=0; #endif;
	#ifdef ParseToken; Constant isix_ParseToken=ParseToken; #ifnot; Constant isix_ParseToken=0; #endif;
	#ifdef ParseTokenStopped; Constant isix_ParseTokenStopped=ParseTokenStopped; #ifnot; Constant isix_ParseTokenStopped=0; #endif;
	#ifdef ParseToken__; Constant isix_ParseToken__=ParseToken__; #ifnot; Constant isix_ParseToken__=0; #endif;
	#ifdef ParserError; Constant isix_ParserError=ParserError; #ifnot; Constant isix_ParserError=0; #endif;
	#ifdef Parser__parse; Constant isix_Parser__parse=Parser__parse; #ifnot; Constant isix_Parser__parse=0; #endif;
	#ifdef PartitionList; Constant isix_PartitionList=PartitionList; #ifnot; Constant isix_PartitionList=0; #endif;
	#ifdef Perform_Undo; Constant isix_Perform_Undo=Perform_Undo; #ifnot; Constant isix_Perform_Undo=0; #endif;
	#ifdef PlaceInScope; Constant isix_PlaceInScope=PlaceInScope; #ifnot; Constant isix_PlaceInScope=0; #endif;
	#ifdef PlaySound; Constant isix_PlaySound=PlaySound; #ifnot; Constant isix_PlaySound=0; #endif;
	#ifdef PlayerTo; Constant isix_PlayerTo=PlayerTo; #ifnot; Constant isix_PlayerTo=0; #endif;
	#ifdef PredictableSub; Constant isix_PredictableSub=PredictableSub; #ifnot; Constant isix_PredictableSub=0; #endif;
	#ifdef PrefaceByArticle; Constant isix_PrefaceByArticle=PrefaceByArticle; #ifnot; Constant isix_PrefaceByArticle=0; #endif;
	#ifdef PrepositionChain; Constant isix_PrepositionChain=PrepositionChain; #ifnot; Constant isix_PrepositionChain=0; #endif;
	#ifdef PrintCommand; Constant isix_PrintCommand=PrintCommand; #ifnot; Constant isix_PrintCommand=0; #endif;
	#ifdef PrintInferredCommand; Constant isix_PrintInferredCommand=PrintInferredCommand; #ifnot; Constant isix_PrintInferredCommand=0; #endif;
	#ifdef PrintKindValuePair; Constant isix_PrintKindValuePair=PrintKindValuePair; #ifnot; Constant isix_PrintKindValuePair=0; #endif;
	#ifdef PrintOrRun; Constant isix_PrintOrRun=PrintOrRun; #ifnot; Constant isix_PrintOrRun=0; #endif;
	#ifdef PrintPrompt; Constant isix_PrintPrompt=PrintPrompt; #ifnot; Constant isix_PrintPrompt=0; #endif;
	#ifdef PrintPropertyName; Constant isix_PrintPropertyName=PrintPropertyName; #ifnot; Constant isix_PrintPropertyName=0; #endif;
	#ifdef PrintRank; Constant isix_PrintRank=PrintRank; #ifnot; Constant isix_PrintRank=0; #endif;
	#ifdef PrintSceneName; Constant isix_PrintSceneName=PrintSceneName; #ifnot; Constant isix_PrintSceneName=0; #endif;
	#ifdef PrintSingleParagraph; Constant isix_PrintSingleParagraph=PrintSingleParagraph; #ifnot; Constant isix_PrintSingleParagraph=0; #endif;
	#ifdef PrintSnippet; Constant isix_PrintSnippet=PrintSnippet; #ifnot; Constant isix_PrintSnippet=0; #endif;
	#ifdef PrintSpaces; Constant isix_PrintSpaces=PrintSpaces; #ifnot; Constant isix_PrintSpaces=0; #endif;
	#ifdef PrintTableName; Constant isix_PrintTableName=PrintTableName; #ifnot; Constant isix_PrintTableName=0; #endif;
	#ifdef PrintText; Constant isix_PrintText=PrintText; #ifnot; Constant isix_PrintText=0; #endif;
	#ifdef PrintTimeOfDay; Constant isix_PrintTimeOfDay=PrintTimeOfDay; #ifnot; Constant isix_PrintTimeOfDay=0; #endif;
	#ifdef PrintTimeOfDayEnglish; Constant isix_PrintTimeOfDayEnglish=PrintTimeOfDayEnglish; #ifnot; Constant isix_PrintTimeOfDayEnglish=0; #endif;
	#ifdef PrintUseOption; Constant isix_PrintUseOption=PrintUseOption; #ifnot; Constant isix_PrintUseOption=0; #endif;
	#ifdef PrintVerb; Constant isix_PrintVerb=PrintVerb; #ifnot; Constant isix_PrintVerb=0; #endif;
	#ifdef Print_ScL; Constant isix_Print_ScL=Print_ScL; #ifnot; Constant isix_Print_ScL=0; #endif;
	#ifdef ProcessActivityRulebook; Constant isix_ProcessActivityRulebook=ProcessActivityRulebook; #ifnot; Constant isix_ProcessActivityRulebook=0; #endif;
	#ifdef ProcessRulebook; Constant isix_ProcessRulebook=ProcessRulebook; #ifnot; Constant isix_ProcessRulebook=0; #endif;
	#ifdef PronounNotice; Constant isix_PronounNotice=PronounNotice; #ifnot; Constant isix_PronounNotice=0; #endif;
	#ifdef PronounNoticeHeldObjects; Constant isix_PronounNoticeHeldObjects=PronounNoticeHeldObjects; #ifnot; Constant isix_PronounNoticeHeldObjects=0; #endif;
	#ifdef PronounValue; Constant isix_PronounValue=PronounValue; #ifnot; Constant isix_PronounValue=0; #endif;
	#ifdef Prop_Falsity; Constant isix_Prop_Falsity=Prop_Falsity; #ifnot; Constant isix_Prop_Falsity=0; #endif;
	#ifdef PushRuleChange; Constant isix_PushRuleChange=PushRuleChange; #ifnot; Constant isix_PushRuleChange=0; #endif;
	#ifdef RELATION_TY_Compare; Constant isix_RELATION_TY_Compare=RELATION_TY_Compare; #ifnot; Constant isix_RELATION_TY_Compare=0; #endif;
	#ifdef RELATION_TY_Copy; Constant isix_RELATION_TY_Copy=RELATION_TY_Copy; #ifnot; Constant isix_RELATION_TY_Copy=0; #endif;
	#ifdef RELATION_TY_Create; Constant isix_RELATION_TY_Create=RELATION_TY_Create; #ifnot; Constant isix_RELATION_TY_Create=0; #endif;
	#ifdef RELATION_TY_Destroy; Constant isix_RELATION_TY_Destroy=RELATION_TY_Destroy; #ifnot; Constant isix_RELATION_TY_Destroy=0; #endif;
	#ifdef RELATION_TY_Distinguish; Constant isix_RELATION_TY_Distinguish=RELATION_TY_Distinguish; #ifnot; Constant isix_RELATION_TY_Distinguish=0; #endif;
	#ifdef RELATION_TY_Empty; Constant isix_RELATION_TY_Empty=RELATION_TY_Empty; #ifnot; Constant isix_RELATION_TY_Empty=0; #endif;
	#ifdef RELATION_TY_EquivalenceAdjective; Constant isix_RELATION_TY_EquivalenceAdje=RELATION_TY_EquivalenceAdjective; #ifnot; Constant isix_RELATION_TY_EquivalenceAdje=0; #endif;
	#ifdef RELATION_TY_GetValency; Constant isix_RELATION_TY_GetValency=RELATION_TY_GetValency; #ifnot; Constant isix_RELATION_TY_GetValency=0; #endif;
	#ifdef RELATION_TY_Name; Constant isix_RELATION_TY_Name=RELATION_TY_Name; #ifnot; Constant isix_RELATION_TY_Name=0; #endif;
	#ifdef RELATION_TY_OToOAdjective; Constant isix_RELATION_TY_OToOAdjective=RELATION_TY_OToOAdjective; #ifnot; Constant isix_RELATION_TY_OToOAdjective=0; #endif;
	#ifdef RELATION_TY_OToVAdjective; Constant isix_RELATION_TY_OToVAdjective=RELATION_TY_OToVAdjective; #ifnot; Constant isix_RELATION_TY_OToVAdjective=0; #endif;
	#ifdef RELATION_TY_Say; Constant isix_RELATION_TY_Say=RELATION_TY_Say; #ifnot; Constant isix_RELATION_TY_Say=0; #endif;
	#ifdef RELATION_TY_SetValency; Constant isix_RELATION_TY_SetValency=RELATION_TY_SetValency; #ifnot; Constant isix_RELATION_TY_SetValency=0; #endif;
	#ifdef RELATION_TY_Support; Constant isix_RELATION_TY_Support=RELATION_TY_Support; #ifnot; Constant isix_RELATION_TY_Support=0; #endif;
	#ifdef RELATION_TY_SymmetricAdjective; Constant isix_RELATION_TY_SymmetricAdject=RELATION_TY_SymmetricAdjective; #ifnot; Constant isix_RELATION_TY_SymmetricAdject=0; #endif;
	#ifdef RELATION_TY_VToOAdjective; Constant isix_RELATION_TY_VToOAdjective=RELATION_TY_VToOAdjective; #ifnot; Constant isix_RELATION_TY_VToOAdjective=0; #endif;
	#ifdef RELATION_TY_VToVAdjective; Constant isix_RELATION_TY_VToVAdjective=RELATION_TY_VToVAdjective; #ifnot; Constant isix_RELATION_TY_VToVAdjective=0; #endif;
	#ifdef RELATIVE_TIME_TOKEN; Constant isix_RELATIVE_TIME_TOKEN=RELATIVE_TIME_TOKEN; #ifnot; Constant isix_RELATIVE_TIME_TOKEN=0; #endif;
	#ifdef RSE_Flip; Constant isix_RSE_Flip=RSE_Flip; #ifnot; Constant isix_RSE_Flip=0; #endif;
	#ifdef RSE_Set; Constant isix_RSE_Set=RSE_Set; #ifnot; Constant isix_RSE_Set=0; #endif;
	#ifdef Refers; Constant isix_Refers=Refers; #ifnot; Constant isix_Refers=0; #endif;
	#ifdef ReinstateRule; Constant isix_ReinstateRule=ReinstateRule; #ifnot; Constant isix_ReinstateRule=0; #endif;
	#ifdef RelFollowVector; Constant isix_RelFollowVector=RelFollowVector; #ifnot; Constant isix_RelFollowVector=0; #endif;
	#ifdef RelationRouteTo; Constant isix_RelationRouteTo=RelationRouteTo; #ifnot; Constant isix_RelationRouteTo=0; #endif;
	#ifdef RelationTest; Constant isix_RelationTest=RelationTest; #ifnot; Constant isix_RelationTest=0; #endif;
	#ifdef Relation_Now1to1; Constant isix_Relation_Now1to1=Relation_Now1to1; #ifnot; Constant isix_Relation_Now1to1=0; #endif;
	#ifdef Relation_Now1to1V; Constant isix_Relation_Now1to1V=Relation_Now1to1V; #ifnot; Constant isix_Relation_Now1to1V=0; #endif;
	#ifdef Relation_NowEquiv; Constant isix_Relation_NowEquiv=Relation_NowEquiv; #ifnot; Constant isix_Relation_NowEquiv=0; #endif;
	#ifdef Relation_NowEquivV; Constant isix_Relation_NowEquivV=Relation_NowEquivV; #ifnot; Constant isix_Relation_NowEquivV=0; #endif;
	#ifdef Relation_NowN1toV; Constant isix_Relation_NowN1toV=Relation_NowN1toV; #ifnot; Constant isix_Relation_NowN1toV=0; #endif;
	#ifdef Relation_NowN1toVV; Constant isix_Relation_NowN1toVV=Relation_NowN1toVV; #ifnot; Constant isix_Relation_NowN1toVV=0; #endif;
	#ifdef Relation_NowNEquiv; Constant isix_Relation_NowNEquiv=Relation_NowNEquiv; #ifnot; Constant isix_Relation_NowNEquiv=0; #endif;
	#ifdef Relation_NowNEquivV; Constant isix_Relation_NowNEquivV=Relation_NowNEquivV; #ifnot; Constant isix_Relation_NowNEquivV=0; #endif;
	#ifdef Relation_NowNVtoV; Constant isix_Relation_NowNVtoV=Relation_NowNVtoV; #ifnot; Constant isix_Relation_NowNVtoV=0; #endif;
	#ifdef Relation_NowS1to1; Constant isix_Relation_NowS1to1=Relation_NowS1to1; #ifnot; Constant isix_Relation_NowS1to1=0; #endif;
	#ifdef Relation_NowS1to1V; Constant isix_Relation_NowS1to1V=Relation_NowS1to1V; #ifnot; Constant isix_Relation_NowS1to1V=0; #endif;
	#ifdef Relation_NowSN1to1; Constant isix_Relation_NowSN1to1=Relation_NowSN1to1; #ifnot; Constant isix_Relation_NowSN1to1=0; #endif;
	#ifdef Relation_NowSN1to1V; Constant isix_Relation_NowSN1to1V=Relation_NowSN1to1V; #ifnot; Constant isix_Relation_NowSN1to1V=0; #endif;
	#ifdef Relation_NowVtoV; Constant isix_Relation_NowVtoV=Relation_NowVtoV; #ifnot; Constant isix_Relation_NowVtoV=0; #endif;
	#ifdef Relation_RShowOtoO; Constant isix_Relation_RShowOtoO=Relation_RShowOtoO; #ifnot; Constant isix_Relation_RShowOtoO=0; #endif;
	#ifdef Relation_ShowEquiv; Constant isix_Relation_ShowEquiv=Relation_ShowEquiv; #ifnot; Constant isix_Relation_ShowEquiv=0; #endif;
	#ifdef Relation_ShowOtoO; Constant isix_Relation_ShowOtoO=Relation_ShowOtoO; #ifnot; Constant isix_Relation_ShowOtoO=0; #endif;
	#ifdef Relation_ShowVtoV; Constant isix_Relation_ShowVtoV=Relation_ShowVtoV; #ifnot; Constant isix_Relation_ShowVtoV=0; #endif;
	#ifdef Relation_TestVtoV; Constant isix_Relation_TestVtoV=Relation_TestVtoV; #ifnot; Constant isix_Relation_TestVtoV=0; #endif;
	#ifdef RemoveFromPlay; Constant isix_RemoveFromPlay=RemoveFromPlay; #ifnot; Constant isix_RemoveFromPlay=0; #endif;
	#ifdef RequisitionStack; Constant isix_RequisitionStack=RequisitionStack; #ifnot; Constant isix_RequisitionStack=0; #endif;
	#ifdef ResetDescriptors; Constant isix_ResetDescriptors=ResetDescriptors; #ifnot; Constant isix_ResetDescriptors=0; #endif;
	#ifdef ResetVagueWords; Constant isix_ResetVagueWords=ResetVagueWords; #ifnot; Constant isix_ResetVagueWords=0; #endif;
	#ifdef ResultOfRule; Constant isix_ResultOfRule=ResultOfRule; #ifnot; Constant isix_ResultOfRule=0; #endif;
	#ifdef ReversedHashTableRelationHandler; Constant isix_ReversedHashTableRelationHa=ReversedHashTableRelationHandler; #ifnot; Constant isix_ReversedHashTableRelationHa=0; #endif;
	#ifdef ReviseMulti; Constant isix_ReviseMulti=ReviseMulti; #ifnot; Constant isix_ReviseMulti=0; #endif;
	#ifdef RoomOrDoorFrom; Constant isix_RoomOrDoorFrom=RoomOrDoorFrom; #ifnot; Constant isix_RoomOrDoorFrom=0; #endif;
	#ifdef RoundOffTime; Constant isix_RoundOffTime=RoundOffTime; #ifnot; Constant isix_RoundOffTime=0; #endif;
	#ifdef RuleHasNoOutcome; Constant isix_RuleHasNoOutcome=RuleHasNoOutcome; #ifnot; Constant isix_RuleHasNoOutcome=0; #endif;
	#ifdef RulePrintingRule; Constant isix_RulePrintingRule=RulePrintingRule; #ifnot; Constant isix_RulePrintingRule=0; #endif;
	#ifdef RulebookEmpty; Constant isix_RulebookEmpty=RulebookEmpty; #ifnot; Constant isix_RulebookEmpty=0; #endif;
	#ifdef RulebookFailed; Constant isix_RulebookFailed=RulebookFailed; #ifnot; Constant isix_RulebookFailed=0; #endif;
	#ifdef RulebookFails; Constant isix_RulebookFails=RulebookFails; #ifnot; Constant isix_RulebookFails=0; #endif;
	#ifdef RulebookOutcome; Constant isix_RulebookOutcome=RulebookOutcome; #ifnot; Constant isix_RulebookOutcome=0; #endif;
	#ifdef RulebookOutcomePrintingRule; Constant isix_RulebookOutcomePrintingRule=RulebookOutcomePrintingRule; #ifnot; Constant isix_RulebookOutcomePrintingRule=0; #endif;
	#ifdef RulebookSucceeded; Constant isix_RulebookSucceeded=RulebookSucceeded; #ifnot; Constant isix_RulebookSucceeded=0; #endif;
	#ifdef RulebookSucceeds; Constant isix_RulebookSucceeds=RulebookSucceeds; #ifnot; Constant isix_RulebookSucceeds=0; #endif;
	#ifdef RulesAllSub; Constant isix_RulesAllSub=RulesAllSub; #ifnot; Constant isix_RulesAllSub=0; #endif;
	#ifdef RulesOffSub; Constant isix_RulesOffSub=RulesOffSub; #ifnot; Constant isix_RulesOffSub=0; #endif;
	#ifdef RulesOnSub; Constant isix_RulesOnSub=RulesOnSub; #ifnot; Constant isix_RulesOnSub=0; #endif;
	#ifdef RunParagraphOn; Constant isix_RunParagraphOn=RunParagraphOn; #ifnot; Constant isix_RunParagraphOn=0; #endif;
	#ifdef RunRoutines; Constant isix_RunRoutines=RunRoutines; #ifnot; Constant isix_RunRoutines=0; #endif;
	#ifdef RunTimeError; Constant isix_RunTimeError=RunTimeError; #ifnot; Constant isix_RunTimeError=0; #endif;
	#ifdef RunTimeProblem; Constant isix_RunTimeProblem=RunTimeProblem; #ifnot; Constant isix_RunTimeProblem=0; #endif;
	#ifdef SL_Location; Constant isix_SL_Location=SL_Location; #ifnot; Constant isix_SL_Location=0; #endif;
	#ifdef SL_Score_Moves; Constant isix_SL_Score_Moves=SL_Score_Moves; #ifnot; Constant isix_SL_Score_Moves=0; #endif;
	#ifdef STORED_ACTION_TY_Adopt; Constant isix_STORED_ACTION_TY_Adopt=STORED_ACTION_TY_Adopt; #ifnot; Constant isix_STORED_ACTION_TY_Adopt=0; #endif;
	#ifdef STORED_ACTION_TY_Compare; Constant isix_STORED_ACTION_TY_Compare=STORED_ACTION_TY_Compare; #ifnot; Constant isix_STORED_ACTION_TY_Compare=0; #endif;
	#ifdef STORED_ACTION_TY_Copy; Constant isix_STORED_ACTION_TY_Copy=STORED_ACTION_TY_Copy; #ifnot; Constant isix_STORED_ACTION_TY_Copy=0; #endif;
	#ifdef STORED_ACTION_TY_Create; Constant isix_STORED_ACTION_TY_Create=STORED_ACTION_TY_Create; #ifnot; Constant isix_STORED_ACTION_TY_Create=0; #endif;
	#ifdef STORED_ACTION_TY_Current; Constant isix_STORED_ACTION_TY_Current=STORED_ACTION_TY_Current; #ifnot; Constant isix_STORED_ACTION_TY_Current=0; #endif;
	#ifdef STORED_ACTION_TY_Destroy; Constant isix_STORED_ACTION_TY_Destroy=STORED_ACTION_TY_Destroy; #ifnot; Constant isix_STORED_ACTION_TY_Destroy=0; #endif;
	#ifdef STORED_ACTION_TY_Distinguish; Constant isix_STORED_ACTION_TY_Distinguis=STORED_ACTION_TY_Distinguish; #ifnot; Constant isix_STORED_ACTION_TY_Distinguis=0; #endif;
	#ifdef STORED_ACTION_TY_Hash; Constant isix_STORED_ACTION_TY_Hash=STORED_ACTION_TY_Hash; #ifnot; Constant isix_STORED_ACTION_TY_Hash=0; #endif;
	#ifdef STORED_ACTION_TY_Involves; Constant isix_STORED_ACTION_TY_Involves=STORED_ACTION_TY_Involves; #ifnot; Constant isix_STORED_ACTION_TY_Involves=0; #endif;
	#ifdef STORED_ACTION_TY_New; Constant isix_STORED_ACTION_TY_New=STORED_ACTION_TY_New; #ifnot; Constant isix_STORED_ACTION_TY_New=0; #endif;
	#ifdef STORED_ACTION_TY_Part; Constant isix_STORED_ACTION_TY_Part=STORED_ACTION_TY_Part; #ifnot; Constant isix_STORED_ACTION_TY_Part=0; #endif;
	#ifdef STORED_ACTION_TY_Say; Constant isix_STORED_ACTION_TY_Say=STORED_ACTION_TY_Say; #ifnot; Constant isix_STORED_ACTION_TY_Say=0; #endif;
	#ifdef STORED_ACTION_TY_Support; Constant isix_STORED_ACTION_TY_Support=STORED_ACTION_TY_Support; #ifnot; Constant isix_STORED_ACTION_TY_Support=0; #endif;
	#ifdef STORED_ACTION_TY_Try; Constant isix_STORED_ACTION_TY_Try=STORED_ACTION_TY_Try; #ifnot; Constant isix_STORED_ACTION_TY_Try=0; #endif;
	#ifdef STORED_ACTION_TY_Unadopt; Constant isix_STORED_ACTION_TY_Unadopt=STORED_ACTION_TY_Unadopt; #ifnot; Constant isix_STORED_ACTION_TY_Unadopt=0; #endif;
	#ifdef STextSubstitution; Constant isix_STextSubstitution=STextSubstitution; #ifnot; Constant isix_STextSubstitution=0; #endif;
	#ifdef SafeSkipDescriptors; Constant isix_SafeSkipDescriptors=SafeSkipDescriptors; #ifnot; Constant isix_SafeSkipDescriptors=0; #endif;
	#ifdef SayActionName; Constant isix_SayActionName=SayActionName; #ifnot; Constant isix_SayActionName=0; #endif;
	#ifdef SayPhraseName; Constant isix_SayPhraseName=SayPhraseName; #ifnot; Constant isix_SayPhraseName=0; #endif;
	#ifdef ScanPropertyMetadata; Constant isix_ScanPropertyMetadata=ScanPropertyMetadata; #ifnot; Constant isix_ScanPropertyMetadata=0; #endif;
	#ifdef SceneUtility; Constant isix_SceneUtility=SceneUtility; #ifnot; Constant isix_SceneUtility=0; #endif;
	#ifdef ScenesOffSub; Constant isix_ScenesOffSub=ScenesOffSub; #ifnot; Constant isix_ScenesOffSub=0; #endif;
	#ifdef ScenesOnSub; Constant isix_ScenesOnSub=ScenesOnSub; #ifnot; Constant isix_ScenesOnSub=0; #endif;
	#ifdef ScopeCeiling; Constant isix_ScopeCeiling=ScopeCeiling; #ifnot; Constant isix_ScopeCeiling=0; #endif;
	#ifdef ScopeSub; Constant isix_ScopeSub=ScopeSub; #ifnot; Constant isix_ScopeSub=0; #endif;
	#ifdef ScopeWithin; Constant isix_ScopeWithin=ScopeWithin; #ifnot; Constant isix_ScopeWithin=0; #endif;
	#ifdef ScoreDabCombo; Constant isix_ScoreDabCombo=ScoreDabCombo; #ifnot; Constant isix_ScoreDabCombo=0; #endif;
	#ifdef ScoreMatchL; Constant isix_ScoreMatchL=ScoreMatchL; #ifnot; Constant isix_ScoreMatchL=0; #endif;
	#ifdef SearchScope; Constant isix_SearchScope=SearchScope; #ifnot; Constant isix_SearchScope=0; #endif;
	#ifdef SetActionBitmap; Constant isix_SetActionBitmap=SetActionBitmap; #ifnot; Constant isix_SetActionBitmap=0; #endif;
	#ifdef SetEitherOrProperty; Constant isix_SetEitherOrProperty=SetEitherOrProperty; #ifnot; Constant isix_SetEitherOrProperty=0; #endif;
	#ifdef SetPlayersCommand; Constant isix_SetPlayersCommand=SetPlayersCommand; #ifnot; Constant isix_SetPlayersCommand=0; #endif;
	#ifdef SetPronoun; Constant isix_SetPronoun=SetPronoun; #ifnot; Constant isix_SetPronoun=0; #endif;
	#ifdef SetRulebookOutcome; Constant isix_SetRulebookOutcome=SetRulebookOutcome; #ifnot; Constant isix_SetRulebookOutcome=0; #endif;
	#ifdef SetSortDomain; Constant isix_SetSortDomain=SetSortDomain; #ifnot; Constant isix_SetSortDomain=0; #endif;
	#ifdef SetTime; Constant isix_SetTime=SetTime; #ifnot; Constant isix_SetTime=0; #endif;
	#ifdef SetTimedEvent; Constant isix_SetTimedEvent=SetTimedEvent; #ifnot; Constant isix_SetTimedEvent=0; #endif;
	#ifdef ShowExtensionVersions; Constant isix_ShowExtensionVersions=ShowExtensionVersions; #ifnot; Constant isix_ShowExtensionVersions=0; #endif;
	#ifdef ShowFullExtensionVersions; Constant isix_ShowFullExtensionVersions=ShowFullExtensionVersions; #ifnot; Constant isix_ShowFullExtensionVersions=0; #endif;
	#ifdef ShowHeapSub; Constant isix_ShowHeapSub=ShowHeapSub; #ifnot; Constant isix_ShowHeapSub=0; #endif;
	#ifdef ShowMeRecursively; Constant isix_ShowMeRecursively=ShowMeRecursively; #ifnot; Constant isix_ShowMeRecursively=0; #endif;
	#ifdef ShowMeSub; Constant isix_ShowMeSub=ShowMeSub; #ifnot; Constant isix_ShowMeSub=0; #endif;
	#ifdef ShowOneRelation; Constant isix_ShowOneRelation=ShowOneRelation; #ifnot; Constant isix_ShowOneRelation=0; #endif;
	#ifdef ShowRLocation; Constant isix_ShowRLocation=ShowRLocation; #ifnot; Constant isix_ShowRLocation=0; #endif;
	#ifdef ShowRelationsSub; Constant isix_ShowRelationsSub=ShowRelationsSub; #ifnot; Constant isix_ShowRelationsSub=0; #endif;
	#ifdef ShowSceneStatus; Constant isix_ShowSceneStatus=ShowSceneStatus; #ifnot; Constant isix_ShowSceneStatus=0; #endif;
	#ifdef ShowVerbSub; Constant isix_ShowVerbSub=ShowVerbSub; #ifnot; Constant isix_ShowVerbSub=0; #endif;
	#ifdef SignalMapChange; Constant isix_SignalMapChange=SignalMapChange; #ifnot; Constant isix_SignalMapChange=0; #endif;
	#ifdef SilentlyConsiderLight; Constant isix_SilentlyConsiderLight=SilentlyConsiderLight; #ifnot; Constant isix_SilentlyConsiderLight=0; #endif;
	#ifdef SingleBestGuess; Constant isix_SingleBestGuess=SingleBestGuess; #ifnot; Constant isix_SingleBestGuess=0; #endif;
	#ifdef SlowCountRouteTo; Constant isix_SlowCountRouteTo=SlowCountRouteTo; #ifnot; Constant isix_SlowCountRouteTo=0; #endif;
	#ifdef SlowRouteTo; Constant isix_SlowRouteTo=SlowRouteTo; #ifnot; Constant isix_SlowRouteTo=0; #endif;
	#ifdef SnippetIncludes; Constant isix_SnippetIncludes=SnippetIncludes; #ifnot; Constant isix_SnippetIncludes=0; #endif;
	#ifdef SnippetMatches; Constant isix_SnippetMatches=SnippetMatches; #ifnot; Constant isix_SnippetMatches=0; #endif;
	#ifdef SortArray; Constant isix_SortArray=SortArray; #ifnot; Constant isix_SortArray=0; #endif;
	#ifdef SortRange; Constant isix_SortRange=SortRange; #ifnot; Constant isix_SortRange=0; #endif;
	#ifdef SpecialLookSpacingBreak; Constant isix_SpecialLookSpacingBreak=SpecialLookSpacingBreak; #ifnot; Constant isix_SpecialLookSpacingBreak=0; #endif;
	#ifdef SpliceSnippet; Constant isix_SpliceSnippet=SpliceSnippet; #ifnot; Constant isix_SpliceSnippet=0; #endif;
	#ifdef SpliceSnippet__TextPrinter; Constant isix_SpliceSnippet__TextPrinter=SpliceSnippet__TextPrinter; #ifnot; Constant isix_SpliceSnippet__TextPrinter=0; #endif;
	#ifdef SquareRoot; Constant isix_SquareRoot=SquareRoot; #ifnot; Constant isix_SquareRoot=0; #endif;
	#ifdef SubstituteRule; Constant isix_SubstituteRule=SubstituteRule; #ifnot; Constant isix_SubstituteRule=0; #endif;
	#ifdef SupporterOf; Constant isix_SupporterOf=SupporterOf; #ifnot; Constant isix_SupporterOf=0; #endif;
	#ifdef SuppressRule; Constant isix_SuppressRule=SuppressRule; #ifnot; Constant isix_SuppressRule=0; #endif;
	#ifdef SwapWorkflags; Constant isix_SwapWorkflags=SwapWorkflags; #ifnot; Constant isix_SwapWorkflags=0; #endif;
	#ifdef Sym2in1HashTableRelationHandler; Constant isix_Sym2in1HashTableRelationHan=Sym2in1HashTableRelationHandler; #ifnot; Constant isix_Sym2in1HashTableRelationHan=0; #endif;
	#ifdef SymDoubleHashSetRelationHandler; Constant isix_SymDoubleHashSetRelationHan=SymDoubleHashSetRelationHandler; #ifnot; Constant isix_SymDoubleHashSetRelationHan=0; #endif;
	#ifdef SymHashListRelationHandler; Constant isix_SymHashListRelationHandler=SymHashListRelationHandler; #ifnot; Constant isix_SymHashListRelationHandler=0; #endif;
	#ifdef TC_KOV; Constant isix_TC_KOV=TC_KOV; #ifnot; Constant isix_TC_KOV=0; #endif;
	#ifdef TIME_TOKEN; Constant isix_TIME_TOKEN=TIME_TOKEN; #ifnot; Constant isix_TIME_TOKEN=0; #endif;
	#ifdef TRUTH_STATE_TOKEN; Constant isix_TRUTH_STATE_TOKEN=TRUTH_STATE_TOKEN; #ifnot; Constant isix_TRUTH_STATE_TOKEN=0; #endif;
	#ifdef TableBlankOutAll; Constant isix_TableBlankOutAll=TableBlankOutAll; #ifnot; Constant isix_TableBlankOutAll=0; #endif;
	#ifdef TableBlankOutColumn; Constant isix_TableBlankOutColumn=TableBlankOutColumn; #ifnot; Constant isix_TableBlankOutColumn=0; #endif;
	#ifdef TableBlankOutRow; Constant isix_TableBlankOutRow=TableBlankOutRow; #ifnot; Constant isix_TableBlankOutRow=0; #endif;
	#ifdef TableBlankRow; Constant isix_TableBlankRow=TableBlankRow; #ifnot; Constant isix_TableBlankRow=0; #endif;
	#ifdef TableBlankRows; Constant isix_TableBlankRows=TableBlankRows; #ifnot; Constant isix_TableBlankRows=0; #endif;
	#ifdef TableColumnDebug; Constant isix_TableColumnDebug=TableColumnDebug; #ifnot; Constant isix_TableColumnDebug=0; #endif;
	#ifdef TableCompareRows; Constant isix_TableCompareRows=TableCompareRows; #ifnot; Constant isix_TableCompareRows=0; #endif;
	#ifdef TableFilledRows; Constant isix_TableFilledRows=TableFilledRows; #ifnot; Constant isix_TableFilledRows=0; #endif;
	#ifdef TableFindCol; Constant isix_TableFindCol=TableFindCol; #ifnot; Constant isix_TableFindCol=0; #endif;
	#ifdef TableLookUpCorr; Constant isix_TableLookUpCorr=TableLookUpCorr; #ifnot; Constant isix_TableLookUpCorr=0; #endif;
	#ifdef TableLookUpEntry; Constant isix_TableLookUpEntry=TableLookUpEntry; #ifnot; Constant isix_TableLookUpEntry=0; #endif;
	#ifdef TableMoveBlankBitsDown; Constant isix_TableMoveBlankBitsDown=TableMoveBlankBitsDown; #ifnot; Constant isix_TableMoveBlankBitsDown=0; #endif;
	#ifdef TableMoveBlanksToBack; Constant isix_TableMoveBlanksToBack=TableMoveBlanksToBack; #ifnot; Constant isix_TableMoveBlanksToBack=0; #endif;
	#ifdef TableMoveRowDown; Constant isix_TableMoveRowDown=TableMoveRowDown; #ifnot; Constant isix_TableMoveRowDown=0; #endif;
	#ifdef TableNextRow; Constant isix_TableNextRow=TableNextRow; #ifnot; Constant isix_TableNextRow=0; #endif;
	#ifdef TablePrint; Constant isix_TablePrint=TablePrint; #ifnot; Constant isix_TablePrint=0; #endif;
	#ifdef TableRandomRow; Constant isix_TableRandomRow=TableRandomRow; #ifnot; Constant isix_TableRandomRow=0; #endif;
	#ifdef TableRead; Constant isix_TableRead=TableRead; #ifnot; Constant isix_TableRead=0; #endif;
	#ifdef TableRowCorr; Constant isix_TableRowCorr=TableRowCorr; #ifnot; Constant isix_TableRowCorr=0; #endif;
	#ifdef TableRowIsBlank; Constant isix_TableRowIsBlank=TableRowIsBlank; #ifnot; Constant isix_TableRowIsBlank=0; #endif;
	#ifdef TableRows; Constant isix_TableRows=TableRows; #ifnot; Constant isix_TableRows=0; #endif;
	#ifdef TableShuffle; Constant isix_TableShuffle=TableShuffle; #ifnot; Constant isix_TableShuffle=0; #endif;
	#ifdef TableSort; Constant isix_TableSort=TableSort; #ifnot; Constant isix_TableSort=0; #endif;
	#ifdef TableSwapBlankBits; Constant isix_TableSwapBlankBits=TableSwapBlankBits; #ifnot; Constant isix_TableSwapBlankBits=0; #endif;
	#ifdef TableSwapRows; Constant isix_TableSwapRows=TableSwapRows; #ifnot; Constant isix_TableSwapRows=0; #endif;
	#ifdef TestActionBitmap; Constant isix_TestActionBitmap=TestActionBitmap; #ifnot; Constant isix_TestActionBitmap=0; #endif;
	#ifdef TestActionMask; Constant isix_TestActionMask=TestActionMask; #ifnot; Constant isix_TestActionMask=0; #endif;
	#ifdef TestActivity; Constant isix_TestActivity=TestActivity; #ifnot; Constant isix_TestActivity=0; #endif;
	#ifdef TestAdjacency; Constant isix_TestAdjacency=TestAdjacency; #ifnot; Constant isix_TestAdjacency=0; #endif;
	#ifdef TestConcealment; Constant isix_TestConcealment=TestConcealment; #ifnot; Constant isix_TestConcealment=0; #endif;
	#ifdef TestContainmentRange; Constant isix_TestContainmentRange=TestContainmentRange; #ifnot; Constant isix_TestContainmentRange=0; #endif;
	#ifdef TestKeyboardPrimitive; Constant isix_TestKeyboardPrimitive=TestKeyboardPrimitive; #ifnot; Constant isix_TestKeyboardPrimitive=0; #endif;
	#ifdef TestRegionalContainment; Constant isix_TestRegionalContainment=TestRegionalContainment; #ifnot; Constant isix_TestRegionalContainment=0; #endif;
	#ifdef TestScope; Constant isix_TestScope=TestScope; #ifnot; Constant isix_TestScope=0; #endif;
	#ifdef TestScriptSub; Constant isix_TestScriptSub=TestScriptSub; #ifnot; Constant isix_TestScriptSub=0; #endif;
	#ifdef TestSinglePastState; Constant isix_TestSinglePastState=TestSinglePastState; #ifnot; Constant isix_TestSinglePastState=0; #endif;
	#ifdef TestStart; Constant isix_TestStart=TestStart; #ifnot; Constant isix_TestStart=0; #endif;
	#ifdef TestTouchability; Constant isix_TestTouchability=TestTouchability; #ifnot; Constant isix_TestTouchability=0; #endif;
	#ifdef TestUseOption; Constant isix_TestUseOption=TestUseOption; #ifnot; Constant isix_TestUseOption=0; #endif;
	#ifdef TestVisibility; Constant isix_TestVisibility=TestVisibility; #ifnot; Constant isix_TestVisibility=0; #endif;
	#ifdef ThatorThose; Constant isix_ThatorThose=ThatorThose; #ifnot; Constant isix_ThatorThose=0; #endif;
	#ifdef TraceLevelSub; Constant isix_TraceLevelSub=TraceLevelSub; #ifnot; Constant isix_TraceLevelSub=0; #endif;
	#ifdef TraceOffSub; Constant isix_TraceOffSub=TraceOffSub; #ifnot; Constant isix_TraceOffSub=0; #endif;
	#ifdef TraceOnSub; Constant isix_TraceOnSub=TraceOnSub; #ifnot; Constant isix_TraceOnSub=0; #endif;
	#ifdef TrackActions; Constant isix_TrackActions=TrackActions; #ifnot; Constant isix_TrackActions=0; #endif;
	#ifdef TreatParserResults; Constant isix_TreatParserResults=TreatParserResults; #ifnot; Constant isix_TreatParserResults=0; #endif;
	#ifdef TryAction; Constant isix_TryAction=TryAction; #ifnot; Constant isix_TryAction=0; #endif;
	#ifdef TryGivenObject; Constant isix_TryGivenObject=TryGivenObject; #ifnot; Constant isix_TryGivenObject=0; #endif;
	#ifdef TryNumber; Constant isix_TryNumber=TryNumber; #ifnot; Constant isix_TryNumber=0; #endif;
	#ifdef TwoInOneCheckResize; Constant isix_TwoInOneCheckResize=TwoInOneCheckResize; #ifnot; Constant isix_TwoInOneCheckResize=0; #endif;
	#ifdef TwoInOneDelete; Constant isix_TwoInOneDelete=TwoInOneDelete; #ifnot; Constant isix_TwoInOneDelete=0; #endif;
	#ifdef TwoInOneEntryMatches; Constant isix_TwoInOneEntryMatches=TwoInOneEntryMatches; #ifnot; Constant isix_TwoInOneEntryMatches=0; #endif;
	#ifdef TwoInOneHashTableRelationHandler; Constant isix_TwoInOneHashTableRelationHa=TwoInOneHashTableRelationHandler; #ifnot; Constant isix_TwoInOneHashTableRelationHa=0; #endif;
	#ifdef TwoInOneLookUp; Constant isix_TwoInOneLookUp=TwoInOneLookUp; #ifnot; Constant isix_TwoInOneLookUp=0; #endif;
	#ifdef UnknownVerb; Constant isix_UnknownVerb=UnknownVerb; #ifnot; Constant isix_UnknownVerb=0; #endif;
	#ifdef UnpackGrammarLine; Constant isix_UnpackGrammarLine=UnpackGrammarLine; #ifnot; Constant isix_UnpackGrammarLine=0; #endif;
	#ifdef UnsignedCompare; Constant isix_UnsignedCompare=UnsignedCompare; #ifnot; Constant isix_UnsignedCompare=0; #endif;
	#ifdef UpdateActionBitmap; Constant isix_UpdateActionBitmap=UpdateActionBitmap; #ifnot; Constant isix_UpdateActionBitmap=0; #endif;
	#ifdef UseRule; Constant isix_UseRule=UseRule; #ifnot; Constant isix_UseRule=0; #endif;
	#ifdef VM_AllocateMemory; Constant isix_VM_AllocateMemory=VM_AllocateMemory; #ifnot; Constant isix_VM_AllocateMemory=0; #endif;
	#ifdef VM_ClearScreen; Constant isix_VM_ClearScreen=VM_ClearScreen; #ifnot; Constant isix_VM_ClearScreen=0; #endif;
	#ifdef VM_CommandTableAddress; Constant isix_VM_CommandTableAddress=VM_CommandTableAddress; #ifnot; Constant isix_VM_CommandTableAddress=0; #endif;
	#ifdef VM_CopyBuffer; Constant isix_VM_CopyBuffer=VM_CopyBuffer; #ifnot; Constant isix_VM_CopyBuffer=0; #endif;
	#ifdef VM_Describe_Release; Constant isix_VM_Describe_Release=VM_Describe_Release; #ifnot; Constant isix_VM_Describe_Release=0; #endif;
	#ifdef VM_DictionaryAddressToNumber; Constant isix_VM_DictionaryAddressToNumbe=VM_DictionaryAddressToNumber; #ifnot; Constant isix_VM_DictionaryAddressToNumbe=0; #endif;
	#ifdef VM_FreeMemory; Constant isix_VM_FreeMemory=VM_FreeMemory; #ifnot; Constant isix_VM_FreeMemory=0; #endif;
	#ifdef VM_Initialise; Constant isix_VM_Initialise=VM_Initialise; #ifnot; Constant isix_VM_Initialise=0; #endif;
	#ifdef VM_InvalidDictionaryAddress; Constant isix_VM_InvalidDictionaryAddress=VM_InvalidDictionaryAddress; #ifnot; Constant isix_VM_InvalidDictionaryAddress=0; #endif;
	#ifdef VM_KeyChar; Constant isix_VM_KeyChar=VM_KeyChar; #ifnot; Constant isix_VM_KeyChar=0; #endif;
	#ifdef VM_KeyDelay; Constant isix_VM_KeyDelay=VM_KeyDelay; #ifnot; Constant isix_VM_KeyDelay=0; #endif;
	#ifdef VM_KeyDelay_Interrupt; Constant isix_VM_KeyDelay_Interrupt=VM_KeyDelay_Interrupt; #ifnot; Constant isix_VM_KeyDelay_Interrupt=0; #endif;
	#ifdef VM_LowerToUpperCase; Constant isix_VM_LowerToUpperCase=VM_LowerToUpperCase; #ifnot; Constant isix_VM_LowerToUpperCase=0; #endif;
	#ifdef VM_MainWindow; Constant isix_VM_MainWindow=VM_MainWindow; #ifnot; Constant isix_VM_MainWindow=0; #endif;
	#ifdef VM_MoveCursorInStatusLine; Constant isix_VM_MoveCursorInStatusLine=VM_MoveCursorInStatusLine; #ifnot; Constant isix_VM_MoveCursorInStatusLine=0; #endif;
	#ifdef VM_NumberToDictionaryAddress; Constant isix_VM_NumberToDictionaryAddres=VM_NumberToDictionaryAddress; #ifnot; Constant isix_VM_NumberToDictionaryAddres=0; #endif;
	#ifdef VM_Picture; Constant isix_VM_Picture=VM_Picture; #ifnot; Constant isix_VM_Picture=0; #endif;
	#ifdef VM_PreInitialise; Constant isix_VM_PreInitialise=VM_PreInitialise; #ifnot; Constant isix_VM_PreInitialise=0; #endif;
	#ifdef VM_PrintCommandWords; Constant isix_VM_PrintCommandWords=VM_PrintCommandWords; #ifnot; Constant isix_VM_PrintCommandWords=0; #endif;
	#ifdef VM_PrintToBuffer; Constant isix_VM_PrintToBuffer=VM_PrintToBuffer; #ifnot; Constant isix_VM_PrintToBuffer=0; #endif;
	#ifdef VM_ReadKeyboard; Constant isix_VM_ReadKeyboard=VM_ReadKeyboard; #ifnot; Constant isix_VM_ReadKeyboard=0; #endif;
	#ifdef VM_RestoreWindowColours; Constant isix_VM_RestoreWindowColours=VM_RestoreWindowColours; #ifnot; Constant isix_VM_RestoreWindowColours=0; #endif;
	#ifdef VM_Save_Undo; Constant isix_VM_Save_Undo=VM_Save_Undo; #ifnot; Constant isix_VM_Save_Undo=0; #endif;
	#ifdef VM_ScreenHeight; Constant isix_VM_ScreenHeight=VM_ScreenHeight; #ifnot; Constant isix_VM_ScreenHeight=0; #endif;
	#ifdef VM_ScreenWidth; Constant isix_VM_ScreenWidth=VM_ScreenWidth; #ifnot; Constant isix_VM_ScreenWidth=0; #endif;
	#ifdef VM_Seed_RNG; Constant isix_VM_Seed_RNG=VM_Seed_RNG; #ifnot; Constant isix_VM_Seed_RNG=0; #endif;
	#ifdef VM_SetWindowColours; Constant isix_VM_SetWindowColours=VM_SetWindowColours; #ifnot; Constant isix_VM_SetWindowColours=0; #endif;
	#ifdef VM_SoundEffect; Constant isix_VM_SoundEffect=VM_SoundEffect; #ifnot; Constant isix_VM_SoundEffect=0; #endif;
	#ifdef VM_StatusLineHeight; Constant isix_VM_StatusLineHeight=VM_StatusLineHeight; #ifnot; Constant isix_VM_StatusLineHeight=0; #endif;
	#ifdef VM_Style; Constant isix_VM_Style=VM_Style; #ifnot; Constant isix_VM_Style=0; #endif;
	#ifdef VM_Tokenise; Constant isix_VM_Tokenise=VM_Tokenise; #ifnot; Constant isix_VM_Tokenise=0; #endif;
	#ifdef VM_Undo; Constant isix_VM_Undo=VM_Undo; #ifnot; Constant isix_VM_Undo=0; #endif;
	#ifdef VM_UpperToLowerCase; Constant isix_VM_UpperToLowerCase=VM_UpperToLowerCase; #ifnot; Constant isix_VM_UpperToLowerCase=0; #endif;
	#ifdef VisibilityParent; Constant isix_VisibilityParent=VisibilityParent; #ifnot; Constant isix_VisibilityParent=0; #endif;
	#ifdef VtoORelRouteTo; Constant isix_VtoORelRouteTo=VtoORelRouteTo; #ifnot; Constant isix_VtoORelRouteTo=0; #endif;
	#ifdef VtoVRelRouteTo; Constant isix_VtoVRelRouteTo=VtoVRelRouteTo; #ifnot; Constant isix_VtoVRelRouteTo=0; #endif;
	#ifdef WearObject; Constant isix_WearObject=WearObject; #ifnot; Constant isix_WearObject=0; #endif;
	#ifdef WearerOf; Constant isix_WearerOf=WearerOf; #ifnot; Constant isix_WearerOf=0; #endif;
	#ifdef WhetherIn; Constant isix_WhetherIn=WhetherIn; #ifnot; Constant isix_WhetherIn=0; #endif;
	#ifdef WhetherProvides; Constant isix_WhetherProvides=WhetherProvides; #ifnot; Constant isix_WhetherProvides=0; #endif;
	#ifdef WillRecurs; Constant isix_WillRecurs=WillRecurs; #ifnot; Constant isix_WillRecurs=0; #endif;
	#ifdef WordAddress; Constant isix_WordAddress=WordAddress; #ifnot; Constant isix_WordAddress=0; #endif;
	#ifdef WordCount; Constant isix_WordCount=WordCount; #ifnot; Constant isix_WordCount=0; #endif;
	#ifdef WordFrom; Constant isix_WordFrom=WordFrom; #ifnot; Constant isix_WordFrom=0; #endif;
	#ifdef WordInProperty; Constant isix_WordInProperty=WordInProperty; #ifnot; Constant isix_WordInProperty=0; #endif;
	#ifdef WordLength; Constant isix_WordLength=WordLength; #ifnot; Constant isix_WordLength=0; #endif;
	#ifdef WriteAfterEntry; Constant isix_WriteAfterEntry=WriteAfterEntry; #ifnot; Constant isix_WriteAfterEntry=0; #endif;
	#ifdef WriteGProperty; Constant isix_WriteGProperty=WriteGProperty; #ifnot; Constant isix_WriteGProperty=0; #endif;
	#ifdef WriteLIST_OF_TY_GetItem; Constant isix_WriteLIST_OF_TY_GetItem=WriteLIST_OF_TY_GetItem; #ifnot; Constant isix_WriteLIST_OF_TY_GetItem=0; #endif;
	#ifdef WriteListFrom; Constant isix_WriteListFrom=WriteListFrom; #ifnot; Constant isix_WriteListFrom=0; #endif;
	#ifdef WriteListOfMarkedObjects; Constant isix_WriteListOfMarkedObjects=WriteListOfMarkedObjects; #ifnot; Constant isix_WriteListOfMarkedObjects=0; #endif;
	#ifdef WriteListR; Constant isix_WriteListR=WriteListR; #ifnot; Constant isix_WriteListR=0; #endif;
	#ifdef WriteMultiClassGroup; Constant isix_WriteMultiClassGroup=WriteMultiClassGroup; #ifnot; Constant isix_WriteMultiClassGroup=0; #endif;
	#ifdef WriteSingleClassGroup; Constant isix_WriteSingleClassGroup=WriteSingleClassGroup; #ifnot; Constant isix_WriteSingleClassGroup=0; #endif;
	#ifdef XAbstractSub; Constant isix_XAbstractSub=XAbstractSub; #ifnot; Constant isix_XAbstractSub=0; #endif;
	#ifdef XObj; Constant isix_XObj=XObj; #ifnot; Constant isix_XObj=0; #endif;
	#ifdef XPurloinSub; Constant isix_XPurloinSub=XPurloinSub; #ifnot; Constant isix_XPurloinSub=0; #endif;
	#ifdef XTestMove; Constant isix_XTestMove=XTestMove; #ifnot; Constant isix_XTestMove=0; #endif;
	#ifdef XTreeSub; Constant isix_XTreeSub=XTreeSub; #ifnot; Constant isix_XTreeSub=0; #endif;
	#ifdef YesOrNo; Constant isix_YesOrNo=YesOrNo; #ifnot; Constant isix_YesOrNo=0; #endif;
	#ifdef Z6_DrawStatusLine; Constant isix_Z6_DrawStatusLine=Z6_DrawStatusLine; #ifnot; Constant isix_Z6_DrawStatusLine=0; #endif;
	#ifdef Z6_MoveCursor; Constant isix_Z6_MoveCursor=Z6_MoveCursor; #ifnot; Constant isix_Z6_MoveCursor=0; #endif;
	#ifdef ZRegion; Constant isix_ZRegion=ZRegion; #ifnot; Constant isix_ZRegion=0; #endif;
	#ifdef glk_buffer_to_lower_case_uni; Constant isix_glk_buffer_to_lower_case_un=glk_buffer_to_lower_case_uni; #ifnot; Constant isix_glk_buffer_to_lower_case_un=0; #endif;
	#ifdef glk_buffer_to_title_case_uni; Constant isix_glk_buffer_to_title_case_un=glk_buffer_to_title_case_uni; #ifnot; Constant isix_glk_buffer_to_title_case_un=0; #endif;
	#ifdef glk_buffer_to_upper_case_uni; Constant isix_glk_buffer_to_upper_case_un=glk_buffer_to_upper_case_uni; #ifnot; Constant isix_glk_buffer_to_upper_case_un=0; #endif;
	#ifdef glk_cancel_char_event; Constant isix_glk_cancel_char_event=glk_cancel_char_event; #ifnot; Constant isix_glk_cancel_char_event=0; #endif;
	#ifdef glk_cancel_hyperlink_event; Constant isix_glk_cancel_hyperlink_event=glk_cancel_hyperlink_event; #ifnot; Constant isix_glk_cancel_hyperlink_event=0; #endif;
	#ifdef glk_cancel_line_event; Constant isix_glk_cancel_line_event=glk_cancel_line_event; #ifnot; Constant isix_glk_cancel_line_event=0; #endif;
	#ifdef glk_cancel_mouse_event; Constant isix_glk_cancel_mouse_event=glk_cancel_mouse_event; #ifnot; Constant isix_glk_cancel_mouse_event=0; #endif;
	#ifdef glk_char_to_lower; Constant isix_glk_char_to_lower=glk_char_to_lower; #ifnot; Constant isix_glk_char_to_lower=0; #endif;
	#ifdef glk_char_to_upper; Constant isix_glk_char_to_upper=glk_char_to_upper; #ifnot; Constant isix_glk_char_to_upper=0; #endif;
	#ifdef glk_exit; Constant isix_glk_exit=glk_exit; #ifnot; Constant isix_glk_exit=0; #endif;
	#ifdef glk_fileref_create_by_name; Constant isix_glk_fileref_create_by_name=glk_fileref_create_by_name; #ifnot; Constant isix_glk_fileref_create_by_name=0; #endif;
	#ifdef glk_fileref_create_by_prompt; Constant isix_glk_fileref_create_by_promp=glk_fileref_create_by_prompt; #ifnot; Constant isix_glk_fileref_create_by_promp=0; #endif;
	#ifdef glk_fileref_create_from_fileref; Constant isix_glk_fileref_create_from_fil=glk_fileref_create_from_fileref; #ifnot; Constant isix_glk_fileref_create_from_fil=0; #endif;
	#ifdef glk_fileref_create_temp; Constant isix_glk_fileref_create_temp=glk_fileref_create_temp; #ifnot; Constant isix_glk_fileref_create_temp=0; #endif;
	#ifdef glk_fileref_delete_file; Constant isix_glk_fileref_delete_file=glk_fileref_delete_file; #ifnot; Constant isix_glk_fileref_delete_file=0; #endif;
	#ifdef glk_fileref_destroy; Constant isix_glk_fileref_destroy=glk_fileref_destroy; #ifnot; Constant isix_glk_fileref_destroy=0; #endif;
	#ifdef glk_fileref_does_file_exist; Constant isix_glk_fileref_does_file_exist=glk_fileref_does_file_exist; #ifnot; Constant isix_glk_fileref_does_file_exist=0; #endif;
	#ifdef glk_fileref_get_rock; Constant isix_glk_fileref_get_rock=glk_fileref_get_rock; #ifnot; Constant isix_glk_fileref_get_rock=0; #endif;
	#ifdef glk_fileref_iterate; Constant isix_glk_fileref_iterate=glk_fileref_iterate; #ifnot; Constant isix_glk_fileref_iterate=0; #endif;
	#ifdef glk_gestalt; Constant isix_glk_gestalt=glk_gestalt; #ifnot; Constant isix_glk_gestalt=0; #endif;
	#ifdef glk_gestalt_ext; Constant isix_glk_gestalt_ext=glk_gestalt_ext; #ifnot; Constant isix_glk_gestalt_ext=0; #endif;
	#ifdef glk_get_buffer_stream; Constant isix_glk_get_buffer_stream=glk_get_buffer_stream; #ifnot; Constant isix_glk_get_buffer_stream=0; #endif;
	#ifdef glk_get_buffer_stream_uni; Constant isix_glk_get_buffer_stream_uni=glk_get_buffer_stream_uni; #ifnot; Constant isix_glk_get_buffer_stream_uni=0; #endif;
	#ifdef glk_get_char_stream; Constant isix_glk_get_char_stream=glk_get_char_stream; #ifnot; Constant isix_glk_get_char_stream=0; #endif;
	#ifdef glk_get_char_stream_uni; Constant isix_glk_get_char_stream_uni=glk_get_char_stream_uni; #ifnot; Constant isix_glk_get_char_stream_uni=0; #endif;
	#ifdef glk_get_line_stream; Constant isix_glk_get_line_stream=glk_get_line_stream; #ifnot; Constant isix_glk_get_line_stream=0; #endif;
	#ifdef glk_get_line_stream_uni; Constant isix_glk_get_line_stream_uni=glk_get_line_stream_uni; #ifnot; Constant isix_glk_get_line_stream_uni=0; #endif;
	#ifdef glk_image_draw; Constant isix_glk_image_draw=glk_image_draw; #ifnot; Constant isix_glk_image_draw=0; #endif;
	#ifdef glk_image_draw_scaled; Constant isix_glk_image_draw_scaled=glk_image_draw_scaled; #ifnot; Constant isix_glk_image_draw_scaled=0; #endif;
	#ifdef glk_image_get_info; Constant isix_glk_image_get_info=glk_image_get_info; #ifnot; Constant isix_glk_image_get_info=0; #endif;
	#ifdef glk_put_buffer; Constant isix_glk_put_buffer=glk_put_buffer; #ifnot; Constant isix_glk_put_buffer=0; #endif;
	#ifdef glk_put_buffer_stream; Constant isix_glk_put_buffer_stream=glk_put_buffer_stream; #ifnot; Constant isix_glk_put_buffer_stream=0; #endif;
	#ifdef glk_put_buffer_stream_uni; Constant isix_glk_put_buffer_stream_uni=glk_put_buffer_stream_uni; #ifnot; Constant isix_glk_put_buffer_stream_uni=0; #endif;
	#ifdef glk_put_buffer_uni; Constant isix_glk_put_buffer_uni=glk_put_buffer_uni; #ifnot; Constant isix_glk_put_buffer_uni=0; #endif;
	#ifdef glk_put_char; Constant isix_glk_put_char=glk_put_char; #ifnot; Constant isix_glk_put_char=0; #endif;
	#ifdef glk_put_char_stream; Constant isix_glk_put_char_stream=glk_put_char_stream; #ifnot; Constant isix_glk_put_char_stream=0; #endif;
	#ifdef glk_put_char_stream_uni; Constant isix_glk_put_char_stream_uni=glk_put_char_stream_uni; #ifnot; Constant isix_glk_put_char_stream_uni=0; #endif;
	#ifdef glk_put_char_uni; Constant isix_glk_put_char_uni=glk_put_char_uni; #ifnot; Constant isix_glk_put_char_uni=0; #endif;
	#ifdef glk_put_string; Constant isix_glk_put_string=glk_put_string; #ifnot; Constant isix_glk_put_string=0; #endif;
	#ifdef glk_put_string_stream; Constant isix_glk_put_string_stream=glk_put_string_stream; #ifnot; Constant isix_glk_put_string_stream=0; #endif;
	#ifdef glk_put_string_stream_uni; Constant isix_glk_put_string_stream_uni=glk_put_string_stream_uni; #ifnot; Constant isix_glk_put_string_stream_uni=0; #endif;
	#ifdef glk_put_string_uni; Constant isix_glk_put_string_uni=glk_put_string_uni; #ifnot; Constant isix_glk_put_string_uni=0; #endif;
	#ifdef glk_request_char_event; Constant isix_glk_request_char_event=glk_request_char_event; #ifnot; Constant isix_glk_request_char_event=0; #endif;
	#ifdef glk_request_char_event_uni; Constant isix_glk_request_char_event_uni=glk_request_char_event_uni; #ifnot; Constant isix_glk_request_char_event_uni=0; #endif;
	#ifdef glk_request_hyperlink_event; Constant isix_glk_request_hyperlink_event=glk_request_hyperlink_event; #ifnot; Constant isix_glk_request_hyperlink_event=0; #endif;
	#ifdef glk_request_line_event; Constant isix_glk_request_line_event=glk_request_line_event; #ifnot; Constant isix_glk_request_line_event=0; #endif;
	#ifdef glk_request_line_event_uni; Constant isix_glk_request_line_event_uni=glk_request_line_event_uni; #ifnot; Constant isix_glk_request_line_event_uni=0; #endif;
	#ifdef glk_request_mouse_event; Constant isix_glk_request_mouse_event=glk_request_mouse_event; #ifnot; Constant isix_glk_request_mouse_event=0; #endif;
	#ifdef glk_request_timer_events; Constant isix_glk_request_timer_events=glk_request_timer_events; #ifnot; Constant isix_glk_request_timer_events=0; #endif;
	#ifdef glk_schannel_create; Constant isix_glk_schannel_create=glk_schannel_create; #ifnot; Constant isix_glk_schannel_create=0; #endif;
	#ifdef glk_schannel_destroy; Constant isix_glk_schannel_destroy=glk_schannel_destroy; #ifnot; Constant isix_glk_schannel_destroy=0; #endif;
	#ifdef glk_schannel_get_rock; Constant isix_glk_schannel_get_rock=glk_schannel_get_rock; #ifnot; Constant isix_glk_schannel_get_rock=0; #endif;
	#ifdef glk_schannel_iterate; Constant isix_glk_schannel_iterate=glk_schannel_iterate; #ifnot; Constant isix_glk_schannel_iterate=0; #endif;
	#ifdef glk_schannel_play; Constant isix_glk_schannel_play=glk_schannel_play; #ifnot; Constant isix_glk_schannel_play=0; #endif;
	#ifdef glk_schannel_play_ext; Constant isix_glk_schannel_play_ext=glk_schannel_play_ext; #ifnot; Constant isix_glk_schannel_play_ext=0; #endif;
	#ifdef glk_schannel_set_volume; Constant isix_glk_schannel_set_volume=glk_schannel_set_volume; #ifnot; Constant isix_glk_schannel_set_volume=0; #endif;
	#ifdef glk_schannel_stop; Constant isix_glk_schannel_stop=glk_schannel_stop; #ifnot; Constant isix_glk_schannel_stop=0; #endif;
	#ifdef glk_select; Constant isix_glk_select=glk_select; #ifnot; Constant isix_glk_select=0; #endif;
	#ifdef glk_select_poll; Constant isix_glk_select_poll=glk_select_poll; #ifnot; Constant isix_glk_select_poll=0; #endif;
	#ifdef glk_set_hyperlink; Constant isix_glk_set_hyperlink=glk_set_hyperlink; #ifnot; Constant isix_glk_set_hyperlink=0; #endif;
	#ifdef glk_set_hyperlink_stream; Constant isix_glk_set_hyperlink_stream=glk_set_hyperlink_stream; #ifnot; Constant isix_glk_set_hyperlink_stream=0; #endif;
	#ifdef glk_set_interrupt_handler; Constant isix_glk_set_interrupt_handler=glk_set_interrupt_handler; #ifnot; Constant isix_glk_set_interrupt_handler=0; #endif;
	#ifdef glk_set_style; Constant isix_glk_set_style=glk_set_style; #ifnot; Constant isix_glk_set_style=0; #endif;
	#ifdef glk_set_style_stream; Constant isix_glk_set_style_stream=glk_set_style_stream; #ifnot; Constant isix_glk_set_style_stream=0; #endif;
	#ifdef glk_set_window; Constant isix_glk_set_window=glk_set_window; #ifnot; Constant isix_glk_set_window=0; #endif;
	#ifdef glk_sound_load_hint; Constant isix_glk_sound_load_hint=glk_sound_load_hint; #ifnot; Constant isix_glk_sound_load_hint=0; #endif;
	#ifdef glk_stream_close; Constant isix_glk_stream_close=glk_stream_close; #ifnot; Constant isix_glk_stream_close=0; #endif;
	#ifdef glk_stream_get_current; Constant isix_glk_stream_get_current=glk_stream_get_current; #ifnot; Constant isix_glk_stream_get_current=0; #endif;
	#ifdef glk_stream_get_position; Constant isix_glk_stream_get_position=glk_stream_get_position; #ifnot; Constant isix_glk_stream_get_position=0; #endif;
	#ifdef glk_stream_get_rock; Constant isix_glk_stream_get_rock=glk_stream_get_rock; #ifnot; Constant isix_glk_stream_get_rock=0; #endif;
	#ifdef glk_stream_iterate; Constant isix_glk_stream_iterate=glk_stream_iterate; #ifnot; Constant isix_glk_stream_iterate=0; #endif;
	#ifdef glk_stream_open_file; Constant isix_glk_stream_open_file=glk_stream_open_file; #ifnot; Constant isix_glk_stream_open_file=0; #endif;
	#ifdef glk_stream_open_file_uni; Constant isix_glk_stream_open_file_uni=glk_stream_open_file_uni; #ifnot; Constant isix_glk_stream_open_file_uni=0; #endif;
	#ifdef glk_stream_open_memory; Constant isix_glk_stream_open_memory=glk_stream_open_memory; #ifnot; Constant isix_glk_stream_open_memory=0; #endif;
	#ifdef glk_stream_open_memory_uni; Constant isix_glk_stream_open_memory_uni=glk_stream_open_memory_uni; #ifnot; Constant isix_glk_stream_open_memory_uni=0; #endif;
	#ifdef glk_stream_set_current; Constant isix_glk_stream_set_current=glk_stream_set_current; #ifnot; Constant isix_glk_stream_set_current=0; #endif;
	#ifdef glk_stream_set_position; Constant isix_glk_stream_set_position=glk_stream_set_position; #ifnot; Constant isix_glk_stream_set_position=0; #endif;
	#ifdef glk_style_distinguish; Constant isix_glk_style_distinguish=glk_style_distinguish; #ifnot; Constant isix_glk_style_distinguish=0; #endif;
	#ifdef glk_style_measure; Constant isix_glk_style_measure=glk_style_measure; #ifnot; Constant isix_glk_style_measure=0; #endif;
	#ifdef glk_stylehint_clear; Constant isix_glk_stylehint_clear=glk_stylehint_clear; #ifnot; Constant isix_glk_stylehint_clear=0; #endif;
	#ifdef glk_stylehint_set; Constant isix_glk_stylehint_set=glk_stylehint_set; #ifnot; Constant isix_glk_stylehint_set=0; #endif;
	#ifdef glk_tick; Constant isix_glk_tick=glk_tick; #ifnot; Constant isix_glk_tick=0; #endif;
	#ifdef glk_window_clear; Constant isix_glk_window_clear=glk_window_clear; #ifnot; Constant isix_glk_window_clear=0; #endif;
	#ifdef glk_window_close; Constant isix_glk_window_close=glk_window_close; #ifnot; Constant isix_glk_window_close=0; #endif;
	#ifdef glk_window_erase_rect; Constant isix_glk_window_erase_rect=glk_window_erase_rect; #ifnot; Constant isix_glk_window_erase_rect=0; #endif;
	#ifdef glk_window_fill_rect; Constant isix_glk_window_fill_rect=glk_window_fill_rect; #ifnot; Constant isix_glk_window_fill_rect=0; #endif;
	#ifdef glk_window_flow_break; Constant isix_glk_window_flow_break=glk_window_flow_break; #ifnot; Constant isix_glk_window_flow_break=0; #endif;
	#ifdef glk_window_get_arrangement; Constant isix_glk_window_get_arrangement=glk_window_get_arrangement; #ifnot; Constant isix_glk_window_get_arrangement=0; #endif;
	#ifdef glk_window_get_echo_stream; Constant isix_glk_window_get_echo_stream=glk_window_get_echo_stream; #ifnot; Constant isix_glk_window_get_echo_stream=0; #endif;
	#ifdef glk_window_get_parent; Constant isix_glk_window_get_parent=glk_window_get_parent; #ifnot; Constant isix_glk_window_get_parent=0; #endif;
	#ifdef glk_window_get_rock; Constant isix_glk_window_get_rock=glk_window_get_rock; #ifnot; Constant isix_glk_window_get_rock=0; #endif;
	#ifdef glk_window_get_root; Constant isix_glk_window_get_root=glk_window_get_root; #ifnot; Constant isix_glk_window_get_root=0; #endif;
	#ifdef glk_window_get_sibling; Constant isix_glk_window_get_sibling=glk_window_get_sibling; #ifnot; Constant isix_glk_window_get_sibling=0; #endif;
	#ifdef glk_window_get_size; Constant isix_glk_window_get_size=glk_window_get_size; #ifnot; Constant isix_glk_window_get_size=0; #endif;
	#ifdef glk_window_get_stream; Constant isix_glk_window_get_stream=glk_window_get_stream; #ifnot; Constant isix_glk_window_get_stream=0; #endif;
	#ifdef glk_window_get_type; Constant isix_glk_window_get_type=glk_window_get_type; #ifnot; Constant isix_glk_window_get_type=0; #endif;
	#ifdef glk_window_iterate; Constant isix_glk_window_iterate=glk_window_iterate; #ifnot; Constant isix_glk_window_iterate=0; #endif;
	#ifdef glk_window_move_cursor; Constant isix_glk_window_move_cursor=glk_window_move_cursor; #ifnot; Constant isix_glk_window_move_cursor=0; #endif;
	#ifdef glk_window_open; Constant isix_glk_window_open=glk_window_open; #ifnot; Constant isix_glk_window_open=0; #endif;
	#ifdef glk_window_set_arrangement; Constant isix_glk_window_set_arrangement=glk_window_set_arrangement; #ifnot; Constant isix_glk_window_set_arrangement=0; #endif;
	#ifdef glk_window_set_background_color; Constant isix_glk_window_set_background_c=glk_window_set_background_color; #ifnot; Constant isix_glk_window_set_background_c=0; #endif;
	#ifdef glk_window_set_echo_stream; Constant isix_glk_window_set_echo_stream=glk_window_set_echo_stream; #ifnot; Constant isix_glk_window_set_echo_stream=0; #endif;
	#ifdef loc; Constant isix_loc=loc; #ifnot; Constant isix_loc=0; #endif;
	#ifdef testcommandnoun; Constant isix_testcommandnoun=testcommandnoun; #ifnot; Constant isix_testcommandnoun=0; #endif;
-) after "RelationKind.i6t".

Chapter "Inlined Phrases for Standard Template Routines"

To decide what number is the address of I6_AGL__M: (- isix_AGL__M -).
To decide what number is the address of I6_AbandonActivity: (- isix_AbandonActivity -).
To decide what number is the address of I6_AbbreviatedRoomDescription: (- isix_AbbreviatedRoomDescription -).
To decide what number is the address of I6_ActRulebookFails: (- isix_ActRulebookFails -).
To decide what number is the address of I6_ActRulebookSucceeds: (- isix_ActRulebookSucceeds -).
To decide what number is the address of I6_ActionNumberIndexed: (- isix_ActionNumberIndexed -).
To decide what number is the address of I6_ActionPrimitive: (- isix_ActionPrimitive -).
To decide what number is the address of I6_ActionVariablesNotTypeSafe: (- isix_ActionVariablesNotTypeSafe -).
To decide what number is the address of I6_ActionsOffSub: (- isix_ActionsOffSub -).
To decide what number is the address of I6_ActionsOnSub: (- isix_ActionsOnSub -).
To decide what number is the address of I6_ActivityEmpty: (- isix_ActivityEmpty -).
To decide what number is the address of I6_AddToScope: (- isix_AddToScope -).
To decide what number is the address of I6_Adjudicate: (- isix_Adjudicate -).
To decide what number is the address of I6_AllowInShowme: (- isix_AllowInShowme -).
To decide what number is the address of I6_AnalyseToken: (- isix_AnalyseToken -).
To decide what number is the address of I6_ArgumentTypeFailed: (- isix_ArgumentTypeFailed -).
To decide what number is the address of I6_ArticleDescriptors: (- isix_ArticleDescriptors -).
To decide what number is the address of I6_AssertMapConnection: (- isix_AssertMapConnection -).
To decide what number is the address of I6_AssertMapUnconnection: (- isix_AssertMapUnconnection -).
To decide what number is the address of I6_BackSideOfDoor: (- isix_BackSideOfDoor -).
To decide what number is the address of I6_Banner: (- isix_Banner -).
To decide what number is the address of I6_BeginAction: (- isix_BeginAction -).
To decide what number is the address of I6_BeginActivity: (- isix_BeginActivity -).
To decide what number is the address of I6_BeginFollowRulebook: (- isix_BeginFollowRulebook -).
To decide what number is the address of I6_BestGuess: (- isix_BestGuess -).
To decide what number is the address of I6_BlkAllocate: (- isix_BlkAllocate -).
To decide what number is the address of I6_BlkAllocationError: (- isix_BlkAllocationError -).
To decide what number is the address of I6_BlkDebug: (- isix_BlkDebug -).
To decide what number is the address of I6_BlkDebugDecomposition: (- isix_BlkDebugDecomposition -).
To decide what number is the address of I6_BlkFree: (- isix_BlkFree -).
To decide what number is the address of I6_BlkFreeSingleBlock: (- isix_BlkFreeSingleBlock -).
To decide what number is the address of I6_BlkMerge: (- isix_BlkMerge -).
To decide what number is the address of I6_BlkRecut: (- isix_BlkRecut -).
To decide what number is the address of I6_BlkResize: (- isix_BlkResize -).
To decide what number is the address of I6_BlkSize: (- isix_BlkSize -).
To decide what number is the address of I6_BlkTotalSize: (- isix_BlkTotalSize -).
To decide what number is the address of I6_BlkType: (- isix_BlkType -).
To decide what number is the address of I6_BlkValueCast: (- isix_BlkValueCast -).
To decide what number is the address of I6_BlkValueCompare: (- isix_BlkValueCompare -).
To decide what number is the address of I6_BlkValueCopy: (- isix_BlkValueCopy -).
To decide what number is the address of I6_BlkValueCreate: (- isix_BlkValueCreate -).
To decide what number is the address of I6_BlkValueDestroy: (- isix_BlkValueDestroy -).
To decide what number is the address of I6_BlkValueExtent: (- isix_BlkValueExtent -).
To decide what number is the address of I6_BlkValueHash: (- isix_BlkValueHash -).
To decide what number is the address of I6_BlkValueInitialCopy: (- isix_BlkValueInitialCopy -).
To decide what number is the address of I6_BlkValueRead: (- isix_BlkValueRead -).
To decide what number is the address of I6_BlkValueReadFromFile: (- isix_BlkValueReadFromFile -).
To decide what number is the address of I6_BlkValueSetExtent: (- isix_BlkValueSetExtent -).
To decide what number is the address of I6_BlkValueWrite: (- isix_BlkValueWrite -).
To decide what number is the address of I6_BlkValueWriteToFile: (- isix_BlkValueWriteToFile -).
To decide what number is the address of I6_COBJ__Copy: (- isix_COBJ__Copy -).
To decide what number is the address of I6_COBJ__SwapMatches: (- isix_COBJ__SwapMatches -).
To decide what number is the address of I6_COMBINATION_TY_Compare: (- isix_COMBINATION_TY_Compare -).
To decide what number is the address of I6_COMBINATION_TY_Copy: (- isix_COMBINATION_TY_Copy -).
To decide what number is the address of I6_COMBINATION_TY_CopyRawArray: (- isix_COMBINATION_TY_CopyRawArray -).
To decide what number is the address of I6_COMBINATION_TY_Create: (- isix_COMBINATION_TY_Create -).
To decide what number is the address of I6_COMBINATION_TY_Destroy: (- isix_COMBINATION_TY_Destroy -).
To decide what number is the address of I6_COMBINATION_TY_Distinguish: (- isix_COMBINATION_TY_Distinguish -).
To decide what number is the address of I6_COMBINATION_TY_Hash: (- isix_COMBINATION_TY_Hash -).
To decide what number is the address of I6_COMBINATION_TY_PreCopy: (- isix_COMBINATION_TY_PreCopy -).
To decide what number is the address of I6_COMBINATION_TY_Say: (- isix_COMBINATION_TY_Say -).
To decide what number is the address of I6_COMBINATION_TY_Support: (- isix_COMBINATION_TY_Support -).
To decide what number is the address of I6_CPrintOrRun: (- isix_CPrintOrRun -).
To decide what number is the address of I6_CThatorThose: (- isix_CThatorThose -).
To decide what number is the address of I6_CTheyreorThats: (- isix_CTheyreorThats -).
To decide what number is the address of I6_CantSee: (- isix_CantSee -).
To decide what number is the address of I6_Cap: (- isix_Cap -).
To decide what number is the address of I6_CarrierOf: (- isix_CarrierOf -).
To decide what number is the address of I6_CarryOutActivity: (- isix_CarryOutActivity -).
To decide what number is the address of I6_ChangePlayer: (- isix_ChangePlayer -).
To decide what number is the address of I6_CharIsOfCase: (- isix_CharIsOfCase -).
To decide what number is the address of I6_CharTestCases: (- isix_CharTestCases -).
To decide what number is the address of I6_CharToCase: (- isix_CharToCase -).
To decide what number is the address of I6_CheckKindReturned: (- isix_CheckKindReturned -).
To decide what number is the address of I6_CheckTableEntryIsBlank: (- isix_CheckTableEntryIsBlank -).
To decide what number is the address of I6_ChooseObjects: (- isix_ChooseObjects -).
To decide what number is the address of I6_ChooseRelationHandler: (- isix_ChooseRelationHandler -).
To decide what number is the address of I6_ChronologyPoint: (- isix_ChronologyPoint -).
To decide what number is the address of I6_ClearBoxedText: (- isix_ClearBoxedText -).
To decide what number is the address of I6_ClearParagraphing: (- isix_ClearParagraphing -).
To decide what number is the address of I6_CommandClarificationBreak: (- isix_CommandClarificationBreak -).
To decide what number is the address of I6_CommonAncestor: (- isix_CommonAncestor -).
To decide what number is the address of I6_CompareFields: (- isix_CompareFields -).
To decide what number is the address of I6_ComponentHasLight: (- isix_ComponentHasLight -).
To decide what number is the address of I6_ComputeFWMatrix: (- isix_ComputeFWMatrix -).
To decide what number is the address of I6_ConsultNounFilterToken: (- isix_ConsultNounFilterToken -).
To decide what number is the address of I6_ContainerOf: (- isix_ContainerOf -).
To decide what number is the address of I6_ConvertToGoingWithPush: (- isix_ConvertToGoingWithPush -).
To decide what number is the address of I6_CoreOf: (- isix_CoreOf -).
To decide what number is the address of I6_CoreOfParentOfCoreOf: (- isix_CoreOfParentOfCoreOf -).
To decide what number is the address of I6_CreateBlockConstants: (- isix_CreateBlockConstants -).
To decide what number is the address of I6_CreateDynamicRelations: (- isix_CreateDynamicRelations -).
To decide what number is the address of I6_CreatePropertyOffsets: (- isix_CreatePropertyOffsets -).
To decide what number is the address of I6_CreatureTest: (- isix_CreatureTest -).
To decide what number is the address of I6_CubeRoot: (- isix_CubeRoot -).
To decide what number is the address of I6_DA_Name: (- isix_DA_Name -).
To decide what number is the address of I6_DA_Number: (- isix_DA_Number -).
To decide what number is the address of I6_DA_Topic: (- isix_DA_Topic -).
To decide what number is the address of I6_DA_TruthState: (- isix_DA_TruthState -).
To decide what number is the address of I6_DB_Action: (- isix_DB_Action -).
To decide what number is the address of I6_DB_Action_Details: (- isix_DB_Action_Details -).
To decide what number is the address of I6_DB_Rule: (- isix_DB_Rule -).
To decide what number is the address of I6_DECIMAL_TOKEN: (- isix_DECIMAL_TOKEN -).
To decide what number is the address of I6_DebugAction: (- isix_DebugAction -).
To decide what number is the address of I6_DebugAttribute: (- isix_DebugAttribute -).
To decide what number is the address of I6_DebugGrammarLine: (- isix_DebugGrammarLine -).
To decide what number is the address of I6_DebugHeap: (- isix_DebugHeap -).
To decide what number is the address of I6_DebugPartition: (- isix_DebugPartition -).
To decide what number is the address of I6_DebugRulebooks: (- isix_DebugRulebooks -).
To decide what number is the address of I6_DebugToken: (- isix_DebugToken -).
To decide what number is the address of I6_DecimalNumber: (- isix_DecimalNumber -).
To decide what number is the address of I6_DefaultTopic: (- isix_DefaultTopic -).
To decide what number is the address of I6_DefaultValueFinder: (- isix_DefaultValueFinder -).
To decide what number is the address of I6_DefaultValueOfKOV: (- isix_DefaultValueOfKOV -).
To decide what number is the address of I6_Descriptors: (- isix_Descriptors -).
To decide what number is the address of I6_DetachPart: (- isix_DetachPart -).
To decide what number is the address of I6_DetectPluralWord: (- isix_DetectPluralWord -).
To decide what number is the address of I6_DetectSceneChange: (- isix_DetectSceneChange -).
To decide what number is the address of I6_DiagnoseSortList: (- isix_DiagnoseSortList -).
To decide what number is the address of I6_DictionaryWordToVerbNum: (- isix_DictionaryWordToVerbNum -).
To decide what number is the address of I6_DigitToValue: (- isix_DigitToValue -).
To decide what number is the address of I6_DirectionDoorLeadsIn: (- isix_DirectionDoorLeadsIn -).
To decide what number is the address of I6_DisplayBoxedQuotation: (- isix_DisplayBoxedQuotation -).
To decide what number is the address of I6_DisplayFigure: (- isix_DisplayFigure -).
To decide what number is the address of I6_DistributeBlockConstants: (- isix_DistributeBlockConstants -).
To decide what number is the address of I6_DivideParagraphPoint: (- isix_DivideParagraphPoint -).
To decide what number is the address of I6_DoScopeAction: (- isix_DoScopeAction -).
To decide what number is the address of I6_DoScopeActionAndRecurse: (- isix_DoScopeActionAndRecurse -).
To decide what number is the address of I6_DonotuseRule: (- isix_DonotuseRule -).
To decide what number is the address of I6_DoorFrom: (- isix_DoorFrom -).
To decide what number is the address of I6_DoubleHashSetCheckResize: (- isix_DoubleHashSetCheckResize -).
To decide what number is the address of I6_DoubleHashSetEntryMatches: (- isix_DoubleHashSetEntryMatches -).
To decide what number is the address of I6_DoubleHashSetLookUp: (- isix_DoubleHashSetLookUp -).
To decide what number is the address of I6_DoubleHashSetRelationHandler: (- isix_DoubleHashSetRelationHandle -).
To decide what number is the address of I6_DrawStatusLine: (- isix_DrawStatusLine -).
To decide what number is the address of I6_DuringSceneMatching: (- isix_DuringSceneMatching -).
To decide what number is the address of I6_EmptyRelationHandler: (- isix_EmptyRelationHandler -).
To decide what number is the address of I6_EndActivity: (- isix_EndActivity -).
To decide what number is the address of I6_EndFollowRulebook: (- isix_EndFollowRulebook -).
To decide what number is the address of I6_EnsureBreakBeforePrompt: (- isix_EnsureBreakBeforePrompt -).
To decide what number is the address of I6_EquivHashTableRelationHandler: (- isix_EquivHashTableRelationHandl -).
To decide what number is the address of I6_ExchangeFields: (- isix_ExchangeFields -).
To decide what number is the address of I6_ExistsTableLookUpCorr: (- isix_ExistsTableLookUpCorr -).
To decide what number is the address of I6_ExistsTableLookUpEntry: (- isix_ExistsTableLookUpEntry -).
To decide what number is the address of I6_ExistsTableRowCorr: (- isix_ExistsTableRowCorr -).
To decide what number is the address of I6_FastCountRouteTo: (- isix_FastCountRouteTo -).
To decide what number is the address of I6_FastRouteTo: (- isix_FastRouteTo -).
To decide what number is the address of I6_FastVtoVRelRouteTo: (- isix_FastVtoVRelRouteTo -).
To decide what number is the address of I6_FileIO_Close: (- isix_FileIO_Close -).
To decide what number is the address of I6_FileIO_Error: (- isix_FileIO_Error -).
To decide what number is the address of I6_FileIO_Exists: (- isix_FileIO_Exists -).
To decide what number is the address of I6_FileIO_GetC: (- isix_FileIO_GetC -).
To decide what number is the address of I6_FileIO_GetTable: (- isix_FileIO_GetTable -).
To decide what number is the address of I6_FileIO_MarkReady: (- isix_FileIO_MarkReady -).
To decide what number is the address of I6_FileIO_Open: (- isix_FileIO_Open -).
To decide what number is the address of I6_FileIO_PrintContents: (- isix_FileIO_PrintContents -).
To decide what number is the address of I6_FileIO_PrintLine: (- isix_FileIO_PrintLine -).
To decide what number is the address of I6_FileIO_PutC: (- isix_FileIO_PutC -).
To decide what number is the address of I6_FileIO_PutContents: (- isix_FileIO_PutContents -).
To decide what number is the address of I6_FileIO_PutTable: (- isix_FileIO_PutTable -).
To decide what number is the address of I6_FileIO_Ready: (- isix_FileIO_Ready -).
To decide what number is the address of I6_FindAction: (- isix_FindAction -).
To decide what number is the address of I6_FindVisibilityLevels: (- isix_FindVisibilityLevels -).
To decide what number is the address of I6_FixInhibitFlag: (- isix_FixInhibitFlag -).
To decide what number is the address of I6_FollowRulebook: (- isix_FollowRulebook -).
To decide what number is the address of I6_ForActivity: (- isix_ForActivity -).
To decide what number is the address of I6_ForceTableEntryBlank: (- isix_ForceTableEntryBlank -).
To decide what number is the address of I6_ForceTableEntryNonBlank: (- isix_ForceTableEntryNonBlank -).
To decide what number is the address of I6_FoundEverywhere: (- isix_FoundEverywhere -).
To decide what number is the address of I6_FreeStack: (- isix_FreeStack -).
To decide what number is the address of I6_FrontSideOfDoor: (- isix_FrontSideOfDoor -).
To decide what number is the address of I6_GGRecoverObjects: (- isix_GGRecoverObjects -).
To decide what number is the address of I6_GGWordCompare: (- isix_GGWordCompare -).
To decide what number is the address of I6_GL__M: (- isix_GL__M -).
To decide what number is the address of I6_GProperty: (- isix_GProperty -).
To decide what number is the address of I6_GVS_Convert: (- isix_GVS_Convert -).
To decide what number is the address of I6_GenerateMultipleActions: (- isix_GenerateMultipleActions -).
To decide what number is the address of I6_GenerateRandomNumber: (- isix_GenerateRandomNumber -).
To decide what number is the address of I6_GenericVerbSub: (- isix_GenericVerbSub -).
To decide what number is the address of I6_GetEitherOrProperty: (- isix_GetEitherOrProperty -).
To decide what number is the address of I6_GetGNAOfObject: (- isix_GetGNAOfObject -).
To decide what number is the address of I6_GetGender: (- isix_GetGender -).
To decide what number is the address of I6_GlkListSub: (- isix_GlkListSub -).
To decide what number is the address of I6_Glulx_ChangeAnyToCString: (- isix_Glulx_ChangeAnyToCString -).
To decide what number is the address of I6_Glulx_PrintAnyToArray: (- isix_Glulx_PrintAnyToArray -).
To decide what number is the address of I6_Glulx_PrintAnything: (- isix_Glulx_PrintAnything -).
To decide what number is the address of I6_GoingLookBreak: (- isix_GoingLookBreak -).
To decide what number is the address of I6_GonearSub: (- isix_GonearSub -).
To decide what number is the address of I6_GroupChildren: (- isix_GroupChildren -).
To decide what number is the address of I6_HasLightSource: (- isix_HasLightSource -).
To decide what number is the address of I6_HashCoreCheckResize: (- isix_HashCoreCheckResize -).
To decide what number is the address of I6_HashCoreEntryMatches: (- isix_HashCoreEntryMatches -).
To decide what number is the address of I6_HashCoreLookUp: (- isix_HashCoreLookUp -).
To decide what number is the address of I6_HashCoreRelationHandler: (- isix_HashCoreRelationHandler -).
To decide what number is the address of I6_HashListRelationHandler: (- isix_HashListRelationHandler -).
To decide what number is the address of I6_HashTableRelationHandler: (- isix_HashTableRelationHandler -).
To decide what number is the address of I6_HasorHave: (- isix_HasorHave -).
To decide what number is the address of I6_HeapInitialise: (- isix_HeapInitialise -).
To decide what number is the address of I6_HeapLargestFreeBlock: (- isix_HeapLargestFreeBlock -).
To decide what number is the address of I6_HeapMakeSpace: (- isix_HeapMakeSpace -).
To decide what number is the address of I6_HeapNetFreeSpace: (- isix_HeapNetFreeSpace -).
To decide what number is the address of I6_HidesLightSource: (- isix_HidesLightSource -).
To decide what number is the address of I6_HimHerItself: (- isix_HimHerItself -).
To decide what number is the address of I6_HisHerTheir: (- isix_HisHerTheir -).
To decide what number is the address of I6_HolderOf: (- isix_HolderOf -).
To decide what number is the address of I6_HoursMinsWordToTime: (- isix_HoursMinsWordToTime -).
To decide what number is the address of I6_I7_ExtendedTryNumber: (- isix_I7_ExtendedTryNumber -).
To decide what number is the address of I6_I7_Kind_Name: (- isix_I7_Kind_Name -).
To decide what number is the address of I6_I7_SOO_CYC: (- isix_I7_SOO_CYC -).
To decide what number is the address of I6_I7_SOO_PAR: (- isix_I7_SOO_PAR -).
To decide what number is the address of I6_I7_SOO_RAN: (- isix_I7_SOO_RAN -).
To decide what number is the address of I6_I7_SOO_SHU: (- isix_I7_SOO_SHU -).
To decide what number is the address of I6_I7_SOO_STI: (- isix_I7_SOO_STI -).
To decide what number is the address of I6_I7_SOO_STOP: (- isix_I7_SOO_STOP -).
To decide what number is the address of I6_I7_SOO_TAP: (- isix_I7_SOO_TAP -).
To decide what number is the address of I6_I7_SOO_TPAR: (- isix_I7_SOO_TPAR -).
To decide what number is the address of I6_I7_SOO_TRAN: (- isix_I7_SOO_TRAN -).
To decide what number is the address of I6_I7_String: (- isix_I7_String -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Cast: (- isix_INDEXED_TEXT_TY_Cast -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Compare: (- isix_INDEXED_TEXT_TY_Compare -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Create: (- isix_INDEXED_TEXT_TY_Create -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Distinguish: (- isix_INDEXED_TEXT_TY_Distinguish -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Empty: (- isix_INDEXED_TEXT_TY_Empty -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Hash: (- isix_INDEXED_TEXT_TY_Hash -).
To decide what number is the address of I6_INDEXED_TEXT_TY_ROGPR: (- isix_INDEXED_TEXT_TY_ROGPR -).
To decide what number is the address of I6_INDEXED_TEXT_TY_ReadFile: (- isix_INDEXED_TEXT_TY_ReadFile -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Say: (- isix_INDEXED_TEXT_TY_Say -).
To decide what number is the address of I6_INDEXED_TEXT_TY_Support: (- isix_INDEXED_TEXT_TY_Support -).
To decide what number is the address of I6_INDEXED_TEXT_TY_WriteFile: (- isix_INDEXED_TEXT_TY_WriteFile -).
To decide what number is the address of I6_IPMS_Lower: (- isix_IPMS_Lower -).
To decide what number is the address of I6_IPMS_Merge: (- isix_IPMS_Merge -).
To decide what number is the address of I6_IPMS_Reverse: (- isix_IPMS_Reverse -).
To decide what number is the address of I6_IPMS_Rotate: (- isix_IPMS_Rotate -).
To decide what number is the address of I6_IPMS_Upper: (- isix_IPMS_Upper -).
To decide what number is the address of I6_IT_BlobAccess: (- isix_IT_BlobAccess -).
To decide what number is the address of I6_IT_CHR_CompileTree: (- isix_IT_CHR_CompileTree -).
To decide what number is the address of I6_IT_CharacterLength: (- isix_IT_CharacterLength -).
To decide what number is the address of I6_IT_CharactersOfCase: (- isix_IT_CharactersOfCase -).
To decide what number is the address of I6_IT_CharactersToCase: (- isix_IT_CharactersToCase -).
To decide what number is the address of I6_IT_Concatenate: (- isix_IT_Concatenate -).
To decide what number is the address of I6_IT_GetBlob: (- isix_IT_GetBlob -).
To decide what number is the address of I6_IT_GetCharacter: (- isix_IT_GetCharacter -).
To decide what number is the address of I6_IT_MV_End: (- isix_IT_MV_End -).
To decide what number is the address of I6_IT_RE_CheckTree: (- isix_IT_RE_CheckTree -).
To decide what number is the address of I6_IT_RE_Clear_Markers: (- isix_IT_RE_Clear_Markers -).
To decide what number is the address of I6_IT_RE_CompileTree: (- isix_IT_RE_CompileTree -).
To decide what number is the address of I6_IT_RE_Concatenate: (- isix_IT_RE_Concatenate -).
To decide what number is the address of I6_IT_RE_CreateMatchVars: (- isix_IT_RE_CreateMatchVars -).
To decide what number is the address of I6_IT_RE_DebugMatchVars: (- isix_IT_RE_DebugMatchVars -).
To decide what number is the address of I6_IT_RE_DebugNode: (- isix_IT_RE_DebugNode -).
To decide what number is the address of I6_IT_RE_DebugSubtree: (- isix_IT_RE_DebugSubtree -).
To decide what number is the address of I6_IT_RE_DebugTree: (- isix_IT_RE_DebugTree -).
To decide what number is the address of I6_IT_RE_EmptyMatchVars: (- isix_IT_RE_EmptyMatchVars -).
To decide what number is the address of I6_IT_RE_EraseConstraints: (- isix_IT_RE_EraseConstraints -).
To decide what number is the address of I6_IT_RE_ExpandChoices: (- isix_IT_RE_ExpandChoices -).
To decide what number is the address of I6_IT_RE_FailSubexpressions: (- isix_IT_RE_FailSubexpressions -).
To decide what number is the address of I6_IT_RE_GetMatchVar: (- isix_IT_RE_GetMatchVar -).
To decide what number is the address of I6_IT_RE_MatchSubstring: (- isix_IT_RE_MatchSubstring -).
To decide what number is the address of I6_IT_RE_Node: (- isix_IT_RE_Node -).
To decide what number is the address of I6_IT_RE_NodeAddress: (- isix_IT_RE_NodeAddress -).
To decide what number is the address of I6_IT_RE_Parse: (- isix_IT_RE_Parse -).
To decide what number is the address of I6_IT_RE_ParseAtPosition: (- isix_IT_RE_ParseAtPosition -).
To decide what number is the address of I6_IT_RE_PrintNoRewinds: (- isix_IT_RE_PrintNoRewinds -).
To decide what number is the address of I6_IT_RE_Range: (- isix_IT_RE_Range -).
To decide what number is the address of I6_IT_RE_RangeSyntaxCorrect: (- isix_IT_RE_RangeSyntaxCorrect -).
To decide what number is the address of I6_IT_RE_SeekBacktrack: (- isix_IT_RE_SeekBacktrack -).
To decide what number is the address of I6_IT_RE_SetTrace: (- isix_IT_RE_SetTrace -).
To decide what number is the address of I6_IT_RE_Width: (- isix_IT_RE_Width -).
To decide what number is the address of I6_IT_ReplaceBlob: (- isix_IT_ReplaceBlob -).
To decide what number is the address of I6_IT_ReplaceText: (- isix_IT_ReplaceText -).
To decide what number is the address of I6_IT_Replace_RE: (- isix_IT_Replace_RE -).
To decide what number is the address of I6_IT_RevCase: (- isix_IT_RevCase -).
To decide what number is the address of I6_Identical: (- isix_Identical -).
To decide what number is the address of I6_ImplicitTake: (- isix_ImplicitTake -).
To decide what number is the address of I6_InPlaceMergeSortAlgorithm: (- isix_InPlaceMergeSortAlgorithm -).
To decide what number is the address of I6_IndirectlyContains: (- isix_IndirectlyContains -).
To decide what number is the address of I6_InitialHeapAllocation: (- isix_InitialHeapAllocation -).
To decide what number is the address of I6_InsertionSortAlgorithm: (- isix_InsertionSortAlgorithm -).
To decide what number is the address of I6_IntegerDivide: (- isix_IntegerDivide -).
To decide what number is the address of I6_IntegerRemainder: (- isix_IntegerRemainder -).
To decide what number is the address of I6_InternalTestCases: (- isix_InternalTestCases -).
To decide what number is the address of I6_IsSeeThrough: (- isix_IsSeeThrough -).
To decide what number is the address of I6_IsorAre: (- isix_IsorAre -).
To decide what number is the address of I6_IterateRelations: (- isix_IterateRelations -).
To decide what number is the address of I6_ItorThem: (- isix_ItorThem -).
To decide what number is the address of I6_KOVComparisonFunction: (- isix_KOVComparisonFunction -).
To decide what number is the address of I6_KOVDomainSize: (- isix_KOVDomainSize -).
To decide what number is the address of I6_KOVHashValue: (- isix_KOVHashValue -).
To decide what number is the address of I6_KOVIsBlockValue: (- isix_KOVIsBlockValue -).
To decide what number is the address of I6_KOVSupportFunction: (- isix_KOVSupportFunction -).
To decide what number is the address of I6_Keyboard: (- isix_Keyboard -).
To decide what number is the address of I6_KeyboardPrimitive: (- isix_KeyboardPrimitive -).
To decide what number is the address of I6_KindAtomic: (- isix_KindAtomic -).
To decide what number is the address of I6_KindBaseArity: (- isix_KindBaseArity -).
To decide what number is the address of I6_KindBaseTerm: (- isix_KindBaseTerm -).
To decide what number is the address of I6_LIST_OF_TY_AppendList: (- isix_LIST_OF_TY_AppendList -).
To decide what number is the address of I6_LIST_OF_TY_Compare: (- isix_LIST_OF_TY_Compare -).
To decide what number is the address of I6_LIST_OF_TY_ComparisonFn: (- isix_LIST_OF_TY_ComparisonFn -).
To decide what number is the address of I6_LIST_OF_TY_Copy: (- isix_LIST_OF_TY_Copy -).
To decide what number is the address of I6_LIST_OF_TY_CopyRawArray: (- isix_LIST_OF_TY_CopyRawArray -).
To decide what number is the address of I6_LIST_OF_TY_Create: (- isix_LIST_OF_TY_Create -).
To decide what number is the address of I6_LIST_OF_TY_Desc: (- isix_LIST_OF_TY_Desc -).
To decide what number is the address of I6_LIST_OF_TY_Destroy: (- isix_LIST_OF_TY_Destroy -).
To decide what number is the address of I6_LIST_OF_TY_Distinguish: (- isix_LIST_OF_TY_Distinguish -).
To decide what number is the address of I6_LIST_OF_TY_Empty: (- isix_LIST_OF_TY_Empty -).
To decide what number is the address of I6_LIST_OF_TY_FindItem: (- isix_LIST_OF_TY_FindItem -).
To decide what number is the address of I6_LIST_OF_TY_GetItem: (- isix_LIST_OF_TY_GetItem -).
To decide what number is the address of I6_LIST_OF_TY_GetLength: (- isix_LIST_OF_TY_GetLength -).
To decide what number is the address of I6_LIST_OF_TY_Hash: (- isix_LIST_OF_TY_Hash -).
To decide what number is the address of I6_LIST_OF_TY_InsertItem: (- isix_LIST_OF_TY_InsertItem -).
To decide what number is the address of I6_LIST_OF_TY_Mol: (- isix_LIST_OF_TY_Mol -).
To decide what number is the address of I6_LIST_OF_TY_PreCopy: (- isix_LIST_OF_TY_PreCopy -).
To decide what number is the address of I6_LIST_OF_TY_PutItem: (- isix_LIST_OF_TY_PutItem -).
To decide what number is the address of I6_LIST_OF_TY_RemoveItemRange: (- isix_LIST_OF_TY_RemoveItemRange -).
To decide what number is the address of I6_LIST_OF_TY_RemoveValue: (- isix_LIST_OF_TY_RemoveValue -).
To decide what number is the address of I6_LIST_OF_TY_Remove_List: (- isix_LIST_OF_TY_Remove_List -).
To decide what number is the address of I6_LIST_OF_TY_Reverse: (- isix_LIST_OF_TY_Reverse -).
To decide what number is the address of I6_LIST_OF_TY_Rotate: (- isix_LIST_OF_TY_Rotate -).
To decide what number is the address of I6_LIST_OF_TY_Say: (- isix_LIST_OF_TY_Say -).
To decide what number is the address of I6_LIST_OF_TY_SetLength: (- isix_LIST_OF_TY_SetLength -).
To decide what number is the address of I6_LIST_OF_TY_Set_Mol: (- isix_LIST_OF_TY_Set_Mol -).
To decide what number is the address of I6_LIST_OF_TY_Sort: (- isix_LIST_OF_TY_Sort -).
To decide what number is the address of I6_LIST_OF_TY_Support: (- isix_LIST_OF_TY_Support -).
To decide what number is the address of I6_LTI_Insert: (- isix_LTI_Insert -).
To decide what number is the address of I6_L__M: (- isix_L__M -).
To decide what number is the address of I6_LanguageContraction: (- isix_LanguageContraction -).
To decide what number is the address of I6_LanguageDirection: (- isix_LanguageDirection -).
To decide what number is the address of I6_LanguageLM: (- isix_LanguageLM -).
To decide what number is the address of I6_LanguageNumber: (- isix_LanguageNumber -).
To decide what number is the address of I6_LanguageTimeOfDay: (- isix_LanguageTimeOfDay -).
To decide what number is the address of I6_LanguageToInformese: (- isix_LanguageToInformese -).
To decide what number is the address of I6_LanguageVerb: (- isix_LanguageVerb -).
To decide what number is the address of I6_LanguageVerbLikesAdverb: (- isix_LanguageVerbLikesAdverb -).
To decide what number is the address of I6_LanguageVerbMayBeName: (- isix_LanguageVerbMayBeName -).
To decide what number is the address of I6_ListCompareEntries: (- isix_ListCompareEntries -).
To decide what number is the address of I6_ListEqual: (- isix_ListEqual -).
To decide what number is the address of I6_ListSwapEntries: (- isix_ListSwapEntries -).
To decide what number is the address of I6_LocationOf: (- isix_LocationOf -).
To decide what number is the address of I6_LookAfterGoing: (- isix_LookAfterGoing -).
To decide what number is the address of I6_LookSub: (- isix_LookSub -).
To decide what number is the address of I6_LoopOverScope: (- isix_LoopOverScope -).
To decide what number is the address of I6_MStack_CreateAVVars: (- isix_MStack_CreateAVVars -).
To decide what number is the address of I6_MStack_CreateRBVars: (- isix_MStack_CreateRBVars -).
To decide what number is the address of I6_MStack_DestroyAVVars: (- isix_MStack_DestroyAVVars -).
To decide what number is the address of I6_MStack_DestroyRBVars: (- isix_MStack_DestroyRBVars -).
To decide what number is the address of I6_Main: (- isix_Main -).
To decide what number is the address of I6_MakeColourWord: (- isix_MakeColourWord -).
To decide what number is the address of I6_MakeMatch: (- isix_MakeMatch -).
To decide what number is the address of I6_MakePart: (- isix_MakePart -).
To decide what number is the address of I6_MapConnection: (- isix_MapConnection -).
To decide what number is the address of I6_MapRouteTo: (- isix_MapRouteTo -).
To decide what number is the address of I6_MarkedListCoalesce: (- isix_MarkedListCoalesce -).
To decide what number is the address of I6_MarkedListIterator: (- isix_MarkedListIterator -).
To decide what number is the address of I6_MatchTextAgainstObject: (- isix_MatchTextAgainstObject -).
To decide what number is the address of I6_MistakeActionSub: (- isix_MistakeActionSub -).
To decide what number is the address of I6_MoveBackdrop: (- isix_MoveBackdrop -).
To decide what number is the address of I6_MoveDuringGoing: (- isix_MoveDuringGoing -).
To decide what number is the address of I6_MoveFloatingObjects: (- isix_MoveFloatingObjects -).
To decide what number is the address of I6_MoveObject: (- isix_MoveObject -).
To decide what number is the address of I6_MoveRuleAfter: (- isix_MoveRuleAfter -).
To decide what number is the address of I6_MoveRuleBefore: (- isix_MoveRuleBefore -).
To decide what number is the address of I6_MoveWord: (- isix_MoveWord -).
To decide what number is the address of I6_MstVO: (- isix_MstVO -).
To decide what number is the address of I6_MstVON: (- isix_MstVON -).
To decide what number is the address of I6_Mstack_Backtrace: (- isix_Mstack_Backtrace -).
To decide what number is the address of I6_Mstack_Create_Frame: (- isix_Mstack_Create_Frame -).
To decide what number is the address of I6_Mstack_Destroy_Frame: (- isix_Mstack_Destroy_Frame -).
To decide what number is the address of I6_Mstack_Seek_Frame: (- isix_Mstack_Seek_Frame -).
To decide what number is the address of I6_MultiAdd: (- isix_MultiAdd -).
To decide what number is the address of I6_MultiFilter: (- isix_MultiFilter -).
To decide what number is the address of I6_MultiSub: (- isix_MultiSub -).
To decide what number is the address of I6_NeedLightForAction: (- isix_NeedLightForAction -).
To decide what number is the address of I6_NeedToCarryNoun: (- isix_NeedToCarryNoun -).
To decide what number is the address of I6_NeedToCarrySecondNoun: (- isix_NeedToCarrySecondNoun -).
To decide what number is the address of I6_NeedToTouchNoun: (- isix_NeedToTouchNoun -).
To decide what number is the address of I6_NeedToTouchSecondNoun: (- isix_NeedToTouchSecondNoun -).
To decide what number is the address of I6_NextWord: (- isix_NextWord -).
To decide what number is the address of I6_NextWordStopped: (- isix_NextWordStopped -).
To decide what number is the address of I6_NotifyTheScore: (- isix_NotifyTheScore -).
To decide what number is the address of I6_NounDomain: (- isix_NounDomain -).
To decide what number is the address of I6_NounWord: (- isix_NounWord -).
To decide what number is the address of I6_NumberOfGroupsInList: (- isix_NumberOfGroupsInList -).
To decide what number is the address of I6_NumberWord: (- isix_NumberWord -).
To decide what number is the address of I6_ObjectIsUntouchable: (- isix_ObjectIsUntouchable -).
To decide what number is the address of I6_ObjectTreeCoalesce: (- isix_ObjectTreeCoalesce -).
To decide what number is the address of I6_ObjectTreeIterator: (- isix_ObjectTreeIterator -).
To decide what number is the address of I6_OffersLight: (- isix_OffersLight -).
To decide what number is the address of I6_OhLookItsReal: (- isix_OhLookItsReal -).
To decide what number is the address of I6_OhLookItsRoom: (- isix_OhLookItsRoom -).
To decide what number is the address of I6_OhLookItsThing: (- isix_OhLookItsThing -).
To decide what number is the address of I6_OldSortAlgorithm: (- isix_OldSortAlgorithm -).
To decide what number is the address of I6_OnStage: (- isix_OnStage -).
To decide what number is the address of I6_OtherSideOfDoor: (- isix_OtherSideOfDoor -).
To decide what number is the address of I6_OtoVRelRouteTo: (- isix_OtoVRelRouteTo -).
To decide what number is the address of I6_OwnerOf: (- isix_OwnerOf -).
To decide what number is the address of I6_PROPERTY_TY_Say: (- isix_PROPERTY_TY_Say -).
To decide what number is the address of I6_PSN__: (- isix_PSN__ -).
To decide what number is the address of I6_ParaContent: (- isix_ParaContent -).
To decide what number is the address of I6_ParentOf: (- isix_ParentOf -).
To decide what number is the address of I6_ParseToken: (- isix_ParseToken -).
To decide what number is the address of I6_ParseTokenStopped: (- isix_ParseTokenStopped -).
To decide what number is the address of I6_ParseToken__: (- isix_ParseToken__ -).
To decide what number is the address of I6_ParserError: (- isix_ParserError -).
To decide what number is the address of I6_Parser__parse: (- isix_Parser__parse -).
To decide what number is the address of I6_PartitionList: (- isix_PartitionList -).
To decide what number is the address of I6_Perform_Undo: (- isix_Perform_Undo -).
To decide what number is the address of I6_PlaceInScope: (- isix_PlaceInScope -).
To decide what number is the address of I6_PlaySound: (- isix_PlaySound -).
To decide what number is the address of I6_PlayerTo: (- isix_PlayerTo -).
To decide what number is the address of I6_PredictableSub: (- isix_PredictableSub -).
To decide what number is the address of I6_PrefaceByArticle: (- isix_PrefaceByArticle -).
To decide what number is the address of I6_PrepositionChain: (- isix_PrepositionChain -).
To decide what number is the address of I6_PrintCommand: (- isix_PrintCommand -).
To decide what number is the address of I6_PrintInferredCommand: (- isix_PrintInferredCommand -).
To decide what number is the address of I6_PrintKindValuePair: (- isix_PrintKindValuePair -).
To decide what number is the address of I6_PrintOrRun: (- isix_PrintOrRun -).
To decide what number is the address of I6_PrintPrompt: (- isix_PrintPrompt -).
To decide what number is the address of I6_PrintPropertyName: (- isix_PrintPropertyName -).
To decide what number is the address of I6_PrintRank: (- isix_PrintRank -).
To decide what number is the address of I6_PrintSceneName: (- isix_PrintSceneName -).
To decide what number is the address of I6_PrintSingleParagraph: (- isix_PrintSingleParagraph -).
To decide what number is the address of I6_PrintSnippet: (- isix_PrintSnippet -).
To decide what number is the address of I6_PrintSpaces: (- isix_PrintSpaces -).
To decide what number is the address of I6_PrintTableName: (- isix_PrintTableName -).
To decide what number is the address of I6_PrintText: (- isix_PrintText -).
To decide what number is the address of I6_PrintTimeOfDay: (- isix_PrintTimeOfDay -).
To decide what number is the address of I6_PrintTimeOfDayEnglish: (- isix_PrintTimeOfDayEnglish -).
To decide what number is the address of I6_PrintUseOption: (- isix_PrintUseOption -).
To decide what number is the address of I6_PrintVerb: (- isix_PrintVerb -).
To decide what number is the address of I6_Print_ScL: (- isix_Print_ScL -).
To decide what number is the address of I6_ProcessActivityRulebook: (- isix_ProcessActivityRulebook -).
To decide what number is the address of I6_ProcessRulebook: (- isix_ProcessRulebook -).
To decide what number is the address of I6_PronounNotice: (- isix_PronounNotice -).
To decide what number is the address of I6_PronounNoticeHeldObjects: (- isix_PronounNoticeHeldObjects -).
To decide what number is the address of I6_PronounValue: (- isix_PronounValue -).
To decide what number is the address of I6_Prop_Falsity: (- isix_Prop_Falsity -).
To decide what number is the address of I6_PushRuleChange: (- isix_PushRuleChange -).
To decide what number is the address of I6_RELATION_TY_Compare: (- isix_RELATION_TY_Compare -).
To decide what number is the address of I6_RELATION_TY_Copy: (- isix_RELATION_TY_Copy -).
To decide what number is the address of I6_RELATION_TY_Create: (- isix_RELATION_TY_Create -).
To decide what number is the address of I6_RELATION_TY_Destroy: (- isix_RELATION_TY_Destroy -).
To decide what number is the address of I6_RELATION_TY_Distinguish: (- isix_RELATION_TY_Distinguish -).
To decide what number is the address of I6_RELATION_TY_Empty: (- isix_RELATION_TY_Empty -).
To decide what number is the address of I6_RELATION_TY_EquivalenceAdjective: (- isix_RELATION_TY_EquivalenceAdje -).
To decide what number is the address of I6_RELATION_TY_GetValency: (- isix_RELATION_TY_GetValency -).
To decide what number is the address of I6_RELATION_TY_Name: (- isix_RELATION_TY_Name -).
To decide what number is the address of I6_RELATION_TY_OToOAdjective: (- isix_RELATION_TY_OToOAdjective -).
To decide what number is the address of I6_RELATION_TY_OToVAdjective: (- isix_RELATION_TY_OToVAdjective -).
To decide what number is the address of I6_RELATION_TY_Say: (- isix_RELATION_TY_Say -).
To decide what number is the address of I6_RELATION_TY_SetValency: (- isix_RELATION_TY_SetValency -).
To decide what number is the address of I6_RELATION_TY_Support: (- isix_RELATION_TY_Support -).
To decide what number is the address of I6_RELATION_TY_SymmetricAdjective: (- isix_RELATION_TY_SymmetricAdject -).
To decide what number is the address of I6_RELATION_TY_VToOAdjective: (- isix_RELATION_TY_VToOAdjective -).
To decide what number is the address of I6_RELATION_TY_VToVAdjective: (- isix_RELATION_TY_VToVAdjective -).
To decide what number is the address of I6_RELATIVE_TIME_TOKEN: (- isix_RELATIVE_TIME_TOKEN -).
To decide what number is the address of I6_RSE_Flip: (- isix_RSE_Flip -).
To decide what number is the address of I6_RSE_Set: (- isix_RSE_Set -).
To decide what number is the address of I6_Refers: (- isix_Refers -).
To decide what number is the address of I6_ReinstateRule: (- isix_ReinstateRule -).
To decide what number is the address of I6_RelFollowVector: (- isix_RelFollowVector -).
To decide what number is the address of I6_RelationRouteTo: (- isix_RelationRouteTo -).
To decide what number is the address of I6_RelationTest: (- isix_RelationTest -).
To decide what number is the address of I6_Relation_Now1to1: (- isix_Relation_Now1to1 -).
To decide what number is the address of I6_Relation_Now1to1V: (- isix_Relation_Now1to1V -).
To decide what number is the address of I6_Relation_NowEquiv: (- isix_Relation_NowEquiv -).
To decide what number is the address of I6_Relation_NowEquivV: (- isix_Relation_NowEquivV -).
To decide what number is the address of I6_Relation_NowN1toV: (- isix_Relation_NowN1toV -).
To decide what number is the address of I6_Relation_NowN1toVV: (- isix_Relation_NowN1toVV -).
To decide what number is the address of I6_Relation_NowNEquiv: (- isix_Relation_NowNEquiv -).
To decide what number is the address of I6_Relation_NowNEquivV: (- isix_Relation_NowNEquivV -).
To decide what number is the address of I6_Relation_NowNVtoV: (- isix_Relation_NowNVtoV -).
To decide what number is the address of I6_Relation_NowS1to1: (- isix_Relation_NowS1to1 -).
To decide what number is the address of I6_Relation_NowS1to1V: (- isix_Relation_NowS1to1V -).
To decide what number is the address of I6_Relation_NowSN1to1: (- isix_Relation_NowSN1to1 -).
To decide what number is the address of I6_Relation_NowSN1to1V: (- isix_Relation_NowSN1to1V -).
To decide what number is the address of I6_Relation_NowVtoV: (- isix_Relation_NowVtoV -).
To decide what number is the address of I6_Relation_RShowOtoO: (- isix_Relation_RShowOtoO -).
To decide what number is the address of I6_Relation_ShowEquiv: (- isix_Relation_ShowEquiv -).
To decide what number is the address of I6_Relation_ShowOtoO: (- isix_Relation_ShowOtoO -).
To decide what number is the address of I6_Relation_ShowVtoV: (- isix_Relation_ShowVtoV -).
To decide what number is the address of I6_Relation_TestVtoV: (- isix_Relation_TestVtoV -).
To decide what number is the address of I6_RemoveFromPlay: (- isix_RemoveFromPlay -).
To decide what number is the address of I6_RequisitionStack: (- isix_RequisitionStack -).
To decide what number is the address of I6_ResetDescriptors: (- isix_ResetDescriptors -).
To decide what number is the address of I6_ResetVagueWords: (- isix_ResetVagueWords -).
To decide what number is the address of I6_ResultOfRule: (- isix_ResultOfRule -).
To decide what number is the address of I6_ReversedHashTableRelationHandler: (- isix_ReversedHashTableRelationHa -).
To decide what number is the address of I6_ReviseMulti: (- isix_ReviseMulti -).
To decide what number is the address of I6_RoomOrDoorFrom: (- isix_RoomOrDoorFrom -).
To decide what number is the address of I6_RoundOffTime: (- isix_RoundOffTime -).
To decide what number is the address of I6_RuleHasNoOutcome: (- isix_RuleHasNoOutcome -).
To decide what number is the address of I6_RulePrintingRule: (- isix_RulePrintingRule -).
To decide what number is the address of I6_RulebookEmpty: (- isix_RulebookEmpty -).
To decide what number is the address of I6_RulebookFailed: (- isix_RulebookFailed -).
To decide what number is the address of I6_RulebookFails: (- isix_RulebookFails -).
To decide what number is the address of I6_RulebookOutcome: (- isix_RulebookOutcome -).
To decide what number is the address of I6_RulebookOutcomePrintingRule: (- isix_RulebookOutcomePrintingRule -).
To decide what number is the address of I6_RulebookSucceeded: (- isix_RulebookSucceeded -).
To decide what number is the address of I6_RulebookSucceeds: (- isix_RulebookSucceeds -).
To decide what number is the address of I6_RulesAllSub: (- isix_RulesAllSub -).
To decide what number is the address of I6_RulesOffSub: (- isix_RulesOffSub -).
To decide what number is the address of I6_RulesOnSub: (- isix_RulesOnSub -).
To decide what number is the address of I6_RunParagraphOn: (- isix_RunParagraphOn -).
To decide what number is the address of I6_RunRoutines: (- isix_RunRoutines -).
To decide what number is the address of I6_RunTimeError: (- isix_RunTimeError -).
To decide what number is the address of I6_RunTimeProblem: (- isix_RunTimeProblem -).
To decide what number is the address of I6_SL_Location: (- isix_SL_Location -).
To decide what number is the address of I6_SL_Score_Moves: (- isix_SL_Score_Moves -).
To decide what number is the address of I6_STORED_ACTION_TY_Adopt: (- isix_STORED_ACTION_TY_Adopt -).
To decide what number is the address of I6_STORED_ACTION_TY_Compare: (- isix_STORED_ACTION_TY_Compare -).
To decide what number is the address of I6_STORED_ACTION_TY_Copy: (- isix_STORED_ACTION_TY_Copy -).
To decide what number is the address of I6_STORED_ACTION_TY_Create: (- isix_STORED_ACTION_TY_Create -).
To decide what number is the address of I6_STORED_ACTION_TY_Current: (- isix_STORED_ACTION_TY_Current -).
To decide what number is the address of I6_STORED_ACTION_TY_Destroy: (- isix_STORED_ACTION_TY_Destroy -).
To decide what number is the address of I6_STORED_ACTION_TY_Distinguish: (- isix_STORED_ACTION_TY_Distinguis -).
To decide what number is the address of I6_STORED_ACTION_TY_Hash: (- isix_STORED_ACTION_TY_Hash -).
To decide what number is the address of I6_STORED_ACTION_TY_Involves: (- isix_STORED_ACTION_TY_Involves -).
To decide what number is the address of I6_STORED_ACTION_TY_New: (- isix_STORED_ACTION_TY_New -).
To decide what number is the address of I6_STORED_ACTION_TY_Part: (- isix_STORED_ACTION_TY_Part -).
To decide what number is the address of I6_STORED_ACTION_TY_Say: (- isix_STORED_ACTION_TY_Say -).
To decide what number is the address of I6_STORED_ACTION_TY_Support: (- isix_STORED_ACTION_TY_Support -).
To decide what number is the address of I6_STORED_ACTION_TY_Try: (- isix_STORED_ACTION_TY_Try -).
To decide what number is the address of I6_STORED_ACTION_TY_Unadopt: (- isix_STORED_ACTION_TY_Unadopt -).
To decide what number is the address of I6_STextSubstitution: (- isix_STextSubstitution -).
To decide what number is the address of I6_SafeSkipDescriptors: (- isix_SafeSkipDescriptors -).
To decide what number is the address of I6_SayActionName: (- isix_SayActionName -).
To decide what number is the address of I6_SayPhraseName: (- isix_SayPhraseName -).
To decide what number is the address of I6_ScanPropertyMetadata: (- isix_ScanPropertyMetadata -).
To decide what number is the address of I6_SceneUtility: (- isix_SceneUtility -).
To decide what number is the address of I6_ScenesOffSub: (- isix_ScenesOffSub -).
To decide what number is the address of I6_ScenesOnSub: (- isix_ScenesOnSub -).
To decide what number is the address of I6_ScopeCeiling: (- isix_ScopeCeiling -).
To decide what number is the address of I6_ScopeSub: (- isix_ScopeSub -).
To decide what number is the address of I6_ScopeWithin: (- isix_ScopeWithin -).
To decide what number is the address of I6_ScoreDabCombo: (- isix_ScoreDabCombo -).
To decide what number is the address of I6_ScoreMatchL: (- isix_ScoreMatchL -).
To decide what number is the address of I6_SearchScope: (- isix_SearchScope -).
To decide what number is the address of I6_SetActionBitmap: (- isix_SetActionBitmap -).
To decide what number is the address of I6_SetEitherOrProperty: (- isix_SetEitherOrProperty -).
To decide what number is the address of I6_SetPlayersCommand: (- isix_SetPlayersCommand -).
To decide what number is the address of I6_SetPronoun: (- isix_SetPronoun -).
To decide what number is the address of I6_SetRulebookOutcome: (- isix_SetRulebookOutcome -).
To decide what number is the address of I6_SetSortDomain: (- isix_SetSortDomain -).
To decide what number is the address of I6_SetTime: (- isix_SetTime -).
To decide what number is the address of I6_SetTimedEvent: (- isix_SetTimedEvent -).
To decide what number is the address of I6_ShowExtensionVersions: (- isix_ShowExtensionVersions -).
To decide what number is the address of I6_ShowFullExtensionVersions: (- isix_ShowFullExtensionVersions -).
To decide what number is the address of I6_ShowHeapSub: (- isix_ShowHeapSub -).
To decide what number is the address of I6_ShowMeRecursively: (- isix_ShowMeRecursively -).
To decide what number is the address of I6_ShowMeSub: (- isix_ShowMeSub -).
To decide what number is the address of I6_ShowOneRelation: (- isix_ShowOneRelation -).
To decide what number is the address of I6_ShowRLocation: (- isix_ShowRLocation -).
To decide what number is the address of I6_ShowRelationsSub: (- isix_ShowRelationsSub -).
To decide what number is the address of I6_ShowSceneStatus: (- isix_ShowSceneStatus -).
To decide what number is the address of I6_ShowVerbSub: (- isix_ShowVerbSub -).
To decide what number is the address of I6_SignalMapChange: (- isix_SignalMapChange -).
To decide what number is the address of I6_SilentlyConsiderLight: (- isix_SilentlyConsiderLight -).
To decide what number is the address of I6_SingleBestGuess: (- isix_SingleBestGuess -).
To decide what number is the address of I6_SlowCountRouteTo: (- isix_SlowCountRouteTo -).
To decide what number is the address of I6_SlowRouteTo: (- isix_SlowRouteTo -).
To decide what number is the address of I6_SnippetIncludes: (- isix_SnippetIncludes -).
To decide what number is the address of I6_SnippetMatches: (- isix_SnippetMatches -).
To decide what number is the address of I6_SortArray: (- isix_SortArray -).
To decide what number is the address of I6_SortRange: (- isix_SortRange -).
To decide what number is the address of I6_SpecialLookSpacingBreak: (- isix_SpecialLookSpacingBreak -).
To decide what number is the address of I6_SpliceSnippet: (- isix_SpliceSnippet -).
To decide what number is the address of I6_SpliceSnippet__TextPrinter: (- isix_SpliceSnippet__TextPrinter -).
To decide what number is the address of I6_SquareRoot: (- isix_SquareRoot -).
To decide what number is the address of I6_SubstituteRule: (- isix_SubstituteRule -).
To decide what number is the address of I6_SupporterOf: (- isix_SupporterOf -).
To decide what number is the address of I6_SuppressRule: (- isix_SuppressRule -).
To decide what number is the address of I6_SwapWorkflags: (- isix_SwapWorkflags -).
To decide what number is the address of I6_Sym2in1HashTableRelationHandler: (- isix_Sym2in1HashTableRelationHan -).
To decide what number is the address of I6_SymDoubleHashSetRelationHandler: (- isix_SymDoubleHashSetRelationHan -).
To decide what number is the address of I6_SymHashListRelationHandler: (- isix_SymHashListRelationHandler -).
To decide what number is the address of I6_TC_KOV: (- isix_TC_KOV -).
To decide what number is the address of I6_TIME_TOKEN: (- isix_TIME_TOKEN -).
To decide what number is the address of I6_TRUTH_STATE_TOKEN: (- isix_TRUTH_STATE_TOKEN -).
To decide what number is the address of I6_TableBlankOutAll: (- isix_TableBlankOutAll -).
To decide what number is the address of I6_TableBlankOutColumn: (- isix_TableBlankOutColumn -).
To decide what number is the address of I6_TableBlankOutRow: (- isix_TableBlankOutRow -).
To decide what number is the address of I6_TableBlankRow: (- isix_TableBlankRow -).
To decide what number is the address of I6_TableBlankRows: (- isix_TableBlankRows -).
To decide what number is the address of I6_TableColumnDebug: (- isix_TableColumnDebug -).
To decide what number is the address of I6_TableCompareRows: (- isix_TableCompareRows -).
To decide what number is the address of I6_TableFilledRows: (- isix_TableFilledRows -).
To decide what number is the address of I6_TableFindCol: (- isix_TableFindCol -).
To decide what number is the address of I6_TableLookUpCorr: (- isix_TableLookUpCorr -).
To decide what number is the address of I6_TableLookUpEntry: (- isix_TableLookUpEntry -).
To decide what number is the address of I6_TableMoveBlankBitsDown: (- isix_TableMoveBlankBitsDown -).
To decide what number is the address of I6_TableMoveBlanksToBack: (- isix_TableMoveBlanksToBack -).
To decide what number is the address of I6_TableMoveRowDown: (- isix_TableMoveRowDown -).
To decide what number is the address of I6_TableNextRow: (- isix_TableNextRow -).
To decide what number is the address of I6_TablePrint: (- isix_TablePrint -).
To decide what number is the address of I6_TableRandomRow: (- isix_TableRandomRow -).
To decide what number is the address of I6_TableRead: (- isix_TableRead -).
To decide what number is the address of I6_TableRowCorr: (- isix_TableRowCorr -).
To decide what number is the address of I6_TableRowIsBlank: (- isix_TableRowIsBlank -).
To decide what number is the address of I6_TableRows: (- isix_TableRows -).
To decide what number is the address of I6_TableShuffle: (- isix_TableShuffle -).
To decide what number is the address of I6_TableSort: (- isix_TableSort -).
To decide what number is the address of I6_TableSwapBlankBits: (- isix_TableSwapBlankBits -).
To decide what number is the address of I6_TableSwapRows: (- isix_TableSwapRows -).
To decide what number is the address of I6_TestActionBitmap: (- isix_TestActionBitmap -).
To decide what number is the address of I6_TestActionMask: (- isix_TestActionMask -).
To decide what number is the address of I6_TestActivity: (- isix_TestActivity -).
To decide what number is the address of I6_TestAdjacency: (- isix_TestAdjacency -).
To decide what number is the address of I6_TestConcealment: (- isix_TestConcealment -).
To decide what number is the address of I6_TestContainmentRange: (- isix_TestContainmentRange -).
To decide what number is the address of I6_TestKeyboardPrimitive: (- isix_TestKeyboardPrimitive -).
To decide what number is the address of I6_TestRegionalContainment: (- isix_TestRegionalContainment -).
To decide what number is the address of I6_TestScope: (- isix_TestScope -).
To decide what number is the address of I6_TestScriptSub: (- isix_TestScriptSub -).
To decide what number is the address of I6_TestSinglePastState: (- isix_TestSinglePastState -).
To decide what number is the address of I6_TestStart: (- isix_TestStart -).
To decide what number is the address of I6_TestTouchability: (- isix_TestTouchability -).
To decide what number is the address of I6_TestUseOption: (- isix_TestUseOption -).
To decide what number is the address of I6_TestVisibility: (- isix_TestVisibility -).
To decide what number is the address of I6_ThatorThose: (- isix_ThatorThose -).
To decide what number is the address of I6_TraceLevelSub: (- isix_TraceLevelSub -).
To decide what number is the address of I6_TraceOffSub: (- isix_TraceOffSub -).
To decide what number is the address of I6_TraceOnSub: (- isix_TraceOnSub -).
To decide what number is the address of I6_TrackActions: (- isix_TrackActions -).
To decide what number is the address of I6_TreatParserResults: (- isix_TreatParserResults -).
To decide what number is the address of I6_TryAction: (- isix_TryAction -).
To decide what number is the address of I6_TryGivenObject: (- isix_TryGivenObject -).
To decide what number is the address of I6_TryNumber: (- isix_TryNumber -).
To decide what number is the address of I6_TwoInOneCheckResize: (- isix_TwoInOneCheckResize -).
To decide what number is the address of I6_TwoInOneDelete: (- isix_TwoInOneDelete -).
To decide what number is the address of I6_TwoInOneEntryMatches: (- isix_TwoInOneEntryMatches -).
To decide what number is the address of I6_TwoInOneHashTableRelationHandler: (- isix_TwoInOneHashTableRelationHa -).
To decide what number is the address of I6_TwoInOneLookUp: (- isix_TwoInOneLookUp -).
To decide what number is the address of I6_UnknownVerb: (- isix_UnknownVerb -).
To decide what number is the address of I6_UnpackGrammarLine: (- isix_UnpackGrammarLine -).
To decide what number is the address of I6_UnsignedCompare: (- isix_UnsignedCompare -).
To decide what number is the address of I6_UpdateActionBitmap: (- isix_UpdateActionBitmap -).
To decide what number is the address of I6_UseRule: (- isix_UseRule -).
To decide what number is the address of I6_VM_AllocateMemory: (- isix_VM_AllocateMemory -).
To decide what number is the address of I6_VM_ClearScreen: (- isix_VM_ClearScreen -).
To decide what number is the address of I6_VM_CommandTableAddress: (- isix_VM_CommandTableAddress -).
To decide what number is the address of I6_VM_CopyBuffer: (- isix_VM_CopyBuffer -).
To decide what number is the address of I6_VM_Describe_Release: (- isix_VM_Describe_Release -).
To decide what number is the address of I6_VM_DictionaryAddressToNumber: (- isix_VM_DictionaryAddressToNumbe -).
To decide what number is the address of I6_VM_FreeMemory: (- isix_VM_FreeMemory -).
To decide what number is the address of I6_VM_Initialise: (- isix_VM_Initialise -).
To decide what number is the address of I6_VM_InvalidDictionaryAddress: (- isix_VM_InvalidDictionaryAddress -).
To decide what number is the address of I6_VM_KeyChar: (- isix_VM_KeyChar -).
To decide what number is the address of I6_VM_KeyDelay: (- isix_VM_KeyDelay -).
To decide what number is the address of I6_VM_KeyDelay_Interrupt: (- isix_VM_KeyDelay_Interrupt -).
To decide what number is the address of I6_VM_LowerToUpperCase: (- isix_VM_LowerToUpperCase -).
To decide what number is the address of I6_VM_MainWindow: (- isix_VM_MainWindow -).
To decide what number is the address of I6_VM_MoveCursorInStatusLine: (- isix_VM_MoveCursorInStatusLine -).
To decide what number is the address of I6_VM_NumberToDictionaryAddress: (- isix_VM_NumberToDictionaryAddres -).
To decide what number is the address of I6_VM_Picture: (- isix_VM_Picture -).
To decide what number is the address of I6_VM_PreInitialise: (- isix_VM_PreInitialise -).
To decide what number is the address of I6_VM_PrintCommandWords: (- isix_VM_PrintCommandWords -).
To decide what number is the address of I6_VM_PrintToBuffer: (- isix_VM_PrintToBuffer -).
To decide what number is the address of I6_VM_ReadKeyboard: (- isix_VM_ReadKeyboard -).
To decide what number is the address of I6_VM_RestoreWindowColours: (- isix_VM_RestoreWindowColours -).
To decide what number is the address of I6_VM_Save_Undo: (- isix_VM_Save_Undo -).
To decide what number is the address of I6_VM_ScreenHeight: (- isix_VM_ScreenHeight -).
To decide what number is the address of I6_VM_ScreenWidth: (- isix_VM_ScreenWidth -).
To decide what number is the address of I6_VM_Seed_RNG: (- isix_VM_Seed_RNG -).
To decide what number is the address of I6_VM_SetWindowColours: (- isix_VM_SetWindowColours -).
To decide what number is the address of I6_VM_SoundEffect: (- isix_VM_SoundEffect -).
To decide what number is the address of I6_VM_StatusLineHeight: (- isix_VM_StatusLineHeight -).
To decide what number is the address of I6_VM_Style: (- isix_VM_Style -).
To decide what number is the address of I6_VM_Tokenise: (- isix_VM_Tokenise -).
To decide what number is the address of I6_VM_Undo: (- isix_VM_Undo -).
To decide what number is the address of I6_VM_UpperToLowerCase: (- isix_VM_UpperToLowerCase -).
To decide what number is the address of I6_VisibilityParent: (- isix_VisibilityParent -).
To decide what number is the address of I6_VtoORelRouteTo: (- isix_VtoORelRouteTo -).
To decide what number is the address of I6_VtoVRelRouteTo: (- isix_VtoVRelRouteTo -).
To decide what number is the address of I6_WearObject: (- isix_WearObject -).
To decide what number is the address of I6_WearerOf: (- isix_WearerOf -).
To decide what number is the address of I6_WhetherIn: (- isix_WhetherIn -).
To decide what number is the address of I6_WhetherProvides: (- isix_WhetherProvides -).
To decide what number is the address of I6_WillRecurs: (- isix_WillRecurs -).
To decide what number is the address of I6_WordAddress: (- isix_WordAddress -).
To decide what number is the address of I6_WordCount: (- isix_WordCount -).
To decide what number is the address of I6_WordFrom: (- isix_WordFrom -).
To decide what number is the address of I6_WordInProperty: (- isix_WordInProperty -).
To decide what number is the address of I6_WordLength: (- isix_WordLength -).
To decide what number is the address of I6_WriteAfterEntry: (- isix_WriteAfterEntry -).
To decide what number is the address of I6_WriteGProperty: (- isix_WriteGProperty -).
To decide what number is the address of I6_WriteLIST_OF_TY_GetItem: (- isix_WriteLIST_OF_TY_GetItem -).
To decide what number is the address of I6_WriteListFrom: (- isix_WriteListFrom -).
To decide what number is the address of I6_WriteListOfMarkedObjects: (- isix_WriteListOfMarkedObjects -).
To decide what number is the address of I6_WriteListR: (- isix_WriteListR -).
To decide what number is the address of I6_WriteMultiClassGroup: (- isix_WriteMultiClassGroup -).
To decide what number is the address of I6_WriteSingleClassGroup: (- isix_WriteSingleClassGroup -).
To decide what number is the address of I6_XAbstractSub: (- isix_XAbstractSub -).
To decide what number is the address of I6_XObj: (- isix_XObj -).
To decide what number is the address of I6_XPurloinSub: (- isix_XPurloinSub -).
To decide what number is the address of I6_XTestMove: (- isix_XTestMove -).
To decide what number is the address of I6_XTreeSub: (- isix_XTreeSub -).
To decide what number is the address of I6_YesOrNo: (- isix_YesOrNo -).
To decide what number is the address of I6_Z6_DrawStatusLine: (- isix_Z6_DrawStatusLine -).
To decide what number is the address of I6_Z6_MoveCursor: (- isix_Z6_MoveCursor -).
To decide what number is the address of I6_ZRegion: (- isix_ZRegion -).
To decide what number is the address of I6_glk_buffer_to_lower_case_uni: (- isix_glk_buffer_to_lower_case_un -).
To decide what number is the address of I6_glk_buffer_to_title_case_uni: (- isix_glk_buffer_to_title_case_un -).
To decide what number is the address of I6_glk_buffer_to_upper_case_uni: (- isix_glk_buffer_to_upper_case_un -).
To decide what number is the address of I6_glk_cancel_char_event: (- isix_glk_cancel_char_event -).
To decide what number is the address of I6_glk_cancel_hyperlink_event: (- isix_glk_cancel_hyperlink_event -).
To decide what number is the address of I6_glk_cancel_line_event: (- isix_glk_cancel_line_event -).
To decide what number is the address of I6_glk_cancel_mouse_event: (- isix_glk_cancel_mouse_event -).
To decide what number is the address of I6_glk_char_to_lower: (- isix_glk_char_to_lower -).
To decide what number is the address of I6_glk_char_to_upper: (- isix_glk_char_to_upper -).
To decide what number is the address of I6_glk_exit: (- isix_glk_exit -).
To decide what number is the address of I6_glk_fileref_create_by_name: (- isix_glk_fileref_create_by_name -).
To decide what number is the address of I6_glk_fileref_create_by_prompt: (- isix_glk_fileref_create_by_promp -).
To decide what number is the address of I6_glk_fileref_create_from_fileref: (- isix_glk_fileref_create_from_fil -).
To decide what number is the address of I6_glk_fileref_create_temp: (- isix_glk_fileref_create_temp -).
To decide what number is the address of I6_glk_fileref_delete_file: (- isix_glk_fileref_delete_file -).
To decide what number is the address of I6_glk_fileref_destroy: (- isix_glk_fileref_destroy -).
To decide what number is the address of I6_glk_fileref_does_file_exist: (- isix_glk_fileref_does_file_exist -).
To decide what number is the address of I6_glk_fileref_get_rock: (- isix_glk_fileref_get_rock -).
To decide what number is the address of I6_glk_fileref_iterate: (- isix_glk_fileref_iterate -).
To decide what number is the address of I6_glk_gestalt: (- isix_glk_gestalt -).
To decide what number is the address of I6_glk_gestalt_ext: (- isix_glk_gestalt_ext -).
To decide what number is the address of I6_glk_get_buffer_stream: (- isix_glk_get_buffer_stream -).
To decide what number is the address of I6_glk_get_buffer_stream_uni: (- isix_glk_get_buffer_stream_uni -).
To decide what number is the address of I6_glk_get_char_stream: (- isix_glk_get_char_stream -).
To decide what number is the address of I6_glk_get_char_stream_uni: (- isix_glk_get_char_stream_uni -).
To decide what number is the address of I6_glk_get_line_stream: (- isix_glk_get_line_stream -).
To decide what number is the address of I6_glk_get_line_stream_uni: (- isix_glk_get_line_stream_uni -).
To decide what number is the address of I6_glk_image_draw: (- isix_glk_image_draw -).
To decide what number is the address of I6_glk_image_draw_scaled: (- isix_glk_image_draw_scaled -).
To decide what number is the address of I6_glk_image_get_info: (- isix_glk_image_get_info -).
To decide what number is the address of I6_glk_put_buffer: (- isix_glk_put_buffer -).
To decide what number is the address of I6_glk_put_buffer_stream: (- isix_glk_put_buffer_stream -).
To decide what number is the address of I6_glk_put_buffer_stream_uni: (- isix_glk_put_buffer_stream_uni -).
To decide what number is the address of I6_glk_put_buffer_uni: (- isix_glk_put_buffer_uni -).
To decide what number is the address of I6_glk_put_char: (- isix_glk_put_char -).
To decide what number is the address of I6_glk_put_char_stream: (- isix_glk_put_char_stream -).
To decide what number is the address of I6_glk_put_char_stream_uni: (- isix_glk_put_char_stream_uni -).
To decide what number is the address of I6_glk_put_char_uni: (- isix_glk_put_char_uni -).
To decide what number is the address of I6_glk_put_string: (- isix_glk_put_string -).
To decide what number is the address of I6_glk_put_string_stream: (- isix_glk_put_string_stream -).
To decide what number is the address of I6_glk_put_string_stream_uni: (- isix_glk_put_string_stream_uni -).
To decide what number is the address of I6_glk_put_string_uni: (- isix_glk_put_string_uni -).
To decide what number is the address of I6_glk_request_char_event: (- isix_glk_request_char_event -).
To decide what number is the address of I6_glk_request_char_event_uni: (- isix_glk_request_char_event_uni -).
To decide what number is the address of I6_glk_request_hyperlink_event: (- isix_glk_request_hyperlink_event -).
To decide what number is the address of I6_glk_request_line_event: (- isix_glk_request_line_event -).
To decide what number is the address of I6_glk_request_line_event_uni: (- isix_glk_request_line_event_uni -).
To decide what number is the address of I6_glk_request_mouse_event: (- isix_glk_request_mouse_event -).
To decide what number is the address of I6_glk_request_timer_events: (- isix_glk_request_timer_events -).
To decide what number is the address of I6_glk_schannel_create: (- isix_glk_schannel_create -).
To decide what number is the address of I6_glk_schannel_destroy: (- isix_glk_schannel_destroy -).
To decide what number is the address of I6_glk_schannel_get_rock: (- isix_glk_schannel_get_rock -).
To decide what number is the address of I6_glk_schannel_iterate: (- isix_glk_schannel_iterate -).
To decide what number is the address of I6_glk_schannel_play: (- isix_glk_schannel_play -).
To decide what number is the address of I6_glk_schannel_play_ext: (- isix_glk_schannel_play_ext -).
To decide what number is the address of I6_glk_schannel_set_volume: (- isix_glk_schannel_set_volume -).
To decide what number is the address of I6_glk_schannel_stop: (- isix_glk_schannel_stop -).
To decide what number is the address of I6_glk_select: (- isix_glk_select -).
To decide what number is the address of I6_glk_select_poll: (- isix_glk_select_poll -).
To decide what number is the address of I6_glk_set_hyperlink: (- isix_glk_set_hyperlink -).
To decide what number is the address of I6_glk_set_hyperlink_stream: (- isix_glk_set_hyperlink_stream -).
To decide what number is the address of I6_glk_set_interrupt_handler: (- isix_glk_set_interrupt_handler -).
To decide what number is the address of I6_glk_set_style: (- isix_glk_set_style -).
To decide what number is the address of I6_glk_set_style_stream: (- isix_glk_set_style_stream -).
To decide what number is the address of I6_glk_set_window: (- isix_glk_set_window -).
To decide what number is the address of I6_glk_sound_load_hint: (- isix_glk_sound_load_hint -).
To decide what number is the address of I6_glk_stream_close: (- isix_glk_stream_close -).
To decide what number is the address of I6_glk_stream_get_current: (- isix_glk_stream_get_current -).
To decide what number is the address of I6_glk_stream_get_position: (- isix_glk_stream_get_position -).
To decide what number is the address of I6_glk_stream_get_rock: (- isix_glk_stream_get_rock -).
To decide what number is the address of I6_glk_stream_iterate: (- isix_glk_stream_iterate -).
To decide what number is the address of I6_glk_stream_open_file: (- isix_glk_stream_open_file -).
To decide what number is the address of I6_glk_stream_open_file_uni: (- isix_glk_stream_open_file_uni -).
To decide what number is the address of I6_glk_stream_open_memory: (- isix_glk_stream_open_memory -).
To decide what number is the address of I6_glk_stream_open_memory_uni: (- isix_glk_stream_open_memory_uni -).
To decide what number is the address of I6_glk_stream_set_current: (- isix_glk_stream_set_current -).
To decide what number is the address of I6_glk_stream_set_position: (- isix_glk_stream_set_position -).
To decide what number is the address of I6_glk_style_distinguish: (- isix_glk_style_distinguish -).
To decide what number is the address of I6_glk_style_measure: (- isix_glk_style_measure -).
To decide what number is the address of I6_glk_stylehint_clear: (- isix_glk_stylehint_clear -).
To decide what number is the address of I6_glk_stylehint_set: (- isix_glk_stylehint_set -).
To decide what number is the address of I6_glk_tick: (- isix_glk_tick -).
To decide what number is the address of I6_glk_window_clear: (- isix_glk_window_clear -).
To decide what number is the address of I6_glk_window_close: (- isix_glk_window_close -).
To decide what number is the address of I6_glk_window_erase_rect: (- isix_glk_window_erase_rect -).
To decide what number is the address of I6_glk_window_fill_rect: (- isix_glk_window_fill_rect -).
To decide what number is the address of I6_glk_window_flow_break: (- isix_glk_window_flow_break -).
To decide what number is the address of I6_glk_window_get_arrangement: (- isix_glk_window_get_arrangement -).
To decide what number is the address of I6_glk_window_get_echo_stream: (- isix_glk_window_get_echo_stream -).
To decide what number is the address of I6_glk_window_get_parent: (- isix_glk_window_get_parent -).
To decide what number is the address of I6_glk_window_get_rock: (- isix_glk_window_get_rock -).
To decide what number is the address of I6_glk_window_get_root: (- isix_glk_window_get_root -).
To decide what number is the address of I6_glk_window_get_sibling: (- isix_glk_window_get_sibling -).
To decide what number is the address of I6_glk_window_get_size: (- isix_glk_window_get_size -).
To decide what number is the address of I6_glk_window_get_stream: (- isix_glk_window_get_stream -).
To decide what number is the address of I6_glk_window_get_type: (- isix_glk_window_get_type -).
To decide what number is the address of I6_glk_window_iterate: (- isix_glk_window_iterate -).
To decide what number is the address of I6_glk_window_move_cursor: (- isix_glk_window_move_cursor -).
To decide what number is the address of I6_glk_window_open: (- isix_glk_window_open -).
To decide what number is the address of I6_glk_window_set_arrangement: (- isix_glk_window_set_arrangement -).
To decide what number is the address of I6_glk_window_set_background_color: (- isix_glk_window_set_background_c -).
To decide what number is the address of I6_glk_window_set_echo_stream: (- isix_glk_window_set_echo_stream -).
To decide what number is the address of I6_loc: (- isix_loc -).
To decide what number is the address of I6_testcommandnoun: (- isix_testcommandnoun -).

Chapter "Traversal over Standard Template Routines"

[Note that we are expected to leave out I6_Main; it often gets special treatment.]
To traverse the standard template routines with the visitor (V - a phrase (number, text) -> nothing):
	if the address of I6_AGL__M is not zero, apply V to the address of I6_AGL__M and "AGL__M";
	if the address of I6_AbandonActivity is not zero, apply V to the address of I6_AbandonActivity and "AbandonActivity";
	if the address of I6_AbbreviatedRoomDescription is not zero, apply V to the address of I6_AbbreviatedRoomDescription and "AbbreviatedRoomDescription";
	if the address of I6_ActRulebookFails is not zero, apply V to the address of I6_ActRulebookFails and "ActRulebookFails";
	if the address of I6_ActRulebookSucceeds is not zero, apply V to the address of I6_ActRulebookSucceeds and "ActRulebookSucceeds";
	if the address of I6_ActionNumberIndexed is not zero, apply V to the address of I6_ActionNumberIndexed and "ActionNumberIndexed";
	if the address of I6_ActionPrimitive is not zero, apply V to the address of I6_ActionPrimitive and "ActionPrimitive";
	if the address of I6_ActionVariablesNotTypeSafe is not zero, apply V to the address of I6_ActionVariablesNotTypeSafe and "ActionVariablesNotTypeSafe";
	if the address of I6_ActionsOffSub is not zero, apply V to the address of I6_ActionsOffSub and "ActionsOffSub";
	if the address of I6_ActionsOnSub is not zero, apply V to the address of I6_ActionsOnSub and "ActionsOnSub";
	if the address of I6_ActivityEmpty is not zero, apply V to the address of I6_ActivityEmpty and "ActivityEmpty";
	if the address of I6_AddToScope is not zero, apply V to the address of I6_AddToScope and "AddToScope";
	if the address of I6_Adjudicate is not zero, apply V to the address of I6_Adjudicate and "Adjudicate";
	if the address of I6_AllowInShowme is not zero, apply V to the address of I6_AllowInShowme and "AllowInShowme";
	if the address of I6_AnalyseToken is not zero, apply V to the address of I6_AnalyseToken and "AnalyseToken";
	if the address of I6_ArgumentTypeFailed is not zero, apply V to the address of I6_ArgumentTypeFailed and "ArgumentTypeFailed";
	if the address of I6_ArticleDescriptors is not zero, apply V to the address of I6_ArticleDescriptors and "ArticleDescriptors";
	if the address of I6_AssertMapConnection is not zero, apply V to the address of I6_AssertMapConnection and "AssertMapConnection";
	if the address of I6_AssertMapUnconnection is not zero, apply V to the address of I6_AssertMapUnconnection and "AssertMapUnconnection";
	if the address of I6_BackSideOfDoor is not zero, apply V to the address of I6_BackSideOfDoor and "BackSideOfDoor";
	if the address of I6_Banner is not zero, apply V to the address of I6_Banner and "Banner";
	if the address of I6_BeginAction is not zero, apply V to the address of I6_BeginAction and "BeginAction";
	if the address of I6_BeginActivity is not zero, apply V to the address of I6_BeginActivity and "BeginActivity";
	if the address of I6_BeginFollowRulebook is not zero, apply V to the address of I6_BeginFollowRulebook and "BeginFollowRulebook";
	if the address of I6_BestGuess is not zero, apply V to the address of I6_BestGuess and "BestGuess";
	if the address of I6_BlkAllocate is not zero, apply V to the address of I6_BlkAllocate and "BlkAllocate";
	if the address of I6_BlkAllocationError is not zero, apply V to the address of I6_BlkAllocationError and "BlkAllocationError";
	if the address of I6_BlkDebug is not zero, apply V to the address of I6_BlkDebug and "BlkDebug";
	if the address of I6_BlkDebugDecomposition is not zero, apply V to the address of I6_BlkDebugDecomposition and "BlkDebugDecomposition";
	if the address of I6_BlkFree is not zero, apply V to the address of I6_BlkFree and "BlkFree";
	if the address of I6_BlkFreeSingleBlock is not zero, apply V to the address of I6_BlkFreeSingleBlock and "BlkFreeSingleBlock";
	if the address of I6_BlkMerge is not zero, apply V to the address of I6_BlkMerge and "BlkMerge";
	if the address of I6_BlkRecut is not zero, apply V to the address of I6_BlkRecut and "BlkRecut";
	if the address of I6_BlkResize is not zero, apply V to the address of I6_BlkResize and "BlkResize";
	if the address of I6_BlkSize is not zero, apply V to the address of I6_BlkSize and "BlkSize";
	if the address of I6_BlkTotalSize is not zero, apply V to the address of I6_BlkTotalSize and "BlkTotalSize";
	if the address of I6_BlkType is not zero, apply V to the address of I6_BlkType and "BlkType";
	if the address of I6_BlkValueCast is not zero, apply V to the address of I6_BlkValueCast and "BlkValueCast";
	if the address of I6_BlkValueCompare is not zero, apply V to the address of I6_BlkValueCompare and "BlkValueCompare";
	if the address of I6_BlkValueCopy is not zero, apply V to the address of I6_BlkValueCopy and "BlkValueCopy";
	if the address of I6_BlkValueCreate is not zero, apply V to the address of I6_BlkValueCreate and "BlkValueCreate";
	if the address of I6_BlkValueDestroy is not zero, apply V to the address of I6_BlkValueDestroy and "BlkValueDestroy";
	if the address of I6_BlkValueExtent is not zero, apply V to the address of I6_BlkValueExtent and "BlkValueExtent";
	if the address of I6_BlkValueHash is not zero, apply V to the address of I6_BlkValueHash and "BlkValueHash";
	if the address of I6_BlkValueInitialCopy is not zero, apply V to the address of I6_BlkValueInitialCopy and "BlkValueInitialCopy";
	if the address of I6_BlkValueRead is not zero, apply V to the address of I6_BlkValueRead and "BlkValueRead";
	if the address of I6_BlkValueReadFromFile is not zero, apply V to the address of I6_BlkValueReadFromFile and "BlkValueReadFromFile";
	if the address of I6_BlkValueSetExtent is not zero, apply V to the address of I6_BlkValueSetExtent and "BlkValueSetExtent";
	if the address of I6_BlkValueWrite is not zero, apply V to the address of I6_BlkValueWrite and "BlkValueWrite";
	if the address of I6_BlkValueWriteToFile is not zero, apply V to the address of I6_BlkValueWriteToFile and "BlkValueWriteToFile";
	if the address of I6_COBJ__Copy is not zero, apply V to the address of I6_COBJ__Copy and "COBJ__Copy";
	if the address of I6_COBJ__SwapMatches is not zero, apply V to the address of I6_COBJ__SwapMatches and "COBJ__SwapMatches";
	if the address of I6_COMBINATION_TY_Compare is not zero, apply V to the address of I6_COMBINATION_TY_Compare and "COMBINATION_TY_Compare";
	if the address of I6_COMBINATION_TY_Copy is not zero, apply V to the address of I6_COMBINATION_TY_Copy and "COMBINATION_TY_Copy";
	if the address of I6_COMBINATION_TY_CopyRawArray is not zero, apply V to the address of I6_COMBINATION_TY_CopyRawArray and "COMBINATION_TY_CopyRawArray";
	if the address of I6_COMBINATION_TY_Create is not zero, apply V to the address of I6_COMBINATION_TY_Create and "COMBINATION_TY_Create";
	if the address of I6_COMBINATION_TY_Destroy is not zero, apply V to the address of I6_COMBINATION_TY_Destroy and "COMBINATION_TY_Destroy";
	if the address of I6_COMBINATION_TY_Distinguish is not zero, apply V to the address of I6_COMBINATION_TY_Distinguish and "COMBINATION_TY_Distinguish";
	if the address of I6_COMBINATION_TY_Hash is not zero, apply V to the address of I6_COMBINATION_TY_Hash and "COMBINATION_TY_Hash";
	if the address of I6_COMBINATION_TY_PreCopy is not zero, apply V to the address of I6_COMBINATION_TY_PreCopy and "COMBINATION_TY_PreCopy";
	if the address of I6_COMBINATION_TY_Say is not zero, apply V to the address of I6_COMBINATION_TY_Say and "COMBINATION_TY_Say";
	if the address of I6_COMBINATION_TY_Support is not zero, apply V to the address of I6_COMBINATION_TY_Support and "COMBINATION_TY_Support";
	if the address of I6_CPrintOrRun is not zero, apply V to the address of I6_CPrintOrRun and "CPrintOrRun";
	if the address of I6_CThatorThose is not zero, apply V to the address of I6_CThatorThose and "CThatorThose";
	if the address of I6_CTheyreorThats is not zero, apply V to the address of I6_CTheyreorThats and "CTheyreorThats";
	if the address of I6_CantSee is not zero, apply V to the address of I6_CantSee and "CantSee";
	if the address of I6_Cap is not zero, apply V to the address of I6_Cap and "Cap";
	if the address of I6_CarrierOf is not zero, apply V to the address of I6_CarrierOf and "CarrierOf";
	if the address of I6_CarryOutActivity is not zero, apply V to the address of I6_CarryOutActivity and "CarryOutActivity";
	if the address of I6_ChangePlayer is not zero, apply V to the address of I6_ChangePlayer and "ChangePlayer";
	if the address of I6_CharIsOfCase is not zero, apply V to the address of I6_CharIsOfCase and "CharIsOfCase";
	if the address of I6_CharTestCases is not zero, apply V to the address of I6_CharTestCases and "CharTestCases";
	if the address of I6_CharToCase is not zero, apply V to the address of I6_CharToCase and "CharToCase";
	if the address of I6_CheckKindReturned is not zero, apply V to the address of I6_CheckKindReturned and "CheckKindReturned";
	if the address of I6_CheckTableEntryIsBlank is not zero, apply V to the address of I6_CheckTableEntryIsBlank and "CheckTableEntryIsBlank";
	if the address of I6_ChooseObjects is not zero, apply V to the address of I6_ChooseObjects and "ChooseObjects";
	if the address of I6_ChooseRelationHandler is not zero, apply V to the address of I6_ChooseRelationHandler and "ChooseRelationHandler";
	if the address of I6_ChronologyPoint is not zero, apply V to the address of I6_ChronologyPoint and "ChronologyPoint";
	if the address of I6_ClearBoxedText is not zero, apply V to the address of I6_ClearBoxedText and "ClearBoxedText";
	if the address of I6_ClearParagraphing is not zero, apply V to the address of I6_ClearParagraphing and "ClearParagraphing";
	if the address of I6_CommandClarificationBreak is not zero, apply V to the address of I6_CommandClarificationBreak and "CommandClarificationBreak";
	if the address of I6_CommonAncestor is not zero, apply V to the address of I6_CommonAncestor and "CommonAncestor";
	if the address of I6_CompareFields is not zero, apply V to the address of I6_CompareFields and "CompareFields";
	if the address of I6_ComponentHasLight is not zero, apply V to the address of I6_ComponentHasLight and "ComponentHasLight";
	if the address of I6_ComputeFWMatrix is not zero, apply V to the address of I6_ComputeFWMatrix and "ComputeFWMatrix";
	if the address of I6_ConsultNounFilterToken is not zero, apply V to the address of I6_ConsultNounFilterToken and "ConsultNounFilterToken";
	if the address of I6_ContainerOf is not zero, apply V to the address of I6_ContainerOf and "ContainerOf";
	if the address of I6_ConvertToGoingWithPush is not zero, apply V to the address of I6_ConvertToGoingWithPush and "ConvertToGoingWithPush";
	if the address of I6_CoreOf is not zero, apply V to the address of I6_CoreOf and "CoreOf";
	if the address of I6_CoreOfParentOfCoreOf is not zero, apply V to the address of I6_CoreOfParentOfCoreOf and "CoreOfParentOfCoreOf";
	if the address of I6_CreateBlockConstants is not zero, apply V to the address of I6_CreateBlockConstants and "CreateBlockConstants";
	if the address of I6_CreateDynamicRelations is not zero, apply V to the address of I6_CreateDynamicRelations and "CreateDynamicRelations";
	if the address of I6_CreatePropertyOffsets is not zero, apply V to the address of I6_CreatePropertyOffsets and "CreatePropertyOffsets";
	if the address of I6_CreatureTest is not zero, apply V to the address of I6_CreatureTest and "CreatureTest";
	if the address of I6_CubeRoot is not zero, apply V to the address of I6_CubeRoot and "CubeRoot";
	if the address of I6_DA_Name is not zero, apply V to the address of I6_DA_Name and "DA_Name";
	if the address of I6_DA_Number is not zero, apply V to the address of I6_DA_Number and "DA_Number";
	if the address of I6_DA_Topic is not zero, apply V to the address of I6_DA_Topic and "DA_Topic";
	if the address of I6_DA_TruthState is not zero, apply V to the address of I6_DA_TruthState and "DA_TruthState";
	if the address of I6_DB_Action is not zero, apply V to the address of I6_DB_Action and "DB_Action";
	if the address of I6_DB_Action_Details is not zero, apply V to the address of I6_DB_Action_Details and "DB_Action_Details";
	if the address of I6_DB_Rule is not zero, apply V to the address of I6_DB_Rule and "DB_Rule";
	if the address of I6_DECIMAL_TOKEN is not zero, apply V to the address of I6_DECIMAL_TOKEN and "DECIMAL_TOKEN";
	if the address of I6_DebugAction is not zero, apply V to the address of I6_DebugAction and "DebugAction";
	if the address of I6_DebugAttribute is not zero, apply V to the address of I6_DebugAttribute and "DebugAttribute";
	if the address of I6_DebugGrammarLine is not zero, apply V to the address of I6_DebugGrammarLine and "DebugGrammarLine";
	if the address of I6_DebugHeap is not zero, apply V to the address of I6_DebugHeap and "DebugHeap";
	if the address of I6_DebugPartition is not zero, apply V to the address of I6_DebugPartition and "DebugPartition";
	if the address of I6_DebugRulebooks is not zero, apply V to the address of I6_DebugRulebooks and "DebugRulebooks";
	if the address of I6_DebugToken is not zero, apply V to the address of I6_DebugToken and "DebugToken";
	if the address of I6_DecimalNumber is not zero, apply V to the address of I6_DecimalNumber and "DecimalNumber";
	if the address of I6_DefaultTopic is not zero, apply V to the address of I6_DefaultTopic and "DefaultTopic";
	if the address of I6_DefaultValueFinder is not zero, apply V to the address of I6_DefaultValueFinder and "DefaultValueFinder";
	if the address of I6_DefaultValueOfKOV is not zero, apply V to the address of I6_DefaultValueOfKOV and "DefaultValueOfKOV";
	if the address of I6_Descriptors is not zero, apply V to the address of I6_Descriptors and "Descriptors";
	if the address of I6_DetachPart is not zero, apply V to the address of I6_DetachPart and "DetachPart";
	if the address of I6_DetectPluralWord is not zero, apply V to the address of I6_DetectPluralWord and "DetectPluralWord";
	if the address of I6_DetectSceneChange is not zero, apply V to the address of I6_DetectSceneChange and "DetectSceneChange";
	if the address of I6_DiagnoseSortList is not zero, apply V to the address of I6_DiagnoseSortList and "DiagnoseSortList";
	if the address of I6_DictionaryWordToVerbNum is not zero, apply V to the address of I6_DictionaryWordToVerbNum and "DictionaryWordToVerbNum";
	if the address of I6_DigitToValue is not zero, apply V to the address of I6_DigitToValue and "DigitToValue";
	if the address of I6_DirectionDoorLeadsIn is not zero, apply V to the address of I6_DirectionDoorLeadsIn and "DirectionDoorLeadsIn";
	if the address of I6_DisplayBoxedQuotation is not zero, apply V to the address of I6_DisplayBoxedQuotation and "DisplayBoxedQuotation";
	if the address of I6_DisplayFigure is not zero, apply V to the address of I6_DisplayFigure and "DisplayFigure";
	if the address of I6_DistributeBlockConstants is not zero, apply V to the address of I6_DistributeBlockConstants and "DistributeBlockConstants";
	if the address of I6_DivideParagraphPoint is not zero, apply V to the address of I6_DivideParagraphPoint and "DivideParagraphPoint";
	if the address of I6_DoScopeAction is not zero, apply V to the address of I6_DoScopeAction and "DoScopeAction";
	if the address of I6_DoScopeActionAndRecurse is not zero, apply V to the address of I6_DoScopeActionAndRecurse and "DoScopeActionAndRecurse";
	if the address of I6_DonotuseRule is not zero, apply V to the address of I6_DonotuseRule and "DonotuseRule";
	if the address of I6_DoorFrom is not zero, apply V to the address of I6_DoorFrom and "DoorFrom";
	if the address of I6_DoubleHashSetCheckResize is not zero, apply V to the address of I6_DoubleHashSetCheckResize and "DoubleHashSetCheckResize";
	if the address of I6_DoubleHashSetEntryMatches is not zero, apply V to the address of I6_DoubleHashSetEntryMatches and "DoubleHashSetEntryMatches";
	if the address of I6_DoubleHashSetLookUp is not zero, apply V to the address of I6_DoubleHashSetLookUp and "DoubleHashSetLookUp";
	if the address of I6_DoubleHashSetRelationHandler is not zero, apply V to the address of I6_DoubleHashSetRelationHandler and "DoubleHashSetRelationHandler";
	if the address of I6_DrawStatusLine is not zero, apply V to the address of I6_DrawStatusLine and "DrawStatusLine";
	if the address of I6_DuringSceneMatching is not zero, apply V to the address of I6_DuringSceneMatching and "DuringSceneMatching";
	if the address of I6_EmptyRelationHandler is not zero, apply V to the address of I6_EmptyRelationHandler and "EmptyRelationHandler";
	if the address of I6_EndActivity is not zero, apply V to the address of I6_EndActivity and "EndActivity";
	if the address of I6_EndFollowRulebook is not zero, apply V to the address of I6_EndFollowRulebook and "EndFollowRulebook";
	if the address of I6_EnsureBreakBeforePrompt is not zero, apply V to the address of I6_EnsureBreakBeforePrompt and "EnsureBreakBeforePrompt";
	if the address of I6_EquivHashTableRelationHandler is not zero, apply V to the address of I6_EquivHashTableRelationHandler and "EquivHashTableRelationHandler";
	if the address of I6_ExchangeFields is not zero, apply V to the address of I6_ExchangeFields and "ExchangeFields";
	if the address of I6_ExistsTableLookUpCorr is not zero, apply V to the address of I6_ExistsTableLookUpCorr and "ExistsTableLookUpCorr";
	if the address of I6_ExistsTableLookUpEntry is not zero, apply V to the address of I6_ExistsTableLookUpEntry and "ExistsTableLookUpEntry";
	if the address of I6_ExistsTableRowCorr is not zero, apply V to the address of I6_ExistsTableRowCorr and "ExistsTableRowCorr";
	if the address of I6_FastCountRouteTo is not zero, apply V to the address of I6_FastCountRouteTo and "FastCountRouteTo";
	if the address of I6_FastRouteTo is not zero, apply V to the address of I6_FastRouteTo and "FastRouteTo";
	if the address of I6_FastVtoVRelRouteTo is not zero, apply V to the address of I6_FastVtoVRelRouteTo and "FastVtoVRelRouteTo";
	if the address of I6_FileIO_Close is not zero, apply V to the address of I6_FileIO_Close and "FileIO_Close";
	if the address of I6_FileIO_Error is not zero, apply V to the address of I6_FileIO_Error and "FileIO_Error";
	if the address of I6_FileIO_Exists is not zero, apply V to the address of I6_FileIO_Exists and "FileIO_Exists";
	if the address of I6_FileIO_GetC is not zero, apply V to the address of I6_FileIO_GetC and "FileIO_GetC";
	if the address of I6_FileIO_GetTable is not zero, apply V to the address of I6_FileIO_GetTable and "FileIO_GetTable";
	if the address of I6_FileIO_MarkReady is not zero, apply V to the address of I6_FileIO_MarkReady and "FileIO_MarkReady";
	if the address of I6_FileIO_Open is not zero, apply V to the address of I6_FileIO_Open and "FileIO_Open";
	if the address of I6_FileIO_PrintContents is not zero, apply V to the address of I6_FileIO_PrintContents and "FileIO_PrintContents";
	if the address of I6_FileIO_PrintLine is not zero, apply V to the address of I6_FileIO_PrintLine and "FileIO_PrintLine";
	if the address of I6_FileIO_PutC is not zero, apply V to the address of I6_FileIO_PutC and "FileIO_PutC";
	if the address of I6_FileIO_PutContents is not zero, apply V to the address of I6_FileIO_PutContents and "FileIO_PutContents";
	if the address of I6_FileIO_PutTable is not zero, apply V to the address of I6_FileIO_PutTable and "FileIO_PutTable";
	if the address of I6_FileIO_Ready is not zero, apply V to the address of I6_FileIO_Ready and "FileIO_Ready";
	if the address of I6_FindAction is not zero, apply V to the address of I6_FindAction and "FindAction";
	if the address of I6_FindVisibilityLevels is not zero, apply V to the address of I6_FindVisibilityLevels and "FindVisibilityLevels";
	if the address of I6_FixInhibitFlag is not zero, apply V to the address of I6_FixInhibitFlag and "FixInhibitFlag";
	if the address of I6_FollowRulebook is not zero, apply V to the address of I6_FollowRulebook and "FollowRulebook";
	if the address of I6_ForActivity is not zero, apply V to the address of I6_ForActivity and "ForActivity";
	if the address of I6_ForceTableEntryBlank is not zero, apply V to the address of I6_ForceTableEntryBlank and "ForceTableEntryBlank";
	if the address of I6_ForceTableEntryNonBlank is not zero, apply V to the address of I6_ForceTableEntryNonBlank and "ForceTableEntryNonBlank";
	if the address of I6_FoundEverywhere is not zero, apply V to the address of I6_FoundEverywhere and "FoundEverywhere";
	if the address of I6_FreeStack is not zero, apply V to the address of I6_FreeStack and "FreeStack";
	if the address of I6_FrontSideOfDoor is not zero, apply V to the address of I6_FrontSideOfDoor and "FrontSideOfDoor";
	if the address of I6_GGRecoverObjects is not zero, apply V to the address of I6_GGRecoverObjects and "GGRecoverObjects";
	if the address of I6_GGWordCompare is not zero, apply V to the address of I6_GGWordCompare and "GGWordCompare";
	if the address of I6_GL__M is not zero, apply V to the address of I6_GL__M and "GL__M";
	if the address of I6_GProperty is not zero, apply V to the address of I6_GProperty and "GProperty";
	if the address of I6_GVS_Convert is not zero, apply V to the address of I6_GVS_Convert and "GVS_Convert";
	if the address of I6_GenerateMultipleActions is not zero, apply V to the address of I6_GenerateMultipleActions and "GenerateMultipleActions";
	if the address of I6_GenerateRandomNumber is not zero, apply V to the address of I6_GenerateRandomNumber and "GenerateRandomNumber";
	if the address of I6_GenericVerbSub is not zero, apply V to the address of I6_GenericVerbSub and "GenericVerbSub";
	if the address of I6_GetEitherOrProperty is not zero, apply V to the address of I6_GetEitherOrProperty and "GetEitherOrProperty";
	if the address of I6_GetGNAOfObject is not zero, apply V to the address of I6_GetGNAOfObject and "GetGNAOfObject";
	if the address of I6_GetGender is not zero, apply V to the address of I6_GetGender and "GetGender";
	if the address of I6_GlkListSub is not zero, apply V to the address of I6_GlkListSub and "GlkListSub";
	if the address of I6_Glulx_ChangeAnyToCString is not zero, apply V to the address of I6_Glulx_ChangeAnyToCString and "Glulx_ChangeAnyToCString";
	if the address of I6_Glulx_PrintAnyToArray is not zero, apply V to the address of I6_Glulx_PrintAnyToArray and "Glulx_PrintAnyToArray";
	if the address of I6_Glulx_PrintAnything is not zero, apply V to the address of I6_Glulx_PrintAnything and "Glulx_PrintAnything";
	if the address of I6_GoingLookBreak is not zero, apply V to the address of I6_GoingLookBreak and "GoingLookBreak";
	if the address of I6_GonearSub is not zero, apply V to the address of I6_GonearSub and "GonearSub";
	if the address of I6_GroupChildren is not zero, apply V to the address of I6_GroupChildren and "GroupChildren";
	if the address of I6_HasLightSource is not zero, apply V to the address of I6_HasLightSource and "HasLightSource";
	if the address of I6_HashCoreCheckResize is not zero, apply V to the address of I6_HashCoreCheckResize and "HashCoreCheckResize";
	if the address of I6_HashCoreEntryMatches is not zero, apply V to the address of I6_HashCoreEntryMatches and "HashCoreEntryMatches";
	if the address of I6_HashCoreLookUp is not zero, apply V to the address of I6_HashCoreLookUp and "HashCoreLookUp";
	if the address of I6_HashCoreRelationHandler is not zero, apply V to the address of I6_HashCoreRelationHandler and "HashCoreRelationHandler";
	if the address of I6_HashListRelationHandler is not zero, apply V to the address of I6_HashListRelationHandler and "HashListRelationHandler";
	if the address of I6_HashTableRelationHandler is not zero, apply V to the address of I6_HashTableRelationHandler and "HashTableRelationHandler";
	if the address of I6_HasorHave is not zero, apply V to the address of I6_HasorHave and "HasorHave";
	if the address of I6_HeapInitialise is not zero, apply V to the address of I6_HeapInitialise and "HeapInitialise";
	if the address of I6_HeapLargestFreeBlock is not zero, apply V to the address of I6_HeapLargestFreeBlock and "HeapLargestFreeBlock";
	if the address of I6_HeapMakeSpace is not zero, apply V to the address of I6_HeapMakeSpace and "HeapMakeSpace";
	if the address of I6_HeapNetFreeSpace is not zero, apply V to the address of I6_HeapNetFreeSpace and "HeapNetFreeSpace";
	if the address of I6_HidesLightSource is not zero, apply V to the address of I6_HidesLightSource and "HidesLightSource";
	if the address of I6_HimHerItself is not zero, apply V to the address of I6_HimHerItself and "HimHerItself";
	if the address of I6_HisHerTheir is not zero, apply V to the address of I6_HisHerTheir and "HisHerTheir";
	if the address of I6_HolderOf is not zero, apply V to the address of I6_HolderOf and "HolderOf";
	if the address of I6_HoursMinsWordToTime is not zero, apply V to the address of I6_HoursMinsWordToTime and "HoursMinsWordToTime";
	if the address of I6_I7_ExtendedTryNumber is not zero, apply V to the address of I6_I7_ExtendedTryNumber and "I7_ExtendedTryNumber";
	if the address of I6_I7_Kind_Name is not zero, apply V to the address of I6_I7_Kind_Name and "I7_Kind_Name";
	if the address of I6_I7_SOO_CYC is not zero, apply V to the address of I6_I7_SOO_CYC and "I7_SOO_CYC";
	if the address of I6_I7_SOO_PAR is not zero, apply V to the address of I6_I7_SOO_PAR and "I7_SOO_PAR";
	if the address of I6_I7_SOO_RAN is not zero, apply V to the address of I6_I7_SOO_RAN and "I7_SOO_RAN";
	if the address of I6_I7_SOO_SHU is not zero, apply V to the address of I6_I7_SOO_SHU and "I7_SOO_SHU";
	if the address of I6_I7_SOO_STI is not zero, apply V to the address of I6_I7_SOO_STI and "I7_SOO_STI";
	if the address of I6_I7_SOO_STOP is not zero, apply V to the address of I6_I7_SOO_STOP and "I7_SOO_STOP";
	if the address of I6_I7_SOO_TAP is not zero, apply V to the address of I6_I7_SOO_TAP and "I7_SOO_TAP";
	if the address of I6_I7_SOO_TPAR is not zero, apply V to the address of I6_I7_SOO_TPAR and "I7_SOO_TPAR";
	if the address of I6_I7_SOO_TRAN is not zero, apply V to the address of I6_I7_SOO_TRAN and "I7_SOO_TRAN";
	if the address of I6_I7_String is not zero, apply V to the address of I6_I7_String and "I7_String";
	if the address of I6_INDEXED_TEXT_TY_Cast is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Cast and "INDEXED_TEXT_TY_Cast";
	if the address of I6_INDEXED_TEXT_TY_Compare is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Compare and "INDEXED_TEXT_TY_Compare";
	if the address of I6_INDEXED_TEXT_TY_Create is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Create and "INDEXED_TEXT_TY_Create";
	if the address of I6_INDEXED_TEXT_TY_Distinguish is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Distinguish and "INDEXED_TEXT_TY_Distinguish";
	if the address of I6_INDEXED_TEXT_TY_Empty is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Empty and "INDEXED_TEXT_TY_Empty";
	if the address of I6_INDEXED_TEXT_TY_Hash is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Hash and "INDEXED_TEXT_TY_Hash";
	if the address of I6_INDEXED_TEXT_TY_ROGPR is not zero, apply V to the address of I6_INDEXED_TEXT_TY_ROGPR and "INDEXED_TEXT_TY_ROGPR";
	if the address of I6_INDEXED_TEXT_TY_ReadFile is not zero, apply V to the address of I6_INDEXED_TEXT_TY_ReadFile and "INDEXED_TEXT_TY_ReadFile";
	if the address of I6_INDEXED_TEXT_TY_Say is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Say and "INDEXED_TEXT_TY_Say";
	if the address of I6_INDEXED_TEXT_TY_Support is not zero, apply V to the address of I6_INDEXED_TEXT_TY_Support and "INDEXED_TEXT_TY_Support";
	if the address of I6_INDEXED_TEXT_TY_WriteFile is not zero, apply V to the address of I6_INDEXED_TEXT_TY_WriteFile and "INDEXED_TEXT_TY_WriteFile";
	if the address of I6_IPMS_Lower is not zero, apply V to the address of I6_IPMS_Lower and "IPMS_Lower";
	if the address of I6_IPMS_Merge is not zero, apply V to the address of I6_IPMS_Merge and "IPMS_Merge";
	if the address of I6_IPMS_Reverse is not zero, apply V to the address of I6_IPMS_Reverse and "IPMS_Reverse";
	if the address of I6_IPMS_Rotate is not zero, apply V to the address of I6_IPMS_Rotate and "IPMS_Rotate";
	if the address of I6_IPMS_Upper is not zero, apply V to the address of I6_IPMS_Upper and "IPMS_Upper";
	if the address of I6_IT_BlobAccess is not zero, apply V to the address of I6_IT_BlobAccess and "IT_BlobAccess";
	if the address of I6_IT_CHR_CompileTree is not zero, apply V to the address of I6_IT_CHR_CompileTree and "IT_CHR_CompileTree";
	if the address of I6_IT_CharacterLength is not zero, apply V to the address of I6_IT_CharacterLength and "IT_CharacterLength";
	if the address of I6_IT_CharactersOfCase is not zero, apply V to the address of I6_IT_CharactersOfCase and "IT_CharactersOfCase";
	if the address of I6_IT_CharactersToCase is not zero, apply V to the address of I6_IT_CharactersToCase and "IT_CharactersToCase";
	if the address of I6_IT_Concatenate is not zero, apply V to the address of I6_IT_Concatenate and "IT_Concatenate";
	if the address of I6_IT_GetBlob is not zero, apply V to the address of I6_IT_GetBlob and "IT_GetBlob";
	if the address of I6_IT_GetCharacter is not zero, apply V to the address of I6_IT_GetCharacter and "IT_GetCharacter";
	if the address of I6_IT_MV_End is not zero, apply V to the address of I6_IT_MV_End and "IT_MV_End";
	if the address of I6_IT_RE_CheckTree is not zero, apply V to the address of I6_IT_RE_CheckTree and "IT_RE_CheckTree";
	if the address of I6_IT_RE_Clear_Markers is not zero, apply V to the address of I6_IT_RE_Clear_Markers and "IT_RE_Clear_Markers";
	if the address of I6_IT_RE_CompileTree is not zero, apply V to the address of I6_IT_RE_CompileTree and "IT_RE_CompileTree";
	if the address of I6_IT_RE_Concatenate is not zero, apply V to the address of I6_IT_RE_Concatenate and "IT_RE_Concatenate";
	if the address of I6_IT_RE_CreateMatchVars is not zero, apply V to the address of I6_IT_RE_CreateMatchVars and "IT_RE_CreateMatchVars";
	if the address of I6_IT_RE_DebugMatchVars is not zero, apply V to the address of I6_IT_RE_DebugMatchVars and "IT_RE_DebugMatchVars";
	if the address of I6_IT_RE_DebugNode is not zero, apply V to the address of I6_IT_RE_DebugNode and "IT_RE_DebugNode";
	if the address of I6_IT_RE_DebugSubtree is not zero, apply V to the address of I6_IT_RE_DebugSubtree and "IT_RE_DebugSubtree";
	if the address of I6_IT_RE_DebugTree is not zero, apply V to the address of I6_IT_RE_DebugTree and "IT_RE_DebugTree";
	if the address of I6_IT_RE_EmptyMatchVars is not zero, apply V to the address of I6_IT_RE_EmptyMatchVars and "IT_RE_EmptyMatchVars";
	if the address of I6_IT_RE_EraseConstraints is not zero, apply V to the address of I6_IT_RE_EraseConstraints and "IT_RE_EraseConstraints";
	if the address of I6_IT_RE_ExpandChoices is not zero, apply V to the address of I6_IT_RE_ExpandChoices and "IT_RE_ExpandChoices";
	if the address of I6_IT_RE_FailSubexpressions is not zero, apply V to the address of I6_IT_RE_FailSubexpressions and "IT_RE_FailSubexpressions";
	if the address of I6_IT_RE_GetMatchVar is not zero, apply V to the address of I6_IT_RE_GetMatchVar and "IT_RE_GetMatchVar";
	if the address of I6_IT_RE_MatchSubstring is not zero, apply V to the address of I6_IT_RE_MatchSubstring and "IT_RE_MatchSubstring";
	if the address of I6_IT_RE_Node is not zero, apply V to the address of I6_IT_RE_Node and "IT_RE_Node";
	if the address of I6_IT_RE_NodeAddress is not zero, apply V to the address of I6_IT_RE_NodeAddress and "IT_RE_NodeAddress";
	if the address of I6_IT_RE_Parse is not zero, apply V to the address of I6_IT_RE_Parse and "IT_RE_Parse";
	if the address of I6_IT_RE_ParseAtPosition is not zero, apply V to the address of I6_IT_RE_ParseAtPosition and "IT_RE_ParseAtPosition";
	if the address of I6_IT_RE_PrintNoRewinds is not zero, apply V to the address of I6_IT_RE_PrintNoRewinds and "IT_RE_PrintNoRewinds";
	if the address of I6_IT_RE_Range is not zero, apply V to the address of I6_IT_RE_Range and "IT_RE_Range";
	if the address of I6_IT_RE_RangeSyntaxCorrect is not zero, apply V to the address of I6_IT_RE_RangeSyntaxCorrect and "IT_RE_RangeSyntaxCorrect";
	if the address of I6_IT_RE_SeekBacktrack is not zero, apply V to the address of I6_IT_RE_SeekBacktrack and "IT_RE_SeekBacktrack";
	if the address of I6_IT_RE_SetTrace is not zero, apply V to the address of I6_IT_RE_SetTrace and "IT_RE_SetTrace";
	if the address of I6_IT_RE_Width is not zero, apply V to the address of I6_IT_RE_Width and "IT_RE_Width";
	if the address of I6_IT_ReplaceBlob is not zero, apply V to the address of I6_IT_ReplaceBlob and "IT_ReplaceBlob";
	if the address of I6_IT_ReplaceText is not zero, apply V to the address of I6_IT_ReplaceText and "IT_ReplaceText";
	if the address of I6_IT_Replace_RE is not zero, apply V to the address of I6_IT_Replace_RE and "IT_Replace_RE";
	if the address of I6_IT_RevCase is not zero, apply V to the address of I6_IT_RevCase and "IT_RevCase";
	if the address of I6_Identical is not zero, apply V to the address of I6_Identical and "Identical";
	if the address of I6_ImplicitTake is not zero, apply V to the address of I6_ImplicitTake and "ImplicitTake";
	if the address of I6_InPlaceMergeSortAlgorithm is not zero, apply V to the address of I6_InPlaceMergeSortAlgorithm and "InPlaceMergeSortAlgorithm";
	if the address of I6_IndirectlyContains is not zero, apply V to the address of I6_IndirectlyContains and "IndirectlyContains";
	if the address of I6_InitialHeapAllocation is not zero, apply V to the address of I6_InitialHeapAllocation and "InitialHeapAllocation";
	if the address of I6_InsertionSortAlgorithm is not zero, apply V to the address of I6_InsertionSortAlgorithm and "InsertionSortAlgorithm";
	if the address of I6_IntegerDivide is not zero, apply V to the address of I6_IntegerDivide and "IntegerDivide";
	if the address of I6_IntegerRemainder is not zero, apply V to the address of I6_IntegerRemainder and "IntegerRemainder";
	if the address of I6_InternalTestCases is not zero, apply V to the address of I6_InternalTestCases and "InternalTestCases";
	if the address of I6_IsSeeThrough is not zero, apply V to the address of I6_IsSeeThrough and "IsSeeThrough";
	if the address of I6_IsorAre is not zero, apply V to the address of I6_IsorAre and "IsorAre";
	if the address of I6_IterateRelations is not zero, apply V to the address of I6_IterateRelations and "IterateRelations";
	if the address of I6_ItorThem is not zero, apply V to the address of I6_ItorThem and "ItorThem";
	if the address of I6_KOVComparisonFunction is not zero, apply V to the address of I6_KOVComparisonFunction and "KOVComparisonFunction";
	if the address of I6_KOVDomainSize is not zero, apply V to the address of I6_KOVDomainSize and "KOVDomainSize";
	if the address of I6_KOVHashValue is not zero, apply V to the address of I6_KOVHashValue and "KOVHashValue";
	if the address of I6_KOVIsBlockValue is not zero, apply V to the address of I6_KOVIsBlockValue and "KOVIsBlockValue";
	if the address of I6_KOVSupportFunction is not zero, apply V to the address of I6_KOVSupportFunction and "KOVSupportFunction";
	if the address of I6_Keyboard is not zero, apply V to the address of I6_Keyboard and "Keyboard";
	if the address of I6_KeyboardPrimitive is not zero, apply V to the address of I6_KeyboardPrimitive and "KeyboardPrimitive";
	if the address of I6_KindAtomic is not zero, apply V to the address of I6_KindAtomic and "KindAtomic";
	if the address of I6_KindBaseArity is not zero, apply V to the address of I6_KindBaseArity and "KindBaseArity";
	if the address of I6_KindBaseTerm is not zero, apply V to the address of I6_KindBaseTerm and "KindBaseTerm";
	if the address of I6_LIST_OF_TY_AppendList is not zero, apply V to the address of I6_LIST_OF_TY_AppendList and "LIST_OF_TY_AppendList";
	if the address of I6_LIST_OF_TY_Compare is not zero, apply V to the address of I6_LIST_OF_TY_Compare and "LIST_OF_TY_Compare";
	if the address of I6_LIST_OF_TY_ComparisonFn is not zero, apply V to the address of I6_LIST_OF_TY_ComparisonFn and "LIST_OF_TY_ComparisonFn";
	if the address of I6_LIST_OF_TY_Copy is not zero, apply V to the address of I6_LIST_OF_TY_Copy and "LIST_OF_TY_Copy";
	if the address of I6_LIST_OF_TY_CopyRawArray is not zero, apply V to the address of I6_LIST_OF_TY_CopyRawArray and "LIST_OF_TY_CopyRawArray";
	if the address of I6_LIST_OF_TY_Create is not zero, apply V to the address of I6_LIST_OF_TY_Create and "LIST_OF_TY_Create";
	if the address of I6_LIST_OF_TY_Desc is not zero, apply V to the address of I6_LIST_OF_TY_Desc and "LIST_OF_TY_Desc";
	if the address of I6_LIST_OF_TY_Destroy is not zero, apply V to the address of I6_LIST_OF_TY_Destroy and "LIST_OF_TY_Destroy";
	if the address of I6_LIST_OF_TY_Distinguish is not zero, apply V to the address of I6_LIST_OF_TY_Distinguish and "LIST_OF_TY_Distinguish";
	if the address of I6_LIST_OF_TY_Empty is not zero, apply V to the address of I6_LIST_OF_TY_Empty and "LIST_OF_TY_Empty";
	if the address of I6_LIST_OF_TY_FindItem is not zero, apply V to the address of I6_LIST_OF_TY_FindItem and "LIST_OF_TY_FindItem";
	if the address of I6_LIST_OF_TY_GetItem is not zero, apply V to the address of I6_LIST_OF_TY_GetItem and "LIST_OF_TY_GetItem";
	if the address of I6_LIST_OF_TY_GetLength is not zero, apply V to the address of I6_LIST_OF_TY_GetLength and "LIST_OF_TY_GetLength";
	if the address of I6_LIST_OF_TY_Hash is not zero, apply V to the address of I6_LIST_OF_TY_Hash and "LIST_OF_TY_Hash";
	if the address of I6_LIST_OF_TY_InsertItem is not zero, apply V to the address of I6_LIST_OF_TY_InsertItem and "LIST_OF_TY_InsertItem";
	if the address of I6_LIST_OF_TY_Mol is not zero, apply V to the address of I6_LIST_OF_TY_Mol and "LIST_OF_TY_Mol";
	if the address of I6_LIST_OF_TY_PreCopy is not zero, apply V to the address of I6_LIST_OF_TY_PreCopy and "LIST_OF_TY_PreCopy";
	if the address of I6_LIST_OF_TY_PutItem is not zero, apply V to the address of I6_LIST_OF_TY_PutItem and "LIST_OF_TY_PutItem";
	if the address of I6_LIST_OF_TY_RemoveItemRange is not zero, apply V to the address of I6_LIST_OF_TY_RemoveItemRange and "LIST_OF_TY_RemoveItemRange";
	if the address of I6_LIST_OF_TY_RemoveValue is not zero, apply V to the address of I6_LIST_OF_TY_RemoveValue and "LIST_OF_TY_RemoveValue";
	if the address of I6_LIST_OF_TY_Remove_List is not zero, apply V to the address of I6_LIST_OF_TY_Remove_List and "LIST_OF_TY_Remove_List";
	if the address of I6_LIST_OF_TY_Reverse is not zero, apply V to the address of I6_LIST_OF_TY_Reverse and "LIST_OF_TY_Reverse";
	if the address of I6_LIST_OF_TY_Rotate is not zero, apply V to the address of I6_LIST_OF_TY_Rotate and "LIST_OF_TY_Rotate";
	if the address of I6_LIST_OF_TY_Say is not zero, apply V to the address of I6_LIST_OF_TY_Say and "LIST_OF_TY_Say";
	if the address of I6_LIST_OF_TY_SetLength is not zero, apply V to the address of I6_LIST_OF_TY_SetLength and "LIST_OF_TY_SetLength";
	if the address of I6_LIST_OF_TY_Set_Mol is not zero, apply V to the address of I6_LIST_OF_TY_Set_Mol and "LIST_OF_TY_Set_Mol";
	if the address of I6_LIST_OF_TY_Sort is not zero, apply V to the address of I6_LIST_OF_TY_Sort and "LIST_OF_TY_Sort";
	if the address of I6_LIST_OF_TY_Support is not zero, apply V to the address of I6_LIST_OF_TY_Support and "LIST_OF_TY_Support";
	if the address of I6_LTI_Insert is not zero, apply V to the address of I6_LTI_Insert and "LTI_Insert";
	if the address of I6_L__M is not zero, apply V to the address of I6_L__M and "L__M";
	if the address of I6_LanguageContraction is not zero, apply V to the address of I6_LanguageContraction and "LanguageContraction";
	if the address of I6_LanguageDirection is not zero, apply V to the address of I6_LanguageDirection and "LanguageDirection";
	if the address of I6_LanguageLM is not zero, apply V to the address of I6_LanguageLM and "LanguageLM";
	if the address of I6_LanguageNumber is not zero, apply V to the address of I6_LanguageNumber and "LanguageNumber";
	if the address of I6_LanguageTimeOfDay is not zero, apply V to the address of I6_LanguageTimeOfDay and "LanguageTimeOfDay";
	if the address of I6_LanguageToInformese is not zero, apply V to the address of I6_LanguageToInformese and "LanguageToInformese";
	if the address of I6_LanguageVerb is not zero, apply V to the address of I6_LanguageVerb and "LanguageVerb";
	if the address of I6_LanguageVerbLikesAdverb is not zero, apply V to the address of I6_LanguageVerbLikesAdverb and "LanguageVerbLikesAdverb";
	if the address of I6_LanguageVerbMayBeName is not zero, apply V to the address of I6_LanguageVerbMayBeName and "LanguageVerbMayBeName";
	if the address of I6_ListCompareEntries is not zero, apply V to the address of I6_ListCompareEntries and "ListCompareEntries";
	if the address of I6_ListEqual is not zero, apply V to the address of I6_ListEqual and "ListEqual";
	if the address of I6_ListSwapEntries is not zero, apply V to the address of I6_ListSwapEntries and "ListSwapEntries";
	if the address of I6_LocationOf is not zero, apply V to the address of I6_LocationOf and "LocationOf";
	if the address of I6_LookAfterGoing is not zero, apply V to the address of I6_LookAfterGoing and "LookAfterGoing";
	if the address of I6_LookSub is not zero, apply V to the address of I6_LookSub and "LookSub";
	if the address of I6_LoopOverScope is not zero, apply V to the address of I6_LoopOverScope and "LoopOverScope";
	if the address of I6_MStack_CreateAVVars is not zero, apply V to the address of I6_MStack_CreateAVVars and "MStack_CreateAVVars";
	if the address of I6_MStack_CreateRBVars is not zero, apply V to the address of I6_MStack_CreateRBVars and "MStack_CreateRBVars";
	if the address of I6_MStack_DestroyAVVars is not zero, apply V to the address of I6_MStack_DestroyAVVars and "MStack_DestroyAVVars";
	if the address of I6_MStack_DestroyRBVars is not zero, apply V to the address of I6_MStack_DestroyRBVars and "MStack_DestroyRBVars";
	if the address of I6_MakeColourWord is not zero, apply V to the address of I6_MakeColourWord and "MakeColourWord";
	if the address of I6_MakeMatch is not zero, apply V to the address of I6_MakeMatch and "MakeMatch";
	if the address of I6_MakePart is not zero, apply V to the address of I6_MakePart and "MakePart";
	if the address of I6_MapConnection is not zero, apply V to the address of I6_MapConnection and "MapConnection";
	if the address of I6_MapRouteTo is not zero, apply V to the address of I6_MapRouteTo and "MapRouteTo";
	if the address of I6_MarkedListCoalesce is not zero, apply V to the address of I6_MarkedListCoalesce and "MarkedListCoalesce";
	if the address of I6_MarkedListIterator is not zero, apply V to the address of I6_MarkedListIterator and "MarkedListIterator";
	if the address of I6_MatchTextAgainstObject is not zero, apply V to the address of I6_MatchTextAgainstObject and "MatchTextAgainstObject";
	if the address of I6_MistakeActionSub is not zero, apply V to the address of I6_MistakeActionSub and "MistakeActionSub";
	if the address of I6_MoveBackdrop is not zero, apply V to the address of I6_MoveBackdrop and "MoveBackdrop";
	if the address of I6_MoveDuringGoing is not zero, apply V to the address of I6_MoveDuringGoing and "MoveDuringGoing";
	if the address of I6_MoveFloatingObjects is not zero, apply V to the address of I6_MoveFloatingObjects and "MoveFloatingObjects";
	if the address of I6_MoveObject is not zero, apply V to the address of I6_MoveObject and "MoveObject";
	if the address of I6_MoveRuleAfter is not zero, apply V to the address of I6_MoveRuleAfter and "MoveRuleAfter";
	if the address of I6_MoveRuleBefore is not zero, apply V to the address of I6_MoveRuleBefore and "MoveRuleBefore";
	if the address of I6_MoveWord is not zero, apply V to the address of I6_MoveWord and "MoveWord";
	if the address of I6_MstVO is not zero, apply V to the address of I6_MstVO and "MstVO";
	if the address of I6_MstVON is not zero, apply V to the address of I6_MstVON and "MstVON";
	if the address of I6_Mstack_Backtrace is not zero, apply V to the address of I6_Mstack_Backtrace and "Mstack_Backtrace";
	if the address of I6_Mstack_Create_Frame is not zero, apply V to the address of I6_Mstack_Create_Frame and "Mstack_Create_Frame";
	if the address of I6_Mstack_Destroy_Frame is not zero, apply V to the address of I6_Mstack_Destroy_Frame and "Mstack_Destroy_Frame";
	if the address of I6_Mstack_Seek_Frame is not zero, apply V to the address of I6_Mstack_Seek_Frame and "Mstack_Seek_Frame";
	if the address of I6_MultiAdd is not zero, apply V to the address of I6_MultiAdd and "MultiAdd";
	if the address of I6_MultiFilter is not zero, apply V to the address of I6_MultiFilter and "MultiFilter";
	if the address of I6_MultiSub is not zero, apply V to the address of I6_MultiSub and "MultiSub";
	if the address of I6_NeedLightForAction is not zero, apply V to the address of I6_NeedLightForAction and "NeedLightForAction";
	if the address of I6_NeedToCarryNoun is not zero, apply V to the address of I6_NeedToCarryNoun and "NeedToCarryNoun";
	if the address of I6_NeedToCarrySecondNoun is not zero, apply V to the address of I6_NeedToCarrySecondNoun and "NeedToCarrySecondNoun";
	if the address of I6_NeedToTouchNoun is not zero, apply V to the address of I6_NeedToTouchNoun and "NeedToTouchNoun";
	if the address of I6_NeedToTouchSecondNoun is not zero, apply V to the address of I6_NeedToTouchSecondNoun and "NeedToTouchSecondNoun";
	if the address of I6_NextWord is not zero, apply V to the address of I6_NextWord and "NextWord";
	if the address of I6_NextWordStopped is not zero, apply V to the address of I6_NextWordStopped and "NextWordStopped";
	if the address of I6_NotifyTheScore is not zero, apply V to the address of I6_NotifyTheScore and "NotifyTheScore";
	if the address of I6_NounDomain is not zero, apply V to the address of I6_NounDomain and "NounDomain";
	if the address of I6_NounWord is not zero, apply V to the address of I6_NounWord and "NounWord";
	if the address of I6_NumberOfGroupsInList is not zero, apply V to the address of I6_NumberOfGroupsInList and "NumberOfGroupsInList";
	if the address of I6_NumberWord is not zero, apply V to the address of I6_NumberWord and "NumberWord";
	if the address of I6_ObjectIsUntouchable is not zero, apply V to the address of I6_ObjectIsUntouchable and "ObjectIsUntouchable";
	if the address of I6_ObjectTreeCoalesce is not zero, apply V to the address of I6_ObjectTreeCoalesce and "ObjectTreeCoalesce";
	if the address of I6_ObjectTreeIterator is not zero, apply V to the address of I6_ObjectTreeIterator and "ObjectTreeIterator";
	if the address of I6_OffersLight is not zero, apply V to the address of I6_OffersLight and "OffersLight";
	if the address of I6_OhLookItsReal is not zero, apply V to the address of I6_OhLookItsReal and "OhLookItsReal";
	if the address of I6_OhLookItsRoom is not zero, apply V to the address of I6_OhLookItsRoom and "OhLookItsRoom";
	if the address of I6_OhLookItsThing is not zero, apply V to the address of I6_OhLookItsThing and "OhLookItsThing";
	if the address of I6_OldSortAlgorithm is not zero, apply V to the address of I6_OldSortAlgorithm and "OldSortAlgorithm";
	if the address of I6_OnStage is not zero, apply V to the address of I6_OnStage and "OnStage";
	if the address of I6_OtherSideOfDoor is not zero, apply V to the address of I6_OtherSideOfDoor and "OtherSideOfDoor";
	if the address of I6_OtoVRelRouteTo is not zero, apply V to the address of I6_OtoVRelRouteTo and "OtoVRelRouteTo";
	if the address of I6_OwnerOf is not zero, apply V to the address of I6_OwnerOf and "OwnerOf";
	if the address of I6_PROPERTY_TY_Say is not zero, apply V to the address of I6_PROPERTY_TY_Say and "PROPERTY_TY_Say";
	if the address of I6_PSN__ is not zero, apply V to the address of I6_PSN__ and "PSN__";
	if the address of I6_ParaContent is not zero, apply V to the address of I6_ParaContent and "ParaContent";
	if the address of I6_ParentOf is not zero, apply V to the address of I6_ParentOf and "ParentOf";
	if the address of I6_ParseToken is not zero, apply V to the address of I6_ParseToken and "ParseToken";
	if the address of I6_ParseTokenStopped is not zero, apply V to the address of I6_ParseTokenStopped and "ParseTokenStopped";
	if the address of I6_ParseToken__ is not zero, apply V to the address of I6_ParseToken__ and "ParseToken__";
	if the address of I6_ParserError is not zero, apply V to the address of I6_ParserError and "ParserError";
	if the address of I6_Parser__parse is not zero, apply V to the address of I6_Parser__parse and "Parser__parse";
	if the address of I6_PartitionList is not zero, apply V to the address of I6_PartitionList and "PartitionList";
	if the address of I6_Perform_Undo is not zero, apply V to the address of I6_Perform_Undo and "Perform_Undo";
	if the address of I6_PlaceInScope is not zero, apply V to the address of I6_PlaceInScope and "PlaceInScope";
	if the address of I6_PlaySound is not zero, apply V to the address of I6_PlaySound and "PlaySound";
	if the address of I6_PlayerTo is not zero, apply V to the address of I6_PlayerTo and "PlayerTo";
	if the address of I6_PredictableSub is not zero, apply V to the address of I6_PredictableSub and "PredictableSub";
	if the address of I6_PrefaceByArticle is not zero, apply V to the address of I6_PrefaceByArticle and "PrefaceByArticle";
	if the address of I6_PrepositionChain is not zero, apply V to the address of I6_PrepositionChain and "PrepositionChain";
	if the address of I6_PrintCommand is not zero, apply V to the address of I6_PrintCommand and "PrintCommand";
	if the address of I6_PrintInferredCommand is not zero, apply V to the address of I6_PrintInferredCommand and "PrintInferredCommand";
	if the address of I6_PrintKindValuePair is not zero, apply V to the address of I6_PrintKindValuePair and "PrintKindValuePair";
	if the address of I6_PrintOrRun is not zero, apply V to the address of I6_PrintOrRun and "PrintOrRun";
	if the address of I6_PrintPrompt is not zero, apply V to the address of I6_PrintPrompt and "PrintPrompt";
	if the address of I6_PrintPropertyName is not zero, apply V to the address of I6_PrintPropertyName and "PrintPropertyName";
	if the address of I6_PrintRank is not zero, apply V to the address of I6_PrintRank and "PrintRank";
	if the address of I6_PrintSceneName is not zero, apply V to the address of I6_PrintSceneName and "PrintSceneName";
	if the address of I6_PrintSingleParagraph is not zero, apply V to the address of I6_PrintSingleParagraph and "PrintSingleParagraph";
	if the address of I6_PrintSnippet is not zero, apply V to the address of I6_PrintSnippet and "PrintSnippet";
	if the address of I6_PrintSpaces is not zero, apply V to the address of I6_PrintSpaces and "PrintSpaces";
	if the address of I6_PrintTableName is not zero, apply V to the address of I6_PrintTableName and "PrintTableName";
	if the address of I6_PrintText is not zero, apply V to the address of I6_PrintText and "PrintText";
	if the address of I6_PrintTimeOfDay is not zero, apply V to the address of I6_PrintTimeOfDay and "PrintTimeOfDay";
	if the address of I6_PrintTimeOfDayEnglish is not zero, apply V to the address of I6_PrintTimeOfDayEnglish and "PrintTimeOfDayEnglish";
	if the address of I6_PrintUseOption is not zero, apply V to the address of I6_PrintUseOption and "PrintUseOption";
	if the address of I6_PrintVerb is not zero, apply V to the address of I6_PrintVerb and "PrintVerb";
	if the address of I6_Print_ScL is not zero, apply V to the address of I6_Print_ScL and "Print_ScL";
	if the address of I6_ProcessActivityRulebook is not zero, apply V to the address of I6_ProcessActivityRulebook and "ProcessActivityRulebook";
	if the address of I6_ProcessRulebook is not zero, apply V to the address of I6_ProcessRulebook and "ProcessRulebook";
	if the address of I6_PronounNotice is not zero, apply V to the address of I6_PronounNotice and "PronounNotice";
	if the address of I6_PronounNoticeHeldObjects is not zero, apply V to the address of I6_PronounNoticeHeldObjects and "PronounNoticeHeldObjects";
	if the address of I6_PronounValue is not zero, apply V to the address of I6_PronounValue and "PronounValue";
	if the address of I6_Prop_Falsity is not zero, apply V to the address of I6_Prop_Falsity and "Prop_Falsity";
	if the address of I6_PushRuleChange is not zero, apply V to the address of I6_PushRuleChange and "PushRuleChange";
	if the address of I6_RELATION_TY_Compare is not zero, apply V to the address of I6_RELATION_TY_Compare and "RELATION_TY_Compare";
	if the address of I6_RELATION_TY_Copy is not zero, apply V to the address of I6_RELATION_TY_Copy and "RELATION_TY_Copy";
	if the address of I6_RELATION_TY_Create is not zero, apply V to the address of I6_RELATION_TY_Create and "RELATION_TY_Create";
	if the address of I6_RELATION_TY_Destroy is not zero, apply V to the address of I6_RELATION_TY_Destroy and "RELATION_TY_Destroy";
	if the address of I6_RELATION_TY_Distinguish is not zero, apply V to the address of I6_RELATION_TY_Distinguish and "RELATION_TY_Distinguish";
	if the address of I6_RELATION_TY_Empty is not zero, apply V to the address of I6_RELATION_TY_Empty and "RELATION_TY_Empty";
	if the address of I6_RELATION_TY_EquivalenceAdjective is not zero, apply V to the address of I6_RELATION_TY_EquivalenceAdjective and "RELATION_TY_EquivalenceAdjective";
	if the address of I6_RELATION_TY_GetValency is not zero, apply V to the address of I6_RELATION_TY_GetValency and "RELATION_TY_GetValency";
	if the address of I6_RELATION_TY_Name is not zero, apply V to the address of I6_RELATION_TY_Name and "RELATION_TY_Name";
	if the address of I6_RELATION_TY_OToOAdjective is not zero, apply V to the address of I6_RELATION_TY_OToOAdjective and "RELATION_TY_OToOAdjective";
	if the address of I6_RELATION_TY_OToVAdjective is not zero, apply V to the address of I6_RELATION_TY_OToVAdjective and "RELATION_TY_OToVAdjective";
	if the address of I6_RELATION_TY_Say is not zero, apply V to the address of I6_RELATION_TY_Say and "RELATION_TY_Say";
	if the address of I6_RELATION_TY_SetValency is not zero, apply V to the address of I6_RELATION_TY_SetValency and "RELATION_TY_SetValency";
	if the address of I6_RELATION_TY_Support is not zero, apply V to the address of I6_RELATION_TY_Support and "RELATION_TY_Support";
	if the address of I6_RELATION_TY_SymmetricAdjective is not zero, apply V to the address of I6_RELATION_TY_SymmetricAdjective and "RELATION_TY_SymmetricAdjective";
	if the address of I6_RELATION_TY_VToOAdjective is not zero, apply V to the address of I6_RELATION_TY_VToOAdjective and "RELATION_TY_VToOAdjective";
	if the address of I6_RELATION_TY_VToVAdjective is not zero, apply V to the address of I6_RELATION_TY_VToVAdjective and "RELATION_TY_VToVAdjective";
	if the address of I6_RELATIVE_TIME_TOKEN is not zero, apply V to the address of I6_RELATIVE_TIME_TOKEN and "RELATIVE_TIME_TOKEN";
	if the address of I6_RSE_Flip is not zero, apply V to the address of I6_RSE_Flip and "RSE_Flip";
	if the address of I6_RSE_Set is not zero, apply V to the address of I6_RSE_Set and "RSE_Set";
	if the address of I6_Refers is not zero, apply V to the address of I6_Refers and "Refers";
	if the address of I6_ReinstateRule is not zero, apply V to the address of I6_ReinstateRule and "ReinstateRule";
	if the address of I6_RelFollowVector is not zero, apply V to the address of I6_RelFollowVector and "RelFollowVector";
	if the address of I6_RelationRouteTo is not zero, apply V to the address of I6_RelationRouteTo and "RelationRouteTo";
	if the address of I6_RelationTest is not zero, apply V to the address of I6_RelationTest and "RelationTest";
	if the address of I6_Relation_Now1to1 is not zero, apply V to the address of I6_Relation_Now1to1 and "Relation_Now1to1";
	if the address of I6_Relation_Now1to1V is not zero, apply V to the address of I6_Relation_Now1to1V and "Relation_Now1to1V";
	if the address of I6_Relation_NowEquiv is not zero, apply V to the address of I6_Relation_NowEquiv and "Relation_NowEquiv";
	if the address of I6_Relation_NowEquivV is not zero, apply V to the address of I6_Relation_NowEquivV and "Relation_NowEquivV";
	if the address of I6_Relation_NowN1toV is not zero, apply V to the address of I6_Relation_NowN1toV and "Relation_NowN1toV";
	if the address of I6_Relation_NowN1toVV is not zero, apply V to the address of I6_Relation_NowN1toVV and "Relation_NowN1toVV";
	if the address of I6_Relation_NowNEquiv is not zero, apply V to the address of I6_Relation_NowNEquiv and "Relation_NowNEquiv";
	if the address of I6_Relation_NowNEquivV is not zero, apply V to the address of I6_Relation_NowNEquivV and "Relation_NowNEquivV";
	if the address of I6_Relation_NowNVtoV is not zero, apply V to the address of I6_Relation_NowNVtoV and "Relation_NowNVtoV";
	if the address of I6_Relation_NowS1to1 is not zero, apply V to the address of I6_Relation_NowS1to1 and "Relation_NowS1to1";
	if the address of I6_Relation_NowS1to1V is not zero, apply V to the address of I6_Relation_NowS1to1V and "Relation_NowS1to1V";
	if the address of I6_Relation_NowSN1to1 is not zero, apply V to the address of I6_Relation_NowSN1to1 and "Relation_NowSN1to1";
	if the address of I6_Relation_NowSN1to1V is not zero, apply V to the address of I6_Relation_NowSN1to1V and "Relation_NowSN1to1V";
	if the address of I6_Relation_NowVtoV is not zero, apply V to the address of I6_Relation_NowVtoV and "Relation_NowVtoV";
	if the address of I6_Relation_RShowOtoO is not zero, apply V to the address of I6_Relation_RShowOtoO and "Relation_RShowOtoO";
	if the address of I6_Relation_ShowEquiv is not zero, apply V to the address of I6_Relation_ShowEquiv and "Relation_ShowEquiv";
	if the address of I6_Relation_ShowOtoO is not zero, apply V to the address of I6_Relation_ShowOtoO and "Relation_ShowOtoO";
	if the address of I6_Relation_ShowVtoV is not zero, apply V to the address of I6_Relation_ShowVtoV and "Relation_ShowVtoV";
	if the address of I6_Relation_TestVtoV is not zero, apply V to the address of I6_Relation_TestVtoV and "Relation_TestVtoV";
	if the address of I6_RemoveFromPlay is not zero, apply V to the address of I6_RemoveFromPlay and "RemoveFromPlay";
	if the address of I6_RequisitionStack is not zero, apply V to the address of I6_RequisitionStack and "RequisitionStack";
	if the address of I6_ResetDescriptors is not zero, apply V to the address of I6_ResetDescriptors and "ResetDescriptors";
	if the address of I6_ResetVagueWords is not zero, apply V to the address of I6_ResetVagueWords and "ResetVagueWords";
	if the address of I6_ResultOfRule is not zero, apply V to the address of I6_ResultOfRule and "ResultOfRule";
	if the address of I6_ReversedHashTableRelationHandler is not zero, apply V to the address of I6_ReversedHashTableRelationHandler and "ReversedHashTableRelationHandler";
	if the address of I6_ReviseMulti is not zero, apply V to the address of I6_ReviseMulti and "ReviseMulti";
	if the address of I6_RoomOrDoorFrom is not zero, apply V to the address of I6_RoomOrDoorFrom and "RoomOrDoorFrom";
	if the address of I6_RoundOffTime is not zero, apply V to the address of I6_RoundOffTime and "RoundOffTime";
	if the address of I6_RuleHasNoOutcome is not zero, apply V to the address of I6_RuleHasNoOutcome and "RuleHasNoOutcome";
	if the address of I6_RulePrintingRule is not zero, apply V to the address of I6_RulePrintingRule and "RulePrintingRule";
	if the address of I6_RulebookEmpty is not zero, apply V to the address of I6_RulebookEmpty and "RulebookEmpty";
	if the address of I6_RulebookFailed is not zero, apply V to the address of I6_RulebookFailed and "RulebookFailed";
	if the address of I6_RulebookFails is not zero, apply V to the address of I6_RulebookFails and "RulebookFails";
	if the address of I6_RulebookOutcome is not zero, apply V to the address of I6_RulebookOutcome and "RulebookOutcome";
	if the address of I6_RulebookOutcomePrintingRule is not zero, apply V to the address of I6_RulebookOutcomePrintingRule and "RulebookOutcomePrintingRule";
	if the address of I6_RulebookSucceeded is not zero, apply V to the address of I6_RulebookSucceeded and "RulebookSucceeded";
	if the address of I6_RulebookSucceeds is not zero, apply V to the address of I6_RulebookSucceeds and "RulebookSucceeds";
	if the address of I6_RulesAllSub is not zero, apply V to the address of I6_RulesAllSub and "RulesAllSub";
	if the address of I6_RulesOffSub is not zero, apply V to the address of I6_RulesOffSub and "RulesOffSub";
	if the address of I6_RulesOnSub is not zero, apply V to the address of I6_RulesOnSub and "RulesOnSub";
	if the address of I6_RunParagraphOn is not zero, apply V to the address of I6_RunParagraphOn and "RunParagraphOn";
	if the address of I6_RunRoutines is not zero, apply V to the address of I6_RunRoutines and "RunRoutines";
	if the address of I6_RunTimeError is not zero, apply V to the address of I6_RunTimeError and "RunTimeError";
	if the address of I6_RunTimeProblem is not zero, apply V to the address of I6_RunTimeProblem and "RunTimeProblem";
	if the address of I6_SL_Location is not zero, apply V to the address of I6_SL_Location and "SL_Location";
	if the address of I6_SL_Score_Moves is not zero, apply V to the address of I6_SL_Score_Moves and "SL_Score_Moves";
	if the address of I6_STORED_ACTION_TY_Adopt is not zero, apply V to the address of I6_STORED_ACTION_TY_Adopt and "STORED_ACTION_TY_Adopt";
	if the address of I6_STORED_ACTION_TY_Compare is not zero, apply V to the address of I6_STORED_ACTION_TY_Compare and "STORED_ACTION_TY_Compare";
	if the address of I6_STORED_ACTION_TY_Copy is not zero, apply V to the address of I6_STORED_ACTION_TY_Copy and "STORED_ACTION_TY_Copy";
	if the address of I6_STORED_ACTION_TY_Create is not zero, apply V to the address of I6_STORED_ACTION_TY_Create and "STORED_ACTION_TY_Create";
	if the address of I6_STORED_ACTION_TY_Current is not zero, apply V to the address of I6_STORED_ACTION_TY_Current and "STORED_ACTION_TY_Current";
	if the address of I6_STORED_ACTION_TY_Destroy is not zero, apply V to the address of I6_STORED_ACTION_TY_Destroy and "STORED_ACTION_TY_Destroy";
	if the address of I6_STORED_ACTION_TY_Distinguish is not zero, apply V to the address of I6_STORED_ACTION_TY_Distinguish and "STORED_ACTION_TY_Distinguish";
	if the address of I6_STORED_ACTION_TY_Hash is not zero, apply V to the address of I6_STORED_ACTION_TY_Hash and "STORED_ACTION_TY_Hash";
	if the address of I6_STORED_ACTION_TY_Involves is not zero, apply V to the address of I6_STORED_ACTION_TY_Involves and "STORED_ACTION_TY_Involves";
	if the address of I6_STORED_ACTION_TY_New is not zero, apply V to the address of I6_STORED_ACTION_TY_New and "STORED_ACTION_TY_New";
	if the address of I6_STORED_ACTION_TY_Part is not zero, apply V to the address of I6_STORED_ACTION_TY_Part and "STORED_ACTION_TY_Part";
	if the address of I6_STORED_ACTION_TY_Say is not zero, apply V to the address of I6_STORED_ACTION_TY_Say and "STORED_ACTION_TY_Say";
	if the address of I6_STORED_ACTION_TY_Support is not zero, apply V to the address of I6_STORED_ACTION_TY_Support and "STORED_ACTION_TY_Support";
	if the address of I6_STORED_ACTION_TY_Try is not zero, apply V to the address of I6_STORED_ACTION_TY_Try and "STORED_ACTION_TY_Try";
	if the address of I6_STORED_ACTION_TY_Unadopt is not zero, apply V to the address of I6_STORED_ACTION_TY_Unadopt and "STORED_ACTION_TY_Unadopt";
	if the address of I6_STextSubstitution is not zero, apply V to the address of I6_STextSubstitution and "STextSubstitution";
	if the address of I6_SafeSkipDescriptors is not zero, apply V to the address of I6_SafeSkipDescriptors and "SafeSkipDescriptors";
	if the address of I6_SayActionName is not zero, apply V to the address of I6_SayActionName and "SayActionName";
	if the address of I6_SayPhraseName is not zero, apply V to the address of I6_SayPhraseName and "SayPhraseName";
	if the address of I6_ScanPropertyMetadata is not zero, apply V to the address of I6_ScanPropertyMetadata and "ScanPropertyMetadata";
	if the address of I6_SceneUtility is not zero, apply V to the address of I6_SceneUtility and "SceneUtility";
	if the address of I6_ScenesOffSub is not zero, apply V to the address of I6_ScenesOffSub and "ScenesOffSub";
	if the address of I6_ScenesOnSub is not zero, apply V to the address of I6_ScenesOnSub and "ScenesOnSub";
	if the address of I6_ScopeCeiling is not zero, apply V to the address of I6_ScopeCeiling and "ScopeCeiling";
	if the address of I6_ScopeSub is not zero, apply V to the address of I6_ScopeSub and "ScopeSub";
	if the address of I6_ScopeWithin is not zero, apply V to the address of I6_ScopeWithin and "ScopeWithin";
	if the address of I6_ScoreDabCombo is not zero, apply V to the address of I6_ScoreDabCombo and "ScoreDabCombo";
	if the address of I6_ScoreMatchL is not zero, apply V to the address of I6_ScoreMatchL and "ScoreMatchL";
	if the address of I6_SearchScope is not zero, apply V to the address of I6_SearchScope and "SearchScope";
	if the address of I6_SetActionBitmap is not zero, apply V to the address of I6_SetActionBitmap and "SetActionBitmap";
	if the address of I6_SetEitherOrProperty is not zero, apply V to the address of I6_SetEitherOrProperty and "SetEitherOrProperty";
	if the address of I6_SetPlayersCommand is not zero, apply V to the address of I6_SetPlayersCommand and "SetPlayersCommand";
	if the address of I6_SetPronoun is not zero, apply V to the address of I6_SetPronoun and "SetPronoun";
	if the address of I6_SetRulebookOutcome is not zero, apply V to the address of I6_SetRulebookOutcome and "SetRulebookOutcome";
	if the address of I6_SetSortDomain is not zero, apply V to the address of I6_SetSortDomain and "SetSortDomain";
	if the address of I6_SetTime is not zero, apply V to the address of I6_SetTime and "SetTime";
	if the address of I6_SetTimedEvent is not zero, apply V to the address of I6_SetTimedEvent and "SetTimedEvent";
	if the address of I6_ShowExtensionVersions is not zero, apply V to the address of I6_ShowExtensionVersions and "ShowExtensionVersions";
	if the address of I6_ShowFullExtensionVersions is not zero, apply V to the address of I6_ShowFullExtensionVersions and "ShowFullExtensionVersions";
	if the address of I6_ShowHeapSub is not zero, apply V to the address of I6_ShowHeapSub and "ShowHeapSub";
	if the address of I6_ShowMeRecursively is not zero, apply V to the address of I6_ShowMeRecursively and "ShowMeRecursively";
	if the address of I6_ShowMeSub is not zero, apply V to the address of I6_ShowMeSub and "ShowMeSub";
	if the address of I6_ShowOneRelation is not zero, apply V to the address of I6_ShowOneRelation and "ShowOneRelation";
	if the address of I6_ShowRLocation is not zero, apply V to the address of I6_ShowRLocation and "ShowRLocation";
	if the address of I6_ShowRelationsSub is not zero, apply V to the address of I6_ShowRelationsSub and "ShowRelationsSub";
	if the address of I6_ShowSceneStatus is not zero, apply V to the address of I6_ShowSceneStatus and "ShowSceneStatus";
	if the address of I6_ShowVerbSub is not zero, apply V to the address of I6_ShowVerbSub and "ShowVerbSub";
	if the address of I6_SignalMapChange is not zero, apply V to the address of I6_SignalMapChange and "SignalMapChange";
	if the address of I6_SilentlyConsiderLight is not zero, apply V to the address of I6_SilentlyConsiderLight and "SilentlyConsiderLight";
	if the address of I6_SingleBestGuess is not zero, apply V to the address of I6_SingleBestGuess and "SingleBestGuess";
	if the address of I6_SlowCountRouteTo is not zero, apply V to the address of I6_SlowCountRouteTo and "SlowCountRouteTo";
	if the address of I6_SlowRouteTo is not zero, apply V to the address of I6_SlowRouteTo and "SlowRouteTo";
	if the address of I6_SnippetIncludes is not zero, apply V to the address of I6_SnippetIncludes and "SnippetIncludes";
	if the address of I6_SnippetMatches is not zero, apply V to the address of I6_SnippetMatches and "SnippetMatches";
	if the address of I6_SortArray is not zero, apply V to the address of I6_SortArray and "SortArray";
	if the address of I6_SortRange is not zero, apply V to the address of I6_SortRange and "SortRange";
	if the address of I6_SpecialLookSpacingBreak is not zero, apply V to the address of I6_SpecialLookSpacingBreak and "SpecialLookSpacingBreak";
	if the address of I6_SpliceSnippet is not zero, apply V to the address of I6_SpliceSnippet and "SpliceSnippet";
	if the address of I6_SpliceSnippet__TextPrinter is not zero, apply V to the address of I6_SpliceSnippet__TextPrinter and "SpliceSnippet__TextPrinter";
	if the address of I6_SquareRoot is not zero, apply V to the address of I6_SquareRoot and "SquareRoot";
	if the address of I6_SubstituteRule is not zero, apply V to the address of I6_SubstituteRule and "SubstituteRule";
	if the address of I6_SupporterOf is not zero, apply V to the address of I6_SupporterOf and "SupporterOf";
	if the address of I6_SuppressRule is not zero, apply V to the address of I6_SuppressRule and "SuppressRule";
	if the address of I6_SwapWorkflags is not zero, apply V to the address of I6_SwapWorkflags and "SwapWorkflags";
	if the address of I6_Sym2in1HashTableRelationHandler is not zero, apply V to the address of I6_Sym2in1HashTableRelationHandler and "Sym2in1HashTableRelationHandler";
	if the address of I6_SymDoubleHashSetRelationHandler is not zero, apply V to the address of I6_SymDoubleHashSetRelationHandler and "SymDoubleHashSetRelationHandler";
	if the address of I6_SymHashListRelationHandler is not zero, apply V to the address of I6_SymHashListRelationHandler and "SymHashListRelationHandler";
	if the address of I6_TC_KOV is not zero, apply V to the address of I6_TC_KOV and "TC_KOV";
	if the address of I6_TIME_TOKEN is not zero, apply V to the address of I6_TIME_TOKEN and "TIME_TOKEN";
	if the address of I6_TRUTH_STATE_TOKEN is not zero, apply V to the address of I6_TRUTH_STATE_TOKEN and "TRUTH_STATE_TOKEN";
	if the address of I6_TableBlankOutAll is not zero, apply V to the address of I6_TableBlankOutAll and "TableBlankOutAll";
	if the address of I6_TableBlankOutColumn is not zero, apply V to the address of I6_TableBlankOutColumn and "TableBlankOutColumn";
	if the address of I6_TableBlankOutRow is not zero, apply V to the address of I6_TableBlankOutRow and "TableBlankOutRow";
	if the address of I6_TableBlankRow is not zero, apply V to the address of I6_TableBlankRow and "TableBlankRow";
	if the address of I6_TableBlankRows is not zero, apply V to the address of I6_TableBlankRows and "TableBlankRows";
	if the address of I6_TableColumnDebug is not zero, apply V to the address of I6_TableColumnDebug and "TableColumnDebug";
	if the address of I6_TableCompareRows is not zero, apply V to the address of I6_TableCompareRows and "TableCompareRows";
	if the address of I6_TableFilledRows is not zero, apply V to the address of I6_TableFilledRows and "TableFilledRows";
	if the address of I6_TableFindCol is not zero, apply V to the address of I6_TableFindCol and "TableFindCol";
	if the address of I6_TableLookUpCorr is not zero, apply V to the address of I6_TableLookUpCorr and "TableLookUpCorr";
	if the address of I6_TableLookUpEntry is not zero, apply V to the address of I6_TableLookUpEntry and "TableLookUpEntry";
	if the address of I6_TableMoveBlankBitsDown is not zero, apply V to the address of I6_TableMoveBlankBitsDown and "TableMoveBlankBitsDown";
	if the address of I6_TableMoveBlanksToBack is not zero, apply V to the address of I6_TableMoveBlanksToBack and "TableMoveBlanksToBack";
	if the address of I6_TableMoveRowDown is not zero, apply V to the address of I6_TableMoveRowDown and "TableMoveRowDown";
	if the address of I6_TableNextRow is not zero, apply V to the address of I6_TableNextRow and "TableNextRow";
	if the address of I6_TablePrint is not zero, apply V to the address of I6_TablePrint and "TablePrint";
	if the address of I6_TableRandomRow is not zero, apply V to the address of I6_TableRandomRow and "TableRandomRow";
	if the address of I6_TableRead is not zero, apply V to the address of I6_TableRead and "TableRead";
	if the address of I6_TableRowCorr is not zero, apply V to the address of I6_TableRowCorr and "TableRowCorr";
	if the address of I6_TableRowIsBlank is not zero, apply V to the address of I6_TableRowIsBlank and "TableRowIsBlank";
	if the address of I6_TableRows is not zero, apply V to the address of I6_TableRows and "TableRows";
	if the address of I6_TableShuffle is not zero, apply V to the address of I6_TableShuffle and "TableShuffle";
	if the address of I6_TableSort is not zero, apply V to the address of I6_TableSort and "TableSort";
	if the address of I6_TableSwapBlankBits is not zero, apply V to the address of I6_TableSwapBlankBits and "TableSwapBlankBits";
	if the address of I6_TableSwapRows is not zero, apply V to the address of I6_TableSwapRows and "TableSwapRows";
	if the address of I6_TestActionBitmap is not zero, apply V to the address of I6_TestActionBitmap and "TestActionBitmap";
	if the address of I6_TestActionMask is not zero, apply V to the address of I6_TestActionMask and "TestActionMask";
	if the address of I6_TestActivity is not zero, apply V to the address of I6_TestActivity and "TestActivity";
	if the address of I6_TestAdjacency is not zero, apply V to the address of I6_TestAdjacency and "TestAdjacency";
	if the address of I6_TestConcealment is not zero, apply V to the address of I6_TestConcealment and "TestConcealment";
	if the address of I6_TestContainmentRange is not zero, apply V to the address of I6_TestContainmentRange and "TestContainmentRange";
	if the address of I6_TestKeyboardPrimitive is not zero, apply V to the address of I6_TestKeyboardPrimitive and "TestKeyboardPrimitive";
	if the address of I6_TestRegionalContainment is not zero, apply V to the address of I6_TestRegionalContainment and "TestRegionalContainment";
	if the address of I6_TestScope is not zero, apply V to the address of I6_TestScope and "TestScope";
	if the address of I6_TestScriptSub is not zero, apply V to the address of I6_TestScriptSub and "TestScriptSub";
	if the address of I6_TestSinglePastState is not zero, apply V to the address of I6_TestSinglePastState and "TestSinglePastState";
	if the address of I6_TestStart is not zero, apply V to the address of I6_TestStart and "TestStart";
	if the address of I6_TestTouchability is not zero, apply V to the address of I6_TestTouchability and "TestTouchability";
	if the address of I6_TestUseOption is not zero, apply V to the address of I6_TestUseOption and "TestUseOption";
	if the address of I6_TestVisibility is not zero, apply V to the address of I6_TestVisibility and "TestVisibility";
	if the address of I6_ThatorThose is not zero, apply V to the address of I6_ThatorThose and "ThatorThose";
	if the address of I6_TraceLevelSub is not zero, apply V to the address of I6_TraceLevelSub and "TraceLevelSub";
	if the address of I6_TraceOffSub is not zero, apply V to the address of I6_TraceOffSub and "TraceOffSub";
	if the address of I6_TraceOnSub is not zero, apply V to the address of I6_TraceOnSub and "TraceOnSub";
	if the address of I6_TrackActions is not zero, apply V to the address of I6_TrackActions and "TrackActions";
	if the address of I6_TreatParserResults is not zero, apply V to the address of I6_TreatParserResults and "TreatParserResults";
	if the address of I6_TryAction is not zero, apply V to the address of I6_TryAction and "TryAction";
	if the address of I6_TryGivenObject is not zero, apply V to the address of I6_TryGivenObject and "TryGivenObject";
	if the address of I6_TryNumber is not zero, apply V to the address of I6_TryNumber and "TryNumber";
	if the address of I6_TwoInOneCheckResize is not zero, apply V to the address of I6_TwoInOneCheckResize and "TwoInOneCheckResize";
	if the address of I6_TwoInOneDelete is not zero, apply V to the address of I6_TwoInOneDelete and "TwoInOneDelete";
	if the address of I6_TwoInOneEntryMatches is not zero, apply V to the address of I6_TwoInOneEntryMatches and "TwoInOneEntryMatches";
	if the address of I6_TwoInOneHashTableRelationHandler is not zero, apply V to the address of I6_TwoInOneHashTableRelationHandler and "TwoInOneHashTableRelationHandler";
	if the address of I6_TwoInOneLookUp is not zero, apply V to the address of I6_TwoInOneLookUp and "TwoInOneLookUp";
	if the address of I6_UnknownVerb is not zero, apply V to the address of I6_UnknownVerb and "UnknownVerb";
	if the address of I6_UnpackGrammarLine is not zero, apply V to the address of I6_UnpackGrammarLine and "UnpackGrammarLine";
	if the address of I6_UnsignedCompare is not zero, apply V to the address of I6_UnsignedCompare and "UnsignedCompare";
	if the address of I6_UpdateActionBitmap is not zero, apply V to the address of I6_UpdateActionBitmap and "UpdateActionBitmap";
	if the address of I6_UseRule is not zero, apply V to the address of I6_UseRule and "UseRule";
	if the address of I6_VM_AllocateMemory is not zero, apply V to the address of I6_VM_AllocateMemory and "VM_AllocateMemory";
	if the address of I6_VM_ClearScreen is not zero, apply V to the address of I6_VM_ClearScreen and "VM_ClearScreen";
	if the address of I6_VM_CommandTableAddress is not zero, apply V to the address of I6_VM_CommandTableAddress and "VM_CommandTableAddress";
	if the address of I6_VM_CopyBuffer is not zero, apply V to the address of I6_VM_CopyBuffer and "VM_CopyBuffer";
	if the address of I6_VM_Describe_Release is not zero, apply V to the address of I6_VM_Describe_Release and "VM_Describe_Release";
	if the address of I6_VM_DictionaryAddressToNumber is not zero, apply V to the address of I6_VM_DictionaryAddressToNumber and "VM_DictionaryAddressToNumber";
	if the address of I6_VM_FreeMemory is not zero, apply V to the address of I6_VM_FreeMemory and "VM_FreeMemory";
	if the address of I6_VM_Initialise is not zero, apply V to the address of I6_VM_Initialise and "VM_Initialise";
	if the address of I6_VM_InvalidDictionaryAddress is not zero, apply V to the address of I6_VM_InvalidDictionaryAddress and "VM_InvalidDictionaryAddress";
	if the address of I6_VM_KeyChar is not zero, apply V to the address of I6_VM_KeyChar and "VM_KeyChar";
	if the address of I6_VM_KeyDelay is not zero, apply V to the address of I6_VM_KeyDelay and "VM_KeyDelay";
	if the address of I6_VM_KeyDelay_Interrupt is not zero, apply V to the address of I6_VM_KeyDelay_Interrupt and "VM_KeyDelay_Interrupt";
	if the address of I6_VM_LowerToUpperCase is not zero, apply V to the address of I6_VM_LowerToUpperCase and "VM_LowerToUpperCase";
	if the address of I6_VM_MainWindow is not zero, apply V to the address of I6_VM_MainWindow and "VM_MainWindow";
	if the address of I6_VM_MoveCursorInStatusLine is not zero, apply V to the address of I6_VM_MoveCursorInStatusLine and "VM_MoveCursorInStatusLine";
	if the address of I6_VM_NumberToDictionaryAddress is not zero, apply V to the address of I6_VM_NumberToDictionaryAddress and "VM_NumberToDictionaryAddress";
	if the address of I6_VM_Picture is not zero, apply V to the address of I6_VM_Picture and "VM_Picture";
	if the address of I6_VM_PreInitialise is not zero, apply V to the address of I6_VM_PreInitialise and "VM_PreInitialise";
	if the address of I6_VM_PrintCommandWords is not zero, apply V to the address of I6_VM_PrintCommandWords and "VM_PrintCommandWords";
	if the address of I6_VM_PrintToBuffer is not zero, apply V to the address of I6_VM_PrintToBuffer and "VM_PrintToBuffer";
	if the address of I6_VM_ReadKeyboard is not zero, apply V to the address of I6_VM_ReadKeyboard and "VM_ReadKeyboard";
	if the address of I6_VM_RestoreWindowColours is not zero, apply V to the address of I6_VM_RestoreWindowColours and "VM_RestoreWindowColours";
	if the address of I6_VM_Save_Undo is not zero, apply V to the address of I6_VM_Save_Undo and "VM_Save_Undo";
	if the address of I6_VM_ScreenHeight is not zero, apply V to the address of I6_VM_ScreenHeight and "VM_ScreenHeight";
	if the address of I6_VM_ScreenWidth is not zero, apply V to the address of I6_VM_ScreenWidth and "VM_ScreenWidth";
	if the address of I6_VM_Seed_RNG is not zero, apply V to the address of I6_VM_Seed_RNG and "VM_Seed_RNG";
	if the address of I6_VM_SetWindowColours is not zero, apply V to the address of I6_VM_SetWindowColours and "VM_SetWindowColours";
	if the address of I6_VM_SoundEffect is not zero, apply V to the address of I6_VM_SoundEffect and "VM_SoundEffect";
	if the address of I6_VM_StatusLineHeight is not zero, apply V to the address of I6_VM_StatusLineHeight and "VM_StatusLineHeight";
	if the address of I6_VM_Style is not zero, apply V to the address of I6_VM_Style and "VM_Style";
	if the address of I6_VM_Tokenise is not zero, apply V to the address of I6_VM_Tokenise and "VM_Tokenise";
	if the address of I6_VM_Undo is not zero, apply V to the address of I6_VM_Undo and "VM_Undo";
	if the address of I6_VM_UpperToLowerCase is not zero, apply V to the address of I6_VM_UpperToLowerCase and "VM_UpperToLowerCase";
	if the address of I6_VisibilityParent is not zero, apply V to the address of I6_VisibilityParent and "VisibilityParent";
	if the address of I6_VtoORelRouteTo is not zero, apply V to the address of I6_VtoORelRouteTo and "VtoORelRouteTo";
	if the address of I6_VtoVRelRouteTo is not zero, apply V to the address of I6_VtoVRelRouteTo and "VtoVRelRouteTo";
	if the address of I6_WearObject is not zero, apply V to the address of I6_WearObject and "WearObject";
	if the address of I6_WearerOf is not zero, apply V to the address of I6_WearerOf and "WearerOf";
	if the address of I6_WhetherIn is not zero, apply V to the address of I6_WhetherIn and "WhetherIn";
	if the address of I6_WhetherProvides is not zero, apply V to the address of I6_WhetherProvides and "WhetherProvides";
	if the address of I6_WillRecurs is not zero, apply V to the address of I6_WillRecurs and "WillRecurs";
	if the address of I6_WordAddress is not zero, apply V to the address of I6_WordAddress and "WordAddress";
	if the address of I6_WordCount is not zero, apply V to the address of I6_WordCount and "WordCount";
	if the address of I6_WordFrom is not zero, apply V to the address of I6_WordFrom and "WordFrom";
	if the address of I6_WordInProperty is not zero, apply V to the address of I6_WordInProperty and "WordInProperty";
	if the address of I6_WordLength is not zero, apply V to the address of I6_WordLength and "WordLength";
	if the address of I6_WriteAfterEntry is not zero, apply V to the address of I6_WriteAfterEntry and "WriteAfterEntry";
	if the address of I6_WriteGProperty is not zero, apply V to the address of I6_WriteGProperty and "WriteGProperty";
	if the address of I6_WriteLIST_OF_TY_GetItem is not zero, apply V to the address of I6_WriteLIST_OF_TY_GetItem and "WriteLIST_OF_TY_GetItem";
	if the address of I6_WriteListFrom is not zero, apply V to the address of I6_WriteListFrom and "WriteListFrom";
	if the address of I6_WriteListOfMarkedObjects is not zero, apply V to the address of I6_WriteListOfMarkedObjects and "WriteListOfMarkedObjects";
	if the address of I6_WriteListR is not zero, apply V to the address of I6_WriteListR and "WriteListR";
	if the address of I6_WriteMultiClassGroup is not zero, apply V to the address of I6_WriteMultiClassGroup and "WriteMultiClassGroup";
	if the address of I6_WriteSingleClassGroup is not zero, apply V to the address of I6_WriteSingleClassGroup and "WriteSingleClassGroup";
	if the address of I6_XAbstractSub is not zero, apply V to the address of I6_XAbstractSub and "XAbstractSub";
	if the address of I6_XObj is not zero, apply V to the address of I6_XObj and "XObj";
	if the address of I6_XPurloinSub is not zero, apply V to the address of I6_XPurloinSub and "XPurloinSub";
	if the address of I6_XTestMove is not zero, apply V to the address of I6_XTestMove and "XTestMove";
	if the address of I6_XTreeSub is not zero, apply V to the address of I6_XTreeSub and "XTreeSub";
	if the address of I6_YesOrNo is not zero, apply V to the address of I6_YesOrNo and "YesOrNo";
	if the address of I6_Z6_DrawStatusLine is not zero, apply V to the address of I6_Z6_DrawStatusLine and "Z6_DrawStatusLine";
	if the address of I6_Z6_MoveCursor is not zero, apply V to the address of I6_Z6_MoveCursor and "Z6_MoveCursor";
	if the address of I6_ZRegion is not zero, apply V to the address of I6_ZRegion and "ZRegion";
	if the address of I6_glk_buffer_to_lower_case_uni is not zero, apply V to the address of I6_glk_buffer_to_lower_case_uni and "glk_buffer_to_lower_case_uni";
	if the address of I6_glk_buffer_to_title_case_uni is not zero, apply V to the address of I6_glk_buffer_to_title_case_uni and "glk_buffer_to_title_case_uni";
	if the address of I6_glk_buffer_to_upper_case_uni is not zero, apply V to the address of I6_glk_buffer_to_upper_case_uni and "glk_buffer_to_upper_case_uni";
	if the address of I6_glk_cancel_char_event is not zero, apply V to the address of I6_glk_cancel_char_event and "glk_cancel_char_event";
	if the address of I6_glk_cancel_hyperlink_event is not zero, apply V to the address of I6_glk_cancel_hyperlink_event and "glk_cancel_hyperlink_event";
	if the address of I6_glk_cancel_line_event is not zero, apply V to the address of I6_glk_cancel_line_event and "glk_cancel_line_event";
	if the address of I6_glk_cancel_mouse_event is not zero, apply V to the address of I6_glk_cancel_mouse_event and "glk_cancel_mouse_event";
	if the address of I6_glk_char_to_lower is not zero, apply V to the address of I6_glk_char_to_lower and "glk_char_to_lower";
	if the address of I6_glk_char_to_upper is not zero, apply V to the address of I6_glk_char_to_upper and "glk_char_to_upper";
	if the address of I6_glk_exit is not zero, apply V to the address of I6_glk_exit and "glk_exit";
	if the address of I6_glk_fileref_create_by_name is not zero, apply V to the address of I6_glk_fileref_create_by_name and "glk_fileref_create_by_name";
	if the address of I6_glk_fileref_create_by_prompt is not zero, apply V to the address of I6_glk_fileref_create_by_prompt and "glk_fileref_create_by_prompt";
	if the address of I6_glk_fileref_create_from_fileref is not zero, apply V to the address of I6_glk_fileref_create_from_fileref and "glk_fileref_create_from_fileref";
	if the address of I6_glk_fileref_create_temp is not zero, apply V to the address of I6_glk_fileref_create_temp and "glk_fileref_create_temp";
	if the address of I6_glk_fileref_delete_file is not zero, apply V to the address of I6_glk_fileref_delete_file and "glk_fileref_delete_file";
	if the address of I6_glk_fileref_destroy is not zero, apply V to the address of I6_glk_fileref_destroy and "glk_fileref_destroy";
	if the address of I6_glk_fileref_does_file_exist is not zero, apply V to the address of I6_glk_fileref_does_file_exist and "glk_fileref_does_file_exist";
	if the address of I6_glk_fileref_get_rock is not zero, apply V to the address of I6_glk_fileref_get_rock and "glk_fileref_get_rock";
	if the address of I6_glk_fileref_iterate is not zero, apply V to the address of I6_glk_fileref_iterate and "glk_fileref_iterate";
	if the address of I6_glk_gestalt is not zero, apply V to the address of I6_glk_gestalt and "glk_gestalt";
	if the address of I6_glk_gestalt_ext is not zero, apply V to the address of I6_glk_gestalt_ext and "glk_gestalt_ext";
	if the address of I6_glk_get_buffer_stream is not zero, apply V to the address of I6_glk_get_buffer_stream and "glk_get_buffer_stream";
	if the address of I6_glk_get_buffer_stream_uni is not zero, apply V to the address of I6_glk_get_buffer_stream_uni and "glk_get_buffer_stream_uni";
	if the address of I6_glk_get_char_stream is not zero, apply V to the address of I6_glk_get_char_stream and "glk_get_char_stream";
	if the address of I6_glk_get_char_stream_uni is not zero, apply V to the address of I6_glk_get_char_stream_uni and "glk_get_char_stream_uni";
	if the address of I6_glk_get_line_stream is not zero, apply V to the address of I6_glk_get_line_stream and "glk_get_line_stream";
	if the address of I6_glk_get_line_stream_uni is not zero, apply V to the address of I6_glk_get_line_stream_uni and "glk_get_line_stream_uni";
	if the address of I6_glk_image_draw is not zero, apply V to the address of I6_glk_image_draw and "glk_image_draw";
	if the address of I6_glk_image_draw_scaled is not zero, apply V to the address of I6_glk_image_draw_scaled and "glk_image_draw_scaled";
	if the address of I6_glk_image_get_info is not zero, apply V to the address of I6_glk_image_get_info and "glk_image_get_info";
	if the address of I6_glk_put_buffer is not zero, apply V to the address of I6_glk_put_buffer and "glk_put_buffer";
	if the address of I6_glk_put_buffer_stream is not zero, apply V to the address of I6_glk_put_buffer_stream and "glk_put_buffer_stream";
	if the address of I6_glk_put_buffer_stream_uni is not zero, apply V to the address of I6_glk_put_buffer_stream_uni and "glk_put_buffer_stream_uni";
	if the address of I6_glk_put_buffer_uni is not zero, apply V to the address of I6_glk_put_buffer_uni and "glk_put_buffer_uni";
	if the address of I6_glk_put_char is not zero, apply V to the address of I6_glk_put_char and "glk_put_char";
	if the address of I6_glk_put_char_stream is not zero, apply V to the address of I6_glk_put_char_stream and "glk_put_char_stream";
	if the address of I6_glk_put_char_stream_uni is not zero, apply V to the address of I6_glk_put_char_stream_uni and "glk_put_char_stream_uni";
	if the address of I6_glk_put_char_uni is not zero, apply V to the address of I6_glk_put_char_uni and "glk_put_char_uni";
	if the address of I6_glk_put_string is not zero, apply V to the address of I6_glk_put_string and "glk_put_string";
	if the address of I6_glk_put_string_stream is not zero, apply V to the address of I6_glk_put_string_stream and "glk_put_string_stream";
	if the address of I6_glk_put_string_stream_uni is not zero, apply V to the address of I6_glk_put_string_stream_uni and "glk_put_string_stream_uni";
	if the address of I6_glk_put_string_uni is not zero, apply V to the address of I6_glk_put_string_uni and "glk_put_string_uni";
	if the address of I6_glk_request_char_event is not zero, apply V to the address of I6_glk_request_char_event and "glk_request_char_event";
	if the address of I6_glk_request_char_event_uni is not zero, apply V to the address of I6_glk_request_char_event_uni and "glk_request_char_event_uni";
	if the address of I6_glk_request_hyperlink_event is not zero, apply V to the address of I6_glk_request_hyperlink_event and "glk_request_hyperlink_event";
	if the address of I6_glk_request_line_event is not zero, apply V to the address of I6_glk_request_line_event and "glk_request_line_event";
	if the address of I6_glk_request_line_event_uni is not zero, apply V to the address of I6_glk_request_line_event_uni and "glk_request_line_event_uni";
	if the address of I6_glk_request_mouse_event is not zero, apply V to the address of I6_glk_request_mouse_event and "glk_request_mouse_event";
	if the address of I6_glk_request_timer_events is not zero, apply V to the address of I6_glk_request_timer_events and "glk_request_timer_events";
	if the address of I6_glk_schannel_create is not zero, apply V to the address of I6_glk_schannel_create and "glk_schannel_create";
	if the address of I6_glk_schannel_destroy is not zero, apply V to the address of I6_glk_schannel_destroy and "glk_schannel_destroy";
	if the address of I6_glk_schannel_get_rock is not zero, apply V to the address of I6_glk_schannel_get_rock and "glk_schannel_get_rock";
	if the address of I6_glk_schannel_iterate is not zero, apply V to the address of I6_glk_schannel_iterate and "glk_schannel_iterate";
	if the address of I6_glk_schannel_play is not zero, apply V to the address of I6_glk_schannel_play and "glk_schannel_play";
	if the address of I6_glk_schannel_play_ext is not zero, apply V to the address of I6_glk_schannel_play_ext and "glk_schannel_play_ext";
	if the address of I6_glk_schannel_set_volume is not zero, apply V to the address of I6_glk_schannel_set_volume and "glk_schannel_set_volume";
	if the address of I6_glk_schannel_stop is not zero, apply V to the address of I6_glk_schannel_stop and "glk_schannel_stop";
	if the address of I6_glk_select is not zero, apply V to the address of I6_glk_select and "glk_select";
	if the address of I6_glk_select_poll is not zero, apply V to the address of I6_glk_select_poll and "glk_select_poll";
	if the address of I6_glk_set_hyperlink is not zero, apply V to the address of I6_glk_set_hyperlink and "glk_set_hyperlink";
	if the address of I6_glk_set_hyperlink_stream is not zero, apply V to the address of I6_glk_set_hyperlink_stream and "glk_set_hyperlink_stream";
	if the address of I6_glk_set_interrupt_handler is not zero, apply V to the address of I6_glk_set_interrupt_handler and "glk_set_interrupt_handler";
	if the address of I6_glk_set_style is not zero, apply V to the address of I6_glk_set_style and "glk_set_style";
	if the address of I6_glk_set_style_stream is not zero, apply V to the address of I6_glk_set_style_stream and "glk_set_style_stream";
	if the address of I6_glk_set_window is not zero, apply V to the address of I6_glk_set_window and "glk_set_window";
	if the address of I6_glk_sound_load_hint is not zero, apply V to the address of I6_glk_sound_load_hint and "glk_sound_load_hint";
	if the address of I6_glk_stream_close is not zero, apply V to the address of I6_glk_stream_close and "glk_stream_close";
	if the address of I6_glk_stream_get_current is not zero, apply V to the address of I6_glk_stream_get_current and "glk_stream_get_current";
	if the address of I6_glk_stream_get_position is not zero, apply V to the address of I6_glk_stream_get_position and "glk_stream_get_position";
	if the address of I6_glk_stream_get_rock is not zero, apply V to the address of I6_glk_stream_get_rock and "glk_stream_get_rock";
	if the address of I6_glk_stream_iterate is not zero, apply V to the address of I6_glk_stream_iterate and "glk_stream_iterate";
	if the address of I6_glk_stream_open_file is not zero, apply V to the address of I6_glk_stream_open_file and "glk_stream_open_file";
	if the address of I6_glk_stream_open_file_uni is not zero, apply V to the address of I6_glk_stream_open_file_uni and "glk_stream_open_file_uni";
	if the address of I6_glk_stream_open_memory is not zero, apply V to the address of I6_glk_stream_open_memory and "glk_stream_open_memory";
	if the address of I6_glk_stream_open_memory_uni is not zero, apply V to the address of I6_glk_stream_open_memory_uni and "glk_stream_open_memory_uni";
	if the address of I6_glk_stream_set_current is not zero, apply V to the address of I6_glk_stream_set_current and "glk_stream_set_current";
	if the address of I6_glk_stream_set_position is not zero, apply V to the address of I6_glk_stream_set_position and "glk_stream_set_position";
	if the address of I6_glk_style_distinguish is not zero, apply V to the address of I6_glk_style_distinguish and "glk_style_distinguish";
	if the address of I6_glk_style_measure is not zero, apply V to the address of I6_glk_style_measure and "glk_style_measure";
	if the address of I6_glk_stylehint_clear is not zero, apply V to the address of I6_glk_stylehint_clear and "glk_stylehint_clear";
	if the address of I6_glk_stylehint_set is not zero, apply V to the address of I6_glk_stylehint_set and "glk_stylehint_set";
	if the address of I6_glk_tick is not zero, apply V to the address of I6_glk_tick and "glk_tick";
	if the address of I6_glk_window_clear is not zero, apply V to the address of I6_glk_window_clear and "glk_window_clear";
	if the address of I6_glk_window_close is not zero, apply V to the address of I6_glk_window_close and "glk_window_close";
	if the address of I6_glk_window_erase_rect is not zero, apply V to the address of I6_glk_window_erase_rect and "glk_window_erase_rect";
	if the address of I6_glk_window_fill_rect is not zero, apply V to the address of I6_glk_window_fill_rect and "glk_window_fill_rect";
	if the address of I6_glk_window_flow_break is not zero, apply V to the address of I6_glk_window_flow_break and "glk_window_flow_break";
	if the address of I6_glk_window_get_arrangement is not zero, apply V to the address of I6_glk_window_get_arrangement and "glk_window_get_arrangement";
	if the address of I6_glk_window_get_echo_stream is not zero, apply V to the address of I6_glk_window_get_echo_stream and "glk_window_get_echo_stream";
	if the address of I6_glk_window_get_parent is not zero, apply V to the address of I6_glk_window_get_parent and "glk_window_get_parent";
	if the address of I6_glk_window_get_rock is not zero, apply V to the address of I6_glk_window_get_rock and "glk_window_get_rock";
	if the address of I6_glk_window_get_root is not zero, apply V to the address of I6_glk_window_get_root and "glk_window_get_root";
	if the address of I6_glk_window_get_sibling is not zero, apply V to the address of I6_glk_window_get_sibling and "glk_window_get_sibling";
	if the address of I6_glk_window_get_size is not zero, apply V to the address of I6_glk_window_get_size and "glk_window_get_size";
	if the address of I6_glk_window_get_stream is not zero, apply V to the address of I6_glk_window_get_stream and "glk_window_get_stream";
	if the address of I6_glk_window_get_type is not zero, apply V to the address of I6_glk_window_get_type and "glk_window_get_type";
	if the address of I6_glk_window_iterate is not zero, apply V to the address of I6_glk_window_iterate and "glk_window_iterate";
	if the address of I6_glk_window_move_cursor is not zero, apply V to the address of I6_glk_window_move_cursor and "glk_window_move_cursor";
	if the address of I6_glk_window_open is not zero, apply V to the address of I6_glk_window_open and "glk_window_open";
	if the address of I6_glk_window_set_arrangement is not zero, apply V to the address of I6_glk_window_set_arrangement and "glk_window_set_arrangement";
	if the address of I6_glk_window_set_background_color is not zero, apply V to the address of I6_glk_window_set_background_color and "glk_window_set_background_color";
	if the address of I6_glk_window_set_echo_stream is not zero, apply V to the address of I6_glk_window_set_echo_stream and "glk_window_set_echo_stream";
	if the address of I6_loc is not zero, apply V to the address of I6_loc and "loc";
	if the address of I6_testcommandnoun is not zero, apply V to the address of I6_testcommandnoun and "testcommandnoun".

Book "Integration with Human-Friendly Function Names" (for use with Human-Friendly Function Names by Brady Garvin)

Chapter "Naming Veneer Routines"

A function-naming rule (this is the name veneer routines rule):
	traverse the veneer routines with the visitor naming each veneer routine.

Chapter "Naming Standard Template Routines"

A function-naming rule (this is the name standard template routines rule):
	traverse the standard template routines with the visitor naming each standard template routine.

I6 Routine Names ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

I6 Routine Names lets us find where the I6 veneer routines and the I6 routines
from the standard templates are stored in memory, which is something that
debugging extensions sometimes need to do under the hood.  It can also associate
these routines with human-friendly names so that debugging extensions can give
more informative output.

Details are in the following chapters.

Chapter: Usage

I6 Routine Names provides address-finding phrases for most of the common I6
routines, including the veneer routines.  For instance, we can write

	the address of I6_RT__Err

and get back a number like 298834.  (RT__Err is the actual routine name; the I6_
prefix is to avoid name clashes.)  If a routine is not defined, the address will
be zero.

Additionally, we can iterate over all such routines that have nonzero addresses.
Given a phrase taking a number, a truth state, and two texts, such as

	To report the address (A - a number) and override flag (F - a truth state) as meaning the veneer routine named (N - some text) with annotation (Z - some text) (this is reporting each veneer routine):
		say "Address [A]: [N][if F is true] (overridden)[end if] ([Z])."

we can write

	traverse the veneer routines with the visitor reporting each veneer routine;

and the phrase will be invoked once per veneer routine.  In this case, the output
should look something like

	Address 7637: Box__Routine (displaying a box quote).
	Address 131264: R_Process (triggering an action).
	Address 145977: DefArt (saying a lowercase definite article).
	Address 145613: InDefArt (saying a lowercase indefinite article).
	Address 146081: CDefArt (saying an uppercase definite article).
	Address 145787: CInDefArt (saying an uppercase indefinite article).
	Address 146271: PrintShortName (saying the short name of an I6 value).
	Address 144258: EnglishNumber (saying a number in words).
	Address 337011: Print__PName (overridden) (saying a property name).
	Address 337178: WV__Pr (overridden) (writing a value to a property).
	Address 337222: RV__Pr (overridden) (reading a value from a property).
	Address 337287: CA__Pr (overridden) (calling a property value).
	....

Similarly, if we define a phrase taking a number and a text:

	To report the address (A - a number) as meaning the standard template routine named (N - some text) (this is reporting each standard template routine):
		say "Address [A]: [N]."

Then we can write

	traverse the standard template routines with the visitor reporting each standard template routine;

to call the phrase once for each routine from the standard template.  (These
routines cannot be overridden the same way a veneer routine can, and they have
no annotations; hence the missing arguments.)  With this phrase, the output
should resemble

	Address 36290: AGL__M.
	Address 137388: AbandonActivity.
	Address 131660: AbbreviatedRoomDescription.
	Address 164976: ActRulebookFails.
	Address 164952: ActRulebookSucceeds.
	....

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

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

I6 Routine Names was prepared as part of the Glulx Runtime Instrumentation
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

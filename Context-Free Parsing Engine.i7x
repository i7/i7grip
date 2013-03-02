Version 1 of Context-Free Parsing Engine (for Glulx only) by Brady Garvin begins here.

"A library for parsing a generic sequence according to a grammar in Backus-Naur form."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Text by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Object Pools by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2012 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

[For each of the kinds defined by Context-Free Parsing Engine you will see a sentence like

	A parseme is an invalid parseme.

This bewildering statement actually sets up parsemes as a qualitative value with default value the parseme at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on parsemes.]

[The convenience phrases can build some lengthy expressions.]
Use MAX_EXPRESSION_NODES of 4096.

Chapter "Use Options"

Use a context-free parseme hash table size of at least 311 translates as (- Constant CFPE_PARSEME_HASH_SIZE={N}; -).
Use a context-free production hash table size of at least 311 translates as (- Constant CFPE_PRODUCTION_HASH_SIZE={N}; -).

Use a parse step preallocation of at least 2048 translates as (- Constant CFPE_STEP_PREALLOC={N}; -).
Use a parse goal preallocation of at least 1024 translates as (- Constant CFPE_GOAL_PREALLOC={N}; -).
Use a parse tree vertex preallocation of at least 2048 translates as (- Constant CFPE_VERTEX_PREALLOC={N}; -).

To decide what number is the context-free parseme hash table size: (- CFPE_PARSEME_HASH_SIZE -).
To decide what number is the context-free production hash table size: (- CFPE_PRODUCTION_HASH_SIZE -).

To decide what number is the parse step preallocation: (- CFPE_STEP_PREALLOC -).
To decide what number is the parse goal preallocation: (- CFPE_GOAL_PREALLOC -).
To decide what number is the parse tree vertex preallocation: (- CFPE_VERTEX_PREALLOC -).

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at adding parsemes to a parser already in normal form:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I tried to add parsemes to a parser, but it had been already put in normal form, which ought not happen until all parsemes and productions have been added.[terminating the story]".

To fail at adding productions to a parser already in normal form:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I tried to add productions to a parser, but it had been already put in normal form, which ought not happen until all parsemes and productions have been added.[terminating the story]".

To fail at putting a parser into normal form twice:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I tried to put a parser into normal form, but that had already been done, suggesting a bug.[terminating the story]".

To fail at normalizing an absurd grammar:
	say "[low-level runtime failure in]Context-Free Parsing Engine[with explanation]I was given a grammar in which the empty text could be understood as a particular parseme, as could several copies of the parseme itself.  This is a problematic edge case that I don't handle, mostly to keep things simple, but also because it is almost always a bug.[terminating the story]".

To fail at initializing a parser that is not in normal form:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I tried parse with a parser that hadn't yet been put in normal form.[terminating the story]".

To fail at initializing a parser with a foreign parseme:
	say "[low-level runtime failure in]Context-Free Parsing Engine[with explanation]I was asked to parse for a parseme in a parser where it doesn't belong.[terminating the story]".

To fail at reinitializing a parser mid-parse:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I tried to reinitialize a parser mid-parse, which should never happen.[terminating the story]".

To fail at locating a doppelganger parse tree vertex:
	say "[low-level runtime failure in]Context-Free Parsing Engine[with explanation]I cloned a parse tree and then went to find the doppelganger of a vertex from the original tree.  But there was no such vertex, which means that the clone must have failed in a way that is only possible if the original tree's internal state has been corrupted.[terminating the story]".

To fail at making a mismatched unsubstitution:
	say "[low-level runtime failure in]Context-Free Parsing Engine[with explanation]I was rewriting a parse tree after finding a match, but my list of rewrites contained a nonsense instruction to replace one vertex with two unrelated ones.  Either the tree or the list must have been corrupted.[terminating the story]".

To fail at unrotating from a nonrotation parseme:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I was rewriting a parse tree after finding a match, but my list of rewrites contained a instruction that led me to try rotating a wrongly shaped or out-of-bounds region.  Either the tree or the list must have been corrupted.[terminating the story]".

To fail at expanding an already expanded parse tree vertex:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I tried to expand a vertex in one of the candidate parse trees, but the vertex was already expanded, a sure sign that I'm confused.[terminating the story]".

To fail at rewriting trivial recursion:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I found a production that understand a parseme as itself, even after the code to prune such productions.  Either my data structures have been tampered with or I am confused.[terminating the story]".

To fail at finding a parse step in a consistent state:
	say "[low-level runtime failure in]Context Free Parsing Engine[with explanation]I found a parse step that gave me a sequence of expansions to use for a production, but that sequence didn't match the production's length.  I must have created that parse step wrongly, or else it has been corrupted.[terminating the story]".

Book "Data Structures"

Part "Grammar Structures"

Chapter "Parsemes"

[``Parseme'' (pronounced like ``lexeme'') is another, rarer term for a symbol (i.e., a terminal or a nonterminal) in a BNF grammar.  It seemed like something unlikely to cause name clashes.]

Section "The Parseme Kind"

A parseme is a kind of value.
A parseme is an invalid parseme.  [See the note in the book "Extension Information."]
The specification of a parseme is "Parsemes are Context-Free Parsing Engine's analog to understand tokens.  Some match literal input (these are called terminals), while others match sequences of other parsemes (nonterminals).  Unlike Inform understand tokens, parsemes can be recursive: it is possible for '[parseme A][parseme B]' to be understood as '[parseme A]', for instance."

Section "Parseme Constants" - unindexed

To decide what parseme is a null parseme: (- 0 -).

Section "Parseme Adjectives" - unindexed

Definition: a parseme is null if it is a null parseme.

Section "The Parseme Structure" - unindexed

[Layout:
	4 bytes for the human-friendly name
	4 bytes for the owning context-free parser
	4 bytes for the parsing phrase
	4 bytes for the production linked list
	4 bytes for the original parseme (null if none)
	4 bytes for the parse attempt linked list
	4 bytes for the parse step linked list]
[Some parsemes are split into two during grammar normalization.  One has roughly the same meaning as the original, and the other converts left recursion into right recursion (a ``rotation parseme'').  The original parseme field is set in the latter so that we can replace it with the former when we recover the parse tree.]
[The parse attempt linked list contains every beginning index at which we have tried to match this parseme.]
[The parse step linked list maps beginning indices to zero or more parse steps, each of which matches this parseme at that beginning index.]

To decide what number is the size in memory of a parseme: (- 28 -).

Section "Private Parseme Construction and Destruction" - unindexed

To decide what text is the name for a rotation for (A - a parseme):
	let the human-friendly name be the human-friendly name of A;
	let the length be 13 plus the length of the human-friendly name;
	let the result be a new uninitialized permanent synthetic text with length the length characters;
	overwrite the synthetic text the result with the text printed when we say "rotation for [the human-friendly name]";
	decide on the result.

To decide what parseme is a new rotation parseme for (A - a parseme):
	let the result be a permanent memory allocation of the size in memory of a parseme bytes converted to a parseme;
	zero the size in memory of a parseme bytes at address result converted to a number;
	let the owner be the owner of A;
	write the human-friendly name the name for a rotation for A to the result;
	write the owner the owner to the result;
	write the parsing phrase the standard nonterminal parsing phrase to the result;
	write the original parseme A to the result;
	push the key the result onto the parseme linked list of the owner;
	decide on the result.

Section "Public Parseme Construction"

To decide what parseme is a new terminal in (A - a context-free parser) named (T - some text) and parsed by (P - a phrase (parseme, number) -> nothing):
	check that A is not in normal form or else fail at adding parsemes to a parser already in normal form;
	let the result be a permanent memory allocation of the size in memory of a parseme bytes converted to a parseme;
	zero the size in memory of a parseme bytes at address result converted to a number;
	write the human-friendly name T to the result;
	write the owner A to the result;
	write the parsing phrase P to the result;
	push the key the result onto the parseme linked list of A;
	decide on the result.

To decide what parseme is a new nonterminal in (A - a context-free parser) named (T - some text) (this is allocating a new nonterminal):
	decide on a new terminal in A named T and parsed by the standard nonterminal parsing phrase.

Section "Private Parseme Accessors and Mutators" - unindexed

To write the human-friendly name (X - some text) to (A - a parseme): (- llo_setInt({A},{X}); -).

To write the owner (X - a context-free parser) to (A - a parseme): (- llo_setField({A},1,{X}); -).

To decide what phrase (parseme, number) -> nothing is the parsing phrase of (A - a parseme): (- llo_getField({A},2) -).
To write the parsing phrase (X - a phrase (parseme, number) -> nothing) to (A - a parseme): (- llo_setField({A},2,{X}); -).

To decide what permanent linked list is the production linked list of (A - a parseme): (- ({A}-->3) -).
To write the production linked list (X - a permanent linked list) to (A - a parseme): (- llo_setField({A},3,{X}); -).

To decide what parseme is the original parseme of (A - a parseme): (- llo_getField({A},4) -).
To write the original parseme (X - a parseme) to (A - a parseme): (- llo_setField({A},4,{X}); -).

To decide what linked list is the parse attempt linked list of (A - a parseme): (- ({A}-->5) -).
To write the parse attempt linked list (X - a linked list) to (A - a parseme): (- llo_setField({A},5,{X}); -).

To decide what linked list is the parse step linked list of (A - a parseme): (- ({A}-->6) -).
To write the parse step linked list (X - a linked list) to (A - a parseme): (- llo_setField({A},6,{X}); -).

Section "Public Parseme Accessors and Mutators"

To decide what text is the human-friendly name of (A - a parseme): (- llo_getInt({A}) -).

To decide what context-free parser is the owner of (A - a parseme): (- llo_getField({A},1) -).

To decide whether (A - a parseme) is a terminal:
	decide on whether or not the parsing phrase of A is not the standard nonterminal parsing phrase.
To decide whether (A - a parseme) is a nonterminal:
	decide on whether or not the parsing phrase of A is the standard nonterminal parsing phrase.

Section "Saying and Debugging Parsemes"

To say (A - a parseme):
	say "(parseme [A converted to a number in hexadecimal]: [the human-friendly name of A])".

To say the productions of (A - a parseme):
	if the production linked list of A is empty:
		say "    (no productions)[line break]";
	otherwise:
		repeat with the production running through the production keys of the production linked list of A:
			say "    [the production][line break]".

Chapter "Productions"

Section "The Production Kind"

A production is a kind of value.
A production is an invalid production.  [See the note in the book "Extension Information."]
The specification of a production is "Productions are the analog to understand lines in Context-Free Parsing Engine; each one represents a way that a sequence of parsemes can be understood as another parseme."

Section "Production Constants" - unindexed

To decide what production is a null production: (- 0 -).

Section "Production Adjectives" - unindexed

Definition: a production is null if it is a null production.

Section "The Production Structure" - unindexed

[Layout:
	4 bytes for the left-hand parseme
	4 bytes for the right-hand parseme linked list
	4 bytes for the right-hand parseme linked list tail
	4 bytes for the inner production (null if none)
	4 bytes for the outer production (null if none)
	4 bytes for the substitution size (zero if none, but possibility zero anyway)]
[During grammar normalization, some extra productions are created by substituting one production (the inner production) in for the first right-hand parseme of another (the outer production).  We track both of the original productions and the number of parsemes substituted so that we can undo things in tree recovery.]

To decide what number is the size in memory of a production: (- 24 -).

Section "Helper Functions for Production Construction and Destruction" - unindexed

To decide what permanent linked list is (A - a permanent linked list) without its first vertex:
	if A is empty:
		decide on an empty permanent linked list;
	let the result be the link of A converted to a linked list vertex;
	decide on the result converted to a permanent linked list.

Section "Private Production Construction and Destruction" - unindexed

[With this constructor we are lazy and do *not* ascribe the new production to its left-hand parseme.  This construction is really only useful for normalization, which is going to redo the production linked list anyway.]
To decide what production is a new production with (I - a production) substituted in for the first right-hand parseme of (O - a production):
	let the result be a permanent memory allocation of the size in memory of a production bytes converted to a production;
	zero the size in memory of a production bytes at address result converted to a number;
	write the left-hand parseme the left-hand parseme of O to the result;
	write the inner production I to the result;
	write the outer production O to the result;
	let the parseme linked list be an empty permanent linked list;
	let the parseme linked list tail be an empty permanent linked list's tail;
	let the substitution size be zero;
	repeat with the parseme running through the parseme keys of the right-hand parseme linked list of I:
		enqueue the key the parseme in the parseme linked list through the parseme linked list tail;
		increment the substitution size;
	repeat with the parseme running through the parseme keys of the right-hand parseme linked list of O without its first vertex:
		enqueue the key the parseme in the parseme linked list through the parseme linked list tail;
	write the right-hand parseme linked list the parseme linked list to the result;
	write the right-hand parseme linked list tail the parseme linked list tail to the result;
	write the substitution size the substitution size to the result;
	decide on the result.

Section "Public Production Construction and Destruction"

To decide what production is a new production for (S - a parseme):
	always check that the owner of S is not in normal form or else fail at adding productions to a parser already in normal form;
	let the result be a permanent memory allocation of the size in memory of a production bytes converted to a production;
	zero the size in memory of a production bytes at address result converted to a number;
	write the left-hand parseme S to the result;
	push the key the result onto the production linked list of S;
	decide on the result.

Section "Private Production Accessors and Mutators" - unindexed

To decide what parseme is the left-hand parseme of (A - a production): (- llo_getInt({A}) -).
To write the left-hand parseme (X - a parseme) to (A - a production): (- llo_setInt({A},{X}); -).

To decide what permanent linked list is the right-hand parseme linked list of (A - a production): (- ({A}-->1) -).
To write the right-hand parseme linked list (X - a permanent linked list) to (A - a production): (- llo_setField({A},1,{X}); -).

To decide what permanent linked list tail is the right-hand parseme linked list tail of (A - a production): (- ({A}-->2) -).
To write the right-hand parseme linked list tail (X - a permanent linked list tail) to (A - a production): (- llo_setField({A},2,{X}); -).

To decide what production is the inner production of (A - a production): (- llo_getField({A},3) -).
To write the inner production (X - a production) to (A - a production): (- llo_setField({A},3,{X}); -).

To decide what production is the outer production of (A - a production): (- llo_getField({A},4) -).
To write the outer production (X - a production) to (A - a production): (- llo_setField({A},4,{X}); -).

To decide what number is the substitution size of (A - a production): (- llo_getField({A},5) -).
To write the substitution size (X - a number) to (A - a production): (- llo_setField({A},5,{X}); -).

To decide what parseme is the first right-hand parseme of (P - a production):
	let the linked list vertex be the right-hand parseme linked list of P converted to a permanent linked list vertex;
	if the linked list vertex is null:
		decide on a null parseme;
	decide on the parseme key of the linked list vertex.

Section "Public Production Accessors and Mutators"

To decide what context-free parser is the owner of (A - a production):
	decide on the owner of the left-hand parseme of A.

To prepend (S - a parseme) to (A - a production):
	[This is somewhat less than ideal: we depend on the internals of linked lists.  If we have to do this anywhere else, it would be better to create a phrase in Low-Level Linked Lists.]
	push the key S onto the right-hand parseme linked list of A;
	if the right-hand parseme linked list of A is unit:
		let the tail be the right-hand parseme linked list of A converted to a permanent linked list tail;
		write the right-hand parseme linked list tail the tail to A.

To append (S - a parseme) to (A - a production):
	enqueue the key S in the right-hand parseme linked list of A through the right-hand parseme linked list tail of A.

Section "Saying and Debugging Productions"

To say (A - a production):
	if A is an invalid production:
		say "<invalid production>";
	otherwise:
		say "[the left-hand parseme of A] ->";
		if the right-hand parseme linked list of A is empty:
			say " ε";
		otherwise:
			repeat with the parseme running through the parseme keys of the right-hand parseme linked list of A:
				say " [the parseme]".

Part "Parsing Structures"

Chapter "Parse Tree Rewrites" - unindexed

Section "The Parse Tree Rewrite Kind" - unindexed

A parse tree rewrite is a kind of value.
A parse tree rewrite is an invalid parse tree rewrite.  [See the note in the book "Extension Information."]
The specification of a parse tree rewrite is "Context-Free Parsing Engine internally rewrites parsemes and productions in a form that simplifies left-to-right parsing.  When the parse is complete, it has to undo the rewriting so that the parse tree corresponds to the original grammar.  A parse tree rewrite is the internal data structure used to remember these rewrites in the interim."

Section "The Parse Tree Rewrite Structure" - unindexed

[Layout:
	4 bytes for the rewriting phrase
	4 bytes for the production]
[The rewriting phrase should take a production, and returning nothing.  The standard phrases are defined later in this file.]

To decide what number is the size in memory of a parse tree rewrite: (- 8 -).

Section "Parse Tree Rewrite Construction and Destruction" - unindexed

To decide what parse tree rewrite is a new tree unsubstitution rewrite for (P - a production):
	let the result be a permanent memory allocation of the size in memory of a parse tree rewrite bytes converted to a parse tree rewrite;
	write the rewriting phrase unsubstituting a production to the result;
	write the production P to the result;
	decide on the result.

To decide what parse tree rewrite is a new tree rotation rewrite for (P - a production):
	let the result be a permanent memory allocation of the size in memory of a parse tree rewrite bytes converted to a parse tree rewrite;
	write the rewriting phrase rotating a production to the result;
	write the production P to the result;
	decide on the result.

Section "Parse Tree Rewrite Accessors and Mutators" - unindexed

To decide what phrase production -> nothing is the rewriting phrase of (A - a parse tree rewrite): (- llo_getInt({A}) -).
To write the rewriting phrase (X - a phrase production -> nothing) to (A - a parse tree rewrite): (- llo_setInt({A},{X}); -).

To decide what production is the production of (A - a parse tree rewrite): (- llo_getField({A},1) -).
To write the production (X - a production) to (A - a parse tree rewrite): (- llo_setField({A},1,{X}); -).

Section "Saying and Debugging Parse Tree Rewrites" - unindexed

To say (A - a parse tree rewrite):
	let the rewriting phrase be the rewriting phrase of A;
	say "[if the rewriting phrase is unsubstituting a production]unsubstitution of[otherwise if the rewriting phrase is rotating a production]rotation of[otherwise]custom operation ([the rewriting phrase]) on[end if] [the production of A]".

Chapter "Parse Steps" - unindexed

A parse step is a kind of value.
A parse step is an invalid parse step.  [See the note in the book "Extension Information."]
The specification of a parse step is "A parse step represents mostly the same information as a parse tree vertex, except that parse steps are shared between trees, and possibly even separate branches of the same tree.  They therefore do not have unique parents, and may even end up with zero parents if none is ever synthesized."

Section "The Parse Step Structure" - unindexed

[Layout:
	4 bytes for the production
	4 bytes for the children linked list
	4 bytes for the end lexeme index]
[Any code that looks up parse steps already knows the beginning index, so there's no point in storing it.]

To decide what number is the size in memory of a parse step: (- 12 -).

Section "Helper Variables and Functions for Parse Step Construction and Destruction" - unindexed

The parse step object pool is an object pool that varies.

To ensure that the parse step object pool is initialized:
	if the parse step object pool is an invalid object pool:
		now the parse step object pool is a new permanent object pool with the parse step preallocation objects of size the size in memory of a parse step bytes.

Section "Parse Step Construction and Destruction" - unindexed

To decide what parse step is a new parse step ending at lexeme index (I - a number):
	let the result be a memory allocation from the parse step object pool converted to a parse step;
	zero the size in memory of a parse step bytes at address result converted to a number;
	write the end lexeme index I to the result;
	decide on the result.

To decide what parse step is a new parse step for (P - a production) ending at lexeme index (I - a number):
	let the result be a new parse step ending at lexeme index I;
	write the production P to the result;
	decide on the result.

Section "Parse Step Accessors and Mutators" - unindexed

To decide what production is the production of (A - a parse step): (- llo_getInt({A}) -).
To write the production (X - a production) to (A - a parse step): (- llo_setInt({A},{X}); -).

To decide what linked list is the children linked list of (A - a parse step): (- ({A}-->1) -).
To write the children linked list (X - a linked list) to (A - a parse step): (- llo_setField({A},1,{X}); -).

To decide what number is the end lexeme index of (A - a parse step): (- llo_getField({A},2) -).
To write the end lexeme index (X - a number) to (A - a parse step): (- llo_setField({A},2,{X}); -).

Part "Mixed-Purpose Data Structures"

Chapter "Parse Tree Vertices"

Section "The Parse Tree Vertex Kind"

A parse tree vertex is a kind of value.  The plural of parse tree vertex is parse tree vertices.
A parse tree vertex is an invalid parse tree vertex.  [See the note in the book "Extension Information."]
The specification of a parse tree vertex is "A parse tree vertex represents all of the input matched by a single occurrence of a parseme.  For instance, if a parseme X matches two occurrences of the parseme Y, and the parseme Y matches the literal text 'z', a parse of the text 'zz' would have three parse tree vertices: one for each time Y matched a 'z' and another for X matching the whole input.  We think of these vertices as organized in a family tree where children vertices constitute their parents, and when we describe adjacent siblings, we say that the vertex that matched earlier input is on the left.  Thus, Y has two vertices, one on the left and one on the right, and their parent is X's vertex."

Section "Parse Tree Vertex Constants"

To decide what parse tree vertex is a null parse tree vertex: (- 0 -).

Section "Parse Tree Vertex Adjectives"

Definition: a parse tree vertex is null if it is a null parse tree vertex.

Section "The Parse Tree Vertex Structure" - unindexed

[Layout:
	4 bytes for the parseme
	4 bytes for the production (null if none)
	4 bytes for the parent (null if none)
	4 bytes for the first child (null if none)
	4 bytes for the last child (null if none)
	4 bytes for the left sibling (null if none)
	4 bytes for the right sibling (null if none)
	4 bytes for the beginning lexeme index
	4 bytes for the end lexeme index]

To decide what number is the size in memory of a parse tree vertex: (- 36 -).

Section "Helper Variables and Functions for Parse Tree Vertex Construction and Destruction" - unindexed

The parse tree vertex object pool is an object pool that varies.

To ensure that the parse tree vertex object pool is initialized:
	if the parse tree vertex object pool is an invalid object pool:
		now the parse tree vertex object pool is a new permanent object pool with the parse tree vertex preallocation objects of size the size in memory of a parse tree vertex bytes.

The doppelganger parse tree vertex is a parse tree vertex that varies.

To decide what parse tree vertex is a clone of (A - a parse tree vertex) with the doppelganger noted for (B - a parse tree vertex):
	let the result be a memory allocation from the parse tree vertex object pool converted to a parse tree vertex;
	if A is B:
		now the doppelganger parse tree vertex is the result;
	copy the size in memory of a parse tree vertex bytes from address (A converted to a number) to address (the result converted to a number);
	let the first child be the first child of A;
	unless the first child is null:
		let the cloned child be a clone of the first child with the doppelganger noted for B;
		write the first child the cloned child to the result;
		write the parent the result to the cloned child;
		repeat with the later child running through the right siblings of the first child:
			let the cloned child's sibling be the cloned child;
			now the cloned child is a clone of the later child with the doppelganger noted for B;
			write the left sibling the cloned child's sibling to the cloned child;
			write the right sibling the cloned child to the cloned child's sibling;
			write the parent the result to the cloned child;
		write the last child the cloned child to the result;	
	decide on the result.

Section "Private Parse Tree Vertex Construction and Destruction" - unindexed

To decide what parse tree vertex is a new parse tree root for (S - a parseme):
	let the result be a memory allocation from the parse tree vertex object pool converted to a parse tree vertex;
	zero the size in memory of a parse tree vertex bytes at address result converted to a number;
	write the parseme S to the result;
	decide on the result.

To decide what parse tree vertex is a new parse tree vertex for (S - a parseme) with the parent (A - a parse tree vertex), placed on the left:
	let the result be a memory allocation from the parse tree vertex object pool converted to a parse tree vertex;
	zero the size in memory of a parse tree vertex bytes at address result converted to a number;
	write the parseme S to the result;
	write the parent A to the result;
	if placed on the left:
		let the sibling be the first child of A;
		if the sibling is null:
			write the last child the result to A;
		otherwise:
			write the left sibling the result to the sibling;
			write the right sibling the sibling to the result;
		write the first child the result to A;
	otherwise:
		let the sibling be the last child of A;
		if the sibling is null:
			write the first child the result to A;
		otherwise:
			write the left sibling the sibling to the result;
			write the right sibling the result to the sibling;
		write the last child the result to A;
	decide on the result.

To delete (A - a parse tree vertex) but not its descendants:
	free the memory allocation at address (A converted to a number) to the parse tree vertex object pool.

Section "Public Parse Tree Vertex Construction and Destruction"

To decide what parse tree vertex is the parse tree vertex corresponding to (A - a parse tree vertex) in a new clone of its tree:
	let the root be the root of A;
	now the doppelganger parse tree vertex is a null parse tree vertex;
	let the cloned root be a clone of the root with the doppelganger noted for A;
	always check that the doppelganger parse tree vertex is not null or else fail at locating a doppelganger parse tree vertex;
	decide on the doppelganger parse tree vertex.

To delete (A - a parse tree vertex) and its descendants (this is deleting a parse tree):
	let the child be the first child of A;
	while the child is not null:
		let the sibling be the right sibling of the child;
		delete the child and its descendants;
		now the child is the sibling;
	free the memory allocation at address (A converted to a number) to the parse tree vertex object pool.

Section "Private Parse Tree Vertex Mutators" - unindexed

To write the parseme (X - a parseme) to (A - a parse tree vertex): (- llo_setInt({A},{X}); -).

To write the production (X - a production) to (A - a parse tree vertex): (- llo_setField({A},1,{X}); -).

To write the parent (X - a parse tree vertex) to (A - a parse tree vertex): (- llo_setField({A},2,{X}); -).

To write the first child (X - a parse tree vertex) to (A - a parse tree vertex): (- llo_setField({A},3,{X}); -).

To write the last child (X - a parse tree vertex) to (A - a parse tree vertex): (- llo_setField({A},4,{X}); -).

To write the left sibling (X - a parse tree vertex) to (A - a parse tree vertex): (- llo_setField({A},5,{X}); -).

To write the right sibling (X - a parse tree vertex) to (A - a parse tree vertex): (- llo_setField({A},6,{X}); -).

To write the beginning lexeme index (X - a number) to (A - a parse tree vertex): (- llo_setField({A},7,{X}); -).

Section "Public Parse Tree Vertex Accessors"

To decide what parseme is the parseme of (A - a parse tree vertex): (- llo_getInt({A}) -).

To decide what production is the production of (A - a parse tree vertex): (- llo_getField({A},1) -).

To decide whether (A - a parse tree vertex) is a root: (- (~~llo_getField({A},2)) -).
To decide whether (A - a parse tree vertex) is not a root: (- llo_getField({A},2) -).
To decide what parse tree vertex is the parent of (A - a parse tree vertex): (- llo_getField({A},2) -).

To decide what parse tree vertex is the first child of (A - a parse tree vertex): (- llo_getField({A},3) -).

To decide what parse tree vertex is the last child of (A - a parse tree vertex): (- llo_getField({A},4) -).

To decide what parse tree vertex is the left sibling of (A - a parse tree vertex): (- llo_getField({A},5) -).

To decide what parse tree vertex is the right sibling of (A - a parse tree vertex): (- llo_getField({A},6) -).

To decide what number is the beginning lexeme index of (A - a parse tree vertex): (- llo_getField({A},7) -).

To decide what number is the end lexeme index of (A - a parse tree vertex): (- llo_getField({A},8) -).
To write the end lexeme index (X - a number) to (A - a parse tree vertex): (- llo_setField({A},8,{X}); -).

To decide what parse tree vertex is the root of (A - a parse tree vertex):
	let the result be A;
	while the result is not a root:
		now the result is the parent of the result;
	decide on the result.

To decide what context-free parser is the owner of (A - a parse tree vertex):
	decide on the owner of the parseme of A.

Section "Loops over Parse Tree Vertices"

To repeat with (I - a nonexisting parse tree vertex variable) running through the children of (A - a parse tree vertex) begin -- end: (-
	for({I}=llo_getField({A},3):{I}:{I}=llo_getField({I},6))
-).

To repeat with (I - a nonexisting parse tree vertex variable) running through the right siblings of (A - a parse tree vertex) begin -- end: (-
	for({I}=llo_getField({A},6):{I}:{I}=llo_getField({I},6))
-).

To decide what parse tree vertex is the first match for (S - a parseme) among the children of (V - a parse tree vertex):
	repeat with the child running through the children of V:
		if the parseme of the child is S:
			decide on the child;
	decide on an invalid parse tree vertex.

To decide what parse tree vertex is the next match for (S - a parseme) after the child (V - a parse tree vertex):
	repeat with the child running through the right siblings of V:
		if the parseme of the child is S:
			decide on the child;
	decide on an invalid parse tree vertex.

To decide whether (S - a parseme) appears among the children of (V - a parse tree vertex):
	repeat with the child running through the children of V:
		if the parseme of the child is S:
			decide yes;
	decide no.

Section "Saying and Debugging Parse Tree Vertices"

To say (A - a parse tree vertex) (this is saying a parse tree vertex):
	let the beginning lexeme index be the beginning lexeme index of A;
	let the end lexeme index be the end lexeme index of A;
	let the length be the end lexeme index minus the beginning lexeme index;
	if the length is less than zero:
		now the length is zero;
	say "[the parseme of A][if the end lexeme index is not zero] [bracket][the beginning lexeme index]..[no line break][the end lexeme index])[end if]";
	unless the first child of A is null:
		say " {";
		repeat with the child running through the children of A:
			say " ";
			apply saying a parse tree vertex to the child;
		say " }".

Chapter "Context-Free Parsers"

Section "The Context-Free Parser Kind"

A context-free parser is a kind of value.
A context-free parser is an invalid context-free parser.  [See the note in the book "Extension Information."]
The specification of a context-free parser is "A context-free parser matches an input (usually, but not necessarily text) against parsemes, which are like Inform's understand tokens."

Section "The Context-Free Parser Structure" - unindexed

[Layout:
	4 bytes for the normalized flag
	4 bytes for the parseme linked list
	4 bytes for the parse tree rewrite linked list
	4 bytes for the content
	4 bytes for the lexeme count]

To decide what number is the size in memory of a context-free parser: (- 20 -).

Section "Context-Free Parser Construction and Destruction"

To decide what context-free parser is a new context-free parser:
	ensure that the parse step object pool is initialized;
	ensure that the parse tree vertex object pool is initialized;
	let the result be a permanent memory allocation of the size in memory of a context-free parser bytes converted to a context-free parser;
	zero the size in memory of a context-free parser bytes at address result converted to a number;
	decide on the result.

Section "Private Context-Free Parser Accessors and Mutators" - unindexed

To mark (A - a context-free parser) as being in normal form: (- llo_setInt({A},1); -).

To decide what permanent linked list is the parseme linked list of (A - a context-free parser): (- ({A}-->1) -).
To write the parseme linked list (X - a permanent linked list) to (A - a context-free parser): (- llo_setField({A},1,{X}); -).

To decide what permanent linked list is the parse tree rewrite linked list of (A - a context-free parser): (- ({A}-->2) -).
To write the parse tree rewrite linked list (X - a permanent linked list) to (A - a context-free parser): (- llo_setField({A},2,{X}); -).

Section "Public Context-Free Parser Accessors and Mutators"

To decide whether (A - a context-free parser) is in normal form: (- llo_getInt({A}) -).
To decide whether (A - a context-free parser) is not in normal form: (- (~~llo_getInt({A})) -).

To decide what K is the (D - a description of values of kind K) content of (A - a context-free parser): (- ({A}-->3) -).

To decide what number is the lexeme count of (A - a context-free parser): (- llo_getField({A},4) -).

To write the content (X - a value of kind K) and the lexeme count (N - a number) to (A - a context-free parser): (- llo_setField({A},3,{X});llo_setField({A},4,{N}); -).

Section "Saying and Debugging Context-Free Parsers"

To say (A - a context-free parser):
	say "Parser[if A is in normal form] in normal form[end if]:[line break]";
	repeat with the parseme running through the parseme keys of the parseme linked list of A:
		say "  [the parseme][line break][the productions of the parseme]";
	repeat with the parse tree rewrite running through the parse tree rewrite keys of the parse tree rewrite linked list of A:
		say "  Rewrite: [the parse tree rewrite][line break]".

To say the matches made by (A - a context-free parser):
	say "Matches made by a parser[if A is in normal form] in normal form[end if]:[line break]";
	repeat with the parseme running through the parseme keys of the parseme linked list of A:
		if the parse step linked list of the parseme is not empty:
			say "  [the parseme]";
			repeat with the parse step linked list vertex running through the parse step linked list of the parseme:
				let the current parse step be the parse step value of the parse step linked list vertex;
				say " [bracket][the number key of the parse step linked list vertex]..[no line break][the end lexeme index of the current parse step])";
			say "[line break]".

Book "Relations and Verbs"

Chapter "Having a Parseme"

Having a parseme relates a parse tree vertex (called V) to a parseme (called S) when S is the parseme of V.
The verb to have the parseme (it has the parseme, they have the parseme, it had the parseme, it is a parseme had by, it is having the parseme) implies the having a parseme relation.

Book "Parser Lifecycle"

Chapter "Normalization"

Section "Purging Indirect Cycles" - unindexed

To decide what permanent linked list is the list of left-recursive productions that remain after purging productions that immediately produce keys of (H - a hash table) from (S - a parseme) of (A - a context-free parser):
	let the production worklist be the production linked list of S;
	let the composite production worklist be an empty permanent linked list;
	let the non-left-recursive production linked list be an empty permanent linked list;
	let the left-recursive production linked list be an empty permanent linked list;
	while the production worklist is not empty:
		repeat with the outer production running through the production keys of the production worklist:
			let the first right-hand parseme be the first right-hand parseme of the outer production;
			if the first right-hand parseme is S:
				if the right-hand parseme linked list of the outer production is not unit:
					[Categorize the production as left-recursive.]
					push the key the outer production onto the left-recursive production linked list;
				[Otherwise, discard the production as redundant.]
			otherwise if H contains the key the first right-hand parseme:
				[Expand the production by substituting in previously purged productions.]
				repeat with the inner production running through the production keys of the production linked list of the first right-hand parseme:
					let the composite production be a new production with the inner production substituted in for the first right-hand parseme of the outer production;
					push the key the composite production onto the composite production worklist;
					push the key a new tree unsubstitution rewrite for the composite production onto the parse tree rewrite linked list of A;
			otherwise:
				[Categorize the production as non-left-recursive.]
				push the key the outer production onto the non-left-recursive production linked list;
		[Throw away the production worklist.]
		now the production worklist is the composite production worklist;
		now the composite production worklist is an empty permanent linked list;
	write the production linked list the non-left-recursive production linked list to S;
	decide on the left-recursive production linked list.

Section "Purging All Cycles" - unindexed

To put (S - a parseme) of (A - a context-free parser) into normal form with the seen parsemes being the keys of (H - a hash table):
	let the left-recursive production linked list be the list of left-recursive productions that remain after purging productions that immediately produce keys of H from S of A;
	insert the key S into H;
	if the left-recursive production linked list is empty:
		stop;
	let the rotation parseme be a new rotation parseme for S;
	repeat with the non-left-recursive production running through the production keys of the production linked list of S:
		enqueue the key the rotation parseme in the right-hand parseme linked list of the non-left-recursive production through the right-hand parseme linked list tail of the non-left-recursive production;
	repeat with the left-recursive production running through the production keys of the left-recursive production linked list:
		write the left-hand parseme the rotation parseme to the left-recursive production;
		let the repurposed vertex be the right-hand parseme linked list of the left-recursive production converted to a permanent linked list vertex;
		let the tail-to-replace be the right-hand parseme linked list tail of the left-recursive production converted to a permanent linked list vertex;
		let the replacement list be the link of the repurposed vertex converted to a permanent linked list;
		always check that the replacement list is not empty or else fail at rewriting trivial recursion;
		write the key the rotation parseme to the repurposed vertex;
		write the link a null permanent linked list vertex to the repurposed vertex;
		write the link the repurposed vertex to the tail-to-replace;
		write the right-hand parseme linked list the replacement list to the left-recursive production;
		write the right-hand parseme linked list tail (the repurposed vertex converted to a permanent linked list tail) to the left-recursive production;
	write the production linked list the left-recursive production linked list to the rotation parseme;
	let the rotation parseme's empty production be a new production for the rotation parseme;
	push the key a new tree rotation rewrite for the rotation parseme's empty production onto the parse tree rewrite linked list of A;
	now the left-recursive production linked list is the list of left-recursive productions that remain after purging productions that immediately produce keys of H from the rotation parseme of A;
	[I haven't decided yet whether it's worth it to handle the case where this list comes back non-empty.  It's a pain, and I can't imagine how anyone would find it useful.  But having exceptional cases also bothers me.]
	always check that the left-recursive production linked list is empty or else fail at normalizing an absurd grammar;
	insert the key the rotation parseme into H.

Section "Normalization Proper"

To put (A - a context-free parser) into normal form:
	if A is in normal form:
		fail at putting a parser into normal form twice;
	let the seen hash table be a new hash table with the context-free parseme hash table size buckets;
	repeat with the parseme running through the parseme keys of the parseme linked list of A:
		if the parseme is a nonterminal:
			put the parseme of A into normal form with the seen parsemes being the keys of the seen hash table;
	delete the seen hash table;
	mark A as being in normal form.

Chapter "Parsing" - unindexed

To parse for (S - a parseme) (this is parsing for a parseme):
	let the owner be the owner of S;
	[////fail at reinitializing a parser mid-parse;]
	repeat with the parseme running through the parseme keys of the parseme linked list of the owner:
		delete the parse attempt linked list of the parseme;
		write the parse attempt linked list an empty linked list to the parseme;
		delete the parse step linked list of the parseme;
		write the parse step linked list an empty linked list to the parseme;
	apply the parsing phrase of S to S and zero.

Chapter "Iteration over Steps" - unindexed

To decide what linked list vertex is the first parse step linked list vertex for (S - a parseme) (this is finding a first parse step linked list vertex):
	let the end lexeme index be the lexeme count of the owner of S;
	repeat with the candidate running through occurrences of the key zero in the parse step linked list of S:
		if the end lexeme index of the parse step value of the candidate is the end lexeme index:
			decide on the candidate;
	decide on a null linked list vertex.

To decide what linked list vertex is the next parse step for (S - a parseme) after (L - a linked list vertex) (this is finding a next parse step linked list vertex):
	let the end lexeme index be the lexeme count of the owner of S;
	let the candidate be the first match for the key zero after L;
	while the candidate is not null:
		if the end lexeme index of the parse step value of the candidate is the end lexeme index:
			break;
		now the candidate is the first match for the key zero after the candidate;
	decide on the candidate.

Chapter "Expansion" - unindexed

[V should already know its parseme, parent, siblings, and beginning lexeme index.  We will set its production, children, and end lexeme index.]
To expand (V - a parse tree vertex) using (T - a parse step):
	write the end lexeme index the end lexeme index of T to V;
	let the production be the production of T;
	if the production is null:
		stop;
	write the production the production to V;
	let the parseme linked list vertex be the right-hand parseme linked list of the production converted to a permanent linked list vertex;
	let the child linked list vertex be the children linked list of T converted to a linked list vertex;
	let the beginning lexeme index be the beginning lexeme index of V;
	while the parseme linked list vertex is not null:
		always check that the child linked list vertex is not null or else fail at finding a parse step in a consistent state;
		let the child step be the parse step key of the child linked list vertex;
		let the child vertex be a new parse tree vertex for the parseme key of the parseme linked list vertex with the parent V;
		write the beginning lexeme index the beginning lexeme index to the child vertex;
		expand the child vertex using the child step;
		now the parseme linked list vertex is the link of the parseme linked list vertex;
		now the child linked list vertex is the link of the child linked list vertex;
		now the beginning lexeme index is the end lexeme index of the child vertex;
	always check that the child linked list vertex is null or else fail at finding a parse step in a consistent state.

Chapter "Rewriting" - unindexed

[The rewriting phrases look a lot scarier than they actually are: one inserts a vertex between a parent and some of its children, while the other rotates a line of right descent to a line of left descent.  It's just that all of the tidying up of pointers and lexeme indices is happening explicitly.]

Section "Iteration Order"

To decide what parse tree vertex is the parse tree vertex to visit after (V - a parse tree vertex):
	let the child be the first child of V;
	if the child is not null:
		decide on the child;
	let the current vertex be V;
	let the sibling be the right sibling of the current vertex;
	while the sibling is null:
		let the parent be the parent of the current vertex;
		if the parent is null:
			decide on a null parse tree vertex;
		now the current vertex is the parent;
		now the sibling is the right sibling of the current vertex;
	decide on the sibling.

Section "Hashing Production Instantiations" - unindexed

[The production instantiation hash table maps productions to the vertices that use them.]
The production instantiation hash table is a hash table that varies.

To hash the productions of vertices rooted at (V - a parse tree vertex):
	let the current vertex be V;
	while the current vertex is not null:
		let the production be the production of the current vertex;
		insert the key the production and the value the current vertex into the production instantiation hash table;
		now the current vertex is the parse tree vertex to visit after the current vertex.

Section "Unsubstitution" - unindexed

To unsubstitute (P - a production) (this is unsubstituting a production):
	let the outer production be the outer production of P;
	let the inner production be the inner production of P;
	let the outer parseme be the left-hand parseme of the outer production;
	let the inner parseme be the left-hand parseme of the inner production;
	let the substitution size be the substitution size of P;
	repeat with the parse tree vertex running through the parse tree vertex values matching the key P in the production instantiation hash table:
		always check that the outer parseme is the parseme of the parse tree vertex or else fail at making a mismatched unsubstitution;
		write the production the outer production to the parse tree vertex;
		insert the key the outer production and the value the parse tree vertex into the production instantiation hash table;
		let the beginning lexeme index be the beginning lexeme index of the parse tree vertex;
		let the child be a new parse tree vertex for the inner parseme with the parent the parse tree vertex, placed on the left;
		write the production the inner production to the child;
		write the beginning lexeme index the beginning lexeme index to the child;
		insert the key the inner production and the value the child into the production instantiation hash table;
		if the substitution size is zero:
			write the end lexeme index the beginning lexeme index to the child;
		otherwise:
			let the first grandchild be the right sibling of the child;
			let the last grandchild be the child;
			repeat with a counter running from one to the substitution size:
				now the last grandchild is the right sibling of the last grandchild;
				write the parent the child to the last grandchild;
			let the sibling be the right sibling of the last grandchild;
			if the sibling is null:
				write the last child the child to the parse tree vertex;
			otherwise:
				write the left sibling the child to the sibling;
			write the right sibling the sibling to the child;
			write the first child the first grandchild to the child;
			write the last child the last grandchild to the child;
			write the left sibling a null parse tree vertex to the first grandchild;
			write the right sibling a null parse tree vertex to the last grandchild;
			write the end lexeme index the end lexeme index of the last grandchild to the child.

Section "Rotation" - unindexed

To detach vertices after (V - a parse tree vertex) from its parent (P - a parse tree vertex):
	if V is null:
		if P is null:
			stop;
		write the first child a null parse tree vertex to P;
		write the end lexeme index the beginning lexeme index of P to P;
	otherwise:
		write the end lexeme index the end lexeme index of V to P;
		write the right sibling a null parse tree vertex to V;
	write the last child V to P.

To remove the rotation terminator (V - a parse tree vertex):
	detach vertices after the left sibling of V from its parent the parent of V;
	delete V and its descendants.

To have (V - a parse tree vertex) claim the detached (W - a parse tree vertex) as its first child:
	write the left sibling a null parse tree vertex to W;
	let the sibling be the first child of V;
	if the sibling is null:
		write the last child W to V;
	otherwise:
		write the left sibling W to the sibling;
	write the right sibling the sibling to W;
	write the parent V to W;
	write the first child W to V.

To join (V - a parse tree vertex) to the parent (P - a parse tree vertex) and the left sibling (L - a parse tree vertex) and the right sibling (R - a parse tree vertex):
	if P is null:
		write the parent a null parse tree vertex to V;
		write the left sibling a null parse tree vertex to V;
		write the right sibling a null parse tree vertex to V;
	otherwise:
		write the parent P to V;
		if L is null:
			write the first child V to P;
		otherwise:
			write the right sibling V to L;
		write the left sibling L to V;
		if R is null:
			write the last child V to P;
		otherwise:
			write the left sibling V to R;
		write the right sibling R to V.

To rotate away (P - a production) (this is rotating a production):
	let the rotation parseme be the left-hand parseme of P;
	let the original parseme be the original parseme of the rotation parseme;
	repeat with the parse tree vertex running through the parse tree vertex values matching the key P in the production instantiation hash table:
		let the eventual ancestor be the parent of the parse tree vertex;
		always check that the eventual ancestor is not null or else fail at unrotating from a nonrotation parseme;
		remove the rotation terminator the parse tree vertex;
		let the locus be the eventual ancestor;
		let the parent be the parent of the locus;
		let the left sibling be the left sibling of the locus;
		let the right sibling be the right sibling of the locus;
		while the left-hand parseme of the production of the locus is the rotation parseme:
			always check that the parent is not null or else fail at unrotating from a nonrotation parseme;
			always check that the right sibling is null or else fail at unrotating from a nonrotation parseme;
			let the grandparent be the parent of the parent;
			detach vertices after the left sibling from its parent the parent;
			[Update the siblings now, before we clobber them.]
			now the left sibling is the left sibling of the parent;
			now the right sibling is the right sibling of the parent;
			[Clobbering here.]
			have the locus claim the detached parent as its first child;
			write the parseme the original parseme to the locus;
			[Update everything else.]
			now the locus is the parent;
			now the parent is the grandparent;
		join the eventual ancestor to the parent the parent and the left sibling the left sibling and the right sibling the right sibling;
		let the beginning lexeme index be the beginning lexeme index of the locus;
		now the locus is the parent of the locus;
		while the locus is not the parent:
			write the beginning lexeme index the beginning lexeme index to the locus;
			now the locus is the parent of the locus.

Section "Rewriting Proper" - unindexed

To rewrite the match rooted at (V - a parse tree vertex):
	let the owner be the owner of V;
	now the production instantiation hash table is a new hash table with the context-free production hash table size buckets;
	hash the productions of vertices rooted at V;
	repeat with the rewrite running through the parse tree rewrite keys of the parse tree rewrite linked list of the owner:
		apply the rewriting phrase of the rewrite to the production of the rewrite;
	delete the production instantiation hash table.

Chapter "Parsing Callbacks"

Section "Private Parsing Callbacks" - unindexed

To match (A - a parseme) from lexeme index (B - a number) to lexeme index (E - a number) via (P - a production):
	let the parse step be a new parse step for P ending at lexeme index E;
	push the key B and the value the parse step onto the parse step linked list of A.

[L should be an expansion stack as described later.  The relevant part here is that it should have the children of the new parse step as values of values in reverse order.]
To match (A - a parseme) from lexeme index (B - a number) to lexeme index (E - a number) via (P - a production) as described by (L - a linked list):
	let the new parse step be a new parse step for P ending at lexeme index E;
	repeat with the parse step linked list vertex running through the linked list vertex values of L:
		push the key the parse step value of the parse step linked list vertex onto the children linked list of the new parse step;
	push the key B and the value the new parse step onto the parse step linked list of A.

Section "Public Parsing Callbacks"

To match (A - a parseme) from lexeme index (B - a number) to lexeme index (E - a number):
	let the parse step be a new parse step ending at lexeme index E;
	push the key B and the value the parse step onto the parse step linked list of A.

Chapter "Standard Nonterminal Parsing Phrase" - unindexed

To decide what linked list vertex is the first candidate step linked list vertex for (S - a parseme) beginning at lexeme index (I - a number):
	unless the parse attempt linked list of S contains the key I:
		push the key I onto the parse attempt linked list of S;
		apply the parsing phrase of S to S and I;
	decide on the first match for the key I in the parse step linked list of S.

To parse for the nonterminal (S - a parseme) beginning at lexeme index (I - a number) (this is the standard nonterminal parsing phrase):
	repeat with the production running through the production keys of the production linked list of S:
		if the right-hand parseme linked list of the production is empty:
			match S from lexeme index I to lexeme index I via the production;
			next;
		[The expansion stack has as keys permanent linked list vertices---these are vertices from the production's right-hand parseme linked list and represent the part of the production we are working on.]
		[For values it has (non-permanent, but not-to-be-deleted) linked list vertices---these are vertices from the child parseme's parse step linked list and represent the subexpansion of that parseme we are working with at the corresponding position.]
		let the expansion stack be an empty linked list;
		let the initial position linked list vertex be the right-hand parseme linked list of the production converted to a permanent linked list vertex;
		let the child be the parseme key of the initial position linked list vertex;
		let the initial candidate step linked list vertex be the first candidate step linked list vertex for the child beginning at lexeme index I;
		[This next check isn't strictly necessary, but it short-circuits things often enough to be useful.]
		if the initial candidate step linked list vertex is null:
			next;
		push the key the initial position linked list vertex and the value the initial candidate step linked list vertex onto the expansion stack;
		repeat until a break:
			let the expansion vertex be the expansion stack converted to a linked list vertex;
			let the position linked list vertex be the permanent linked list vertex key of the expansion vertex;
			let the candidate step linked list vertex be the linked list vertex value of the expansion vertex;
			if the candidate step linked list vertex is null or the link of the position linked list vertex is null:
				unless the candidate step linked list vertex is null:
					let the end lexeme index be the end lexeme index of the parse step value of the candidate step linked list vertex;
					match S from lexeme index I to lexeme index the end lexeme index via the production as described by the expansion stack;
					let the lexeme index key be the number key of the candidate step linked list vertex;
					now the candidate step linked list vertex is the first match for the key the lexeme index key after the candidate step linked list vertex;
				let the outer break flag be false;
				repeat until a break:
					unless the candidate step linked list vertex is null:
						write the value the candidate step linked list vertex to the expansion vertex;
						break;
					let the discarded value be a linked list vertex popped off of the expansion stack;
					delete the discarded value;
					if the expansion stack is empty:
						now the outer break flag is true;
						break;
					now the expansion vertex is the expansion stack converted to a linked list vertex;
					now the candidate step linked list vertex is the linked list vertex value of the expansion vertex;
					let the lexeme index key be the number key of the candidate step linked list vertex;
					now the candidate step linked list vertex is the first match for the key the lexeme index key after the candidate step linked list vertex;
				if the outer break flag is true:
					break;
			otherwise:
				let the end lexeme index be the end lexeme index of the parse step value of the candidate step linked list vertex;
				now the position linked list vertex is the link of the position linked list vertex;
				now the child is the parseme key of the position linked list vertex;
				now the candidate step linked list vertex is the first candidate step linked list vertex for the child beginning at lexeme index the end lexeme index;
				push the key the position linked list vertex and the value the candidate step linked list vertex onto the expansion stack.

Chapter "Top-Level Orchestration"

Section "Tree Extraction" - unindexed

To decide what parse tree vertex is the root for (S - a parseme) using (T - a parse step) (this is extracting a parse tree):
	let the root be a new parse tree root for S;
	expand the root using T;
	rewrite the match rooted at the root;
	decide on the root of the root.

Section "Iterating over Matches"

Include (-
	Global cfpe_iterator;
-) after "Definitions.i6t".

To repeat with (I - a nonexisting parse tree vertex variable) running through matches for (S - a parseme) begin -- end: (-
	(llo_getField((+ parsing for a parseme +),1))({S});
	cfpe_iterator=(llo_getField((+ finding a first parse step linked list vertex +),1))({S});
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if(llo_advance){
			@pull cfpe_iterator;
			if(cfpe_iterator) (llo_getField((+ deleting a parse tree +),1))({I});
			if(llo_broken){
				break;
			}
			cfpe_iterator=(llo_getField((+ finding a next parse step linked list vertex +),1))({S},cfpe_iterator);
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			@push cfpe_iterator;
			if(cfpe_iterator){
				{I}=(llo_getField((+ extracting a parse tree +),1))({S},llo_getField(cfpe_iterator,1));
				llo_advance=llo_broken=false;
			}else{
				llo_advance=llo_broken=true;
			}
		}else for(llo_oneTime=true,llo_broken=true,llo_advance=true:llo_oneTime&&((llo_oneTime=false),true)||(llo_broken=false):)
-).

Context-Free Parsing Engine ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Context-Free Parsing Engine mimics Inform's parsing capabilities, but as a
separate set of phrases that can applied to any input, even nontextual input.
Furthermore, parsemes in Context-Free Parsing Engine, which are the analog to
understand tokens, may be recursive.  For instance, it is possible to write the
equivalent of

	Understand "tell [an NPC] to [an imperative command]" as "[an imperative command]".

and then parse something like

	"tell Jemison to tell Watson to kill Zoe"

On the other hand, Context-Free Parsing Engine is slower and has no built-in
facilities for disambiguating or handling malformed input.

Details are in the following chapters.

Chapter: Usage

Section: A note

When our intent is to parse (possibly punctuated) words, we should use the
extension Punctuated Word Parsing Engine, which builds on this extension and
provides phrases that mimic Inform's understand-as syntax.

Section: Background

In interactive fiction, the term "parsing" usually means the end-to-end process
of converting a player's command into an action to take in the simulated world.
"Parsing" in the extension Context-Free Parsing Engine, however, should be
understood as it is in general computer science: a single step in that larger
procedure.  Once an input has been converted to a sequence of chunks, called
"lexemes", for instance,

	"tell", "Jemison", "to", "tell", "Watson", "to", "kill", "Zoe"

the parsing operation organizes the lexemes in an outline-like structure, which
we refer to as a "parse tree".  For example,

	1. "[an imperative command]"
	1.a. "tell"
	1.b. "[an NPC]"
	1.b.1. "Jemison"
	1.c. "to"
	1.d. "[an imperative command]"
	1.d.1. "tell"
	1.d.2. "[an NPC]"
	1.d.2.a. "Watson"
	1.d.3. "to"
	1.d.4. "[an imperative command]"
	1.d.4.a. "kill"
	1.d.4.b. "[an NPC]"
	1.d.4.b.1. "Zoe"

Here, item 1 tells us that the whole thing is an imperative command.  Parts
1a--1d give its structure: the command is to tell an NPC to do something.  Item
1b1 indicates that the NPC is Jemison, items 1d1--1d4 elaborate on what the
player is asking Jemison to do, and so on.

In computer science lingo, 1, 1a, 1b, etc. are called "parse tree vertices" and
their annotations, like "[an imperative command]", "tell", and "[an NPC]", are
called "parsemes" (pronounced like extreme, or supreme, or lexeme, with an -eem
sound at the end).  Parsemes are very similar to Inform's understand tokens, and
like understand tokens, the same parseme can appear in several parse tree
vertices.

Parsemes come in two flavors.  Those that correspond to lexemes in the input,
such as "tell", are called "terminals" because they end the process of
subdividing the input: an entry with a terminal cannot have any subentries.  The
others, written in bracket notation, stand for a general concept that might
manifest as several different lexeme sequences.  "[an NPC]", for instance, can
on closer inspection turn out to be "Jemison", "Watson", or "Zoe".  As one might
expect, the term for these parsemes is "nonterminals".

While the terminals that appear in a parse tree are governed by the input, the
choice and arrangement of nonterminals must be controlled some other way, by
rules termed "productions" (so called because an entry in a parse tree is said
to "produce" its subentries).  Productions are much like Inform's understand
lines.  In the example above we would have five of them, two for imperative
commands:

	Understand "tell [an NPC] to [an imperative command]" as "[an imperative command]".

and

	Understand "kill [an NPC]" as "[an imperative command]".

as well as three for NPCs:

	Understand "Jemison" as "[an NPC]".

	Understand "Watson" as "[an NPC]".

and

	Understand "Zoe" as "[an NPC]".

A collection of lexemes, parsemes, and productions is called a grammar.  Given a
grammar, an input, and a target parseme, a parser's job is to find all parse
trees that match the input and have the target parseme at the top.

We say "all" because the productions might not be strict enough for every input
to produce a unique parse tree.  We call such lax grammars "ambiguous".  To
illustrate, suppose that there is a production meaning

	Understand "[a noun] of [a noun]" as "[a noun]".

and we want to parse

	"a box of troubles of the worst kind"

as a noun.  We could either end up with

	1. "[a noun]"
	1.a. "[a noun]"
	1.a.1. "[a noun]"
	1.a.1.a. "a box"
	1.a.2. "of"
	1.a.3. "[a noun]"
	1.a.3.a. "troubles"
	1.b. "of"
	1.c. "[a noun]"
	1.c.1. "the worst kind"

which is to say that the box of troubles is of the worst kind or

	1. "[a noun]"
	1.a. "[a noun]"
	1.a.1. "a box"
	1.b. "of"
	1.c. "[a noun]"
	1.c.1. "[a noun]"
	1.c.1.a. "troubles"
	1.c.2. "of"
	1.c.3. "[a noun]"
	1.c.3.a. "the worst kind"

in which the box contains the worst kind of troubles.  Whether the distinction
matters depends on our application.

When it does, one possible solution is to generate both trees but then discard
one at some later stage of processing, like inside a routine that asks
disambiguation questions.  Such a strategy works with Inform's built-in parser
because it limits the amount of ambiguity we can introduce in a grammar.  But
when we allow recursion, that tack doesn't always pan out.  A grammar can be so
ambiguous that some inputs have infinitely many parse trees.

So sometimes we must manually make the grammar unambiguous, or at least less
ambiguous.  In this case, we could add another parseme and rewrite the
production to break its symmetry:

	Understand "[a noun] of [a noun or an of-phrase]" as "[a noun or an of-phrase]".

There is one kind of ambiguity so troublesome that even Context-Free Parsing
Engine won't let it through: a production where a parseme matches multiple
copies of itself (but nothing else):

	Understand "[an absurdity][an absurdity]" as "[an absurdity]".

in combination with a production where that same parseme matches nothing at all:

	Understand "" as "[an absurdity]".

The problem is that this grammar makes a parseme match no input infinitely many
ways, and the parser cannot safely throw away either of the productions.  (If
the first production had understood only a single occurrence of the parseme as
itself, the extension would also have been in trouble, but it would have
automatically recovered by ignoring the recursive production.)  Fortunately,
it's hard to imagine a situation where this arrangement would be useful.

Section: Creating a parser

Context-Free Parsing Engine provides the kind

	a context-free parser

for storing parsers.  Variables of this kind initially have the value

	an invalid context-free parser

which, as one might expect, cannot legally be an argument to any of the parsing
phrases.  To obtain a useful value, we request

	a new context-free parser

as in

	now the auxiliary parser is a new context-free parser;

At the moment context-free parsers can be created but not destroyed.  This may
change in a future version of the extension.

Section: Creating parsemes

Once we have a parser, we need to equip it with parsemes.  Parsemes are usually
stored in values that vary, for instance,

	An imperative command is a parseme that varies.

The naming here is a little awkward, but makes more sense when we use
substitution syntax, as extensions like Punctuated Word Parsing Engine let us
do:

	understand "tell [an NPC] to [an imperative command]" as "[an imperative command]";

Parseme variables will initially hold

	an invalid parseme

which, like an invalid context-free parser, is not a value to be given to
parsing phrases.  We replace it by writing

	now (X - a temporary named parseme) is a new nonterminal in (A - a context-free parser) named (T - some text)

for nonterminals and

	now (X - a parseme variable) is a new terminal in (A - a context-free parser) named (T - some text) and parsed by (P - a phrase parse tree vertex -> nothing)

for terminals.  The names have no significance except to make debugging easier,
although we can look them up and print them if we wish.  We will wait to discuss
parsing phrases until the section "Terminals' parsing phrases".

It is important that we keep track of what each parseme means, because parsemes
are only able to answer a few questions about themselves:

	the owner of (A - a parseme)

decides on the context-free parser that owns A,

	if (A - a parseme) is a terminal:
		....

checks whether A is a terminal, with the opposite condition evaluated by

	if (A - a parseme) is a nonterminal:
		....

and the phrase

	the human-friendly name of (A - a parseme)

retrieves the name that we originally gave as T.

Section: Creating productions

Production variables, like parsers and parsemes, begin by holding an invalid
value,

	an invalid production

but we can ask for new, useful values:

	a new production for (S - a parseme)

Here S is the parseme that we would like to understand a parseme sequence as.
That sequence is initially empty, but we can add parsemes to it, either on the
left:

	prepend (S - a parseme) to (A - a production)

or the right:

	append (S - a parseme) to (A - a production)

For instance,

	let telling be a new production for an imperative command;
	prepend the word to to telling;
	prepend an NPC to telling;
	append an imperative command to telling;
	prepend the word tell to telling;

would be one way to build up an equivalent to

	understand "tell [an NPC] to [an imperative command]" as "[an imperative command]";

Productions, like parsemes, cannot tell us much about themselves.  In fact,
apart from the debugging facilities at the end of this chapter, the only query
we can make to a production is a request for

	the owner of (A - a production)

which returns the context-free parser that owns it.  Usually we forget about
productions as soon as we've filled them in.

Section: Putting a parser in normal form

Once we have all of the parsemes and productions established, we invoke the
phrase

	put (A - a context-free parser) into normal form

The parser will then optimize its grammar for left-to-right parsing.  At this
point the grammar is set in stone: we cannot add more parsemes, we cannot add
more productions, and we cannot even put A into normal form again.  But A is now
able to parse, whereas before it was not.  In case we need to check what
operations are possible, the extension provides the conditional

	if (A - a context-free parser) is in normal form:
		....

Section: Loading input

To begin the actual parsing process, we give a parser some input:

	write the content (X - a value) and the lexeme count (N - a number) to (A - a context-free parser)

Here X is the actual input.  It can be of any kind, but to avoid mysterious bugs
we should make sure that it's of a kind that the terminals are prepared to
handle.

N, in turn, is the number of lexemes in X.  While the terminals' parsing phrases
might be able to figure out N from X, the parser cannot, and it needs to know
when to stop parsing.

Section: Parsing

Once a parser is in normal form and has input, we can iterate over the parse
trees for that input.  The loop

	repeat with (I - a nonexisting parse tree vertex variable) running through matches for (S - a parseme):
		....

runs once for each tree (unless we use "break"), setting I to be the parse tree
vertex at the top.  These trees and their vertices become invalid when a loop
iteration completes---if we want to keep a copy, it is not enough to assign I to
a variable.  Instead, we must clone the tree, as in

	let the clone be the parse tree vertex corresponding to I in a new clone of its tree;

The new variable the clone is completely equivalent to I, except that it will
survive until we delete it with the phrase

	delete (V - a parse tree vertex) and its descendants

as in

	delete the clone and its descendants;

It is a bad idea to let clones accumulate in memory unnecessarily, so we should
be sure to delete them as soon as they are no longer needed.  But be careful; it
is a worse idea to delete only part of a tree.  If we have a vertex that is not
topmost in its tree, we should not give it to the deletion phrase.

One final warning: if we break out of a loop over parse trees by a mechanism
other than "break", like "stop" or "decide on", the loop won't have a chance to
clean up the current iteration's tree, so we must do so manually.  For instance:

	repeat with the root running through matches for ...:
		if ...:
			delete the root and its descendants;
			decide yes.

Section: Inspecting parse trees

Parse tree vertices have comparatively much to tell us.  As before we can ask for

	the owner of (A - a parse tree vertex)

to discover the parser that owns them.  We can also ask for

	the parseme of (A - a parse tree vertex)

to get their annotation, and

	the production of (A - a parse tree vertex)

if that parseme is a nonterminal, to obtain the production that justifies that
annotation.

As for relating parse tree vertices to the input, the phrase

	the beginning lexeme index of (A - a parse tree vertex)

will tell us which lexeme is the first one A matches and

	the end lexeme index of (A - a parse tree vertex)

will tell us the first following lexeme that it does not match.  These indices
are counted from zero.  For example, with the input

	"tell Jemison to tell Watson to kill Zoe"

broken into word lexemes, the imperative command that matched "kill Zoe" would
have a beginning lexeme index of six (there are six words before the word
"kill"), and an end lexeme index of eight (adding on the two matched words
brings that count to eight).

Parse tree vertices also know about their neighbors in the parse tree.  Consider
A to be parse tree vertex 1d4 in

	1. "[an imperative command]"
	1.a. "tell"
	1.b. "[an NPC]"
	1.b.1. "Jemison"
	1.c. "to"
	1.d. "[an imperative command]"
	1.d.1. "tell"
	1.d.2. "[an NPC]"
	1.d.2.a. "Watson"
	1.d.3. "to"
	1.d.4. "[an imperative command]" (this is A)
	1.d.4.a. "kill"
	1.d.4.b. "[an NPC]"
	1.d.4.b.1. "Zoe"

By writing

	the parse tree vertex to visit after (A - a parse tree vertex)

we obtain the next vertex in outline order, 1d4a in this case.

The phrase

	the parent of (A - a parse tree vertex)

would decide on vertex 1d (the vertex immediately above),

	the first child of (A - a parse tree vertex)

would result in 1d4a, and

	the last child of (A - a parse tree vertex)

would be 1d4b.

Asking for

	the left sibling of (A - a parse tree vertex)

would produce vertex 1d3 (the preceding vertex at the same level), whereas

	the right sibling of (A - a parse tree vertex)

ought not decide on a vertex at all---1d4 has no such sibling.  In fact,
whenever we ask for a relation that does not exist, all of these phrases will
return

	a null parse tree vertex

Like

	an invalid parse tree vertex

which is the initial value of parse tree vertex variables, null vertices cannot
be meaningfully passed to phrases.  But we can check for them by applying the
adjective "null":

	if (V - a parse tree vertex) is null:
		....

In addition, because the vertex at the top of a tree is traditionally called the
"root", the tests

	if (A - a parse tree vertex) is a root:
		....

and

	if (A - a parse tree vertex) is not a root:
		....

are provided as shorthand forms for

	if the parent of (A - a parse tree vertex) is null:
		....

and

	if the parent of (A - a parse tree vertex) is not null:
		....

respectively.  Likewise, the phrase

	the root of (A - a parse tree vertex)

obtains the root of the tree that A inhabits.  In the case of vertex 1d4, this
would be vertex 1.

The extension also includes convenience phrases for iterating over vertices'
relatives.  The loop

	repeat with (I - a nonexisting parse tree vertex variable) running through the children of (A - a parse tree vertex):
		....

sets I to each child of A, starting with the left-most (earliest) child.  With
vertex 1d4, the first iteration would have I being vertex 1d4a, while the second
would store 1d4b.  Another,

	repeat with (I - a nonexisting parse tree vertex variable) running through the right siblings of (A - a parse tree vertex):
		....

sets I to the right sibling of A, then to the right sibling of that vertex, and
so on.  It would do nothing when A is vertex 1d4 because 1d4 has no right siblings.

The utility of these loops can be seen in their search variations.  On one hand
we have

	the first match for (S - a parseme) among the children of (V - a parse tree vertex)

which decides on the left-most vertex that is both a child of V and annotated
with the parseme S.  If it cannot find any such vertex, it decides on a null
one.  The similar

	the next match for (S - a parseme) after the child (V - a parse tree vertex)

starts from one such match and finds the next one.  Again, if there are no
suitable vertices, the phrase produces a null vertex as its result.

Finally, to top off all of these searching phrases, we have the simple
conditional

	if (S - a parseme) appears among the children of (V - a parse tree vertex):
		....

The code represented by the ellipses executes if any direct child of V has the
parseme S.

Section: Processing parsed input

In many applications we want to process vertices annotated with different
parsemes differently.  The straightforward approach is to write a series of ifs:

	To decide what stored action is represented by the tree rooted at (V - a parse tree vertex):
		if the parseme of V is an imperative command:
			...
		otherwise if the parseme of V is an interrogative command:
			...
		otherwise ....

Unfortunately, this lumps all of the cases together in one phrase, and it
becomes awkward to add or replace cases from another part of the source text.
So instead, Context-Free Parsing Engine defines the relation

	the having a parseme relation

which relates vertices to the parseme that annotate them, as well as the verb
``to have the parseme''.  We then write

	To decide what stored action is represented by the tree rooted at (V - a parse tree vertex that has the parseme an imperative command):
		....

	To decide what stored action is represented by the tree rooted at (V - a parse tree vertex that has the parseme an interrogative command):
		....

which places every case in its own phrase.

Section: Terminals' parsing phrases

When dealing with nonterminals and productions, a parser can ignore the kind of
its input.  But to match input against terminals it needs some assistance, which
is provided in the form of parsing phrases.  Each terminal is equipped with one
parsing phrase, which receives that terminal and a beginning lexeme index and
determines whether the lexemes at that index match.

Let us begin with an example:

	To parse for (S - a parseme) beginning at lexeme index (I - a number) by matching a single lexeme (this is an example parsing phrase):
		....

Using

	the owner of (A - a parseme)

combined with the phrase

	the (K - a kind) content of (A - a context-free parser)

we first access the input being parsed.  For the example our input will be a
list of lexemes:

	let the lexeme list be the list of lexemes content of the owner of S;

Next, we convert the lexeme index, which counts from zero, to a list index,
which Inform has count from one:

	let the list index be I plus one;

Because our example phrase will never match zero lexemes, we want to stop any
matching attempts when the index is out of bounds.  One way is to write

	if the list index is greater than the number of entries in the lexeme list:
		stop;

another is to use the phrase

	the lexeme count of (A - a context-free parser)

and write

	if the list index is greater than the lexeme count of the owner of V;
		stop;

On the other hand, if there is a lexeme to match, we should retrieve it:

	let the lexeme be entry list index of the lexeme list;

We then compare the lexeme against the parseme:

	if the lexeme is ...:

Should the comparison succeed, we need to notify the parser of the extent of our
match.  First we compute the end index, based on the fact that we have matched
one lexeme:

	let the end lexeme index be I plus one;

and then we report the match, using the phrase

	match (S - a parseme) from lexeme index (B - a number) to lexeme index (E - a number)

which is only valid inside of a parsing phrase, and only if S is the parseme we
were given, B is the beginning index that we called I, and E is an in-bounds
number greater than or equal to B.  In our case, we write

	match S from lexeme index I to lexeme index the end lexeme index.

Put together, the code looks like this:

	To parse for (S - a parseme) beginning at lexeme index (I - a number) by matching a single lexeme (this is an example parsing phrase):
		let the lexeme list be the list of lexemes content of the owner of S;
		let the list index be I plus one;
		if the list index is greater than the number of entries in the lexeme list:
			stop;
		let the lexeme be entry list index of the lexeme list;
		if the lexeme is ...:
			let the end lexeme index be I plus one;
			match S from lexeme index I to lexeme index the end lexeme index.

There is a possibility, which we did not encounter in this example, that there
are several end indices that we could sensibly choose.  For instance, suppose
that we want a terminal to match any alliteration.  At lexeme index zero of
"marvelous marble march of stairs" we can match both "marvelous marble" and
"marvelous marble march", so we should invoke the phrase

	match (S - a parseme) from lexeme index (B - a number) to lexeme index (E - a number)

twice---once with E set to two and another time with E being three.

Section: Debugging phrases

During development it is sometimes handy to see the internal representation of
the parsing structures.  The primary phrase for inspecting a parser is

	say (A - a context-free parser)

which renders the (possibly optimized) productions of A in a standard notation,
BNF, and lists the parse tree rewrites used to undo the effects of grammar
optimization.  For less overwhelming output, we can inspect individual parsemes
and productions via

	say (A - a parseme)

and

	say (A - a production)

not to mention

	say the productions of (A - a parseme)

We may also print a vertex through the say phrase

	say (A - a parse tree vertex)

As for reading the output, parsemes are identified by a unique code and their
human-friendly name, and will usually print as something like this:

	(parseme 0x1234ABCD: an NPC)

If they are in a vertex that has matched lexemes, the beginning and end indices
of those lexemes follow in bracket notation, as in

	(parseme 0x1234ABCD: an NPC) (7..9)

and if there are more parsemes that made the matching possible, they will appear
in curly braces after that:

	(parseme 0x1234ABCD: an NPC) (7..9) { (parseme 0x5678EF01) ... }

An epsilon is used to indicate an empty list of parsemes.

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

Context-Free Parsing Engine was prepared as part of the Glulx Runtime
Instrumentation Project (https://sourceforge.net/projects/i7grip/).  For this
first edition of the project, special thanks go to these people, in
chronological order:

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

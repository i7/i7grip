Version 1 of Disambiguation Framework (for Glulx only) by Brady Garvin begins here.

"A standard process for disambiguating parses made by Context-Free Parsing Engine."

Include Runtime Checks by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Context-Free Parsing Engine by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Disambiguation Framework you will see a sentence like

	A disambiguation feature is aborting disambiguation.

This bewildering statement actually sets up disambiguation features as a qualitative value with default value the disambiguation feature at address one, which, as we say, signifies a request to abort disambiguation.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on disambiguation features.]

Chapter "Use Options" - unindexed

Use a disambiguation hash table size of at least 11 translates as (- Constant DF_DISAMBIGUATION_HASH_SIZE={N}; -).

To decide what number is the disambiguation hash table size: (- DF_DISAMBIGUATION_HASH_SIZE -).

Chapter "Rulebooks"

The disambiguation setup rules are [rulebook is] a rulebook.

Book "Runtime Checks"

Chapter "Messages" - unindexed

To fail at scoring a valid feature alternative list:
	say "[low-level runtime failure in]Disambiguation Framework[with explanation]I found a disambiguation question that I might ask and then discovered that one of the options would be impossible.  Probably my process for building questions is broken.[terminating the story]".

To fail at finding disambiguation choices:
	say "[low-level runtime failure in]Disambiguation Framework[with explanation]I found a set of parse trees that I considered distinct, but then I failed to find a disambiguation question that would differentiate them.  Therefore, one of those two steps must be buggy.[terminating the story]".

To fail at finding matches for a disambiguation choice:
	say "[low-level runtime failure in]Disambiguation Framework[with explanation]I pruned the possible matches according to a disambiguation question that should have differentiated them and ended up with no survivors.  Therefore, either the choices I offered were wrong or the pruning went awry.[terminating the story]".

Book "Disambiguation Framework"

Chapter "Canonicalization"

[Phase I: Copies of the candidate parse trees are canonicalized.]
[Not all members of canonical parse tree vertices are significant; only their parsemes and their tree structure count.]
[The main contract for canonicalization is that parse trees shall share a canonical form if and only if they have the same semantics.  Usually that means paring a parse tree down to an abstract syntax tree.]
[A canonicalization rulebook will be traversed once per parse tree vertex, visiting them from bottom to top (i.e., seeing the root last).  It may rewrite anything in the subtree rooted at the vertex to canonicalize.  If it changes the root of the subtree, it should store the new root as ``the parse tree vertex to canonicalize''; the parent and sibling pointers will be automatically updated at the end of the rulebook.]
[(An alternative design would be to run the rulebook once and give it access to the root.  But almost all rewrites are location-agnostic, so we get simpler code when they don't have to each reimplement the loop over vertices.)]

[Available to canonicalization rulebooks:
	the parse tree vertex to canonicalize, a mutable variable]

[Memory: Allocates one canonical tree per parse.]
[Reentrancy: Is push/pop balanced.]

Section "Public Canonicalization Variables"

The parse tree vertex to canonicalize is a parse tree vertex that varies.  The parse tree vertex to canonicalize is an invalid parse tree vertex.

Section "Canonicalization Subroutines" - unindexed

To canonicalize (A - a parse tree vertex) by (C - a rulebook) after its children:
	let the previous child be a null parse tree vertex;
	now the parse tree vertex to canonicalize is the first child of A;
	while the parse tree vertex to canonicalize is not null:
		let the next child be the right sibling of the parse tree vertex to canonicalize;
		canonicalize the parse tree vertex to canonicalize by C after its children;
		if the previous child is null:
			write the first child (the parse tree vertex to canonicalize) to A;
		otherwise:
			write the right sibling (the parse tree vertex to canonicalize) to the previous child;
		write the left sibling the previous child to the parse tree vertex to canonicalize;
		if the next child is null:
			write the last child (the parse tree vertex to canonicalize) to A;
		otherwise:
			write the left sibling (the parse tree vertex to canonicalize) to the next child;
		write the right sibling the next child to the parse tree vertex to canonicalize;
		write the parent A to the parse tree vertex to canonicalize;
		now the previous child is the parse tree vertex to canonicalize;
		now the parse tree vertex to canonicalize is the next child;
	now the parse tree vertex to canonicalize is A;
	traverse C.

To decide what parse tree vertex is the root of a new canonicalization by (C - a rulebook) of the parse tree rooted at (A - a parse tree vertex):
	push the parse tree vertex to canonicalize;
	canonicalize the parse tree vertex corresponding to A in a new clone of its tree by C after its children;
	let the result be the parse tree vertex to canonicalize;
	pop the parse tree vertex to canonicalize;
	write the left sibling a null parse tree vertex to the result;
	write the right sibling a null parse tree vertex to the result;
	write the parent a null parse tree vertex to the result;
	decide on the result.

Section "Canonicalization Client Subroutines" - unindexed

To decide whether the canonical tree rooted at (A - a parse tree vertex) is identical to the canonical tree rooted at (B - a parse tree vertex):
	unless the parseme of A is the parseme of B:
		decide no;
	let A's child be the first child of A;
	let B's child be the first child of B;
	while A's child is not null and B's child is not null:
		unless the canonical tree rooted at A's child is identical to the canonical tree rooted at B's child:
			decide no;
		now A's child is the right sibling of A's child;
		now B's child is the right sibling of B's child;
	if A's child is not null or B's child is not null:
		decide no;
	decide yes.

Section "Canonicalization Phrase" - unindexed

To decide what linked list is (L - a linked list) after canonicalizing with (C - a rulebook) the parse trees rooted at the keys and storing the resulting roots as values:
	repeat with the linked list vertex running through L:
		write the value the root of a new canonicalization by C of the parse tree rooted at the parse tree vertex key of the linked list vertex to the linked list vertex;
	decide on L.

Chapter "Scoring"

[Phase II: Parse trees are scored in several dimensions.]
[Higher scores are better, but the scale is not assumed to be anything but ordinal.  For example, the scores 1, 2, and 4 rate three trees in increasing order; the scores -701, 0, and 18, although different-seeming, give the same ordering and therefore lead to the same outcome.]
[Because scores are mostly for computing the Pareto front, I find it easier to think of them in the negative sense, as counting and penalizing flaws in less sensible parse trees rather than as counting and rewarding sensical features.]
[The results are undefined if, in a particular dimension, some trees are scored but others are not.]

[Available to scoring rulebooks:
	the root of the parse tree to score, an immutable variable
	the root of the canonicalized parse tree to score, an immutable variable
	give the parse tree to score (N - a number) point/points for (T - some text), a phrase to invoke once per tree/dimension combination]

[Memory: Allocates the parse tree score hash table and its values, which are linked lists.]
[Reentrancy: Is push/pop balanced except for the parse tree score hash table stack, which gains a push.  (See Phase IV.)]

Section "Private Scoring Variables" - unindexed

The variable holding the root of the parse tree to score is a parse tree vertex that varies.  The variable holding the root of the parse tree to score is an invalid parse tree vertex.
The variable holding the root of the canonicalized parse tree to score is a parse tree vertex that varies.  The variable holding the root of the canonicalized parse tree to score is an invalid parse tree vertex.

[Keys are the canonicalized parse tree vertices; values are linked lists mapping names of scoring dimensions as texts to scores.]
The parse tree score hash table is a hash table that varies.

Section "Public Scoring Variables"

To decide what parse tree vertex is the root of the parse tree to score: (- (+ the variable holding the root of the parse tree to score +) -).
To decide what parse tree vertex is the root of the canonicalized parse tree to score: (- (+ the variable holding the root of the canonicalized parse tree to score +) -).

Section "Scoring Callbacks"

To give the parse tree to score (N - a number) point/points for (T - some text):
	let the linked list vertex be the first match for the key the root of the canonicalized parse tree to score in the parse tree score hash table;
	if the linked list vertex is null:
		insert the key the root of the canonicalized parse tree to score and the value an empty linked list into the parse tree score hash table;
		now the linked list vertex is the first match for the key the root of the canonicalized parse tree to score in the parse tree score hash table;
	let the linked list be the linked list value of the linked list vertex;
	push the textual key T and the value N onto the linked list;
	write the value the linked list to the linked list vertex.

Section "Scoring Subroutines" - unindexed

To score the parse tree rooted at (A - a parse tree vertex) and having a canonical parse tree rooted at (B - a parse tree vertex) with (S - a rulebook):
	push the variable holding the root of the parse tree to score;
	now the variable holding the root of the parse tree to score is A;
	push the variable holding the root of the canonicalized parse tree to score;
	now the variable holding the root of the canonicalized parse tree to score is B;
	traverse S;
	pop the variable holding the root of the canonicalized parse tree to score;
	pop the variable holding the root of the parse tree to score.

The parse tree score hash table stack is a linked list that varies.

A disambiguation setup rule (this is the initialize the parse tree score hash table stack rule):
	now the parse tree score hash table stack is an empty linked list.

Section "Scoring Phrase" - unindexed

To score the parse trees rooted at the keys and canonically rooted at the values of (L - a linked list) with (S - a rulebook):
	push the key the parse tree score hash table onto the parse tree score hash table stack;
	now the parse tree score hash table is a new hash table with the disambiguation hash table size buckets;
	repeat with the linked list vertex running through L:
		score the parse tree rooted at the parse tree vertex key of the linked list vertex and having a canonical parse tree rooted at the parse tree vertex value of the linked list vertex with S.

Chapter "Unconditional Filtration"

[Phase III: Nonsensical parse trees are filtered out.]
[The primary filtration rulebook is invoked once per parse tree.  If any rule has the outcome ``filter out the parse tree'', the parse tree is discarded.  Then the same happens with the secondary filtration rulebook.]

[Available to filtration rulebooks:
	the root of the parse tree to filter, an immutable variable
	the root of the canonicalized parse tree to filter, an immutable variable
	filter out the parse tree, a rulebook outcome to produce if the parse tree is rejected
	..., phrases to access the other trees and their scores, which might be offered in the future]

[Memory: Deallocates some parse trees, the corresponding canonicalizations, the corresponding entries in the parse tree score hash table, and their linked list values.]
[Reentrancy: Is push/pop balanced.]

Section "Private Filtration Variables" - unindexed

The variable holding the root of the parse tree to filter is a parse tree vertex that varies.  The variable holding the root of the parse tree to filter is an invalid parse tree vertex.
The variable holding the root of the canonicalized parse tree to filter is a parse tree vertex that varies.  The variable holding the root of the canonicalized parse tree to filter is an invalid parse tree vertex.

The parse tree filtered out flag is a truth state that varies.

The parse-tree-filtering rulebook is a rulebook that varies.

Section "Public Filtration Variables"

To decide what parse tree vertex is the root of the parse tree to filter: (- (+ the variable holding the root of the parse tree to filter +) -).
To decide what parse tree vertex is the root of the canonicalized parse tree to filter: (- (+ the variable holding the root of the canonicalized parse tree to filter +) -).

Section "Filtration Callbacks"

To filter out the parse tree: (- (+ the parse tree filtered out flag +) = true; rtrue; -).

Section "Filtration Subroutines" - unindexed

To decide whether the parse-tree-filtering rulebook retains (A - linked list vertex) (this is applying the decisions of the parse-tree-filtering rulebook):
	now the variable holding the root of the parse tree to filter is the parse tree vertex key of A;
	now the variable holding the root of the canonicalized parse tree to filter is the parse tree vertex value of A;
	now the parse tree filtered out flag is false;
	traverse the parse-tree-filtering rulebook with short-circuiting;
	if the parse tree filtered out flag is true:
		let the canonical root be the parse tree vertex value of A;
		delete the first linked list value matching the key the canonical root in the parse tree score hash table or an empty linked list if there are no matches;
		remove the first occurrence of the key the canonical root from the parse tree score hash table;
		delete the parse tree vertex key of A and its descendants;
		delete the canonical root and its descendants;
		decide no;
	decide yes.

Section "Filtration Phrase" - unindexed

To decide what linked list is (L - a linked list) after filtering with (F - a rulebook) the parse trees rooted at the keys and canonically rooted at the values:
	push the parse-tree-filtering rulebook;
	push the variable holding the root of the parse tree to filter;
	push the variable holding the root of the canonicalized parse tree to filter;
	push the parse tree filtered out flag;
	now the parse-tree-filtering rulebook is F;
	filter L by applying the decisions of the parse-tree-filtering rulebook;
	pop the parse tree filtered out flag;
	pop the variable holding the root of the canonicalized parse tree to filter;
	pop the variable holding the root of the parse tree to filter;
	pop the parse-tree-filtering rulebook;
	decide on L.

Chapter "Global Disambiguation" - unindexed

[Phase IV: The interpretation on the Pareto front is chosen, if it is unique.]

[Memory: Deallocates the parse tree score hash table, its entries, and its linked list values.  If the argument list is filtered, the lost parse trees and their canonicalizations are also deallocated.]
[Reentrancy: Is push/pop balanced except for the parse tree score hash table stack, which is popped once.  (See Phase II.)]

Section "Global Disambiguation Subroutines" - unindexed

A Pareto challenge outcome is a kind of value.  The Pareto challenge outcomes are Pareto victory, Pareto draw, Pareto defeat, and Pareto incomparability.

To decide what Pareto challenge outcome is the result of challenging (M - a linked list) with (L - a linked list):
	let the challenger winning flag be false;
	let the challenger losing flag be false;
	repeat with the score vertex running through M:
		let the category be the text key of the score vertex;
		let the score be the number value of the score vertex;
		let the challenger score be the first number value matching the key the category in L or zero if there are no matches;
		if the challenger score is greater than the score:
			now the challenger winning flag is true;
			if the challenger losing flag is true:
				decide on Pareto incomparability;
		otherwise if the challenger score is less than the score:
			now the challenger losing flag is true;
			if the challenger winning flag is true:
				decide on Pareto incomparability;
	if the challenger losing flag is true:
		decide on Pareto defeat;
	if the challenger winning flag is true:
		decide on Pareto victory;
	decide on Pareto draw.

To decide what linked list is a new list of canonical parse trees at a Pareto front point:
	[The trees at the current best guess are stored in the candidate list, and one such tree is the representative candidate, whose scores are cached.]
	[Trees whose points are dominated by the representative are accumulated in the excluded list and eventually deleted from the score hash table.]
	[Trees decided on are also deleted from the score hash table, so that further queries will yield trees at a different point.]
	let the representative candidate be a null parse tree vertex;
	let the representative's scores be an empty linked list;
	let the candidate list be an empty linked list;
	let the excluded list be an empty linked list;
	repeat with the linked list vertex running through the parse tree score hash table:
		let the challenger be the parse tree vertex key of the linked list vertex;
		let the challenger scores be the linked list value of the linked list vertex;
		if the candidate list is empty:
			now the representative candidate is the challenger;
			now the representative's scores are the challenger scores;	
			push the key the representative candidate onto the candidate list;
		otherwise:
			if the result of challenging the representative's scores with the challenger scores is:
				-- Pareto victory:
					let the candidate list tail vertex be the tail of the candidate list converted to a linked list vertex;
					write the link (the excluded list converted to a linked list vertex) to the candidate list tail vertex;
					now the excluded list is the candidate list;
					now the candidate list is an empty linked list;
					now the representative candidate is the challenger;
					now the representative's scores are the challenger scores;
					push the key the challenger onto the candidate list;
				-- Pareto draw:
					push the key the challenger onto the candidate list;
				-- Pareto defeat:
					push the key the challenger onto the excluded list;
	[Pick up any exclusions that were visited before the candidates.]
	repeat with the linked list vertex running through the parse tree score hash table:
		let the challenger be the parse tree vertex key of the linked list vertex;
		if the challenger is the representative candidate:
			break;
		let the challenger scores be the linked list value of the linked list vertex;
		if the result of challenging the representative's scores with the challenger scores is Pareto defeat:
			push the key the challenger onto the excluded list;				
	repeat with the candidate running through the parse tree vertex keys of the candidate list:
		delete the first linked list value matching the key the candidate in the parse tree score hash table or an empty linked list if there are no matches;
		remove the first occurrence of the key the candidate from the parse tree score hash table;
	repeat with the exclusion running through the parse tree vertex keys of the excluded list:
		delete the first linked list value matching the key the exclusion in the parse tree score hash table or an empty linked list if there are no matches;
		remove the first occurrence of the key the exclusion from the parse tree score hash table;
	delete the excluded list;
	decide on the candidate list.

To clean up after finding the Pareto front:
	repeat with the linked list vertex running through the parse tree score hash table:
		delete the linked list value of the linked list vertex;
	delete the parse tree score hash table;
	now the parse tree score hash table is a hash table key popped off of the parse tree score hash table stack.

To decide what linked list is (L - a linked list) filtered to the vertex with the key (K - a parse tree vertex):
	repeat until a break:
		let the result vertex be a linked list vertex popped off of L;
		if the parse tree vertex value of the result vertex is K:
			repeat with the linked list vertex running through L:
				delete the parse tree vertex key of the linked list vertex and its descendants;
				delete the parse tree vertex value of the linked list vertex and its descendants;
				delete the linked list vertex;
			write the link a null linked list vertex to the result vertex;
			decide on the result vertex converted to a linked list;
		delete the parse tree vertex key of the result vertex and its descendants;
		delete the parse tree vertex value of the result vertex and its descendants;
		delete the result vertex.

Section "Global Disambiguation Phrase" - unindexed

To decide what linked list is (L - a linked list) after choosing the Pareto front if it has a unique canonical parse tree:
	let the result be a null parse tree vertex;
	while the parse tree score hash table is not empty:
		let the tree list be a new list of canonical parse trees at a Pareto front point;
		if the result is a null parse tree vertex:
			now the result is a parse tree vertex key popped off of the tree list;
		repeat with the other result running through the parse tree vertex keys of the tree list:
			unless the canonical tree rooted at the result is identical to the canonical tree rooted at the other result:
				delete the tree list;
				clean up after finding the Pareto front;
				decide on L;
		delete the tree list;
	clean up after finding the Pareto front;
	if the result is null:
		decide on L;
	decide on L filtered to the vertex with the key the result.

Chapter "Unification" - unindexed

[Phase V: Identical canonical trees are unified so that sameness can be checked by comparing addresses.]

[Memory: Allocates the canonical tree count list (for reference counting).  Deallocates duplicate canonical trees.]
[Reentrancy: Is push/pop balanced except for the canonical tree count list stack, which gains a push.  (See Phase VI.)]

Section "Private Unification Variables" - unindexed

[Keys are roots of canonical trees; values are the number of times they appear as values in (the phrases' argument) L.]
The canonical tree count list is a linked list that varies.

The canonical tree count list stack is a linked list that varies.

A disambiguation setup rule (this is the initialize the canonical tree count list stack rule):
	now the canonical tree count list stack is an empty linked list.

Section "Unification Phrase" - unindexed

To decide what linked list is (L - a linked list) after unifying identical canonical trees:
	push the key the canonical tree count list onto the canonical tree count list stack;
	now the canonical tree count list is an empty linked list;
	repeat with the linked list vertex running through L:
		let the canonical root be the parse tree vertex value of the linked list vertex;
		repeat with the other linked list vertex running through the canonical tree count list:
			let the other canonical root be the parse tree vertex key of the other linked list vertex;
			if the canonical tree rooted at the canonical root is identical to the canonical tree rooted at the other canonical root:
				delete the canonical root and its descendants;
				write the value the other canonical root to the linked list vertex;
				write the value the number value of the other linked list vertex plus one to the other linked list vertex;
				break;
		if the parse tree vertex value of the linked list vertex is the canonical root:	
			push the key the canonical root and the value one onto the canonical tree count list;
	decide on L.

Chapter "Local Disambiguation"

[Phase VI: The set of interpretations is pared down to a singleton by asking multiple-choice questions.]
[The phrase is given a set of mutually exclusive features and asked which one appears in the input's intended parse.  In some cases it may also be allowed to decide on "none of the offered disambiguation features", and it always has the option to decide on "aborting disambiguation".]

[Available to local disambiguation phrases:
	its first argument (a context-free parser), the parser from whom disambiguation is occuring
	its second argument (a linked list), the available alternatives; each linked list vertex should be converted to a disambiguation feature
	its third argument (a linked list), whether the phrase may decide on "none of the offered disambiguation features"]

[Memory: Deallocates some parse trees and the corresponding canonicalizations; deallocates the canonical tree count list.]
[Reentrancy: Is push/pop balanced except for the canonical tree count list stack, which is popped once.  (See Phase V.)]

Section "Private Local Disambiguation Variables" - unindexed

[The parse tree feature hash table maps beginning lexeme indices to comparable feature lists.]
[A comparable feature list maps parsemes and (underlying) end lexeme indices to a matching trees list.]
[A feature is represented by a vertex in a comparable feature list; such a vertex uniquely identifies a parseme at a particular lexeme range.]
[A matching trees list maps parse tree roots to unified canonical roots, just like the phase phrase's L.]
[A feature alternative list is a list whose vertices are copies of features.]

[The reason for grouping by beginning lexeme index first is to get more friendly disambiguation questions: ``Which do you mean, `mark' as a verb or `mark' as a person's name?'' rather than ``Which do you mean, `mark' as a person's name or `twain' as two fathoms?'']

The parse tree feature hash table is a hash table that varies.

The parse tree feature hash table stack is a linked list that varies.

A disambiguation setup rule (this is the initialize the parse tree feature hash table stack rule):
	now the parse tree feature hash table stack is an empty linked list.

[Used in place of a closure for pruning away overlapping features.]
The already matchable tree list is a linked list that varies.

[Used in place of a closure for preparing the offered alternatives, consulting the local disambiguator, and filtering after its decision.]
The offered beginning lexeme index is a number that varies.
The offered feature alternative list is a linked list that varies.
The none-of-the-above-features offering is a truth state that varies.
The offered feature alternative list score is a number that varies.
The chosen feature alternative is a linked list vertex that varies.

The offered beginning lexeme index stack is a linked list that varies.
The offered feature alternative list stack is a linked list that varies.

A disambiguation setup rule (this is the initialize the disambiguation offerings stacks rule):
	now the offered beginning lexeme index stack is an empty linked list;
	now the offered feature alternative list stack is an empty linked list.

Section "Local Disambiguation Subroutines" - unindexed

To decide whether (X - a number) is the same number as (Y - a number) (this is numeric equality):
	decide on whether or not X is Y.

To decide what linked list vertex is the feature exhibited by (A - a parse tree vertex):
	let the parseme be the parseme of A;
	let the beginning index be the beginning lexeme index of A;
	let the end index be the end lexeme index of A;
	let the hash table vertex be the first match for the key the beginning index in the parse tree feature hash table;
	if the hash table vertex is null:
		insert the key the beginning index and the value an empty linked list into the parse tree feature hash table;
		now the hash table vertex is the first match for the key the beginning index in the parse tree feature hash table;
	let the comparable feature list be the linked list value of the hash table vertex;
	let the feature be the first match for the key the parseme and the underlying key the end index in the comparable feature list with the comparator numeric equality;
	if the feature is null:
		push the key the parseme and the underlying key the end index and the value an empty linked list onto the comparable feature list;
		write the value the comparable feature list to the hash table vertex;
		now the feature is the first match for the key the parseme and the underlying key the end index in the comparable feature list with the comparator numeric equality;
	decide on the feature.

To initialize the parse tree feature hash table from (L - a linked list):
	push the key the parse tree feature hash table onto the parse tree feature hash table stack;
	now the parse tree feature hash table is a new hash table with the disambiguation hash table size buckets;
	repeat with the linked list vertex running through L:
		let the root be the parse tree vertex key of the linked list vertex;
		let the canonical root be the parse tree vertex value of the linked list vertex;
		let the current vertex be the root;
		while the current vertex is not null:
			let the feature be the feature exhibited by the current vertex;
			let the matching trees list be the linked list value of the feature;
			push the key the root and the value the canonical root onto the matching trees list;
			write the value the matching trees list to the feature;
			now the current vertex is the parse tree vertex to visit after the current vertex.

To decide what number is the score of letting (L - a linked list) survive disambiguation:
	let the canonical root count be zero;
	let the seen hash table be a new hash table with the disambiguation hash table size buckets;
	repeat with the canonical root running through the parse tree vertex values of L:
		unless the seen hash table contains the key the canonical root:
			insert the key the canonical root into the seen hash table;
			increment the canonical root count;
	delete the seen hash table;
	decide on the canonical root count times (the canonical root count minus one).

[We also encode the presence of leftovers by flipping the score's bits.  That will do for now, since this is just an internal phrase, though I'm not sure the ickiness is worth the gains in performance and avoidance of code duplication.]
To decide what number is the score of the feature alternative list (A - a linked list) when applied to (L - a linked list):
	let the result be zero;
	let the leftovers be a new copy of L;
	let the entirety be the length of L;
	repeat with the matching trees list running through the linked list values of A:
		let the match count be the length of the matching trees list;
		always check that the match count is not zero or else fail at scoring a valid feature alternative list;
		if the match count is the entirety:
			delete the leftovers;
			decide on 2147483647; [the maximum signed integer]
		increase the result by the score of letting the matching trees list survive disambiguation;
		repeat with the root running through the parse tree vertex keys of the matching trees list:
			remove the first occurrence of the key the root from the leftovers;
	always check that the length of the leftovers is less than the entirety or else fail at scoring a valid feature alternative list;
	increase the result by the score of letting the leftovers survive disambiguation;
	unless the leftovers are empty:
		now the result is the bitwise not of the result;
	delete the leftovers;
	decide on the result.

To decide whether independence from the already matchable tree list is exhibited by the feature (F - a linked list vertex) (this is enforcing independence from the already matchable tree list):
	let the matching trees list be the linked list value of F;
	repeat with the root running through the parse tree vertex keys of the already matchable tree list:
		if the matching trees list contains the key the root:
			decide no;
	decide yes.

To consider applying feature alternative lists beginning at lexeme index (B - a number) that include (A - a linked list) and select from the pruned comparable feature list (P - a linked list) to (L - a linked list):
	unless P is empty:
		let the selections be A;
		repeat with the selection running through P:
			now the already matchable tree list is the linked list value of the selection;
			push the key the parseme key of the selection and the underlying key the underlying number key of the selection and the value the already matchable tree list onto the selections;
			let the pruned suffix be the link of the selection converted to a linked list;
			now the pruned suffix is a new copy of the pruned suffix;
			filter the pruned suffix by enforcing independence from the already matchable tree list;
			consider applying feature alternative lists beginning at lexeme index B that include the selections and select from the pruned comparable feature list the pruned suffix to L;
			delete the pruned suffix;
			delete a linked list vertex popped off of the selections;
		stop;
	let the score be the score of the feature alternative list A when applied to L;
	let the leftovers flag be whether or not the score is less than zero;
	if the leftovers flag is true:
		now the score is the bitwise not of the score;
	if the score is less than the offered feature alternative list score or the score is the offered feature alternative list score and B is less than the offered beginning lexeme index:
		now the offered beginning lexeme index is B;
		delete the offered feature alternative list;
		now the offered feature alternative list is a new copy of A;
		now the none-of-the-above-features offering is the leftovers flag;
		now the offered feature alternative list score is the score.

To offer a feature alternative list for (L - a linked list):
	push the key the offered beginning lexeme index onto the offered beginning lexeme index stack;
	push the key the offered feature alternative list onto the offered feature alternative list stack;
	now the offered beginning lexeme index is zero;
	now the offered feature alternative list is an empty linked list;
	now the offered feature alternative list score is 2147483647; [the maximum signed integer]
	repeat with the hash table vertex running through the parse tree feature hash table:
		let the beginning index be the number key of the hash table vertex;
		let the comparable feature list be the linked list value of the hash table vertex;
		consider applying feature alternative lists beginning at lexeme index the beginning index that include an empty linked list and select from the pruned comparable feature list the comparable feature list to L;
	always check that the offered feature alternative list is not empty or else fail at finding disambiguation choices.

To decide whether the chosen feature alternative retains (A - a linked list vertex) (this is applying the chosen feature alternative):
	let the result be true;
	let the root be the parse tree vertex key of A;
	if the chosen feature alternative is null:
		repeat with the matching trees list running through the linked list values of the offered feature alternative list:
			if the matching trees list contains the key the root:
				now the result is false;
				break;
	otherwise:
		let the matching trees list be the linked list value of the chosen feature alternative;
		now the result is (whether or not the matching trees list contains the key the parse tree vertex key of A);
	if the result is false:
		delete the root and its descendants;
		let the canonical root be the parse tree vertex value of A;
		let the canonical tree count vertex be the first match for the key the canonical root in the canonical tree count list;
		let the count be the number value of the canonical tree count vertex minus one;
		if the count is zero:
			delete the canonical root and its descendants;
			remove the first occurrence of the key the canonical root from the canonical tree count list;
		otherwise:
			write the value the count to the canonical tree count vertex;
	decide on the result.

To destroy the parse tree feature hash table:
	repeat with the hash table vertex running through the parse tree feature hash table:
		let the comparable feature list be the linked list value of the hash table vertex;
		repeat with the feature running through the comparable feature list:
			delete the linked list value of the feature;
		delete the comparable feature list;
	delete the parse tree feature hash table;
	now the parse tree feature hash table is a hash table key popped off of the parse tree feature hash table stack.

Section "Local Disambiguation Kinds"

A disambiguation feature is a kind of value.  [In fact, an alias for a linked list vertex.]
A disambiguation feature is aborting disambiguation.  [See the note in the book "Extension Information."]
The specification of a disambiguation feature is "Disambiguation features are in fact a type alias for linked list vertices; a disambiguation phrase should convert each of the vertices it receives to a disambiguation feature.  Most of them represent a parseme appearing over a particular lexeme range.  The others are 'aborting disambiguation', which never appears in an alternatives list but can be decided on to abort disambiguation, and 'none of the offered disambiguation features', provided so that a phrase can decide on none of the alternatives offered."

To decide what disambiguation feature is none of the offered disambiguation features: (- 0 -).

To decide what parseme is the parseme of (A - a disambiguation feature):
	decide on the parseme key of A converted to a linked list vertex.

To decide what number is the beginning lexeme index of (A - a disambiguation feature):
	decide on the offered beginning lexeme index.

To decide what number is the end lexeme index of (A - a disambiguation feature):
	decide on the underlying number key of A converted to a linked list vertex.

Section "Local Disambiguation Phrase" - unindexed

To decide what linked list is (L - a linked list) after disambiguating locally with (D - a phrase (context-free parser, linked list, truth state) -> disambiguation feature) for (A - a context-free parser):
	while the canonical tree count list is not unit:
		initialize the parse tree feature hash table from L;
		offer a feature alternative list for L;
		let the chosen feature be D applied to A and the offered feature alternative list and the none-of-the-above-features offering;
		now the offered beginning lexeme index is a number key popped off of the offered beginning lexeme index stack;
		now the chosen feature alternative is the chosen feature converted to a linked list vertex;
		if the chosen feature alternative is an invalid linked list vertex:
			repeat with the root running through the parse tree vertex keys of L:
				delete the root and its descendants;
			delete L;
			delete the offered feature alternative list;
			now the offered feature alternative list is a linked list key popped off of the offered feature alternative list stack;
			destroy the parse tree feature hash table;
			repeat with the canonical root running through the parse tree vertex keys of the canonical tree count list:
				delete the canonical root and its descendants;
			delete the canonical tree count list;
			now the canonical tree count list is a linked list key popped off of the canonical tree count list stack;
			decide on an empty linked list;
		filter L by applying the chosen feature alternative;
		always check that L is not empty or else fail at finding matches for a disambiguation choice;
		delete the offered feature alternative list;
		now the offered feature alternative list is a linked list key popped off of the offered feature alternative list stack;
		destroy the parse tree feature hash table;
	delete the canonical tree count list;
	now the canonical tree count list is a linked list key popped off of the canonical tree count list stack;
	decide on L.

Chapter "Orchestration"

To decide what parse tree vertex is the root of the match for (S - a parseme) canonicalized by (C - a rulebook) and disambiguated by scores from (E - a rulebook) and primary filtration from (F - a rulebook) and secondary filtration from (G - a rulebook) and disambiguating choices from (D - a phrase (context-free parser, linked list, truth state) -> disambiguation feature):
	set up the disambiguation framework;
	let the possibilities be an empty linked list;
	repeat with the root running through matches for S:
		let the possibility be the parse tree vertex corresponding to the root in a new clone of its tree;
		push the key the possibility onto the possibilities;
	if the possibilities are empty:
		decide on a null parse tree vertex;
	now the possibilities are the possibilities after canonicalizing with C the parse trees rooted at the keys and storing the resulting roots as values;
	unless the possibilities are unit:
		score the parse trees rooted at the keys and canonically rooted at the values of the possibilities with E;
		now the possibilities are the possibilities after filtering with F the parse trees rooted at the keys and canonically rooted at the values;
		if the possibilities are empty:
			decide on a null parse tree vertex;
		unless the possibilities are unit:
			now the possibilities are the possibilities after filtering with G the parse trees rooted at the keys and canonically rooted at the values;
			if the possibilities are empty:
				decide on a null parse tree vertex;
			unless the possibilities are unit:
				now the possibilities are the possibilities after choosing the Pareto front if it has a unique canonical parse tree;
				if the possibilities are empty:
					decide on a null parse tree vertex;
				unless the possibilities are unit:
					now the possibilities are the possibilities after unifying identical canonical trees;
					if the possibilities are empty:
						decide on a null parse tree vertex;
					unless the possibilities are unit:
						now the possibilities are the possibilities after disambiguating locally with D for the owner of S;
						if the possibilities are empty:
							decide on a null parse tree vertex;
	let the result be the parse tree vertex value of the possibilities converted to a linked list vertex;
	[There might be several, equivalent possibilities, so we are careful to delete all of them.]
	repeat with the possibility running through the possibilities:
		let the root be the parse tree vertex key of the possibility;
		let the canonical root be the parse tree vertex value of the possibility;
		delete the root and its descendants;
		if the canonical root is not the result:
			delete the canonical root and its descendants;
	delete the possibilities;
	decide on the result.

Book "Setup" - unindexed

Chapter "Setup Flag" -- unindexed

The disambiguation framework setup flag is a truth state that varies.  The disambiguation framework setup flag is false.

Chapter "Setup Phrase" - unindexed

To set up the disambiguation framework:
	if the disambiguation framework setup flag is false:
		traverse the disambiguation setup rulebook;
		now the disambiguation framework setup flag is true.

Disambiguation Framework ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Disambiguation Framework adds disambiguation facilities to Context Free Parsing
Engine (and therefore to extensions that use that engine, like Punctuated Word
Parsing Engine).

Details are in the following chapters.

Chapter: Usage

Section: Background

Authors using this extension should be familiar with the documentation for
Context-Free Parsing Engine.

Section: Process

////

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

Punctuated Word Parsing Engine was prepared as part of the Glulx Runtime
Instrumentation Project (https://github.com/i7/i7grip).  For this first edition
of the project, special thanks go to these people, in chronological order:

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

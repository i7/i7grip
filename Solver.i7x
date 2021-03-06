Version 1 of Solver (for Glulx only) by Brady Garvin begins here.

"A solver for problems of satisfiability modulo theories---in other words, machinery that decides, given a set of statements, whether or not they can all be true at once."

Include Runtime Checks by Brady Garvin.
Include Low-Level Operations by Brady Garvin.
Include Low-Level Linked Lists by Brady Garvin.
Include Low-Level Hash Tables by Brady Garvin.
Include Low-Level Vectors by Brady Garvin.
Include Low-Level Priority Queues by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2014 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[For each of the kinds defined by Solver you will see a sentence like

	A partition is an invalid partition.

This bewildering statement actually sets up partitions as a qualitative value with default value the partition at address one, which, as we say, is invalid.  (We could have gone with a quantitative kind for default zero, but then we would open up the possibility for arithmetic on the pointers.)  I wish it weren't necessary, but at least in this build Inform doesn't let us provide a default value any other way, and, moreover, we need a default value or else only I6 substitutions are allowed to decide on partitions.]

Chapter "Use Options" - unindexed

Use an initial variable capacity of at least 1024 translates as (- Constant S_VARIABLE_CAPACITY = {N}; -).
Use an initial clause capacity of at least 1024 translates as (- Constant S_CLAUSE_CAPACITY = {N}; -).

Use a clause learning hash table size of at least 19 translates as (- Constant S_CLAUSE_LEARNING_HASH_SIZE = {N}; -).

To decide what number is the initial variable capacity: (- S_VARIABLE_CAPACITY -).
To decide what number is the initial clause capacity: (- S_CLAUSE_CAPACITY -).

To decide what number is the clause learning hash table size: (- S_CLAUSE_LEARNING_HASH_SIZE -).

Book "Runtime Checks"

Chapter "Failure Messages" - unindexed

To fail at adding a clause whose truth is already determined, that being as yet unimplemented:
	say "[low-level runtime failure in]Solver[with explanation]The ability to add clauses when their truth is already determined is not yet implemented.[terminating the story]".

To fail at replacing an unwatched variable:
	say "[low-level runtime failure in]Solver[with explanation]I tried to change the variable a clause was watching, but ended up replacing an unwatched variable.  My watch-list bookkeeping must therefore have gone wrong.[terminating the story]".

To fail at entailing a determined variable:
	say "[low-level runtime failure in]Solver[with explanation]I tried to entail a variable that was already determined.  Most likely my watch-list bookkeeping has gone wrong.[terminating the story]".

To fail at replacing an undetermined variable:
	say "[low-level runtime failure in]Solver[with explanation]I tried to change the variable a clause was watching, but ended up replacing an undetermined variable, which the clause should still want to watch.  My watch-list bookkeeping must therefore have gone wrong.[terminating the story]".

To fail at making a decision when assignments are pending:
	say "[low-level runtime failure in]Solver[with explanation]I tried to make a decision before dealing with all of the consequences of a prior decision.[terminating the story]".

To fail at processing a pending assignment when no assignments are pending:
	say "[low-level runtime failure in]Solver[with explanation]I tried to continue handling the consequences of a decision when no more consequences were left to be handled.[terminating the story]".

Book "Partitions"

Chapter "The Partition Kind"

A partition is a kind of value.
A partition is an invalid partition.  [See the note in the book "Extension Information."]
The specification of a partition is "A division of a set {0, ..., N - 1} (which we often denote [N]) into P disjoint parts, which are number 0 to P - 1.  Partitions support iteration over parts, lookup of a part by element, transfer of an element from one part to another, and other similar operations."

Chapter "The Partition Structure" - unindexed

[Layout:
	12 bytes for the inverse part order vector (whose keys [indices] are elements, and whose values [contents] are part order indices; N is implicitly stored as the length of this vector)
	12 bytes for the part order vector (whose keys [indices] are part order indices, and whose values [contents] are elements)
	12 bytes for the part offset vector (whose keys [indices] are part indices [or else P], and whose values [contents] are the beginning indices of those parts [or else N]; P is implicitly stored as the length of this vector minus one)]

To decide what number is the size of a partition: (- 48 -).

Chapter "Private Partition Construction and Destruction" - unindexed

[Initially, all elements are in the last part.]

To initialize (A - a partition) with (N - a number) elements and (P - a number) parts and capacity for (C - a number) elements:
	if C is less than N:
		now C is N;
	initialize the inverse part order vector of A with capacity C;
	resize the inverse part order vector of A to hold N data;
	initialize the part order vector of A with capacity C;
	resize the part order vector of A to hold N data;
	initialize the part offset vector of A with capacity P plus one;
	resize the part offset vector of A to hold P plus one data;
	repeat with the index running over the half-open interval from zero to N:
		map the index to part order index index in A;
	repeat with the index running over the half-open interval from zero to P:
		write the beginning index zero to part index of A;
	write the beginning index N to part P of A.

To delete the contents of (A - a partition):
	delete the contents of the inverse part order vector of A;
	delete the contents of the part order vector of A;
	delete the contents of the part offset vector of A.	

Chapter "Public Partition Construction and Destruction"

To decide what partition is a new partition of (N - a number) elements into (P - a number) parts:
	let the result be a memory allocation of the size of a partition bytes converted to a partition;
	initialize the result with N elements and P parts and capacity for N elements;
	decide on the result.

To delete (A - a partition):
	delete the contents of A;
	free the memory allocation at address A converted to a number.

Chapter "Private Partition Accessors and Mutators" - unindexed

To decide what vector is the inverse part order vector of (A - a partition): (- {A} -).
To decide what vector is the part order vector of (A - a partition): (- ({A} + 12) -).
To decide what vector is the part offset vector of (A - a partition): (- ({A} + 24) -).

To decide what number is the part order index of (X - a number) in (A - a partition):
	decide on number datum X of the inverse part order vector of A.
To decide what number is the element at part order index (J - a number) in (A - a partition):
	decide on number datum J of the part order vector of A.

To map (X - a number) to part order index (J - a number) in (A - a partition):
	write J to datum X of the inverse part order vector of A;
	write X to datum J of the part order vector of A.

To decide what number is the beginning index of part (I - a number) of (A - a partition):
	decide on number datum I of the part offset vector of A.
To write the beginning index (J - a number) to part (I - a number) of (A - a partition):
	write J to datum I of the part offset vector of A.

To decide what number is the end index of part (I - a number) of (A - a partition):
	decide on number datum I plus one of the part offset vector of A.
To write the end index (J - a number) to part (I - a number) of (A - a partition):
	write J to datum I plus one of the part offset vector of A.

Chapter "Public Partition Accessors and Mutators"

To decide what number is the total cardinality of (A - a partition): (- llo_getField({A}, 1) -).

To decide what number is the part count of (A - a partition): (- (llo_getField({A}, 7) - 1) -).

To decide what number is the cardinality of part (I - a number) of (A - a partition):
	decide on the end index of part I of A minus the beginning index of part I of A.

To decide what number is the first element of part (I - a number) of (A - a partition):
	let the index be the beginning index of part I of A;
	decide on the element at part order index index in A.

To decide what number is the part of (A - a partition) containing (X - a number):
	let the target be the part order index of X in A;
	let the result be zero;
	while the target is at least the end index of part result of A:
		increment the result;
	decide on the result.

To decide whether part (I - a number) of (A - a partition) contains (X - a number):
	let the target be the part order index of X in A;
	decide on whether or not the beginning index of part I of A is at most the target and the end index of part I of A is greater than the target.

To decide whether part (I - a number) of (A - a partition) does not contain (X - a number):
	let the target be the part order index of X in A;
	decide on whether or not the beginning index of part I of A is greater than the target or the end index of part I of A is at most the target.

[I must be one less than the part of A containing X.]
To move (X - a number) down to part (I - a number) of (A - a partition):
	let X's index be the part order index of X in A;
	let Y's index be the end index of part I of A;
	if X's index is not Y's index:
		let Y be the element at part order index Y's index in A;
		map X to part order index Y's index in A;
		map Y to part order index X's index in A;
	write the end index Y's index plus one to part I of A.

[I must be one more than the part of A containing X.]
To move (X - a number) up to part (I - a number) of (A - a partition):
	let X's index be the part order index of X in A;
	let Y's index be the beginning index of part I of A minus one;
	if X's index is not Y's index:
		let Y be the element at part order index Y's index in A;
		map X to part order index Y's index in A;
		map Y to part order index X's index in A;
	write the beginning index Y's index to part I of A.

To move (X - a number) to part (I - a number) of (A - a partition):
	let the part be the part of A containing X;
	while I is less than the part:
		decrement the part;
		move X down to part part of A;
	while I is greater than the part:
		increment the part;
		move X up to part part of A.

Chapter "Partition Resizing"

To resize (A - a partition) to total cardinality (N - a number):
	let the cardinality be the total cardinality of A;
	let the part count be the part count of A;
	if the cardinality is less than N:
		resize the inverse part order vector of A to hold N data;
		resize the part order vector of A to hold N data;
		repeat with the index running over the half-open interval from the cardinality to N:
			map the index to part order index index in A;
		write the beginning index N to part part count of A;
	otherwise if the cardinality is greater than N:
		let the target index be zero;
		let the part be zero;
		repeat with the index running over the half-open interval from zero to the cardinality:
			while the index is at least the beginning index of part part of A:
				write the beginning index target index to part part of A;
				increment the part;
			let the element be the element at part order index index in A;
			if the element is less than N:
				map the element to part order index target index in A;
				increment the target index;
		resize the inverse part order vector of A to hold N data;
		resize the part order vector of A to hold N data;
		write the beginning index N to part part count of A.

Chapter "Iteration over a Part"

To repeat with (I - a nonexisting number variable) running through the elements of part (J - a number) of (A - a partition) begin -- end: (-
	llv_array = llo_getField({A}, 8);
	llv_limit = llo_getField(llv_array,{J} + 1);
	llv_iterator = llo_getField(llv_array, {J});
	llv_array = llo_getField({A}, 5);
	@push llv_array;
	@push llv_limit;
	jump LLO_LOOP_{-counter:LLO_LOOP}_ENTRY;
	for(::)
		if (llo_advance) {
			@pull llv_iterator;
			if (llo_broken) {
				@pull llv_limit;
				@pull llv_array;
				break;
			}
			llv_iterator++;
		.LLO_LOOP_{-advance-counter:LLO_LOOP}_ENTRY;
			@push llv_iterator;
			@stkpeek 1 llv_limit;
			llo_advance = llo_broken = (llv_iterator >= llv_limit);
			if (~~llo_broken) {
				@stkpeek 2 llv_array;
				@aload llv_array llv_iterator {I};
			}
		} else for (llo_oneTime = true, llo_broken = true, llo_advance = true: llo_oneTime && ((llo_oneTime = false), true) || (llo_broken = false):)
-).

Chapter "Partition Debugging" - unindexed

To say (A - a partition):
	say "[bracket]";
	let the limit be the total cardinality of A;
	let the part be zero;
	repeat with the index running over the half-open interval from zero to the limit:
		while the index is at least the beginning index of part part of A:
			say "Part([part]): ";
			increment the part;
		say "[the element at part order index index in A] ";
	say "X[close bracket]".

Book "Solver Data Structures"

Chapter "Variables"

Section "The Variable Kind"

A solver variable is a kind of value.
A solver variable is an invalid solver variable.  [See the note in the book "Extension Information."]
The specification of a solver variable is "A solver variable is a variable in the sense of satisfiability problems: a unnegated statement that cannot meaningfully be broken up in to shorter statements and whose truth is, as yet, unknown.  'The lamp is lit' could be a solver variable, as could 'we have reached the third winning ending'.  'The player's score is neither three nor four' would not (ordinarily) make a good solver variable, but could rather be formed by negating variables for 'the player's score is three' and 'the player's score is four' and then taking their conjunction."

Section "The Variable Structure" - unindexed

[Layout:
	1 (most significant) bit padding
	31 bits for the variable index]

Section "Saying Variables"

To say (V - a solver variable):
	say "V[V converted to a number]".

Chapter "Literals"

Section "The Literal Kind"

A solver literal is a kind of value.
A solver literal is an invalid solver literal.  [See the note in the book "Extension Information."]
The specification of a solver literal is "A solver literal is a literal in the sense of satisfiability problems: a (possibly negated) statement that cannot meaningfully be broken up in to shorter statements and whose truth is, as yet, unknown.  Literals are always either variables or negated variables."

Section "The Literal Structure" - unindexed

[Layout:
	1 (most significant) bit for negation (the bit is set when the literal is negated)
	31 bits for the variable index]

Include (-
	Constant S_NEGATION = $80000000;
	Constant S_VARIABLE_MASK = ~S_NEGATION;
-) after "Definitions.i6t".

Section "Literal Construction"

To decide what solver literal is (V - a solver variable) unnegated: (- {V} -).
To decide what solver literal is (V - a solver variable) negated: (- ({V} | S_NEGATION) -).

To decide what solver literal is (L - a solver literal) negated: (- llo_xor({L}, S_NEGATION) -).

Section "Literal Accessors"

To decide what solver variable is the variable of (L - a solver literal): (- ({L} & S_VARIABLE_MASK) -).
To decide whether (L - a solver literal) is negated: (- ({L} & S_NEGATION) -).
To decide whether (L - a solver literal) is not negated: (- (~~({L} & S_NEGATION)) -).

Section "Saying Literals"

To say (L - a solver literal):
	say "[if L is negated]~[end if][the variable of L]".

Chapter "Clauses"

Section "The Clause Kind"

A solver clause is a kind of value.
A solver clause is an invalid solver clause.  [See the note in the book "Extension Information."]
The specification of a solver clause is "A solver clause is a clause in the sense of satisfiability problems: a disjunction of zero or more (possibly negated) statements.  Clauses are built by combining literals with the logical 'or' operator."

Section "The Clause Structure" - unindexed

[Layout:
	4 bytes for the clause index
	4 bytes for the watch count
	12 bytes for the literal vector (containing watched variables at the lowest indices)]

To decide what number is the size of a solver clause: (- 20 -).

Section "Clause Construction and Destruction"

To decide what solver clause is a new solver clause holding (L - a number) literal/literals:
	let the result be a memory allocation of the size of a solver clause bytes converted to a solver clause;
	write the watch count zero to the result;
	initialize the literal vector of the result with capacity L;
	resize the literal vector of the result to hold L data;
	decide on the result.

To delete (A - a solver clause):
	delete the contents of the literal vector of A;
	free the memory allocation at address A converted to a number.

Section "Private Clause Accessors and Mutators" - unindexed

To decide what number is the clause index of (A - a solver clause): (- llo_getInt({A}) -).
To write the clause index (I - a number) to (A - a solver clause): (- llo_setInt({A}, {I}); -).

To decide what number is the watch count of (A - a solver clause): (- llo_getField({A}, 1) -).
To write the watch count (W - a number) to (A - a solver clause): (- llo_setField({A}, 1, {W}); -).
To decrement the watch count of (A - a solver clause): (- llo_setField({A}, 1, llo_getField({A}, 1) - 1); -).

To decide what vector is the literal vector of (A - a solver clause): (- ({A} + 8) -).

To decide what number is the index at which (A - a solver clause) contains the watched variable (V - a solver variable):
	if V is the variable of literal zero of A:
		decide on zero;
	decide on one.
To decide what number is the watch index that is not (I - a number): (- (1 - {I}) -).

Section "Public Clause Accessors and Mutators"

To decide what number is the literal count of (A - a solver clause): (- llo_getField({A}, 3) -).

To decide what solver literal is literal (I - a number) of (A - a solver clause):
	decide on solver literal datum I of the literal vector of A.
To write (L - a solver literal) to literal (I - a number) of (A - a solver clause):
	write L to datum I of the literal vector of A.

Section "Saying Clauses"

To say (C - a solver clause):
	let the literal vector be the literal vector of C;
	say "(Clause [the clause index of C] [bracket][the watch count of C] watch[if the watch count of C is not one]es[end if][close bracket]:";
	repeat with the literal running through the solver literal data in the literal vector:
		say " [the literal]";
	say ")".

Chapter "Solvers"

Section "The Solver Kind"

An SMT solver is a kind of value.
An SMT solver is an invalid SMT solver.  [See the note in the book "Extension Information."]
The specification of an SMT solver is "A satisfiability modulo theories (SMT) solver decides, given a set of statements, whether or not they can all be true at once."

Section "The SMT Solver Structure" - unindexed

[Layout:
	4 bytes for the decision level (only used for debugging at the moment)
	12 bytes for the assignment vector (indexed by variable, holding assigned truth states)
	12 bytes for the clause vector (indexed by clause index, holding clauses)
	48 bytes for the variable tripartition (into {Assigned, Pending, Unassigned})
	48 bytes for the clause bipartition (into {Inactive, Active})
	4 bytes for the assignment count stack
	4 bytes for the deactivation count stack
	12 bytes for the watch list vector (indexed by variable, holding linked lists of clauses)
	12 bytes for the reason vector (indexed by variable, holding entailing clauses, or a null clause for decision variables)]

To decide what number is the size of an SMT solver: (- 156 -).

Section "SMT Solver Partitions' Parts" - unindexed

To decide what number is the assigned part: (- 0 -).
To decide what number is the pending part: (- 1 -).
To decide what number is the unassigned part: (- 2 -).

To decide what number is the inactive part: (- 0 -).
To decide what number is the active part: (- 1 -).

Section "SMT Solver Construction and Destruction"

To decide what SMT solver is a new SMT solver:
	let the result be a memory allocation of the size of an SMT solver bytes converted to an SMT solver;
	write the decision level zero to the result;
	initialize the assignment vector of the result with capacity the initial variable capacity;
	initialize the clause vector of the result with capacity the initial clause capacity;
	initialize the variable tripartition of the result with zero elements and three parts and capacity for the initial variable capacity elements;
	initialize the clause bipartition of the result with zero elements and two parts and capacity for the initial clause capacity elements;
	write the assignment count stack an empty linked list to the result;
	write the deactivation count stack an empty linked list to the result;
	initialize the watch list vector of the result with capacity the initial variable capacity;
	initialize the reason vector of the result with capacity the initial variable capacity;
	decide on the result.

To delete (A - an SMT solver):
	delete the contents of the assignment vector of A;
	repeat with the clause running through the solver clause data in the clause vector of A:
		delete the clause;
	delete the contents of the clause vector of A;
	delete the contents of the variable tripartition of A;
	delete the contents of the clause bipartition of A;
	repeat with the watch list running through the linked list data in the watch list vector of A:
		delete the watch list;
	delete the contents of the watch list vector of A;
	delete the contents of the reason vector of A;
	free the memory allocation at address A converted to a number.

Section "Private SMT Solver Accessors and Mutators" - unindexed

To decide what number is the decision level of (A - an SMT solver): (- llo_getInt({A}) -).
To write the decision level (I - a number) to (A - an SMT solver): (- llo_setInt({A}, {I}); -).

To decide what vector is the assignment vector of (A - an SMT solver): (- ({A} + 4) -).
To decide what vector is the clause vector of (A - an SMT solver): (- ({A} + 16) -).
To decide what partition is the variable tripartition of (A - an SMT solver): (- ({A} + 28) -).
To decide what partition is the clause bipartition of (A - an SMT solver): (- ({A} + 76) -).
To decide what vector is the watch list vector of (A - an SMT solver): (- ({A} + 132) -).
To decide what vector is the reason vector of (A - an SMT solver): (- ({A} + 144) -).

To decide what linked list is the assignment count stack of (A - an SMT solver): (- ({A}-->31) -).
To write the assignment count stack (X - a linked list) to (A - an SMT solver): (- llo_setField({A}, 31, {X}); -).

To decide what linked list is the deactivation count stack of (A - an SMT solver): (- ({A}-->32) -).
To write the deactivation count stack (X - a linked list) to (A - an SMT solver): (- llo_setField({A}, 32, {X}); -).

To decide what linked list is the watch list for (V - a solver variable) in (A - an SMT solver): (- (llo_getField({A}, 35)-->{V}) -).
To decide what linked list is the watch list for (L - a solver literal) in (A - an SMT solver): (- (llo_getField({A}, 35)-->({L} & S_VARIABLE_MASK)) -).

To write (L - a linked list) to the watch list for (V - a solver variable) in (A - an SMT solver): (- llo_setField(llo_getField({A}, 35), {V}, {L}); -).

To decide what solver clause is the reason clause for (V - a solver variable) in (A - an SMT solver): (- llo_getField(llo_getField({A}, 38), {V}) -).
To decide whether (V - a solver variable) was last a decision variable in (A - an SMT solver): (- (~~llo_getField(llo_getField({A}, 38), {V})) -).

To write the reason clause (X - a solver clause) to (V - a solver variable) in (A - an SMT solver): (- llo_setField(llo_getField({A}, 38), {V}, {X}); -).
To write no reason clause to (V - a solver variable) in (A - an SMT solver): (- llo_setField(llo_getField({A}, 38), {V}, 0); -).

To decide whether (V - a solver variable) is assigned in (A - an SMT solver):
	decide on whether or not part assigned part of the variable tripartition of A contains V converted to a number.

To decide whether (V - a solver variable) is pending in (A - an SMT solver):
	decide on whether or not part pending part of the variable tripartition of A contains V converted to a number.

To decide whether (V - a solver variable) is determined [assigned or pending] in (A - an SMT solver):
	decide on whether or not part unassigned part of the variable tripartition of A does not contain V converted to a number.

To decide whether (V - a solver variable) is unassigned in (A - an SMT solver):
	decide on whether or not part unassigned part of the variable tripartition of A contains V converted to a number.

To decide whether (L - a solver literal) is assigned in (A - an SMT solver):
	decide on whether or not the variable of L is assigned in A.

To decide whether (L - a solver literal) is pending in (A - an SMT solver):
	decide on whether or not the variable of L is pending in A.

To decide whether (L - a solver literal) is determined in (A - an SMT solver):
	decide on whether or not the variable of L is determined in A.

To decide whether (L - a solver literal) is unassigned in (A - an SMT solver):
	decide on whether or not the variable of L is unassigned in A.

Section "Public SMT Solver Accessors and Mutators"

To decide what number is the variable count of (A - an SMT solver): (- llo_getField({A}, 2) -).

To decide what solver variable is variable (I - a number) of (A - an SMT solver): (- {I} -).

To decide what solver variable is a new variable in (A - an SMT solver):
	let the variable count be the variable count of A;
	let the result be the variable count converted to a solver variable;
	increment the variable count;
	resize the assignment vector of A to hold the variable count data;
	resize the variable tripartition of A to total cardinality variable count;
	resize the watch list vector of A to hold the variable count data;
	write an empty linked list to datum variable count minus one of the watch list vector of A;
	resize the reason vector of A to hold the variable count data;
	decide on the result.

To decide whether (V - a solver variable) is assigned false in (A - an SMT solver):
	decide on whether or not the truth state datum V converted to a number of the assignment vector of A is false.

To decide whether (V - a solver variable) is assigned true in (A - an SMT solver):
	decide on the truth state datum V converted to a number of the assignment vector of A.

To decide what number is the clause count of (A - an SMT solver): (- llo_getField({A}, 5) -).

To decide what solver clause is clause (I - a number) of (A - an SMT solver): (- llo_getField(llo_getField({A}, 6), {I}) -).

To add (C - a solver clause) to (A - an SMT solver):
	let the clause count be the clause count of A;
	write the clause index the clause count to C;
	increment the clause count;
	resize the clause vector of A to hold the clause count data;
	write C to datum clause count minus one of the clause vector of A;
	resize the clause bipartition of A to total cardinality clause count;
	let the watch count be zero;
	let the limit be the literal count of C;
	repeat with the index running over the half-open interval from zero to the limit:
		let the literal be literal index of C;
		unless the literal is determined in A:
			unless the index is the watch count:
				let the other literal be literal watch count of C;
				write the literal to literal watch count of C;
				write the other literal to literal index of C;
			push the key C onto the watch list for the literal in A;
			increment the watch count;
			if the watch count is two:
				break;
	if the watch count is:
		-- zero:
			fail at adding a clause whose truth is already determined, that being as yet unimplemented;
			[////]
			let the truth of the clause be false;
			repeat with the index running over the half-open interval from zero to the limit:
				let the literal be literal index of C;
			[////]
		-- one:
			entail literal zero of C from C in A;
	write the watch count the watch count to C.

Book "Solver Algorithms"

Chapter "Learning" - unindexed

The learning solver is an SMT solver that varies.

To decide what number is the rank of (L - a solver literal) in the learning solver (this is ranking solver variables by assignment order):
	decide on zero minus the part order index of the variable of L converted to a number in the variable tripartition of the learning solver.

To expand the learned clause (H - a hash table) and the intermediate implicant queue (Q - a priority queue) with the knowledge that (L - a solver literal) was implied by (C - a solver clause):
	let the literal vector be the literal vector of C;
	repeat with the literal running through the solver literal data in the literal vector:
		unless the literal is L:
			if the variable of the literal was last a decision variable in the learning solver:
				unless H contains the key the literal:
					insert the key the literal into H;
			otherwise:
				enqueue the literal negated in Q with ranking phrase ranking solver variables by assignment order.

To decide what solver clause is (H - a hash table) as a solver clause:
	let the result be a new solver clause holding the number of entries in H literals;
	let the literal vector be the literal vector of the result;
	let the index be zero;
	repeat with the literal running through the solver literal keys of H:
		write the literal to datum index of the literal vector;
		increment the index;
	decide on the result.

To decide what solver clause is a new clause learned from (C - a solver clause) implying the conflicting assertion of (L - a solver literal) in (A - an SMT solver):
	now the learning solver is A;
	let the learned clause be a new hash table with the clause learning hash table size buckets;
	let the intermediate implicant queue be a new priority queue with capacity the cardinality of part assigned part of the variable tripartition of A;
	let the previous rank be the rank of L in the learning solver minus one;
	enqueue L negated in the intermediate implicant queue with ranking phrase ranking solver variables by assignment order; [Deal with the implication of not L.]
	expand the learned clause the learned clause and the intermediate implicant queue the intermediate implicant queue with the knowledge that L was implied by C; [Deal with the implication of L.]
	while size of the intermediate implicant queue is greater than zero:
		let the resolution literal be a solver literal dequeued from the intermediate implicant queue with ranking phrase ranking solver variables by assignment order;
		let the rank be the rank of the resolution literal in the learning solver;
		if the rank is greater than the previous rank:
			expand the learned clause the learned clause and the intermediate implicant queue the intermediate implicant queue with the knowledge that the resolution literal was implied by the reason clause for the variable of the resolution literal in A;
			now the previous rank is the rank;
	let the result be the learned clause as a solver clause;
	delete the learned clause;
	decide on the result.

Chapter "Watch Replacement with Learning and Entailment" - unindexed

To entail (L - a solver literal) from (C - a solver clause) in (A - an SMT solver):
	let the sign be whether or not L is not negated;
	let the variable be the variable of L;
	let the variable index be the variable converted to a number;
	move the variable index down to part pending part of the variable tripartition of A;
	write the reason clause C to the variable in A;
	write the sign to datum variable index of the assignment vector of A.

To decide what solver clause is a new clause learned from (A - an SMT solver) trying to find a replacement for (V - a solver variable) that (C - a solver clause) can watch:
	[Case I: C is has already been satisfied by some unwatched variable's assignment, and does not need to watch variables.]
	let the clause index be the clause index of C;
	let the clause bipartition be the clause bipartition of A;
	if part inactive part of the clause bipartition contains the clause index:
		decrement the watch count of C;
		decide on an invalid solver clause;
	[Case II: C has just been satisfied by V's assignment, and does not need to watch variables.]
	let the pivot index be the index at which C contains the watched variable V;
	let the literal be literal pivot index of C;
	always check that the variable of the literal is V or else fail at replacing an unwatched variable;
	if (whether or not V is assigned false in A) is (whether or not the literal is negated):
		move the clause index down to part inactive part of the clause bipartition;
		decrement the watch count of C;
		decide on an invalid solver clause;
	let the literal count be the literal count of C;
	[Case III: C will be satisfied by some unwatched variable's assignment, and does not need to watch variables.]
	repeat with the replacement index running over the half-open interval from two to the literal count:
		let the replacement literal be literal replacement index of C;
		if the replacement literal is pending in A:
			if (whether or not the variable of the replacement literal is assigned false in A) is (whether or not the replacement literal is negated):
				move the clause index down to part inactive part of the clause bipartition;
				decrement the watch count of C;
				decide on an invalid solver clause;
	[Case IV: C is not satisfied by unwatched variables, but may be in the future; we should watch for that.]
	repeat with the replacement index running over the half-open interval from two to the literal count:
		let the replacement literal be literal replacement index of C;
		if the replacement literal is unassigned in A:
			write the literal to literal replacement index of C;
			write the replacement literal to literal pivot index of C;
			push the key C onto the watch list for the replacement literal in A;
			decide on an invalid solver clause;
	[Case V: C is cannot be satisfied by unwatched variables, and the only remaining variable is already determined.]
	let the unit literal be literal (the watch index that is not the pivot index) of C;
	if the unit literal is pending in A:
		if (whether or not the variable of the unit literal is assigned false in A) is (whether or not the unit literal is negated):
			move the clause index down to part inactive part of the clause bipartition;
			decrement the watch count of C;
			decide on an invalid solver clause;
		decide on a new clause learned from C implying the conflicting assertion of the unit literal in A;
	[Case VI: C is unsatisfied by unwatched variables and determines the only remaining variable.]
	always check that the variable of the unit literal is unassigned in A or else fail at entailing a determined variable;
	entail the unit literal from C in A;
	move the clause index down to part inactive part of the clause bipartition;
	decrement the watch count of C;
	decide on an invalid solver clause.

To decide what solver clause is a new clause learned from (A - an SMT solver) trying to find replacements for (V - a solver variable) that its clauses can watch:
	always check that V is assigned in A or else fail at replacing an undetermined variable;
	let the watch list be the watch list for V in A;
	while the watch list is not empty:
		let the clause be a solver clause key popped off of the watch list;
		let the learned clause be a new clause learned from A trying to find a replacement for V that the clause can watch;
		unless the learned clause is an invalid solver clause:
			push the key the clause [back] onto the watch list;
			write the watch list to the watch list for V in A;
			decide on the learned clause;
	write the watch list to the watch list for V in A;
	decide on an invalid solver clause.

Chapter "Decision Making with Learning" - unindexed

To decide what solver clause is a new clause learned from (A - an SMT solver) trying to make a decision:
	let the variable tripartition be the variable tripartition of A;
	always check that the cardinality of part pending part of the variable tripartition is zero or else fail at making a decision when assignments are pending;
	push the key the cardinality of part assigned part of the variable tripartition onto the assignment count stack of A;
	push the key the cardinality of part inactive part of the clause bipartition of A onto the deactivation count stack of A;
	[//// We should use a heuristic here to pick variables more cleverly.]
	let the decision variable index be the first element of part unassigned part of the variable tripartition;
	let the decision variable be the decision variable index converted to a solver variable;
	[//// We should use a heuristic here to pick polarities more cleverly.]
	write false to datum decision variable index of the assignment vector of A;
	write no reason clause to the decision variable in A;
	move the decision variable index to part assigned part of the variable tripartition;
	decide on a new clause learned from A trying to find replacements for the decision variable that its clauses can watch.

Chapter "Entailment Processing with Learning" - unindexed

To decide what solver clause is a new clause learned from (A - an SMT solver) trying to make an entailed assignment:
	let the variable tripartition be the variable tripartition of A;
	always check that the cardinality of part pending part of the variable tripartition is greater than zero or else fail at processing a pending assignment when no assignments are pending;
	let the entailed variable index be the first element of part pending part of the variable tripartition;
	let the entailed variable be the entailed variable index converted to a solver variable;
	move the entailed variable index down to part assigned part of the variable tripartition;
	decide on a new clause learned from A trying to find replacements for the entailed variable that its clauses can watch.

Chapter "Backtracking" - unindexed

To decide whether (A - an SMT solver) successfully backtracks:
	if the assignment count stack of A is empty:
		decide no;
	let the variable tripartition be the variable tripartition of A;
	let the clause bipartition be the clause bipartition of A;
	let the assignment count be a number key popped off of the assignment count stack of A;
	let the deactivation count be a number key popped off of the deactivation count stack of A;
	let the limit be the beginning index of part active part of the clause bipartition;
	repeat with the clause index index running over the half-open interval from the deactivation count to the limit [i.e, over indices of indices of clauses to reactivate]:
		let the clause index be the element at part order index (clause index index) in the clause bipartition;
		let the reactivated clause be clause clause index of A;
		if the watch count of the reactivated clause is zero:
			push the key the reactivated clause onto the watch list for literal zero of the reactivated clause in A;
			push the key the reactivated clause onto the watch list for literal one of the reactivated clause in A;
			write the watch count two to the reactivated clause;
		otherwise:
			let the candidate variable be the variable of literal zero of the reactivated clause;
			if the candidate variable is assigned in A:
				push the key the reactivated clause onto the watch list for the candidate variable in A;
			otherwise:
				let the other candidate variable be the variable of literal one of the reactivated clause;
				push the key the reactivated clause onto the watch list for the other candidate variable in A;
			write the watch count two to the reactivated clause;
	write the beginning index assignment count to part pending part of the variable tripartition;
	write the beginning index assignment count to part unassigned part of the variable tripartition;
	write the beginning index deactivation count to part active part of the clause bipartition;
	decide yes.

Chapter "Solving"

To decide whether (A - an SMT solver) finds a solution:
	let the variable tripartition be the variable tripartition of A;
	while the cardinality of part unassigned part of the variable tripartition is not zero or the cardinality of part pending part of the variable tripartition is not zero:
		let the learned clause be an invalid solver clause;
		if the cardinality of part pending part of the variable tripartition is zero:
			now the learned clause is a new clause learned from A trying to make a decision;
		otherwise:
			now the learned clause is a new clause learned from A trying to make an entailed assignment;
		unless the learned clause is an invalid solver clause:
			unless A successfully backtracks:
				delete the learned clause;
				decide no;
			add the learned clause to A;
	decide yes.

Solver ends here.

---- DOCUMENTATION ----

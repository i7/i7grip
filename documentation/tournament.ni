"Tournament" by Brady Garvin.

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

Version 1 of Runtime Checks (for Glulx only) by Brady Garvin begins here.

"Phrases for testing authorial expectations at runtime."

Include Low-Level Operations by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This extension is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this extension.  If not, see <http://www.gnu.org/licenses/>.]

Book "Extension Information"

Chapter "Use Options"

Use runtime checks even in a released version of the story translates as (- Constant RC_ENABLE_ASSERTIONS; -).

Include (-
	#ifndef RC_ENABLE_ASSERTIONS;
	#ifdef DEBUG;
	Constant RC_ENABLE_ASSERTIONS;
	#endif;
	#endif;
-) after "Definitions.i6t".

Chapter "Rulebooks"

The environment check rules are [rulebook is] a rulebook.

This is the environment check stage rule:
	traverse the environment check rules.
The environment check stage rule is listed first in the startup rulebook.  [We cannot just write ``A first startup rule...'' because the startup rulebook gets special treatment when rules are sorted.]

Book "Terminating the Story"

To terminate the story: (- quit; -).

Book "Runtime Checks"

To check that (C - a condition) or else (P - a phrase): (- if(true){-open-brace} #ifdef RC_ENABLE_ASSERTIONS; if(~~{C}) {P} {-close-brace} #endif; -).
To always check that (C - a condition) or else (P - a phrase): (- if(~~{C}) {P} -).

Book "Presentation of Runtime Failures"

Chapter "Glulx Typefaces"

To say warning type: (- glk_set_style(style_Alert); -).

Chapter "Glulx Visibility Assurance" - unindexed

Include (-
	Global rc_mustTerminate=false;
	[ rc_ensureVisibility root window iosystem iorock;
		if(rc_mustTerminate){
			return;
		}
		@getiosys iosystem iorock;
		if(~~iosystem){
			@setiosys 2 0;
		}
		root=glk_window_get_root();
		if(root){
			window=glk_window_open(root,winmethod_Above|winmethod_Fixed,12,wintype_TextBuffer,-4123);
		}else{
			window=glk_window_open(0,0,0,wintype_TextBuffer,-4123);
		}
		if(window){
			glk_set_window(window);
			rc_mustTerminate=true;
		}
	];
-) after "Definitions.i6t".

To decide what number is the address of I6_rc_ensureVisibility: (- rc_ensureVisibility -).
To ensure failure visibility: (- rc_ensureVisibility(); -).
To decide whether the runtime failure must terminate the story: (- rc_mustTerminate -).

Chapter "Segmented Substitutions"

To say runtime failure in -- beginning say_runtime_failure_in -- running on:
	say "[line break][warning type]*** Runtime failure in ".

To say low-level runtime failure in -- beginning say_runtime_failure_in -- running on:
	ensure failure visibility;
	say "[line break][warning type]*** Runtime failure in ".

To say with explanation -- continuing say_runtime_failure_in -- running on:
	say ": ".

To say continuing anyway -- ending say_runtime_failure_in -- running on:
	if the runtime failure must terminate the story:
		say " ***[line break]*** I would attempt to continue anyway, but the failure was low-level, and I had to change the Glk window tree to reliably report it.  I've terminated the story instead. ***[roman type][line break]";
		terminate the story;
	say " ***[line break]*** Attempting to continue anyway... ***[roman type][line break]".

To say terminating the story -- ending say_runtime_failure_in -- running on:
	say " ***[line break]*** Continuing further seems like a bad idea, so I've terminated the story. ***[roman type][line break]";
	terminate the story.

Chapter "Story Title"

To decide what text is the story title: (- Story -).

Runtime Checks ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

The phrases in Runtime Checks let us verify that our expectations hold
throughout a story, or react if they don't.  For instance,

	check that the time of day is after 6:30 PM or else say "[runtime failure in]the shooting star sequence[with explanation]The shooting star is supposed to appear after sunset, but the current time is only [the time of day].[continuing anyway]";

Details are in the following chapters.

Chapter: Usage

Occasionally our source text will make assumptions about the state of affairs,
and as authors we have to be aware of these assumptions to write a logically
consistent story.  Take this snippet for instance:

	After going to the cryocell:
		say "[The nemesis] slips behind you and yanks the door shut.  Click!  It's locked!";
		now the cryocell door is closed;
		now the cryocell door is locked;
		freezing begins in three minutes from now.
	At the time when freezing begins:
		say "Icy clouds pour in through the vents.  You beat on the walls until it's too painful.";
		end the story saying "You have been defeated."

The first rule assumes that the nemesis is nearby when the player enters the
cryocell, and the second assumes that, having entered it, the player cannot
escape.  In a full length story, even the most thoroughly implemented, these
assumptions can pile up.

Runtime Checks gives us phrases that help out in two ways.  First, they document
assumptions in case we forget them (and also in case someone else needs to
understand our source text).  Second, they check that these assumptions hold
when the story is played.

Actually, this is already possible without any extensions; one way would be to
find the point at which an assumption should hold and write

	unless (C - a condition), (P - a phrase)

where C is what we expect to be true no matter what the player does, and P is
how to react if the player proves us wrong.  Runtime Checks alters the syntax
only slightly, to

	check that (C - a condition) or else (P - a phrase)

so that we can distinguish at a glance the lines that deal with authorial
expectations.  To improve performance, it also removes these checks when the
story is released, with two exceptions: If we say

	Use runtime checks even in a released version of the story.

no checks are removed, and if we place the word "always" before a check, as in

	always check that (C - a condition) or else (P - a phrase)

that particular check will never be removed.

Returning to the example, we might write

	After going to the cryocell:
		check that the nemesis is enclosed by the room gone from or else say "(Shouldn't [the nemesis] be in [the room gone from]?)";
		say "[The nemesis] slips behind you and yanks the door shut.  Click!  It's locked!";
		now the cryocell door is closed;
		now the cryocell door is locked;
		freezing begins in three minutes from now.
	At the time when freezing begins:
		check that the player is enclosed by the cryocell or else say "(Shouldn't [the player] be in [the cryocell]?)";
		say "Icy clouds pour in through the vents.  You beat on the walls until it's too painful.";
		end the story saying "You have been defeated."

Here we have opted to give a parenthetical note whenever something strange
happens.  If we wish, Runtime Checks also has stock phrases for reporting
surprises.  We could write something like

	check that the nemesis is enclosed by the room gone from or else say "[runtime failure in]the cryocell trap[with explanation][The nemesis] should be in [the room gone from] so that [it-they of the nemesis] can lock the player in, but right now [the nemesis] is in [the location of the nemesis].[continuing anyway]"

which uses the three substitutions

	"[runtime failure in]"

	"[with explanation]"

and

	"[continuing anyway]"

to produce the text

	*** Runtime failure in the cryocell trap: The giant robot's evil twin should be in the underground lab so that it can lock the player in, but right now the giant robot's evil twin is in the flying fortress. ***
	*** Attempting to continue anyway... ***

in the interpreter's type style for warnings, which we can otherwise achieve by
including Runtime Checks and invoking the substitution

	"[warning type]"

If something very bad happens, and we can't recover, we would want to replace

	"[continuing anyway]"

with

	"[terminating the story]"

as in

	To set up the next episode:
		check that the list of undefeated nemeses is not empty or else say "[runtime failure in]setting up the next episode[with explanation]There are no more nemeses for the player to face.  The season should have ended when the previous nemesis, [the nemesis], was defeated.[terminating the story]"
		....

which yields the text

	*** Runtime failure in setting up the next episode: There are no more nemeses for the player to face.  The season should have ended when the previous nemesis, the Martian manticore, was defeated. ***
	*** Continuing further seems like a bad idea, so I've terminated the story. ***

and then brings the story to an immediate halt.

For really exceptional cases---such as when we're fiddling with the status line
or other Glk windows, and the failure message might not be visible if we printed
it directly---we would want to use the substitution

	"[low-level runtime failure in]"

which should always be paired with

	"[terminating the story]"

To illustrate,

	check that the list of viable window streams is not empty or else say "[low-level runtime failure in]the Glk stream-juggling machinery[with explanation]the viable window streams have been exhausted.[terminating the story]";

Runtime failures marked as low-level will be reported in a brand new Glk window,
if possible.  For most interpreters, this is enough to guarantee that they will
be visible.  The alternative is just to end the story silently:

	check that the list of viable window streams is not empty or else terminate the story;

Finally, as a convenience, Runtime Checks defines a text constant

	the story title

in case the failure involves the entire story.  Usually we use this constant in
rules added to the

	the environment check rulebook

which is specifically for low-level runtime checks that should happen before the
story begins.  For instance, if we depend on an optional interpreter feature
like dynamic memory allocation, we might use a phrase from Low-Level Operations
and write

	*: An environment check rule (this is the check for dynamic memory allocation to support procedural nemesis creation rule):
		always check that memory allocation is supported or else say "[low-level runtime failure in][the story title][with explanation]This story needs dynamic memory allocation (which your interpreter does not support) in order to create nemeses on the fly.[terminating the story]".

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

Runtime Checks was prepared as part of the Glulx Runtime Instrumentation Project
(https://sourceforge.net/projects/i7grip/).  For this first edition of the
project, special thanks go to these people, in chronological order:

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

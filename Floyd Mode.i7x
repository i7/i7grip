Version 1 of Floyd Mode (for Glulx only) by Brady Garvin begins here.

"Emulation of command line and MUD interpreters (like Floyd)."

Include Low-Level Operations by Brady Garvin.
Include Glk Interception by Brady Garvin.

Use authorial modesty.

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

Chapter "Use Options"

Use window splitting even in Floyd mode translates as (- Constant FM_WINDOWS_OKAY; -).
Use text styles even in Floyd mode translates as (- Constant FM_STYLES_OKAY; -).
Use graphics even in Floyd mode translates as (- Constant FM_GRAPHICS_OKAY; -).
Use sounds even in Floyd mode translates as (- Constant FM_SOUNDS_OKAY; -).
Use hyperlinks even in Floyd mode translates as (- Constant FM_HYPERLINKS_OKAY; -).
Use timers even in Floyd mode translates as (- Constant FM_TIMERS_OKAY; -).

Book "Floyd Mode"

Chapter "Window Splitting" - unindexed

The Glk layer after forbidding window splitting is a Glk layer that varies.

To forbid window splitting (this is forbidding window splitting):
	if the function selector of the current Glk invocation is 35 [glk_window_open]:
		ensure that the current Glk invocation has at least one argument;
		if argument number zero of the current Glk invocation is not zero:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
			stop;
	delegate the current Glk invocation to the Glk layer after forbidding window splitting.

Chapter "Styles" - unindexed

The Glk layer after forbidding text styles is a Glk layer that varies.

To forbid text styles (this is forbidding text styles):
	if the function selector of the current Glk invocation is 134 [glk_set_style] or the function selector of the current Glk invocation is 135 [glk_set_style_stream] or the function selector of the current Glk invocation is 178 [glk_style_distinguish] or the function selector of the current Glk invocation is 179 [glk_style_measure]:
		delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		stop;
	delegate the current Glk invocation to the Glk layer after forbidding text styles.

Chapter "Graphics" - unindexed

To decide what number is the graphics gestalt: (- gestalt_Graphics -).
To decide what number is the image drawing gestalt: (- gestalt_DrawImage -).
To decide what number is the transparent graphics gestalt: (- gestalt_GraphicsTransparency -).

The Glk layer after forbidding graphics is a Glk layer that varies.

To forbid graphics (this is forbidding graphics):
	if the function selector of the current Glk invocation is 4 [glk_gestalt] or the function selector of the current Glk invocation is 5 [glk_gestalt_ext]:
		ensure that the current Glk invocation has at least one argument;
		if argument number zero of the current Glk invocation is the graphics gestalt or argument number zero of the current Glk invocation is the image drawing gestalt or argument number zero of the current Glk invocation is the transparent graphics gestalt:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
			stop;
	otherwise if the function selector of the current Glk invocation is 224 [glk_image_get_info] or the function selector of the current Glk invocation is 225 [glk_image_draw] or the function selector of the current Glk invocation is 226 [glk_image_draw_scaled] or the function selector of the current Glk invocation is 235 [glk_window_set_background_color] or the function selector of the current Glk invocation is 234 [glk_window_fill_rect] or the function selector of the current Glk invocation is 233 [glk_window_erase_rect] or the function selector of the current Glk invocation is 232 [glk_window_flow_break]:
		delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		stop;
	delegate the current Glk invocation to the Glk layer after forbidding graphics.

Chapter "Sound" - unindexed

To decide what number is the sound gestalt: (- gestalt_Sound -).
To decide what number is the music sound gestalt: (- gestalt_SoundMusic -).
To decide what number is the sound volume gestalt: (- gestalt_SoundVolume -).
To decide what number is the sound notification gestalt: (- gestalt_SoundNotify -).

The Glk layer after forbidding sound is a Glk layer that varies.

To forbid sound (this is forbidding sound):
	if the function selector of the current Glk invocation is 4 [glk_gestalt] or the function selector of the current Glk invocation is 5 [glk_gestalt_ext]:
		ensure that the current Glk invocation has at least one argument;
		if argument number zero of the current Glk invocation is the sound gestalt or argument number zero of the current Glk invocation is the music sound gestalt or argument number zero of the current Glk invocation is the sound volume gestalt or argument number zero of the current Glk invocation is the sound notification gestalt:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
			stop;
	otherwise if the function selector of the current Glk invocation is 242 [glk_schannel_create] or the function selector of the current Glk invocation is 243 [glk_schannel_destroy] or the function selector of the current Glk invocation is 248 [glk_schannel_play] or the function selector of the current Glk invocation is 249 [glk_schannel_play_ext] or the function selector of the current Glk invocation is 250 [glk_schannel_stop] or the function selector of the current Glk invocation is 251 [glk_schannel_set_volume] or the function selector of the current Glk invocation is 252 [glk_sound_load_hint]:
		delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		stop;
	delegate the current Glk invocation to the Glk layer after forbidding sound.

Chapter "Hyperlinks" - unindexed

To decide what number is the hyperlink gestalt: (- gestalt_Hyperlinks -).
To decide what number is the hyperlink input gestalt: (- gestalt_HyperlinkInput -).

The Glk layer after forbidding hyperlinks is a Glk layer that varies.

To forbid hyperlinks (this is forbidding hyperlinks):
	if the function selector of the current Glk invocation is 4 [glk_gestalt] or the function selector of the current Glk invocation is 5 [glk_gestalt_ext]:
		ensure that the current Glk invocation has at least one argument;
		if argument number zero of the current Glk invocation is the hyperlink gestalt or argument number zero of the current Glk invocation is the hyperlink input gestalt:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
			stop;
	otherwise if the function selector of the current Glk invocation is 256 [glk_set_hyperlink] or the function selector of the current Glk invocation is 257 [glk_set_hyperlink_stream]:
		delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		stop;
	delegate the current Glk invocation to the Glk layer after forbidding hyperlinks.

Chapter "Timers" - unindexed

To decide what number is the timer gestalt: (- gestalt_Timer -).

The Glk layer after forbidding timers is a Glk layer that varies.

To forbid timers (this is forbidding timers):
	if the function selector of the current Glk invocation is 4 [glk_gestalt] or the function selector of the current Glk invocation is 5 [glk_gestalt_ext]:
		ensure that the current Glk invocation has at least one argument;
		if argument number zero of the current Glk invocation is the timer gestalt:
			delegate the current Glk invocation to a do-nothing layer returning zero stack results;
			stop;
	otherwise if the function selector of the current Glk invocation is 214 [glk_request_timer_events]:
		delegate the current Glk invocation to a do-nothing layer returning zero stack results;
		stop;
	delegate the current Glk invocation to the Glk layer after forbidding timers.

Chapter "Layering"

A Glk layering rule (this is the forbid selected Glk operations in Floyd mode rule):
	if the window splitting even in Floyd mode option is inactive:
		install forbidding window splitting as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after forbidding window splitting be the layer it should delegate to;
	if the text styles even in Floyd mode option is inactive:
		install forbidding text styles as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after forbidding text styles be the layer it should delegate to;
	if the graphics even in Floyd mode option is inactive:
		install forbidding graphics as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after forbidding graphics be the layer it should delegate to;
	if the sounds even in Floyd mode option is inactive:
		install forbidding sound as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after forbidding sound be the layer it should delegate to;
	if the hyperlinks even in Floyd mode option is inactive:
		install forbidding hyperlinks as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after forbidding hyperlinks be the layer it should delegate to;
	if the timers even in Floyd mode option is inactive:
		install forbidding timers as a Glk layer whose notifications are handled by the default value of phrase Glk layer notification -> nothing and let the Glk layer after forbidding timers be the layer it should delegate to.

Section "Layering above the Debugger Layer" (for use with Interactive Debugger by Brady Garvin)

The forbid selected Glk operations in Floyd mode rule is listed after the debugger window wrapper rule in the Glk layering rulebook.

Floyd Mode ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

Floyd Mode hides interpreter capabilities from the story so that we can test
playability under restricted settings: playing on the command line or via Floyd
of Club Floyd fame.  Window splitting, text styles, graphics, sounds,
hyperlinks, and timers are all disabled, though we can reinstate these
capabilities on an individual basis.

Details are in the following chapters.

Chapter: Usage

When Floyd Mode is included, all of the interpreter capabilities not supported
by Floyd are disabled.  We can selectively re-enable them with use options:

	Use window splitting even in Floyd mode.

	Use text styles even in Floyd mode.

	Use graphics even in Floyd mode.

	Use sounds even in Floyd mode.

	Use hyperlinks even in Floyd mode.

	Use timers even in Floyd mode.

Otherwise there is nothing else that we need to do.

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform 6G60.  It will probably function on newer
versions, and it may function under slightly older versions, though there is no
guarantee.

Floyd Mode is subject to the caveats for the Glulx Runtime Instrumentation
Framework; see the requirements chapter in its documentation for the technical
details.

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

Floyd Mode was prepared as part of the Glulx Runtime Instrumentation Project
(https://github.com/i7/i7grip).  For this first edition of the project, special
thanks go to these people, in chronological order:

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

For Floyd Mode in particular, I am grateful to Andrew Plotkin for suggesting an
in-IDE mechanism to force these limitations.

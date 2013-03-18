Version 1 of Compiler Version Checks by Brady Garvin begins here.

"Phrases for checking the version of the I7 compiler."

Use authorial modesty.  [This doesn't work in 4U67 or earlier.]

Book "Copyright and License"

[Copyright 2013 Brady J. Garvin]

[This extension is released under the Creative Commons Attribution 3.0 Unported License (CC BY 3.0) so that it can qualify as a public Inform extension.  See the LICENSE file included in the release for further details.]

Book "Extension Information"

[Nothing to mention here in the present version.]

Book "Compiler Versions"

Chapter "Z-Machine Implementation" (for Z-machine only)

[We only have 16 bits, so we rely on the number-letter-number-number convention.]
[Assuming that that convention holds, we never use the sign bit, so there's no need to translate the result for signed comparisons.]
Include (-
	Array NIVersionBuffer -> 6;
	[ ConvertNIVersionToNumber version result;
		version.print_to_array(NIVersionBuffer,6);
		result=2600*((NIVersionBuffer->2)-48);
		result=result+100*((NIVersionBuffer->3)-64);
		result=result+10*((NIVersionBuffer->4)-48);
		result=result+((NIVersionBuffer->5)-48);
		return result;
	];
-).

Chapter "Glulx Implementation" (for Glulx only)

[With 32 bits, we just care that versions advance asciibetically.]
[Assuming that the first character is ASCII, we don't use the sign bit, so again there is no need to worry about signed/unsigned issues.]
Include (-
	Array NIVersionBuffer -> 8;
	[ ConvertNIVersionToNumber version iosystem iorock;
		@getiosys iosystem iorock;
		if(~~iosystem){
			@setiosys 2 0;
		}
		version.print_to_array(NIVersionBuffer,8);
		return NIVersionBuffer-->1;
	];
-).

Chapter "Phrases"

To decide what text is the formatted current compiler version: (- NI_BUILD_COUNT -).
To decide what number is the current compiler version: (- ConvertNIVersionToNumber(NI_BUILD_COUNT) -).
To decide what number is compiler version (V - some text): (- ConvertNIVersionToNumber({V}) -).

Compiler Version Checks ends here.

---- DOCUMENTATION ----

Chapter: Synopsis

With Compiler Version Checks we can write rules and phrases that change their
behavior depending on the version of Inform that the story is built with.  For
instance,

	unless the current compiler version is at least compiler version "6G60":
		....

Details are in the following chapters.

Chapter: Usage

Compiler Version Checks makes the current compiler version available in two
forms: as a four-character text, like "6E92" or "6G60", and as a numeric
encoding of the text, such as 910506290 or 910636592 (smaller numbers are used
on the Z-machine).  We write the phrase

	the formatted current compiler version

for the former and just

	the current compiler version

for the latter.  For example,

	*: When play begins:
		say "This story was compiled under version [the formatted current compiler version].  As a number, that's [the current compiler version]."

The purely numeric form is useful when we want to compare the current compiler
version against another legal version number.  Extensions, for instance, may
want to warn about potential compatibility issues:

	*: When play begins:
		if the current compiler version is greater than compiler version "6G60":
			say "Warning: The quux extension hasn't yet been tested with this version of Inform."

or

	*: When play begins:
		if the current compiler version is at most compiler version "5Z71":
			say "Warning: The quux extension is known to provoke runtime problems with this version of Inform."

Notice that we can encode text as a version number by writing "compiler version"
before it.  Because this works for any text that follows the
number-letter-number-number format (and doesn't include substitutions), we can
even compare against versions that did not exist when Compiler Version Checks
was prepared:

	*: When play begins:
		if the current compiler version is at least compiler version "9Z98":
			say "Warning: Inform is about to run out of version numbers."

Chapter: Requirements, Limitations, and Bugs

This version was tested with Inform versions 4S08 through 6G60.  For Inform
versions 4S08 through 4U67, we must remove the authorial modesty option from the
extension, as it wasn't yet supported.  Versions 4W37 and later have no caveats,
and the extension will probably function on newer versions also.

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

Compiler Version Checks was prepared as part of the Glulx Runtime
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

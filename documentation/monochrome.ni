"Monochrome" by Brady Garvin.

Include Interactive Debugger by Brady Garvin.
The name of the symbolic link to the debug information file is "...".
The name of the symbolic link to the intermediate I6 file is "...".
The name of the symbolic link to the debugging log file is "...".

Monochromatic is a truth state that varies.  Monochromatic is false.

Drawing Room is a room.
The table is a supporter in the drawing room.  The description is "A low coffee table, mahogany, to guess from the [if monochromatic is true]dark gray[otherwise]reddish-brown[end if] color."
The bowl is a container on the table.  The description is "Ceramic[if monochromatic is true] and glaringly white[otherwise], in a stunning lemon yellow[end if]."
The fruit is an edible thing in the bowl.  The indefinite article is "some".  The description is "[if monochromatic is true]Three silvery apples[otherwise]Two red apples, a green one,[end if] and a [if monochromatic is true]charcoal [end if]pear."

The player carries a whiteboard.  The whiteboard has some indexed text called the image.  The image of the whiteboard is "".  The description of the whiteboard is "[if the image of the whiteboard is empty]It's blank.[otherwise]It shows [the image of the whiteboard][end if]".

Drawing is an action applying to one thing.
Understand "draw [something]" as drawing.
Carry out drawing:
	now the image of the whiteboard is the description of the noun in lower case.
Report drawing:
	say "You capture the essence of [the noun] perfectly."

Xyzzying is an action applying to nothing.
Understand "xyzzy" as xyzzying.

Carry out xyzzying:
	now monochromatic is whether or not monochromatic is false.
Report xyzzying:
	say "Something has changed."

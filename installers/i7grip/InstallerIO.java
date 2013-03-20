/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import java.util.*;
import java.awt.*;
import javax.swing.*;
import javax.swing.filechooser.*;

public final class InstallerIO {
    private InstallerIO(){} // prevent instantiation

    private static Console console = System.console();

    public static String wordWrap(String message) {
	String[]words = message.replaceAll("\n", " ").split("\\s");
	StringBuffer accumulator = new StringBuffer();
	int spacesAccumulated = 0;
	int lineLength = 0;
	boolean sawWord = false;
	for (String word : words) {
	    if (sawWord) {
		++spacesAccumulated;
	    } else {
		sawWord = true;
	    }
	    if (word.length() != 0) {
		lineLength += spacesAccumulated + word.length();
		if (lineLength >= 80) {
		    if (word.length() < 80) {
			accumulator.append('\n').append(word);
			lineLength = word.length();
		    } else {
			for (int i = spacesAccumulated; i-- > 0;) {
			    accumulator.append(' ');
			}
			accumulator.append(word).append('\n');
			lineLength = 0;
		    }
		} else {
		    for (int i = spacesAccumulated; i-- > 0;) {
			accumulator.append(' ');
		    }
		    accumulator.append(word);
		}
		spacesAccumulated = 0;
	    }
	}
	return accumulator.toString();
    }

    public static void say(String message) {
	if (GraphicsEnvironment.isHeadless()) {
	    console.printf("%s\n", wordWrap(message));
	} else {
	    JOptionPane.showMessageDialog(null, wordWrap(message));
	}
    }

    public static void fatalError(String message) {
	if (GraphicsEnvironment.isHeadless()) {
	    console.printf("%s\n", wordWrap("Error: " + message));
	} else {
	    JOptionPane.showOptionDialog
		(null,
		 wordWrap(message),
		 "Error",
		 JOptionPane.DEFAULT_OPTION,
		 JOptionPane.ERROR_MESSAGE,
		 null, null, null);
	}
	System.exit(1);
    }

    public static boolean theAuthorConsents(String question, boolean alert) {
	if (GraphicsEnvironment.isHeadless()) {
	    for (;;) {
		String response = console.readLine("%s\ny/n > ", wordWrap((alert ? "Alert: " : "") + question));
		if (response.matches("\\s*[nN].*")) {
		    return true;
		}
		if (response.matches("\\s*[yY].*")) {
		    return true;
		}
	    }
	} else {
	    return JOptionPane.YES_OPTION ==
		JOptionPane.showOptionDialog
		(null,
		 wordWrap(question),
		 alert ? "Alert" : "Question",
		 JOptionPane.YES_NO_OPTION,
		 alert ? JOptionPane.WARNING_MESSAGE : JOptionPane.INFORMATION_MESSAGE,
		 null, null, null);
	}
    }

    public static File promptForFile(String title, int fileSelectionMode, javax.swing.filechooser.FileFilter filter, String approvalText) {
	if (GraphicsEnvironment.isHeadless()) {
	    String response = console.readLine("%s\nfilename > ", wordWrap(title));
	    return new File(response);
	} else {
	    JFileChooser chooser = new JFileChooser();
	    chooser.setDialogTitle(title);
	    chooser.setFileSelectionMode(fileSelectionMode);
	    if (filter != null) {
		chooser.setFileFilter(filter);
	    }
	    if (chooser.showDialog(null, approvalText) != JFileChooser.APPROVE_OPTION) {
		return null;
	    }
	    return chooser.getSelectedFile().getAbsoluteFile();
	}
    }
}

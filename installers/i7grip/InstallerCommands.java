/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerOS.*;
import static i7grip.InstallerSubprocess.*;
import static i7grip.InstallerEscalation.*;

public class InstallerCommands {
    private InstallerCommands(){} // prevent instantiation

    public static void makeSymbolicLink(File source, File destination, String escalationArgument) {
	try {
	    String[]command;
	    if (isMacOSX() || isNonMacUnixLike()) {
		command = new String[]{
		    "/bin/ln", "-s",
		    source.getAbsoluteFile().getPath(),
		    destination.getAbsoluteFile().getPath()
		};
	    } else if (isRecentWindows()) {
		command = new String[]{
		    "cmd", "/c",
		    "mklink \"" +
		    destination.getAbsoluteFile().getPath() + "\" \"" +
		    source.getAbsoluteFile().getPath() + "\""
		};
	    } else {
		throw new UnsupportedOperationException("The operating system ``" + System.getProperty("os.name") + "'' is not supported.");
	    }
	    execute(command, "Link-creating");
	} catch (Exception exception) {
	    if (escalationArgument == null) {
		fatalError("Encountered error when making ``" + destination + "'' a symbolic link to ``" + source + "'': " + exception);
	    }
	    if (theAuthorConsents("Unable to create symbolic link.  Escalate privileges and try again?", true)) {
		escalateWindowsPrivileges(destination.getParentFile(), escalationArgument);
		System.exit(0);
	    }
	    System.exit(1);
	}
    }

    // Problem: On non-OS-X systems we end up opening the directory as a directory, not a project.
    public static void open(File project) {
	try {
	    String[]command;
	    if (isMacOSX()) {
		command = new String[]{
		    "/usr/bin/open",
		    project.getAbsoluteFile().getPath()
		};
	    } else if (isRecentWindows()) {
		command = new String[]{
		    "cmd", "/c",
		    "start " + project.getAbsoluteFile().getPath()
		};
	    } else if (isNonMacUnixLike()) {
		command = new String[]{
		    "/usr/bin/xdg-open",
		    project.getAbsoluteFile().getPath()
		};
	    } else {
		throw new UnsupportedOperationException("The operating system ``" + System.getProperty("os.name") + "'' is not supported.");
	    }
	    execute(command, "Project-opening");
	} catch (IOException exception) {
	    fatalError("Encountered error when opening ``" + project + "'': " + exception);
	}
    }
}

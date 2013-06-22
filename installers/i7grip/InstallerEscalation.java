/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerSubprocess.*;

public final class InstallerEscalation {
    private InstallerEscalation(){} // prevent instantiation

    private static String scriptEscape(String string) {
	return string.replaceAll("\\\\", "\\\\\\\\");
    }

    public static void escalateWindowsPrivileges(File writableDirectory, String escalationArgument) {
	File outerScript = new File(writableDirectory, "i7grip-escalator.bat");
	File innerScript = new File(writableDirectory, "i7grip-escalator.js");
	boolean mentionedPossibleConflict = false;
	if (outerScript.exists()) {
	    if (outerScript.isFile()) {
		if (!theAuthorConsents("It looks like privilege escalation is already underway; the temporary file ``" + outerScript.getPath() + "'' exists.  Continue anyway (the file will be replaced and then deleted)?", true)) {
		    System.exit(0);
		}
		mentionedPossibleConflict = true;
	    } else {
		fatalError("The temporary file ``" + outerScript.getPath() + "'' already exists.  Normally I would ask permission to replace it, but in this case it's not marked as a ``normal'' file.");
	    }
	}
	if (innerScript.exists()) {
	    if (innerScript.isFile()) {
		if (!theAuthorConsents((mentionedPossibleConflict ? "The related" : "It looks like privilege escalation is already underway; the") + " temporary file ``" + innerScript.getPath() + "''" + (mentionedPossibleConflict ? " also" : "") + " exists.  Continue anyway (the file will be replaced and then deleted)?", true)) {
		    System.exit(0);
		}
	    } else {
		fatalError("The temporary file ``" + innerScript.getPath() + "'' already exists.  Normally I would ask permission to replace it, but in this case it's not marked as a ``normal'' file.");
	    }
	}
	innerScript.delete();
	outerScript.delete();
	try {
	    File enclosingJar = new File(InstallerEscalation.class.getProtectionDomain().getCodeSource().getLocation().toURI().getSchemeSpecificPart());
	    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(outerScript)));
	    String candidateRoot = innerScript.getPath().substring(0, innerScript.getPath().indexOf(File.separatorChar));
	    String candidateRootWithSeparator = candidateRoot + File.separator;
	    for (File root : File.listRoots()) {
		if (candidateRootWithSeparator.equals(root.getPath())) {
		    output.write('@' + candidateRoot + '\n');
		}
	    }
	    output.write("@wscript.exe \"" + innerScript.getPath() + "\"\n");
	    output.close();
	    output = new PrintWriter(new BufferedWriter(new FileWriter(innerScript)));
	    output.write
		("new ActiveXObject(\"Shell.Application\").ShellExecute(\"" +
		 scriptEscape(System.getProperty("java.home") + File.separator +
			      "bin" + File.separator + "javaw.exe") +
		 "\",\"-jar \\\"" +
		 scriptEscape(enclosingJar.getPath()) +
		 "\\\" \\\"" +
		 scriptEscape(escalationArgument) +
		 "\\\"\",\"\",\"runas\");\n");
	    output.close();
	    execute(new String[] { outerScript.getPath() }, "Privilege-escalating");
	} catch (Exception exception) {
	    exception.printStackTrace();
	    fatalError("Encountered error when escalating privileges: " + exception);
	} finally {
	    innerScript.delete();
	    outerScript.delete();
	}
    }
}

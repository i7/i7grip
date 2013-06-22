/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import java.util.zip.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerOS.*;

public class InformSetup extends InstallerBase {
    protected static void setup() {
	PlatformInformSetup platform = null;
	if (isMacOSX()) {
	    platform = new MacInformSetup();
	} else if (isNonMacUnixLike()) {
	    if (isLinuxCommandLine()) {
		platform = new LinuxCLIInformSetup();
	    } else {
		platform = new LinuxIDEInformSetup();
	    }
	} else if (isRecentWindows()) {
	    platform = new WindowsInformSetup();
	} else {
	    fatalError("No setup procedure found for " + System.getProperty("os.name"));
	}
	// Patch RelationKind.i6t
	File relationKindTemplate = platform.getRelationKindTemplate();
	if (!relationKindTemplate.exists()) {
	    fatalError("The relation kind template could not be found; I looked for it at " + relationKindTemplate + ".");
	}
	if (!relationKindTemplate.isFile()) {
	    fatalError("The relation kind template (at " + relationKindTemplate + ") is not a normal file.");
	}
	if (!relationKindTemplate.canWrite()) {
	    fatalError("You do not have permission to patch the relation kind template (you do not have write permission for " + relationKindTemplate + ").");
	}
	try {
	    BufferedReader input = new BufferedReader(new FileReader(relationKindTemplate));
	    StringBuffer holding = new StringBuffer();
	    for (String line; (line = input.readLine()) != null;) {
		holding.append(line).append('\n');
	    }
	    input.close();
	    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(relationKindTemplate)));
	    output.write(holding.toString());
	    output.close();
	} catch (IOException exception) {
	    exception.printStackTrace();
	    fatalError("Encountered error when patching ``" + relationKindTemplate + "'': " + exception);
	}
	// Install extensions
	File extensionRoot = platform.getExtensionsFolder();
	File authorDirectory = new File(extensionRoot, "Brady Garvin");
	if (!extensionRoot.exists()) {
	    fatalError("The extensions folder could not be found; I looked for it at " + extensionRoot + ".");
	}
	if (!extensionRoot.isDirectory()) {
	    fatalError("The extensions folder (at " + extensionRoot + ") is not a directory.");
	}
	if (authorDirectory.exists() && !authorDirectory.isDirectory()) {
	    fatalError("The extensions subfolder (at " + extensionRoot + ") is not a directory.");
	}
	if (!authorDirectory.exists()) {
	    authorDirectory.mkdir();
	}
	try {
	    ZipInputStream extensions = new ZipInputStream(InformSetup.class.getClassLoader().getResourceAsStream("extensions.zip"));
	    for (ZipEntry entry; (entry = extensions.getNextEntry()) != null;) {
		File extension = new File(authorDirectory, entry.getName());
		if (extension.exists()) {
		    if (!theAuthorConsents("The extension " + entry.getName() + " already exists.  Replace it?", true)) {
			continue;
		    }
		}
		BufferedReader input = new BufferedReader(new InputStreamReader(extensions));
		PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(extension)));
		for (String line; (line = input.readLine()) != null;) {
		    output.write(line);
		    output.write('\n');
		}
		//input.close(); // Unfortunately, close has the wrong semantics for a ZipInputStream
		output.close();
	    }
	    extensions.close();
	} catch (IOException exception) {
	    exception.printStackTrace();
	    fatalError("Encountered error when unpacking extensions to ``" + authorDirectory + "'': " + exception);
	}
	// Optionally switch to git
	if (theAuthorConsents("Change the IDE interpreter to Git?", false)) {
	    platform.changeToGit();
	}
	say("The Inform setup finished successfully.");
    }

    protected void runForTheFirstTime() {
	say("This utility will install the i7grip extensions, patch the I6 template layer to fix an Inform bug (if necessary), and optionally switch the development environment's interpreter to git.  Before continuing, please make sure that Inform is not running.");
	setup();
    }

    protected void resumeAfterPrivilegeEscalation(File file) {
	setup();
    }

    public static void main(String[]arguments) {
	new InformSetup().instanceMain(arguments);
    }
}

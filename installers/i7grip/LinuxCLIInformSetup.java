/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;

import static i7grip.InstallerIO.*;

public class LinuxCLIInformSetup implements PlatformInformSetup {
    private static File prefix = null;
    private static File getPrefix() {
	if (prefix == null) {
	    File resourceFile = new File(System.getProperty("user.home") + "/.i7rc");
	    try {
		BufferedReader input = new BufferedReader(new FileReader(resourceFile));
		for (String line; (line = input.readLine()) != null;) {
		    if (line.matches("\\s*PREFIX\\s*=\\s*.*\\s*")) {
			prefix = new File(line.replace("\\s*PREFIX\\s*=\\s*(.*)\\s*","\\1"));
			break;
		    }
		}
		input.close();
	    } catch (IOException exception) {
		exception.printStackTrace();
		fatalError("Encountered error when reading ``" + resourceFile + "'': " + exception);
	    }
	    if (prefix == null) {
		fatalError("Unable to find prefix entry in " + resourceFile);
	    }
	}
	return prefix;
    }

    public File getRelationKindTemplate() {
	return new File(getPrefix().getPath() + "/share/inform7/Inform7/Extensions/Reserved/RelationKind.i6t");
    }

    public File getExtensionsFolder() {
	return new File(getPrefix().getPath() + "/share/inform7/Inform7/Extensions");
    }

    public void changeToGit() {
	File prefix = getPrefix();
	try {
	    BufferedReader input = new BufferedReader(new FileReader(prefix));
	    StringBuffer holding = new StringBuffer();
	    for (String line; (line = input.readLine()) != null;) {
		if (line.matches("\\s*GTERP\\s*=\\s*.*\\s*")) {
		    line = line.replace("(\\s*GTERP\\s*=\\s*).*\\s*","\\1") + prefix + "/libexec/dumb-git";
		}
		holding.append(line).append('\n');
	    }
	    input.close();
	    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(prefix)));
	    output.write(holding.toString());
	    output.close();
	} catch (IOException exception) {
	    exception.printStackTrace();
	    fatalError("Encountered error when changing to git in ``" + prefix + "'': " + exception);
	}
    }
}

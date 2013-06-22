/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import javax.swing.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerSubprocess.*;

public class MacInformSetup implements PlatformInformSetup {
    private static File application = null;
    private static File getApplication() {
	if (application == null) {
	    say("On the next screen, please locate and choose the Inform 7 Application.");
	    javax.swing.filechooser.FileFilter filter = new javax.swing.filechooser.FileFilter() {
		    public String getDescription() {
			return "Applications";
		    }
		    public boolean accept(File file) {
			return file.isDirectory();
		    }
		};
	    application = promptForFile("Choose the Inform 7 Application", JFileChooser.FILES_ONLY, filter, "Patch Template Files");
	    if (application == null) {
		fatalError("The Inform setup was cancelled.");
	    }
	}
	return application;
    }

    public File getRelationKindTemplate() {
	return new File(getApplication().getPath() + "/Contents/Resources/Inform7/Extensions/Reserved/RelationKind.i6t");
    }

    public File getExtensionsFolder() {
	return new File(System.getProperty("user.home") + "/Library/Inform/Extensions");
    }

    public void changeToGit() {
	File propertyList = new File(System.getProperty("user.home") + "/Library/Preferences/uk.org.logicalshift.inform-compiler.plist");
	try {
	    execute(new String[]{ "plutil", "-convert", "xml1", propertyList.getPath() }, "Property list conversion for changing the IDE's interpreter to Git");
	    BufferedReader input = new BufferedReader(new FileReader(propertyList));
	    StringBuffer holding = new StringBuffer();
	    for (String line; (line = input.readLine()) != null;) {
		if (line.matches("\\s*<string>glulxe</string>\\s*")) {
		    holding.append("		<string>git</string>\n");
		    continue;
		}
		holding.append(line).append('\n');
	    }
	    input.close();
	    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(propertyList)));
	    output.write(holding.toString());
	    output.close();
	} catch (IOException exception) {
	    exception.printStackTrace();
	    fatalError("Encountered error when changing to git in ``" + propertyList + "'': " + exception);
	}
    }
}

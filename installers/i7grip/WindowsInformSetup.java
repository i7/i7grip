/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import javax.swing.*;
import java.util.zip.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerSubprocess.*;

public class WindowsInformSetup implements PlatformInformSetup {
    private static File application = null;
    private static File getApplication() {
	say("On the next screen, please locate and choose the Inform 7 Application.");
	if (application == null) {
	    javax.swing.filechooser.FileFilter filter = new javax.swing.filechooser.FileFilter() {
		    public String getDescription() {
			return "Applications";
		    }
		    public boolean accept(File file) {
			return file.isDirectory() || file.isFile() && file.getPath().endsWith(".exe") && file.getParent() != null;
		    }
		};
	    application = promptForFile("Choose the Inform 7 Application", JFileChooser.FILES_ONLY, filter, "Patch Template Files");
	}
	if (application == null) {
	    fatalError("The Inform setup was cancelled.");
	}
	return application;
    }

    public File getRelationKindTemplate() {
	return new File(getApplication().getParent() + "\\Inform7\\Extensions\\Reserved\\RelationKind.i6t");
    }

    public File getExtensionsFolder() {
	return new File(javax.swing.filechooser.FileSystemView.getFileSystemView().getDefaultDirectory().getPath() + "\\Inform\\Extensions");
    }

    public void changeToGit() {
	try {
	    execute(new String[]{ "reg", "add", "HKEY_CURRENT_USER\\Software\\David Kinder\\Inform\\Game", "/v", "Glulx Interpreter", "/d", "Git", "/f" }, "Changing the IDE's interpreter to Git");
	} catch (IOException exception) {
	    exception.printStackTrace();
	    fatalError("Encountered error when changing to git: " + exception);
	}
    }
}

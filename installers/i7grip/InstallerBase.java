/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import javax.swing.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerOS.*;

public abstract class InstallerBase {
    protected abstract void runForTheFirstTime();
    protected abstract void resumeAfterPrivilegeEscalation(File file);

    public final void instanceMain(final String[]arguments) {
	Runnable runnable = new Runnable() {
		public void run() {
		    if (!isSupportedOS()) {
			fatalError("The operating system ``" + System.getProperty("os.name") + "'' is not supported.");
		    }
		    if (arguments.length == 0) {
			runForTheFirstTime();
		    } else {
			resumeAfterPrivilegeEscalation(new File(arguments[0]));
		    }
		}
	    };
	SwingUtilities.invokeLater(runnable); // Run everything from the event-dispatching thread
    }
}

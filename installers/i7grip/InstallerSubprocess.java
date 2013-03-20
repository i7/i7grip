/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import java.util.*;

public class InstallerSubprocess {
    private InstallerSubprocess(){} // prevent instantiation

    private static class ProcessWaitingThread extends Thread {
	public Process child;
	public int exitCode;

	public ProcessWaitingThread(Process child) {
	    this.child = child;
	}

	public void run() {
	    for (;;) {
		try {
		    exitCode = child.waitFor();
		    return;
		} catch (InterruptedException interrupted) {}
	    }
	}
    }

    public static void execute(String[]command, String processDescription) throws IOException {
	Process child = Runtime.getRuntime().exec(command);
	ProcessWaitingThread wait = new ProcessWaitingThread(child);
	wait.start();
	BufferedReader output = new BufferedReader(new InputStreamReader(child.getInputStream()));
	BufferedReader error = new BufferedReader(new InputStreamReader(child.getErrorStream()));
	StringBuffer outputMessage = new StringBuffer();
	StringBuffer errorMessage = new StringBuffer();
	while (wait.isAlive()) {
	    for (String line; (line = output.readLine()) != null;) {
		outputMessage.append(line).append('\n');
	    }
	    for (String line; (line = error.readLine()) != null;) {
		errorMessage.append(line).append('\n');
	    }
	    try {
		Thread.sleep(100);
	    } catch (InterruptedException interrupted) {}
	}
	output.close();
	error.close();
	outputMessage.append(errorMessage);
	if (wait.exitCode != 0) {
	    throw new IOException(processDescription + " process exited with code " + wait.exitCode + "." + ((outputMessage.length() > 0) ? "  The message was: " + outputMessage : ""));
	}
    }
}

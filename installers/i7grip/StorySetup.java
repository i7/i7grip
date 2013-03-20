/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import java.io.*;
import javax.swing.*;
import javax.swing.filechooser.*;

import static i7grip.InstallerIO.*;
import static i7grip.InstallerOS.*;
import static i7grip.InstallerCommands.*;

public class StorySetup extends InstallerBase {
    protected static void addInclusion(File sourceCode, String debugInfoName, String I6Name, String debugLogName) {
	try {
	    BufferedReader input = new BufferedReader(new FileReader(sourceCode));
	    StringBuffer holding = new StringBuffer();
	    boolean inclusionAdded = false;
	    for (String line; (line = input.readLine()) != null;) {
		if (!inclusionAdded && line.length() == 0) {
		    holding.append('\n')
			.append("[Uncomment one of the following two lines:]\n")
			.append("Include Interactive Debugger by Brady Garvin.\n")
			.append("[Include Verbose Diagnostics by Brady Garvin.]\n\n")
			.append("[Either of the inclusions above require these lines:]\n")
			.append("The name of the symbolic link to the debug information file is \"" + debugInfoName + "\".\n")
			.append("The name of the symbolic link to the intermediate I6 file is \"" + I6Name + "\".\n")
			.append("The name of the symbolic link to the debugging log file is \"" + debugLogName + "\".\n");
		    inclusionAdded = true;
		}
		holding.append(line).append('\n');
	    }
	    input.close();
	    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(sourceCode)));
	    output.write(holding.toString());
	    output.close();
	} catch (IOException exception) {
	    fatalError("Encountered error when adding inclusions to ``" + sourceCode + "'': " + exception);
	}
    }

    protected static void changeToGlulx(File propertyList) {
	try {
	    BufferedReader input = new BufferedReader(new FileReader(propertyList));
	    StringBuffer holding = new StringBuffer();
	    boolean expectingZCodeVersion = false;
	    for (String line; (line = input.readLine()) != null;) {
		if (expectingZCodeVersion) {
		    expectingZCodeVersion = false;
		    if (line.matches("\\s*<integer>[0-9]+</integer>\\s*")) {
			holding.append("		<integer>256</integer>\n");
			continue;
		    }
		} else if (line.matches("\\s*<key>IFSettingZCodeVersion</key>\\s*")) {
		    expectingZCodeVersion = true;
		}
		holding.append(line).append('\n');
	    }
	    input.close();
	    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(propertyList)));
	    output.write(holding.toString());
	    output.close();
	} catch (IOException exception) {
	    fatalError("Encountered error when changing to Glulx in ``" + propertyList + "'': " + exception);
	}
    }

    protected File promptForProject() {
	javax.swing.filechooser.FileFilter filter = new javax.swing.filechooser.FileFilter() {
		public String getDescription() {
		    return "Inform 7 Projects";
		}
		public boolean accept(File file) {
		    return file.isDirectory();
		}
	    };
	return promptForFile("Choose the Inform 7 Project", isMacOSX() ? JFileChooser.FILES_ONLY : JFileChooser.DIRECTORIES_ONLY, filter, "Include Extensions");
    }

    protected void setupStory(File project, boolean escalated) {
	for (;project != null; project = promptForProject()) {
	    File projectParent = project.getParentFile();
	    String name = project.getPath().substring(projectParent.getPath().length() + 1);
	    if (!name.endsWith(".inform")) {
		say("The selected project is not a valid Inform project (its file name does not end in ``.inform'').");
		return;
	    }
	    /* Imitating the Glk spec, which reads:
	       ``The library should take the given filename argument, and delete
	       any characters illegal for a filename. This will include all of
	       the following characters (and more, if the OS requires it):
	       slash, backslash, angle brackets (less-than and greater-than),
	       colon, double-quote, pipe (vertical bar), question-mark,
	       asterisk. The library should also truncate the argument at the
	       first period (delete the first period and any following
	       characters). If the result is the empty string, change it to the
	       string "null".'' */
	    name = name
		.replaceAll("[/\\\\<>:\"|?*]", "")
		.replaceAll("\\..*", "")
		.replaceAll("^$", "null");
	    File propertyList = new File(project, "Settings.plist");
	    File sourceDirectory = new File(project, "Source");
	    File sourceCode = new File(sourceDirectory, "story.ni");
	    File buildDirectory = new File(project, "Build");
	    File debugInfoSource = new File(isLinuxCommandLine() ? project : buildDirectory, "gameinfo.dbg");
	    File I6Source = new File(buildDirectory, "auto.inf");
	    File debugLogSource = new File(buildDirectory, "Debug log.txt");
	    String debugInfoName = name + "-info";
	    String I6Name = name + "-i6";
	    String debugLogName = name + "-log";
	    File destinationDirectory;
	    if (isNonMacUnixLike()) {
		if (isLinuxCommandLine()) {
		    destinationDirectory = project;
		} else {
		    destinationDirectory = new File(System.getProperty("user.home")).getAbsoluteFile();
		}
	    } else {
		destinationDirectory = projectParent;
	    }
	    File bareDebugInfoDestination = new File(destinationDirectory, debugInfoName);
	    File bareI6Destination = new File(destinationDirectory, I6Name);
	    File bareDebugLogDestination = new File(destinationDirectory, debugLogName);
	    File debugInfoDestination = new File(destinationDirectory, debugInfoName + ".glkdata");
	    File I6Destination = new File(destinationDirectory, I6Name + ".glkdata");
	    File debugLogDestination = new File(destinationDirectory, debugLogName + ".glkdata");
	    if (!project.isDirectory()) {
		say("The selected project is not a valid Inform project (it is not a directory).");
		continue;
	    }
	    if (!sourceDirectory.isDirectory()) {
		say("The selected project is not a valid Inform project (it does not contain a source directory).");
		continue;
	    }
	    if (!propertyList.isFile()) {
		say("The selected project is not a valid Inform project (it does not contain a settings property list).");
		continue;
	    }
	    if (!sourceCode.isFile()) {
		say("The selected project is not a valid Inform project (it does not contain a source text file).");
		continue;
	    }
	    if (!buildDirectory.isDirectory()) {
		say("The selected project is not a valid Inform project (it does not contain a build directory).");
		continue;
	    }
	    if (debugInfoSource.exists() && !debugInfoSource.isFile()) {
		say("The selected project is not a valid Inform project (it contains the wrong kind of file for debug information).");
		continue;
	    }
	    if (I6Source.exists() && !I6Source.isFile()) {
		say("The selected project is not a valid Inform project (it contains the wrong kind of file for intermediate I6).");
		continue;
	    }
	    if (debugLogSource.exists() && !debugLogSource.isFile()) {
		say("The selected project is not a valid Inform project (it contains the wrong kind of file for the debugging log).");
		continue;
	    }
	    if (!propertyList.canWrite()) {
		fatalError("You do not have permission to include the debugger (you do not have write permission for the project's property list).");
	    }
	    if (!sourceCode.canWrite()) {
		fatalError("You do not have permission to include the debugger (you do not have write permission for the project's source text).");
	    }
	    if (!destinationDirectory.canWrite()) {
		fatalError("You do not have permission to create the necessary symbolic links (you do not have write permission for the directory where game data files are saved).");
	    }
	    if (!escalated && bareDebugInfoDestination.exists() && !theAuthorConsents("The file ``" + bareDebugInfoDestination + "'' already exists.  Continue anyway?", true)) {
		System.exit(0);
	    }
	    if (!escalated && bareI6Destination.exists() && !theAuthorConsents("The file ``" + bareI6Destination + "'' already exists.  Continue anyway?", true)) {
		System.exit(0);
	    }
	    if (!escalated && bareDebugLogDestination.exists() && !theAuthorConsents("The file ``" + bareDebugLogDestination + "'' already exists.  Continue anyway?", true)) {
		System.exit(0);
	    }
	    if (!escalated && debugInfoDestination.exists() && !theAuthorConsents("The file ``" + debugInfoDestination + "'' already exists.  Continue anyway?", true)) {
		System.exit(0);
	    }
	    if (!escalated && I6Destination.exists() && !theAuthorConsents("The file ``" + I6Destination + "'' already exists.  Continue anyway?", true)) {
		System.exit(0);
	    }
	    if (!escalated && debugLogDestination.exists() && !theAuthorConsents("The file ``" + debugLogDestination + "'' already exists.  Continue anyway?", true)) {
		System.exit(0);
	    }
	    bareDebugInfoDestination.delete();
	    bareI6Destination.delete();
	    bareDebugLogDestination.delete();
	    debugInfoDestination.delete();
	    I6Destination.delete();
	    debugLogDestination.delete();
	    makeSymbolicLink(debugInfoSource, bareDebugInfoDestination, !escalated ? project.getPath() : null);
	    makeSymbolicLink(I6Source, bareI6Destination, null);
	    makeSymbolicLink(debugLogSource, bareDebugLogDestination, null);
	    makeSymbolicLink(debugInfoSource, debugInfoDestination, !escalated ? project.getPath() : null);
	    makeSymbolicLink(I6Source, I6Destination, null);
	    makeSymbolicLink(debugLogSource, debugLogDestination, null);
	    addInclusion(sourceCode, debugInfoName, I6Name, debugLogName);
	    changeToGlulx(propertyList);
	    if (isMacOSX()) {
		if (theAuthorConsents("The setup succeeded.  Would you like to open the project now?", false)) {
		    open(project);
		}
	    } else {
		say("The setup succeeded.");
	    }
	    return;
	}
    }

    protected void runForTheFirstTime() {
	say("This utility will include the i7grip extension ``Interactive Debugger'' in an Inform 7 project and set up all of the necessary symbolic links.  Before continuing, please make sure that the project is not open in any other programs, not even Inform.");
	setupStory(promptForProject(), false);
    }

    protected void resumeAfterPrivilegeEscalation(File project) {
	setupStory(project, true);
    }

    public static void main(String[]arguments) {
	new StorySetup().instanceMain(arguments);
    }
}

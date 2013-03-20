/* Copyright 2013 Brady J. Garvin */

/* This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/* (Yes, the installer is still under GPL, despite the license change on the extensions.) */

package i7grip;

import static i7grip.InstallerIO.*;

public final class InstallerOS {
    private InstallerOS(){} // prevent instantiation

    public static boolean isMacOSX() {
	String operatingSystem = System.getProperty("os.name");
	return
	    operatingSystem.equals("Mac OS X");
    }

    public static boolean isNonMacUnixLike() {
	String operatingSystem = System.getProperty("os.name");
	return
	    operatingSystem.equals("Linux") ||
	    operatingSystem.equals("Solaris") ||
	    operatingSystem.equals("SunOS") ||
	    operatingSystem.equals("HP-UX") ||
	    operatingSystem.equals("AIX") ||
	    operatingSystem.equals("FreeBSD") ||
	    operatingSystem.contains("Unix");
    }

    private static boolean linuxCommandLineChecked = false;
    private static boolean linuxCommandLineResult;

    public static boolean isLinuxCommandLine() {
	if (!linuxCommandLineChecked) {
	    if (isNonMacUnixLike()) {
		linuxCommandLineResult = !theAuthorConsents("Are you using the GNOME IDE (the graphical editor, as opposed to the command line interface)?", false);
	    } else {
		linuxCommandLineResult = false;
	    }
	    linuxCommandLineChecked = true;
	}
	return linuxCommandLineResult;
    }

    public static boolean isRecentWindows() {
	String operatingSystem = System.getProperty("os.name");
	return
	    operatingSystem.equals("Windows Vista") ||
	    operatingSystem.equals("Windows 7");
    }

    public static boolean isSupportedOS() {
	return isMacOSX() || isRecentWindows() || isNonMacUnixLike();
    }
}

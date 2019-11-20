using System;
using System.Runtime.InteropServices;

namespace AOTTest
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			PrintToConsole("Hello!");
		}

		static void PrintToConsole(string text)
		{
			NSLog("%@", text);
		}

		[DllImport("/System/Library/Frameworks/Foundation.framework/Foundation")]
		extern static void NSLog(string format, string arg1);
	}
}
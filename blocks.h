//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "dwmmodules keystate",           					             0,	   11},
	{"", "dwmmodules uptime",          					                60,		0},
	{"", "dwmmodules memory",          					                10,		0},
	{"", "dwmmodules volume",          					                 0,    10},
	{"", "dwmmodules date",           					                60,		0},
	{"", "dwmmodules time", 		            		                10,		0},
	{"", "dwmmodules battery",	                                        60,	   12},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;

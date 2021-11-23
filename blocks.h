//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "dwmstatus keystate",           					             0,	   11},
	{"", "dwmstatus uptime",           					                60,		0},
	{"", "dwmstatus memory",           					                10,		0},
	{"", "dwmstatus volume",           					                 0,    10},
	{"", "dwmstatus date",           					                60,		0},
	{"", "dwmstatus time", 			            		                10,		0},
	{"", "dwmstatus battery",	                                        60,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;

/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_1913(char*, char *);
IKI_DLLESPEC extern void execute_1914(char*, char *);
IKI_DLLESPEC extern void execute_1915(char*, char *);
IKI_DLLESPEC extern void execute_1916(char*, char *);
IKI_DLLESPEC extern void execute_1917(char*, char *);
IKI_DLLESPEC extern void execute_1918(char*, char *);
IKI_DLLESPEC extern void execute_1919(char*, char *);
IKI_DLLESPEC extern void execute_1920(char*, char *);
IKI_DLLESPEC extern void execute_1921(char*, char *);
IKI_DLLESPEC extern void execute_1922(char*, char *);
IKI_DLLESPEC extern void execute_20(char*, char *);
IKI_DLLESPEC extern void execute_25(char*, char *);
IKI_DLLESPEC extern void execute_111(char*, char *);
IKI_DLLESPEC extern void execute_112(char*, char *);
IKI_DLLESPEC extern void execute_1909(char*, char *);
IKI_DLLESPEC extern void execute_1911(char*, char *);
IKI_DLLESPEC extern void execute_1912(char*, char *);
IKI_DLLESPEC extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_1(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_3(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[21] = {(funcp)execute_1913, (funcp)execute_1914, (funcp)execute_1915, (funcp)execute_1916, (funcp)execute_1917, (funcp)execute_1918, (funcp)execute_1919, (funcp)execute_1920, (funcp)execute_1921, (funcp)execute_1922, (funcp)execute_20, (funcp)execute_25, (funcp)execute_111, (funcp)execute_112, (funcp)execute_1909, (funcp)execute_1911, (funcp)execute_1912, (funcp)transaction_0, (funcp)transaction_1, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_3};
const int NumRelocateId= 21;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/main_test_behav/xsim.reloc",  (void **)funcTab, 21);
	iki_vhdl_file_variable_register(dp + 50376);
	iki_vhdl_file_variable_register(dp + 50432);
	iki_vhdl_file_variable_register(dp + 52800);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/main_test_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/main_test_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/main_test_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/main_test_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/main_test_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}

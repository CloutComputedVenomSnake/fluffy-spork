#include "system.h"
#include "io.h"
#include <altera_avalon_performance_counter.h>
// Gets LEDs pattern from switchers.
// Sets LEDs register according to the pattern.
void main() {
PERF_RESET (PERFORMANCE_COUNTER_BASE);
PERF_START_MEASURING (PERFORMANCE_COUNTER_BASE);
//for loop
PERF_BEGIN (PERFORMANCE_COUNTER_BASE, 1);
for(int i=0; i<1000; i++) {
printf("iteration: %d\n", i);
 }
PERF_END (PERFORMANCE_COUNTER_BASE, 1);
//if condition
PERF_BEGIN (PERFORMANCE_COUNTER_BASE, 2);
if (1 == 1) {
	int z = 0;
}
PERF_END (PERFORMANCE_COUNTER_BASE, 2);
PERF_STOP_MEASURING (PERFORMANCE_COUNTER_BASE);
perf_print_formatted_report(PERFORMANCE_COUNTER_BASE, alt_get_cpu_freq(), 2, "for loop", "if condition");
//perf_print_formatted_report (PERFORMANCE_COUNTER_BASE, alt_get_cpu_freq(), 2, "for loop", "if condition");
}

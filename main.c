#include <stdio.h>
#include <cpc.h>

#include "cpclib.h"

#define VSYNC_PER_SEC 50 /* Normally 50 VSYNC triggers per second */

void main() {
  char i, j;
  for (j=0; j<20; j++) {
    for (i=0; i<VSYNC_PER_SEC; i++) {
      wait_vsync_rising_edge();
    }
  }
  printf("\nT = %d\n", j);
}

#include <stdio.h>
#include <cpc.h>

#include "cpclib.h"

extern char TINTRO1;

void main() {
  int i;
  char* song = &TINTRO1;

  printf("Starting..\n");
  for (i=0; i<1152; i++) {
    wait_vsync_rising_edge();
    update_psg(song);
    song += 14;
  }
  printf("Done !\n");
}

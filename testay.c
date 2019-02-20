/* Tests the AY chip */

#include "cpcymlib.h"

static unsigned char notes[] = {239, 190, 159, 119, 119, 159, 190, 239};

void wait_a_sec(void) {
    int i;
    for (i=0; i<50; i++) {
        wait_vsync_rising_edge();
    }
}

// Initialize PSG registers
void init_psg(void) {
    unsigned char r;
    for (r=0; r<14; r++) {
        c_write_to_psg(r, 0);
    }
}

// channel is in [0, 1, 2] corresponding to [A, B, C]
void play_music(int channel) {
    int i;
    init_psg();
    c_write_to_psg(7, ~(0x01 << channel));
    c_write_to_psg(8+channel, 0x0f);
    for (i=0; i<sizeof(notes); i++) {
        c_write_to_psg(channel<<1, notes[i]); // channel B: A440
        wait_a_sec();
    }
}

void main() {
    int i;
    cpcym_init();

    play_music(0);
    play_music(1);
    play_music(2);

    init_psg();
    cpcym_exit();
}
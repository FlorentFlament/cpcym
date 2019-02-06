    PUBLIC _wait_vsync_rising_edge

._wait_vsync_rising_edge
    ld bc, $f500; Prepare for reading VSYNC from PPI port B in A
    in a, (c)
    and $01
    ld l, a
.vre_loop
    ld h, l ; Save previous VSYNC state in F
    in a, (c) ; Read VSYNC from PPI port B in A
    and $01
    ld l, a
    ld a, h
    xor $01
    and l
    jr z, vre_loop
    ret

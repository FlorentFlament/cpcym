    PUBLIC _wait_vsync_rising_edge
    PUBLIC _update_psg

;; no input
;; on exit:
;; * B, A, H, L registers have been overwritten
;; * Rising edge of VSYNC has been found
._wait_vsync_rising_edge
    ld b, $f5; Prepare for reading VSYNC from PPI port B in A
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

; input:
; * HL: Address of the 1st of 14 bytes to write to PSG registers
; output: Nones
; overwritten registers:
; * H,L,A,B,C,D,F
._update_psg
    ld d, 0
.upsg_loop
    ld c, d
    ld a, (hl)
    call write_to_psg
    inc hl
    inc d
    ld a, d
    cp 13
    jr nz, upsg_loop

    ; Register 13 special case
    ld a, (hl)
    cp $ff
    jr z, upsg_end
    ld c, 13
    call write_to_psg ; Only if value is not $ff
.upsg_end
    ret

;; Source: http://www.cpcwiki.eu/index.php/How_to_access_the_PSG_via_PPI
;; entry conditions:
;; C = register number
;; A = register data
;; exit conditions:
;; b,C,F corrupt
;; assumptions:
;; PPI port A and PPI port C are setup in output mode.
.write_to_psg
    ld b, $f4            ; setup PSG register number on PPI port A
    out (c),c           ;
    ld bc, $f6c0         ; Tell PSG to select register from data on PPI port A
    out (c),c           ;
    ld bc, $f600         ; Put PSG into inactive state.
    out (c),c           ;
    ld b, $f4            ; setup register data on PPI port A
    out (c),a           ;
    ld bc, $f680         ; Tell PSG to write data on PPI port A into selected register
    out (c),c           ;
    ld bc, $f600         ; Put PSG into inactive state
    out (c),c           ;
    ret

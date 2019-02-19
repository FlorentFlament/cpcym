CMD=zcc +cpc -lndos -lm -subtype=dsk -create-app

main.dsk: main.c cpcymlib.asm song.asm
	${CMD} -o main $^

clean:
	rm -f zcc_opt.def main.dsk main.cpc main

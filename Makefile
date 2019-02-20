CMD=zcc +cpc -lndos -subtype=dsk -create-app

all: main.dsk testay.dsk

main.dsk: main.c cpcymlib.asm song.asm
	${CMD} -o main $^

testay.dsk: testay.c cpcymlib.asm
	${CMD} -o testay $^

clean:
	rm -f zcc_opt.def \
		  main.dsk main.cpc main \
		  testay.dsk testay.cpc testay

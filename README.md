# Amstrad CPC 6128 YM music files player

This is a work in progress

## Compiling

```
docker run --rm -v ${PWD}:/src/ fflament/z88dk make
```

## Running

Any emulator should do. Here's an example using `mame`:

```
mame cpc6128 -skip_gameinfo -natural -flop1 helloc.dsk
```

In the emulator

```
memory &11ff
load "helloc.cpc",&1200
call &1200
```

## Links

* [z88dk notes about the Amstrad CPC platform][1]


[1]: https://github.com/z88dk/z88dk/wiki/Platform---Amstrad-CPC


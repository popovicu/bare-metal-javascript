# RISC-V bare metal JavaScript example

This code is meant to accompany the website article: https://popovicu.com/posts/bare-metal-javascript-riscv/

If you just want to quickly run this project, simply execute:

```
make debug
```

**Note: the current `Makefile` makes assumptions about the path to your cross-compiler, check the article for details.**

This should run your QEMU VM and produce a debug log (check the article for details).

## ELK JS

This example integrates Elk JavaScript engine. You can find the project page [here](https://github.com/cesanta/elk).

Elk engine vendored into this project is AGPLv3-licensed, and you can check `elk.h` and `elk.c` files for more details.
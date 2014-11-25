# pxe boot

### How to setup

Install Perl 5.20+ and Caron. Then `caton install`.

If you want to install modules globally not locally,
try `cpanm -nq --installdeps .`.

### How to run server

    > carton exec perl script/pxe-boot-server

### How to run tests

    > carton exec prove -l

### I'm tired of `carton exec`

Try `source .rc`.

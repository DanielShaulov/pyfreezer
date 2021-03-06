#define getentropy getentropy_real
#include <sys/select.h>
#include <string.h>
#include <sys/auxv.h>
#include <unistd.h>
#include <sys/types.h>
#undef getentropy

extern void __chk_fail (void) __attribute__ ((__noreturn__));

long int
__fdelt_chk (long int d)
{
  if (d < 0 || d >= FD_SETSIZE)
    __chk_fail ();

  return d / __NFDBITS;
}

void *memcpy(void *dest, const void *src, size_t n)
{
  memmove(dest, src, n);
}

unsigned long getauxval(unsigned long type)
{
  if (type == AT_SECURE) {
    return getuid() != geteuid() || getgid() != getegid();
  }
  return 0;
}

__attribute__((weak)) void *getentropy = NULL;

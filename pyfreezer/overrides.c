#include <sys/select.h>
#include <string.h>

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

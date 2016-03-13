#include <stdlib.h>
#include <stdio.h>

int tigermain(void *, int);

int arrLenError(int len)
{
    printf("Error: attempt to create array with negative length (%d)\n",len);
    exit(1);
    return 0; /* keeping gcc happy */
}

/* p164 */
int *initArray(int size, int init) 
{
    /* Array layout: [S, elm0, elm1, ..., elmS-1].  Returning pointer
     * to elm0, which means that the size S may be ignored---but it
     * is available in case array bounds checking code is generated */
    int i;
    int *a;
    if (size<0)
	arrLenError(size);
    a = (int *)malloc((size+1)*sizeof(int));
    a[0] = size;
    for (i = 1; i <= size; i++) 
        a[i] = init;
    return (a+1);
}

int arrInxError(int index)
{
    printf("Error: array index (%d) out of range\n",index);
    exit(1);
    return 0; /* keeping gcc happy */
}

int *allocRecord(int size)
{
    int i;
    int *p, *a;
    p = a = (int *)malloc(size*sizeof(int));
    for (i = 0; i < size; i += sizeof(int)) 
        *p++ = 0;
    return a;
}

int recFieldError()
{
    printf("Error: record field lookup applied to nil\n");
    exit(1);
    return 0; /* keeping gcc happy */
}

struct string {
    int length;
    unsigned char chars[1];
};

int stringEqual(struct string *s, struct string *t)
{
    int i;
    if (s == t)
        return 1;
    if (s->length != t->length)
        return 0;
    for (i = 0; i < s->length; i++)
        if (s->chars[i] != t->chars[i])
            return 0;
    return 1;
}

int stringNotEq(struct string *s, struct string *t)
{
    return !stringEqual(s, t);
}

int stringLessEq(struct string *s, struct string *t)
{
    int i,len;
    if (s == t)
        return 1;
    len = s->length <= t->length? s->length : t->length;
    for (i = 0; i < len; i++) {
        if (s->chars[i] < t->chars[i]) return 1;
        if (s->chars[i] > t->chars[i]) return 0;
        /* s->chars[j] == t->chars[j] for all j, 0<=j<=i */
    }
    return (s->length <= t->length);
}

int stringLess(struct string *s, struct string *t)
{
    return !stringLessEq(t, s);
}

int stringGreater(struct string *s, struct string *t)
{
    return !stringLessEq(s, t);
}

int stringGreaterEq(struct string *s, struct string *t)
{
    return stringLessEq(t, s);
}

void print(void *static_link, struct string *s)
{
    int i; 
    unsigned char *p = s->chars;
    for (i = 0; i < s->length; i++, p++)
        putchar(*p);
}

void flush(void *static_link)
{
    fflush(stdout);
}

struct string consts[256];
struct string empty = { 0, "" };

int main(int argc, char *argv[])
{
    int i;
    int result;

    for (i = 0; i < 256; i++) {
        consts[i].length = 1;
        consts[i].chars[0] = i;
    }
    /* args to tigermain: 0 is the static link, 1000 is unused, but
     * easy to see on the stack, nice when debugging frames */
    result = tigermain(0, 1000);
    return result;
}

int ord(void *static_link, struct string *s)
{
    if (s->length == 0) 
        return -1;
    else 
        return s->chars[0];
}

struct string *chr(void *static_link, int i)
{
    if (i < 0 || i >= 256) {
        printf("Error: chr(%d) out of range\n",i); 
        exit(1);
    }
    return consts+i;
}

int size(void *static_link, struct string *s)
{ 
    return s->length;
}

struct string *substring(void *static_link, struct string *s, int first, int n)
{
    if (first < 0 || first+n>s->length) {
        printf("Error: substring([%d],%d,%d) out of range\n",s->length,first,n);
        exit(1);
    }
    if (n == 1)
        return consts+s->chars[first];
    {
        struct string *t = (struct string *)malloc(sizeof(int)+n);
        int i;
        t->length = n;
        for (i = 0; i < n; i++)
            t->chars[i] = s->chars[first+i];
        return t;
    }
}

struct string *concat(void *static_link, struct string *a, struct string *b)
{
    if (a->length == 0)
        return b;
    else if (b->length == 0)
        return a;
    else {
        int i, n = a->length+b->length;
        struct string *t = (struct string *)malloc(sizeof(int)+n);
        t->length = n;
        for (i = 0; i < a->length; i++)
            t->chars[i] = a->chars[i];
        for(i = 0; i < b->length; i++)
            t->chars[i+a->length] = b->chars[i];
        return t;
     }
}

int not(void *static_link, int i)
{
    return !i;
}

struct string *getChar(void *static_link)
{
    int i = getc(stdin);
    if (i == EOF)
        return &empty;
    else
        return consts+i;
}


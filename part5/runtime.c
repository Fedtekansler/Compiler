
<!-- saved from url=(0088)https://services.brics.dk/java/courseadmin/dOvs/documents/getDocument/runtime.c?d=109116 -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript" charset="UTF-8" src="./runtime_files/l.js"></script><style type="text/css"></style></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">#include &lt;stdlib.h&gt;
#include &lt;stdio.h&gt;

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
    if (size&lt;0)
	arrLenError(size);
    a = (int *)malloc((size+1)*sizeof(int));
    a[0] = size;
    for (i = 1; i &lt;= size; i++) 
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
    for (i = 0; i &lt; size; i += sizeof(int)) 
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
    if (s-&gt;length != t-&gt;length)
        return 0;
    for (i = 0; i &lt; s-&gt;length; i++)
        if (s-&gt;chars[i] != t-&gt;chars[i])
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
    len = s-&gt;length &lt;= t-&gt;length? s-&gt;length : t-&gt;length;
    for (i = 0; i &lt; len; i++) {
        if (s-&gt;chars[i] &lt; t-&gt;chars[i]) return 1;
        if (s-&gt;chars[i] &gt; t-&gt;chars[i]) return 0;
        /* s-&gt;chars[j] == t-&gt;chars[j] for all j, 0&lt;=j&lt;=i */
    }
    return (s-&gt;length &lt;= t-&gt;length);
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
    unsigned char *p = s-&gt;chars;
    for (i = 0; i &lt; s-&gt;length; i++, p++)
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

    for (i = 0; i &lt; 256; i++) {
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
    if (s-&gt;length == 0) 
        return -1;
    else 
        return s-&gt;chars[0];
}

struct string *chr(void *static_link, int i)
{
    if (i &lt; 0 || i &gt;= 256) {
        printf("Error: chr(%d) out of range\n",i); 
        exit(1);
    }
    return consts+i;
}

int size(void *static_link, struct string *s)
{ 
    return s-&gt;length;
}

struct string *substring(void *static_link, struct string *s, int first, int n)
{
    if (first &lt; 0 || first+n&gt;s-&gt;length) {
        printf("Error: substring([%d],%d,%d) out of range\n",s-&gt;length,first,n);
        exit(1);
    }
    if (n == 1)
        return consts+s-&gt;chars[first];
    {
        struct string *t = (struct string *)malloc(sizeof(int)+n);
        int i;
        t-&gt;length = n;
        for (i = 0; i &lt; n; i++)
            t-&gt;chars[i] = s-&gt;chars[first+i];
        return t;
    }
}

struct string *concat(void *static_link, struct string *a, struct string *b)
{
    if (a-&gt;length == 0)
        return b;
    else if (b-&gt;length == 0)
        return a;
    else {
        int i, n = a-&gt;length+b-&gt;length;
        struct string *t = (struct string *)malloc(sizeof(int)+n);
        t-&gt;length = n;
        for (i = 0; i &lt; a-&gt;length; i++)
            t-&gt;chars[i] = a-&gt;chars[i];
        for(i = 0; i &lt; b-&gt;length; i++)
            t-&gt;chars[i+a-&gt;length] = b-&gt;chars[i];
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
        return &amp;empty;
    else
        return consts+i;
}

</pre></body></html>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

#define NO_OF_ARGS 5
#define NO_OF_ROLES 9
#define LAST_ROLE (NO_OF_ROLES-1)

static char* msg[NO_OF_ROLES] = {
    "arg 5      28(%ebp)",
    "arg 4      24(%ebp)",
    "arg 3      20(%ebp)",
    "arg 2      16(%ebp)",
    "arg 1      12(%ebp)",
    "static link 8(%ebp)",
    "ret address 4(%ebp)",
    "old %ebp     (%ebp)",
    "local"
};

static char *line = "--------------------------------------------------\n";
static int showstack_running = 0;

void showstack (int *ebp, int *esp) {
    int *p;
    int role = 0;
    int localNr = 1;

    if (!ebp || !esp || ebp<=esp || ebp>esp+1000)
        return;

    showstack_running++;
    printf("\n-- Frame ----- addr ------ val ----------- val ",ebp,esp);
    printf("-----------------------");
    for (p=ebp+NO_OF_ARGS+2; p>=esp-2; p--) {
        printf("\n");
        if (p == ebp) {
            printf(line);
            printf("ebp ->   ");
        }
        else if (p == esp) {
            printf("esp ->   ");
        }
        else {
            if (p == esp-1) printf(line);
            printf("         ");
        }
        printf("0x%08x 0x%08x %15d   %s",(int)p,*p,*p,msg[role]);
        if (role < LAST_ROLE) role++;
        else {
            if (p >= esp) {
                printf(" %2d  %3d(%%ebp)",localNr,-4*localNr);
                localNr++;
            }
        }
    }
    printf("\n-- End frame ----------------------",ebp,esp);
    printf("-----------------------------------\n");
    showstack_running--;
}


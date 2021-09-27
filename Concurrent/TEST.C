#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>


#define NUM_THREADS  4

// Just used to send the index of the id
struct tdata {
    int tid;
};

int counter = 0;

void *count(void *ptr) {
    int tid = ((struct tdata *) ptr)->tid;
    printf("Hi, I'm thread %d\n", tid);
    pthread_exit(NULL);
}

int main (int argc, char *argv[]) {
    pthread_t threads[NUM_THREADS];
    int rc, i;
    struct tdata id[NUM_THREADS];
    for(i=0; i<NUM_THREADS; i++){
        id[i].tid = i;
        rc = pthread_create(&threads[i], NULL, count, (void *) &id[i]);
    }
    for(i=0; i<NUM_THREADS; i++){
        pthread_join(threads[i], NULL);
    }

    pthread_exit(NULL);
}
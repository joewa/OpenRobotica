#include "modelicafifos.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


#define BUFSIZE 255
//#define DEBUG

#ifdef __cplusplus
extern "C" {
#endif

int createFifo(const char *fifoName) {
  int retval;
  char buf[255];
  printf("createFifo: Creating pair of fifos...");
  sprintf(buf,"/tmp/%s.in",fifoName);
  printf("\nCreating %s",buf);
  retval = mkfifo(buf, 0666);
  if(retval==-1 && errno!=EEXIST) {
    perror("Error creating named pipe"); return -1; /*exit(1);*/ }
  sprintf(buf,"/tmp/%s.out",fifoName);
  printf("\nCreating %s",buf);
  retval = mkfifo(buf, 0666);
  if(retval==-1 && errno!=EEXIST) {
    perror("Error creating named pipe"); return -1; /*exit(1);*/ }
  return 0;
}

int openFifoIn(const char *fifoName)
{
  int fd;
  char buf[255];
  sprintf(buf,"/tmp/%s.in",fifoName);
  printf("\nopenFifoIn: Opening %s for reading\n",buf);
  fd = open(buf, O_RDONLY);
  return fd;
}

int openFifoOut(const char *fifoName)
{
  int fd;
  char buf[255];
  sprintf(buf,"/tmp/%s.out",fifoName);
  printf("\nopenFifoOut: Opening %s for writing\n",buf);
  fd = open(buf, O_WRONLY);
  return fd;
}

void extOpenFifoServer(const char* fifoName, int* fds, int fds_size) {
  char buf[255];
  createFifo(fifoName);
  fds[0] = openFifoOut(fifoName);  // Open fifo for write first; blocks until client opens for reading
  fds[1] = openFifoIn(fifoName);   // blocks until the other fifo is opened for writing
  fds[0]=0;fds[1]=0;
}

void extCreateAndOpenFile(const char* fifoName, int* fds, int fds_size) {
  char buf[255];
  fds[0]=12;fds[1]=34;
}

int extOpenFifoClient(const char *fifoName) {
  int fd_i, fd_o;
  char buf[255];
  fd_i = openFifoIn(fifoName);
  fd_o = openFifoOut(fifoName);   // blocks until the other fifo is opened for writing
  return 0;
}

int fifoOutRealArray(int fd_o, double* varout, int size) {
  int numwritten; unsigned char sendsize;
  sendsize = (unsigned char)(size*sizeof(double));
  printf("\nWriting:"); for(int i=0; i<size; i++) printf("%i:%f, ",i,varout[i]); printf("\n");
  write(fd_o, &sendsize, 1); //write length
  numwritten = write(fd_o, varout, size*sizeof(double));
  return numwritten;
}

double lastevent_time=0;
int fifoInRealArray(int fd_i, double* varin, int size) {
  int numread, i; unsigned char rcsize;
  printf("fifoInRealArray:\n");
  read(fd_i, &rcsize, 1); printf("read %i Bytes\n", rcsize); 
  numread = read(fd_i, varin, size*sizeof(double));
  if(numread != rcsize) printf("Error:fifoInRealArray. numread=%i, rcsize=%i, size=%i\n", numread, rcsize,size);
  if(varin[0] == -1) {// return from an interrupt
      varin[0] = lastevent_time;
  }
  else { // return from a scheduled event
      lastevent_time = varin[0];
  }
  //for(i=0; i<size; i++) printf("\nArrayId:%i, %f", i, varin[i]);
  return numread;
}


//BEGIN OM Workaround

int fdbufwrcount=0;
int fdbufrdcount=0;
double valbuf[255];

int fifoOutReal(int fd_o, double varout, int id, int size) {
  int numwritten;
  valbuf[id] = varout;
  fdbufwrcount++;
  if(fdbufwrcount >= size) {
    numwritten = fifoOutRealArray(fd_o, valbuf, size);
    fdbufwrcount = 0;
  }
  printf("fifoOutReal\n");
  return numwritten;
}

double fifoInReal(int fd_i, int id, int size)
{
  int numread; double varin=0;
  printf("fifoInReal: id=%i, size=%i\n",id,size);
  if(fdbufrdcount <= 0) {
    numread = fifoInRealArray(fd_i, valbuf, size);
    fdbufrdcount = size;
  }
  varin = valbuf[id];
  fdbufrdcount--;
  printf("Id:%i, Val:%f\n",id,varin);
  return varin;
}

//END OM Workaround

double extFifoIO(int fd_o, int fd_i, double t, double x) // pipe-id/fd-pair
{
  int numwritten, retval;
  fd_set lese_menge;
  char buf[255];
  //Messwert wert;
  //wert.t = t; wert.y = x;
  //sprintf(buf, "%f, %f\n", t, x);
  //write(1, buf, strlen(buf));
  FD_ZERO(&lese_menge);
  //numwritten = write(fd, &x, sizeof(x));
  FD_SET(fd_i, &lese_menge);
  // retval = select(fd+1, &lese_menge, NULL, NULL, NULL);
  // 
  return t+0.125;
}

#ifdef __cplusplus
}
#endif


#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


#include "modelicafifos.h"

#define CTRLFIFO "modelicaFifo"; //in Header definieren
#define BUFSIZE 255


int global_var=100;

void fifoclient()
{
  int fd_i, fd_o, retval, numread, numwritten, i=0;
  fd_set lese_menge, schreib_menge;
  char buf[BUFSIZE]; unsigned char rcsize,sendsize;
  double val_in, val_out=0;
  double y[10];
  double r[10]; r[0]=0;
  FD_ZERO(&lese_menge);
  FD_ZERO(&schreib_menge);
  fd_i = open("/tmp/ModelicaFifo.out",O_RDONLY);
  fd_o = open("/tmp/ModelicaFifo.in", O_WRONLY);
  if (fd_i==-1||fd_o==-1) {perror("\nError opening fifo"); exit(1); }
  printf("\nfd_i:%i, fd_o:%i\n", fd_i, fd_o);
  while(1) { i++;
    FD_SET(fd_o, &schreib_menge);
    FD_SET(0, &lese_menge);
    FD_SET(fd_i, &lese_menge);
    retval = select(fd_i+1, &lese_menge, NULL, NULL, NULL);
    if(FD_ISSET(fd_i, &lese_menge)) {
      printf("\nRead...");
      read(fd_i, &rcsize, 1); // Laenge lesen
      printf("%i Bytes\n", rcsize);
      read(fd_i, y, rcsize);
      printf("Empfangen: %f, %f\n", y[0],y[1]);
      r[0] += 0.03125; r[1]=10; sendsize=2*sizeof(double);
      printf(" Sende: %f, %f",r[0],r[1]);
      write(fd_o, &sendsize, 1);
      write(fd_o, r, sendsize);
    }
    if(FD_ISSET(0, &lese_menge)) {
      numread    = read(0, buf, BUFSIZE); if(strcmp(buf,"quit")>=0) break;
      buf[numread]='\0'; printf("Eingegeben: %s", buf);
      //sscanf(buf, "%f", &val_out); printf(" Zahl: %f", val_out);
      r[0] += 0.03125; r[1]=10;
      write(fd_o, r, 2*sizeof(double));
      printf("\nWert empfangen: %f, Simulation wartet auf Eingabe...\n", val_in);
    }
    if(FD_ISSET(fd_o, &schreib_menge)) {
      printf(" GESCHRIEBEN ");
    }
  }
  close(fd_i);
  close(fd_o);
}

int main()
{
  int lokal_var;
  pid_t pid;
  lokal_var=1;

  fifoclient();
 
  exit(0);
}
 

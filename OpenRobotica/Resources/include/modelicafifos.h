#ifndef MODELICAFIFOS_H
#define MODELICAFIFOS_H

#ifdef __cplusplus
extern "C" {
#endif


int createFifo(const char *fifoName);
void extOpenFifoServer(const char* fifoName, int* fds, int); //Name, *fds, 2
int extOpenFifoClient(const char *fifoName);
int openFifoOut(const char *fifoName);
int openFifoIn(const char *fifoName);
int fifoOutReal(int fd_o, double varout, int id, int size);
double fifoInReal(int fd_i, int id, int size);

double extFifoIO(int fd_o, int fd_i, double t, double x);

#ifdef __cplusplus
}
#endif

#endif // MODELICAFIFOS_H


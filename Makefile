CC = gcc
CFLAGS = -D_POSIX_C_SOURCE=200112L -O2 -fopenmp

FC = gfortran
FFLAGS = -O2 -fopenmp

#all: stream_f.exe stream_c.exe stream_c_v2.exe
all: stream_f.exe stream_c_v2.exe

stream_f.exe: stream.f mysecond.o
	$(CC) $(CFLAGS) -c mysecond.c
	$(FC) $(FFLAGS) -c stream.f
	$(FC) $(FFLAGS) stream.o mysecond.o -o stream_f.exe

#stream_c.exe: stream.c
#	$(CC) $(CFLAGS) stream.c -o stream_c.exe

stream_c_v2.exe: stream_v2.c
	$(CC) $(CFLAGS) stream_v2.c -o stream_c_v2.exe

clean:
	rm -f stream_f.exe stream_c.exe stream_c_v2.exe *.o

# an example of a more complex build line for the Intel icc compiler
stream.icc: stream.c
	icc -O3 -xCORE-AVX2 -ffreestanding -qopenmp -DSTREAM_ARRAY_SIZE=80000000 -DNTIMES=20 stream.c -o stream.omp.AVX2.80M.20x.icc

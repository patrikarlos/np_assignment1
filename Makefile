CC_FLAGS= -Wall -I.
LD_FLAGS= -Wall -L./ 


all: libcalc test client server

servermain.o: servermain.cpp
	$(CXX)  $(CC_FLAGS) $(CFLAGS) -c servermain.cpp 

clientmain.o: clientmain.cpp
	$(CXX) $(CC_FLAGS) $(CFLAGS) -c clientmain.cpp 

main.o: main.cpp
	$(CXX) $(CC_FLAGS) $(CFLAGS) -c main.cpp 


test: main.o calcLib.o
	$(CXX) $(LD_FLAGS) -o test main.o -lcalc

client: clientmain.o calcLib.o
	$(CXX) $(LD_FLAGS) -o client clientmain.o -lcalc

server: servermain.o calcLib.o
	$(CXX) $(LD_FLAGS) -o server servermain.o -lcalc


calcLib.o: calcLib.c calcLib.h
	gcc -Wall -fPIC -c calcLib.c

libcalc: calcLib.o
	ar -rc libcalc.a -o calcLib.o

clean:
	rm *.o *.a test server client

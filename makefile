GNUREC=-O3 -fvectorize -funroll-loops -fstrict-vtable-pointers -fslp-vectorize -freroll-loops -freciprocal-math -ffast-math -funit-at-a-time -pthread
GO=$(GNUREC)
CXX=g++ $(GO) 

## edit here
#STLPORT=./STLport-5.2.1
#STLHASHMAPLIB=/usr/local/Cellar/boost/1.73.0/include/boost/phoenix/stl/algorithm/detail #is_std_hash_map.hpp
STLHASHMAPLIB=/usr/local/Cellar/llvm/10.0.0_3/include/c++/v1/ext/
INCLUDES=-I./tclap-1.2.1/include/ -I$(STLHASHMAPLIB)
#LIBS=-L$(STLPORT)/lib
CXXFLAGS=-c $(INCLUDES) -DUSESTLPORT
LDFLAGS=$(LIBS) 
INLIBS=-lpthread -lc -lm

alignSrc=mmAligner.cpp mmEM.cpp
SOURCES=$(alignSrc)
alignObj=$(alignSrc:.cpp=.o)
OBJECTS=$(alignObj)

EXECUTABLE=m2m-aligner

all: $($SOURCES) $(EXECUTABLE)

$(EXECUTABLE):	$(OBJECTS) 
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@ $(INLIBS)

.cpp.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $< -o $@

clean:	
	rm -f $(EXECUTABLE) $(OBJECTS)

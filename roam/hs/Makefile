PLATFORM = "w64"
CC:=ghc
CLIB_ROOT:=d://roam/clib
SRCS:=triangle-opengl.c
OBJS:=$(SRCS:.c=.o)
FLAGS:=--make -no-hs-main
TARGET:=main

# Config for lib.
LINUX_GRAPHICS=glfw GL x11 pthread dl
WIN_GRAPHICS:=glfw opengl32 gdi32
GL_LIBS:=$(addprefix -l,$(GRAPHICS))


GL_LIBS:=$(addprefix -l,$(WIN_GRAPHICS))
CLIB:=$CLIB_ROOT/windows


INCLUDE_PATHS:=-I$(CLIB)/x64/include
LIBRARY_PATHS:=-L$(CLIB)/x64/glfw-mingw


build: $(SRCS) $(OBJS)
	$(CC) $(FLAGS) $(SRCS) -o $(TARGET) $(GL_LIBS) $(INCLUDE_PATHS) $(LIBRARY_PATHS)

clean:
	rm -f $(OBJS) $(TARGET)

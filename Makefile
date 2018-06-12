# Binary name
APP = app

# Build settings
LIBS = 
INCLUDES =
CC = gcc
CFLAGS += -g -Wall -Werror
BUILDDIR = build

.PHONY: default all clean

EXEC = $(BUILDDIR)/$(APP)
C_OBJECTS = $(patsubst %.c, $(BUILDDIR)/%.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

default: $(EXEC)
all: default

.SECONDEXPANSION:
$(C_OBJECTS): %.o: $$(notdir %.c) $(HEADERS)
	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(EXEC): $(C_OBJECTS)
	$(CC) $(C_OBJECTS) $(CFLAGS) $(LIBS) -o $@

clean:
	@rm -f $(C_OBJECTS)
	@rm -f $(EXEC)

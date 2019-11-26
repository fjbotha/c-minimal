# Binary name
APP := app

# Build settings
LIBS :=
INCLUDES :=
CC_PREFIX :=
CC := $(CC_PREFIX)gcc
CFLAGS := -g -Wall -Werror
BUILDDIR := build

.PHONY: default all clean

EXEC := $(BUILDDIR)/$(APP)
OBJECTS = $(patsubst %.c, $(BUILDDIR)/%.o, $(SOURCES))
AUTODEPS = $(patsubst %.c, $(BUILDDIR)/%.d, $(SOURCES))

SOURCES := main.c

default: $(EXEC)
all: default

$(BUILDDIR)/%.o: %.c
	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) $(CFLAGS) $(LIBS) -o $@

clean:
	@rm -f $(OBJECTS)
	@rm -f $(AUTODEPS)
	@rm -f $(EXEC)

$(BUILDDIR)/%.d: %.c
	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
	@set -e; rm -f $@; \
	$(CC) -M $(CFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,$(BUILDDIR)/\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

-include $(AUTODEPS)

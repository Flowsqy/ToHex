TARGET_EXEC := ToHex
DEV_TEST_EXEC := dev-test

BUILD_DIR := ./build
SRCS_DIR := ./src

# Compilation
CC = clang
CFLAGS = -std=gnu11 -Wall -pedantic -O3

MAIN_FILE := $(SRCS_DIR)/main
SRCS := $(filter-out $(MAIN_FILE).c, $(wildcard $(SRCS_DIR)/*.c))
OBJS := $(SRCS:%.c=$(BUILD_DIR)/%.o)

.PHONY: all
all: main

.PHONY: build
build: main

.PHONY: main
main: $(BUILD_DIR)/$(TARGET_EXEC)

# Link main executable
$(BUILD_DIR)/$(TARGET_EXEC): $(BUILD_DIR)/$(MAIN_FILE).o $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

# Compile default
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: run
run: $(BUILD_DIR)/$(TARGET_EXEC)
	$^

.PHONY: clean
clean:
	rm -rf -- $(BUILD_DIR)


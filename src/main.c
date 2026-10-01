#include "unistd.h"

#define READ_BUFFER_SIZE 4096

#define TO_HEX_DIGIT(x) (x) < 10 ? '0' + (x) : 'A' + ((x) - 10)

int main(void) {
    int read_bytes = 0;
    char read_buffer[READ_BUFFER_SIZE];
    char display_buffer[READ_BUFFER_SIZE*2];
    do {
        read_bytes = read(STDIN_FILENO, read_buffer, READ_BUFFER_SIZE);
        if (read_bytes < 1) {
            break;
        }
        for (int read_byte_index = 0; read_byte_index < read_bytes; read_byte_index++) {
            display_buffer[read_byte_index << 1] = TO_HEX_DIGIT((read_buffer[read_byte_index] >> 4) & 0xF);
            display_buffer[(read_byte_index << 1) + 1] = TO_HEX_DIGIT(read_buffer[read_byte_index] & 0xF);
        }
        write(STDOUT_FILENO, display_buffer, read_bytes << 1);
    } while (read_bytes == READ_BUFFER_SIZE);
    return 0;
}

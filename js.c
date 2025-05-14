#include <errno.h>
#include <string.h>

#include "elk.h"

#include "uart.h"

jsval_t print_uart(struct js *js, jsval_t *args, int nargs) {
    if (nargs != 2) return js_mkerr(js, "2 args expected\n");
    double len_double = js_getnum(args[1]); // Get length first
    size_t len = (size_t) len_double;
    char* str = js_getstr(js, args[0], &len);  // Fetch 1st arg
    uart_puts(str);
    return js_mktrue();
}

int main() {
    char mem[1024];
    struct js *js = js_create(mem, sizeof(mem));

    js_set(js, js_glob(js), "print_uart", js_mkfun(print_uart));
    char *js_code = "let msg = \"Hello from JS!\";\n"
    "for (let i = 0; i < 10; i++) {\n"
    "    let iteration_message = \"\";\n"
    "    for (let j = 0; j < i; j++) { iteration_message += msg; }\n"
    "    iteration_message += \"\\n\";\n"
    "    print_uart(iteration_message, iteration_message.length);"
    "}\n"
    "let successMessage = \"Successful JavaScript!\\n\";\n"
    "print_uart(successMessage, successMessage.length);";
    jsval_t result = js_eval(js, js_code, strlen(js_code));
    uart_puts(js_str(js, result)); uart_putc('\n');

    return 0;
}

void* _sbrk(int incr) {
    return (void*) NULL;
}
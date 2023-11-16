package main

import dro "../../."
import "core:c/libc"
import "core:fmt"
import "core:os"

main :: proc() {
    b := dro.binout_open("./examples/binout/binout0000")
    if err := dro.binout_open_error(&b); err != nil {
        fmt.eprintf("failed to open binout: %s\n", err)
        libc.free(rawptr(err))
        os.exit(1)
    }
    defer dro.binout_close(&b)

    type_id: dro.binout_type
    timed: b32
    real := dro.binout_simple_path_to_real(
        &b,
        "nodout/d000001",
        &type_id,
        &timed,
    )
    defer libc.free(rawptr(real))

    fmt.printf("type_id=%v timed=%v\n", type_id, timed)

    num_children: uint
    children := dro.binout_get_children(&b, real, &num_children)
    defer dro.binout_free_children(children)

    for i: uint = 0; i < num_children; i += 1 {
        fmt.printf("%s\n", children[i])
    }
}

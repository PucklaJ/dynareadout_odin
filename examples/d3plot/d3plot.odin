package main

import dro "../../."
import "core:c"
import "core:c/libc"
import "core:fmt"
import "core:os"

main :: proc() {
    d := dro.d3plot_open("./examples/d3plot/d3plot")
    defer dro.d3plot_close(&d)
    if err := d.error_string; err != nil {
        fmt.eprintf("failed to open d3plot: {}\n", err)
        os.exit(1)
    }

    num_nodes: c.size_t
    node_ids := dro.d3plot_read_node_ids(&d, &num_nodes)
    defer libc.free(rawptr(node_ids))

    fmt.printf("Number of Nodes: {}\n", num_nodes)
    fmt.printf("[")
    for i: c.size_t; i < num_nodes; i += 1 {
        fmt.printf("{}", node_ids[i])
        if i != num_nodes - 1 {
            fmt.printf(", ")
        }
    }
    fmt.printf("]\n")

    num_shells: c.size_t
    shell_ids := dro.d3plot_read_shell_element_ids(&d, &num_shells)
    defer libc.free(rawptr(shell_ids))

    fmt.printf("Num Shells: {}\n", num_shells)
    fmt.printf("[")
    for i: c.size_t; i < num_shells; i += 1 {
        fmt.printf("{}", shell_ids[i])
        if i != num_shells - 1 {
            fmt.printf(", ")
        }
    }
    fmt.printf("]\n")

    fmt.printf("Num States: {}\n", d.num_states)
    for i: c.size_t; i < d.num_states; i += 1 {
        fmt.printf("State {}={}\n", i, dro.d3plot_read_time(&d, i))

        num_els, num_his: c.size_t
        shells := dro.d3plot_read_shells_state(&d, i, &num_els, &num_his)
        defer dro.d3plot_free_shells_state(shells)

        for j: c.size_t; j < num_els; j += 1 {
            mean := dro.d3plot_get_shell_mean(&shells[j])
            defer dro.d3plot_free_surface(mean)

            fmt.printf("Shell {}={}: {}\n", j, shell_ids[j], mean.stress)
        }
    }
}


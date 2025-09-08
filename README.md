### ⚠️ WIP

# Random number generation toolkit for Ada

Design principles mostly inspired by the [rand](https://github.com/rust-random/rand) Rust crate.

The project is split into several subcrates. `rand_core`, `rand_chacha`, `rand_xoshiro256` and `rand_distributions` can be used on embedded; However, `rand_sys` (and its dependent `rand`, the main crate) pull entropy from system sources, using the [`system_random`](https://alire.ada.dev/crates/system_random) Alire crate.

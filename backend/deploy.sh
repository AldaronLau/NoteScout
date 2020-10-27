#!/usr/bin/sh

cargo build --release
scp target/release/backend notescout@10.0.0.90:~/notescout

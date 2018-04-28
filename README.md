# admin-scripts

## Purpose
Collection of bash scripts for system / server administration tasks.

The functions mainly focus on knowing what happens on a system, what is
the status of something, reporting, and access to said system.

## Usage
Every script in the root directory can be executed individually, without
depending on another script.

The only exceptions are things in the `lib` directory. These are shared
resources (helpers, etc.), used by the "regular" scripts in the root directory.

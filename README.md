# pdAudio

Bits and pieces I use in puredata projects.
If there is documentation it's mainly for myself.

## Dependencies

see `./dependencies.fish`

## Build Dependencies

- fish shell
- git
- autotools (only needed to build the dependencies)

## Initialize Project

init project (download dependencies, ...):

	$ ./scripts/init.fish

## Installation

	$ ./scripts/install.fish --deps --link

By default this installs all objs in `pd_objs` plus dependencies into `./install`.
For details, append the `--help` option.

## Running

	$ ./scripts/run.fish

## Uninstall

	$ rm -rf ./dependencies
	$ rm -r ./install

## Documentation

None

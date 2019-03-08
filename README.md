# Beacon-Server

[Beacon](https://github.com/pharo-project/pharo-beacon) server for [Pharo](https://www.pharo.org/) utilizes JSON RPC for collecting Beacon signals from remote systems.

## Installation

```smalltalk
Metacello new
  baseline: 'BeaconServer';
  repository: 'github://grype/Beacon-Server';
  load.
```

## Usage

This is really all there is to it:

```smalltalk
server := BeaconServer new.
server start.
server isRunning.
server stop.
```

Start instances of BeaconServer and SignalLogger and you're all set...

## How does this work?

`BeaconServer` utilizes a [JRPC](https://github.com/juliendelplanque/JRPC) server to capture signals. It also extends Beacon's hierarchy of Signals with Remote equivalents. This adds two things: #source attribute, which captures signal's origin; and special handling of stack traces (see: `RemoteCallStackFrame` & `TBeaconRemoteCallStack`).

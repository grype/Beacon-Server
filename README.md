# Beacon-Server

Server for collecting [Beacon](https://github.com/pharo-project/pharo-beacon) signals from remote clients in [Pharo](https://www.pharo.org/).

## Installation

```smalltalk
Metacello new
  baseline: 'BeaconServer';
  repository: 'github://grype/Beacon-Server';
  load.
```

## Usage

Create and start an instance of `BeaconServer` and an instance of `SignalLogger`, and you're all set.

```smalltalk
server := BeaconServer new.

"Start server on port 4000"
server startOn: 4000. 

"Start a logger"
logger := MemoryLogger instance.
logger start.
logger inspect.

"When done, stop the server"
server stop.
```

## How does it work?

`BeaconServer` utilizes a [JRPC](https://github.com/juliendelplanque/JRPC) server for capturing Beacon signals from remote clients in JSON format. It also extends Beacon's existing hierarchy of signals with remote equivalents that capture information about the origin of the signal and provide special handling for things like stack traces. This makes it possible to capture arbitrary signals from other, non-Pharo based clients.

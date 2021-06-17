"
I am a server for logging remote beacon signals.

I utilize JSON-RPC server for gathering remote signals in JSON format, materializing them into appropriate subclasses of BeaconSignal, and then emitting them.

To use me:

server := BeaconServer new.
server startOn: 4000. ""to start listening on port 4000""
server stop. ""to stop""

 
Instance Variables
	jrpcServer:		<JRPCServer>
"
Class {
	#name : #BeaconServer,
	#superclass : #Object,
	#instVars : [
		'jrpcServer',
		'parser'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #'event handling' }
BeaconServer >> handleEmittedData: aSignalData [
	| signal |
	
	signal := parser parse: aSignalData.
	signal emit
]

{ #category : #initialization }
BeaconServer >> initialize [
	super initialize.
	parser := BeaconRemoteSignalParser new.
	jrpcServer := JRPCServer http
		addHandlerNamed: 'emit'
			block: [ :signalData | 
				signalData do: [ :each | self handleEmittedData: each ] ];
		yourself
]

{ #category : #testing }
BeaconServer >> isRunning [ 
	^ jrpcServer isRunning 
]

{ #category : #accessing }
BeaconServer >> port [
	^ jrpcServer port
]

{ #category : #'starting/stopping' }
BeaconServer >> startOn: aPort [
	self isRunning ifTrue: [ self stop ].
	jrpcServer
		port: aPort;
		start
]

{ #category : #'starting/stopping' }
BeaconServer >> stop [
	jrpcServer stop
]

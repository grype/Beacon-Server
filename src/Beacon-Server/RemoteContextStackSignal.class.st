Class {
	#name : #RemoteContextStackSignal,
	#superclass : #ContextStackSignal,
	#traits : 'TBeaconRemoteSignal',
	#classTraits : 'TBeaconRemoteSignal classTrait',
	#category : #'Beacon-Server-Signals'
}

{ #category : #'*Beacon-Server' }
RemoteContextStackSignal >> stack: aStack [
	stack := aStack
]

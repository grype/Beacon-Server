Class {
	#name : #RemoteContextStackSignal,
	#superclass : #ThisContextSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconRemoteCallStack',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconRemoteCallStack classTrait',
	#category : #'Beacon-Server-Signals'
}

{ #category : #initialize }
RemoteContextStackSignal >> currentStack [
	^ self stack 
]

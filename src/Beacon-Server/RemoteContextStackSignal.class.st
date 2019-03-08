Class {
	#name : #RemoteContextStackSignal,
	#superclass : #ThisContextSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconRemoteCallStack + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconRemoteCallStack classTrait + TBeaconMaterializing classTrait',
	#category : #'Beacon-Server-Signals'
}

{ #category : #initialize }
RemoteContextStackSignal >> currentStack [
	^ self stack 
]

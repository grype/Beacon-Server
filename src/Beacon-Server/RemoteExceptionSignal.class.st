"
I encapsulate a remote exception signal, similar to ==ExceptionSignal==.
"
Class {
	#name : #RemoteExceptionSignal,
	#superclass : #ExceptionSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconRemoteCallStack + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconRemoteCallStack classTrait + TBeaconMaterializing classTrait',
	#category : #'Beacon-Server-Signals'
}

{ #category : #'gt-inspector-extension' }
RemoteExceptionSignal >> gtInspectorDisplayType [
	^ self class name
]

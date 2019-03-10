"
I encapsulate a remote string signal, similar to ==StringSignal==.
"
Class {
	#name : #RemoteStringSignal,
	#superclass : #StringSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconMaterializing classTrait',
	#category : #'Beacon-Server-Signals'
}

"
I represent the basis of a remote signal source.

I define properties that ==BeaconServer== expects to find in JSON representations of a remote signal's source. That information encapsulates information about the origin of the remote signal, as seen by the originating system.

By default, ==BeaconServer== will create instances of ==GenericSignalSource==, and looks for '__class' attribute in the JSON data to identify local class to instantiate - which has to use me in its trait composition.

Instance Variables
	identifier:		<String> - Unique identifier of the signal sender, e.g. unique device identifier

"
Trait {
	#name : #TBeaconRemoteSignalSource,
	#instVars : [
		'identifier'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #'gt-inspector-extension' }
TBeaconRemoteSignalSource >> gtInspectorDisplayString [
	^ self printString truncateTo: 32
]

{ #category : #accessing }
TBeaconRemoteSignalSource >> identifier [
	^ identifier
]

{ #category : #accessing }
TBeaconRemoteSignalSource >> identifier: anObject [
	identifier := anObject
]

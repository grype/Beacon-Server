Class {
	#name : #BaselineOfBeaconServer,
	#superclass : #BaselineOf,
	#category : #BaselineOfBeaconServer
}

{ #category : #baselines }
BaselineOfBeaconServer >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self deps: spec.
			spec
				package: #'Beacon-Server'
				with: [ spec requires: #('Beacon' 'JRPC') ].
			spec group: 'default' with: #('Beacon-Server') ]
]

{ #category : #baselines }
BaselineOfBeaconServer >> deps: spec [
	spec
		baseline: 'Beacon'
			with: [ spec repository: 'github://pharo-project/pharo-beacon' ];
		baseline: 'JRPC'
			with: [ spec repository: 'github://JulienDelplanque/JRPC' ]
]

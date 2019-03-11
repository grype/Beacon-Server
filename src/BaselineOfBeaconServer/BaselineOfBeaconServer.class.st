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
					with: [ spec requires: #('Beacon' 'JRPC') ];
				package: #'Beacon-Server-Tests'
					with: [ spec requires: #('Beacon-Server' 'Mocketry') ].
			spec
				group: 'Core' with: #('Beacon-Server');
				group: 'Tests' with: #('Beacon-Server-Tests');
				group: 'default' with: #('Core' 'Tests') ]
]

{ #category : #baselines }
BaselineOfBeaconServer >> deps: spec [
	spec
		baseline: 'Beacon'
			with: [ spec repository: 'github://pharo-project/pharo-beacon' ];
		baseline: 'JRPC'
			with: [ spec repository: 'github://JulienDelplanque/JRPC' ];
		baseline: 'Mocketry'
			with: [ spec repository: 'github://dionisiydk/Mocketry' ]
]

"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBeaconServer,
	#superclass : #PackageManifest,
	#category : #'Beacon-Server-Manifest'
}

{ #category : #'code-critics' }
ManifestBeaconServer class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'MemoryLogger class' #gtTimelineOn: #true)) #'2022-10-06T11:12:35.066098-07:00') )
]

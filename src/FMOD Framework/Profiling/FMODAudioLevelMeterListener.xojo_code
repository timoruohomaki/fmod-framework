#tag Interface
Protected Interface FMODAudioLevelMeterListener
Implements FMODAudioProfilerListener
	#tag Method, Flags = &h0
		Sub OnLevelUpdate(peakLevels() as Single, rmsLevels() as Single, numChannels as Integer)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface

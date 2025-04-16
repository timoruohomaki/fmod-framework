#tag Interface
Private Interface IAudioProfiler
	#tag Method, Flags = &h0
		Sub EndTiming(operationName As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAverageCPUUsage() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPeakMemoryUsage() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProfileData() As Dictionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordBufferStats(bufferSize As UInt32, bufferUsage As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordChannelUsage(activeChannels As UInt32, totalChannels As UInt32)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordCPUUsage(moduleIdentifier As String, usagePercentage As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordDSPUsage(dspName As String, usagePercentage As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordMemoryUsage(moduleIdentifier As String, bytesUsed As UInt64)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTiming(operationName As String)
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Interface
#tag EndInterface

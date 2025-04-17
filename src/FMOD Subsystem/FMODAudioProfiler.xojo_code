#tag Class
Protected Class FMODAudioProfiler
Implements IAudioProfiler
	#tag Method, Flags = &h0
		Sub Constructor()
		  mMetricsData = New Dictionary
		  mTimingData = New Dictionary
		  mStartTimes = New Dictionary
		  mCPUReadings = 0
		  mTotalCPUUsage = 0
		  mPeakMemoryUsage = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  If mStartTimes.HasKey(operationName) Then
		    var startTime As UInt64 = mStartTimes.Value(operationName)
		    var endTime As UInt64 = System.Microseconds
		    var duration As UInt64 = endTime - startTime
		    
		    var key As String = "timing_" + operationName
		    
		    // Store running average for timing operations
		    If mTimingData.HasKey(key) Then
		      var dataDict As Dictionary = mTimingData.Value(key)
		      var count As Integer = dataDict.Value("count")
		      var total As UInt64 = dataDict.Value("total")
		      var max As UInt64 = dataDict.Value("max")
		      
		      dataDict.Value("count") = count + 1
		      dataDict.Value("total") = total + duration
		      dataDict.Value("avg") = (total + duration) / (count + 1)
		      
		      If duration > max Then
		        dataDict.Value("max") = duration
		      End If
		    Else
		      var dataDict As New Dictionary
		      dataDict.Value("count") = 1
		      dataDict.Value("total") = duration
		      dataDict.Value("avg") = duration
		      dataDict.Value("max") = duration
		      
		      mTimingData.Value(key) = dataDict
		    End If
		    
		    // Remove the start time
		    mStartTimes.Remove(operationName)
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_GetDSPBufferSize(systemPtr As Ptr, ByRef bufferlength As Integer, ByRef numbuffers As Integer) As Integer
		  Declare Function FMOD_System_GetDSPBufferSize Lib FMODLib(systemPtr As Ptr, ByRef bufferlength As Integer, ByRef numbuffers As Integer) As Integer
		  
		  Return bufferlength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAverageCPUUsage() As Double
		  // Part of the IAudioProfiler interface.
		  
		  If mCPUReadings > 0 Then
		    Return mTotalCPUUsage / mCPUReadings
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPeakMemoryUsage() As UInt64
		  // Part of the IAudioProfiler interface.
		  
		  Return mPeakMemoryUsage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProfileData() As Dictionary
		  // Part of the IAudioProfiler interface.
		  
		  var result As New Dictionary
		  
		  // Copy all metrics data
		  For Each key As Variant In mMetricsData.Keys
		    result.Value(key) = mMetricsData.Value(key)
		  Next
		  
		  // Add timing data
		  result.Value("timing_data") = mTimingData.Clone
		  
		  // Add summary metrics
		  result.Value("avg_cpu_usage") = GetAverageCPUUsage()
		  result.Value("peak_memory") = mPeakMemoryUsage
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordBufferStats(bufferSize As UInt32, bufferUsage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  mMetricsData.Value("buffer_size") = bufferSize
		  mMetricsData.Value("buffer_usage_percent") = bufferUsage
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordChannelUsage(activeChannels As UInt32, totalChannels As UInt32)
		  // Part of the IAudioProfiler interface.
		  
		  mMetricsData.Value("active_channels") = activeChannels
		  mMetricsData.Value("total_channels") = totalChannels
		  mMetricsData.Value("channel_usage_percent") = (activeChannels / totalChannels) * 100
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordCPUUsage(moduleIdentifier As String, usagePercentage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  mTotalCPUUsage = mTotalCPUUsage + usagePercentage
		  mCPUReadings = mCPUReadings + 1
		  
		  var key As String = "cpu_" + moduleIdentifier
		  
		  If mMetricsData.HasKey(key) Then
		    
		    var currentMax As Double = mMetricsData.Value(key)
		    
		    If usagePercentage > currentMax Then
		      mMetricsData.Value(key) = usagePercentage
		    End If
		    
		  Else
		    mMetricsData.Value(key) = usagePercentage
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordDSPUsage(dspName As String, usagePercentage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  var key As String = "dsp_" + dspName
		  
		  mMetricsData.Value(key) = usagePercentage
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordMemoryUsage(moduleIdentifier As String, bytesUsed As UInt64)
		  // Part of the IAudioProfiler interface.
		  
		  If bytesUsed > mPeakMemoryUsage Then
		    mPeakMemoryUsage = bytesUsed
		  End If
		  
		  var key As String = "mem_" + moduleIdentifier
		  
		  mMetricsData.Value(key) = bytesUsed
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  mMetricsData.Clear
		  mTimingData.Clear
		  mStartTimes.Clear
		  mCPUReadings = 0
		  mTotalCPUUsage = 0
		  mPeakMemoryUsage = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  mStartTimes.Value(operationName) = System.Microseconds
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCPUReadings As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMetricsData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPeakMemoryUsage As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartTimes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimingData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalCPUUsage As Double
	#tag EndProperty


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
End Class
#tag EndClass

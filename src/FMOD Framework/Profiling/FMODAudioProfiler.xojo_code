#tag Class
Protected Class FMODAudioProfiler
Implements IAudioProfiler
	#tag Method, Flags = &h0
		Sub AddListener(listener as FMODAudioProfilerListener)
		  // Check if the listener is already in the array
		  For i As Integer = 0 To mListeners.Ubound
		    If mListeners(i) = listener Then
		      Return
		    End If
		  Next
		  
		  // Add the listener
		  mListeners.Append(listener)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // Get the FMOD system instance
		  mSystem = FMODSystem.Instance
		  
		  // Get the library manager instance
		  mLibraryManager = FMODLibraryManager.Instance
		  
		  // Initialize the timer
		  mUpdateTimer = New Timer
		  mUpdateTimer.Period = mCollectionInterval
		  AddHandler mUpdateTimer.Action, WeakAddressOf UpdateTimerAction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Stop the timer if it's running
		  mUpdateTimer.Mode = Timer.ModeOff
		  
		  // Remove event handler
		  RemoveHandler mUpdateTimer.Action, WeakAddressOf UpdateTimerAction
		  
		  // Clear listeners
		  mListeners.ResizeTo(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormatCPUUsage() As String
		  var result As String = "CPU Usage:" + EndOfLine
		  result = result + "  DSP: " + Format(mCPUUsage.dsp * 100, "#,##0.00").Replace(".", ",") + "%" + EndOfLine
		  result = result + "  Stream: " + Format(mCPUUsage.stream * 100, "#,##0.00").Replace(".", ",") + "%" + EndOfLine
		  result = result + "  Geometry: " + Format(mCPUUsage.geometry * 100, "#,##0.00").Replace(".", ",") + "%" + EndOfLine
		  result = result + "  Update: " + Format(mCPUUsage.update * 100, "#,##0.00").Replace(".", ",") + "%" + EndOfLine
		  result = result + "  Total: " + Format(mCPUUsage.total * 100, "#,##0.00").Replace(".", ",") + "%"
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormatMemoryUsage() As String
		  var result As String = "Memory Usage:" + EndOfLine
		  
		  // Convert bytes to more readable format
		  var currentAllocMB As Double = mMemoryUsage.currentallocated / (1024 * 1024)
		  var maxAllocMB As Double = mMemoryUsage.maxallocated / (1024 * 1024)
		  
		  result = result + "  Current: " + Format(currentAllocMB, "#,##0.00").Replace(".", ",") + " MB" + EndOfLine
		  result = result + "  Maximum: " + Format(maxAllocMB, "#,##0.00").Replace(".", ",") + " MB"
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetChannelsPlaying() As Integer
		     Return mChannelsPlaying
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCollectionInterval() As Interval
		     Return mCollectionInterval
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCPUUsage() As FMODStrctures.FMOD_CPU_USAGE
		  Return mCPUUsage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDSPBufferCount() As Integer
		      Return mDSPBufferCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDSPBufferLength() As Integer
		  Return mDSPBufferLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMemoryUsage() As FMODStructures.FMOD_MEMORY_USAGE
		    Return mMemoryUsage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMeteringChannelCount() As Integer
		  If mMeteringEnabled Then
		    Return mMeteringInfo.numchannels
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMeteringInfo() As FMODStructures.FMOD_DSP_METERING_INFO
		     Return mMeteringInfo
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPeakLevels() As Single()
		  var result() As Single
		  
		  If mMeteringEnabled Then
		    result.ResizeTo(mMeteringInfo.numchannels - 1)
		    
		    For i As Integer = 0 To mMeteringInfo.numchannels - 1
		      result(i) = mMeteringInfo.peaklevel(i)
		    Next
		  End If
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRMSLevels() As Single()
		  var result() As Single
		  
		  If mMeteringEnabled Then
		    result.ResizeTo(mMeteringInfo.numchannels - 1)
		    
		    For i As Integer = 0 To mMeteringInfo.numchannels - 1
		      result(i) = mMeteringInfo.rmslevel(i)
		    Next
		  End If
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTotalChannels() As Integer
		      Return mTotalChannels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize() As Boolean
		  // Check if FMOD system is initialized
		  If Not mSystem.IsInitialized Then
		    Return False
		  End If
		  
		  Try
		    // Get initial DSP buffer information
		    UpdateDSPBufferInfo()
		    
		    // Initialize metering if requested
		    If Not InitializeLevelMetering() Then
		      System.DebugLog("Warning: Level metering could not be initialized")
		      // Continue anyway, as metering is optional
		    End If
		    
		    // Start collecting data
		    mUpdateTimer.Mode = Timer.ModeMultiple
		    
		    Return True
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Failed to initialize audio profiler: " + ex.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InitializeLevelMetering() As Boolean
		  If Not mSystem.IsInitialized Then
		    Return False
		  End If
		  
		  Try
		    // Get the master channel group
		    var result As Integer = mLibraryManager.GetMasterChannelGroup(mSystem.SystemPtr, mMasterChannelGroup)
		    
		    If result <> FMODStructures.FMOD_RESULT.OK Then
		      System.DebugLog("Failed to get master channel group: " + FMODSystem.ResultToString(result))
		      Return False
		    End If
		    
		    // Get the head DSP from the master channel group
		    result = mLibraryManager.ChannelGroup_GetDSP(mMasterChannelGroup, FMODStructures.FMOD_CHANNELCONTROL_DSP_INDEX.HEAD, mMasterDSP)
		    
		    If result <> FMODStructures.FMOD_RESULT.OK Then
		      System.DebugLog("Failed to get master DSP: " + FMODSystem.ResultToString(result))
		      Return False
		    End If
		    
		    // Enable metering on the master DSP
		    result = mLibraryManager.DSP_SetMeteringEnabled(mMasterDSP, True, True)
		    
		    If result <> FMODStructures.FMOD_RESULT.OK Then
		      System.DebugLog("Failed to enable metering: " + FMODSystem.ResultToString(result))
		      Return False
		    End If
		    
		    mMeteringEnabled = True
		    Return True
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error initializing level metering: " + ex.Message)
		    mMeteringEnabled = False
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsMeteringEnabled() As Boolean
		     Return mMeteringEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LevelToDecibels(level as Single) As Single
		  // Avoid log(0)
		  If level <= 0.0000001 Then
		    Return -80.0 // -80 dB floor
		  End If
		  
		  // Convert linear level to dB: dB = 20 * log10(level)
		  Return 20.0 * Log10(level)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyListeners()
		  // Get level data if metering is enabled
		  var peakLevels() As Single
		  var rmsLevels() As Single
		  var numChannels As Integer = 0
		  
		  If mMeteringEnabled Then
		    peakLevels = GetPeakLevels()
		    rmsLevels = GetRMSLevels()
		    numChannels = GetMeteringChannelCount()
		  End If
		  
		  // Notify all registered listeners
		  For Each listener As FMODAudioProfilerListener In mListeners
		    If listener <> Nil Then
		      // General update for all listeners
		      listener.OnProfilerUpdate(Self)
		      
		      // Level meter update for specialized listeners
		      If mMeteringEnabled And listener IsA FMODAudioLevelMeterListener Then
		        var levelListener As FMODAudioLevelMeterListener = FMODAudioLevelMeterListener(listener)
		        levelListener.OnLevelUpdate(peakLevels, rmsLevels, numChannels)
		      End If
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveListener(listener As FMODAudioProfilerListener)
		  For i As Integer = 0 To mListeners.Ubound
		    If mListeners(i) = listener Then
		      mListeners.Remove(i)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCollectionInterval(intervalMS As Integer)
		  // Ensure the interval is reasonable (minimum 100ms, maximum 10000ms)
		  mCollectionInterval = Max(100, Min(10000, intervalMS))
		  mUpdateTimer.Period = mCollectionInterval
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Shutdown()
		  // Stop the timer
		  mUpdateTimer.Mode = Timer.ModeOff
		  
		  // Disable metering if it was enabled
		  If mMeteringEnabled And mMasterDSP <> Nil Then
		    var result As Integer = mLibraryManager.DSP_SetMeteringEnabled(mMasterDSP, False, False)
		    
		    If result <> FMODStructures.FMOD_RESULT.OK Then
		      System.DebugLog("Failed to disable metering: " + FMODSystem.ResultToString(result))
		    End If
		    
		    mMeteringEnabled = False
		    mMasterDSP = Nil
		    mMasterChannelGroup = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateChannelCounts()
		  If Not mSystem.IsInitialized Then
		    Return
		  End If
		  
		  var result As Integer = mLibraryManager.GetChannelsPlaying(mSystem.SystemPtr, mChannelsPlaying, mTotalChannels)
		  
		  If result <> FMODStructures.FMOD_RESULT.OK Then
		    System.DebugLog("Failed to get channel counts: " + FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateCPUUsage()
		  If Not mSystem.IsInitialized Then
		    Return
		  End If
		  
		  var result As Integer = mLibraryManager.GetCPUUsage(mSystem.SystemPtr, mCPUUsage)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to get CPU usage: " + FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateDSPBufferInfo()
		  If Not mSystem.IsInitialized Then
		    Return
		  End If
		  
		  var result As Integer = mLibraryManager.GetDSPBufferSize(mSystem.SystemPtr, mDSPBufferLength, mDSPBufferCount)
		  
		  If result <> FMODStructures.FMOD_RESULT.OK Then
		    System.DebugLog("Failed to get DSP buffer size: " + FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateLevelMetering()
		  If Not mSystem.IsInitialized Or Not mMeteringEnabled Or mMasterDSP = Nil Then
		    Return
		  End If
		  
		  var result As Integer = mLibraryManager.DSP_GetMeteringInfo(mMasterDSP, mMeteringInfo)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to get metering info: " + FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateMemoryUsage()
		  If Not mSystem.IsInitialized Then
		    Return
		  End If
		  
		  var result As Integer = mLibraryManager.GetMemoryInfo(mSystem.SystemPtr, mMemoryUsage)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to get memory usage: " + FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateTimerAction(sender as Timer)
		  If Not mSystem.IsInitialized Then
		    Return
		  End If
		  
		  Try
		    // Update all profiler data
		    UpdateCPUUsage()
		    UpdateMemoryUsage()
		    UpdateChannelCounts()
		    
		    // Update level metering if enabled
		    If mMeteringEnabled Then
		      UpdateLevelMetering()
		    End If
		    
		    // Notify listeners
		    NotifyListeners()
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error updating profiler data: " + ex.Message)
		  End Try
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mInstance Is Nil Then
			    mInstance = New FMODAudioProfiler
			  End If
			  
			  Return mInstance
			End Get
		#tag EndGetter
		Instance() As FMODAudioProfiler
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mChannelsPlaying As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCollectionInterval As Integer = 1000
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCPUUsage As FMODStructures.FMOD_CPU_USAGE
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDSPBufferCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDSPBufferLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mInstance As FMODAudioProfiler
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLibraryManager As FMODLibraryManager
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mListeners() As FMODAudioProfilerListener
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMasterChannelGroup As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMasterDSP As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMemoryUsage As FMODStructures.FMOD_MEMORY_USAGE
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMeteringEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMeteringInfo As FMODStructures.FMOD_DSP_METERING_INFO
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSystem As FMODSystem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTotalChannels As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUpdateTimer As Timer
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

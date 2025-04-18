#tag Class
Protected Class FMODSystem
	#tag Method, Flags = &h0
		Sub Constructor()
		  mSystemPtr = Nil
		  mInitialized = False
		  
		  mLogger = New FMODLogger
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  // Shut down the system if it's still initialized
		  If mInitialized Then
		    Shutdown()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExpectedVersionToString(version as UInt32) As String
		  Return VersionToString(version)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSystemPtr() As Ptr
		  Return mSystemPtr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Initialize() As Boolean
		  // Return true if already initialized
		  If mInitialized Then
		    Return True
		  End If
		  
		  Try
		    // Get the library manager instance first
		    var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		    
		    // Create the FMOD system using the library manager
		    var result As Integer = libManager.CreateSystem(mSystemPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT.OK Then
		      LogError("Failed to create FMOD system: " + ResultToString(result))
		      Return False
		    End If
		    
		    // Initialize the system
		    // Default settings: 32 channels, FMOD_INIT.NORMAL flags
		    result = libManager.InitSystem(mSystemPtr, 32, FMODStructures.FMOD_INIT.NORMAL)
		    
		    If result <> FMODStructures.FMOD_RESULT.OK Then
		      LogError("Failed to initialize FMOD system: " + ResultToString(result))
		      // Clean up on error
		      libManager.ReleaseSystem(mSystemPtr)
		      mSystemPtr = Nil
		      Return False
		    End If
		    
		    mInitialized = True
		    Return True
		    
		  Catch ex As RuntimeException
		    LogError("Error initializing FMOD: " + ex.Message)
		    
		    // Clean up on error
		    If mSystemPtr <> Nil Then
		      var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		      libManager.ReleaseSystem(mSystemPtr)
		      mSystemPtr = Nil
		    End If
		    
		    mInitialized = False
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Instance() As FMODSystem
		  If mInstance = Nil Then
		    mInstance = New FMODSystem
		  End If
		  
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInitialized() As Boolean
		  Return mInitialized
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LogError(message as String)
		  If mLogger <> Nil Then
		    mLogger.LogError(message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultToString(result as Integer) As String
		  Select Case result
		    
		  Case FMOD_OK
		    Return "No errors"
		  Case FMOD_ERR_BADCOMMAND
		    Return "Bad command"
		  Case FMOD_ERR_CHANNEL_ALLOC
		    Return "Failed to allocate a channel"
		  Case FMOD_ERR_CHANNEL_STOLEN
		    Return "The channel had been stolen by another sound"
		  Case FMOD_ERR_DMA
		    Return "DMA error"
		  Case FMOD_ERR_DSP_CONNECTION
		    Return "DSP connection error"
		  Case FMOD_ERR_DSP_FORMAT
		    Return "Unsupported format"
		  Case FMOD_ERR_DSP_INUSE
		    Return "DSP is already in use"
		  Case FMOD_ERR_DSP_NOTFOUND
		    Return "DSP not found"
		  Case FMOD_ERR_DSP_RUNNING
		    Return "DSP is already running"
		  Case FMOD_ERR_DSP_TOOMANYCONNECTIONS
		    Return "Too many DSP connections"
		  Case FMOD_ERR_FILE_BAD
		    Return "Bad or corrupt file"
		  Case FMOD_ERR_FILE_COULDNOTSEEK
		    Return "Failed to seek in file"
		  Case FMOD_ERR_FILE_DISKEJECTED
		    Return "Media was ejected while reading"
		  Case FMOD_ERR_FILE_EOF
		    Return "End of file"
		  Case FMOD_ERR_FILE_ENDOFDATA
		    Return "End of data"
		  Case FMOD_ERR_FILE_NOTFOUND
		    Return "File not found"
		  Case 12
		    Return "File format error"
		  Case 13
		    Return "File bad or corrupt"
		  Case 14
		    Return "Insufficient memory"
		  Case 15
		    Return "Invalid file handle"
		  Case 16
		    Return "Invalid parameter"
		  Case 17
		    Return "Invalid speaker"
		  Case 18
		    Return "Plug-in resource unavailable"
		  Case 19
		    Return "Plug-in missing"
		  Case 20
		    Return "Plug-in output in use or unsupported"
		  Case 21
		    Return "Plug-in type not found"
		  Case 22
		    Return "Insufficient memory or resources"
		  Case 23
		    Return "Unimplemented feature"
		  Case 24
		    Return "Uninitialized system"
		  Case 25
		    Return "Unsupported feature"
		  Case 26
		    Return "Version mismatch"
		  Case 27
		    Return "Event not found"
		  Case 28
		    Return "Event already loaded"
		  Case 29
		    Return "Event failed"
		  Case 30
		    Return "Event already playing"
		  Case 31
		    Return "Event not playing"
		  Case 32
		    Return "Event parameter not found"
		  Case 33
		    Return "Event category not found"
		  Case 34
		    Return "Invalid event"
		  Case 35
		    Return "Core or driver level error"
		  Case 68
		    Return "Record busy - sound is still playing or recording"
		  Case 69
		    Return "Cannot lock a non-blocking thread"
		  Case 70
		    Return "Thread not found"
		  Case 71
		    Return "Command interrupted by a higher priority command"
		  Case 72
		    Return "Resource still in use by another thread"
		  Case 73
		    Return "Invalid source channel"
		  Case 74
		    Return "Destination channel is a source channel"
		  Case 75
		    Return "DSP channel is a source channel"
		  Case -1
		    Return "MBS declare error"
		  Case Else
		    Return "Unknown error: " + Str(result)
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetNumChannels(numChannels as Integer) As Boolean
		  If Not mInitialized Or mSystemPtr = Nil Then
		    Return False
		  End If
		  
		  Dim result As Integer
		  result = FMOD_System_SetNumChannels(mSystemPtr, numChannels)
		  
		  If result <> FMOD_OK Then
		    LogError("Failed to set number of channels: " + ResultToString(result))
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetSoftwareFormat(sampleRate As Integer, speakerMode As Integer) As Boolean
		  If Not mInitialized Or mSystemPtr = Nil Then
		    Return False
		  End If
		  
		  Dim result As Integer
		  result = FMOD_System_SetSoftwareFormat(mSystemPtr, sampleRate, speakerMode, 0)
		  
		  If result <> FMOD_OK Then
		    LogError("Failed to set software format: " + ResultToString(result))
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Shutdown()
		  If Not mInitialized Or mSystemPtr = Nil Then
		    Return
		  End If
		  
		  Try
		    // Release the system
		    Dim result As Integer
		    result = FMOD_System_Release(mSystemPtr)
		    
		    If result <> FMOD_OK Then
		      LogError("Warning: Failed to release FMOD system: " + ResultToString(result))
		    End If
		    
		  Catch ex As RuntimeException
		    LogError("Error shutting down FMOD: " + ex.Message)
		  Finally
		    // Ensure we mark as uninitialized even if there was an error
		    mSystemPtr = Nil
		    mInitialized = False
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Update() As Boolean
		  If Not mInitialized Or mSystemPtr = Nil Then
		    Return False
		  End If
		  
		  var result As Integer = FMODLibraryManager.Instance.UpdateSystem(mSystemPtr)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    LogError("Failed to update FMOD system: " + ResultToString(result))
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function VersionToString(version as UInt32) As String
		  Dim major As UInt32 = (version >> 16) And &hFF
		  Dim minor As UInt32 = (version >> 8) And &hFF
		  Dim patch As UInt32 = version And &hFF
		  
		  Return major.ToString + "." + minor.ToString + "." + patch.ToString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mInitialized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInstance As FMODSystem
	#tag EndProperty

	#tag Property, Flags = &h0
		mLogger As FMODLogger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSystemPtr As Ptr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSystemPtr
			End Get
		#tag EndGetter
		SystemPtr As Ptr
	#tag EndComputedProperty


	#tag Constant, Name = FMOD_VERSION, Type = Double, Dynamic = False, Default = \"&h00020206", Scope = Public
	#tag EndConstant


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

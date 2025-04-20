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

	#tag Method, Flags = &h0
		Function Initialize() As Boolean
		  // Return true if already initialized
		  If mInitialized Then
		    Return True
		  End If
		  
		  var result as integer
		  
		  Try
		    // Get the library manager from the module
		    // No need to create an instance since FMODLibraryManager is now a module
		    
		    // Create the FMOD system using the library manager
		    result  = FMODLibraryManager.CreateSystem(mSystemPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Then
		      LogError("Failed to create FMOD system: " + ResultToString(result))
		      Return False
		    End If
		    
		    // Initialize the system
		    // Default settings: 32 channels, FMOD_INIT.NORMAL flags
		    result = FMODLibraryManager.InitSystem(mSystemPtr, 32, FMODStructures.FMOD_INIT_NORMAL)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Then
		      LogError("Failed to initialize FMOD system: " + ResultToString(result))
		      // Clean up on error
		      result = FMODLibraryManager.ReleaseSystem(mSystemPtr)
		      mSystemPtr = Nil
		      Return False
		    End If
		    
		    mInitialized = True
		    Return True
		    
		  Catch ex As RuntimeException
		    LogError("Error initializing FMOD: " + ex.Message)
		    
		    // Clean up on error
		    If mSystemPtr <> Nil Then
		      result = FMODLibraryManager.ReleaseSystem(mSystemPtr)
		      mSystemPtr = Nil
		    End If
		    
		    mInitialized = False
		    Return False
		  End Try
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
		Function SetNumChannels(numChannels as Integer) As Boolean
		  If Not mInitialized Or mSystemPtr = Nil Then
		    Return False
		  End If
		  
		  Dim result As Integer
		  result = SetNumChannels(mSystemPtr, numChannels)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
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
		  
		  // Use FMODLibraryManager instead of direct FMOD_System_SetSoftwareFormat call
		  var result As Integer = FMODLibraryManager.SetSoftwareFormat(mSystemPtr, sampleRate, speakerMode, 0)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
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
		    result = ReleaseSystem(mSystemPtr)
		    
		    If result <> FMOD_RESULT_OK Then
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
		  
		  var result As Integer = UpdateSystem(mSystemPtr)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    LogError("Failed to update FMOD system: " + ResultToString(result))
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function VersionToString(version as UInt32) As String
		  // Extract version components using different approach
		  var major As UInt32 = Bitwise.ShiftRight(version, 16) And &hFF
		  var minor As UInt32 = Bitwise.ShiftRight(version, 8) And &hFF
		  var patch As UInt32 = version And &hFF
		  
		  // Construct version string
		  var s As String
		  s = major.ToString + "." + minor.ToString + "." + patch.ToString
		  Return s
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mInstance Is Nil Then
			    mInstance = New FMODSystem
			  End If
			  
			  Return mInstance
			End Get
		#tag EndGetter
		Instance As FMODSystem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mInitialized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As FMODSystem
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

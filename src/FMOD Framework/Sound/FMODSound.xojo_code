#tag Class
Protected Class FMODSound
	#tag Method, Flags = &h0
		Sub Constructor(filePath as String = "")
		  If FMODSystem.Instance = Nil Or Not FMODSystem.Instance.IsInitialized Then
		    Raise New FMODException("FMOD System not initialized")
		  End If
		  
		  // Get the library manager instance
		  var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		  
		  If filePath <> "" Then
		    // Create a sound creation info structure (if needed)
		    var exInfo As New FMODStructures.FMOD_CREATESOUNDEXINFO
		    
		    // Create the sound from file
		    var result As Integer = libManager.CreateSound(FMODSystem.Instance.SystemPtr, filePath, _
		    FMODStructures.FMOD_MODE_DEFAULT, Nil, SoundPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Then
		      Raise New FMODException("Failed to create sound: " + _
		      FMODSystem.ResultToString(result))
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateFromFile(filePath as String) As FMODSound
		  Try
		    Return New FMODSound(filePath)
		  Catch ex As RuntimeException
		    System.DebugLog("Failed to create sound from file: " + ex.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If SoundPtr <> Nil Then
		    var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		    libManager.ReleaseSound(SoundPtr)
		    SoundPtr = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLengthMS() As Integer
		  // returns length in milliseconds
		  
		  If SoundPtr = Nil Then Return 0
		  
		  var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		  var length As UInt32 = 0
		  
		  var result As Integer = libManager.GetSoundLength(SoundPtr, length, FMODStructures.FMOD_TIMEUNIT_MS)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to get sound length: " + _
		    FMODSystem.ResultToString(result))
		    Return 0
		  End If
		  
		  Return length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSoundPtr() As Ptr
		  return SoundPtr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Play(paused as Boolean = False) As FMODChannel
		  If SoundPtr = Nil Then Return Nil
		  
		  Try
		    var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		    var channelPtr As Ptr
		    
		    // Play the sound
		    var result As Integer = libManager.PlaySound(FMODSystem.Instance.SystemPtr, SoundPtr, _
		    Nil, paused, channelPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Then
		      System.DebugLog("Failed to play sound: " + _
		      FMODSystem.ResultToString(result))
		      Return Nil
		    End If
		    
		    // Create a channel wrapper
		    Return New FMODChannel(channelPtr)
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error playing sound: " + ex.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLoopMode(isLooped as Boolean)
		  If SoundPtr = Nil Then Return
		  
		  var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		  var mode As Integer
		  
		  If loop Then
		    mode = FMODStructures.FMOD_MODE_LOOP_NORMAL
		  Else
		    mode = FMODStructures.FMOD_MODE_LOOP_OFF
		  End If
		  
		  var result As Integer = libManager.SetSoundMode(SoundPtr, mode)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to set loop mode: " + _
		    FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLoopPoints(loopStart As Integer, loopEnd As Integer)
		  If SoundPtr = Nil Then Return
		  
		  var libManager As FMODLibraryManager = FMODLibraryManager.Instance
		  
		  var result As Integer = libManager.SetSoundLoopPoints(SoundPtr, loopStart, FMODStructures.FMOD_TIMEUNIT_PCM, _
		  loopEnd, FMODStructures.FMOD_TIMEUNIT_PCM)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to set loop points: " + _
		    FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected SoundPtr As Ptr
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

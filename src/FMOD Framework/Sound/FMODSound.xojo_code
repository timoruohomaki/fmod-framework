#tag Class
Protected Class FMODSound
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  If FMODSystem.Instance = Nil Or Not FMODSystem.Instance.IsInitialized Then
		    Raise New FMODException("FMOD System not initialized")
		  End If
		  
		  If filePath <> "" Then
		    // Create the sound from file
		    Dim result As Integer
		    result = FMOD_System_CreateSound(FMODSystem.Instance.SystemPtr, filePath, _
		    FMOD_MODE.DEFAULT, Nil, SoundPtr)
		    
		    If result <> FMOD_OK Then
		      Raise New FMODException("Failed to create sound: " + _
		      FMODSystem.ResultToString(result))
		    End If
		  End If
		  End Sub
		  
		  // Destructor to release the sound resource
		  Sub Destructor()
		    If SoundPtr <> Nil Then
		      FMOD_Sound_Release(SoundPtr)
		      SoundPtr = Nil
		    End If
		  End Sub
		  
		  // Getter for the sound pointer
		  Function GetSoundPtr() As Ptr
		    Return SoundPtr
		  End Function
		  
		  // Method to set loop mode for the sound
		  Sub SetLoopMode(loop As Boolean)
		    If SoundPtr = Nil Then Return
		    
		    Dim mode As Integer
		    If loop Then
		      mode = FMOD_MODE.LOOP_NORMAL
		    Else
		      mode = FMOD_MODE.LOOP_OFF
		    End If
		    
		    Dim result As Integer = FMOD_Sound_SetMode(SoundPtr, mode)
		    
		    If result <> FMOD_OK Then
		      FMODSystem.Instance.LogError("Failed to set loop mode: " + _
		      FMODSystem.ResultToString(result))
		    End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateFromFile(filePath as String) As FMODSound
		  Try
		    Return New FMODSound(filePath)
		  Catch ex As RuntimeException
		    FMODSystem.Instance.LogError("Failed to create sound from file: " + ex.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetLengthMS() As Integer
		  // returns length in milliseconds
		  
		  If SoundPtr = Nil Then Return 0
		  
		  Dim length As UInt32
		  Dim result As Integer
		  
		  result = FMOD_Sound_GetLength(SoundPtr, length, FMOD_TIMEUNIT.MS)
		  
		  If result <> FMOD_OK Then
		    FMODSystem.Instance.LogError("Failed to get sound length: " + _
		    FMODSystem.ResultToString(result))
		    Return 0
		  End If
		  
		  Return length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Play()
		  If SoundPtr = Nil Then Return Nil
		  
		  Try
		    Dim channelPtr As Ptr
		    Dim result As Integer
		    
		    // Play the sound
		    result = FMOD_System_PlaySound(FMODSystem.Instance.SystemPtr, SoundPtr, _
		    Nil, paused, channelPtr)
		    
		    If result <> FMOD_OK Then
		      FMODSystem.Instance.LogError("Failed to play sound: " + _
		      FMODSystem.ResultToString(result))
		      Return Nil
		    End If
		    
		    // Create a channel wrapper
		    Return New FMODChannel(channelPtr)
		    
		  Catch ex As RuntimeException
		    FMODSystem.Instance.LogError("Error playing sound: " + ex.Message)
		    Return Nil
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetLoopPoints(loopStart As Integer, loopEnd As Integer)
		  If SoundPtr = Nil Then Return
		  
		  Dim result As Integer
		  result = FMOD_Sound_SetLoopPoints(SoundPtr, loopStart, FMOD_TIMEUNIT.PCM, _
		  loopEnd, FMOD_TIMEUNIT.PCM)
		  
		  If result <> FMOD_OK Then
		    FMODSystem.Instance.LogError("Failed to set loop points: " + _
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

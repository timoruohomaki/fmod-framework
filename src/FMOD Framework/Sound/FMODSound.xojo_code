#tag Class
Protected Class FMODSound
	#tag Method, Flags = &h0
		Sub Constructor(filePath as String = "")
		  // Get the FMODSystem instance through the LibraryManager
		  var systemInstance As FMODSystem = FMODLibraryManager.GetSystemInstance()
		  
		  If systemInstance = Nil Or Not systemInstance.IsInitialized Then
		    // Explicitly call the string constructor for FMODException
		    var ex As New FMODException("FMOD System not initialized")
		    Raise ex
		  End If
		  
		  If filePath <> "" Then
		    // Create the sound from file
		    var result As Integer = FMODLibraryManager.CreateSound(systemInstance.SystemPtr, filePath, _
		    FMODStructures.FMOD_MODE_DEFAULT, Nil, SoundPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Then
		      // Explicitly use the integer constructor
		      var ex As New FMODException(result)
		      Raise ex
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
		    var result as Integer = FMODLibraryManager.ReleaseSound(SoundPtr)
		    
		    if result <> FMOD_RESULT_OK then
		      // TODO: should handle the result?
		    end
		    
		    SoundPtr = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLengthMS() As Integer
		  // returns length in milliseconds
		  
		  If SoundPtr = Nil Then Return 0
		  
		  var length As UInt32 = 0
		  
		  var result As Integer = GetSoundLength(SoundPtr, length, FMODStructures.FMOD_TIMEUNIT_MS)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to get sound length: " + _
		    ResultToString(result))
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
		    
		    var channelPtr As Ptr
		    
		    // Play the sound
		    var result As Integer = PlaySound(GetSystemInstance.SystemPtr, SoundPtr, _
		    Nil, paused, channelPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Then
		      System.DebugLog("Failed to play sound: " + _
		      ResultToString(result))
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
		  
		  var mode As Integer
		  
		  If isLooped Then
		    mode = FMODStructures.FMOD_MODE_LOOP_NORMAL
		  Else
		    mode = FMODStructures.FMOD_MODE_LOOP_OFF
		  End If
		  
		  var result As Integer = SetSoundMode(SoundPtr, mode)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to set loop mode: " + _
		    ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLoopPoints(loopStart As Integer, loopEnd As Integer)
		  If SoundPtr = Nil Then Return
		  
		  var result As Integer = SetSoundLoopPoints(SoundPtr, loopStart, FMODStructures.FMOD_TIMEUNIT_PCM, _
		  loopEnd, FMODStructures.FMOD_TIMEUNIT_PCM)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    System.DebugLog("Failed to set loop points: " + _
		    ResultToString(result))
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

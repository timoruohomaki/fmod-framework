#tag Class
Protected Class FMODChannel
	#tag Method, Flags = &h0
		Sub Constructor(cPtr as Ptr)
		  ChannelPtr = cPtr
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetChannelPtr() As Ptr
		  Return ChannelPtr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPlaying() As Boolean
		  If Not IsValid Then Return False
		  
		  var isPlaying As Boolean
		  var result As Integer
		  
		  result = FMOD_Channel_IsPlaying(ChannelPtr, isPlaying)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    // Consider channel not playing if there's an error
		    Return False
		  End If
		  
		  Return isPlaying
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  return ChannelPtr <> nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFrequency(freq as Double)
		  If Not IsValid Then Return
		  
		  var f as Double
		  
		  // Ensure frequency is positive
		  f = Max(0.1, freq)
		  
		  Dim result As Integer
		  result = FMOD_Channel_SetFrequency(ChannelPtr, f)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    FMODSystem.Instance.LogError("Failed to set channel frequency: " + _
		    FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetPan(pan as Double)
		  If Not IsValid Then Return
		  
		  // Clamp pan between -1 (left) and 1 (right)
		  pan = Max(-1.0, Min(1.0, pan))
		  
		  var result As Integer
		  result = FMOD_Channel_SetPan(ChannelPtr, pan)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    FMODSystem.Instance.LogError("Failed to set channel pan: " + _
		    FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetPaused(paused as Boolean)
		  If Not IsValid Then Return
		  
		  var result As Integer
		  
		  result = FMOD_Channel_SetPaused(ChannelPtr, paused)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    FMODSystem.Instance.LogError("Failed to set channel pause state: " + _
		    FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetVolume(volume as Double)
		  If Not IsValid Then Return
		  
		  // Clamp volume between 0 and 1
		  volume = Max(0.0, Min(1.0, volume))
		  
		  var result As Integer
		  result = FMOD_Channel_SetVolume(ChannelPtr, volume)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK  Then
		    FMODSystem.Instance.LogError("Failed to set channel volume: " + _
		    FMODSystem.ResultToString(result))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  If Not IsValid Then Return
		  
		  var result As Integer
		  result = FMOD_Channel_Stop(ChannelPtr)
		  
		  If result <> FMODStructures.FMOD_RESULT_OK Then
		    FMODSystem.Instance.LogError("Failed to stop channel: " + _
		    FMODSystem.ResultToString(result))
		  End If
		  
		  // Clear the channel pointer
		  ChannelPtr = Nil
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ChannelPtr As Ptr
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
		#tag ViewProperty
			Name="ChannelPtr"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

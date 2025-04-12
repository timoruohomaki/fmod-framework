#tag Class
Protected Class FMODToneGenerator
	#tag Method, Flags = &h0
		Sub Cleanup()
		  If Not mInitialized Then Return
		  
		  Try
		    ' Stop any existing channel
		    If mChannel.Ptr <> Nil Then
		      Dim result As Integer = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
		      FMODApi.ERRCHECK(result)
		      mChannel.Ptr = Nil
		    End If
		    
		    ' Release DSP
		    If mDSP.Ptr <> Nil Then
		      Dim result As Integer = FMODApi.FMOD_DSP_Release(mDSP.Ptr)
		      FMODApi.ERRCHECK(result)
		      mDSP.Ptr = Nil
		    End If
		    
		    ' Close and release system
		    If mSystem.Ptr <> Nil Then
		      Dim result As Integer = FMODApi.FMOD_System_Close(mSystem.Ptr)
		      FMODApi.ERRCHECK(result)
		      
		      result = FMODApi.FMOD_System_Release(mSystem.Ptr)
		      FMODApi.ERRCHECK(result)
		      mSystem.Ptr = Nil
		    End If
		    
		    mInitialized = False
		  Catch ex As RuntimeException
		    System.DebugLog("Error cleaning up FMOD: " + ex.Message)
		    Raise ex
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize()
		  if mInitialized then return
		  
		  // Create FMOD System
		  
		  Try
		    
		    var result as Integer
		    
		    result = fmodAPI.FMOD_System_Init(mSystem.Ptr, 32, fmodAPI.FMOD_INIT_NORMAL, Nil)
		    
		    // Initialize FMOD
		    result = FMODApi.FMOD_System_Init(mSystem.Ptr, 32, FMODApi.FMOD_INIT_NORMAL, Nil)
		    FMODApi.ERRCHECK(result)
		    
		    // Create oscillator DSP
		    result = FMODApi.FMOD_System_CreateDSPByType(mSystem.Ptr, FMODApi.FMOD_DSP_TYPE_OSCILLATOR, mDSP)
		    FMODApi.ERRCHECK(result)
		    
		    // Set default oscillator frequency to 440Hz (A note)
		    result = FMODApi.FMOD_DSP_SetParameterFloat(mDSP.Ptr, FMODApi.FMOD_DSP_OSCILLATOR_RATE, 440.0)
		    FMODApi.ERRCHECK(result)
		    
		    mInitialized = True
		    
		  End Try
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayTone(oscillatorType As Integer, volume As Single)
		  If Not mInitialized Then Initialize()
		  
		  Try
		    Dim result As Integer
		    
		    ' Stop any existing channel
		    If mChannel.Ptr <> Nil Then
		      result = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
		      FMODApi.ERRCHECK(result)
		    End If
		    
		    ' Play the DSP
		    result = FMODApi.FMOD_System_PlayDSP(mSystem.Ptr, mDSP.Ptr, Nil, True, mChannel)
		    FMODApi.ERRCHECK(result)
		    
		    ' Set the volume
		    result = FMODApi.FMOD_Channel_SetVolume(mChannel.Ptr, volume)
		    FMODApi.ERRCHECK(result)
		    
		    ' Set the oscillator type
		    result = FMODApi.FMOD_DSP_SetParameterInt(mDSP.Ptr, FMODApi.FMOD_DSP_OSCILLATOR_TYPE, oscillatorType)
		    FMODApi.ERRCHECK(result)
		    
		    ' Start playing
		    result = FMODApi.FMOD_Channel_SetPaused(mChannel.Ptr, False)
		    FMODApi.ERRCHECK(result)
		    
		    ' Update the system
		    result = FMODApi.FMOD_System_Update(mSystem.Ptr)
		    FMODApi.ERRCHECK(result)
		  Catch ex As RuntimeException
		    System.DebugLog("Error playing tone: " + ex.Message)
		    Raise ex
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFrequency(frequency as Single)
		  If Not mInitialized Or mChannel.Ptr = Nil Then Return
		  
		  Try
		    Dim result As Integer = FMODApi.FMOD_Channel_SetFrequency(mChannel.Ptr, frequency)
		    FMODApi.ERRCHECK(result)
		    
		    ' Update the system
		    result = FMODApi.FMOD_System_Update(mSystem.Ptr)
		    FMODApi.ERRCHECK(result)
		  Catch ex As RuntimeException
		    System.DebugLog("Error setting frequency: " + ex.Message)
		    Raise ex
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopTone()
		  If Not mInitialized Or mChannel.Ptr = Nil Then Return
		  
		  Try
		    
		    var result As Integer = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
		    FMODApi.ERRCHECK(result)
		    mChannel.Ptr = Nil
		    
		    ' Update the system
		    result = FMODApi.FMOD_System_Update(mSystem.Ptr)
		    FMODApi.ERRCHECK(result)
		  Catch ex As RuntimeException
		    System.DebugLog("Error stopping tone: " + ex.Message)
		    Raise ex
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  If Not mInitialized Then Return
		  
		  Try
		    var result As Integer = FMODApi.FMOD_System_Update(mSystem.Ptr)
		    FMODApi.ERRCHECK(result)
		  Catch ex As RuntimeException
		    System.DebugLog("Error updating system: " + ex.Message)
		    Raise ex
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		mChannel As fmodAPI.FMODChannel
	#tag EndProperty

	#tag Property, Flags = &h0
		mDSP As fmodAPI.FMODDSP
	#tag EndProperty

	#tag Property, Flags = &h0
		mInitialized As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		mSystem As fmodAPI.FMODSystem
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
			Name="mSystem"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

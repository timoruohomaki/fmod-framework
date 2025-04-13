#tag Class
Protected Class FMODToneGenerator
	#tag Method, Flags = &h0
		Sub Cleanup()
		  If Not mInitialized Then Return
		  
		  Try
		    // Stop any existing channel
		    If mChannel.Ptr <> Nil Then
		      Dim result As Integer = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
		      FMODApi.ERRCHECK(result)
		      mChannel.Ptr = Nil
		    End If
		    
		    // Release DSP
		    If mDSP.Ptr <> Nil Then
		      Dim result As Integer = FMODApi.FMOD_DSP_Release(mDSP.Ptr)
		      FMODApi.ERRCHECK(result)
		      mDSP.Ptr = Nil
		    End If
		    
		    // Close and release system
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
		Function CreateSawWave(sampleRate As Integer, length As Integer) As FMODApi.FMODSound
		  // Create a sound object for a sine wave
		  Dim result As Integer
		  Dim sound As FMODApi.FMODSound
		  
		  // Create the sound
		  result = FMODApi.FMOD_System_CreateStream(mSystem.Ptr, "saw.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, sound)
		  If result <> 0 Then
		    System.Log(System.LogLevelError, "Error creating sine wave sound: " + FMODApi.GetErrorString(result))
		    Return sound
		  End If
		  
		  Return sound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateSinewave(sampleRate As Integer, length As Integer) As FMODApi.FMODSound
		  // Create a sound object for a sine wave
		  Dim result As Integer
		  Dim sound As FMODApi.FMODSound
		  
		  // Create the sound
		  result = FMODApi.FMOD_System_CreateStream(mSystem.Ptr, "sine.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, sound)
		  If result <> 0 Then
		    System.Log(System.LogLevelError, "Error creating sine wave sound: " + FMODApi.GetErrorString(result))
		    Return sound
		  End If
		  
		  Return sound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateSquareWave(sampleRate As Integer, length As Integer) As FMODApi.FMODSound
		  // Create a sound object for a sine wave
		  Dim result As Integer
		  Dim sound As FMODApi.FMODSound
		  
		  // Create the sound
		  result = FMODApi.FMOD_System_CreateStream(mSystem.Ptr, "square.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, sound)
		  If result <> 0 Then
		    System.Log(System.LogLevelError, "Error creating sine wave sound: " + FMODApi.GetErrorString(result))
		    Return sound
		  End If
		  
		  Return sound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTriangleWave(sampleRate As Integer, length As Integer) As FMODApi.FMODSound
		  // Create a sound object for a sine wave
		  Dim result As Integer
		  Dim sound As FMODApi.FMODSound
		  
		  // Create the sound
		  result = FMODApi.FMOD_System_CreateStream(mSystem.Ptr, "triangle.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, sound)
		  If result <> 0 Then
		    System.Log(System.LogLevelError, "Error creating sine wave sound: " + FMODApi.GetErrorString(result))
		    Return sound
		  End If
		  
		  Return sound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateWaveforms()
		  // Create sine, square, saw and triangle waveforms in memory
		  // We'll use FMOD_System_CreateSound with FMOD_OPENUSER to create sounds from memory
		  // For simplicity, here we're creating sine waves pre-generated at 440Hz
		  // We'll then use channel frequency to adjust pitch
		  
		  // For now, just create a basic sine wave at 44100Hz sample rate
		  Dim sampleRate As Integer = 44100
		  Dim length As Integer = sampleRate // 1 second of audio
		  
		  // Create sine wave
		  mSineWaveSound = CreateSineWave(sampleRate, length)
		  // Create square wave
		  mSquareWaveSound = CreateSquareWave(sampleRate, length)
		  // Create saw wave
		  mSawWaveSound = CreateSawWave(sampleRate, length)
		  // Create triangle wave
		  mTriangleWaveSound = CreateTriangleWave(sampleRate, length)
		  
		  System.Log(System.LogLevelDebug, "Waveforms created")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize()
		  If mInitialized Then Return
		  
		  Dim startTime As UInt64 = System.Microseconds
		  
		  // Create FMOD system
		  Try
		    // Initialize the FMOD declares first
		    If Not FMODApi.InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "Failed to initialize FMOD declares")
		      Raise New RuntimeException("Failed to initialize FMOD declares")
		    End If
		    
		    Dim result As Integer
		    
		    System.Log(System.LogLevelDebug, "About to create FMOD system")
		    result = FMODApi.FMOD_System_Create(mSystem, &h00020307) // For FMOD 2.03.07
		    If result <> 0 Then
		      Dim errorMsg As String = "Error creating FMOD system: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    // Initialize FMOD with fewer channels
		    System.Log(System.LogLevelDebug, "About to initialize FMOD system")
		    result = FMODApi.FMOD_System_Init(mSystem.Ptr, 8, FMODApi.FMOD_INIT_NORMAL, Nil)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error initializing FMOD system: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    // Create sound for each waveform type
		    // We'll use pregenerated waveform sounds instead of oscillator DSP
		    CreateWaveforms()
		    
		    mInitialized = True
		    
		    Dim endTime As UInt64 = System.Microseconds
		    Dim duration As UInt64 = endTime - startTime
		    System.Log(System.LogLevelInformation, "FMOD initialization took " + Str(duration) + " microseconds (" + Format(duration / 1000000, "0.000") + " seconds)")
		    
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "Error initializing FMOD: " + ex.Message)
		    Raise ex
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayTone(oscillatorType As Integer, volume As Single)
		  System.Log(System.LogLevelDebug, "PlayTone called with type=" + Str(oscillatorType) + ", volume=" + Str(volume))
		  
		  If Not mInitialized Then
		    System.Log(System.LogLevelDebug, "FMOD not initialized, attempting to initialize")
		    Initialize()
		  End If
		  
		  Try
		    Dim result As Integer
		    
		    // Stop any existing channel
		    If mChannel.Ptr <> Nil Then
		      System.Log(System.LogLevelDebug, "Stopping existing channel")
		      result = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
		      If result <> 0 Then
		        System.Log(System.LogLevelWarning, "Warning: Could not stop channel: " + FMODApi.GetErrorString(result))
		      End If
		      
		      mChannel.Ptr = Nil
		      result = FMODApi.FMOD_System_Update(mSystem.Ptr)
		      SleepMBS(0.05)
		    End If
		    
		    // Select the appropriate waveform sound
		    Dim soundToPlay As FMODApi.FMODSound
		    Select Case oscillatorType
		    Case FMODApi.OSCILLATOR_SINE
		      soundToPlay = mSineWaveSound
		      System.Log(System.LogLevelDebug, "Using sine wave")
		    Case FMODApi.OSCILLATOR_SQUARE
		      soundToPlay = mSquareWaveSound
		      System.Log(System.LogLevelDebug, "Using square wave")
		    Case FMODApi.OSCILLATOR_SAWUP
		      soundToPlay = mSawWaveSound
		      System.Log(System.LogLevelDebug, "Using saw wave")
		    Case FMODApi.OSCILLATOR_TRIANGLE
		      soundToPlay = mTriangleWaveSound
		      System.Log(System.LogLevelDebug, "Using triangle wave")
		    Else
		      soundToPlay = mSineWaveSound
		      System.Log(System.LogLevelDebug, "Using default sine wave")
		    End Select
		    
		    // Play the sound
		    System.Log(System.LogLevelDebug, "About to play sound")
		    result = FMODApi.FMOD_System_PlaySound(mSystem.Ptr, soundToPlay.Ptr, Nil, True, mChannel)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error playing sound: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    // Set the volume
		    System.Log(System.LogLevelDebug, "Setting channel volume to " + Str(volume))
		    result = FMODApi.FMOD_Channel_SetVolume(mChannel.Ptr, volume)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error setting volume: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    // Set frequency to 440Hz
		    System.Log(System.LogLevelDebug, "Setting channel frequency")
		    result = FMODApi.FMOD_Channel_SetFrequency(mChannel.Ptr, 440.0)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error setting frequency: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    // Start playing by unpausing
		    System.Log(System.LogLevelDebug, "Setting channel paused state to False")
		    result = FMODApi.FMOD_Channel_SetPaused(mChannel.Ptr, False)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error setting paused state: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    // Update the system
		    System.Log(System.LogLevelDebug, "Updating FMOD system")
		    result = FMODApi.FMOD_System_Update(mSystem.Ptr)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error updating system: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      Raise New RuntimeException(errorMsg)
		    End If
		    
		    System.Log(System.LogLevelInformation, "Tone started successfully")
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "Error playing tone: " + ex.Message)
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
		    
		    // Update the system
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
		    
		    // Update the system
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

	#tag Property, Flags = &h21
		Private mSawOscillator As FMODApi.FMODDSP
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSawWaveSound As FMODApi.FMODSound
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSineOscillator As FMODApi.FMODDSP
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSineWaveSound As FMODApi.FMODSound
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSquareOscillator As FMODApi.FMODDSP
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSquareWaveSound As FMODApi.FMODSound
	#tag EndProperty

	#tag Property, Flags = &h0
		mSystem As fmodAPI.FMODSystem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTriangleOscillator As FMODApi.FMODDSP
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTriangleWaveSound As FMODApi.FMODSound
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
			Name="mInitialized"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

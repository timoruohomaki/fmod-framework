#tag Class
Protected Class FMODToneGeneratorSound
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
		    
		    // Load sound files for each waveform
		    System.Log(System.LogLevelDebug, "Loading waveform sound files")
		    
		    // Load sine wave
		    result = FMODApi.FMOD_System_CreateSound(mSystem.Ptr, "sine.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, mSineWaveSound)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error loading sine wave: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		      // Just log the error but continue - we'll handle missing files during playback
		    End If
		    
		    // Load square wave
		    result = FMODApi.FMOD_System_CreateSound(mSystem.Ptr, "square.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, mSquareWaveSound)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error loading square wave: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		    End If
		    
		    // Load saw wave
		    result = FMODApi.FMOD_System_CreateSound(mSystem.Ptr, "saw.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, mSawWaveSound)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error loading saw wave: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		    End If
		    
		    // Load triangle wave
		    result = FMODApi.FMOD_System_CreateSound(mSystem.Ptr, "triangle.wav", FMODApi.FMOD_LOOP_NORMAL, Nil, mTriangleWaveSound)
		    If result <> 0 Then
		      Dim errorMsg As String = "Error loading triangle wave: " + FMODApi.GetErrorString(result)
		      System.Log(System.LogLevelError, errorMsg)
		    End If
		    
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
		Sub PlayTone()
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
		    
		    // Play the sound - check if the sound was loaded
		    If soundToPlay.Ptr = Nil Then
		      // Fall back to sine wave if available
		      If mSineWaveSound.Ptr <> Nil Then
		        soundToPlay = mSineWaveSound
		        System.Log(System.LogLevelDebug, "Falling back to sine wave")
		      Else
		        Dim errorMsg As String = "No sound available to play"
		        System.Log(System.LogLevelError, errorMsg)
		        Raise New RuntimeException(errorMsg)
		      End If
		    End If
		    
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


End Class
#tag EndClass

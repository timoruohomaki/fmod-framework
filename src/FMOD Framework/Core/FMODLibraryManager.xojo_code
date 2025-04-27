#tag Module
Protected Module FMODLibraryManager
	#tag Method, Flags = &h0
		Function ChannelGroup_GetDSP(channelGroup As Ptr, index As Integer, ByRef dsp As Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append channelGroup
		  params.Append index
		  params.Append dsp
		  
		  var result As Variant = mChannelGroup_GetDSP.Invoke(params)
		  
		  // Extract the output parameter
		  dsp = params(2)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateDSPByType(systemPtr As Ptr, dspType As Integer, ByRef dsp As Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append dspType
		  params.Append dsp
		  
		  var result As Variant = mCreateDSPByType.Invoke(params)
		  
		  // Extract the output DSP pointer
		  dsp = params(2)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateSound(systemPtr As Ptr, filePath As String, mode As Integer, exInfo As Ptr, ByRef sound As Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mCreateSound Is Nil Then
		    var createSoundPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_CreateSound")
		    If createSoundPtr <> Nil Then
		      mCreateSound = New DeclareFunctionMBS("(psip)i", createSoundPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append filePath
		  params.Append mode
		  params.Append exInfo
		  params.Append sound
		  
		  var result As Variant = mCreateSound.Invoke(params)
		  
		  // Extract the output sound pointer
		  sound = params(4)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateSystem(ByRef systemPtr As Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mCreateSystem Is Nil Then
		    var createSystemPtr As Ptr = GetLibrary().Symbol("FMOD_System_Create")
		    If createSystemPtr <> Nil Then
		      mCreateSystem = New DeclareFunctionMBS("(p)i", createSystemPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append systemPtr
		  
		  var result As Variant = mCreateSystem.Invoke(params)
		  
		  // Extract the system pointer from the parameters
		  systemPtr = params(0)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DSP_GetMeteringInfo(dsp As Ptr, ByRef outputInfo As FMODStructures.FMOD_DSP_METERING_INFO) As Integer
		  If Not IsLibraryLoaded() Or mDSPGetMeteringInfo Is Nil Then Return -1
		  
		  // For this function, we need to handle the struct specially
		  // Create a memory block to hold the struct
		  var outputInfoMB As New MemoryBlock(FMODStructures.FMOD_DSP_METERING_INFO.Size)
		  
		  var params() As Variant
		  params.Append dsp
		  params.Append Nil  // No input info needed
		  params.Append outputInfoMB
		  
		  var result As Variant = mDSPGetMeteringInfo.Invoke(params)
		  
		  // Convert the memory block back to the structure
		  outputInfo = FMODStructures.MemoryBlockToMeteringInfo(params(2))
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DSP_SetMeteringEnabled(dsp As Ptr, inputEnabled As Boolean, outputEnabled As Boolean) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append dsp
		  params.Append inputEnabled
		  params.Append outputEnabled
		  
		  var result As Variant = mDSPSetMeteringEnabled.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetChannelPosition(channel As Ptr, ByRef position As UInt32, postype As Integer) As integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mGetChannelPosition Is Nil Then
		    var getChannelPositionPtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_GetPosition")
		    If getChannelPositionPtr <> Nil Then
		      mGetChannelPosition = New DeclareFunctionMBS("(p@i)i", getChannelPositionPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  params.Append position
		  params.Append postype
		  
		  var result As Variant = mGetChannelPosition.Invoke(params)
		  
		  // Extract the output position
		  position = params(1)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetChannelsPlaying(systemPtr As Ptr, ByRef channelsPlaying As Integer, ByRef realChannels As Integer) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append channelsPlaying
		  params.Append realChannels
		  
		  var result As Variant = mGetChannelsPlaying.Invoke(params)
		  
		  // Extract the output parameters
		  channelsPlaying = params(1)
		  realChannels = params(2)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCPUUsage(systemPtr As Ptr, ByRef usage As FMODStructures.FMOD_CPU_USAGE) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Create a memory block for the CPU usage structure
		  var usageMB As New MemoryBlock(FMODStructures.FMOD_CPU_USAGE.Size)
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append usageMB
		  
		  var result As Variant = mGetCPUUsage.Invoke(params)
		  
		  // Convert the memory block back to the structure
		  usage = FMODStructures.MemoryBlockToCPUUsage(params(1))
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDSPBufferSize(systemPtr As Ptr, ByRef bufferLength As Integer, ByRef bufferCount As Integer) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append bufferLength
		  params.Append bufferCount
		  
		  var result As Variant = mGetDSPBufferSize.Invoke(params)
		  
		  // Extract the output parameters
		  bufferLength = params(1)
		  bufferCount = params(2)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLibrary() As DeclareLibraryMBS
		  // Load the library if it hasn't been loaded yet
		  
		  If mFMODLibrary Is Nil Then
		    
		    var libraryPath As String
		    
		    #If TargetMacOS Then
		      libraryPath = "libfmod.dylib"
		      
		    #ElseIf TargetWindows Then
		      
		      #If Target32Bit Then
		        libraryPath = "fmod.dll"
		      #Else
		        libraryPath = "fmod64.dll"
		      #EndIf
		      
		    #ElseIf TargetLinux Then
		      
		      libraryPath = "libfmod.so"
		      
		    #EndIf
		    
		    mFMODLibrary = New DeclareLibraryMBS(libraryPath)
		    
		  End If
		  
		  Return mFMODLibrary
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMasterChannelGroup(systemPtr As Ptr, ByRef channelGroup As Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append channelGroup
		  
		  var result As Variant = mGetMasterChannelGroup.Invoke(params)
		  
		  // Extract the output parameter
		  channelGroup = params(1)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMemoryInfo(systemPtr As Ptr, ByRef usage As FMODStructures.FMOD_MEMORY_USAGE) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Create a memory block for the memory usage structure
		  var usageMB As New MemoryBlock(FMODStructures.FMOD_MEMORY_USAGE.Size)
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append 0  // Memory bits (not used)
		  params.Append 0  // Event memory bits (not used)
		  params.Append usageMB
		  
		  var result As Variant = mGetMemoryInfo.Invoke(params)
		  
		  // Convert the memory block back to the structure
		  usage = FMODStructures.MemoryBlockToMemoryUsage(params(3))
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSoundLength(sound As Ptr, ByRef length As UInt32, timeUnit As Integer) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mGetSoundLength Is Nil Then
		    var getSoundLengthPtr As Ptr = mFMODLibrary.Symbol("FMOD_Sound_GetLength")
		    If getSoundLengthPtr <> Nil Then
		      mGetSoundLength = New DeclareFunctionMBS("(p@i)i", getSoundLengthPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append sound
		  params.Append length
		  params.Append timeUnit
		  
		  var result As Variant = mGetSoundLength.Invoke(params)
		  
		  // Extract the output length
		  length = params(1)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSystemInstance() As FMODSystem
		  If mSystemInstance Is Nil Then
		    // Try to initialize if not already done
		    If Not InitializeFMODSystem() Then
		      Return Nil
		    End If
		  End If
		  
		  Return mSystemInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InitializeFMODSystem() As Boolean
		  // Create and initialize the FMOD system if it hasn't been created yet
		  If mSystemInstance Is Nil Then
		    mSystemInstance = New FMODSystem
		    
		    // Call the Initialize method on the instance
		    If Not mSystemInstance.Initialize() Then
		      System.DebugLog("Failed to initialize FMOD System")
		      mSystemInstance = Nil
		      Return False
		    End If
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitializeFunctions()
		  
		  // System Creation - FMOD_System_Create
		  var createSystemPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_Create")
		  If createSystemPtr <> Nil Then
		    mCreateSystem = New DeclareFunctionMBS("(p)i", createSystemPtr)
		  End If
		  
		  // System Release - FMOD_System_Release
		  var releaseSystemPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_Release")
		  If releaseSystemPtr <> Nil Then
		    mReleaseSystem = New DeclareFunctionMBS("(p)i", releaseSystemPtr)
		  End If
		  
		  // Get DSP Buffer Size - FMOD_System_GetDSPBufferSize
		  var getDSPBufferSizePtr As Ptr = mFMODLibrary.Symbol("FMOD_System_GetDSPBufferSize")
		  If getDSPBufferSizePtr <> Nil Then
		    mGetDSPBufferSize = New DeclareFunctionMBS("(ppp)i", getDSPBufferSizePtr)
		  End If
		  
		  // Create DSP by Type - FMOD_System_CreateDSPByType
		  var createDSPByTypePtr As Ptr = mFMODLibrary.Symbol("FMOD_System_CreateDSPByType")
		  If createDSPByTypePtr <> Nil Then
		    mCreateDSPByType = New DeclareFunctionMBS("(pip)i", createDSPByTypePtr)
		  End If
		  
		  // DSP Set Metering Enabled - FMOD_DSP_SetMeteringEnabled
		  var dspSetMeteringEnabledPtr As Ptr = mFMODLibrary.Symbol("FMOD_DSP_SetMeteringEnabled")
		  If dspSetMeteringEnabledPtr <> Nil Then
		    mDSPSetMeteringEnabled = New DeclareFunctionMBS("(pii)i", dspSetMeteringEnabledPtr)
		  End If
		  
		  // DSP Get Metering Info - FMOD_DSP_GetMeteringInfo
		  var dspGetMeteringInfoPtr As Ptr = mFMODLibrary.Symbol("FMOD_DSP_GetMeteringInfo")
		  If dspGetMeteringInfoPtr <> Nil Then
		    mDSPGetMeteringInfo = New DeclareFunctionMBS("(ppp)i", dspGetMeteringInfoPtr)
		  End If
		  
		  // Get CPU Usage - FMOD_System_GetCPUUsage
		  var getCPUUsagePtr As Ptr = mFMODLibrary.Symbol("FMOD_System_GetCPUUsage")
		  If getCPUUsagePtr <> Nil Then
		    mGetCPUUsage = New DeclareFunctionMBS("(pp)i", getCPUUsagePtr)
		  End If
		  
		  // Get Memory Info - FMOD_System_GetMemoryInfo
		  var getMemoryInfoPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_GetMemoryInfo")
		  If getMemoryInfoPtr <> Nil Then
		    mGetMemoryInfo = New DeclareFunctionMBS("(piip)i", getMemoryInfoPtr)
		  End If
		  
		  // Get Channels Playing - FMOD_System_GetChannelsPlaying
		  var getChannelsPlayingPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_GetChannelsPlaying")
		  If getChannelsPlayingPtr <> Nil Then
		    mGetChannelsPlaying = New DeclareFunctionMBS("(ppp)i", getChannelsPlayingPtr)
		  End If
		  
		  // Get Master Channel Group - FMOD_System_GetMasterChannelGroup
		  var getMasterChannelGroupPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_GetMasterChannelGroup")
		  If getMasterChannelGroupPtr <> Nil Then
		    mGetMasterChannelGroup = New DeclareFunctionMBS("(pp)i", getMasterChannelGroupPtr)
		  End If
		  
		  // Channel Group Get DSP - FMOD_ChannelGroup_GetDSP
		  var channelGroupGetDSPPtr As Ptr = mFMODLibrary.Symbol("FMOD_ChannelGroup_GetDSP")
		  If channelGroupGetDSPPtr <> Nil Then
		    mChannelGroup_GetDSP = New DeclareFunctionMBS("(pip)i", channelGroupGetDSPPtr)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InitSystem(systemPtr As Ptr, maxChannels As Integer, flags As Integer, extraDriverData As Ptr = Nil) As Integer
		  If Not IsLibraryLoaded() Or mInitSystem Is Nil Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append maxChannels
		  params.Append flags
		  params.Append extraDriverData
		  
		  var result As Variant = mInitSystem.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsChannelPlaying(channel As Ptr, ByRef isPlaying As Boolean) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mIsChannelPlaying Is Nil Then
		    var isChannelPlayingPtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_IsPlaying")
		    If isChannelPlayingPtr <> Nil Then
		      mIsChannelPlaying = New DeclareFunctionMBS("(p@)i", isChannelPlayingPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  params.Append isPlaying
		  
		  var result As Variant = mIsChannelPlaying.Invoke(params)
		  
		  // Extract the output isPlaying value
		  isPlaying = params(1)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLibraryLoaded() As Boolean
		  Return mFMODLibrary <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlaySound(systemPtr As Ptr, sound As Ptr, channelGroup As Ptr, paused As Boolean, ByRef channel As Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mPlaySound Is Nil Then
		    var playSoundPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_PlaySound")
		    If playSoundPtr <> Nil Then
		      mPlaySound = New DeclareFunctionMBS("(pppb@)i", playSoundPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append sound
		  params.Append channelGroup
		  params.Append paused
		  params.Append channel
		  
		  var result As Variant = mPlaySound.Invoke(params)
		  
		  // Extract the output channel pointer
		  channel = params(4)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReleaseSound(sound as Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mReleaseSound Is Nil Then
		    var releaseSoundPtr As Ptr = mFMODLibrary.Symbol("FMOD_Sound_Release")
		    If releaseSoundPtr <> Nil Then
		      mReleaseSound = New DeclareFunctionMBS("(p)i", releaseSoundPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append sound
		  
		  var result As Variant = mReleaseSound.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReleaseSystem(systemPtr as Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  
		  var result As Variant = mReleaseSystem.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetChannelFrequency(channel As Ptr, frequency As Double) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetChannelFrequency Is Nil Then
		    var setChannelFrequencyPtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_SetFrequency")
		    If setChannelFrequencyPtr <> Nil Then
		      mSetChannelFrequency = New DeclareFunctionMBS("(pf)i", setChannelFrequencyPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  params.Append frequency
		  
		  var result As Variant = mSetChannelFrequency.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetChannelPan(channel As Ptr, pan As Double) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetChannelPan Is Nil Then
		    var setChannelPanPtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_SetPan")
		    If setChannelPanPtr <> Nil Then
		      mSetChannelPan = New DeclareFunctionMBS("(pf)i", setChannelPanPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  params.Append pan
		  
		  var result As Variant = mSetChannelPan.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetChannelPaused(channel As Ptr, paused As Boolean) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetChannelPaused Is Nil Then
		    var setChannelPausedPtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_SetPaused")
		    If setChannelPausedPtr <> Nil Then
		      mSetChannelPaused = New DeclareFunctionMBS("(pb)i", setChannelPausedPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  params.Append paused
		  
		  var result As Variant = mSetChannelPaused.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetChannelVolume(channel As Ptr, volume As Double) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetChannelVolume Is Nil Then
		    var setChannelVolumePtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_SetVolume")
		    If setChannelVolumePtr <> Nil Then
		      mSetChannelVolume = New DeclareFunctionMBS("(pf)i", setChannelVolumePtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  params.Append volume
		  
		  var result As Variant = mSetChannelVolume.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetNumChannels(systemPtr As Ptr, numChannels As Integer) As Integer
		  If Not IsLibraryLoaded() Or mSetNumChannels Is Nil Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append numChannels
		  
		  var result As Variant = mSetNumChannels.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetSoftwareFormat(systemPtr As Ptr, sampleRate As Integer, speakerMode As Integer, numRawSpeakers As Integer = 0) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetSoftwareFormat Is Nil Then
		    var setSoftwareFormatPtr As Ptr = mFMODLibrary.Symbol("FMOD_System_SetSoftwareFormat")
		    If setSoftwareFormatPtr <> Nil Then
		      mSetSoftwareFormat = New DeclareFunctionMBS("(piii)i", setSoftwareFormatPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append systemPtr
		  params.Append sampleRate
		  params.Append speakerMode
		  params.Append numRawSpeakers
		  
		  var result As Variant = mSetSoftwareFormat.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetSoundLoopPoints(sound As Ptr, loopStart As Integer, loopStartType As Integer, loopEnd As Integer, loopEndType As Integer) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetSoundLoopPoints Is Nil Then
		    var setSoundLoopPointsPtr As Ptr = mFMODLibrary.Symbol("FMOD_Sound_SetLoopPoints")
		    If setSoundLoopPointsPtr <> Nil Then
		      mSetSoundLoopPoints = New DeclareFunctionMBS("(piiii)i", setSoundLoopPointsPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append sound
		  params.Append loopStart
		  params.Append loopStartType
		  params.Append loopEnd
		  params.Append loopEndType
		  
		  var result As Variant = mSetSoundLoopPoints.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetSoundMode(soundPtr As Ptr, mode As Integer) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mSetSoundMode Is Nil Then
		    var setSoundModePtr As Ptr = mFMODLibrary.Symbol("FMOD_Sound_SetMode")
		    If setSoundModePtr <> Nil Then
		      mSetSoundMode = New DeclareFunctionMBS("(pi)i", setSoundModePtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append soundPtr
		  params.Append mode
		  
		  var result As Variant = mSetSoundMode.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StopChannel(channel as Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
		  // Lazy initialize this function if needed
		  If mStopChannel Is Nil Then
		    var stopChannelPtr As Ptr = mFMODLibrary.Symbol("FMOD_Channel_Stop")
		    If stopChannelPtr <> Nil Then
		      mStopChannel = New DeclareFunctionMBS("(p)i", stopChannelPtr)
		    Else
		      Return -1
		    End If
		  End If
		  
		  var params() As Variant
		  params.Append channel
		  
		  var result As Variant = mStopChannel.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UpdateSystem(systemPtr As Ptr) As Integer
		  If Not IsLibraryLoaded() Or mUpdateSystem Is Nil Then Return -1
		  
		  var params() As Variant
		  params.Append systemPtr
		  
		  var result As Variant = mUpdateSystem.Invoke(params)
		  
		  Return result.IntegerValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mChannelGroup_GetDSP As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreateDSPByType As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreateSound As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreateSystem As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDSPGetMeteringInfo As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDSPSetMeteringEnabled As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDSPSetMeteringInfo As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMODLibrary As DeclareLibraryMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		mGetChannelPosition As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGetChannelsPlaying As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGetCPUUsage As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGetDSPBufferSize As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGetMasterChannelGroup As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGetMemoryInfo As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGetSoundLength As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitSystem As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsChannelPlaying As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlaySound As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReleaseSound As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReleaseSystem As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetChannelFrequency As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetChannelPan As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetChannelPaused As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetChannelVolume As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetNumChannels As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetSoftwareFormat As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetSoundLoopPoints As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetSoundMode As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStopChannel As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		mSystemInstance As FMODSystem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateSystem As DeclareFunctionMBS
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
End Module
#tag EndModule

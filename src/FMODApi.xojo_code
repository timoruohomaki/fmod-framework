#tag Module
Protected Module FMODApi
	#tag Method, Flags = &h0
		Sub ERRCHECK(result as Integer)
		  If result <> FMOD_OK Then
		    
		    var errorMsg As String = "FMOD Error: " + GetErrorString(result)
		    
		    #If DebugBuild Then
		      System.DebugLog(errorMsg)
		    #EndIf
		    
		    Raise New RuntimeException(errorMsg)
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_Channel_SetFrequency(channel As Ptr, frequency As Single) As Integer
		  Declare Function FMOD_Channel_SetFrequency_Lib Lib "fmod" Alias "FMOD_Channel_SetFrequency" (channel As Ptr, frequency As Single) As Integer
		  Return FMOD_Channel_SetFrequency_Lib(channel, frequency)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_Channel_SetPaused(channel As Ptr, paused As Boolean) As Integer
		  Declare Function FMOD_Channel_SetPaused_Lib Lib "fmod" Alias "FMOD_Channel_SetPaused" (channel As Ptr, paused As Boolean) As Integer
		  Return FMOD_Channel_SetPaused_Lib(channel, paused)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_Channel_SetVolume(channel As Ptr, volume As Single) As Integer
		  Declare Function FMOD_Channel_SetVolume_Lib Lib "fmod" Alias "FMOD_Channel_SetVolume" (channel As Ptr, volume As Single) As Integer
		  Return FMOD_Channel_SetVolume_Lib(channel, volume)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_Channel_Stop(channel As Ptr) As Integer
		  Declare Function FMOD_Channel_Stop_Lib Lib "fmod" Alias "FMOD_Channel_Stop" (channel As Ptr) As Integer
		  
		  Return FMOD_Channel_Stop_Lib(channel)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_DSP_Release(dspPtr As Ptr) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    System.Log(System.LogLevelDebug, "Invoking FMOD_DSP_Release")
		    
		    // Use array parameter approach for consistency
		    var params() As Variant
		    params.Append(dspPtr)
		    
		    Return mFMOD_DSP_Release.Invoke(params)
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_DSP_Release error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_DSP_SetParameterFloat(dsp As Ptr, index As Integer, value As Single) As Integer
		  Declare Function FMOD_DSP_SetParameterFloat_Lib Lib "fmod" Alias "FMOD_DSP_SetParameterFloat" (dsp As Ptr, index As Integer, value As Single) As Integer
		  
		  Return FMOD_DSP_SetParameterFloat_Lib(dsp, index, value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_DSP_SetParameterInt(dsp As Ptr, index As Integer, value As Integer) As Integer
		  Declare Function FMOD_DSP_SetParameterInt_Lib Lib "fmod" Alias "FMOD_DSP_SetParameterInt" (dsp As Ptr, index As Integer, value As Integer) As Integer
		  Return FMOD_DSP_SetParameterInt_Lib(dsp, index, value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_GetVersion() As UInt32
		  #If TargetWindows Then
		    Soft Declare Function FMOD_GetVersion_Lib Lib "fmod" Alias "FMOD_GetVersion" () As UInt32
		  #ElseIf TargetMacOS Then
		    Soft Declare Function FMOD_GetVersion_Lib Lib "libfmod" Alias "FMOD_GetVersion" () As UInt32
		  #EndIf
		  
		  If System.IsFunctionAvailable("FMOD_GetVersion", "fmod") Then
		    Return FMOD_GetVersion_Lib()
		  Else
		    System.DebugLog("FMOD_GetVersion function not found")
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_Close(systemPtr as Ptr) As Integer
		  Declare Function FMOD_System_Close_Lib Lib "fmod" Alias "FMOD_System_Close" (systemPtr as Ptr) As Integer
		  
		  Return FMOD_System_Close_Lib(systemPtr)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_Create(ByRef system As FMODSystem, version As UInt32) As Integer
		  
		  
		  
		  #If TargetMacOS Then
		    
		    Declare Function FMOD_System_Create_Lib Lib "libfmod" Alias "FMOD_System_Create" (ByRef system As FMODSystem, version As UInt32) As Integer
		    
		  #ElseIf TargetWindows Then
		    
		    Declare Function FMOD_System_Create_Lib Lib "fmod" Alias "FMOD_System_Create" (ByRef system As FMODSystem, version As UInt32) As Integer
		    
		  #ElseIf TargetLinux Then
		    
		    Declare Function FMOD_System_Create_Lib Lib "libfmod" Alias "FMOD_System_Create" (ByRef system As FMODSystem, version As UInt32) As Integer
		    
		  #EndIf
		  
		  Return FMOD_System_Create_Lib(system, version)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_CreateDSPByType(systemPtr As Ptr, dspType As Integer, ByRef dsp As FMODDSP) As Integer
		  Declare Function FMOD_System_CreateDSPByType_Lib Lib "fmod" Alias "FMOD_System_CreateDSPByType" (systemPtr as Ptr, dspType As Integer, ByRef dsp As FMODDSP) As Integer
		  
		  Return FMOD_System_CreateDSPByType_Lib(systemPtr, dspType, dsp)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_CreateSound(systemPtr As Ptr, filename As String, flags As UInt32, info As Ptr, ByRef sound As FMODSound) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    var soundMB As New MemoryBlock(4)
		    
		    var params() As Variant
		    params.Append(systemPtr)
		    params.Append(filename)
		    params.Append(flags)
		    params.Append(info)
		    params.Append(soundMB)
		    
		    var result As Integer = mFMOD_System_CreateSound.Invoke(params)
		    
		    If result = 0 Then
		      sound.Ptr = soundMB.Ptr(0)
		    End If
		    
		    Return result
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_System_CreateSound error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_CreateStream(systemPtr As Ptr, filename As String, flags As UInt32, info As Ptr, ByRef sound As FMODSound) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    var soundMB As New MemoryBlock(4)
		    
		    var params() As Variant
		    params.Append(systemPtr)
		    params.Append(filename)
		    params.Append(flags)
		    params.Append(info)
		    params.Append(soundMB)
		    
		    var result As Integer = mFMOD_System_CreateStream.Invoke(params)
		    
		    If result = 0 Then
		      sound.Ptr = soundMB.Ptr(0)
		    End If
		    
		    Return result
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_System_CreateStream error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_GetMasterChannelGroup(systemPtr As Ptr, ByRef channelGroup As FMODChannelGroup) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    System.Log(System.LogLevelDebug, "Getting master channel group")
		    
		    // Use array parameter approach for consistency
		    var channelGroupMB As New MemoryBlock(4)
		    
		    var params() As Variant
		    params.Append(systemPtr)
		    params.Append(channelGroupMB)
		    
		    var result As Integer = mFMOD_System_GetMasterChannelGroup.Invoke(params)
		    
		    If result = 0 Then
		      channelGroup.Ptr = channelGroupMB.Ptr(0)
		    End If
		    
		    Return result
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_System_GetMasterChannelGroup error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_Init(systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    System.Log(System.LogLevelDebug, "Invoking FMOD_System_Init with maxChannels=" + Str(maxChannels))
		    
		    // The error suggests there's a mismatch in parameter types
		    // Let's explicitly cast parameters to match the expected types
		    var result As Integer
		    
		    // Try using array syntax for multiple parameters with DeclareFunctionMBS
		    var params() As Variant
		    params.Append(systemPtr)
		    params.Append(maxChannels)
		    params.Append(flags)
		    params.Append(extraDriverData)
		    
		    result = mFMOD_System_Init.Invoke(params)
		    
		    Return result
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_System_Init error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_PlayDSP(systemPtr As Ptr, dspPtr As Ptr, channelGroupPtr As Ptr, paused As Boolean, ByRef channel As FMODChannel) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    System.Log(System.LogLevelDebug, "Invoking FMOD_System_PlayDSP")
		    System.Log(System.LogLevelDebug, "DSP ptr: " + If(dspPtr = Nil, "Nil", "Non-nil"))
		    
		    // Create a MemoryBlock to receive the channel pointer
		    var channelMB As New MemoryBlock(4)
		    
		    // Use array or the specific invoke method based on your MBS plugin
		    var params() As Variant
		    params.Append(systemPtr)
		    params.Append(dspPtr)
		    params.Append(channelGroupPtr)
		    params.Append(If(paused, 1, 0))  // Convert Boolean to Integer
		    params.Append(channelMB)
		    
		    var result As Integer = mFMOD_System_PlayDSP.Invoke(params)
		    
		    // Extract the channel pointer
		    If result = 0 Then
		      channel.Ptr = channelMB.Ptr(0)
		      System.Log(System.LogLevelDebug, "Channel pointer received: " + If(channel.Ptr = Nil, "Nil", "Non-nil"))
		    End If
		    
		    Return result
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_System_PlayDSP error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_Playsound(systemPtr As Ptr, sound As Ptr, channelGroup As Ptr, paused As Boolean, ByRef channel As FMODChannel) As Integer
		  If Not mInitialized Then
		    If Not InitializeFMODDeclares() Then
		      System.Log(System.LogLevelError, "FMOD declares not initialized")
		      Return -1
		    End If
		  End If
		  
		  Try
		    var channelMB As New MemoryBlock(4)
		    
		    var params() As Variant
		    params.Append(systemPtr)
		    params.Append(sound)
		    params.Append(channelGroup)
		    params.Append(If(paused, 1, 0))
		    params.Append(channelMB)
		    
		    var result As Integer = mFMOD_System_PlaySound.Invoke(params)
		    
		    If result = 0 Then
		      channel.Ptr = channelMB.Ptr(0)
		    End If
		    
		    Return result
		  Catch ex As RuntimeException
		    System.Log(System.LogLevelError, "FMOD_System_PlaySound error: " + ex.Message)
		    Return -1
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_Release(systemPtr as Ptr) As Integer
		  Declare Function FMOD_System_Release_Lib Lib "fmod" Alias "FMOD_System_Release" (systemPtr as Ptr) As Integer
		  
		  Return FMOD_System_Release_Lib(systemPtr)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_Update(systemPtr as Ptr) As Integer
		  Declare Function FMOD_System_Update_Lib Lib "fmod" Alias "FMOD_System_Update" (systemPtr as Ptr) As Integer
		  
		  Return FMOD_System_Update_Lib(systemPtr)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetErrorString(result as Integer) As String
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
		Function InitializeFMODDeclares() As Boolean
		  If mInitialized Then Return True
		  
		  // Determine the library name based on platform
		  var libraryName As String
		  
		  #If TargetWindows Then
		    libraryName = "fmod.dll"
		  #ElseIf TargetMacOS Then
		    libraryName = "libfmod.dylib"
		  #ElseIf TargetLinux Then
		    libraryName = "libfmod.so"
		  #EndIf
		  
		  // Load the library
		  mFMODLibrary = New DeclareLibraryMBS(libraryName)
		  
		  If mFMODLibrary = Nil  Then
		    System.DebugLog("Failed to load FMOD library: " + libraryName)
		    Return False
		  End If
		  
		  var fmodVersion as Integer
		  fmodVersion = FMOD_GetVersion()
		  
		  System.DebugLog("FMOD library version &h" +hex(fmodVersion)+ " loaded successfully.")
		  
		  // #if DebugBuild then
		  // 
		  // Var lines() As String = mFMODLibrary.SymbolNames
		  // Break // look in list of functions
		  // 
		  // #endif
		  
		  // Get function symbols and create function declares
		  
		  var p As Ptr = mFMODLibrary.Symbol("FMOD_System_Create")
		  
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_Create symbol")
		    Return False
		  End If
		  
		  mFMOD_System_Create = New DeclareFunctionMBS("(pi)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_System_Init")
		  
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_Init symbol")
		    Return False
		  End If
		  
		  mFMOD_System_Init = New DeclareFunctionMBS("(piii)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_System_Close")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_Close symbol")
		    Return False
		  End If
		  mFMOD_System_Close = New DeclareFunctionMBS("(p)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_System_Release")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_Release symbol")
		    Return False
		  End If
		  mFMOD_System_Release = New DeclareFunctionMBS("(p)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_System_Update")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_Update symbol")
		    Return False
		  End If
		  mFMOD_System_Update = New DeclareFunctionMBS("(p)i", p)
		  
		  // DSP Functions
		  
		  p = mFMODLibrary.Symbol("FMOD_System_CreateDSPByType")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_CreateDSPByType symbol")
		    Return False
		  End If
		  mFMOD_System_CreateDSPByType = New DeclareFunctionMBS("(pip)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_DSP_SetParameterFloat")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_DSP_SetParameterFloat symbol")
		    Return False
		  End If
		  mFMOD_DSP_SetParameterFloat = New DeclareFunctionMBS("(pif)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_DSP_SetParameterInt")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_DSP_SetParameterInt symbol")
		    Return False
		  End If
		  mFMOD_DSP_SetParameterInt = New DeclareFunctionMBS("(pii)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_DSP_Release")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_DSP_Release symbol")
		    Return False
		  End If
		  mFMOD_DSP_Release = New DeclareFunctionMBS("(p)i", p)
		  
		  // Channel functions
		  
		  
		  p = mFMODLibrary.Symbol("FMOD_System_PlayDSP")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_System_PlayDSP symbol")
		    Return False
		  End If
		  
		  mFMOD_System_PlayDSP = New DeclareFunctionMBS("(pppZp)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_SetVolume")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_SetVolume symbol")
		    Return False
		  End If
		  mFMOD_Channel_SetVolume = New DeclareFunctionMBS("(pf)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_SetFrequency")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_SetFrequency symbol")
		    Return False
		  End If
		  mFMOD_Channel_SetFrequency = New DeclareFunctionMBS("(pf)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_GetVolume")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_GetVolume symbol")
		    Return False
		  End If
		  mFMOD_Channel_GetVolume = New DeclareFunctionMBS("(pp)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_GetFrequency")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_GetFrequency symbol")
		    Return False
		  End If
		  mFMOD_Channel_GetFrequency = New DeclareFunctionMBS("(pp)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_SetPaused")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_SetPaused symbol")
		    Return False
		  End If
		  mFMOD_Channel_SetPaused = New DeclareFunctionMBS("(pZ)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_Stop")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_Stop symbol")
		    Return False
		  End If
		  mFMOD_Channel_Stop = New DeclareFunctionMBS("(p)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_Channel_IsPlaying")
		  If p = Nil Then
		    System.DebugLog("Failed to find FMOD_Channel_IsPlaying symbol")
		    Return False
		  End If
		  mFMOD_Channel_IsPlaying = New DeclareFunctionMBS("(pp)i", p)
		  
		  // Master channel functions
		  
		  p = mFMODLibrary.Symbol("FMOD_System_GetMasterChannelGroup")
		  If p = Nil Then
		    System.Log(System.LogLevelError, "Failed to find FMOD_System_GetMasterChannelGroup symbol")
		    Return False
		  End If
		  mFMOD_System_GetMasterChannelGroup = New DeclareFunctionMBS("(pp)i", p)
		  
		  // other functions
		  
		  p = mFMODLibrary.Symbol("FMOD_System_CreateStream")
		  If p = Nil Then
		    System.Log(System.LogLevelError, "Failed to find FMOD_System_CreateStream symbol")
		    Return False
		  End If
		  mFMOD_System_CreateStream = New DeclareFunctionMBS("(psipi)i", p)
		  
		  p = mFMODLibrary.Symbol("FMOD_System_PlaySound")
		  If p = Nil Then
		    System.Log(System.LogLevelError, "Failed to find FMOD_System_PlaySound symbol")
		    Return False
		  End If
		  mFMOD_System_PlaySound = New DeclareFunctionMBS("(pppip)i", p)
		  
		  // Additional verification could be added for other functions
		  
		  mInitialized = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLibraryPath()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFMODLibrary As DeclareLibraryMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_GetFrequency As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_GetVolume As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_IsPlaying As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_SetFrequency As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_SetPaused As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_SetVolume As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_Channel_Stop As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_DSP_Release As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_DSP_SetParameterFloat As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_DSP_SetParameterInt As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_Close As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_Create As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_CreateDSPByType As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_CreateStream As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_GetMasterChannelGroup As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_Init As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_PlayDSP As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_PlaySound As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_Release As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_Update As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		mInitialized As Boolean = False
	#tag EndProperty


	#tag Constant, Name = FMOD_DSP_OSCILLATOR_RATE, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_OSCILLATOR_TYPE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_OSCILLATOR, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_BADCOMMAND, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_CHANNEL_ALLOC, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_CHANNEL_STOLEN, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DMA, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_CONNECTION, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_DONTPROCESS, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_FORMAT, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_INUSE, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_NOTFOUND, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_RUNNING, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_TOOMANYCONNECTIONS, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_BAD, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_COULDNOTSEEK, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_DISKEJECTED, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_ENDOFDATA, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_EOF, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_NOTFOUND, Type = Double, Dynamic = False, Default = \"17", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_NORMAL, Type = Double, Dynamic = False, Default = \"&h00000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_LOOP_NORMAL, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OSCILLATOR_SAWDOWN, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OSCILLATOR_SAWUP, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OSCILLATOR_SINE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OSCILLATOR_SQUARE, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OSCILLATOR_TRIANGLE, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant


	#tag Structure, Name = FMODChannel, Flags = &h0
		Ptr As Ptr
	#tag EndStructure

	#tag Structure, Name = FMODChannelGroup, Flags = &h0
		Ptr as Ptr
	#tag EndStructure

	#tag Structure, Name = FMODDSP, Flags = &h0
		Ptr As Ptr
	#tag EndStructure

	#tag Structure, Name = FMODSound, Flags = &h0
		Ptr as Ptr
	#tag EndStructure

	#tag Structure, Name = FMODSystem, Flags = &h0
		Ptr As Ptr
	#tag EndStructure


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
End Module
#tag EndModule

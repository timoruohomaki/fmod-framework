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
		Function FMOD_DSP_Release(dsp as Ptr) As Integer
		  Declare Function FMOD_DSP_Release_Lib Lib "fmod" Alias "FMOD_DSP_Release" (dsp As Ptr) As Integer
		  Return FMOD_DSP_Release_Lib(dsp)
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
		Function FMOD_System_Init(systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer
		  #If TargetMacOS Then
		    Soft Declare Function FMOD_System_Init_Lib Lib "libfmod" Alias "FMOD_System_Init" (systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer
		  #ElseIf TargetWindows Then
		    Soft Declare Function FMOD_System_Init_Lib Lib "fmod" Alias "FMOD_System_Init" (systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer
		  #ElseIf TargetLinux Then
		    Soft Declare Function FMOD_System_Init_Lib Lib "libfmod" Alias "FMOD_System_Init" (systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer
		  #EndIf
		  
		  Try
		    Return FMOD_System_Init_Lib(systemPtr, maxChannels, flags, extraDriverData)
		  Catch ex As RuntimeException
		    System.DebugLog("FMOD_System_Init error: " + ex.Message)
		    Return -1 // Return an error code
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FMOD_System_PlayDSP(systemPtr As Ptr, dsp As Ptr, channelGroup As Ptr, paused As Boolean, ByRef channel As FMODChannel) As Integer
		  Declare Function FMOD_System_PlayDSP_Lib Lib "fmod" Alias "FMOD_System_PlayDSP" (systemPtr as Ptr, dsp As Ptr, channelGroup As Ptr, paused As Boolean, ByRef channel As FMODChannel) As Integer
		  Return FMOD_System_PlayDSP_Lib(systemPtr, dsp, channelGroup, paused, channel)
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
		  
		  // Create System functions
		  mFMOD_System_Create = New DeclareFunctionMBS(libraryName, "FMOD_System_Create")
		  mFMOD_System_Create.Declare("FMOD_System_Create", "pi", "i")
		  
		  mFMOD_System_Init = New DeclareFunctionMBS(libraryName, "FMOD_System_Init")
		  mFMOD_System_Init.Declare("FMOD_System_Init", "pipi", "i")
		  
		  mFMOD_System_Close = New DeclareFunctionMBS(libraryName, "FMOD_System_Close")
		  mFMOD_System_Close.Declare("FMOD_System_Close", "p", "i")
		  
		  mFMOD_System_Release = New DeclareFunctionMBS(libraryName, "FMOD_System_Release")
		  mFMOD_System_Release.Declare("FMOD_System_Release", "p", "i")
		  
		  mFMOD_System_Update = New DeclareFunctionMBS(libraryName, "FMOD_System_Update")
		  mFMOD_System_Update.Declare("FMOD_System_Update", "p", "i")
		  
		  // DSP functions
		  mFMOD_System_CreateDSPByType = New DeclareFunctionMBS(libraryName, "FMOD_System_CreateDSPByType")
		  mFMOD_System_CreateDSPByType.Declare("FMOD_System_CreateDSPByType", "pip", "i")
		  
		  mFMOD_DSP_SetParameterFloat = New DeclareFunctionMBS(libraryName, "FMOD_DSP_SetParameterFloat")
		  mFMOD_DSP_SetParameterFloat.Declare("FMOD_DSP_SetParameterFloat", "pif", "i")
		  
		  mFMOD_DSP_SetParameterInt = New DeclareFunctionMBS(libraryName, "FMOD_DSP_SetParameterInt")
		  mFMOD_DSP_SetParameterInt.Declare("FMOD_DSP_SetParameterInt", "pii", "i")
		  
		  mFMOD_DSP_Release = New DeclareFunctionMBS(libraryName, "FMOD_DSP_Release")
		  mFMOD_DSP_Release.Declare("FMOD_DSP_Release", "p", "i")
		  
		  // Channel functions
		  mFMOD_System_PlayDSP = New DeclareFunctionMBS(libraryName, "FMOD_System_PlayDSP")
		  mFMOD_System_PlayDSP.Declare("FMOD_System_PlayDSP", "pppbp", "i")
		  
		  mFMOD_Channel_SetVolume = New DeclareFunctionMBS(libraryName, "FMOD_Channel_SetVolume")
		  mFMOD_Channel_SetVolume.Declare("FMOD_Channel_SetVolume", "pf", "i")
		  
		  mFMOD_Channel_SetFrequency = New DeclareFunctionMBS(libraryName, "FMOD_Channel_SetFrequency")
		  mFMOD_Channel_SetFrequency.Declare("FMOD_Channel_SetFrequency", "pf", "i")
		  
		  mFMOD_Channel_GetVolume = New DeclareFunctionMBS(libraryName, "FMOD_Channel_GetVolume")
		  mFMOD_Channel_GetVolume.Declare("FMOD_Channel_GetVolume", "pp", "i")
		  
		  mFMOD_Channel_GetFrequency = New DeclareFunctionMBS(libraryName, "FMOD_Channel_GetFrequency")
		  mFMOD_Channel_GetFrequency.Declare("FMOD_Channel_GetFrequency", "pp", "i")
		  
		  mFMOD_Channel_SetPaused = New DeclareFunctionMBS(libraryName, "FMOD_Channel_SetPaused")
		  mFMOD_Channel_SetPaused.Declare("FMOD_Channel_SetPaused", "pb", "i")
		  
		  mFMOD_Channel_Stop = New DeclareFunctionMBS(libraryName, "FMOD_Channel_Stop")
		  mFMOD_Channel_Stop.Declare("FMOD_Channel_Stop", "p", "i")
		  
		  mFMOD_Channel_IsPlaying = New DeclareFunctionMBS(libraryName, "FMOD_Channel_IsPlaying")
		  mFMOD_Channel_IsPlaying.Declare("FMOD_Channel_IsPlaying", "pp", "i")
		  
		  // Verify that all declares were created successfully
		  If mFMOD_System_Create = Nil Or Not mFMOD_System_Create.Available Then
		    System.DebugLog("FMOD_System_Create not available")
		    Return False
		  End If
		  
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
		Private mFMOD_System_Init As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFMOD_System_PlayDSP As DeclareFunctionMBS
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

	#tag Structure, Name = FMODDSP, Flags = &h0
		Ptr As Ptr
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

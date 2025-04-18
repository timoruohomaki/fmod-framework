#tag Class
Protected Class FMODLibraryManager
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

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  do
		  loop until LoadLibrary()
		  
		  InitializeFunctions()
		End Sub
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
		Function CreateSystem(ByRef systemPtr as Ptr) As Integer
		  If Not IsLibraryLoaded() Then Return -1
		  
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
		  If Not IsLibraryLoaded() Then Return -1
		  
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

	#tag Method, Flags = &h21
		Private Function GetLibrary() As DeclareLibraryMBS
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
		Sub InitializeFunctions()
		  // // System Creation - FMOD_System_Create
		  // mCreateSystem = New DeclareFunctionMBS("p@", "i", mFMODLibrary.Symbol("FMOD_System_Create"))
		  // 
		  // // System Release - FMOD_System_Release
		  // mReleaseSystem = New DeclareFunctionMBS("p", "i", mFMODLibrary.Symbol("FMOD_System_Release"))
		  // 
		  // // Get DSP Buffer Size - FMOD_System_GetDSPBufferSize
		  // mGetDSPBufferSize = New DeclareFunctionMBS("p@@", "i", mFMODLibrary.Symbol("FMOD_System_GetDSPBufferSize"))
		  // 
		  // // Create DSP by Type - FMOD_System_CreateDSPByType
		  // mCreateDSPByType = New DeclareFunctionMBS("pi@", "i", mFMODLibrary.Symbol("FMOD_System_CreateDSPByType"))
		  // 
		  // // DSP Set Metering Enabled - FMOD_DSP_SetMeteringEnabled
		  // mDSPSetMeteringEnabled = New DeclareFunctionMBS("pbb", "i", mFMODLibrary.Symbol("FMOD_DSP_SetMeteringEnabled"))
		  // 
		  // // DSP Get Metering Info - FMOD_DSP_GetMeteringInfo
		  // mDSPGetMeteringInfo = New DeclareFunctionMBS("pp@", "i", mFMODLibrary.Symbol("FMOD_DSP_GetMeteringInfo"))
		  // 
		  // // Get CPU Usage - FMOD_System_GetCPUUsage
		  // mGetCPUUsage = New DeclareFunctionMBS("p@", "i", mFMODLibrary.Symbol("FMOD_System_GetCPUUsage"))
		  // 
		  // // Get Memory Info - FMOD_System_GetMemoryInfo
		  // mGetMemoryInfo = New DeclareFunctionMBS("pii@", "i", mFMODLibrary.Symbol("FMOD_System_GetMemoryInfo"))
		  // 
		  // // Get Channels Playing - FMOD_System_GetChannelsPlaying
		  // mGetChannelsPlaying = New DeclareFunctionMBS("p@@", "i", mFMODLibrary.Symbol("FMOD_System_GetChannelsPlaying"))
		  // 
		  // // Get Master Channel Group - FMOD_System_GetMasterChannelGroup
		  // mGetMasterChannelGroup = New DeclareFunctionMBS("p@", "i", mFMODLibrary.Symbol("FMOD_System_GetMasterChannelGroup"))
		  // 
		  // // Channel Group Get DSP - FMOD_ChannelGroup_GetDSP
		  // mChannelGroup_GetDSP = New DeclareFunctionMBS("pi@", "i", mFMODLibrary.Symbol("FMOD_ChannelGroup_GetDSP"))
		  
		  
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
		Function Instance() As FMODLibraryManager
		  If mInstance = Nil Then
		    mInstance = New FMODLibraryManager
		  End If
		  
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLibraryLoaded() As Boolean
		      Return mFMODLibrary <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadLibrary() As Boolean
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
		  
		  // TODO if failed
		  
		  // If Not mFMODLibrary.Load(libraryPath) Then
		  // System.DebugLog("Failed to load FMOD library: " + mFMODLibrary.LastError)
		  // Return False
		  // End If
		  
		  Return True
		  
		  
		  
		  
		  
		  
		  
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


	#tag Property, Flags = &h21
		Private mChannelGroup_GetDSP As DeclareFunctionMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreateDSPByType As DeclareFunctionMBS
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

	#tag Property, Flags = &h1
		Protected mInstance As FMODLibraryManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReleaseSystem As DeclareFunctionMBS
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
			Name="mInstance"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

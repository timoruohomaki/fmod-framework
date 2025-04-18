#tag Class
Protected Class FMODStructures
	#tag Method, Flags = &h0
		Function ExInfoToMemoryBlock(info as FMOD_CREATESOUNDEXINFO) As MemoryBlock
		  var mb As New MemoryBlock(FMOD_CREATESOUNDEXINFO.Size)
		  
		  // Set basic properties
		  mb.Int32Value(0) = info.cbsize
		  mb.UInt32Value(4) = info.length
		  mb.UInt32Value(8) = info.fileoffset
		  mb.Int32Value(12) = info.numchannels
		  mb.Int32Value(16) = info.defaultfrequency
		  mb.Int32Value(20) = info.format
		  mb.Int32Value(24) = info.decodebuffersize
		  mb.Int32Value(28) = info.initialsubsound
		  mb.Int32Value(32) = info.numsubsounds
		  
		  // Set pointers and references - use pointer methods appropriate for platform
		  #If Target64Bit Then
		    // For 64-bit platforms, use Int64Value for pointer values
		    mb.Int64Value(36) = Integer(info.inclusionlist)
		    mb.Int32Value(44) = info.inclusionlistnum
		    mb.Int64Value(48) = Integer(info.pcmreadcallback)
		    mb.Int64Value(56) = Integer(info.pcmsetposcallback)
		    mb.Int64Value(64) = Integer(info.nonblockcallback)
		    mb.Int64Value(72) = Integer(info.dlsname)
		    mb.Int64Value(80) = Integer(info.encryptionkey)
		    
		    // Set remaining properties
		    mb.Int32Value(88) = info.maxpolyphony
		    mb.Int64Value(92) = Integer(info.userdata)
		    mb.Int32Value(100) = info.suggestedsoundtype
		    
		    // Set file user functions
		    mb.Int64Value(104) = Integer(info.fileuseropen)
		    mb.Int64Value(112) = Integer(info.fileuserclose)
		    mb.Int64Value(120) = Integer(info.fileuserread)
		    mb.Int64Value(128) = Integer(info.fileuserseek)
		    mb.Int64Value(136) = Integer(info.fileuserasyncread)
		    mb.Int64Value(144) = Integer(info.fileuserasynccancel)
		    mb.Int64Value(152) = Integer(info.fileuserdata)
		    
		    // Set advanced properties
		    mb.Int32Value(160) = info.filebuffersize
		    mb.Int32Value(164) = info.channelorder
		    mb.Int64Value(168) = Integer(info.initialsoundgroup)
		    mb.UInt32Value(176) = info.initialseekposition
		    mb.Int32Value(180) = info.initialseekpostype
		    mb.Int32Value(184) = info.ignoresetfilesystem
		    mb.UInt32Value(188) = info.audioqueuepolicy
		    mb.UInt32Value(192) = info.minmidigranularity
		    mb.Int32Value(196) = info.nonblockthreadid
		    mb.Int64Value(200) = Integer(info.fsbguid)
		  #Else
		    // For 32-bit platforms, use Int32Value for pointer values
		    mb.Int32Value(36) = Integer(info.inclusionlist)
		    mb.Int32Value(40) = info.inclusionlistnum
		    mb.Int32Value(44) = Integer(info.pcmreadcallback)
		    mb.Int32Value(48) = Integer(info.pcmsetposcallback)
		    mb.Int32Value(52) = Integer(info.nonblockcallback)
		    mb.Int32Value(56) = Integer(info.dlsname)
		    mb.Int32Value(60) = Integer(info.encryptionkey)
		    
		    // Set remaining properties
		    mb.Int32Value(64) = info.maxpolyphony
		    mb.Int32Value(68) = Integer(info.userdata)
		    mb.Int32Value(72) = info.suggestedsoundtype
		    
		    // Set file user functions
		    mb.Int32Value(76) = Integer(info.fileuseropen)
		    mb.Int32Value(80) = Integer(info.fileuserclose)
		    mb.Int32Value(84) = Integer(info.fileuserread)
		    mb.Int32Value(88) = Integer(info.fileuserseek)
		    mb.Int32Value(92) = Integer(info.fileuserasyncread)
		    mb.Int32Value(96) = Integer(info.fileuserasynccancel)
		    mb.Int32Value(100) = Integer(info.fileuserdata)
		    
		    // Set advanced properties
		    mb.Int32Value(104) = info.filebuffersize
		    mb.Int32Value(108) = info.channelorder
		    mb.Int32Value(112) = Integer(info.initialsoundgroup)
		    mb.UInt32Value(116) = info.initialseekposition
		    mb.Int32Value(120) = info.initialseekpostype
		    mb.Int32Value(124) = info.ignoresetfilesystem
		    mb.UInt32Value(128) = info.audioqueuepolicy
		    mb.UInt32Value(132) = info.minmidigranularity
		    mb.Int32Value(136) = info.nonblockthreadid
		    mb.Int32Value(140) = Integer(info.fsbguid)
		  #EndIf
		  
		  return mb
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MemoryBlockToExInfo(mb as MemoryBlock) As FMOD_CREATESOUNDEXINFO
		  var info As FMOD_CREATESOUNDEXINFO
		  
		  if mb <> nil then
		    
		    // Get basic properties
		    info.cbsize = mb.Int32Value(0)
		    info.length = mb.UInt32Value(4)
		    info.fileoffset = mb.UInt32Value(8)
		    info.numchannels = mb.Int32Value(12)
		    info.defaultfrequency = mb.Int32Value(16)
		    info.format = mb.Int32Value(20)
		    info.decodebuffersize = mb.Int32Value(24)
		    info.initialsubsound = mb.Int32Value(28)
		    info.numsubsounds = mb.Int32Value(32)
		    
		    // Get pointers and references - use pointer methods appropriate for platform
		    #If Target64Bit Then
		      // For 64-bit platforms, use Int64Value for pointer values
		      info.inclusionlist = Ptr(mb.Int64Value(36))
		      info.inclusionlistnum = mb.Int32Value(44)
		      info.pcmreadcallback = Ptr(mb.Int64Value(48))
		      info.pcmsetposcallback = Ptr(mb.Int64Value(56))
		      info.nonblockcallback = Ptr(mb.Int64Value(64))
		      info.dlsname = Ptr(mb.Int64Value(72))
		      info.encryptionkey = Ptr(mb.Int64Value(80))
		      
		      // Get remaining properties
		      info.maxpolyphony = mb.Int32Value(88)
		      info.userdata = Ptr(mb.Int64Value(92))
		      info.suggestedsoundtype = mb.Int32Value(100)
		      
		      // Get file user functions
		      info.fileuseropen = Ptr(mb.Int64Value(104))
		      info.fileuserclose = Ptr(mb.Int64Value(112))
		      info.fileuserread = Ptr(mb.Int64Value(120))
		      info.fileuserseek = Ptr(mb.Int64Value(128))
		      info.fileuserasyncread = Ptr(mb.Int64Value(136))
		      info.fileuserasynccancel = Ptr(mb.Int64Value(144))
		      info.fileuserdata = Ptr(mb.Int64Value(152))
		      
		      // Get advanced properties
		      info.filebuffersize = mb.Int32Value(160)
		      info.channelorder = mb.Int32Value(164)
		      info.initialsoundgroup = Ptr(mb.Int64Value(168))
		      info.initialseekposition = mb.UInt32Value(176)
		      info.initialseekpostype = mb.Int32Value(180)
		      info.ignoresetfilesystem = mb.Int32Value(184)
		      info.audioqueuepolicy = mb.UInt32Value(188)
		      info.minmidigranularity = mb.UInt32Value(192)
		      info.nonblockthreadid = mb.Int32Value(196)
		      info.fsbguid = Ptr(mb.Int64Value(200))
		    #Else
		      // For 32-bit platforms, use Int32Value for pointer values
		      info.inclusionlist = Ptr(mb.Int32Value(36))
		      info.inclusionlistnum = mb.Int32Value(40)
		      info.pcmreadcallback = Ptr(mb.Int32Value(44))
		      info.pcmsetposcallback = Ptr(mb.Int32Value(48))
		      info.nonblockcallback = Ptr(mb.Int32Value(52))
		      info.dlsname = Ptr(mb.Int32Value(56))
		      info.encryptionkey = Ptr(mb.Int32Value(60))
		      
		      // Get remaining properties
		      info.maxpolyphony = mb.Int32Value(64)
		      info.userdata = Ptr(mb.Int32Value(68))
		      info.suggestedsoundtype = mb.Int32Value(72)
		      
		      // Get file user functions
		      info.fileuseropen = Ptr(mb.Int32Value(76))
		      info.fileuserclose = Ptr(mb.Int32Value(80))
		      info.fileuserread = Ptr(mb.Int32Value(84))
		      info.fileuserseek = Ptr(mb.Int32Value(88))
		      info.fileuserasyncread = Ptr(mb.Int32Value(92))
		      info.fileuserasynccancel = Ptr(mb.Int32Value(96))
		      info.fileuserdata = Ptr(mb.Int32Value(100))
		      
		      // Get advanced properties
		      info.filebuffersize = mb.Int32Value(104)
		      info.channelorder = mb.Int32Value(108)
		      info.initialsoundgroup = Ptr(mb.Int32Value(112))
		      info.initialseekposition = mb.UInt32Value(116)
		      info.initialseekpostype = mb.Int32Value(120)
		      info.ignoresetfilesystem = mb.Int32Value(124)
		      info.audioqueuepolicy = mb.UInt32Value(128)
		      info.minmidigranularity = mb.UInt32Value(132)
		      info.nonblockthreadid = mb.Int32Value(136)
		      info.fsbguid = Ptr(mb.Int32Value(140))
		    #EndIf
		    
		  end
		  
		  return info
		End Function
	#tag EndMethod


	#tag Constant, Name = ERR_DSP_TYPE, Type = Double, Dynamic = False, Default = \"12", Scope = Public
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

	#tag Constant, Name = FMOD_ERR_DSP_RESERVED, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_RUNNING, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_SILENCE, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_TOOMANYCONNECTIONS, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_DSP_TYPE, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_BAD, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_COULDNOTSEEK, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_DISKEJECTED, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_ENDOFDATA, Type = Double, Dynamic = False, Default = \"17", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_EOF, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_ERR_FILE_NOTFOUND, Type = Double, Dynamic = False, Default = \"18", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_RESULT_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant


	#tag Structure, Name = FMOD_CPU_USAGE, Flags = &h0
		dsp As Single
		  stream As Single
		  geometry As Single
		  update As Single
		total As Single
	#tag EndStructure

	#tag Structure, Name = FMOD_CREATESOUNDEXINFO, Flags = &h0
		cbsize As Integer
		  length As UInt32
		  fileoffset As UInt32
		  numchannels As Integer
		  defaultfrequency As Integer
		  format As Integer
		  decodebuffersize As Integer
		  initialsubsound As Integer
		  numsubsounds As Integer
		  inclusionlist As Ptr
		  inclusionlistnum As Integer
		  pcmreadcallback As Ptr
		  pcmsetposcallback As Ptr
		  nonblockcallback As Ptr
		  dlsname As Ptr
		  encryptionkey as Ptr
		  maxpolyphony As Integer
		  userdata As Ptr
		  suggestedsoundtype As Integer
		  fileuseropen As Ptr
		  fileuserclose As Ptr
		  fileuserread As Ptr
		  fileuserseek As Ptr
		  fileuserasyncread As Ptr
		  fileuserasynccancel As Ptr
		  fileuserdata As Ptr
		  filebuffersize As Integer
		  channelorder As Integer
		  initialsoundgroup As Ptr
		  initialseekposition As UInt32
		  initialseekpostype As Integer
		  ignoresetfilesystem As Integer
		  audioqueuepolicy As Integer
		  minmidigranularity As UInt32
		  nonblockthreadid As Integer
		fsbguid As Ptr
	#tag EndStructure

	#tag Structure, Name = FMOD_DSP_METERING_INFO, Flags = &h0
		numsamples As Integer
		  peaklevel(32) As Single
		  rmslevel(32) As Single
		numchannels As Integer
	#tag EndStructure

	#tag Structure, Name = FMOD_MEMORY_USAGE, Flags = &h0
		currentallocated As UInt32
		  maxallocated As UInt32
		other As UInt32
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
	#tag EndViewBehavior
End Class
#tag EndClass

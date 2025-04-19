#tag Module
Protected Module FMODStructures
	#tag Method, Flags = &h0
		Function CPUUsageToMemoryBlock(usage as FMOD_CPU_USAGE) As MemoryBlock
		  var mb As New MemoryBlock(FMOD_CPU_USAGE.Size)
		  
		  mb.SingleValue(0) = usage.dsp
		  mb.SingleValue(4) = usage.stream
		  mb.SingleValue(8) = usage.geometry
		  mb.SingleValue(12) = usage.update
		  mb.SingleValue(16) = usage.total
		  
		  return mb
		End Function
	#tag EndMethod

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
		Function MemoryBlockToCPUUsage(mb as MemoryBlock) As FMOD_CPU_USAGE
		  var usage As FMOD_CPU_USAGE
		  
		  if mb <> nil then
		    usage.dsp = mb.SingleValue(0)
		    usage.stream = mb.SingleValue(4)
		    usage.geometry = mb.SingleValue(8)
		    usage.update = mb.SingleValue(12)
		    usage.total = mb.SingleValue(16)
		  end if
		  
		  return usage
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

	#tag Method, Flags = &h0
		Function MemoryBlockToMemoryUsage(mb as MemoryBlock) As FMOD_MEMORY_USAGE
		  var usage As FMOD_MEMORY_USAGE
		  
		  if mb <> nil then
		    usage.currentallocated = mb.UInt32Value(0)
		    usage.maxallocated = mb.UInt32Value(4)
		    usage.other = mb.UInt32Value(8)
		  end if
		  
		  return usage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MemoryBlockToMeteringInfo(mb as MemoryBlock) As FMOD_DSP_METERING_INFO
		  var info As FMOD_DSP_METERING_INFO
		  
		  if mb <> nil then
		    info.numsamples = mb.Int32Value(0)
		    
		    // Get peak levels
		    var peakLevelOffset As Integer = 4
		    for i As Integer = 0 to 31
		      info.peaklevel(i) = mb.SingleValue(peakLevelOffset + i * 4)
		    next
		    
		    // Get RMS levels
		    var rmsLevelOffset As Integer = peakLevelOffset + 32 * 4
		    for i As Integer = 0 to 31
		      info.rmslevel(i) = mb.SingleValue(rmsLevelOffset + i * 4)
		    next
		    
		    // Get number of channels
		    info.numchannels = mb.Int32Value(rmsLevelOffset + 32 * 4)
		  end if
		  
		  return info
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MemoryUsageToMemoryBlock(usage as FMOD_MEMORY_USAGE) As MemoryBlock
		  var mb As New MemoryBlock(FMOD_MEMORY_USAGE.Size)
		  
		  mb.UInt32Value(0) = usage.currentallocated
		  mb.UInt32Value(4) = usage.maxallocated
		  mb.UInt32Value(8) = usage.other
		  
		  return mb
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MeteringInfoToMemoryBlock(info as FMOD_DSP_METERING_INFO) As MemoryBlock
		  // Implement this method
		  var structSize As Integer = 4 + (32 * 4 * 2) + 4  // numsamples + peaklevel array + rmslevel array + numchannels
		  var mb As New MemoryBlock(structSize)
		  
		  mb.Int32Value(0) = info.numsamples
		  
		  // Set peak levels
		  var peakLevelOffset As Integer = 4
		  for i As Integer = 0 to 31
		    mb.SingleValue(peakLevelOffset + i * 4) = info.peaklevel(i)
		  next
		  
		  // Set RMS levels
		  var rmsLevelOffset As Integer = peakLevelOffset + 32 * 4
		  for i As Integer = 0 to 31
		    mb.SingleValue(rmsLevelOffset + i * 4) = info.rmslevel(i)
		  next
		  
		  // Set number of channels
		  mb.Int32Value(rmsLevelOffset + 32 * 4) = info.numchannels
		  
		  return mb
		End Function
	#tag EndMethod


	#tag Constant, Name = ERR_DSP_TYPE, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_CHANNELCONTROL_DSP_INDEX_FADER, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_CHANNELCONTROL_DSP_INDEX_HEAD, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_CHANNELCONTROL_DSP_INDEX_TAIL, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_AUDIO_RETURN, Type = Double, Dynamic = False, Default = \"22", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_AUDIO_SEND, Type = Double, Dynamic = False, Default = \"21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_CHANNELMIX, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_CHORUS, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_COMPRESSOR, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_CONVOLUTIONREVERB, Type = Double, Dynamic = False, Default = \"29", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_DELAY, Type = Double, Dynamic = False, Default = \"18", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_DISTORTION, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_ECHO, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_ENVELOPEFOLLOWER, Type = Double, Dynamic = False, Default = \"28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_FFT, Type = Double, Dynamic = False, Default = \"26", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_FLANGE, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_HIGHPASS, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_HIGHPASSSIMPLE, Type = Double, Dynamic = False, Default = \"23", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_ITECHO, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_LADSPA, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_LIMITER, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_LOUDNESS_METER, Type = Double, Dynamic = False, Default = \"27", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_LOWPASS, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_LOWPASSIMPLE, Type = Double, Dynamic = False, Default = \"17", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_MIXER, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_MULTIBAND_EQ, Type = Double, Dynamic = False, Default = \"33", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_NORMALIZE, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_OBJECTPAN, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_OSCILLATOR, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_PAN, Type = Double, Dynamic = False, Default = \"24", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_PARAMEQ, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_PITCHSHIFT, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_SFXREVERB, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_THREE_EQ, Type = Double, Dynamic = False, Default = \"25", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_TRANSCEIVER, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_TREMOLO, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_VSTPLUGIN, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_DSP_TYPE_WINAMPPLUGIN, Type = Double, Dynamic = False, Default = \"13", Scope = Public
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

	#tag Constant, Name = FMOD_INIT_CHANNEL_DISTANCEFILTER, Type = Double, Dynamic = False, Default = \"&h00000200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_CHANNEL_LOWPASS, Type = Double, Dynamic = False, Default = \"&h00000100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_D3D_RIGHTHANDED, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_GEOMETRY_USECLOSEST, Type = Double, Dynamic = False, Default = \"&h00040000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_MEMORY_TRACKING, Type = Double, Dynamic = False, Default = \"&h00400000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_MIX_FROM_UPDATE, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_NORMAL, Type = Double, Dynamic = False, Default = \"&h00000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_PREFER_DOLBY_DOWNMIX, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_PROFILE_ENABLE, Type = Double, Dynamic = False, Default = \"&h00010000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_PROFILE_METER_ALL, Type = Double, Dynamic = False, Default = \"&h00200000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_STREAM_FROM_UPDATE, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_THREAD_UNSAFE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_INIT_VOL0_BECOMES_VIRTUAL, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_MODE_DEFAULT, Type = Double, Dynamic = False, Default = \"&h00000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_MODE_LOOP_NORMAL, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_MODE_LOOP_OFF, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_RESULT_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_BITMAP, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_FLOAT, Type = String, Dynamic = False, Default = \"PCMFLOAT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_MAX, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_NONE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_PCM16, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_PCM24, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_PCM32, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_PCM8, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_SOUND_FORMAT_PCMFLOAT, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_MODORDER, Type = Double, Dynamic = False, Default = \"&h00000100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_MODPATTERN, Type = Double, Dynamic = False, Default = \"&h00000400", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_MODROW, Type = Double, Dynamic = False, Default = \"&h00000200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_MS, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_PCM, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_PCMBYTES, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_PCMFRACTION, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_TIMEUNIT_RAWBYTES, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FMOD_VERSION, Type = Double, Dynamic = False, Default = \"&h00020206", Scope = Public
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
End Module
#tag EndModule

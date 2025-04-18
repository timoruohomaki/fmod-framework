#tag Module
Protected Module FMOD_INIT
	#tag Constant, Name = CHANNEL_DISTANCEFILTER, Type = Double, Dynamic = False, Default = \"&h00000200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CHANNEL_LOWPASS, Type = Double, Dynamic = False, Default = \"&h00000100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = D3D_RIGHTHANDED, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GEOMETRY_USECLOSEST, Type = Double, Dynamic = False, Default = \"&h00040000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MEMORY_TRACKING, Type = Double, Dynamic = False, Default = \"&h00400000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MIX_FROM_UPDATE, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NORMAL, Type = Double, Dynamic = False, Default = \"&h00000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PREFER_DOLBY_DOWNMIX, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PROFILE_ENABLE, Type = Double, Dynamic = False, Default = \"&h00010000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PROFILE_METER_ALL, Type = Double, Dynamic = False, Default = \"&h00200000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STREAM_FROM_UPDATE, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = THREAD_UNSAFE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VOL0_BECOMES_VIRTUAL, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant


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

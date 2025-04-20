#tag DesktopWindow
Begin DesktopWindow Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   HasTitleBar     =   True
   Height          =   180
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1575311359
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "FMOD Test Framework"
   Type            =   0
   Visible         =   True
   Width           =   596
   Begin DesktopButton Button1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Play"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   135
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton Button2
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Stop"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   135
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Timer fmodTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   2
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin DesktopBevelButton BevelButton1
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowTabStop    =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   1
      Bold            =   False
      ButtonStyle     =   0
      Caption         =   "DSP Tone 1 kHz"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "Consolas"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   77
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   120
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopBevelButton BevelButton2
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowTabStop    =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   1
      Bold            =   False
      ButtonStyle     =   0
      Caption         =   "Audio File"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "Consolas"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   77
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   120
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopGaugeControl vuLeft
      AccessibilityLabel=   ""
      AutoDeactivate  =   True
      BorderColor     =   &c55575300
      Clickable       =   False
      DMBorderColor   =   &c55575300
      DMDownColor     =   &c1F24260C
      DMGaugeColor    =   &c2F34360C
      DMHighLimitColor=   &cC6C6C600
      DMLargeTickColor=   &cFFFFFF00
      DMLowLimitColor =   &c3C3C3C0C
      DMMediumLimitColor=   &c75757500
      DMNeedleColor   =   &cED6F2D00
      DMSmallTickColor=   &cF0F0F000
      DMTextColor     =   &cFFFFFF00
      DoubleBuffer    =   False
      DownColor       =   &c1F24260C
      Enabled         =   True
      FormatValue     =   "{value}"
      FormatValueMask =   "##"
      GaugeColor      =   &c2F34360C
      Height          =   140
      HighLimit       =   80.0
      HighLimitColor  =   &cC6C6C600
      HighValueLabel  =   ""
      Icon            =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Large           =   False
      LargeTickColor  =   &cFFFFFF00
      LargeTickCount  =   5
      Left            =   284
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LowLimit        =   30.0
      LowLimitColor   =   &c3C3C3C0C
      LowValueLabel   =   ""
      MaxValue        =   100.0
      MediumLimitColor=   &c75757500
      MinValue        =   0.0
      NeedleColor     =   &cED6F2D00
      Scope           =   0
      ShowLargeTicks  =   True
      ShowLimitBar    =   True
      ShowSmallTicks  =   True
      SmallTickColor  =   &cF0F0F000
      SmallTickCount  =   3
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &cFFFFFF00
      Tooltip         =   ""
      Top             =   20
      Value           =   0.0
      Visible         =   True
      Width           =   140
   End
   Begin DesktopGaugeControl vuRight
      AccessibilityLabel=   ""
      AutoDeactivate  =   True
      BorderColor     =   &c55575300
      Clickable       =   False
      DMBorderColor   =   &c55575300
      DMDownColor     =   &c1F24260C
      DMGaugeColor    =   &c2F34360C
      DMHighLimitColor=   &cC6C6C600
      DMLargeTickColor=   &cFFFFFF00
      DMLowLimitColor =   &c3C3C3C0C
      DMMediumLimitColor=   &c75757500
      DMNeedleColor   =   &cED6F2D00
      DMSmallTickColor=   &cF0F0F000
      DMTextColor     =   &cFFFFFF00
      DoubleBuffer    =   False
      DownColor       =   &c1F24260C
      Enabled         =   True
      FormatValue     =   "{value}"
      FormatValueMask =   "##"
      GaugeColor      =   &c2F34360C
      Height          =   140
      HighLimit       =   80.0
      HighLimitColor  =   &cC6C6C600
      HighValueLabel  =   ""
      Icon            =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Large           =   False
      LargeTickColor  =   &cFFFFFF00
      LargeTickCount  =   5
      Left            =   436
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LowLimit        =   30.0
      LowLimitColor   =   &c3C3C3C0C
      LowValueLabel   =   ""
      MaxValue        =   100.0
      MediumLimitColor=   &c75757500
      MinValue        =   0.0
      NeedleColor     =   &cED6F2D00
      Scope           =   0
      ShowLargeTicks  =   True
      ShowLimitBar    =   True
      ShowSmallTicks  =   True
      SmallTickColor  =   &cF0F0F000
      SmallTickCount  =   3
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &cFFFFFF00
      Tooltip         =   ""
      Top             =   20
      Value           =   0.0
      Visible         =   True
      Width           =   140
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub EndTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAverageCPUUsage() As Double
		  // Part of the IAudioProfiler interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPeakMemoryUsage() As UInt64
		  // Part of the IAudioProfiler interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProfileData() As Dictionary
		  // Part of the IAudioProfiler interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordBufferStats(bufferSize As UInt32, bufferUsage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordChannelUsage(activeChannels As UInt32, totalChannels As UInt32)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordCPUUsage(moduleIdentifier As String, usagePercentage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordDSPUsage(dspName As String, usagePercentage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecordMemoryUsage(moduleIdentifier As String, bytesUsed As UInt64)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private previousEx As String
	#tag EndProperty


#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Pressed()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events fmodTimer
	#tag Event
		Sub Action()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasTitleBar"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

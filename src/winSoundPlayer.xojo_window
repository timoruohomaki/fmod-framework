#tag DesktopWindow
Begin DesktopWindow winSoundPlayer
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
   Height          =   177
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
   Width           =   361
   Begin DesktopButton buttonPlay
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Play"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   48
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
      Top             =   109
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin DesktopButton buttonStop
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Stop"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   48
      Index           =   -2147483648
      Italic          =   False
      Left            =   152
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
      Top             =   109
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin Timer fmodTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   2
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin DesktopBevelButton bbPlayTone
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowTabStop    =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   1
      Bold            =   False
      ButtonStyle     =   1
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
   Begin DesktopBevelButton bbPlayFile
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowTabStop    =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   1
      Bold            =   False
      ButtonStyle     =   1
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
   Begin LevelMeterCanvas vuLeft
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   100
      Index           =   -2147483648
      Left            =   299
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   15
   End
   Begin LevelMeterCanvas vuRight
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   100
      Index           =   -2147483648
      Left            =   326
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   15
   End
   Begin DesktopLabel labelPlayPosition
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   284
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "00:00:00"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   67
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  // Clean up any audio resources
		  If mCurrentChannel <> Nil And mCurrentChannel.IsValid Then
		    mCurrentChannel.Stop()
		  End If
		  
		  // Stop oscillator if it's playing
		  If mOscillatorChannel <> Nil And mOscillatorChannel.IsValid Then
		    mOscillatorChannel.Stop()
		  End If
		  
		  // Shut down profiler if it's running
		  Try
		    App.ProfilerInstance.Instance.Shutdown()
		  Catch ex As RuntimeException
		    // Ignore errors during shutdown
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  // Initialize the audio profiler when the window opens
		  Try
		    var profiler As FMODAudioProfiler = App.ProfilerInstance
		    
		    If profiler <> Nil Then
		      // Set a faster update interval (100ms instead of default 1000ms)
		      profiler.SetCollectionInterval(100)
		      
		      // Initialize the profiler with level metering enabled
		      If profiler.Initialize() And profiler.InitializeLevelMetering() Then
		        System.DebugLog("Audio profiler initialized with level metering")
		      Else
		        System.DebugLog("Failed to initialize audio profiler with metering")
		      End If
		    End If
		  Catch ex As RuntimeException
		    System.DebugLog("Error: " + ex.Message)
		  End Try
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CreateOscillator(frequencyHz As Double = 1000.0) As Boolean
		  Try
		    // Get the FMOD system instance
		    var systemInstance As FMODSystem = FMODLibraryManager.GetSystemInstance()
		    If systemInstance = Nil Or Not systemInstance.IsInitialized Then
		      System.DebugLog("FMOD system not initialized")
		      Return False
		    End If
		    
		    // Create an oscillator DSP
		    var dspPtr As Ptr
		    var result As Integer = FMODLibraryManager.CreateDSPByType(systemInstance.SystemPtr, _
		    FMODStructures.FMOD_DSP_TYPE_OSCILLATOR, dspPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Or dspPtr = Nil Then
		      System.DebugLog("Failed to create oscillator DSP: " + FMODStructures.ResultToString(result))
		      Return False
		    End If
		    
		    // Store the DSP
		    mOscillatorDSP = dspPtr
		    
		    // Set the oscillator parameters (frequency, type, etc.)
		    // Note: In a complete implementation, we would add DSP parameter methods
		    // to FMODLibraryManager and use them here
		    
		    // Get the master channel group
		    var masterChannelGroupPtr As Ptr
		    result = FMODLibraryManager.GetMasterChannelGroup(systemInstance.SystemPtr, masterChannelGroupPtr)
		    
		    If result <> FMODStructures.FMOD_RESULT_OK Or masterChannelGroupPtr = Nil Then
		      System.DebugLog("Failed to get master channel group: " + FMODStructures.ResultToString(result))
		      Return False
		    End If
		    
		    // For testing purposes, we can create a simple sound and play it
		    // In a real implementation, we would properly connect the DSP to a channel
		    
		    // For testing visualization only:
		    // Simulate oscillator playing with visualization updates
		    vuLeft.UpdateLevel(0, 0.7)  // Set to a fixed level for testing
		    vuRight.UpdateLevel(0, 0.7)
		    
		    return True
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error creating oscillator: " + ex.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatTime(milliseconds as Integer) As String
		  // Format time in milliseconds to HH:MM:SS
		  var seconds As Integer = milliseconds \ 1000
		  var minutes As Integer = seconds \ 60
		  var hours As Integer = minutes \ 60
		  
		  seconds = seconds Mod 60
		  minutes = minutes Mod 60
		  
		  Return Format(hours, "00") + ":" + Format(minutes, "00") + ":" + Format(seconds, "00")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAverageCPUUsage() As Double
		  // Part of the IAudioProfiler interface.
		  
		  Return 0.0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPeakMemoryUsage() As UInt64
		  // Part of the IAudioProfiler interface.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProfileData() As Dictionary
		  // Part of the IAudioProfiler interface.
		  
		  Return Nil
		  
		  
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

	#tag Method, Flags = &h0
		Sub StopOscillator()
		  Try
		    // TODO: Implement clean DSP disposal
		    mOscillatorDSP = Nil
		    
		    // Update visualizations
		    vuLeft.UpdateLevel(0, 0)
		    vuRight.UpdateLevel(0, 0)
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error stopping oscillator: " + ex.Message)
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		mCurrentChannel As FMODChannel
	#tag EndProperty

	#tag Property, Flags = &h0
		mCurrentSound As FMODSound
	#tag EndProperty

	#tag Property, Flags = &h0
		mOscillatorChannel As FMODChannel
	#tag EndProperty

	#tag Property, Flags = &h0
		mOscillatorDSP As Ptr
	#tag EndProperty

	#tag Property, Flags = &h0
		previousEx As String
	#tag EndProperty


#tag EndWindowCode

#tag Events buttonPlay
	#tag Event
		Sub Pressed()
		  // Play Button
		  Try
		    If bbPlayTone.Value Then
		      // Create and play a tone (oscillator)
		      If mOscillatorDSP = Nil Then
		        // Create a new oscillator at 1kHz
		        If CreateOscillator(1000.0) Then
		          System.DebugLog("Started oscillator at 1kHz")
		        Else
		          System.DebugLog("Failed to start oscillator")
		        End If
		      Else
		        System.DebugLog("Oscillator is already playing")
		      End If
		    ElseIf bbPlayFile.Value Then
		      
		      // Play an audio file (using file dialog)
		      var dlg As New OpenDialog
		      dlg.Title = "Select Audio File"
		      dlg.Filter = "Audio Files:*.mp3;*.wav;*.ogg"
		      
		      
		      var soundFile As FolderItem = dlg.ShowModal()
		      
		      If soundFile <> Nil And soundFile.Exists Then
		        // Create and play the sound
		        var sound As FMODSound = New FMODSound(soundFile.NativePath)
		        If sound <> Nil Then
		          // Store the currently playing sound so we can stop it later
		          mCurrentSound = sound
		          mCurrentChannel = sound.Play(False)
		          
		          System.DebugLog("Playing audio file: " + soundFile.Name)
		        End If
		      End If
		    Else
		      System.DebugLog("Please select a sound source first")
		    End If
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error playing sound: " + ex.Message)
		    
		    // Only display message box if this is a new exception
		    If ex.Message <> previousEx Then
		      MessageBox("Error playing sound: " + ex.Message)
		      previousEx = ex.Message
		    End If
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events buttonStop
	#tag Event
		Sub Pressed()
		  // Stop Button
		  Try
		    // Check if we have a regular sound channel playing
		    If mCurrentChannel <> Nil And mCurrentChannel.IsValid Then
		      mCurrentChannel.Stop()
		      System.DebugLog("Playback stopped")
		    End If
		    
		    // Check if we have an oscillator playing
		    If mOscillatorDSP <> Nil Then
		      StopOscillator()
		      System.DebugLog("Oscillator stopped")
		    End If
		    
		    // Reset VU meters
		    vuLeft.UpdateLevel(0, 0)
		    vuRight.UpdateLevel(0, 0)
		    labelPlayPosition.Text = "00:00:00"
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error stopping sound: " + ex.Message)
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events fmodTimer
	#tag Event
		Sub Action()
		  Try
		    // Update FMOD
		    var systemInstance As FMODSystem = FMODLibraryManager.GetSystemInstance()
		    If systemInstance <> Nil And systemInstance.IsInitialized Then
		      
		      // Update FMOD system
		      do
		      loop until systemInstance.Update()
		      
		      // If there's a channel playing, update visualizations
		      If mCurrentChannel <> Nil And mCurrentChannel.IsValid Then
		        
		        // Get the metering info from the audio profiler
		        
		        If App.ProfilerInstance <> Nil And App.ProfilerInstance.IsMeteringEnabled Then
		          var peakLevels() As Single = App.ProfilerInstance.GetPeakLevels()
		          var rmsLevels() As Single = App.ProfilerInstance.GetRMSLevels()
		          var numChannels As Integer = App.ProfilerInstance.GetMeteringChannelCount()
		          
		          // The LevelMeterCanvas will update automatically through its interface
		          // since it's registered as a listener with the FMODAudioProfiler
		          
		          // The OnLevelUpdate method will be called automatically,
		          // but for VU meters that aren't getting updates through the profiler:
		          If peakLevels.Count >= 2 Then
		            vuLeft.UpdateLevel(0, peakLevels(0))
		            vuRight.UpdateLevel(0, peakLevels(1))
		          ElseIf peakLevels.Count = 1 Then
		            // Mono case
		            vuLeft.UpdateLevel(0, peakLevels(0))
		            vuRight.UpdateLevel(0, peakLevels(0))
		          End If
		          
		          // Update play position label
		          If mCurrentSound <> Nil And mCurrentChannel <> Nil Then
		            // Get current position from the channel
		            var currentPosition As Integer = mCurrentChannel.GetPosition()
		            labelPlayPosition.Text = FormatTime(currentPosition)
		          End If
		        End If
		        
		        // Also check if the sound is still playing
		        If Not mCurrentChannel.IsPlaying Then
		          // Sound has ended
		          vuLeft.UpdateLevel(0, 0)
		          vuRight.UpdateLevel(0, 0)
		          labelPlayPosition.Text = "00:00:00"
		        End If
		      Else
		        // No sound playing
		        vuLeft.UpdateLevel(0, 0)
		        vuRight.UpdateLevel(0, 0)
		        labelPlayPosition.Text = "00:00:00"
		      End If
		    End If
		    
		  Catch ex As RuntimeException
		    System.DebugLog("Error updating audio: " + ex.Message)
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events bbPlayTone
	#tag Event
		Sub Pressed()
		  bbPlayFile.Value = Not me.value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events bbPlayFile
	#tag Event
		Sub Pressed()
		  bbPlayTone.Value = Not me.Value
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
	#tag ViewProperty
		Name="previousEx"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

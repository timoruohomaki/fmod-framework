#tag Class
Protected Class LevelMeterCanvas
Inherits DesktopCanvas
Implements FMODAudioLevelMeterListener,FMODAudioProfilerListener
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  // Initialize the arrays
		  mPeakLevels = New Single()
		  mRMSLevels = New Single()
		  mPeakHold = New Single()
		  mPeakHoldTime = New Integer()
		  
		  // Register with the profiler
		  If FMODAudioProfiler.Instance <> Nil Then
		    FMODAudioProfiler.Instance.AddListener(Self)
		  Else
		    System.DebugLog("FMODAudioProfiler instance not available")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Destructor()
		  // Unregister from the profiler
		  If FMODAudioProfiler.Instance <> Nil Then
		    FMODAudioProfiler.Instance.RemoveListener(Self)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EndTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetAverageCPUUsage() As Double
		  // Part of the IAudioProfiler interface.
		  
		  Return 0
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetPeakMemoryUsage() As UInt64
		  // Part of the IAudioProfiler interface.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetProfileData() As Dictionary
		  // Part of the IAudioProfiler interface.
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OnLevelUpdate(peakLevels() as Single, rmsLevels() as Single, numChannels as Integer)
		  // Part of the FMODAudioLevelMeterListener interface.
		  
		  // Update our local copies of the levels
		  mNumChannels = numChannels
		  
		  // Resize arrays if needed
		  If mPeakLevels.Count <> peakLevels.Count Then
		    mPeakLevels.ResizeTo(peakLevels.LastIndex)
		    mRMSLevels.ResizeTo(rmsLevels.LastIndex)
		    mPeakHold.ResizeTo(peakLevels.LastIndex)
		    mPeakHoldTime.ResizeTo(peakLevels.LastIndex)
		    
		    // Initialize peak hold values
		    For i As Integer = 0 To mPeakHold.LastIndex
		      mPeakHold(i) = 0
		      mPeakHoldTime(i) = 0
		    Next
		    
		  End If
		  
		  // Apply visual decay for smoother meter movement
		  For i As Integer = 0 To Min(peakLevels.LastIndex, mPeakLevels.LastIndex)
		    // If new peak is higher, take it immediately
		    If peakLevels(i) > mPeakLevels(i) Then
		      mPeakLevels(i) = peakLevels(i)
		    Else
		      // Otherwise, decay slowly
		      mPeakLevels(i) = Max(peakLevels(i), mPeakLevels(i) - mDecayRate)
		    End If
		    
		    // Same for RMS
		    If rmsLevels(i) > mRMSLevels(i) Then
		      mRMSLevels(i) = rmsLevels(i)
		    Else
		      mRMSLevels(i) = Max(rmsLevels(i), mRMSLevels(i) - mDecayRate)
		    End If
		    
		    // Update peak hold
		    If peakLevels(i) >= mPeakHold(i) Then
		      mPeakHold(i) = peakLevels(i)
		      mPeakHoldTime(i) = mPeakHoldDuration
		    Else
		      // Decrement the hold time
		      If mPeakHoldTime(i) > 0 Then
		        mPeakHoldTime(i) = mPeakHoldTime(i) - 1
		      Else
		        // Slowly drop the peak hold
		        mPeakHold(i) = Max(0, mPeakHold(i) - mDecayRate * 0.5)
		      End If
		    End If
		  Next
		  
		  // Invalidate the canvas to trigger a redraw
		  Invalidate(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OnProfilerUpdate(Profiler as FMODAudioProfiler)
		  // Part of the FMODAudioProfilerListener interface.
		  
		  // Nothing to do here - we get our updates through OnLevelUpdate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  // Draw the level meter
		  // This is where the visualization will be drawn
		  
		  // Clear the background
		  g.DrawingColor = mBackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Calculate dimensions
		  var barWidth As Integer = Min(mBarWidth, (g.Width - (mNumChannels * mBarSpacing)) / Max(1, mNumChannels))
		  var meterHeight As Integer = g.Height - 20  // Leave room for labels
		  
		  // Draw each channel meter
		  For i As Integer = 0 To mNumChannels - 1
		    If i > mPeakLevels.LastIndex Then
		      Exit // Safety check
		    End If
		    
		    // Calculate positions
		    var x As Integer = i * (barWidth + mBarSpacing) + mBarSpacing
		    var y As Integer = 10
		    
		    // Draw background meter frame
		    g.DrawingColor = &c333333
		    g.FillRectangle(x, y, barWidth, meterHeight)
		    
		    // Convert level to pixel height
		    var peakLevelHeight As Integer = Round(mPeakLevels(i) * meterHeight)
		    var rmsLevelHeight As Integer = Round(mRMSLevels(i) * meterHeight)
		    
		    // Draw RMS level (main bar)
		    If rmsLevelHeight > 0 Then
		      // Gradient coloring based on level
		      var levelRatio As Double = mRMSLevels(i)
		      var barColor As Color
		      
		      If levelRatio > 0.8 Then
		        barColor = mRedColor
		      ElseIf levelRatio > 0.6 Then
		        barColor = mYellowColor
		      Else
		        barColor = mGreenColor
		      End If
		      
		      g.DrawingColor = barColor
		      g.FillRectangle(x, y + meterHeight - rmsLevelHeight, barWidth, rmsLevelHeight)
		    End If
		    
		    // Draw peak hold line
		    If mPeakHold(i) > 0 Then
		      var peakHoldY As Integer = y + meterHeight - Round(mPeakHold(i) * meterHeight)
		      g.DrawingColor = mPeakColor
		      g.FillRectangle(x, peakHoldY, barWidth, 2)
		    End If
		    
		    // Draw level markings
		    g.DrawingColor = &c666666
		    g.DrawLine(x, y + meterHeight * 0.2, x + barWidth, y + meterHeight * 0.2) // -14dB
		    g.DrawLine(x, y + meterHeight * 0.4, x + barWidth, y + meterHeight * 0.4) // -8dB
		    g.DrawLine(x, y + meterHeight * 0.8, x + barWidth, y + meterHeight * 0.8) // -2dB
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecordBufferStats(bufferSize As UInt32, bufferUsage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecordChannelUsage(activeChannels As UInt32, totalChannels As UInt32)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecordCPUUsage(moduleIdentifier As String, usagePercentage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecordDSPUsage(dspName As String, usagePercentage As Double)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecordMemoryUsage(moduleIdentifier As String, bytesUsed As UInt64)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StartTiming(operationName As String)
		  // Part of the IAudioProfiler interface.
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBackgroundColor As Color = &c121212
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBarSpacing As Integer = 5
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBarWidth As Integer = 15
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecayRate As Single = 0.05
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGreenColor As Color = &c00e676
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMeterHeight As Integer = 100
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumChannels As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPeakColor As Color = &ce0e0e0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPeakHold() As Single
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPeakHoldDuration As Integer = 30
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPeakHoldTime() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPeakLevels() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRedColor As Color = &cff144
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRMSLevels() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mYellowColor As Color = &cffeb3b
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
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

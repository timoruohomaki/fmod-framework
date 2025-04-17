#tag Class
Protected Class FMODLogger
	#tag Method, Flags = &h21
		Private Sub LogError(message as String)
		  // In a real implementation, you might log to a file or database or use proper Windows event logging mechanism
		  
		  System.DebugLog("FMOD Error: " + message)
		  
		  #If DebugBuild Then
		    System.Log(System.LogLevelError, "FMOD Error: " + message)
		  #EndIf
		End Sub
	#tag EndMethod


End Class
#tag EndClass

#tag Class
Protected Class FMODLogger
	#tag Method, Flags = &h0
		Sub LogError(message as String)
		  // In a real implementation, you might log to a file or database
		  
		  System.DebugLog("FMOD Error: " + message)
		  
		  #If DebugBuild Then
		    System.Log(System.LogLevelError, "FMOD Error: " + message)
		  #EndIf
		End Sub
	#tag EndMethod


End Class
#tag EndClass

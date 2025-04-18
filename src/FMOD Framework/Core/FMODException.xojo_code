#tag Class
Protected Class FMODException
Inherits RuntimeException
	#tag Method, Flags = &h0
		Sub Constructor(result as Integer)
		  // Use FMODStructures for the result code constants
		  Self.Message = "FMOD Error: " + ResultToString(result)
		  
		  // Log the error to the system log
		  System.DebugLog(Self.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(message as string)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  Self.Message = message
		  
		  // Log the error to the system log
		  // Use System.DebugLog directly instead of going through FMODSystem
		  System.DebugLog("FMOD Error: " + message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultToString(result as Integer) As String
		  Select Case result
		  Case FMODStructures.FMOD_RESULT_OK
		    Return "OK"
		  Case FMODStructures.FMOD_ERR_BADCOMMAND
		    Return "Bad Command"
		  Case FMODStructures.FMOD_ERR_CHANNEL_ALLOC
		    Return "Channel Allocation Error"
		  Case FMODStructures.FMOD_ERR_CHANNEL_STOLEN
		    Return "Channel Stolen"
		  Case FMODStructures.FMOD_ERR_DMA
		    Return "DMA Error"
		  Case FMODStructures.FMOD_ERR_DSP_CONNECTION
		    Return "DSP Connection Error"
		  Case FMODStructures.FMOD_ERR_DSP_DONTPROCESS
		    Return "DSP Don't Process"
		  Case FMODStructures.FMOD_ERR_DSP_FORMAT
		    Return "DSP Format Error"
		  Case FMODStructures.FMOD_ERR_DSP_INUSE
		    Return "DSP In Use"
		  Case FMODStructures.FMOD_ERR_DSP_NOTFOUND
		    Return "DSP Not Found"
		  Case FMODStructures.FMOD_ERR_DSP_RESERVED
		    Return "DSP Reserved"
		  Case FMODStructures.FMOD_ERR_DSP_SILENCE
		    Return "DSP Silence"
		  Case FMODStructures.FMOD_ERR_DSP_TYPE
		    Return "DSP Type Error"
		  Case FMODStructures.FMOD_ERR_FILE_BAD
		    Return "Bad File"
		  Case FMODStructures.FMOD_ERR_FILE_COULDNOTSEEK
		    Return "Could Not Seek File"
		  Case FMODStructures.FMOD_ERR_FILE_DISKEJECTED
		    Return "Disk Ejected"
		  Case FMODStructures.FMOD_ERR_FILE_EOF
		    Return "End of File"
		  Case FMODStructures.FMOD_ERR_FILE_ENDOFDATA
		    Return "End of Data"
		  Case FMODStructures.FMOD_ERR_FILE_NOTFOUND
		    Return "File Not Found"
		    // Add more result codes as needed
		  Else
		    Return "Unknown Error (" + result.ToString + ")"
		  End Select
		End Function
	#tag EndMethod


End Class
#tag EndClass

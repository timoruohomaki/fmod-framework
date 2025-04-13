#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				  macOSEntitlements={"App Sandbox":"False","Hardened Runtime":"False","Notarize":"False","UserEntitlements":""}
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyFMODlib
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vLi4vLi4vLi4vUHJvZ3JhbSUyMEZpbGVzJTIwJTI4eDg2JTI5L0ZNT0QlMjBTb3VuZFN5c3RlbS9GTU9EJTIwU3R1ZGlvJTIwQVBJJTIwV2luZG93cy9hcGkvY29yZS9saWIveDY0L2Ztb2QuZGxs
				End
			End
#tag EndBuildAutomation

<img src="res/FMODLogoBlack.png" width="240">

# FMOD Tone Generator for Xojo

This project implements a tone generator in Xojo using the FMOD Core API. It allows you to generate and play different waveforms (sine, square, saw, triangle) at various frequencies and volumes.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Implementation Details](#implementation-details)
- [API Reference](#api-reference)
- [Usage Examples](#usage-examples)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

The FMOD Tone Generator provides a Xojo wrapper around the FMOD Core API for generating audio tones. It allows you to:

- Play sine, square, saw, and triangle waveforms
- Adjust frequency in real-time
- Control volume
- Manage audio resources properly

This implementation is based on the FMOD example `generate_tone.cpp` and has been adapted for Xojo using declares to interface with the native FMOD library. The FMOD Core API library, part of the FMOD Engine, is available for download for registered users at [FMOD Website](https://www.fmod.com/). While the license is commercial, free indie license is granted to developers with registered projects with less than $200k revenue per year, on a small (under $600k) development budget (as in April 2025).

## Project Structure

The project consists of the following main components:

1. **FMODApi Module** - Contains all declares, constants, and helper functions for interfacing with the FMOD library
2. **FMODToneGenerator Class** - Provides a high-level interface for generating tones
3. **Window UI** - A simple user interface for controlling the tone generator

### File Structure

```
FMODToneGenerator/
├── FMODApi.xojo_module
├── FMODToneGenerator.xojo_class
├── Window1.xojo_window
└── App.xojo_code
```

## Implementation Details

### Library Loading

The project uses `DeclareLibraryMBS` and `DeclareFunctionMBS` from the MBS Xojo Plugins to dynamically load the FMOD library at runtime:

```xojo
// In FMODApi module
Private mFMODLibrary As DeclareLibraryMBS
Private mFMOD_System_Create As DeclareFunctionMBS
// ...other function declares

Public Function InitializeFMODDeclares() As Boolean
  If mInitialized Then Return True
  
  // Determine the library name based on platform
  Dim libraryName As String
  #If TargetWindows Then
    libraryName = "fmod.dll"
  #ElseIf TargetMacOS Then
    libraryName = "libfmod.dylib"
  #ElseIf TargetLinux Then
    libraryName = "libfmod.so"
  #EndIf
  
  // Load the library
  mFMODLibrary = New DeclareLibraryMBS(libraryName)
  If mFMODLibrary = Nil Or Not mFMODLibrary.Available Then
    System.DebugLog("Failed to load FMOD library: " + libraryName)
    Return False
  End If
  
  // Get function symbols and create function declares
  Dim p As Ptr = mFMODLibrary.Symbol("FMOD_System_Create")
  If p = Nil Then
    System.DebugLog("Failed to find FMOD_System_Create symbol")
    Return False
  End If
  mFMOD_System_Create = New DeclareFunctionMBS("(pi)i", p)
  
  // ...load other functions similarly
  
  mInitialized = True
  Return True
End Function
```

### Tone Generation

The tone generation happens through the FMOD DSP system. The `FMODToneGenerator` class creates an oscillator DSP unit and connects it to a channel:

```xojo
// In FMODToneGenerator.PlayTone
Public Sub PlayTone(oscillatorType As Integer, volume As Single)
  If Not mInitialized Then Initialize()
  
  Try
    Dim result As Integer
    
    // Stop any existing channel
    If mChannel.Ptr <> Nil Then
      result = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
      FMODApi.ERRCHECK(result)
    End If
    
    // Play the DSP
    result = FMODApi.FMOD_System_PlayDSP(mSystem.Ptr, mDSP.Ptr, Nil, True, mChannel)
    FMODApi.ERRCHECK(result)
    
    // Set the volume
    result = FMODApi.FMOD_Channel_SetVolume(mChannel.Ptr, volume)
    FMODApi.ERRCHECK(result)
    
    // Set the oscillator type
    result = FMODApi.FMOD_DSP_SetParameterInt(mDSP.Ptr, FMODApi.FMOD_DSP_OSCILLATOR_TYPE, oscillatorType)
    FMODApi.ERRCHECK(result)
    
    // Start playing
    result = FMODApi.FMOD_Channel_SetPaused(mChannel.Ptr, False)
    FMODApi.ERRCHECK(result)
    
    // Update the system
    result = FMODApi.FMOD_System_Update(mSystem.Ptr)
    FMODApi.ERRCHECK(result)
  Catch ex As RuntimeException
    System.DebugLog("Error playing tone: " + ex.Message)
    Raise ex
  End Try
End Sub
```

### Resource Management

The `FMODToneGenerator` class handles resource cleanup in its `Cleanup` method:

```xojo
Public Sub Cleanup()
  If Not mInitialized Then Return
  
  Try
    // Stop any existing channel
    If mChannel.Ptr <> Nil Then
      Dim result As Integer = FMODApi.FMOD_Channel_Stop(mChannel.Ptr)
      FMODApi.ERRCHECK(result)
      mChannel.Ptr = Nil
    End If
    
    // Release DSP
    If mDSP.Ptr <> Nil Then
      Dim result As Integer = FMODApi.FMOD_DSP_Release(mDSP.Ptr)
      FMODApi.ERRCHECK(result)
      mDSP.Ptr = Nil
    End If
    
    // Close and release system
    If mSystem.Ptr <> Nil Then
      Dim result As Integer = FMODApi.FMOD_System_Close(mSystem.Ptr)
      FMODApi.ERRCHECK(result)
      
      result = FMODApi.FMOD_System_Release(mSystem.Ptr)
      FMODApi.ERRCHECK(result)
      mSystem.Ptr = Nil
    End If
    
    mInitialized = False
  Catch ex As RuntimeException
    System.DebugLog("Error cleaning up FMOD: " + ex.Message)
    Raise ex
  End Try
End Sub
```

## API Reference

### FMODApi Module

#### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `FMOD_OK` | 0 | Success code |
| `FMOD_INIT_NORMAL` | &h00000000 | Normal initialization |
| `FMOD_DSP_TYPE_OSCILLATOR` | 8 | Oscillator DSP type |
| `FMOD_DSP_OSCILLATOR_TYPE` | 0 | Parameter index for oscillator type |
| `FMOD_DSP_OSCILLATOR_RATE` | 1 | Parameter index for oscillator rate |
| `OSCILLATOR_SINE` | 0 | Sine wave |
| `OSCILLATOR_SQUARE` | 1 | Square wave |
| `OSCILLATOR_SAWUP` | 2 | Saw wave |
| `OSCILLATOR_TRIANGLE` | 4 | Triangle wave |

#### Methods

| Method | Description |
|--------|-------------|
| `InitializeFMODDeclares() As Boolean` | Initializes all FMOD function declares |
| `FMOD_System_Create(ByRef systemObj As FMODSystem, version As UInt32) As Integer` | Creates an FMOD system object |
| `FMOD_System_Init(systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer` | Initializes the FMOD system |
| `FMOD_System_Close(systemPtr As Ptr) As Integer` | Closes the FMOD system |
| `FMOD_System_Release(systemPtr As Ptr) As Integer` | Releases the FMOD system |
| `FMOD_System_Update(systemPtr As Ptr) As Integer` | Updates the FMOD system |
| `FMOD_System_CreateDSPByType(systemPtr As Ptr, dspType As Integer, ByRef dsp As FMODDSP) As Integer` | Creates a DSP unit |
| `FMOD_DSP_SetParameterFloat(dspPtr As Ptr, index As Integer, value As Single) As Integer` | Sets a float parameter on a DSP |
| `FMOD_DSP_SetParameterInt(dspPtr As Ptr, index As Integer, value As Integer) As Integer` | Sets an integer parameter on a DSP |
| `FMOD_DSP_Release(dspPtr As Ptr) As Integer` | Releases a DSP unit |
| `FMOD_System_PlayDSP(systemPtr As Ptr, dsp As Ptr, channelGroup As Ptr, paused As Boolean, ByRef channel As FMODChannel) As Integer` | Plays a DSP on a channel |
| `FMOD_Channel_SetVolume(channel As Ptr, volume As Single) As Integer` | Sets channel volume |
| `FMOD_Channel_SetFrequency(channel As Ptr, frequency As Single) As Integer` | Sets channel frequency |
| `FMOD_Channel_GetVolume(channel As Ptr, ByRef volume As Single) As Integer` | Gets channel volume |
| `FMOD_Channel_GetFrequency(channel As Ptr, ByRef frequency As Single) As Integer` | Gets channel frequency |
| `FMOD_Channel_SetPaused(channel As Ptr, paused As Boolean) As Integer` | Sets channel paused state |
| `FMOD_Channel_Stop(channel As Ptr) As Integer` | Stops a channel |
| `FMOD_Channel_IsPlaying(channel As Ptr, ByRef isPlaying As Boolean) As Integer` | Checks if a channel is playing |
| `ERRCHECK(result As Integer)` | Checks for FMOD errors |
| `GetErrorString(result As Integer) As String` | Converts error codes to strings |

### FMODToneGenerator Class

#### Methods

| Method | Description |
|--------|-------------|
| `Initialize()` | Initializes the FMOD system and DSP |
| `PlayTone(oscillatorType As Integer, volume As Single)` | Plays a tone with the specified waveform and volume |
| `StopTone()` | Stops the currently playing tone |
| `SetFrequency(frequency As Single)` | Sets the frequency of the current tone |
| `SetVolume(volume As Single)` | Sets the volume of the current tone |
| `GetVolume() As Single` | Gets the current volume |
| `GetFrequency() As Single` | Gets the current frequency |
| `IsPlaying() As Boolean` | Checks if a tone is currently playing |
| `Update()` | Updates the FMOD system (call periodically) |
| `Cleanup()` | Cleans up all FMOD resources |

## Usage Examples

### Basic Usage

```xojo
// Create and initialize the tone generator
Dim toneGenerator As New FMODToneGenerator
toneGenerator.Initialize()

// Play a sine wave at 440Hz with 50% volume
toneGenerator.PlayTone(FMODApi.OSCILLATOR_SINE, 0.5)
toneGenerator.SetFrequency(440.0)

// Later, stop the tone
toneGenerator.StopTone()

// Clean up when done
toneGenerator.Cleanup()
```

### Window with Buttons

```xojo
// In a Window class
Private toneGenerator As FMODToneGenerator
Private updateTimer As Timer

Sub Open()
  // Initialize the tone generator
  toneGenerator = New FMODToneGenerator
  
  Try
    toneGenerator.Initialize()
  Catch ex As RuntimeException
    MessageBox("Error initializing FMOD: " + ex.Message)
  End Try
  
  // Create update timer
  updateTimer = New Timer
  updateTimer.Period = 50
  updateTimer.Mode = Timer.ModeMultiple
  AddHandler updateTimer.Action, AddressOf UpdateTimerAction
  updateTimer.Enabled = True
End Sub

Private Sub UpdateTimerAction()
  If toneGenerator <> Nil Then
    Try
      toneGenerator.Update()
    Catch ex As RuntimeException
      // Handle errors
    End Try
  End If
End Sub

Sub SineButtonAction()
  Try
    toneGenerator.PlayTone(FMODApi.OSCILLATOR_SINE, 0.5)
    toneGenerator.SetFrequency(440.0)
  Catch ex As RuntimeException
    MessageBox("Error playing tone: " + ex.Message)
  End Try
End Sub

Sub StopButtonAction()
  Try
    toneGenerator.StopTone()
  Catch ex As RuntimeException
    MessageBox("Error stopping tone: " + ex.Message)
  End Try
End Sub

Sub Close()
  // Clean up
  If updateTimer <> Nil Then
    updateTimer.Enabled = False
    RemoveHandler updateTimer.Action, AddressOf UpdateTimerAction
  End If
  
  If toneGenerator <> Nil Then
    toneGenerator.Cleanup()
  End If
End Sub
```

## Troubleshooting

### Common Issues

#### "Library not found" error

Ensure that the FMOD library is in the correct location:

- **Windows**: Place fmod.dll in the same directory as your application or in a system path
- **macOS**: Place libfmod.dylib in /usr/local/lib or bundle it with your application
- **Linux**: Place libfmod.so in a standard library path

#### "Function not found" error

Make sure you're using the correct FMOD version that matches your declares. The function names and parameters should match exactly.

#### No sound output

1. Check if the system volume is unmuted
2. Verify that FMOD is properly initialized
3. Ensure that the channel volume is set to a non-zero value
4. Call `Update()` regularly to keep the audio system processing

#### Application crashes

1. Use Soft Declares or the MBS plugin approach to avoid hard crashes
2. Implement proper error checking with `ERRCHECK`
3. Always clean up resources in the `Close` event

### Using MBS Plugins for Robust Declares

The MBS Plugins provide a more robust way to handle external library functions. Here's how to use them correctly:

```xojo
// First load the library
Dim fmodLibrary As New DeclareLibraryMBS("fmod.dll") // Adjust path for platform

// Get a symbol from the library
Dim symbolPtr As Ptr = fmodLibrary.Symbol("FMOD_System_Create")

// Create a function declare with the correct signature
// Format: (parameter types)return type
// i = integer, p = pointer, f = float, b = boolean
Dim createFunc As New DeclareFunctionMBS("(pi)i", symbolPtr)

// Call the function
Dim systemPtrMB As New MemoryBlock(4)
Dim result As Integer = createFunc.Invoke(systemPtrMB, &h00010000)
```

## License

This project uses the FMOD Core API by by Firelight Technologies Pty Ltd., which requires proper licensing for use in commercial applications. Please refer to the [FMOD licensing page](https://www.fmod.com/licensing) for details.

Christian Schmitz Software GmbH, of Nickenich Germany is the owner, developer and sole copyright holder of the MBS Plugins product, which is licensed -not sold- to developer on a non-exclusive basis. [MBS Plugins Licensing](https://www.monkeybreadsoftware.de/xojo/license.shtml)

The Xojo wrapper code itself is provided under the MIT License.

---

*Note: This documentation is based on the FMOD Core API version used in the original example code. Make sure to use the appropriate FMOD version and adjust the code if necessary.*


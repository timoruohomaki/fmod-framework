<img src="res/FMODLogoBlack.png" width="240">

# FMOD Tone Generator for Xojo

> [!NOTE]
> This project is still work in progress, this comment will be removed when it works.

This project implements a tone generator in Xojo using the FMOD Core API. It allows you to generate and play different waveforms (sine, square, saw, triangle) at various frequencies and volumes.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Implementation Details](#implementation-details)
- [API Reference](#api-reference)
- [Usage Examples](#usage-examples)
- [Installation](#installation)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

The FMOD Tone Generator provides a Xojo wrapper around the FMOD Core API for generating audio tones. It includes two distinct implementations:

1. **DSP-based approach**: Uses FMOD's DSP oscillator to generate tones in real-time.
2. **Sound-based approach**: Uses pre-generated waveform sound files.

Both implementations allow you to:
- Play sine, square, saw, and triangle waveforms
- Adjust frequency in real-time
- Control volume
- Manage audio resources properly

## Project Structure

The project consists of the following main components:

```
FMODToneGenerator/
├── FMODApi.xojo_module                  // Shared FMOD API declarations
├── FMODToneGeneratorDSP.xojo_class      // DSP-based implementation
├── FMODToneGeneratorSound.xojo_class    // Sound file-based implementation 
├── Window1.xojo_window                  // UI with options to switch between implementations
└── App.xojo_code                        // Application entry point
```

### Components

1. **FMODApi Module**: Contains all declares, constants, and utility functions for interacting with the FMOD library.
2. **FMODToneGeneratorDSP Class**: Wraps the FMOD DSP oscillator functionality.
3. **FMODToneGeneratorSound Class**: Implements tone generation using pre-generated waveform files.
4. **Window1**: Provides a user interface for controlling the tone generator.

## Implementation Details

### FMODApi Module

The FMODApi module uses the MBS Xojo Plugins' `DeclareLibraryMBS` and `DeclareFunctionMBS` classes to dynamically load the FMOD library functions. This approach provides better error handling and cross-platform compatibility compared to traditional Xojo declares.

```xojo
// Example of function declaration using MBS
Public Function FMOD_System_Init(systemPtr As Ptr, maxChannels As Integer, flags As UInt32, extraDriverData As Ptr) As Integer
  If Not mInitialized Then
    If Not InitializeFMODDeclares() Then
      System.Log(System.LogLevelError, "FMOD declares not initialized")
      Return -1
    End If
  End If
  
  Try
    Dim params() As Variant
    params.Append(systemPtr)
    params.Append(maxChannels)
    params.Append(flags)
    params.Append(extraDriverData)
    
    Return mFMOD_System_Init.Invoke(params)
  Catch ex As RuntimeException
    System.Log(System.LogLevelError, "FMOD_System_Init error: " + ex.Message)
    Return -1
  End Try
End Function
```

### DSP-Based Implementation

The DSP-based implementation uses FMOD's built-in oscillator DSP effect to generate tones in real-time. It provides three different approaches for setting DSP parameters to work around potential issues with specific FMOD versions:

1. **Standard approach**: Creates a new DSP, sets parameters, then plays it.
2. **Alternative approach 1**: Plays the DSP paused, sets parameters, then unpauses it.
3. **Alternative approach 2**: Uses a more complex sequence involving playing and stopping before setting parameters.

```xojo
// Example of setting DSP parameters
result = FMODApi.FMOD_DSP_SetParameterInt(mDSP.Ptr, FMODApi.FMOD_DSP_OSCILLATOR_TYPE, oscillatorType)
result = FMODApi.FMOD_DSP_SetParameterFloat(mDSP.Ptr, FMODApi.FMOD_DSP_OSCILLATOR_RATE, 440.0)
```

### Sound-Based Implementation

The sound-based implementation uses pre-generated waveform files (sine.wav, square.wav, etc.) and plays them with frequency adjustment. This approach avoids issues with DSP parameter setting.

```xojo
// Example of selecting and playing a waveform sound
Dim soundToPlay As FMODApi.FMODSound
Select Case oscillatorType
Case FMODApi.OSCILLATOR_SINE
  soundToPlay = mSineWaveSound
Case FMODApi.OSCILLATOR_SQUARE
  soundToPlay = mSquareWaveSound
// ...other cases
End Select

result = FMODApi.FMOD_System_PlaySound(mSystem.Ptr, soundToPlay.Ptr, Nil, True, mChannel)
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
| `FMOD_LOOP_NORMAL` | &h00000001 | Normal loop mode for sounds |

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
| `FMOD_System_CreateSound(systemPtr As Ptr, filename As String, flags As UInt32, info As Ptr, ByRef sound As FMODSound) As Integer` | Creates a sound from a file |
| `FMOD_System_PlaySound(systemPtr As Ptr, sound As Ptr, channelGroup As Ptr, paused As Boolean, ByRef channel As FMODChannel) As Integer` | Plays a sound |
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

### FMODToneGeneratorDSP Class

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
| Property `DSPParamSettingOrder As Integer` | Controls which parameter setting approach to use |

### FMODToneGeneratorSound Class

| Method | Description |
|--------|-------------|
| `Initialize()` | Initializes the FMOD system and loads sound files |
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
// Using the DSP-based tone generator
Dim toneGenerator As New FMODToneGeneratorDSP
toneGenerator.Initialize()

// Play a sine wave at 440Hz with 50% volume
toneGenerator.PlayTone(FMODApi.OSCILLATOR_SINE, 0.5)

// Later, stop the tone
toneGenerator.StopTone()

// Clean up when done
toneGenerator.Cleanup()
```

### Window with UI Controls

```xojo
// In a Window class
Private toneGenerator As FMODToneGeneratorDSP
Private updateTimer As Timer

Sub Open()
  // Initialize the tone generator
  toneGenerator = New FMODToneGeneratorDSP
  
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
    toneGenerator.PlayTone(FMODApi.OSCILLATOR_SINE, volumeSlider.Value / 100.0)
  Catch ex As RuntimeException
    MessageBox("Error playing tone: " + ex.Message)
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

## Installation

### Requirements

1. **Xojo**: This project requires Xojo 2019r1 or newer.
2. **MBS Xojo Plugins**: The project uses MBS Plugins (specifically the DeclareLibraryMBS and DeclareFunctionMBS classes).
3. **FMOD Core API**: Version 2.03.07 or compatible.

### Setup Steps

1. **Install FMOD Library**:
   - Download FMOD Core API from [FMOD.com](https://www.fmod.com/download) (requires registration)
   - Install the FMOD library for your platform:
     - Windows: Place `fmod.dll` in your application directory
     - macOS: Place `libfmod.dylib` in `/usr/local/lib` or bundle with your application
     - Linux: Place `libfmod.so` in a standard library path

2. **Sound Files** (for sound-based implementation):
   - Create or obtain single-cycle waveform audio files:
     - sine.wav
     - square.wav
     - saw.wav
     - triangle.wav
   - Place these files in your application directory

3. **Project Setup**:
   - Import the project files into Xojo
   - Ensure MBS Plugins are added to your project
   - Verify the library paths in the code match your FMOD installation

## Troubleshooting

### Common Issues

#### "Library not found" error

Ensure that the FMOD library is in the correct location:

- **Windows**: `fmod.dll` should be in the same directory as your application
- **macOS**: `libfmod.dylib` should be in `/usr/local/lib` or bundled with your application
- **Linux**: `libfmod.so` should be in a standard library path

#### "Record busy" or "Event not playing" errors

These errors can occur with certain FMOD versions when setting DSP parameters. Try:

1. Changing the `DSPParamSettingOrder` property to use a different approach
2. Switching to the sound-based implementation
3. Using a different version of the FMOD library

#### No sound output

1. Check if the system volume is unmuted
2. Verify that FMOD is properly initialized
3. Ensure that the channel volume is set to a non-zero value
4. Call `Update()` regularly to keep the audio system processing

#### Sound files not found

For the sound-based implementation, ensure the waveform files are in the correct location:

- Place the `.wav` files in the same directory as your application
- Verify the filenames match exactly what's in the code

## License

This project uses the FMOD Core API by by Firelight Technologies Pty Ltd., which requires proper licensing for use in commercial applications. Please refer to the [FMOD licensing page](https://www.fmod.com/licensing) for details. The FMOD Core API library, part of the FMOD Engine, is available for download for registered users at [FMOD Website](https://www.fmod.com/). While the license is commercial, free indie license is granted to developers with registered projects with less than $200k revenue per year, on a small (under $600k) development budget (as in April 2025).

Christian Schmitz Software GmbH, of Nickenich Germany is the owner, developer and sole copyright holder of the MBS Plugins product, which is licensed -not sold- to developer on a non-exclusive basis. [MBS Plugins Licensing](https://www.monkeybreadsoftware.de/xojo/license.shtml)

The Xojo wrapper code itself is provided under the MIT License.

---

*Note: This documentation is based on the FMOD Core API version used in the original example code. Make sure to use the appropriate FMOD version and adjust the code if necessary.*


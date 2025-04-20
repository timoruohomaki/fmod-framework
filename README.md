<img src="res/FMODLogoBlack.png" width="240">

# FMOD Sound Subsystem for Xojo

> [!NOTE]
> This project is still work in progress, this comment will be removed when it works.

A comprehensive framework for integrating FMOD audio capabilities into Xojo applications, providing both file-based audio playback and DSP-based tone generation with real-time level metering.

## Overview

This framework offers a clean, modular approach to working with FMOD in Xojo, simplifying audio playback and tone generation across multiple platforms. The framework is built with MBS plugins to provide dynamic library loading, eliminating issues with reserved words and improving cross-platform compatibility.

## Features

- Loading and playing various audio file formats using SoundFileMBS
- Generating tones using FMOD's DSP oscillators
- Real-time audio level metering and visualization
- Performance monitoring including CPU and memory usage
- Cross-platform compatibility with proper error handling
- Dynamic library loading with MBS plugins

## Requirements

- Xojo 2021r2.1 or later
- FMOD Sound System (www.fmod.com)
- MBS Xojo Plugins (specifically the DeclareLibraryMBS, DeclareFunctionMBS and SoundFileMBS components)

## Project Structure

```
FMOD Framework/
│
├── Core/
│   ├── FMODLibraryManager.xojo_module    # Dynamic library loading and function access
│   ├── FMODStructures.xojo_module        # FMOD structures, constants, and utilities
│   ├── FMODSystem.xojo_code              # Main FMOD system management
│   ├── FMODException.xojo_code           # Exception handling for FMOD errors
│   └── FMODLogger.xojo_code              # Logging utilities
│
├── Sound/
│   ├── FMODSound.xojo_code               # Base sound class
│   ├── FMODChannel.xojo_code             # Channel management
│   ├── FMODToneGeneratorSound.xojo_code  # File-based tone generation (using SoundFileMBS)
│   └── FMODToneGeneratorDSP.xojo_code    # DSP-based tone generation (oscillators)
│
└── Profiling/
    ├── FMODAudioProfiler.xojo_code       # Performance and level monitoring
    ├── FMODAudioProfilerListener.xojo_interface    # Base listener interface
    ├── FMODAudioLevelMeterListener.xojo_interface  # Level meter listener interface
    └── LevelMeterCanvas.xojo_code         # Visual level meter component
```

## Key Components

### FMODLibraryManager (Module)

The `FMODLibraryManager` module handles dynamic loading of FMOD functions using MBS plugins. This approach provides several advantages:

- No conflicts with reserved words like "system"
- Better error handling for missing libraries or functions
- Platform-specific library paths handled internally
- Functions are lazily loaded only when needed

### FMODStructures (Module)

The `FMODStructures` module contains all FMOD-related structures, constants, and utilities:

- Structure definitions (FMOD_CREATESOUNDEXINFO, FMOD_CPU_USAGE, etc.)
- Constant definitions (FMOD_RESULT_OK, FMOD_MODE_DEFAULT, etc.)
- Utility methods for converting between structures and memory blocks

### FMODSystem

The `FMODSystem` class manages the FMOD system instance, handling initialization, shutdown, and system-level operations.

### FMODSound and Derived Classes

- **FMODSound**: Base class for all sound resources
- **FMODToneGeneratorSound**: Sound playback from file using SoundFileMBS
- **FMODToneGeneratorDSP**: Tone generation using FMOD DSP oscillators

### FMODAudioProfiler

The `FMODAudioProfiler` class provides performance monitoring and level metering:

- CPU and memory usage tracking
- Channel count monitoring
- Real-time audio level metering
- Observer pattern for updates via listener interfaces

## Usage Examples

### Initializing FMOD

```xojo
// Initialize FMOD System
If Not FMODSystem.Instance.Initialize Then
  MessageBox("Failed to initialize FMOD system")
  Return
End If

// Don't forget to shutdown when done
FMODSystem.Instance.Shutdown
```

### Playing a Sound from a File

```xojo
// Create a sound from a file
var soundFile As String = GetFolderItem("sounds/mysound.wav").NativePath
var sound As FMODSound = FMODSound.CreateFromFile(soundFile)

If sound <> Nil Then
  // Get sound information
  var lengthMS As Integer = sound.GetLengthMS()
  
  // Play the sound
  var channel As FMODChannel = sound.Play
  
  If channel <> Nil Then
    // Control playback
    channel.SetVolume(0.8)
    channel.SetPan(0.0) // Center
  End If
End If
```

### Generating a Tone with DSP

```xojo
// Create a sine wave oscillator at 440 Hz (A4 note)
var oscillator As FMODToneGeneratorDSP = FMODToneGeneratorDSP.CreateOscillator(440.0, _
  FMODToneGeneratorDSP.OscillatorType.SINE)

If oscillator <> Nil Then
  // Play the oscillator
  var channel As FMODChannel = oscillator.Play
  
  If channel <> Nil Then
    // Change oscillator parameters in real-time
    oscillator.SetFrequency(523.25) // C5 note
    oscillator.SetOscillatorType(FMODToneGeneratorDSP.OscillatorType.SQUARE)
  End If
End If
```

### Using the Audio Profiler

```xojo
// Initialize the profiler
If Not FMODAudioProfiler.Instance.Initialize Then
  MessageBox("Failed to initialize audio profiler")
End If

// Set the collection interval (in milliseconds)
FMODAudioProfiler.Instance.SetCollectionInterval(500) // Update every 500ms

// Create a listener to receive profiler updates
var listener As New MyProfilerListener

// Add the listener to the profiler
FMODAudioProfiler.Instance.AddListener(listener)

// Later, when shutting down:
FMODAudioProfiler.Instance.Shutdown
```

### Using the Level Meter

```xojo
// Create a level meter listener class
Class MyLevelMeter
  Implements FMODAudioLevelMeterListener
  
  // Required by the base listener interface
  Sub OnProfilerUpdate(profiler As FMODAudioProfiler) Implements FMODAudioProfilerListener.OnProfilerUpdate
    // Process general profiler updates
  End Sub
  
  // Receive level updates
  Sub OnLevelUpdate(peakLevels() As Single, rmsLevels() As Single, numChannels As Integer) Implements FMODAudioLevelMeterListener.OnLevelUpdate
    // Process level data
    var peakDB As Single = FMODAudioProfiler.LevelToDecibels(peakLevels(0))
    
    // Update UI or perform actions based on levels
  End Sub
End Class

// Create and register a level meter listener
var levelMeter As New MyLevelMeter
FMODAudioProfiler.Instance.AddListener(levelMeter)
```

## Implementation Notes

### Using MBS Plugins

This framework uses the following MBS components:

- `DeclareLibraryMBS`: For dynamic loading of the FMOD library
- `DeclareFunctionMBS`: For dynamic function access
- `SoundFileMBS`: For working with audio files in various formats

The dynamic approach allows for better error handling and no conflicts with Xojo reserved words.

### Structure Handling

Structures are converted to/from memory blocks when passed to FMOD functions:

```xojo
// Convert a structure to a memory block
var infoMB As MemoryBlock = FMODStructures.ExInfoToMemoryBlock(info)

// Convert a memory block back to a structure
var info As FMODStructures.FMOD_CREATESOUNDEXINFO = FMODStructures.MemoryBlockToExInfo(infoMB)
```

### Error Handling

Errors are handled consistently throughout the framework:

```xojo
// Check for errors
If result <> FMODStructures.FMOD_RESULT_OK Then
  System.DebugLog("FMOD Error: " + FMODSystem.ResultToString(result))
  Return False
End If
```

## Performance Considerations

- For large audio files, consider streaming instead of loading the entire file
- When using multiple DSP effects, be mindful of CPU usage
- The level metering feature has minimal performance impact
- Set an appropriate update interval for the profiler to balance detail vs. performance


## Credits

- [FMOD Sound System](https://www.fmod.com/) by Firelight Technologies
- [MBS Xojo Plugins](https://www.monkeybreadsoftware.net/) by Monkeybread Software
- [Libsndfile](https://github.com/libsndfile/libsndfile), originally created by Eric de Castro Lopo

## Contributing

Contributions to improve the framework are welcome. Please submit pull requests with clear descriptions of the changes and their purpose.


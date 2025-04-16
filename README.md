<img src="res/FMODLogoBlack.png" width="240">

# FMOD Sound Subsystem for Xojo

> [!NOTE]
> This project is still work in progress, this comment will be removed when it works.


A comprehensive framework for integrating FMOD audio capabilities into Xojo applications, providing both file-based audio playback and DSP-based tone generation.

## Overview

This framework offers an object-oriented approach to working with FMOD in Xojo, simplifying audio playback and tone generation across multiple platforms. The framework supports:

- Loading and playing various audio file formats using SoundFileMBS from MBS Plugins
- Generating tones using FMOD's DSP oscillators
- Managing playback channels with volume, panning, and frequency control
- Cross-platform compatibility with proper error handling

## Requirements

- Xojo (tested with Xojo 2021r2.1 and later)
- FMOD Sound System (www.fmod.com)
- MBS Xojo Plugins (specifically the SoundFileMBS component)

## Structure

The framework consists of several key classes:

- **FMODSystem** - Singleton class that manages the FMOD system
- **FMODSound** - Base class for audio resources
- **FMODToneGeneratorSound** - Class for file-based audio playback using SoundFileMBS
- **FMODToneGeneratorDSP** - Class for DSP-based tone generation using oscillators
- **FMODChannel** - Class for managing playback channels
- **FMODException** - Exception class for FMOD-related errors
- **FMODAudioProfiler** - Performance and level monitoring class for FMOD
- **FMODAudioProfilerListener** - Interface for receiving profiler updates
- **FMODAudioLevelMeterListener** - Interface for receiving level meter updates
- **LevelMeterCanvas** - Canvas control for displaying real-time audio levels
-

## Installation

1. Add the FMOD library to your project:
   - macOS: `libfmod.dylib`
   - Windows: `fmod.dll` (32-bit) or `fmod64.dll` (64-bit)
   - Linux: `libfmod.so`

2. Ensure MBS Plugins are installed in your Xojo installation.

3. Add all the framework classes to your project.

## Usage

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
Dim soundFile As String = GetFolderItem("sounds/mysound.wav").NativePath
Dim sound As FMODToneGeneratorSound = FMODToneGeneratorSound.CreateFromFile(soundFile)

If sound <> Nil Then
  // Get sound information
  Dim channels As Integer = sound.GetChannels()
  Dim sampleRate As Integer = sound.GetSampleRate()
  Dim duration As Double = sound.GetDuration()
  
  // Play the sound
  Dim channel As FMODChannel = sound.Play
  
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
Dim oscillator As FMODToneGeneratorDSP = FMODToneGeneratorDSP.CreateOscillator(440.0, _
  FMODToneGeneratorDSP.OscillatorType.SINE)

If oscillator <> Nil Then
  // Play the oscillator
  Dim channel As FMODChannel = oscillator.Play
  
  If channel <> Nil Then
    // Change oscillator parameters in real-time
    oscillator.SetFrequency(523.25) // C5 note
    oscillator.SetOscillatorType(FMODToneGeneratorDSP.OscillatorType.SQUARE)
  End If
End If
```

### Playing Both File and DSP Sounds Together

```xojo
// Create both sound generators
Dim oscillator As FMODToneGeneratorDSP = FMODToneGeneratorDSP.CreateOscillator(330.0, _
  FMODToneGeneratorDSP.OscillatorType.TRIANGLE)
  
Dim fileSound As FMODToneGeneratorSound = FMODToneGeneratorSound.CreateFromFile(soundFile)

// Play both sounds
Dim oscChannel As FMODChannel = oscillator.Play
Dim fileChannel As FMODChannel = fileSound.Play

// Set volumes to create a blend
If oscChannel <> Nil Then
  oscChannel.SetVolume(0.5)
End If

If fileChannel <> Nil Then
  fileChannel.SetVolume(0.7)
End If
```

## Error Handling

The framework uses the `FMODException` class for error handling. You can catch these exceptions to handle errors gracefully:

```xojo
Try
  Dim sound As FMODToneGeneratorSound = FMODToneGeneratorSound.CreateFromFile(soundFile)
  Dim channel As FMODChannel = sound.Play
Catch ex As FMODException
  MessageBox("Error: " + ex.Message)
End Try
```

## SoundFileMBS Integration

The `FMODToneGeneratorSound` class uses SoundFileMBS from MBS Plugins to handle various audio formats. This provides several advantages:

- Support for multiple audio formats (WAV, AIFF, FLAC, OGG, etc.)
- Automatic handling of endianness differences across platforms
- Consistent interface regardless of audio format
- Better error handling and recovery

## DSP Oscillator Types

The `FMODToneGeneratorDSP` class supports the following oscillator types:

- **SINE** - Smooth sinusoidal waveform
- **SQUARE** - Sharp square waveform with harmonics
- **TRIANGLE** - Triangular waveform
- **SAWTOOTH** - Sawtooth waveform rich in harmonics
- **NOISE** - White noise

## Performance Considerations

- For large audio files, consider streaming instead of loading the entire file into memory
- When using multiple DSP effects, be mindful of CPU usage
- For time-critical applications, implement proper error handling to prevent audio glitches
- Use the FMODAudioProfiler to monitor performance metrics in real-time

## Using the Audio Profiler

The framework includes an audio profiler that helps you monitor FMOD performance metrics in real-time:

```xojo
// Initialize the profiler after FMOD system initialization
If Not FMODAudioProfiler.Instance.Initialize Then
  MessageBox("Failed to initialize audio profiler")
End If

// Set the collection interval (in milliseconds)
FMODAudioProfiler.Instance.SetCollectionInterval(500) // Update every 500ms

// Create a listener to receive profiler updates
Dim listener As New ExampleAudioProfilerListener(ProfilerTextArea)

// Add the listener to the profiler
FMODAudioProfiler.Instance.AddListener(listener)

// Later, when shutting down:
FMODAudioProfiler.Instance.Shutdown()
```

The profiler provides information about:
- CPU usage (DSP, streaming, geometry, update, total)
- Memory usage (current and maximum allocation)
- Channel count (total and currently playing)
- DSP buffer information

## Using the Level Meter

The framework includes a real-time audio level meter that displays the current output levels:

```xojo
// Add a LevelMeterCanvas to your window
Dim levelMeter As New LevelMeterCanvas
levelMeter.Width = 200
levelMeter.Height = 150
YourWindow.AddControl(levelMeter)

// The level meter will automatically register itself with the profiler
// and update in real-time once the profiler is initialized

// You can also create a custom level meter by implementing the interface:
Class MyCustomMeter Implements FMODAudioLevelMeterListener
  // Required by the base listener interface
  Sub OnProfilerUpdate(profiler As FMODAudioProfiler) Implements FMODAudioProfilerListener.OnProfilerUpdate
    // Process general profiler updates
  End Sub
  
  // Receive level updates
  Sub OnLevelUpdate(peakLevels() As Single, rmsLevels() As Single, numChannels As Integer) Implements FMODAudioLevelMeterListener.OnLevelUpdate
    // Process level data
    // peakLevels - Array of peak levels (0.0 to 1.0) for each channel
    // rmsLevels - Array of RMS levels (0.0 to 1.0) for each channel
    // numChannels - Number of audio channels
    
    // Convert level to decibels if needed
    Dim peakDB As Single = FMODAudioProfiler.LevelToDecibels(peakLevels(0))
  End Sub
End Class
```

The level meter provides:
- Real-time RMS and peak levels for all audio channels
- Visual representation with color-coded levels (green, yellow, red)
- Peak hold indicators
- dB scale display
- Smooth visual transitions

## License

This framework is provided under the MIT License.

## Credits

- [FMOD Sound System](https://www.fmod.com/) by Firelight Technologies
- [MBS Xojo Plugins](https://www.monkeybreadsoftware.net/) by Monkeybread Software
- [Libsndfile](https://github.com/libsndfile/libsndfile), originally created by Eric de Castro Lopo

## Contributing

Contributions to improve the framework are welcome. Please submit pull requests with clear descriptions of the changes and their purpose.


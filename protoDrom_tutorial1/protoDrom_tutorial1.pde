/**
 * protoDrom tutorial 1: quick start for libPd + Processing
 * by Shawn Greenlee
 *
 * for this example, you will need these libraries:
 * 1) libPd for Processing (puredataP5) - https://github.com/libpd/puredatap5 
 * 2) controlP5 - http://www.sojamo.de/libraries/controlP5/
 * consult documentation for these libaries for further info.  
 */

// OK, let's get started...

// first, import the libaries (these need to be installed in your libraries folder)

import org.puredata.processing.PureData;
import controlP5.*;

// then, declare variables for the libraries 

PureData pd; 
ControlP5 controlP5;

// and we'll also need to declare two floats: one for frequency, another for volume

float freq = 0.02;
float vol = 0.5;

// ok, now we are ready for the setup

void setup() {
  size(680, 400); 
  frameRate(25);
  pd = new PureData(this, 44100, 0, 2); // set sampling rate, input channels, & output channels
  pd.openPatch("drom_t1.pd"); // open the Pd patch contained in the data folder
  pd.start();  // get Pd ready
  controlP5 = new ControlP5(this); // get controlP5 ready

  // while we are here, let's change our colors for controlP5

  controlP5.setColorForeground(#ffffff);
  controlP5.setColorBackground(#999999);
  controlP5.setColorLabel(#ffffff);
  controlP5.setColorValue(#ffffff);
  controlP5.setColorActive(#ffffff);

  // and we must setup our sliders, one for the frequency and one for the volume

  Slider freq = controlP5.addSlider("freq", 0, 1, 0.02, 40, 50, 30, 200); // name, range-lo, range-hi, start-val, pos-X, pos-Y, width, height 
  freq.setSliderMode(Slider.FLEXIBLE); // this gives us a fader-like interface 

  Slider vol = controlP5.addSlider("vol", 0, 1, 0.5, 100, 50, 30, 200); // name, range-lo, range-hi, start-val, pos-X, pos-Y, width, height
  vol.setSliderMode(Slider.FLEXIBLE); // this gives us a fader-like interface
}

// OK, setup is done.  Now to draw and send these slider values to the Pd patch

void draw() {
  background(#77896C); // we need to set background color in the draw function, so that the sliders value draw correctly, comment out to see the difference
  pd.sendFloat("pd_freq", (float)freq); // send the freq value to a receive in Pd called "pd_freq"
  pd.sendFloat("pd_vol", (float)vol); // send the vol value to a receive in Pd called "pd_vol"
}

// that's it!
// if you've got a handle on this, you are ready for the next example which adds OSC functionality to this sketch


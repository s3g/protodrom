/**
 * protoDrom tutorial 2: adding OSC communication to drom tutoral 1
 * by Shawn Greenlee
 *
 * for this example, you will need these libraries:
 * 1) libPd for Processing (puredataP5) - https://github.com/libpd/puredatap5 
 * 2) controlP5 - http://www.sojamo.de/libraries/controlP5/
 * 3) oscP5 - http://www.sojamo.de/libraries/oscP5/
 * consult documentation for these libaries for further info.  
 */

// OK, let's get started...

// first, import the libaries (these need to be installed in your libraries folder)

import org.puredata.processing.PureData;
import controlP5.*;
import oscP5.*;
import netP5.*; // netP5 is included with the oscP5 library

// then, declare variables for the libraries 

PureData pd; 
ControlP5 controlP5;
OscP5 oscP5;

// and we'll also need to declare two floats: one for frequency, another for volume

float freq = 0.02;
float vol = 0.5;

// ok, now we are ready for the setup function

void setup() {
  size(680, 400); 
  frameRate(25);
  pd = new PureData(this, 44100, 0, 2); // set sampling rate, input channels, & output channels
  pd.openPatch("drom_t2.pd"); // open the Pd patch contained in the data folder
  pd.start();  // get Pd ready
  controlP5 = new ControlP5(this); // get controlP5 ready
  oscP5 = new OscP5(this, 8000); // get oscP5 ready and set the incoming port for communication (this is the connection point for a mobile app)

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

// OK, setup is done
// now to for the draw function which will send the slider values to the Pd patch

void draw() {
  background(#77896C); // we need to set background color in the draw function, so that the slider values draw correctly, comment out to see the difference
  pd.sendFloat("pd_freq", (float)freq); // send the freq value to a receive in Pd called "pd_freq"
  pd.sendFloat("pd_vol", (float)vol); // send the vol value to a receive in Pd called "pd_vol"
}


/**
 * now to set up OSC communication so that the sliders can be controlled remotely
 * you'll need an app capable of sending custom OSC messages, mobile apps like TouchOSC and TB Midi Stuff are good options
 * send your messages from your mobile app on outgoing port: 8000 (which we determined in the setup function)
 * be sure also to set the IP address for the host on your mobile app
 */


void oscEvent(OscMessage theOscMessage) {

  String addr = theOscMessage.addrPattern();
  float  val1  = theOscMessage.get(0).floatValue();

  if (addr.equals("/drom/freq")) {
    freq = val1;
  } // the Osc message you are sending must be formated as "/drom/freq" and will need to be a float in the range of 0-1
  controlP5.controller("freq").setValue(freq); // send the freq value to the freq slider

  if (addr.equals("/drom/vol")) {
    vol = val1;
  } // the Osc message you are sending must be formated as "/drom/vol" and will need to be a float in the range of 0-1
  controlP5.controller("vol").setValue(vol); // send the vol value to the vol slider
}

// now that you have the fundamentals down, try exporting an application
// and on to tutorial 3 where a DR-OM is born...


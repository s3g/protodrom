/**
 * protoDrom tutorial 3: fully functioning DR-OM prototype
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

// and we'll need to declare ten floats 

float osc1 = 0.16;
float lfo1 = 0.14;
float mix = 0.5;
float osc2 = 0.08;
float lfo2 = 0.1;
float speed = 0.1;
float depth = 0.22;
float freq = 0.85;
float res = 0.75;
float vol = 0.5;

// and a boolean so we have an on/off toggle

boolean power = false;


// ok, now we are ready for the setup function

void setup() {
  size(680, 400); 
  frameRate(25);
  pd = new PureData(this, 44100, 0, 2); // set sampling rate, input channels, & output channels
  pd.openPatch("drom_t3.pd"); // open the Pd patch contained in the data folder
  pd.start();  // get Pd ready
  controlP5 = new ControlP5(this); // get controlP5 ready
  oscP5 = new OscP5(this, 8000); // get oscP5 ready and set the incoming port for communication (this is the connection point for your mobile app)

  // while we are here, let's change our colors for controlP5

  controlP5.setColorForeground(#ffffff);
  controlP5.setColorBackground(#999999);
  controlP5.setColorLabel(#ffffff);
  controlP5.setColorValue(#ffffff);
  controlP5.setColorActive(#ffffff);

  // and we must setup our controls, ten sliders 

  Slider osc1 = controlP5.addSlider("osc1", 0, 1, 0.16, 40, 50, 30, 200); // name, range-lo, range-hi, start-val, pos-X, pos-Y, width, height 
  osc1.setSliderMode(Slider.FLEXIBLE);  // this gives us a fader-like interface

  Slider lfo1 = controlP5.addSlider("lfo1", 0, 1, 0.14, 100, 50, 30, 200);
  lfo1.setSliderMode(Slider.FLEXIBLE);

  Slider mix = controlP5.addSlider("mix", 0, 1, 0.5, 160, 50, 30, 200);
  mix.setSliderMode(Slider.FLEXIBLE);

  Slider osc2 = controlP5.addSlider("osc2", 0, 1, 0.08, 220, 50, 30, 200);
  osc2.setSliderMode(Slider.FLEXIBLE);

  Slider lfo2 = controlP5.addSlider("lfo2", 0, 1, 0.1, 280, 50, 30, 200);
  lfo2.setSliderMode(Slider.FLEXIBLE);

  Slider speed = controlP5.addSlider("speed", 0, 1, 0.1, 340, 50, 30, 200);
  speed.setSliderMode(Slider.FLEXIBLE);

  Slider depth = controlP5.addSlider("depth", 0, 1, 0.22, 400, 50, 30, 200);
  depth.setSliderMode(Slider.FLEXIBLE);

  Slider freq = controlP5.addSlider("freq", 0, 1, 0.85, 460, 50, 30, 200);
  freq.setSliderMode(Slider.FLEXIBLE);

  Slider res = controlP5.addSlider("res", 0, 1, 0.75, 520, 50, 30, 200);
  res.setSliderMode(Slider.FLEXIBLE);

  Slider vol = controlP5.addSlider("vol", 0, 1, 0.5, 580, 50, 30, 200);
  vol.setSliderMode(Slider.FLEXIBLE);

  // then, one toggle

  controlP5.addToggle("power", false, 40, 300, 40, 20).setMode(ControlP5.SWITCH);
}

// OK, setup is done
// now for the draw function which will send the slider values to the Pd patch

void draw() {
  background(#77896C); // we need to set background color in the draw function, so that the slider values draw correctly, comment out to see the difference
  pd.sendFloat("pd_osc1", (float)osc1); 
  pd.sendFloat("pd_lfo1", (float)vol); 
  pd.sendFloat("pd_mix", (float)mix); 
  pd.sendFloat("pd_osc2", (float)osc2); 
  pd.sendFloat("pd_lfo2", (float)lfo2); 
  pd.sendFloat("pd_speed", (float)speed); 
  pd.sendFloat("pd_depth", (float)depth); 
  pd.sendFloat("pd_freq", (float)freq); 
  pd.sendFloat("pd_res", (float)res); 
  pd.sendFloat("pd_vol", (float)vol); 

  // and get our boolean toggle sent to Pd
  if (power==true) {
    pd.sendFloat("pd_power", (0));
  } 
  else {
    pd.sendFloat("pd_power", (1));
  }
}


/**
 * now to set up OSC communication so that the sliders and toggle can be controlled remotely
 * you'll need an app capable of sending custom OSC messages, mobile apps like TouchOSC and TB Midi Stuff are good options
 * send your messages from your mobile app on outgoing port: 8000 (which we determined in the setup function)
 * don't forget to set the IP address for the host computer on your mobile app
 */


void oscEvent(OscMessage theOscMessage) {

  String addr = theOscMessage.addrPattern();
  float  val1  = theOscMessage.get(0).floatValue();

  if (addr.equals("/drom/osc1")) {
    osc1 = val1;
  } 
  controlP5.controller("osc1").setValue(osc1); 

  if (addr.equals("/drom/lfo1")) {
    lfo1 = val1;
  } 
  controlP5.controller("lfo1").setValue(lfo1); 

  if (addr.equals("/drom/mix")) {
    mix = val1;
  } 
  controlP5.controller("mix").setValue(mix); 

  if (addr.equals("/drom/osc2")) {
    osc2 = val1;
  } 
  controlP5.controller("osc2").setValue(osc2); 

  if (addr.equals("/drom/lfo2")) {
    lfo2 = val1;
  } 
  controlP5.controller("lfo2").setValue(lfo2); 

  if (addr.equals("/drom/speed")) {
    speed = val1;
  } 
  controlP5.controller("speed").setValue(speed); 

  if (addr.equals("/drom/depth")) {
    depth = val1;
  } 
  controlP5.controller("depth").setValue(depth); 

  if (addr.equals("/drom/freq")) {
    freq = val1;
  } 
  controlP5.controller("freq").setValue(freq); 

  if (addr.equals("/drom/res")) {
    res = val1;
  } 
  controlP5.controller("res").setValue(res); 

  if (addr.equals("/drom/vol")) {
    vol = val1;
  } 
  controlP5.controller("vol").setValue(vol);

// here's the way for handling the boolean toggle 

  if (addr.equals("/drom/power")) {
    if (val1 == 1) {
      power = false;
      controlP5.controller("power").setValue(0);
    }
    if (val1 == 0) {
      power = true;
      controlP5.controller("power").setValue(1);
    }
  }
}

// if this runs for you, export an application and give it a try


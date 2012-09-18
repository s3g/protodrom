protoDROM: prototyping with libPd and Processing
by Shawn Greenlee

Lately I've been using libPd and Processing to prototype audio apps for iOS on my laptop.  I recently did this in the development of Fluxama's DR-OM app, a collection of three mini-synthesizers or "drone ready oscillator modules."  Fluxama is utilizing libPd for the audio in our apps, and as we were getting close to finalizing the first release of DR-OM, I decided to speed things up on the sound design by making use of the recently updated (but still tentative) libPd for Processing (by Peter Brinkmann).  Combined with the Processing libraries controlP5 and oscP5 (by Andreas Schlegel) along with a mobile app that can send multitouch OSC messages (like TB Midi Stuff or TouchOSC), I have a solid prototyping platform that allows me to fine tune things at a quick pace.  

There is a great benefit beyond prototyping for mobile devices here.  The ability to make stand alone applications for laptops and desktops by combining Processing (for visuals) and Pure Data (for audio) is reason enough to continue reading especially if you like developing in a patcher-style audio programming environment.  

To share a bit of my process, I've uploaded some commented tutorial examples to GitHub that will get you going with the essentials for piecing together one of Fluxama's prototype DR-OMs (a protoDrom).  If you are new to Processing and Pure Data, there's plenty of resources online and in print (check out books from O'Reilly, especially Peter Brinkmann's "Making Musical Apps" and Casey Reas and Ben Fry's "Getting Started with Processing").    

Important to note is that as of this writing libPd for Processing is only available for Mac and Linux, and for good measure I'll let you know that I am running a Macbook Pro with the 10.8.1 OS (so if you're working on another OS, mileage may vary).  

OK, before grabbing the code examples, first you'll need a few things:  

1. Processing. I'm using Processing 2 Beta 3
http://processing.org/ 

2. Pure Data (a.k.a. Pd).  You'll want the "vanilla" version, not Pd-extended.  I am using Pure Data 0.43.2
http://puredata.info/downloads/pure-data

3. Processing Libraries (copy these to your "libraries" folder, see respective sites for installation instructions).
a.  libPd for Processing:  https://github.com/libpd/puredatap5  
b.  controlP5:  http://www.sojamo.de/libraries/controlP5/
c.  oscP5:  http://www.sojamo.de/libraries/oscP5/

4. An app on your mobile device capable of sending OSC messages. TouchOSC and TB Midi Stuff are popular options that will let you customize the OSC messages sent.  

Once you have everything installed, run some examples included with the Processing libraries to make sure everything is working properly.

And then check out the DR-OM tutorial code that I've uploaded to GitHub:
https://github.com/s3g/protodrom

Here's what you'll find:

* drom tutorial 1 - A Processing sketch that demonstrates the basics of sending messages to your Pd patch in conjunction with the controlP5 library
* drom tutorial 2 - A Processing sketch adding OSC communication to the first tutorial using oscP5
* drom tutorial 3 - A Processing sketch for one of the synths included in Fluxama's DR-OM app.  Export your own stand alone for best performance.
* a TB Midi Stuff template with the OSC controls all set up

protoDROM: Prototyping with libPd and Processing
by Shawn Greenlee

Lately I’ve been using libPd and Processing to prototype audio apps for iOS on my laptop. I recently did this in the development of Fluxama’s DR-OM app, a collection of three mini-synthesizers or “drone ready oscillator modules.” We’re using libPd for the audio in our apps.  http://libpd.cc

I decided to speed things up on the sound design by making use of the recently updated (but still beta) “libPd for Processing” by Peter Brinkmann. Combined with the Processing libraries controlP5 and oscP5, along with a mobile app that can send multitouch OSC messages (like TB Midi Stuff or TouchOSC), I have a solid prototyping platform that allows me to fine tune things at a quick pace.

There is a great benefit beyond just prototyping for mobile devices here. The ability to make standalone applications for laptops and desktops by combining Processing (for visuals) and Pure Data (for audio) is reason enough to try this out, especially if you like developing in a patcher-style audio programming environment. 

To share a bit of my process, I’ve uploaded some commented tutorial examples to GitHub that will get you going with the essentials for piecing together one of my prototype DR-OMs (a protoDROM).

If you are new to Processing and Pure Data, there’s plenty of resources online and in print. Check out books from O’Reilly, especially Peter Brinkmann’s "Making Musical Apps" and Casey Reas and Ben Fry’s "Getting Started with Processing."

Important to note is that as of this writing libPd for Processing is only available for Mac and Linux, and for good measure I’ll let you know that I am running a Macbook Pro with the 10.8.1 OS (so if you’re working on another OS, mileage may vary).

OK, before grabbing the code examples, first you’ll need a few things:

1) Processing. I’m using Processing 2 Beta 3. http://processing.org

2) Pure Data. You’ll want the “vanilla” version, not Pd-extended. I am using Pure Data 0.43.2. http://puredata.info/downloads/pure-data

3) Processing Libraries. Copy these to your libraries folder; see respective sites for installation instructions.

a) libPd for Processing: Unpack pdp5.zip into your Processing libraries folder. https://github.com/libpd/puredatap5

b) controlP5: For GUI elements. http://www.sojamo.de/libraries/controlP5/

c) oscP5: To integrate P5 and OSC. http://www.sojamo.de/libraries/oscP5/

You’ll also need an app on your mobile device capable of sending OSC messages. TouchOSC and TB Midi Stuff are popular options that will let you customize the OSC messages sent.

http://hexler.net/software/touchosc
http://www.thiburce.com/TBStuff/?page_id=664

Once you have everything installed, run some examples included with the Processing libraries to make sure everything is working properly.

And then check out the DR-OM tutorial code that I’ve uploaded to GitHub:
https://github.com/s3g/protodrom.

Here’s what you’ll find:

1) Drom tutorial 1: A Processing sketch that demonstrates the basics of sending messages to your Pd patch in conjunction with the controlP5 library.

2) Drom tutorial 2: A Processing sketch adding OSC communication to the first tutorial using oscP5.

3) Drom tutorial 3: A Processing sketch for one of the synths. Export your own standalone for best performance.

4) A TB Midi Stuff template with the OSC controls all set up.
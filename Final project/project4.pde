import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;

void setup()
{
  size(512, 200, P3D);
 
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
}
 
void draw()
{
  background(255);
  stroke(0);
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
    line(x1, 250 + out.right.get(i)*50, x2, 250 + out.right.get(i+1)*50);
    line(x1, 350 + out.right.get(i)*50, x2, 350 + out.right.get(i+1)*50);
    line(x1, 450 + out.right.get(i)*50, x2, 450 + out.right.get(i+1)*50);
    line(x1, 550 + out.right.get(i)*50, x2, 550 + out.right.get(i+1)*50);
    line(x1, 650 + out.right.get(i)*50, x2, 650 + out.right.get(i+1)*50);
    line(x1, 750 + out.right.get(i)*50, x2, 750 + out.right.get(i+1)*50);
    line(x1, 850 + out.right.get(i)*50, x2, 850 + out.right.get(i+1)*50);
    line(x1, 950 + out.right.get(i)*50, x2, 950 + out.right.get(i+1)*50);
    line(x1, 1050 + out.right.get(i)*50, x2, 1050 + out.right.get(i+1)*50);
    line(x1, 1150 + out.right.get(i)*50, x2, 1150 + out.right.get(i+1)*50);
    line(x1, 1250 + out.right.get(i)*50, x2, 1250 + out.right.get(i+1)*50);
  }
}
 
void keyPressed()
{
  SineWave mySine;
  MyNote newNote;

  float pitch = 0;
  switch(key) {
    case 'z': pitch = 262; break;
    case 's': pitch = 277; break;
    case 'x': pitch = 294; break;
    case 'd': pitch = 311; break;
    case 'c': pitch = 330; break;
    case 'v': pitch = 349; break;
    case 'g': pitch = 370; break;
    case 'b': pitch = 392; break;
    case 'h': pitch = 415; break;
    case 'n': pitch = 440; break;
    case 'j': pitch = 466; break;
    case 'm': pitch = 494; break;
    case ',': pitch = 523; break;
    case 'l': pitch = 554; break;
    case '.': pitch = 587; break;
    case ';': pitch = 622; break;
    case '/': pitch = 659; break;
  }
  
   if (pitch > 0) {
      newNote = new MyNote(pitch, 0.2);
   }
}

void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}

class MyNote implements AudioSignal
{
     private float freq;
     private float level;
     private float alph;
     private SineWave sine;
     
     MyNote(float pitch, float amplitude)
     {
         freq = pitch;
         level = amplitude;
         sine = new SineWave(freq, level, out.sampleRate());
         alph = 0.9;
         out.addSignal(this);
     }

     void updateLevel()
     {
         level = level * alph;
         sine.setAmp(level);
         
         if (level < 0.01) {
             out.removeSignal(this);
         }
     }
     
     void generate(float [] samp)
     {
         sine.generate(samp);
         updateLevel();
     }
     
    void generate(float [] sampL, float [] sampR)
    {
        sine.generate(sampL, sampR);
        updateLevel();
    }

}

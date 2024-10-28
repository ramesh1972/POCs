using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GodParticle
{
    class Program
    {
        interface IHuman
        {
            string Name { get; set; }
            void Say();
            void Say(String myWords);
        }

        public abstract class Human : IHuman
        {
            public string Name { get; set; }

            public Human(string myName)
            {
                Name = myName;
            }

            public virtual void Say()
            {
                throw new Exception("err..I've got nothing to say.");
            }

            public void Say(string myWords)
            {
                Console.WriteLine("{0}: \"{1}\"", Name, myWords);
                Console.WriteLine(Environment.NewLine);
            }
        }


        class FrustratedScientist : Human
        {
            public FrustratedScientist() : base("Frustrated Scientist") {}

            public override void Say()
            {
                Say("When will i find this God Damned Particle?");
            }
        }

        class WisdomScientist : Human
        {
            public WisdomScientist() : base("Wisdom Scientist") {}

            public override void Say()
            {
                Say("Enough of God bashing. Let's have some ethics");
                Say("If you are so desperate and feel eluded, then...");
                Say("Call it The God Particle");
            }
        }

        class PeterHiggs : Human
        {
            public PeterHiggs() : base("Peter Higgs") {}

            public override void Say()
            {
                Say("Something is missing in the Standard Model. I will call it Higgs Particle.");
            }
        }

        class SatyendraNathBose : Human
        {
            public SatyendraNathBose() : base("Satyendra Nath Bose") {}

            public override void Say()
            {
                Say("I was born on 1 January 1894 and died on 4 February 1974.");
                Say("I was an Indian physicist specializing in mathematical physics.");
                Say("I was best known for my work on quantum mechanics in the early 1920s,");
                Say("providing the foundation for Bose–Einstein statistics and the theory of the Bose–Einstein condensate.");
                Say("I am honoured as the namesake of the boson!!!");
            }
        }

        class Hitler666thBirth : Human
        {
            public Hitler666thBirth() : base("Hitler(666th Birth)") {}

            public override void Say()
            {
                Say("Now I will invent the Black Hole Bomb.");
                Say("I will put it in the LHC and flee to Mars.");
                Say("Then i will explode the bomb, remotely.");
                Say("All Jews, Christians, Muslims, Hindus, Persians...All will be sucked in by the black hole bomb...");
                Say("The Whole World will be sucked into by my bomb.");
                Say("I am God...ha ha ha *&%*!@*:-(");
            }
        }

        class CERNScientist : Human
        {
            public CERNScientist() : base("A CERN Scientist") {}

            public override void Say()
            {
                Say("The results at CERN we saw were \"five sigma\",");
                Say("Meaning there was just a 0.00006 percent chance that what the two laboratories found is a mathematical quirk");
            }

        }

        class RaviSharnkar : Human
        {
            public RaviSharnkar() : base("Ravi Sharnkar (GuruJi)") {}

            public override void Say()
            {
                Say("The Art of Particle Living.");
            }
        }

        class Nithyananda : Human
        {
            public Nithyananda() : base("Nithyananda") {}

            public override void Say()
            {
                Say("What God Particle??? I am God.");
                Say("...And i am party man, full of party stuff.");
            }
        }


        class MaitreyaTheGreatSage : Human
        {
            public MaitreyaTheGreatSage() : base("Maitreya(The Great Sage)") {}

            public override void Say()
            {
                Say("This is what the Bhâgavata Purâna Said a about 5000 years ago...");
                Say("The smallest particle of material substance, which has not yet combined with any other similar");
                Say("particles, is called PARAMANU (a sub-atomic particle of matter");
                Say("Paramanus always exist both in the dormant and manifest states of material existence.");
                Say("It is the combination of more than one paramanu (sub-atomic particle)");
                Say("which gives rise to the illusory concept of a (material) unit.");
 
            }
        }

        class Krishnakanth : Human
        {
            public Krishnakanth() : base("Krishnakanth") {}

            public override void Say()
            {
                Say("So now I am made of God Particles ultimately...?");
            }
        }

        class Ramesh : Human
        {
            public Ramesh() : base("Ramesh") {}

            public override void Say()
            {
                Say("You are a bit different...");
                Say("You are made of Ciqions...");
                Say("The Ciqian is one who is free to think creatively without boundaries, but SHOULD have a certain discipline that programming commands!...");
                Say("That's the Ciqion we inherit!!!");
                Say("That's enough.");
                Say("So What's next?");
                Say("The God Damned God Particle....00006%...huhhuhhuh");
                Say("Anyway its July 4th...all goof ups will be taken in the right spirit...let's make people Happy");
                Say("if wrong we will call it something else, maybe ...The Goofy Party?cle..");
            }
        }

        class Ciqian : Human
        {
            public Ciqian() : base("Ciqian") { }

            public override void Say()
            {
                Say("HAKUNA MATATA...the song goes like...");
                Say("..i Got no worries, cause i ain't in no hurry at all...");
                Say("..Built me a ramp and she is ready to go floating...");
            }
        }

        static void Main(string[] args)
        {
            // set the position
            Console.SetWindowSize(140, 40); 
            Console.SetBufferSize(150, 200);
            Console.SetWindowPosition(1, 1);

            // Each human is created, to say something...
            // frsutrated scientists all ove the wold kept saying...
            System.Threading.CancellationTokenSource cutHimOff = new System.Threading.CancellationTokenSource();
            System.Threading.CancellationToken cancelMe = cutHimOff.Token;
            new System.Threading.Tasks.Task(() =>
                {
                    FrustratedScientist leon = new FrustratedScientist();
                    while (!cancelMe.IsCancellationRequested)
                    {
                        leon.Say();
                        System.Threading.Thread.Sleep(100);
                    }
                }, cancelMe).Start();

            // wait for the mad scientist to ramble
            System.Threading.Thread.Sleep(300);

            // wise man once said
            // cut him off
            cutHimOff.Cancel();
            new WisdomScientist().Say();

            // the 2 cool guys said
            new PeterHiggs().Say();
            new SatyendraNathBose().Say();

            // others said
            new MaitreyaTheGreatSage().Say();
            new RaviSharnkar().Say();
            new Nithyananda().Say();

            // we said
            new Krishnakanth().Say();
            new Ramesh().Say();
            new Ciqian().Say();

            // pause
            Console.ReadKey();
        }
    }
}

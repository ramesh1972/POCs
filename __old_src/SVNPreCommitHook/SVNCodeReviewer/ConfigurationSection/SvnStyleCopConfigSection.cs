namespace SVNStyleCop
{
    using System.Configuration;

    public class SvnStyleCopConfigSection : ConfigurationSection
    {
        [ConfigurationProperty("tempFolder")]
        public string TempFolder
        {
            get
            {
                return (string)this["tempFolder"];
            }

            set
            {
                this["tempFolder"] = value;
            }
        }

        [ConfigurationProperty("svnLook", IsRequired = true)]
        public SvnLookElement SvnLook
        {
            get
            {
                return (SvnLookElement)this["svnLook"];
            }

            set
            {
                this["svnLook"] = value;
            }
        }

        [ConfigurationProperty("styleCop", IsRequired = true)]
        public StyleCopElement StyleCop
        {
            get
            {
                return (StyleCopElement)this["styleCop"];
            }

            set
            {
                this["styleCop"] = value;
            }
        }

        [ConfigurationProperty("pathPatterns", IsDefaultCollection = false)]
        public PathPatternElementCollection PathPatterns
        {
            get
            {
                return (PathPatternElementCollection)base["pathPatterns"];
            }
        }
    }
}

namespace SVNStyleCop
{
    using System.Configuration;
    using System.Text.RegularExpressions;

    public class PathPatternElement : ConfigurationElement
    {
        private Regex valueRegex;
        
        [ConfigurationProperty("value", DefaultValue = ".*", IsRequired = true)]
        [StringValidator(MinLength = 1, MaxLength = 600)]
        public string Value
        {
            get
            {
                return (string)this["value"];
            }

            set
            {
                this["value"] = value;
            }
        }

        [ConfigurationProperty("ignore", DefaultValue = false, IsRequired = false)]
        public bool Ignore
        {
            get
            {
                return (bool)this["ignore"];
            }

            set
            {
                this["ignore"] = value;
            }
        }

        public Regex ValueRegex
        {
            get
            {
                if (this.valueRegex == null)
                {
                    this.valueRegex = new Regex(this.Value);
                }
                
                return this.valueRegex;
            }
        }
    }
}

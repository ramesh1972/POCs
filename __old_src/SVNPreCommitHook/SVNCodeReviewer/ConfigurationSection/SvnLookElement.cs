namespace SVNStyleCop
{
    using System.Configuration;

    public class SvnLookElement : ConfigurationElement
    {
        [ConfigurationProperty("location", IsRequired = true)]
        public string Location
        {
            get
            {
                return (string)this["location"];
            }

            set
            {
                this["location"] = value;
            }
        }
    }
}

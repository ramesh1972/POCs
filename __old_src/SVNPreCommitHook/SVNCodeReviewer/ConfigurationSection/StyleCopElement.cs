namespace SVNStyleCop
{
    using System.Configuration;

    public class StyleCopElement : ConfigurationElement
    {
        [ConfigurationProperty("settingsFile", IsRequired = true)]
        public string SettingsFile
        {
            get
            {
                return (string)this["settingsFile"];
            }

            set
            {
                this["settingsFile"] = value;
            }
        }

        [ConfigurationProperty("maxViolationCount", IsRequired = true)]
        public int MaxViolationCount
        {
            get
            {
                return (int)this["maxViolationCount"];
            }

            set
            {
                this["maxViolationCount"] = value;
            }
        }
    }
}

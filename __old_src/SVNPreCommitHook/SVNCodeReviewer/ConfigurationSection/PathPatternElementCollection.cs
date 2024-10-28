namespace SVNStyleCop
{
    using System.Configuration;

    public class PathPatternElementCollection : ConfigurationElementCollection
    {
        public PathPatternElement this[int index]
        {
            get
            {
                return (PathPatternElement)this.BaseGet(index);
            }

            set
            {
                if (this.BaseGet(index) != null)
                {
                    this.BaseRemoveAt(index);
                }

                this.BaseAdd(index, value);
            }
        }

        protected override ConfigurationElement CreateNewElement()
        {
            return new PathPatternElement();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((PathPatternElement)element).Value;
        }
    }
}
